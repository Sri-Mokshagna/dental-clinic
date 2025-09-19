#!/bin/bash
echo "Starting ngrok tunnel for Twilio webhooks..."
echo ""
echo "Make sure you have:"
echo "1. Installed ngrok from https://ngrok.com/download"
echo "2. Created a free ngrok account"
echo "3. Added your authtoken: ngrok config add-authtoken YOUR_TOKEN"
echo ""
echo "Starting tunnel on port 8080..."
echo "Your public URL will be shown below:"
echo ""
ngrok http 8080
