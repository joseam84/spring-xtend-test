INSERT INTO users (username, password, enabled) VALUES ('su', 'gw', '1');
INSERT INTO users (username, password, enabled) VALUES ('afontanet', 'gw', '1');
INSERT INTO users (username, password, enabled) VALUES ('jomatos', 'gw', '1');
INSERT INTO users (username, password, enabled) VALUES ('jpierre', 'gw', '1');
INSERT INTO users (username, password, enabled) VALUES ('jsergey', 'gw', '1');
INSERT INTO users (username, password, enabled) VALUES ('gcarlo', 'gw', '1');
INSERT INTO users (username, password, enabled) VALUES ('ec12', 'gw', '1');

INSERT INTO authorities (authority, user_username) VALUES ('ROLE_ADMIN', 'su');
INSERT INTO authorities (authority, user_username) VALUES ('ROLE_API', 'su');
INSERT INTO authorities (authority, user_username) VALUES ('ROLE_USER', 'su');
INSERT INTO authorities (authority, user_username) VALUES ('ROLE_USER', 'afontanet');

INSERT INTO address (address_line1, address_line2, city, country, state, zip_code) 
    VALUES ('123 Main', 'PO Box. 1234', 'Caguas', 'USA', 'PR', '00727');
INSERT INTO address (address_line1, address_line2, city, country, state, zip_code) 
    VALUES ('345 E Main', 'PO Box. 5675', 'Gurabo','USA', 'PR', '00728');
INSERT INTO address (address_line1, address_line2, city, country, state, zip_code) VALUES ('678 Main', 'PO Box. 6789', 'San Juan','USA', 'PR', '00936');

INSERT INTO person (first_name, last_name, email, address_id,  person_type, user_id) 
    VALUES ('Jean','Pierre','jp@mail.com','1', 'employee', 'jpierre');
INSERT INTO employee (employee_number, id) VALUES ('12345', '1');
INSERT INTO person (first_name, last_name, email, address_id,  person_type, user_id) 
    VALUES ('Jun','Sergey','js@mail.com','1', 'employee', 'jsergey');
INSERT INTO employee (employee_number, id) VALUES ('34563', '2');
INSERT INTO person (first_name, last_name, email, address_id,  person_type, user_id)  
    VALUES ('Elix','C12','ec@mail.com','3', 'person', 'ec12');
INSERT INTO person (first_name, last_name, email, address_id,  person_type, user_id)  
    VALUES ('Gian','Carlo','gc@mail.com','2', 'employee', 'gcarlo');
INSERT INTO employee (employee_number, id) VALUES ('567856', '3');
