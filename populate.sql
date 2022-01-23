-- Populate country (correct)
insert into country values('tinyurl.com/v5n8tvdd','Portugal','PT');
insert into country values('tinyurl.com/5exjjxwd','South Africa','ZA');
insert into country values('tinyurl.com/2fsbc42p','Spain','ES');
insert into country values('tinyurl.com/yckkzx47','United States','US');
insert into country values('tinyurl.com/5jnb8p3y','Australia','AU');
insert into country values('tinyurl.com/bdfdvdtz','Japan','JP');
insert into country values('tinyurl.com/y62xx23t','Brazil','BR');
insert into country values('tinyurl.com/3sy6mx2x','Argentina','AR');
insert into country values('tinyurl.com/33f2s9wt','Iceland','IS');
insert into country values('tinyurl.com/2p8rkbfh','Italy','IT');
insert into country values('tinyurl.com/mv6z6xd3','United Kingdom','GB');
insert into country values('tinyurl.com/yckrujsy','Greece','GR');
insert into country values('tinyurl.com/2p8bpxc4','Mozambique','MZ');
insert into country values('tinyurl.com/39zdcjaj','United Arab Emirates','AE');
insert into country values('tinyurl.com/4n6tdfba','Canada','CA');


-- Populate Location (correct)
START TRANSACTION;
SET CONSTRAINTS ALL DEFERRED;
insert into location values ('Lisbon', 38.705276,9.146657,'PT'); insert into marina values (38.705276,9.146657);
insert into location values ('Cape Town',-33.924870,18.424055,'ZA'); insert into port values (-33.924870,18.424055);
insert into location values ('Porto',41.157844,-8.629105,'PT'); insert into wharf values (41.157844,-8.629105);
insert into location values ('Durban',-29.858681,31.021839,'ZA'); insert into marina values (-29.858681,31.021839);
insert into location values ('Barcelona',41.385063,2.173404,'ES'); insert into port values (41.385063,2.173404);
insert into location values ('Miami',25.764144,-80.057571,'US'); insert into wharf values (25.764144,-80.057571);
insert into location values ('Perth',-31.950527,115.860458,'AU'); insert into marina values (-31.950527,115.860458);
insert into location values ('Osaka',34.693737,135.502167,'JP'); insert into marina values (34.693737,135.502167);
insert into location values ('Rio de Janeiro',-22.906847,-43.172897,'BR'); insert into port values (-22.906847,-43.172897);
insert into location values ('Buenos Aires',-34.603683,-58.381557,'AR'); insert into port values (-34.603683,-58.381557);
insert into location values ('Reykjavik',64.128288,-21.827774,'IS'); insert into wharf values (64.128288,-21.827774);
insert into location values ('Naples',40.839980,14.252540,'IT'); insert into wharf values (40.839980,14.252540);
insert into location values ('Fuimicino',41.771530,12.230000,'IT'); insert into marina values (41.771530,12.230000);
insert into location values ('Valencia',28.521076,-81.465523,'ES'); insert into port values (28.521076,-81.465523);
insert into location values ('Port Elizabeth',-33.961302,25.662782,'ZA'); insert into wharf values (-33.961302,25.662782);
insert into location values ('Funchal',32.6496497,-16.9086783,'PT'); insert into port values (32.6496497,-16.9086783);
insert into location values ('San Diego',32.7174202,-117.1627728,'US'); insert into port values (32.7174202,-117.1627728);
insert into location values ('Adelaide',-34.9281805,138.5999312,'AU'); insert into marina values (-34.9281805,138.5999312);
insert into location values ('São Paulo',-23.5506507,-46.6333824,'BR'); insert into marina values (-23.5506507,-46.6333824);
insert into location values ('Venice',45.4371908,12.3345898,'IT'); insert into wharf values (45.4371908,12.3345898);
insert into location values ('Figueira da Foz',40.147266,-8.860761,'PT'); insert into marina values (40.147266, -8.860761);
insert into location values ('Aveiro',40.635114,-8.651154,'PT'); insert into port values (40.635114, -8.651154);
insert into location values ('Vigo',42.239086,-8.731343,'ES'); insert into wharf values (42.239086, -8.731343);
insert into location values ('New York',40.703546,-74.006764,'US'); insert into marina values (40.703546, -74.006764);
insert into location values ('Sidney',-33.860549,151.211336,'AU'); insert into port values (-33.860549, 151.211336);
insert into location values ('Tokyo',35.652305,139.761995,'JP'); insert into wharf values (35.652305, 139.761995);
insert into location values ('Salvador',-12.952183,-38.503131,'BR'); insert into marina values (-12.952183, -38.503131);
insert into location values ('Mar del Plata',-38.046028,-57.536806,'AR'); insert into port values (-38.046028, -57.536806);
insert into location values ('Los Angeles',33.738706,-118.266112,'US'); insert into wharf values (33.738706, -118.266112);
insert into location values ('San Francisco',37.799968,-122.398026,'US'); insert into marina values (37.799968, -122.398026);
insert into location values ('Cardiff',51.4816546,-3.1791934,'GB'); insert into marina values (51.4816546,-3.1791934);
insert into location values ('Brighton',50.8214626,-0.1400561, 'GB'); insert into marina values (50.8214626,-0.1400561);
insert into location values ('Athens',37.9839412,23.7283052,'GR'); insert into port values (37.9839412,23.7283052);
insert into location values ('Kalamata',37.0377582,22.1109392,'GR'); insert into wharf values (37.0377582,22.1109392);
insert into location values ('Maputo',-25.966213,32.56745,'MZ'); insert into port values (-25.966213,32.56745);
insert into location values ('Dubai',25.2653471,55.2924914,'AE'); insert into marina values (25.2653471,55.2924914);
insert into location values ('Abu Dhabi',24.4538352,54.3774014,'AE'); insert into marina values (24.4538352,54.3774014);
insert into location values ('Toronto',43.6534817,-79.3839347,'CA'); insert into marina values (43.6534817,-79.3839347);
COMMIT;


