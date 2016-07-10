/*Table structure for table `guildhouses` */
CREATE TABLE `guildhouses` (
  `id` int(16) unsigned NOT NULL AUTO_INCREMENT,
  `guildId` bigint(20) NOT NULL DEFAULT '0',
  `x` double NOT NULL,
  `y` double NOT NULL,
  `z` double NOT NULL,
  `map` int(16) NOT NULL,
  `comment` varchar(255) NOT NULL DEFAULT '',
  `price` bigint(20) NOT NULL DEFAULT '0',
  `faction` int(8) unsigned NOT NULL DEFAULT '3',
  `minguildsize` int(16) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Table structure for table `guildhouses_add` */
CREATE TABLE `guildhouses_add` (
  `guid` int(32) unsigned NOT NULL,
  `type` int(16) unsigned NOT NULL,
  `id` int(16) unsigned NOT NULL,
  `add_type` int(16) unsigned NOT NULL,
  `comment` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`guid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Table structure for table `guildhouses_addtype` */
CREATE TABLE `guildhouses_addtype` (
  `add_type` int(16) unsigned NOT NULL,
  `comment` varchar(255) NOT NULL DEFAULT '',
  `price` bigint(20) NOT NULL DEFAULT '1000',
  `minguildsize` int(16) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`add_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;


TRUNCATE table guildhouses;
TRUNCATE table guildhouses_addtype;

/*
-- Query: SELECT * FROM old_trilogy_world.guildhouses_addtype
LIMIT 0, 1000

-- Date: 2014-05-24 13:00
*/
INSERT INTO `guildhouses_addtype` (`add_type`,`comment`,`price`,`minguildsize`) VALUES (2,'Guardia',8000,30);
INSERT INTO `guildhouses_addtype` (`add_type`,`comment`,`price`,`minguildsize`) VALUES (3,'oggetti lavori',1500,30);
INSERT INTO `guildhouses_addtype` (`add_type`,`comment`,`price`,`minguildsize`) VALUES (4,'pvp',1000,30);
INSERT INTO `guildhouses_addtype` (`add_type`,`comment`,`price`,`minguildsize`) VALUES (5,'manichini',1500,30);
INSERT INTO `guildhouses_addtype` (`add_type`,`comment`,`price`,`minguildsize`) VALUES (6,'vendor',2500,30);
INSERT INTO `guildhouses_addtype` (`add_type`,`comment`,`price`,`minguildsize`) VALUES (7,'vendor speciali',4000,30);
INSERT INTO `guildhouses_addtype` (`add_type`,`comment`,`price`,`minguildsize`) VALUES (8,'extra',6500,30);
INSERT INTO `guildhouses_addtype` (`add_type`,`comment`,`price`,`minguildsize`) VALUES (9,'Custom NPC',8500,30);


/*
-- Query: SELECT * FROM old_trilogy_world.guildhouses
LIMIT 0, 1000

-- Date: 2014-05-24 12:59
*/
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (1,0,-8648.165,-536.4996,145.3925,0,'guildhouses media, elwyn forest, alleanza',45000,0,10000);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (2,36,-12188.07,-2470.23,-0.94,0,'guildhouses media, blastedlands the Tainted Scar, entrambe le fazioni',45000,3,130);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (3,176,-3900.1,-1633.4,132.9,0,'Torre grande, wetland, alleanza',90000,0,200);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (4,0,-9248.7,-3286.8,18.7,1,'guildhouse media, tanaris,alleanza,\"it s PVP, man\"',45000,0,130);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (5,0,-9265.4,-3447,9.6,1,'guildhouse media, tanaris,orda,\"it s PVP, man\"',45000,1,130);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (7,125,4454.6,-3252,1022.7,1,'Torre grande, hyjal, entrambe le fazioni',90000,3,200);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (8,432,-5371.08,-1932.1,87.22,1,'guildhouse media, thousand needles, orda',45000,1,130);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (9,26,-2263.09,-1903.57,3.13,0,'guildhouses media, Arathi Highlands, entrambe le fazioni, \"We are pirates\" ',45000,3,130);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (10,110,-14413.1,689.8,22,0,'guildhouses piccola, booty bay, entrambe le fazioni',20000,3,100);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (11,28,1379.1,-2573.5,101.5,0,'guildhouses piccola, cripta, entrambe le fazioni',20000,3,100);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (12,0,-4682.5,2565.46,12.13,1,'Nave media, ferelas, alleanza',45000,0,130);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (13,420,755.1,-1197.6,134.2,1,'guildhouses media, the barrens, entrambe le fazioni',45000,3,130);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (14,65,2887.22,2452.4,142.83,1,'guildhouses grande, Stonetalon Mountains, orda',90000,1,200);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (15,162,2833.9,2285.39,203.1,1,'guildhouses grande, Stonetalon Mountains, alleanza',90000,0,200);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (16,46,-3145.19,2407.47,254.65,1,'guildhouses media, Feralas, entrambe le fazioni',45000,3,130);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (17,131,4300.91,-2761.449,16.99949,0,'guildhouses grande, entrambe le fazioni, Vista Mare e Monti in stile elfico',90000,3,200);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (18,165,-11365.9,-4713.16,6.16,1,'guildhouses grande, south sea (north isle), entrambe le fazioni',90000,3,200);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (19,313,-11816.24,-4752.8,7,1,'guildhouses grande, south sea (south isle), entrambe le fazioni',90000,3,200);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (20,0,-118164.306,-4592.868,6,1,'TEST,guildhouses grande, south sea, entrambe le fazioni',90000,1,10000);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (21,331,-1555.7,-5318.3,9.1,1,'guildhouses piccola, Echo Isle, orda',20000,1,100);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (22,56,-10733.99,2475.02,6.9,1,'guildhouses grande, silithus, entrambe le fazioni',90000,3,200);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (23,252,-5.577,2222.9243,92.5885,1,'Torre grande orda desolace',90000,1,200);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (24,485,-866.918213,609.997559,177.067322,1,'Torre media orda mulgore',45000,1,20);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (25,0,-913.51,1569.93,44.2,0,'guildhouses grande, Silverpine, entrambe le fazioni',90000,3,10000);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (26,434,1034.514648,-600.811523,118.950165,1,'guildhouses grande,Stonetalon Mountains Windshear Crag, entrambe le fazioni',90000,3,200);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (27,177,-6614.616699,-3903.610352,378.108459,0,'guildhouses media,Badlands Lethlor Ravine, entrambe le fazioni',45000,3,130);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (28,402,-1055.45459,1871.579956,4.497165,0,'guildhouses media,Silverpine Forest South Tide Run, entrambe le fazioni',45000,3,130);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (29,306,3239.046387,2571.091797,7.092238,1,'guildhouses piccola,Ashenvale The Zoram Strand Run, entrambe le fazioni',30000,3,100);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (30,0,5663.133789,-5791.158203,2.982471,1,'Guildhouses piccola, barca,Azshara  The Great Sea, entrambe le fazioni',30000,3,100);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (31,380,-2222.316162,1170.33618,147.383835,1,'guildhouses grande, Kodo Graveyard, entrambe le fazioni',90000,3,200);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (32,356,-9622.33,-1828.26,2.77,1,'guildhouse grande, orda, Land\'s End Beach',90000,1,200);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (33,127,3879.2612,-4465.727,341.1039,1,'guildhouse piccola, entrambe le fazioni, Azshara',30000,3,100);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (34,276,-5743.194,3806.16,0.7238,1,'guildhouse media, entrambe le fazioni, Isle of dread',45000,3,130);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (35,183,-8230.453,-101.289,236.072,0,'guildhouse media, Alliance, Elwynn Forest',45000,0,130);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (36,17,-2925.269,38.0056,189.911,1,'guildhouse grande, orda, Mulgore',90000,1,200);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (37,11,-5060.444,1428.32,480.62,0,'guildhouses grande, The Great Sea in montagna e innevata, alleanza',90000,0,200);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (38,272,-6402.62,-648.83,440.89,0,'guildhouse media, torre per entrambe le fazioni, Searing Gorge,con neve',45000,3,130);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (39,179,-5366.34,-2539.78,484.63,0,'guildhouse piccola in montagna,entrambe le fazioni, Dun Morogh D.I.S.C.O.',30000,3,100);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (40,483,-6363.04,-2086.41,-191.33,1,'guildhouse media,entrambe le fazioni, accampamento un\'Goro Crater ',45000,3,130);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (41,181,-2627.34,2849.11,172.26,1,'guildhouse media,entrambe le fazioni, Ruins of Ravenwind',45000,3,130);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (42,173,-2840.2,3185.94,2.53,1,'guildhouse media,entrambe le fazioni, the forgotten coast con nave',45000,3,130);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (43,0,-6281.45,-68.36,471.42,0,'guildhouse media,entrambe le fazioni, Searing Gorge fenice ',45000,3,130);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (44,458,-7427.34,-2031.89,313.73,0,'guildhouse media,entrambe le fazioni, Burning Steppes refuge',45000,3,130);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (45,55,3990.5,-3927.86,533.23,1,'guildhouse media,entrambe le fazioni, Winterspring PvP Area',45000,3,130);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (46,316,2442.91,-3891.87,273.23,1,'guildhouse piccola,Azshara, dog lovers',30000,3,100);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (47,0,2176.2,-3969.32,341.04,1,'guildhouse media,Durotar/Azshara Tower, ',45000,3,130);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (48,233,-12224.12,-3743.33,23.27,0,'guildhouse media,entrambe le fazioni, Forbidding Sea - ship -',45000,3,130);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (49,446,2017.6,-3851.77,224.72,1,'guildhouse media,entrambe le fazioni, Durotar Flower',45000,3,130);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (50,358,-7046.87,-3774.95,310.17,0,'guildhouse piccola, badlands, accampamento',30000,3,100);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (51,466,-4844.25,-2169.31,524.12,0,'guildhouse media,entrambe le fazioni, North Gate White Snow',45000,3,130);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (52,0,-4357.99,-646.75,166.37,0,'guildhouse media,entrambe le fazioni, Wetlands picnic zone',45000,3,130);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (53,0,4276.58,-4848.05,529.85,1,'guildhouse media,entrambe le fazioni, Rifugio tra la neve',45000,3,130);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (54,0,-9818.605469,-3614.977051,9.697815,1,'guildhouse grande,entrambe le fazioni,Tanaris, Tutti al mare',90000,0,10000);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (55,270,2891.46,-4766.68,250.9,1,'guildhouses grande,Azshara Crater, Forlorn Ridge , alleanza',90000,3,200);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (56,201,-2229.16,2829.45,144.68,1,'guildhouses grande, desolance, tutti sotto un tetto, entrambe fazioni',90000,3,200);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (57,0,-2398.3,2486.88,136.29,1,'guildhouses media, desolance, accampamento tra le montagne, entrambe le fazioni',45000,3,130);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (58,422,-841.19,2556.83,164.07,1,'guildhouses piccola, desolance, per chi beve in compagnia..., entrambe le fazioni',30000,3,100);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (59,147,-5903.771484,840.4021,485.761658,0,'guildhouses grande, Dun Morogh, torre Wintergrasp entrambe le fazioni',90000,3,200);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (60,0,-2621.07,-2163,167.8,0,'guildhouses piccola,Wetlands, Dun Modr, Entrambe le fazioni, molto caratteristica',30000,3,10000);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (61,209,-4984.85,-1330.76,714.67,0,'guildhouses grande, Dun Morogh, ampissimi spazi su montagna innevata! Entrambe fazioni',90000,3,200);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (62,391,-814.71,801.78,166.62,0,'guildhouses grande, Hillsbrad foothills, entrambe le fazioni! Immersa nella pace e nel verde! Almeno a una prima occhiata...',90000,3,200);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (63,237,-9818.605469,-3614.977051,9.697815,1,'guildhouses grande, desolance, tutti al mare, ally',90000,0,300);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (64,431,-10224.275391,125.416061,164.626068,1,'guildhouses grande, the veiled sea, entrambe le fazioni',90000,3,200);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (65,415,-1861.353394,-4150.701172,9.289291,0,'guildhouse grande, Ally, \"che ne sai tu di un campo di grano!\"',90000,0,200);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (66,440,-1713.72998,-10391.5,3.66941,530,'guildhouses grande, \"L\'olandese volante\", alliance',90000,0,200);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (67,0,-13017.33,-2198.73,9.11,0,'guildhouses grande, Forbidding Sea, Dark Battleship orda',90000,1,2000);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (68,467,-11771.16,-3635.3,86.49,0,'guildhouses grande, Twin Towers PvP orda',90000,1,200);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (69,0,-11702.06,-3557.83,86.5,0,'guildhouses grande, Twin Towers PvP ally',90000,0,200);
INSERT INTO `guildhouses` (`id`,`guildId`,`x`,`y`,`z`,`map`,`comment`,`price`,`faction`,`minguildsize`) VALUES (70,335,-11528.83,-2436.15,87.92,0,'guildhouses grande, Red or Black? entrambe le fazioni',90000,3,200);




CREATE TABLE `custom_npc_tele_association` (
  `cat_id` double DEFAULT NULL,
  `dest_id` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `custom_npc_tele_category` (
  `id` double DEFAULT NULL,
  `name` varchar(2295) DEFAULT NULL,
  `flag` tinyint(3) DEFAULT NULL,
  `data0` double DEFAULT NULL,
  `data1` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `custom_npc_tele_destination` (
  `id` double DEFAULT NULL,
  `name` varchar(900) DEFAULT NULL,
  `pos_X` float DEFAULT NULL,
  `pos_Y` float DEFAULT NULL,
  `pos_Z` float DEFAULT NULL,
  `map` double DEFAULT NULL,
  `orientation` float DEFAULT NULL,
  `level` tinyint(3) DEFAULT NULL,
  `cost` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

TRUNCATE table `custom_npc_tele_association` ;
TRUNCATE table `custom_npc_tele_category` ;
TRUNCATE table `custom_npc_tele_destination` ;

INSERT INTO `custom_npc_tele_category` (`id`,`name`,`flag`,`data0`,`data1`) VALUES (1,'[Instances Lvl 1-60]',0,0,0);
INSERT INTO `custom_npc_tele_category` (`id`,`name`,`flag`,`data0`,`data1`) VALUES (2,'[Instances Lvl 70+]',5,70,0);

INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,1);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,2);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,3);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,4);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,5);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,6);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,7);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,8);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,9);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,10);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,11);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,12);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,13);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,14);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,15);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,16);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,17);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,18);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,19);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,20);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,21);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (2,22);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (2,23);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (2,24);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (2,25);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (2,26);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (2,27);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (2,28);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (2,53);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (2,29);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,30);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,31);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,32);

INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (1,'Blackfathom Deeps',4254.58,664.74,-29.04,1,1.97,20,2);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (2,'Blackrock Depths',-7301.03,-913.19,165.37,0,0.08,55,5);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (3,'Blackrock Spire',-7535.43,-1212.04,285.45,0,5.29,58,5);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (4,'Blackwing Lair',-7665.55,-1102.49,400.679,469,0,60,5);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (5,'Maraudon',-1433.33,2955.34,96.21,1,4.82,43,5);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (6,'Molten Core',1121.45,-454.317,-101.33,230,3.5,60,5);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (7,'Naxxramas',3125.18,-3748.02,136.049,0,0,80,15);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (8,'Onyxia\'s Lair',-4707.44,-3726.82,54.6723,1,3.8,80,15);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (9,'Razorfen Downs',-4645.08,-2470.85,85.53,1,4.39,33,2);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (10,'Razorfen Kraul',-4484.04,-1739.4,86.47,1,1.23,25,2);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (11,'Ruins of Ahn\'Qiraj',-8409.03,1498.83,27.3615,1,2.49757,60,5);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (12,'Scholomance',1219.01,-2604.66,85.61,0,0.5,58,5);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (13,'Shadowfang Keep',-254.47,1524.68,76.89,0,1.56,18,2);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (14,'Stratholme',3263.54,-3379.46,143.59,0,0,58,5);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (15,'Temple of Ahn\'Qiraj',-8245.84,1983.74,129.072,1,0.936195,60,5);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (16,'The Deadmines',-11212,1658.58,25.67,0,1.45,15,2);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (17,'The Scarlet Monastery',2843.89,-693.74,139.32,0,5.11,34,2);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (18,'The Sunken Temple',-10346.9,-3851.9,-43.41,0,6.09,49,5);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (19,'The Wailing Caverns',-722.53,-2226.3,16.94,1,2.71,15,2);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (20,'Zul\'Farrak',-6839.39,-2911.03,8.87,1,0.41,43,5);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (21,'Zul\'Gurub',-11916.7,-1212.82,92.2868,0,4.6095,60,5);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (22,'Black Temple',-3610.72,324.988,37.4,530,3.28298,70,10);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (23,'Coilfang Reservoir',517.288,6976.28,32.0072,530,0,62,10);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (24,'Gruul\'s Lair',3539.01,5082.36,1.69107,530,0,70,10);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (25,'Hellfire Citadel',-305.816,3056.4,-2.47318,530,2.01,60,5);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (26,'Isle Of Quel\'Danas',12947.4,-6893.31,5.68398,530,3.09154,70,10);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (27,'Karazhan',-11118.8,-2010.84,47.0807,0,0,70,10);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (28,'Tempest Keep',3089.58,1399.05,187.653,530,4.79407,70,10);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (29,'Zul\'Aman',6846.95,-7954.5,170.028,530,4.61501,70,10);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (30,'Dire Maul',-3960.9,1129.01,162,1,0,55,5);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (31,'Gnomeregan',-5165.83,910.62,258,0,0,24,2);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (32,'Uldaman',-6156.02,-2952.88,211,0,0,36,2);

