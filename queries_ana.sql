--Queries

--Query 1
select iso_code, max(nboats)
from (
    select id_owner, iso_code_owner, iso_code, count((cni,iso_code)) as nboats
    from boat
    group by id_owner, iso_code_owner, iso_code order by iso_code) a
group by iso_code;

select id_owner, iso_code_owner, iso_code, nboats
from (select id_owner, iso_code_owner, iso_code, count((cni,iso_code)) as nboats
    from boat
    group by id_owner, iso_code_owner, iso_code order by iso_code) f
where nboats>= all(select nboats2
    from (select id_owner, iso_code_owner, iso_code, count((cni,iso_code)) as nboats2
    from boat
    group by id_owner, iso_code_owner, iso_code order by iso_code) f2
    where f2.iso_code=f.iso_code
    );


--Query 2
select id_owner, iso_code_owner, count(distinct iso_code) as nboats_distinct_country
from boat
group by id_owner, iso_code_owner
having count(distinct iso_code)>=2;

--Query 3
select id_sailor, iso_code_sailor
from trip t1
where not exists(
    select latitude,longitude
    from trip trip join location l on trip.end_latitude = l.latitude and trip.end_longitude = l.longitude
    where iso_code=(select iso_code from country where l.name='Portugal')
    except
    select end_latitude,end_longitude
    from trip t2
    where t2.iso_code_sailor=t1.iso_code_sailor and t1.id_sailor=t2.id_sailor
    );


--Query 4
select id_sailor, iso_code_sailor, count(date,cni,iso_code_boat,id_sailor,iso_code_sailor,start_date,end_date) ntrips
from trip
group by id_sailor, iso_code_sailor
order by ntrips desc;
--deviamos ver como se faz para mostrar tipo o top 3 (eu ja vi como se faz mas o prof diz que nao podemos usar esse comando)


--Query 5
select id_sailor, iso_code_sailor,date,cni,iso_code_boat,id_sailor,iso_code_sailor,start_date,end_date,sum(duration) as sum_duration
from trip
group by id_sailor, iso_code_sailor,date,cni,iso_code_boat,start_date,end_date --sailor e reservation
order by sum_duration desc;






























