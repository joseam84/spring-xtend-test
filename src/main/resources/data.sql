INSERT INTO users (username, password, enabled) VALUES ('su', 'gw', '1');
INSERT INTO users (username, password, enabled) VALUES ('afontanet', 'gw', '1');
INSERT INTO users (username, password, enabled) VALUES ('jomatos', 'gw', '1');

INSERT INTO authorities (authority, user_username) VALUES ('ROLE_ADMIN', 'su');
INSERT INTO authorities (authority, user_username) VALUES ('ROLE_API', 'su');
INSERT INTO authorities (authority, user_username) VALUES ('ROLE_USER', 'su');
INSERT INTO authorities (authority, user_username) VALUES ('ROLE_USER', 'afontanet');