INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635944366683482486');

-- Add missing weapons to Gordunni npcs
DELETE FROM `creature_equip_template` WHERE `CreatureID` IN (5239,5234,5236,5240);
INSERT INTO `creature_equip_template` (`CreatureID`,`ID`,`ItemID1`,`ItemID2`,`ItemID3`,`VerifiedBuild`) VALUES
(5239,1,5304,0,0,0),
(5234,1,1903,2809,0,0),
(5236,1,1907,0,0,0),
(5240,1,2559,0,0,0);

-- Pathing was added to these spawns without setting bytes2
UPDATE `creature_addon` SET `bytes2`=1 WHERE `guid` IN (50242,50267,50213,50209,50228,50275);