--Populate Person (correct)
insert into person values (126578,'Teresa Villaverde','PT');
insert into person values (126578,'Martin Scorsese','ZA');
insert into person values (5679890,'Tim Burton','US');
insert into person values (456890,'Steven Spielberg','BR');
insert into person values (88904123,'Quentin Tarantino','AR');
insert into person values (908765,'Pedro Almodovar','ES');
insert into person values (14617319,'Christopher Nolan','AU');
insert into person values (55667,'Hayao Miazaki','JP');
insert into person values (68904,'Stanley Kubrick','IS');
insert into person values (1345687,'Federico Fellini','IT');
insert into person values (2956612,'Marta Silva','PT'); --sailor
insert into person values (1962857,'Martim Vincente','ES'); --sailor
insert into person values (4850294,'Carlos Ruiz','AR'); --owner
insert into person values (1046205,'Diogo Silva','BR'); --owner
insert into person values (0193758,'Lewis Button','AU'); --sailor
insert into person values (2957392,'Michael Clifford','AU'); --sailor
insert into person values (2045869,'Chris Hoeven','AU'); --sailor
insert into person values (1220588,'Haruki Murakami','JP'); --owner & sailor
insert into person values (2000582,'Charles Kubica','IS'); --owner
insert into person values (2945190,'Alfredo Giovinazzi','IT'); --owner
insert into person values (2945190,'Ana Rendeiro','PT');
insert into person values (2945191,'João Rendeiro','PT');
insert into person values (8435738,'Maria Joaquina','PT');
insert into person values (34678,'Nelson Mandela','ZA');
insert into person values (27368,'James Cameron','US');
insert into person values (8873768,'Luana Santana','BR');
insert into person values (3824,'Pablo Alboran','AR');
insert into person values (8379268,'Rodrigo Santoro','ES');
insert into person values (89347874,'Nicole Kidman','AU');
insert into person values (2934729,'Fusajiro Yamauchi','JP');
insert into person values (238947,'Jamie Dornan','IS');
insert into person values (23874876,'Luigi Ferrari','IT');
insert into person values (38596665,'Armando Stroll','CA'); --sailor
insert into person values (10386720,'Albert Eisntein','AE'); --sailor
insert into person values (10033958,'Ahmad Salem','AE'); --sailor
insert into person values (10049682,'Matias Damasio','MZ'); --sailor
insert into person values (58995496,'Nicholas Sparks','GB'); --sailor
insert into person values (22059683,'Carlos Sainz','ES'); --owner
insert into person values (50025860,'Gregori Mattos','GR'); --owner
insert into person values (13359683,'João Silva','PT'); --owner
insert into person values (22058689,'John Piastri','ZA'); --owner & sailor
insert into person values (20566893,'Lucas Smith','GB'); --owner & sailor


