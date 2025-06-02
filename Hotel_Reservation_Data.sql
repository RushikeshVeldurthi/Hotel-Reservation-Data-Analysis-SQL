CREATE DATABASE hotel_data;
USE hotel_data;
CREATE TABLE hotel_reservations (
    Booking_ID VARCHAR(10),
    no_of_adults TINYINT,
    no_of_children TINYINT,
    no_of_weekend_nights TINYINT,
    no_of_week_nights TINYINT,
    type_of_meal_plan VARCHAR(20),
    required_car_parking_space TINYINT,
    room_type_reserved VARCHAR(12),
    lead_time INT,
    arrival_year INT,
    arrival_month TINYINT,
    arrival_date TINYINT,
    market_segment_type VARCHAR(20),
    repeated_guest TINYINT,
    no_of_previous_cancellations TINYINT,
    no_of_previous_bookings_not_canceled TINYINT,
    avg_price_per_room FLOAT,
    no_of_special_requests TINYINT,
    booking_status VARCHAR(20)
);
ALTER TABLE hotel_reservations MODIFY Booking_ID VARCHAR(10) NOT NULL;
ALTER TABLE hotel_reservations MODIFY no_of_adults TINYINT NOT NULL;
ALTER TABLE hotel_reservations MODIFY no_of_children TINYINT NOT NULL;
ALTER TABLE hotel_reservations MODIFY no_of_weekend_nights TINYINT NOT NULL;
ALTER TABLE hotel_reservations MODIFY no_of_week_nights TINYINT NOT NULL;
ALTER TABLE hotel_reservations MODIFY type_of_meal_plan VARCHAR(20) NOT NULL;
ALTER TABLE hotel_reservations MODIFY required_car_parking_space TINYINT NOT NULL;
ALTER TABLE hotel_reservations MODIFY room_type_reserved VARCHAR(12) NOT NULL;
ALTER TABLE hotel_reservations MODIFY lead_time INT NOT NULL;
ALTER TABLE hotel_reservations MODIFY arrival_year INT NOT NULL;
ALTER TABLE hotel_reservations MODIFY arrival_month TINYINT NOT NULL;
ALTER TABLE hotel_reservations MODIFY arrival_date TINYINT NOT NULL;
ALTER TABLE hotel_reservations MODIFY market_segment_type VARCHAR(20) NOT NULL;
ALTER TABLE hotel_reservations MODIFY repeated_guest TINYINT NOT NULL;
ALTER TABLE hotel_reservations MODIFY no_of_previous_cancellations TINYINT NOT NULL;
ALTER TABLE hotel_reservations MODIFY no_of_previous_bookings_not_canceled TINYINT NOT NULL;
ALTER TABLE hotel_reservations MODIFY avg_price_per_room FLOAT NOT NULL;
ALTER TABLE hotel_reservations MODIFY no_of_special_requests TINYINT NOT NULL;
ALTER TABLE hotel_reservations MODIFY booking_status VARCHAR(20) NOT NULL;

ALTER TABLE hotel_reservations ADD CONSTRAINT Booking_ID UNIQUE (Booking_ID);
ALTER TABLE hotel_reservations ADD CONSTRAINT no_of_adults CHECK (no_of_adults >= 0);
ALTER TABLE hotel_reservations ADD CONSTRAINT no_of_children CHECK (no_of_children >= 0);
ALTER TABLE hotel_reservations ADD CONSTRAINT no_of_weekend_nights CHECK (no_of_weekend_nights >= 0);
ALTER TABLE hotel_reservations ADD CONSTRAINT no_of_week_nights CHECK (no_of_week_nights >= 0);
ALTER TABLE hotel_reservations ADD CONSTRAINT required_car_parking_space CHECK (required_car_parking_spaces in (0,1));
ALTER TABLE hotel_reservations ADD CONSTRAINT repeated_guest CHECK (repeated_guest in (0,1));
ALTER TABLE hotel_reservations ADD CONSTRAINT avg_price_per_room CHECK (avg_price_per_room >= 0);
ALTER TABLE hotel_reservations ADD CONSTRAINT no_of_special_requests CHECK (no_of_special_requests >= 0);
ALTER TABLE hotel_reservations ADD CONSTRAINT booking_status CHECK (booking_status IN ('Canceled', 'Not_Canceled'));
# 1)
set sql_safe_updates = 0;
update hotel_reservations set room_type_reserved = 1 where room_type_reserved = "Room_Type 1"; 
update hotel_reservations set room_type_reserved = 2 where room_type_reserved = "Room_Type 2";
update hotel_reservations set room_type_reserved = 3 where room_type_reserved = "Room_Type 3";
update hotel_reservations set room_type_reserved = 4 where room_type_reserved = "Room_Type 4";
update hotel_reservations set room_type_reserved = 5 where room_type_reserved = "Room_Type 5";
update hotel_reservations set room_type_reserved = 6 where room_type_reserved = "Room_Type 6";
update hotel_reservations set room_type_reserved = 7 where room_type_reserved = "Room_Type 7";
alter table hotel_reservations  change column room_type_reserved room_type_reserved_id tinyint;
alter table hotel_reservations add constraint room_type_reserved_id  foreign key (room_type_reserved_id) references room_types(room_type_id) on update cascade on delete cascade;
describe hotel_reservations;
select * from hotel_reservations;

