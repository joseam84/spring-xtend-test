--Users
INSERT INTO users (username, password, enabled) VALUES ('su', 'gw', '1');
INSERT INTO users (username, password, enabled) VALUES ('afontanet', 'gw', '1');
INSERT INTO users (username, password, enabled) VALUES ('jomatos', 'gw', '1');
INSERT INTO users (username, password, enabled) VALUES ('jpierre', 'gw', '1');
INSERT INTO users (username, password, enabled) VALUES ('jsergey', 'gw', '1');
INSERT INTO users (username, password, enabled) VALUES ('gcarlo', 'gw', '1');
INSERT INTO users (username, password, enabled) VALUES ('ec12', 'gw', '1');
--Authorities
INSERT INTO authorities (authority, user_username) VALUES ('ROLE_ADMIN', 'su');
INSERT INTO authorities (authority, user_username) VALUES ('ROLE_API', 'su');
INSERT INTO authorities (authority, user_username) VALUES ('ROLE_USER', 'su');
INSERT INTO authorities (authority, user_username) VALUES ('ROLE_USER', 'afontanet');
--Addresses
INSERT INTO address (address_line1, address_line2, city, country, state, zip_code) 
    VALUES ('123 Main', 'PO Box. 1234', 'Caguas', 'USA', 'PR', '00727');
INSERT INTO address (address_line1, address_line2, city, country, state, zip_code) 
    VALUES ('345 E Main', 'PO Box. 5675', 'Gurabo','USA', 'PR', '00728');
INSERT INTO address (address_line1, address_line2, city, country, state, zip_code) VALUES ('678 Main', 'PO Box. 6789', 'San Juan','USA', 'PR', '00936');
-- Employees
INSERT INTO person (first_name, last_name, email, address_id,  person_type, user_id) 
    VALUES ('Jean','Pierre','jp@mail.com','1', 'employee', 'jpierre');
INSERT INTO employee (employee_number, id) VALUES ('12345', '1');
INSERT INTO person (first_name, last_name, email, address_id,  person_type, user_id) 
    VALUES ('Jun','Sergey','js@mail.com','1', 'employee', 'jsergey');
INSERT INTO employee (employee_number, id, manager_id) VALUES ('34563', '2', '1');
INSERT INTO person (first_name, last_name, email, address_id,  person_type, user_id)  
    VALUES ('Gian','Carlo','gc@mail.com','2', 'employee', 'gcarlo');
INSERT INTO employee (employee_number, id, manager_id) VALUES ('567856', '3', '1');
--Persons
INSERT INTO person (first_name, last_name, email, address_id,  person_type, user_id)  
    VALUES ('Elix','C12','ec@mail.com','3', 'person', 'ec12');
--Topics & topics group
INSERT INTO topicgroup (name, description, creator_id) VALUES ('Configuration Team', 'The topics for the configuration team', '1');
INSERT INTO topic (name, description, group_id) VALUES ('Configuration', 'All configuration work','1');
INSERT INTO topic (name, description, group_id) VALUES ('Meetings', 'All meetings','1');
INSERT INTO topic (name, description, group_id) VALUES ('Support', 'Support to other co workers','1');
INSERT INTO topic (name, description, group_id) VALUES ('Time lost', 'Hours wasted by looking at your phone','1');
--Tasks
INSERT INTO task(version, content, employee_id, topic_id) VALUES ('1', 'Time lost','3', '1');
INSERT INTO task(version, content, employee_id, topic_id) VALUES ('1', 'Singing songs','3', '1');
INSERT INTO task(version, content, employee_id, topic_id) VALUES ('1', 'Wasting life','3', '1');
INSERT INTO task(version, content, employee_id, topic_id) VALUES ('1', 'Playing Cards','3', '2');
INSERT INTO task(version, content, employee_id, topic_id) VALUES ('1', 'Twister','3', '2');
INSERT INTO task(version, content, employee_id, topic_id) VALUES ('1', 'More Wasting life','3', '2');


