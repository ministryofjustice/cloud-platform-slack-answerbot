# Answer BOT for Slack channels
## Introduction
This is a simple ruby slack bot to which will looks for keywords in a slack channel and respond. The keywords and response message is predefined within the script. 

## Setup
* This app can be deployed in the Cloud Platform kubernetes cluster. Use `kubectl_deploy` folder for deployment manifest.
* You'll need to add it in slack (you will need suitable permissions for this):
  * Create a Slack app
  * Create a bot user
  * Install the bot user to your workspace, invite the bot to the channel you want to listen in and get the bot token

## Configuration
Set the bot token as `SLACK_API_TOKEN` and pass it as environment variable
This one uses kubernetes secret to set the enviroment variable and used it in the deployment manifest.

## Development
See the makefile for details of how to run the bot code locally, during development.

## Usage
Update the `lib/bot.rb => keyword_list` to update the keywords you want to match and the response respectively.

