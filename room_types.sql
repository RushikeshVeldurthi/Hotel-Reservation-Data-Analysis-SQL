USE hotel_data;
CREATE TABLE room_types (
    room_type_id TINYINT PRIMARY KEY NOT NULL,
    room_type_name VARCHAR(12)
);
INSERT INTO room_types VALUES(1,"Room_Type 1");
INSERT INTO room_types VALUES(2,"Room_Type 2");
INSERT INTO room_types VALUES(3,"Room_Type 3");
INSERT INTO room_types VALUES(4,"Room_Type 4");
INSERT INTO room_types VALUES(5,"Room_Type 5");
INSERT INTO room_types VALUES(6,"Room_Type 6");
INSERT INTO room_types VALUES(7,"Room_Type 7");
select * from room_types;
