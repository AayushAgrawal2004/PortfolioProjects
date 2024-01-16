--create a join table, main table is absenteism at work
--join absenteeism table with compensation table
select * from Absenteeism_at_work a
left join compensation b --bring back all columns from table as work, matching rows from right table
on a.ID = b.ID
--join the reaons table with new join table based on the reasons_for_absense column
left join Reasons r
on a.Reason_for_absence = r.Number;

--find the healthiest employees to determine who receives bonus
--filtering our main table based off many attributes to determine healthy people
select * from Absenteeism_at_work
where Social_drinker = 0 and Social_smoker = 0 and Body_mass_index < 25
and Absenteeism_time_in_hours < (select AVG(Absenteeism_time_in_hours) from Absenteeism_at_work);

--compensation rate increase for non-smokers/budget $983,221
--giving non-smokers 68 cent increase per hour: $983221/(5 days * 8 hours * 52 weeks * 686 non-smoker employees)
--giving $1,414.40 per year for non-smokers
select count(*) as nonsmokers from Absenteeism_at_work
where Social_smoker = 0

--optimize the query: two identical columns and using wildcards
--make categories using case statements for Power BI
--result set from this query will be used for analysis in power bi to make dashboard
select a.ID, r.Reason, a.Month_of_absence, a.Body_mass_index,
case
	when Body_mass_index < 18.5 then 'Underweight'
	when Body_mass_index between 18.5 and 25 then 'Healthy' 
	when Body_mass_index between 25 and 30 then 'Overweight'
	when Body_mass_index > 30 then 'Obese'
	else 'Unknown'
	end as BMI_category,
case 
	when Month_of_absence IN (12,1,2) then 'Winter'
	when Month_of_absence IN (3,4,5) then 'Spring'
	when Month_of_absence IN (6, 7, 8) then 'Summer'
	when Month_of_absence IN (9, 10, 11) then 'Summer'
	else 'Unknown'
	end as Season_Names,
Seasons,
Month_of_absence,
Day_of_the_week,
Transportation_expense,
Education,
Son,
Social_drinker,
Social_smoker,
Pet,
Disciplinary_failure,
Age,
Work_load_Average_day,
Absenteeism_time_in_hours
from Absenteeism_at_work a
left join compensation b --bring back all columns from table as work, matching rows from right table
on a.ID = b.ID
--join the reaons table with new join table based on the reasons_for_absense column
left join Reasons r
on a.Reason_for_absence = r.Number;