--Populate Sailor (correct)
insert into sailor values (126578,'PT');
insert into sailor values (5679890,'US');
insert into sailor values (456890,'BR');
insert into sailor values (88904123,'AR');
insert into sailor values (908765,'ES');
insert into sailor values (2956612,'PT');
insert into sailor values (1962857,'ES');
insert into sailor values (0193758,'AU');
insert into sailor values (2957392,'AU');
insert into sailor values (2045869,'AU');
insert into sailor values (8435738,'PT');
insert into sailor values (34678,'ZA');
insert into sailor values (27368,'US');
insert into sailor values (8379268,'ES');
insert into sailor values (89347874,'AU');
insert into sailor values (2934729,'JP');
insert into sailor values (238947,'IS');
insert into sailor values (23874876,'IT');
insert into sailor values (1220588, 'JP');
insert into sailor values (38596665,'CA');
insert into sailor values (10386720,'AE');
insert into sailor values (10033958,'AE');
insert into sailor values (10049682,'MZ');
insert into sailor values (58995496,'GB');
insert into sailor values (22058689,'ZA');
insert into sailor values (20566893,'GB');

--Populate Owner (correct)
insert into owner values (126578,'ZA','1963-08-01');
insert into owner values (5679890,'US','1977-03-31');
insert into owner values (456890,'BR','1945-12-05');
insert into owner values (14617319,'AU','1974-09-11');
insert into owner values (55667,'JP','1961-01-01');
insert into owner values (68904,'IS','1953-08-09');
insert into owner values (1345687,'IT','1963-08-01');
insert into owner values (2000582,'IS', '1999-09-16');
insert into owner values (2945190,'IT', '1996-03-01');
insert into owner values (4850294,'AR', '1971-10-08');
insert into owner values (1046205,'BR', '1985-10-10');
insert into owner values (8873768,'BR','1945-01-12');
insert into owner values (3824,'AR','1987-02-20');
insert into owner values (8379268,'ES','1955-03-11');
insert into owner values (89347874,'AU','1965-04-21');
insert into owner values (2945190,'PT','1980-07-30');
insert into owner values (1220588,'JP','1984-11-30');
insert into owner values (22059683,'ES','1954-12-13');
insert into owner values (50025860,'GR','1994-09-30');
insert into owner values (13359683,'PT','2000-06-23');
insert into owner values (22058689,'ZA','2001-04-14');
insert into owner values (20566893,'GB','1998-02-17');
insert into owner values (2945191,'PT','1955-04-23');

--Populate Boat
insert into boat values ('PRT', 98237,2000,40,'O Desconhecido','BRA',8873768);
insert into boat values ('ARG', 839,2001,40,'El Rey','ARG',3824);
insert into boat values ('PRT', 23748,2012,30,'EL Hombre','ESP',8379268);
insert into boat values ('AUS', 23784,2020,20,'The Great','AUS',89347874);
insert into boat values ('ZAF', 58947,2021,50,'The Inocent','PRT',2945190);
insert into boat values ('ITA', 18293,2007,50,'Breeza','ZAF',126578); --vhf
insert into boat values ('PRT', 20586,2016,60,'Avante','ITA',1345687); --vhf
insert into boat values ('AUS', 10083,2015,20,'Antelope','ARG',4850294); --vhf
insert into boat values ('ISL', 11940,2004,45,'Freedom','JPN',1220588);
insert into boat values ('ZAF', 49602,1999,40,'Seas the Day','ARG',3824); --vhf
insert into boat values ('CAN', 58201,2001,40,'Carpe Diem','ESP',22059683);
insert into boat values ('USA', 30699,1990,50,'Blue Moon','GRC',50025860);
insert into boat values ('GBR', 10059,2015,20,'Escape','ZAF',22058689);
insert into boat values ('CAN', 20956,1984,45,'Liberdade','PRT',13359683); --vhf
insert into boat values ('GBR', 14296,2019,55,'Serendipity','AUS',89347874); --vhf
insert into boat values ('ZAF', 23874682,2021,100,'Conspirasea','PRT',2945191);
insert into boat values ('GBR', 93476,2021,40,'Black Pearl','USA',5679890);
insert into boat values ('PRT', 345,2021,40,'The Flying Dutchman','BRA',456890);
insert into boat values ('AUS', 3532,2021,40,'The Queen Annes Revenge','AUS',14617319);
insert into boat values ('JPN', 4352,2021,40,'The Dying Gull','JPN',55667);
insert into boat values ('ISL', 346547,2021,40,'Empress','ISL',68904);
insert into boat values ('ISL', 848934,2021,40,'Wicked Wench','ISL',2000582);
insert into boat values ('ITA', 93287,2021,40,'Pirate Armada','ITA',2945190);
insert into boat values ('BRA', 28736,2021,40,'Jolly Roger','BRA',1046205);
insert into boat values ('GBR', 8367,2021,40,'The Barnacle','GBR',20566893);


