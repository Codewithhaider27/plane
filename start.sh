#!/bin/bash

echo "🚀 Starting Plane Project Management Tool..."

# Make script executable
chmod +x start.sh

# Start all services
echo "🐳 Building and starting Docker containers..."
docker-compose up --build

echo "✅ Plane is starting up!"
echo "🌐 Check the Ports panel in VS Code for access URLs"
echo "📱 Main app will be available on port 80 and 3000"
