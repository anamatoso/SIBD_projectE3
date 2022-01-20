-- Queries
-- 1.
select id_owner, iso_code, count(*)
from boat
group by id_owner, iso_code
having count(*) >= all(select count(*) from boat group by id_owner, iso_code);

-- 2.
select distinct id_owner, iso_code_owner
from boat
group by id_owner, iso_code_owner
having count(distinct iso_code) > 1;

-- 3.
select s.id, s.iso_code
from sailor s
group by s.id, s.iso_code
having not exists ((select latitude,longitude from location l where l.iso_code = 'PT')
except (select end_latitude,end_longitude from trip t where t.id_sailor = s.id and t.iso_code_sailor = s.iso_code));

-- 4.
select t.id_sailor, t.iso_code_sailor, count(*) -- what do they mean by "along with their reservations"?
from trip t
group by id_sailor,iso_code_sailor
having count(*) >= all(select count(*) from trip t2 group by t2.id_sailor, t2.iso_code_sailor);

-- 5.
select id_sailor, iso_code_sailor,date,cni,iso_code_boat,id_sailor,iso_code_sailor,start_date,end_date,sum(duration)
from trip
group by id_sailor, iso_code_sailor,date,cni,iso_code_boat,start_date,end_date
having sum(duration) >= all (select sum(duration) from trip group by id_sailor, iso_code_sailor,date,cni,iso_code_boat,start_date,end_date);