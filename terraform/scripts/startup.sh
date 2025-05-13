#!/bin/bash

# Install system dependencies
apt update
apt install -y curl git nodejs npm

# Clone your app (or replace with `gsutil cp` if using GCS upload)
cd /opt
git clone https://github.com/your-username/photo-gallery.git
cd photo-gallery

# Install dependencies
npm install

# Write DB config (injected by Terraform later)
cat > .env <<EOF
DB_HOST=127.0.0.1
DB_USER=root
DB_PW=REPLACE_ME
DB_NAME=photo_gallery
EOF

# Start the app in the background
nohup node app.js > /var/log/app.log 2>&1 &
