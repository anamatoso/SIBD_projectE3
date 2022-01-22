
/*
index 7.1
ano>ano_dado= range logo Btree no ano da tabela boat
country name = country especifico-> hash no name da tabela country

index 7.2
btree start date da trip
para a location nao vale a pena- comparar tempos na msm cite:https://www.viralpatel.net/oracle-index-usage-like-operator-domain-indexes/
 */

CREATE INDEX balance_idx ON account USING HASH (balance);
DROP INDEX balance_idx;
EXPLAIN ANALYZE select * from account;
