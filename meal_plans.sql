USE hotel_data;
create table meal_plans (
    meal_plan_id tinyint primary key not null,
    plan_name varchar(20)
);
insert into meal_plans values (1,"Meal Plan 1");
insert into meal_plans values (2,"Meal Plan 2");
insert into meal_plans values (3,"Meal Plan 3");
insert into meal_plans values (0,"Not Selected");
select * from meal_plans;