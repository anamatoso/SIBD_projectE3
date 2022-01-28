-- 7. INDEXES
-- analyse effect on time of using index for specific queries

----------------
-- 7.1
EXPLAIN ANALYZE SELECT boat.name
FROM boat
    INNER JOIN country ON boat.iso_code=country.iso_code
WHERE year >= 2015 AND country.name = 'Portugal';
-- Hash Join  (cost=1.20..2.57 rows=1 width=11) (actual time=0.046..0.084 rows=2 loops=1)
--   Hash Cond: (boat.iso_code = country.iso_code)
--   ->  Seq Scan on boat  (cost=0.00..1.31 rows=16 width=14) (actual time=0.013..0.032 rows=16 loops=1)
--         Filter: (year >= 2015)
--         Rows Removed by Filter: 9
--   ->  Hash  (cost=1.19..1.19 rows=1 width=3) (actual time=0.016..0.019 rows=1 loops=1)
--         Buckets: 1024  Batches: 1  Memory Usage: 9kB
--         ->  Seq Scan on country  (cost=0.00..1.19 rows=1 width=3) (actual time=0.007..0.011 rows=1 loops=1)
--               Filter: ((name)::text = 'Portugal'::text)
--               Rows Removed by Filter: 14
-- Planning Time: 0.376 ms
-- Execution Time: 0.122 ms

