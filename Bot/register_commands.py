import os
import requests
from dotenv import load_dotenv

load_dotenv()

TOKEN = os.getenv("TOKEN", "").strip()
APP_ID = os.getenv("APP_ID", "").strip()
GUILD_ID = os.getenv("GUILD_ID", "").strip()

if not TOKEN or not APP_ID or not GUILD_ID:
    raise SystemExit("Missing env vars")

COMMANDS = [
    {"name": "start-server", "description": "Start the Minecraft server", "type": 1},
    {"name": "stop-server", "description": "Stop the Minecraft server", "type": 1},
    {"name": "server-status", "description": "Check server status", "type": 1},
]


url = f"https://discord.com/api/v10/applications/{APP_ID}/guilds/{GUILD_ID}/commands"

headers = {
    "Authorization": f"Bot {TOKEN}",
    "Content-Type": "application/json",
}

response = requests.put(url, json=COMMANDS, headers=headers, timeout=10)

if response.status_code != 200:
    print(f"Error: {response.status_code}")
    print(response.json())
else:
    print("Commands registered successfully!")