# Twilio Webhook Setup Guide

## Option 1: ngrok (Easiest for Development)

### Step 1: Install ngrok
```bash
# Download from https://ngrok.com/download
# Or install via package manager:
# Windows (Chocolatey): choco install ngrok
# Mac (Homebrew): brew install ngrok
# Linux: wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.zip
```

### Step 2: Create ngrok account
1. Go to https://ngrok.com/
2. Sign up for free account
3. Get your authtoken from https://dashboard.ngrok.com/get-started/your-authtoken

### Step 3: Configure ngrok
```bash
# Add your authtoken
ngrok config add-authtoken YOUR_AUTHTOKEN_HERE

# Start ngrok tunnel (replace 8080 with your Spring Boot port)
ngrok http 8080
```

### Step 4: Get your public URL
ngrok will show you something like:
```
Forwarding  https://abc123.ngrok.io -> http://localhost:8080
```

### Step 5: Update Twilio Webhooks
1. Go to https://console.twilio.com/us1/develop/phone-numbers/manage/incoming
2. Click on your phone number
3. Set webhook URL to: `https://abc123.ngrok.io/api/patient-otp/webhook`
4. Set HTTP method to POST
5. Save configuration

## Option 2: Railway (Free Cloud Hosting)

### Step 1: Prepare for Railway deployment
1. Create account at https://railway.app/
2. Connect your GitHub repository
3. Railway will automatically detect Spring Boot

### Step 2: Environment Variables
Set these in Railway dashboard:
```
SPRING_PROFILES_ACTIVE=prod
TWILIO_ACCOUNT_SID=your_sid
TWILIO_AUTH_TOKEN=your_token
TWILIO_PHONE_NUMBER=your_number
```

### Step 3: Deploy
Railway will give you a URL like: `https://your-app.railway.app`

### Step 4: Update Twilio Webhooks
Set webhook URL to: `https://your-app.railway.app/api/patient-otp/webhook`

## Option 3: Heroku (Free Tier Available)

### Step 1: Create Heroku app
```bash
# Install Heroku CLI
# Login to Heroku
heroku login

# Create app
heroku create your-clinic-app-name

# Add Java buildpack
heroku buildpacks:set heroku/java
```

### Step 2: Configure environment variables
```bash
heroku config:set TWILIO_ACCOUNT_SID=your_sid
heroku config:set TWILIO_AUTH_TOKEN=your_token
heroku config:set TWILIO_PHONE_NUMBER=your_number
```

### Step 3: Deploy
```bash
git add .
git commit -m "Deploy to Heroku"
git push heroku main
```

### Step 4: Update Twilio Webhooks
Set webhook URL to: `https://your-clinic-app-name.herokuapp.com/api/patient-otp/webhook`

## Option 4: AWS EC2 (Most Permanent)

### Step 1: Launch EC2 instance
1. Go to AWS Console
2. Launch EC2 instance (t2.micro for free tier)
3. Configure security group to allow HTTP (80) and HTTPS (443)

### Step 2: Install Java and deploy
```bash
# Connect to EC2 instance
ssh -i your-key.pem ec2-user@your-ec2-ip

# Install Java
sudo yum update -y
sudo yum install java-11-openjdk -y

# Deploy your application
# (Upload JAR file or clone repository)
```

### Step 3: Configure domain (optional)
- Use Route 53 to create a custom domain
- Point domain to your EC2 instance

## Recommended Approach

For **development/testing**: Use **ngrok**
For **production**: Use **Railway** or **Heroku**

## Webhook Endpoints to Create

You'll need these endpoints in your Spring Boot app:

1. **SMS Status Callback**: `/api/patient-otp/sms-status`
2. **WhatsApp Status Callback**: `/api/patient-otp/whatsapp-status`
3. **Incoming Messages**: `/api/patient-otp/incoming-message`