--Populate Boat with VHF
insert into boat_vhf values ('ITA', 18293, 294826586);
insert into boat_vhf values ('PRT', 20586, 937573910);
insert into boat_vhf values ('AUS', 10083, 184794396);
insert into boat_vhf values ('CAN', 20956, 194739576);
insert into boat_vhf values ('GBR', 14296, 182958928);
insert into boat_vhf values ('ZAF', 49602, 120069305);

--Populate Schedule
insert into schedule values('2021-12-30','2022-01-06');
insert into schedule values('2021-12-30','2021-12-31');
insert into schedule values('2021-12-23','2021-12-26');
insert into schedule values('2021-12-30','2022-01-30');
insert into schedule values('2020-07-30','2020-08-10');
insert into schedule values('2022-08-10','2022-08-25');

--Populate Reservation
insert into reservation values('PRT',98237,'PRT',8435738,'2021-12-30','2022-01-06');
insert into reservation values('ARG',839,'ITA',23874876,'2021-12-30','2021-12-31');
insert into reservation values('PRT',23748,'AUS',89347874,'2021-12-30','2021-12-31');
insert into reservation values('AUS',23784,'JPN',2934729,'2021-12-30','2022-01-30');
insert into reservation values('ZAF',49602,'JPN',1220588,'2020-07-30','2020-08-10');
insert into reservation values('GBR', 14296,'CAN',38596665,'2022-08-10','2022-08-25');

--Populate Trip
-- maria joaquina vai n'o desconhecido numa reserva de 8 dias com 2 trips: tokyo-sidney e sidney-sao paulo
insert into trip values('2021-12-30',interval '1 day','PRT',98237,'PRT',8435738,'2021-12-30','2022-01-06', 35.652305, 139.761995,-33.860549, 151.211336);
insert into trip values('2021-12-31',interval '6 days','PRT',98237,'PRT',8435738,'2021-12-30','2022-01-06', -33.860549, 151.211336,-23.5506507,-46.6333824);
-- Luigi ferrari vai no El Rey numa reserva de 2 dias com 1 trip: naples-barcelona
insert into trip values('2021-12-30',interval '1 day','ARG',839,'ITA',23874876,'2021-12-30','2021-12-31', 40.839980,14.252540,41.385063,2.173404);
-- nicole kidman vai no El Hombre numa reserva de 2 dias com 1 trip: Reykjavik-Funchal
insert into trip values('2021-12-30',interval '1 day','PRT',23748,'AUS',89347874,'2021-12-30','2021-12-31', 64.128288,-21.827774,32.6496497,-16.9086783);
-- Fusajiro Yamauchi vai no the great numa reserva de 53 dias com 3 trips: NY-Aveiro, aveiro-cape town, cape town-adelaide
insert into trip values('2021-12-30',interval '2 days','AUS',23784,'JPN',2934729,'2021-12-30','2022-01-30', 40.703546, -74.006764,40.635114, -8.651154);
insert into trip values('2022-01-01',interval '10 days','AUS',23784,'JPN',2934729,'2021-12-30','2022-01-30',40.635114, -8.651154,-33.924870,18.424055);
insert into trip values('2022-01-11',interval '19 days','AUS',23784,'JPN',2934729,'2021-12-30','2022-01-30', -33.924870,18.424055,-34.9281805,138.5999312);
-- haruki murakami vai no seas the day durante 12 dias com duas trips: lisbon-funchal & adelaide-perth
insert into trip values('2020-07-30',interval '2 day','ZAF',49602,'JPN',1220588,'2020-07-30','2020-08-10', 38.705276,9.146657,32.6496497,-16.9086783);
insert into trip values('2020-08-05',interval '4 day','ZAF',49602,'JPN',1220588,'2020-07-30','2020-08-10', -34.9281805,138.5999312,-31.950527,115.860458);
-- armando stroll no boat Serendipity reserva de 15 dias com 4 trips: barcelona-lisboa, valencia-reykjavik, athens-kalamata & los angeles-san francisco
insert into trip values('2022-08-10',interval '3 day','GBR', 14296,'CAN',38596665,'2022-08-10','2022-08-25', 41.385063,2.173404,38.705276,9.146657);
insert into trip values('2022-08-13',interval '2 day','GBR', 14296,'CAN',38596665,'2022-08-10','2022-08-25', 28.521076,-81.465523,64.128288,-21.827774);
insert into trip values('2022-08-15',interval '2 day','GBR', 14296,'CAN',38596665,'2022-08-10','2022-08-25', 37.9839412,23.7283052,37.0377582,22.1109392);
insert into trip values('2022-08-20',interval '2 day','GBR', 14296,'CAN',38596665,'2022-08-10','2022-08-25', 33.738706, -118.266112,37.799968, -122.398026);

