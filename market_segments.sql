use hotel_data;
create table market_segments (
    market_segment_id tinyint not null primary key,
    segment_name varchar(20)
);
insert into market_segments values (1,"Aviation");
insert into market_segments values (2,"Complementary");
insert into market_segments values (3,"Corporate");
insert into market_segments values (4,"Offline");
insert into market_segments values (5,"Online");
select * from market_segments;