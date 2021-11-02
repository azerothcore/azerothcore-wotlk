INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635884292065100734');

-- Add missing weapons to Burning Blade npcs
DELETE FROM `creature_equip_template` WHERE `CreatureID` IN (4663,4664,4665,4666,4667);
INSERT INTO `creature_equip_template` (`CreatureID`,`ID`,`ItemID1`,`ItemID2`,`ItemID3`,`VerifiedBuild`) VALUES
(4663,1,5303,0,0,0),
(4664,1,4991,0,0,0),
(4665,1,2559,0,0,0),
(4666,1,5285,5281,0,0),
(4667,1,xxxx,0,0,0);
