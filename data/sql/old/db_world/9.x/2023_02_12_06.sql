-- DB update 2023_02_12_05 -> 2023_02_12_06
--
DELETE FROM `smart_scripts` WHERE `entryorguid`=17695 AND `source_type`=0;
INSERT INTO `smart_scripts` VALUES
(17695,0,0,0,63,0,100,0,0,0,0,0,0,11,30991,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shattered Hand Assassin - On Create - Cast Stealth'),
(17695,0,1,0,21,0,100,0,0,0,0,0,0,11,30991,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shattered Hand Assassin - On Reached Home - Cast Stealth'),
(17695,0,2,0,11,0,100,0,0,0,0,0,0,8,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shattered Hand Assassin - On Reset - Set react defensive'),
(17695,0,3,0,4,0,100,0,0,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shattered Hand Assassin - On Aggro - Set react agressive'),
(17695,0,4,0,67,0,100,0,4500,6500,0,0,0,11,30992,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Shattered Hand Assassin - On Target Behind - Cast Backstab'),
(17695,0,5,0,0,0,100,0,8000,11000,22000,25000,0,11,36974,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Shattered Hand Assassin - In Combat - Cast Wound Poison'),
(17695,0,6,0,0,0,100,0,2000,4500,12000,20000,0,11,30981,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Shattered Hand Assassin - In Combat - Cast Crippling Poison'),
(17695,0,7,0,10,0,100,0,0,15,12000,15000,1,11,30980,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Shattered Hand Assassin - On Target Close - Cast Sap'),
(17695,0,8,0,10,0,100,0,0,8,4000,8000,0,11,30986,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Shattered Hand Assassin - On Target Close - Cast Cheap Shot'),
(17695,0,9,0,9,0,100,0,0,8,4000,8000,0,11,30986,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Shattered Hand Assassin - On Target Close - Cast Cheap Shot'),
(17695,0,10,0,6,0,100,512,0,0,0,0,0,45,5,5,0,0,0,0,11,16700,20,1,0,0,0,0,0,'Shattered Hand Assassin - On Death - Set Data');
