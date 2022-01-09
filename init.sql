CREATE DATABASE IF NOT EXISTS wordpress;
GRANT ALL ON *.* TO 'wordpress'@'localhost';
SET PASSWORD FOR 'wordpress'@'localhost' = PASSWORD('wordpress');
FLUSH PRIVILEGES;