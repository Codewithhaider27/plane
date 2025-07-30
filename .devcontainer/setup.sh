#!/bin/bash

echo "🚀 Setting up Plane development environment..."

# Make sure we're in the right directory
cd /workspaces/plane

# Copy environment files
echo "📝 Setting up environment files..."
cp .env.example .env
cp .env.example apps/api/.env
cp .env.example apps/web/.env
cp .env.example apps/space/.env
cp .env.example apps/admin/.env
cp .env.example apps/live/.env

# Update environment variables for Codespaces
echo "🔧 Configuring environment for Codespaces..."
cat > .env << EOF
# Database Settings
POSTGRES_USER="plane"
POSTGRES_PASSWORD="plane"
POSTGRES_DB="plane"
PGDATA="/var/lib/postgresql/data"

# Redis Settings
REDIS_HOST="plane-redis"
REDIS_PORT="6379"

# RabbitMQ Settings
RABBITMQ_HOST="plane-mq"
RABBITMQ_PORT="5672"
RABBITMQ_USER="plane"
RABBITMQ_PASSWORD="plane"
RABBITMQ_VHOST="plane"

# Web Settings
WEB_URL="https://\${CODESPACE_NAME}-80.\${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"
CORS_ALLOWED_ORIGINS="https://\${CODESPACE_NAME}-80.\${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN},https://\${CODESPACE_NAME}-3000.\${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"

# Ports
LISTEN_HTTP_PORT=80
LISTEN_HTTPS_PORT=443

# AWS/Minio Settings
AWS_REGION=""
AWS_ACCESS_KEY_ID="minioadmin"
AWS_SECRET_ACCESS_KEY="minioadmin"
AWS_S3_ENDPOINT_URL="http://plane-minio:9000"
AWS_S3_BUCKET_NAME="uploads"
FILE_SIZE_LIMIT=5242880

# Other Settings
USE_MINIO=1
SECRET_KEY="codespace-plane-secret-key-$(date +%s)"
API_KEY_RATE_LIMIT="60/minute"
EOF

# Copy the main .env to app directories
cp .env apps/api/.env
cp .env apps/web/.env
cp .env apps/space/.env
cp .env apps/admin/.env
cp .env apps/live/.env

# Install dependencies
echo "📦 Installing dependencies..."
npm install -g yarn
yarn install

# Make sure Docker is running
echo "🐳 Starting Docker..."
sudo service docker start

echo "✅ Setup complete! Ready to start Plane."
echo "🎯 Run 'docker-compose up --build' to start all services."
echo "🌐 Access Plane at the forwarded port URLs in the Ports panel."
EOF
