INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641913700930614616');

-- Timbermaw Mystic and Timbermaw Woodbender, Timbermaw Hold, Felwood
UPDATE `creature` SET `Creature_id1`=11552,`Creature_id2`=11553, `chance_id1`=50 WHERE `guid` IN 
(39353,39354,39360,39685,39721);

-- Skeletal Horrors and Skeletal Fiends, Raven Hill, Duskwood
UPDATE `creature` SET `Creature_id1`=202,`Creature_id2`=531, `chance_id1`=50 WHERE `guid` IN 
(4927,4941,4943,4944,4945,4946,4969,4972,4973,4974,4993,5038,5039,5040,5041,5042,5043,5139,5140,5160,5163,5168,5176,5178,5942,5958,5959,5961);
