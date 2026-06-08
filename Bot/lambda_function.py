import json
import os
import boto3
from nacl.signing import VerifyKey
from nacl.exceptions import BadSignatureError

PUBLIC_KEY = os.environ["DISCORD_PUBLIC_KEY"]
INSTANCE_ID = os.environ["INSTANCE_ID"]
ALLOWED_ROLE_IDS = [r.strip() for r in os.environ["ALLOWED_ROLE_IDS"].split(",") if r.strip()]

ec2 = boto3.client("ec2")

#formats response for discord interaction
def respond(payload):
    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps(payload)
    }

#verifies incoming request is from discord by checking signature
def verify_signature(event):
    body = event.get("body", "")
    headers = event.get("headers", {})

    signature = headers.get("x-signature-ed25519") or headers.get("X-Signature-Ed25519")
    timestamp = headers.get("x-signature-timestamp") or headers.get("X-Signature-Timestamp")

    verify_key = VerifyKey(bytes.fromhex(PUBLIC_KEY))
    verify_key.verify(f"{timestamp}{body}".encode(), bytes.fromhex(signature))

#gets current state of ec2 instance
def get_instance_state():
    res = ec2.describe_instances(InstanceIds=[INSTANCE_ID])
    return res["Reservations"][0]["Instances"][0]["State"]["Name"]

#handles start/stop/status actions for ec2 instance
def handle_action(action):
    state = get_instance_state()

    if state in ["pending", "stopping", "shutting-down"]:
        return f"Server is currently {state}."

    if action == "start":
        if state == "running":
            return "Server is already running."
        ec2.start_instances(InstanceIds=[INSTANCE_ID])
        return "Starting server..."

    if action == "stop":
        if state == "stopped":
            return "Server is already stopped."
        ec2.stop_instances(InstanceIds=[INSTANCE_ID])
        return "Stopping server..."

    if action == "status":
        return f"Server is {state}"

    return "Unknown action"

#main lambda handler for discord interaction and cloudwatch alarm
def lambda_handler(event, context):
      #handles sns event from cloudwatch alarm
    if "Records" in event and event["Records"][0].get("EventSource") == "aws:sns":
        try:
            message = event["Records"][0]["Sns"]["Message"]
            print(f"CloudWatch alarm triggered: {message}")
            ec2.stop_instances(InstanceIds=[INSTANCE_ID])
            return {"statusCode": 200, "body": "Instance stopped by CloudWatch alarm"}
        except Exception as e:
            print(f"Error stopping instance from CloudWatch: {e}")
            return {"statusCode": 500, "body": str(e)}

    #handles discord interaction
    try:
        verify_signature(event)
    except BadSignatureError:
        return {"statusCode": 401, "body": "Invalid signature"}

    body = json.loads(event.get("body", "{}"))

    if body.get("type") == 1:
        return respond({"type": 1})

    if body.get("type") == 2:
        command = body.get("data", {}).get("name")
        member_roles = body.get("member", {}).get("roles", [])

        if not any(r in ALLOWED_ROLE_IDS for r in member_roles):
            return respond({
                "type": 4,
                "data": {"content": "No permission."}
            })

        command_map = {
            "start-server": "start",
            "stop-server": "stop",
            "server-status": "status",
        }

        action = command_map.get(command)

        message = handle_action(action) if action else "Unknown command"

        return respond({
            "type": 4,
            "data": {"content": message}
        })