@echo off
echo ========================================
echo    Twilio Webhook Setup Script
echo ========================================
echo.

echo Choose your deployment option:
echo 1. ngrok (Development - Free)
echo 2. Railway (Production - Free tier)
echo 3. Heroku (Production - Free tier)
echo 4. Manual setup instructions
echo.

set /p choice="Enter your choice (1-4): "

if "%choice%"=="1" goto ngrok
if "%choice%"=="2" goto railway
if "%choice%"=="3" goto heroku
if "%choice%"=="4" goto manual
goto invalid

:ngrok
echo.
echo ========================================
echo    Setting up ngrok for Development
echo ========================================
echo.
echo Step 1: Download ngrok from https://ngrok.com/download
echo Step 2: Create free account at https://ngrok.com/
echo Step 3: Get your authtoken from https://dashboard.ngrok.com/get-started/your-authtoken
echo Step 4: Run: ngrok config add-authtoken YOUR_AUTHTOKEN
echo Step 5: Run: ngrok http 8080
echo.
echo Your webhook URLs will be:
echo - SMS Status: https://YOUR_NGROK_URL.ngrok.io/api/patient-otp/sms-status
echo - WhatsApp Status: https://YOUR_NGROK_URL.ngrok.io/api/patient-otp/whatsapp-status
echo - Incoming Messages: https://YOUR_NGROK_URL.ngrok.io/api/patient-otp/incoming-message
echo.
goto end

:railway
echo.
echo ========================================
echo    Setting up Railway for Production
echo ========================================
echo.
echo Step 1: Go to https://railway.app/
echo Step 2: Sign up with GitHub
echo Step 3: Connect your repository
echo Step 4: Set environment variables:
echo    - TWILIO_ACCOUNT_SID=your_sid
echo    - TWILIO_AUTH_TOKEN=your_token
echo    - TWILIO_PHONE_NUMBER=your_number
echo    - TWILIO_WHATSAPP_FROM=Whatsapp:your_number
echo.
echo Step 5: Deploy and get your URL
echo Step 6: Update Twilio webhooks with your Railway URL
echo.
goto end

:heroku
echo.
echo ========================================
echo    Setting up Heroku for Production
echo ========================================
echo.
echo Step 1: Install Heroku CLI from https://devcenter.heroku.com/articles/heroku-cli
echo Step 2: Run: heroku login
echo Step 3: Run: heroku create your-clinic-app-name
echo Step 4: Set environment variables:
echo    - heroku config:set TWILIO_ACCOUNT_SID=your_sid
echo    - heroku config:set TWILIO_AUTH_TOKEN=your_token
echo    - heroku config:set TWILIO_PHONE_NUMBER=your_number
echo.
echo Step 5: Deploy: git push heroku main
echo Step 6: Update Twilio webhooks with your Heroku URL
echo.
goto end

:manual
echo.
echo ========================================
echo    Manual Setup Instructions
echo ========================================
echo.
echo 1. Choose a cloud provider (Railway, Heroku, AWS, etc.)
echo 2. Deploy your Spring Boot application
echo 3. Get your public URL
echo 4. Update Twilio webhooks:
echo    - Go to https://console.twilio.com/us1/develop/phone-numbers/manage/incoming
echo    - Click on your phone number
echo    - Set webhook URLs:
echo      * SMS Status: https://YOUR_URL/api/patient-otp/sms-status
echo      * WhatsApp Status: https://YOUR_URL/api/patient-otp/whatsapp-status
echo      * Incoming Messages: https://YOUR_URL/api/patient-otp/incoming-message
echo.
goto end

:invalid
echo Invalid choice. Please run the script again.
goto end

:end
echo.
echo ========================================
echo    Webhook Endpoints Created
echo ========================================
echo.
echo Your Spring Boot app now has these webhook endpoints:
echo - POST /api/patient-otp/sms-status
echo - POST /api/patient-otp/whatsapp-status
echo - POST /api/patient-otp/incoming-message
echo - GET  /api/patient-otp/webhook-health
echo.
echo Test your webhooks with:
echo curl https://YOUR_URL/api/patient-otp/webhook-health
echo.
pause
