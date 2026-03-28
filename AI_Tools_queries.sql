create database ai_landscape;
use ai_landscape;

CREATE TABLE Ai_tools (
    AI_Name VARCHAR(255),
    Developer VARCHAR(255),
    Release_Year INT,
    Intelligence_Type VARCHAR(100),
    Primary_Domain VARCHAR(150),
    Key_Functionality TEXT,
    Pricing_Model VARCHAR(100),
    API_Availability VARCHAR(50),
    Context_Window VARCHAR(50),
    Accessibility VARCHAR(100),
    Popularity_Votes INT,
    Website_URL TEXT
);
DROP table cleaned_ai_tools;
select * from ai_tools;
SELECT COUNT(*) AS total_tools FROM ai_tools;

select * from ai_tools 
where AI_Name is null
  or Release_Year is null;

select ai_name,count(*)
from ai_tools
group by AI_Name
having count(*) >1;

select release_year, count(*) as total_tools
from ai_tools
group by Release_Year
order by Release_Year;


select Intelligence_Type,
count(*) as total
from ai_tools
group by Intelligence_Type
order by total desc;

select primary_domain,
count(*) as total
from ai_tools
group by Primary_Domain
order by total desc;

select pricing_model ,
count(*) as total
from ai_tools
group by Pricing_Model;

select API_Availability ,
count(*) as total
from ai_tools
group by API_Availability;



select AI_Name,Popularity_Votes
from ai_tools
order by Popularity_Votes desc
limit 10;


select  Intelligence_Type,
avg(popularity_votes) as avg_popularity
from ai_tools
group by Intelligence_Type
order by avg_popularity desc;

select ai_name,Popularity_Votes
from ai_tools
where API_Availability="yes"
order by Popularity_Votes desc;

select ai_name,popularity_votes
from ai_tools
where popularity_votes > (
select avg(popularity_votes) from ai_tools);


select *
from(
       select ai_name,
              intelligence_type,
              Popularity_Votes,
              ROW_NUMBER() over (partition by intelligence_type 
                                   order by popularity_votes desc) as rn
                                   from ai_tools
	) ranked
where rn =1;



select release_year,
       count(*) as total_tools,
       lag(count(*)) over (order by release_year) as prv_year,
       count(*) - lag(count(*)) over (order by release_year) as growth
from ai_tools
group by release_year ;    


create view yearly_summary as 
select release_year ,
       count(*) as total_tools
from ai_tools
group by Release_Year; 
                          