-- For this query, there are two attributes being searched: year and country name. For the year attribute, the query is
-- a range query (all boats registered from <some year> onwards. Thus, a B-tree index is the most appropriate, since it
-- can navigated through the records according to whether these are higher or smaller than a certain record. For the
-- country name attribute, since we are searching for a specific value, we can use a hash index to help the process.
-- To test this, a timing analysis was performed.

CREATE INDEX year_idx ON boat(year); --b-tree index on boat.year
-- planning time: 0.269 ms (same)
-- execution time: 0.097 ms (same)
DROP INDEX year_idx;
-- same

CREATE INDEX name_idx ON country USING HASH (name); --hash index on country.name
-- planning time: 0.269 ms (same)
-- execution time: 0.089 ms (same)
DROP INDEX name_idx;
-- same

-- b-tree index can also be used to find specific values
CREATE INDEX name2_idx ON country(name); --hash index on country.name
-- planning time: 0.269 ms (same)
-- execution time: 0.089 ms (same)
DROP INDEX name2_idx;
-- same

-- using both indexes
-- planning time: 0.270 ms (same)
-- execution time: 0.084 ms (same)
-- seq san on country + bitmap heap scan on boat

-- Using indexes didn't make any difference since it ignored them in any case.

-- used overloaded account (from bank) table to test indexes:
EXPLAIN ANALYZE SELECT branch_name
FROM account
WHERE balance >= 7000 AND branch_name = 'Downtown';
-- Seq Scan on account  (cost=0.00..2181.00 rows=8323 width=9) (actual time=0.019..32.176 rows=8376 loops=1)
-- Filter: ((balance >= '2000'::numeric) AND ((branch_name)::text = 'Downtown'::text))
-- Rows Removed by Filter: 91624
-- Planning Time: 0.186 ms
-- Execution Time: 37.739 ms

CREATE INDEX balance_idx ON account(balance); -- didn't make a difference
-- Seq Scan on account  (cost=0.00..2181.00 rows=8323 width=9) (actual time=0.022..35.874 rows=8376 loops=1)
-- Filter: ((balance >= '2000'::numeric) AND ((branch_name)::text = 'Downtown'::text))
-- Rows Removed by Filter: 91624
-- Planning Time: 0.281 ms
-- Execution Time: 42.046 ms
DROP INDEX balance_idx;

CREATE INDEX name_idx ON account USING HASH (branch_name); -- worked!!
-- Bitmap Heap Scan on account  (cost=551.03..1449.94 rows=8323 width=9) (actual time=1.114..15.958 rows=8376 loops=1)
--   Recheck Cond: ((branch_name)::text = 'Downtown'::text)
--   Filter: (balance >= '2000'::numeric)
--   Rows Removed by Filter: 6214
--   Heap Blocks: exact=681
--   ->  Bitmap Index Scan on name_idx  (cost=0.00..548.95 rows=14527 width=0) (actual time=0.965..0.966 rows=14590 loops=1)
--         Index Cond: ((branch_name)::text = 'Downtown'::text)
-- Planning Time: 0.168 ms
-- Execution Time: 21.944 ms
DROP INDEX name_idx;

-- NOTE: if we use both, only the hash index is actually used, as expected.
-- ALSO: original query doesn't use the same mechanism
-- CONCLUSION: for some reason, using the b-treee isn't useful even it if it a range query. however, the hash index is
-- indeed helpful to search for specific values.

----------------
-- 7.2
EXPLAIN ANALYSE SELECT count(*)
FROM trip
    INNER JOIN location ON trip.end_latitude=location.latitude AND trip.end_longitude=location.longitude
WHERE start_date BETWEEN '2015-08-10' AND '2017-12-12'
  AND location.name LIKE '%SOME_PATTERN%';
-- Aggregate  (cost=2.69..2.70 rows=1 width=8) (actual time=0.024..0.030 rows=1 loops=1)
--   ->  Nested Loop  (cost=0.00..2.69 rows=1 width=0) (actual time=0.019..0.022 rows=0 loops=1)
--         Join Filter: ((trip.end_latitude = location.latitude) AND (trip.end_longitude = location.longitude))
--         ->  Seq Scan on trip  (cost=0.00..1.20 rows=1 width=18) (actual time=0.016..0.017 rows=0 loops=1)
--               Filter: ((start_date >= '2015-08-10'::date) AND (start_date <= '2017-12-12'::date))
--               Rows Removed by Filter: 13
--         ->  Seq Scan on location  (cost=0.00..1.48 rows=1 width=17) (never executed)
--               Filter: ((name)::text ~~ '%SOME_PATTERN%'::text)
-- Planning Time: 0.398 ms
-- Execution Time: 0.077 ms

-- composite b-tree index: location.name, start_date

-- For this query, there are two attributes being searched: start date and location name. For the start date attribute,
-- we have a range query, which indicates the most adequate index would be a B-tree index. For the location attribute, a
-- pattern is being searched. Since the pattern can be in the beginning, middle or end of the location name, no index
-- can help, since all records need to be searched in either case. However, it is worth noting that if the pattern was
-- only in the beginning of the location name, an index range scan (instead of the sequential scan) could improve the
-- query's execution time.
-- Reference: https://www.viralpatel.net/oracle-index-usage-like-operator-domain-indexes/

CREATE INDEX start_date_idx ON trip(start_date);
-- planning time: 0.509 ms (same)
-- execution time: 0.106 ms (same)
DROP INDEX start_date_idx;
-- same

-- testing hash and b-tree for location
-- NOTE: this aren't supposed to help, it was just to confirm. And the indexes still didn't help in the account example.
CREATE INDEX loc_b_idx ON location(name);
-- planning time: 0.517 ms (same)
-- execution time: 0.085 ms (same)
DROP INDEX loc_b_idx;
-- same

CREATE INDEX loc_hash_idx ON location USING HASH (name);
-- planning time: 0.416 ms (same)
-- execution time: 0.081 ms (same)
DROP INDEX loc_hash_idx;
-- same

--NOTA: tentar indice composto

-- Using overloaded account to test indexes
EXPLAIN ANALYSE SELECT count(*)
FROM account
WHERE balance BETWEEN 1000 AND 4000 AND branch_name LIKE '%tr%';
-- Aggregate  (cost=2473.84..2473.85 rows=1 width=8) (actual time=60.869..60.873 rows=1 loops=1)
--   ->  Seq Scan on account  (cost=0.00..2431.00 rows=17135 width=0) (actual time=0.025..48.961 rows=17057 loops=1)
--         Filter: ((balance >= '1000'::numeric) AND (balance <= '4000'::numeric) AND ((branch_name)::text ~~ '%tr%'::text))
--         Rows Removed by Filter: 82943
-- Planning Time: 0.199 ms
-- Execution Time: 60.954 ms

CREATE INDEX balance_idx ON account(balance);
-- Aggregate  (cost=2473.84..2473.85 rows=1 width=8) (actual time=61.096..61.099 rows=1 loops=1)
--   ->  Seq Scan on account  (cost=0.00..2431.00 rows=17135 width=0) (actual time=0.028..49.151 rows=17057 loops=1)
--         Filter: ((balance >= '1000'::numeric) AND (balance <= '4000'::numeric) AND ((branch_name)::text ~~ '%tr%'::text))
--         Rows Removed by Filter: 82943
-- Planning Time: 0.301 ms
-- Execution Time: 61.136 ms
DROP INDEX balance_idx;
-- same

-- testing hash and b-tree for location
CREATE INDEX branch_idx ON account(branch_name);
-- Aggregate  (cost=2473.84..2473.85 rows=1 width=8) (actual time=66.535..66.538 rows=1 loops=1)
--   ->  Seq Scan on account  (cost=0.00..2431.00 rows=17135 width=0) (actual time=0.028..53.416 rows=17057 loops=1)
--         Filter: ((balance >= '1000'::numeric) AND (balance <= '4000'::numeric) AND ((branch_name)::text ~~ '%tr%'::text))
--         Rows Removed by Filter: 82943
-- Planning Time: 0.286 ms
-- Execution Time: 66.575 ms
DROP INDEX branch_idx;
-- same

CREATE INDEX branch2_idx ON account USING HASH (branch_name);
-- Aggregate  (cost=2473.84..2473.85 rows=1 width=8) (actual time=58.289..58.292 rows=1 loops=1)
--   ->  Seq Scan on account  (cost=0.00..2431.00 rows=17135 width=0) (actual time=0.025..46.759 rows=17057 loops=1)
--         Filter: ((balance >= '1000'::numeric) AND (balance <= '4000'::numeric) AND ((branch_name)::text ~~ '%tr%'::text))
--         Rows Removed by Filter: 82943
-- Planning Time: 0.268 ms
-- Execution Time: 58.329 ms
DROP INDEX branch2_idx;
-- same