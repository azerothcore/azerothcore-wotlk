INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636665257418709911');

-- Ancient creature_equip_template with item models, first found item with that model
UPDATE `creature_equip_template` SET `ItemID1`='1907', `ItemID2`='0' WHERE  `CreatureID`=3203 AND `ID`=1;

-- Vmangos
UPDATE `creature_equip_template` SET `ItemID1`='2177', `VerifiedBuild`='31727' WHERE  `CreatureID`=4667 AND `ID`=1;
