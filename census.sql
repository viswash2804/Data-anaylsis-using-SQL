SELECT * FROM project.dataset1;
-- number of rows in our dataset
select count(*) from project.dataset1


-- selecting data who lives in states jharkhand and bihar

select * from project.dataset1 where State='Jharkhand' and State='Bihar'

-- avg growth by state
select State,avg(Growth) from project.dataset1 group by State order by State



-- avg growth by each district in andhrapradesh
select District,avg(Growth) from project.dataset1 where State='Andhra Pradesh'
 group by District
 
 
 -- avg of growth by each district in each state
select District,State,avg(Growth) from project.dataset1 group by District,State 
order by state

 
 
-- avg sex ratio by each state
select State,avg(Sex_Ratio) from project.dataset1 group by State order by State



-- avg of sex ratio by each district in each state
select District,State,avg(Sex_Ratio) from project.dataset1 group by District,State 
order by state


-- avg literacy rate by each state
select State,avg(Literacy) from project.dataset1 group by State order by State

-- avg of literacy by each district in each state
select District,State,avg(Literacy) from project.dataset1 group by District,State 
order by state


-- top 5 state showing highest growth ratio
 select State,Growth from project.dataset1 order by Growth desc limit 5


-- bottom 5 state showing lowest sex ratio
 select State,Growth from project.dataset1 order by Growth asc limit 5


-- top and bottom 5 states in literacy state
select State,Literacy from project.dataset1 order by Literacy desc limit 5

union

select State,Literacy from project.dataset1 order by Literacy asc limit 5


-- states starting with letter A
select * from project.dataset1 where State like 'A%'


-- joining both the tables
select a.District,a.State,a.Sex_Ratio,b.Population,a.Literacy from project.dataset1 as a  inner join
project.dataset2 as b on a.District=b.District


-- sex_ratio=females/males ,  females+males=population ;  females=population-males;   substitute females equation in 
-- sex_ratio equation population-males/males=sex_ratio;   population=males(sex_ratio+1); 


-- calaculating total no.of males in each state
(select c.District,c.State,c.Population/(c.Sex_Ratio+1) males
 from 
 (select a.District,a.State,a.Sex_Ratio/1000 Sex_Ratio,b.Population,a.Literacy from project.dataset1 as a  inner join
project.dataset2 as b on a.District=b.District) c) 


-- similarly for females also ;;

-- calaculating total no.of females in each state
(select c.District,c.State,c.Population*c.Sex_Ratio/(c.Sex_Ratio+1) females
 from 
 (select a.District,a.State,a.Sex_Ratio/1000 Sex_Ratio,b.Population,a.Literacy from project.dataset1 as a  inner join
project.dataset2 as b on a.District=b.District) c) 



-- calaculating total no.of malesn and females in each state
(select c.District,c.State,c.Population/(c.Sex_Ratio+1)males,(c.Population*c.Sex_Ratio)/(c.Sex_Ratio+1) females
 from 
 (select a.District,a.State,a.Sex_Ratio/1000 Sex_Ratio,b.Population,a.Literacy from project.dataset1 as a  inner join
project.dataset2 as b on a.District=b.District) c) 



-- literacy_ratio=total literate_people/population;  total literate_people=population*literacy_ratio ;; 


-- calculating literate people in each state
(select d.District,d.State,(d.Population*d.Literacy) literate_people
from
(select a.District,a.State,a.Literacy/100 Literacy,b.Population  from project.dataset1 as a  inner join
project.dataset2 as b on a.District=b.District) d) 

-- total illiterate_people=(1-literacy_ratio)*population



-- calculating illterate people in each state
(select d.District,d.State,(d.Population*(1-d.Literacy)) illiterate_people
from
(select a.District,a.State,a.Literacy/100 Literacy,b.Population  from project.dataset1 as a  inner join
project.dataset2 as b on a.District=b.District) d) 



-- output top 10 districts from each state with highest literacy rate(using window function)
select e.* from
(select *,rank() over(order by Literacy desc) ranking from project.dataset1) e
where ranking in(1,2,3,4,5,6,7,8,9,10)
order by ranking













