#!/bin/bash

# Install Node.js 18 from NodeSource
apt update
apt install -y curl git

curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt install -y nodejs npm

# Clone your app
cd /opt
git clone https://github.com/ethan-id/photo-gallery.git
cd photo-gallery

# Install dependencies
npm install

# Write fake env vars if needed
cat > .env <<EOF
DB_HOST=127.0.0.1
DB_USER=root
DB_PW=REPLACE_ME
DB_NAME=photo_gallery
EOF

# Start app on port 80 and keep it alive
export PORT=80
nohup node app.js > /home/app.log 2>&1 &

