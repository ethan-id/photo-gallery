#!/bin/bash

set -e

# Install required packages
apt update
apt install -y curl git gnupg default-mysql-client

# Install Node.js 18
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt install -y nodejs

# Clone the app
cd /opt
git clone https://github.com/ethan-id/photo-gallery.git
cd photo-gallery

# Fix permissions so app can write to uploads/
chown -R root:root /opt/photo-gallery

# Install Node dependencies
npm install

# Create .env config
cat > .env <<EOF
DB_HOST=10.69.0.3
DB_USER=appuser
DB_PW=ethanpassword
DB_NAME=photo_gallery
EOF

# Add keep-alive line to prevent Express from exiting
sed -i '1i\setInterval(() => {}, 1000);' app.js

# Initialize DB schema
cat > init.sql <<EOF
CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS photos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  filename VARCHAR(255) NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
EOF

mysql -h 10.69.0.3 -u appuser -pethanpassword photo_gallery < init.sql

# Start the app
export PORT=80
nohup node app.js > /home/app.log 2>&1 &

