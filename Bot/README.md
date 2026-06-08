# Discord Bot

This module containts the bot that lets you manage the Minecraft server from Discord using slash commands. It can start, stop, and check the server status. Commands are registered with `register_commands.py` and the logic runs as `lambda_function.py`.

# Lambda Function

| Functionality | Description |
|--------|-------------|
| Signature Verification | Verifies that incoming requests originated from discord |
| Authorization | Restricts command usage to a discord role(s) |
| EC2 Control | Starts, stops, and checks the status of the EC2 instance |
| Automatic Shutdown | Handles CloudWatch alarm notification and stop the instance when it becomes idle |

### Environment Variables

| Variable | Description |
|--------|-------------|
| `DISCORD_PUBLIC_KEY` | Discord public key used to verify requests |
| `INSTANCE_ID` | ID of the instance controlled by the bot |
| `ALLOWED_ROLE_IDS` | Discord role IDs allowed to execute commands |

# Commands

| Command | Description |
|--------|-------------|
| `/start-server` | Starts the EC2 instance |
| `/stop-server` | Stops the EC2 instance |
| `/server-status` | Displays the current EC2 instance status |

# Command Registration

Before registering commands, create a `.env` file containing:

TOKEN=your_bot_token

APP_ID=your_application_id

GUILD_ID=your_guild_id