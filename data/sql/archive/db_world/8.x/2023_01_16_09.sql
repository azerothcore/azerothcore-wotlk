-- DB update 2023_01_16_08 -> 2023_01_16_09
--
DELETE FROM `smart_scripts` WHERE `entryorguid`=19779 AND `source_type`=0;
INSERT INTO `smart_scripts`  VALUES
(19779,0,0,0,0,0,100,0,0,0,2300,3900,0,11,36645,64,0,0,0,0,2,0,0,0,0,0,0,0,0,"Sunfury Geologist - In Combat CMC - Cast 'Throw Rock'"),
(19779,0,1,0,9,0,100,0,0,5,5000,9000,0,11,35918,32,0,0,0,0,2,0,0,0,0,0,0,0,0,"Sunfury Geologist - Within 0-5 Range - Cast 'Puncture Armor'"),
(19779,0,2,0,2,0,100,1,0,15,0,0,0,25,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"Sunfury Geologist - Between 0-15% Health - Flee For Assist (No Repeat)");
