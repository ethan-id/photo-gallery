CREATE DATABASE photo_gallery;
USE photo_gallery;

CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(255) UNIQUE,
  password VARCHAR(255)
);

CREATE TABLE photos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  filename VARCHAR(255),
  FOREIGN KEY (user_id) REFERENCES users(id)
);
