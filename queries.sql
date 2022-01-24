-- Queries
-- 1. Who is the owner?
select id_owner, iso_code_owner, iso_code, count(distinct (iso_code, cni))
from boat
group by id_owner, iso_code_owner, iso_code
having count(distinct (iso_code, cni)) >= all(select count(distinct (iso_code, cni)) from boat group by id_owner, iso_code_owner, iso_code);

-- 2.
select distinct id_owner, iso_code_owner, count(distinct iso_code) as ncountry
from boat
group by id_owner, iso_code_owner
having count(distinct iso_code) > 1;

-- 3. JUSTIFICAR entre PT ou Portugal + ir buscar info as trip em vez de ao sailor (pq a trip tem os sailors que sailam, e nao todos)
select s.id_sailor, s.iso_code_sailor
from trip s
where not exists (
    (select latitude,longitude from location l where l.iso_code = (select iso_code from country where l.name='Portugal'))
    except (select end_latitude,end_longitude from trip t where t.id_sailor = s.id_sailor and t.iso_code_sailor = s.iso_code_sailor));

-- 4.
select id_sailor, iso_code_sailor, cni, iso_code_boat, start_date, end_date, count(*) as ntrips
from trip
group by cni, iso_code_boat, id_sailor, iso_code_sailor, start_date, end_date
order by ntrips desc;

-- 5.
select id_sailor,iso_code_sailor,cni,iso_code_boat,id_sailor,iso_code_sailor,start_date,end_date,sum(duration) as sum_trip
from trip
group by cni, iso_code_boat, id_sailor, iso_code_sailor, start_date, end_date --reservation
order by sum_trip desc;

