FLUSH PRIVILEGES;
UNINSTALL COMPONENT 'file://component_validate_password';
ALTER USER 'root'@'localhost' IDENTIFIED  BY 'wordpress';
CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER IF NOT EXISTS wordpress@localhost IDENTIFIED BY 'wordpress';
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER ON wordpress.* TO wordpress@localhost;
FLUSH PRIVILEGES;