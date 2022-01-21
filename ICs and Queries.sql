-- Queries
-- 1. Who is the owner - name ou pk's?
select id_owner, iso_code_owner, iso_code, count(distinct (iso_code, cni))
from boat
group by id_owner, iso_code_owner, iso_code
having count(distinct (iso_code, cni)) >= all(select count(distinct (iso_code, cni)) from boat group by id_owner, iso_code_owner, iso_code);

-- 2.
select distinct id_owner, iso_code_owner, count(distinct iso_code) as ncountry
from boat
group by id_owner, iso_code_owner
having count(distinct iso_code) > 1;

-- 3. JUSTIFICAR
select s.id_sailor, s.iso_code_sailor
from trip s
where not exists (
    (select latitude,longitude from location l where l.iso_code = (select iso_code from country where l.name='Portugal'))
    except (select end_latitude,end_longitude from trip t where t.id_sailor = s.id_sailor and t.iso_code_sailor = s.iso_code_sailor));

-- 4. PERGUNTAR - pôr só oq tem mais trips ou uma lista em ordem descendente?
select t.id_sailor, t.iso_code_sailor, count(*) -- what do they mean by "along with their reservations"?
from trip t
group by id_sailor,iso_code_sailor
having count(*) >= all(select count(*) from trip t2 group by t2.id_sailor, t2.iso_code_sailor);

-- 5. PERGUNTAR
select id_sailor, iso_code_sailor,date,cni,iso_code_boat,id_sailor,iso_code_sailor,start_date,end_date,sum(duration)
from trip
group by id_sailor, iso_code_sailor,date,cni,iso_code_boat,start_date,end_date
having sum(duration) >= all (select sum(duration) from trip group by id_sailor, iso_code_sailor,date,cni,iso_code_boat,start_date,end_date);