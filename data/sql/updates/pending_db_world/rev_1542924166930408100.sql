INSERT INTO version_db_world (`sql_rev`) VALUES ('1542924166930408100');
DELETE FROM `creature_equip_template` WHERE `CreatureID`=4240 AND `ID`=1;
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`) VALUES (4240, 1, 35, 0, 0, 12340);
