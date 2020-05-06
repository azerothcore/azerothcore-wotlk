-- DB update 2017_02_03_43 -> 2017_02_03_44
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS 
FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_02_03_43';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_02_03_43 2017_02_03_44 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1486030596737432500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1486030596737432500');

DELETE FROM `creature_template` WHERE `entry` = "32322";
DELETE FROM `creature_template` WHERE `entry` = "32341";
DELETE FROM `creature_template` WHERE `entry` = "32321";
DELETE FROM `creature_template` WHERE `entry` = "32324";

UPDATE `creature` SET `spawndist`= "10", `MovementType` = "1" WHERE `guid` = "102313"; 
UPDATE `creature` SET `spawndist`= "10", `MovementType` = "1" WHERE `guid` = "102123";
UPDATE `creature` SET `spawndist`= "10",  `MovementType` = "1" WHERE `guid` = "103579";
UPDATE `creature` SET `spawndist`= "10", `MovementType` = "1" WHERE `guid` = "102063";

INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES 
(32322, 0, 0, 0, 0, 0, 27916, 27917, 27918, 0, 'Gold Warrior', '', '', 0, 70, 70, 0, 11, 0, 1, 1.14286, 1, 0, 252, 357, 0, 304, 1, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 0, 215, 320, 44, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 1, 0, 0, 'npc_dalaran_warrior', 12340),
(32341, 0, 0, 0, 0, 0, 27926, 27927, 0, 0, 'Gold Mage', '', '', 0, 70, 70, 2, 11, 0, 1, 1.14286, 1, 0, 248, 363, 0, 135, 1, 2000, 2000, 8, 0, 0, 0, 0, 0, 0, 0, 0, 233, 347, 28, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 1, 0, 0, 'npc_dalaran_mage', 12340),
(32321, 0, 0, 0, 0, 0, 27919, 27920, 27921, 0, 'Green Warrior', '', '', 0, 70, 70, 0, 85, 0, 1, 1.14286, 1, 0, 252, 357, 0, 304, 1, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 0, 215, 320, 44, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 1, 0, 0, 'npc_dalaran_warrior', 12340),
(32324, 0, 0, 0, 0, 0, 27928, 27929, 0, 0, 'Green Mage', '', '', 0, 70, 70, 2, 85, 0, 1, 1.14286, 1, 0, 248, 363, 0, 135, 1, 2000, 2000, 8, 0, 0, 0, 0, 0, 0, 0, 0, 233, 347, 28, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 1, 0, 0, 'npc_dalaran_mage', 12340);
--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