# 2)
set sql_safe_updates = 0;
update hotel_reservations set type_of_meal_plan = 1 where type_of_meal_plan = "Meal Plan 1"; 
update hotel_reservations set type_of_meal_plan = 2 where type_of_meal_plan = "Meal Plan 2";
update hotel_reservations set type_of_meal_plan = 3 where type_of_meal_plan = "Meal Plan 3";
update hotel_reservations set type_of_meal_plan = 0 where type_of_meal_plan = "Not Selected";
alter table hotel_reservations  change column type_of_meal_plan type_of_meal_plan_id tinyint;
alter table hotel_reservations add constraint type_of_meal_plan_id  foreign key (type_of_meal_plan_id) references meal_plans(meal_plan_id) on update cascade on delete cascade;
describe hotel_reservations;
select * from hotel_reservations;

# 3)
set sql_safe_updates = 0;
update hotel_reservations hr
join market_segments ms ON hr.market_segment_type = ms.segment_name
set hr.market_segment_type = ms.market_segment_id;
select distinct market_segment_type from hotel_reservations;
alter table hotel_reservations change column market_segment_type market_segment_type_id tinyint;
alter table hotel_reservations add constraint market_segment_type_id foreign key (market_segment_type_id) references market_segments(market_segment_id) on update cascade on delete cascade;
select distinct market_segment_type_id from hotel_reservations;


# 1) Show all canceled bookings.
select * from hotel_reservations where booking_status = "Canceled";
# 2) List bookings with more than 2 adults.
select * from hotel_reservations where no_of_adults > 2;
# 3) Find bookings with children but no adults (data check).
select * from hotel_reservations where no_of_children > 0 and no_of_adults = 0;
# 4) Get bookings with more than 2 special requests.
select * from hotel_reservations where no_of_special_requests > 2;
# 5) Find all bookings that required a car parking space.
select * from hotel_reservations where required_car_parking_space = 1;

# 6) List top 5 bookings by highest average price per room.
select * from hotel_reservations  order by avg_price_per_room desc limit 5;
# 7) Sort bookings by lead time (longest to shortest).
select * from hotel_reservations order by lead_time desc ;
# 8) Show bookings made by repeated guests only.
select * from hotel_reservations where repeated_guest = 1;
# 9) Find bookings with more than 5 nights stay.
select * from hotel_reservations where no_of_week_nights > 5 and no_of_weekend_nights > 5;
# 10) List all bookings with weekend nights but no week nights.
select * from hotel_reservations where no_of_weekend_nights > 0 and no_of_week_nights = 0;

# 11) Count total bookings per room type.
select room_type_reserved_id, count(room_type_reserved_id) as Count from hotel_reservations group by room_type_reserved_id order by Count ;
# 12) Count number of bookings for each meal plan.
select type_of_meal_plan_id, count(type_of_meal_plan_id) as Count from hotel_reservations group by type_of_meal_plan_id order by Count;
# 13) Average lead time grouped by market segment.
select market_segment_type_id, avg(lead_time) as avg_lead_time from hotel_reservations group by market_segment_type_id order by avg_lead_time;
# 14) Total special requests made by repeated guests.
select repeated_guest, sum(no_of_special_requests) as Total from hotel_reservations where repeated_guest = 1 ;
# 15) Average room price for canceled vs. non-canceled bookings.
select booking_status , avg(avg_price_per_room) as average_room_price from hotel_reservations group by booking_status;

# 16) Count bookings by arrival month.
select arrival_month,count(Booking_ID) as Count from hotel_reservations group by arrival_month;
# 17) Find which month has the highest cancellations.
select arrival_month , count(booking_status) as highest_cancellations from hotel_reservations where booking_status = 'Canceled' group by arrival_month order by highest_cancellations desc limit 1;
# 18) Show total bookings per arrival year.
select arrival_year,count(Booking_ID) from hotel_reservations group by arrival_year ;

# 19) Find cancellation rate per room type.
select
room_type_reserved_id,
count(*) as total_bookings,
sum(case when booking_status = 'Canceled' then 1 else 0 end) as cancellations,
(100.0 * sum(case when booking_status = 'Canceled' then 1 else 0 end) / count(*)) as cancel_rate_percent
from hotel_reservations
group by room_type_reserved_id;

# 20) Compare avg lead time for repeat vs. non-repeat guests.
select repeated_guest,avg(lead_time) as avg_lead_time from hotel_reservations  group by repeated_guest order by repeated_guest desc;

