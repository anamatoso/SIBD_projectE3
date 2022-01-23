-- 7. INDEXES
-- analyse effect on time of using index for specific queries

----------------
-- 7.1
EXPLAIN ANALYZE SELECT boat.name
FROM boat
    INNER JOIN country ON boat.iso_code=country.iso_code
WHERE year >= 2015 AND country.name = 'Portugal';
-- planning time: 0.259 ms
-- execution time: 0.088 ms
-- seq san on country + bitmap heap scan on boat

-- For this query, there are two attributes being searched: year and country name. For the year attribute, the query is
-- a range query (all boats registered from <some year> onwards. Thus, a B-tree index is the most appropriate, since it
-- can navigated through the records according to whether these are higher or smaller than a certain record. For the
-- country name attribute, since we are searching for a specific value, we can use a hash index to help the process.
-- To test this, a timing analysis was performed.

CREATE INDEX year_idx ON boat(year); --b-tree index on boat.year
-- planning time: 0.269 ms (same)
-- execution time: 0.097 ms (same)
DROP INDEX year_idx;
-- seq san on country + bitmap heap scan on boat

CREATE INDEX name_idx ON country USING HASH (name); --hash index on country.name
-- planning time: 0.269 ms (same)
-- execution time: 0.089 ms (same)
DROP INDEX name_idx;
-- seq san on country + bitmap heap scan on boat

-- using both indexes
-- planning time: 0.270 ms (same)
-- execution time: 0.084 ms (same)
-- seq san on country + bitmap heap scan on boat

-- Using indexes didn't make any difference since it ignored them in any case.

----------------
-- 7.2
EXPLAIN ANALYSE SELECT count(*)
FROM trip
    INNER JOIN location ON trip.end_latitude=location.latitude AND trip.end_longitude=location.longitude
WHERE start_date BETWEEN '2015-08-10' AND '2017-12-12' AND location.name LIKE '%SOME_PATTERN%';
-- planning time: 0.301 ms
-- execution time: 0.085 ms
-- seq scan on location + bitmap heap scan on trip

-- For this query, there are two attributes being searched: start date and location name. For the start date attribute,
-- we have a range query, which indicates the most adequate index would be a B-tree index. For the location attribute, a
-- pattern is being searched. Since the pattern can be in the beginning, middle or end of the location name, no index
-- can help, since all records need to be searched in either case. However, it is worth noting that if the pattern was
-- only in the beginning of the location name, an index range scan (instead of the sequential scan) could improve the
-- query's execution time.
-- Reference: https://www.viralpatel.net/oracle-index-usage-like-operator-domain-indexes/

CREATE INDEX start_date_idx ON trip(start_date); --b-tree index on boat.year
-- planning time: 0.509 ms (same)
-- execution time: 0.106 ms (same)
DROP INDEX start_date_idx;
-- seq scan on location + bitmap heap scan on trip

-- testing hash and b-tree for location
CREATE INDEX loc_b_idx ON location(name);
DROP INDEX loc_b_idx;
-- planning time: 0.517 ms (same)
-- execution time: 0.085 ms (same)
-- seq scan on location + bitmap heap scan on trip
CREATE INDEX loc_hash_idx ON location USING HASH (name);
DROP INDEX loc_hash_idx;
-- planning time: 0.416 ms (same)
-- execution time: 0.081 ms (same)
-- seq scan on location + bitmap heap scan on trip
