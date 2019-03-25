-- DB update 2016_08_30_00 -> 2016_09_24_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2016_08_30_00 2016_09_24_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1473110802988536500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world(`sql_rev`) VALUES ('1473110802988536500');


-- Tyrannus Mount fix 

DELETE from creature_template where `entry` = 36794;
DELETE from creature_template_addon where entry = 36794;

INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) 
VALUES (36794, 0, 0, 0, 0, 0, 30277, 0, 0, 0, 'Scourgelord Tyrannus', '', '', 0, 82, 82, 2, 21, 0, 3, 3, 0.5, 1, 463, 640, 0, 726, 7.5, 2000, 0, 2, 832, 2048, 8, 0, 0, 0, 0, 0, 360, 520, 91, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 551, 0, 0, '', 0, 4, 1, 8, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, 'npc_pos_tyrannus_events', 12340);


INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
(36794, 0, 27982, 50331648, 1, 0, '');
--
-- END UPDATING QUERIES
--
COMMIT;
END;
//
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
