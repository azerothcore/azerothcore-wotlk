-- DB update 2022_03_09_00 -> 2022_03_09_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_09_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_09_00 2022_03_09_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1643946548773673200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643946548773673200');

DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_class_call_handler', 'spell_corrupted_totems', 'spell_class_call_polymorph', 'aura_class_call_wild_magic', 'aura_class_call_siphon_blessing', 'aura_class_call_berserk', 'spell_shadowblink');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(23410, 'spell_class_call_handler'), -- Mage
(23397, 'spell_class_call_handler'), -- Warrior
(23398, 'spell_class_call_handler'), -- Druid
(23401, 'spell_class_call_handler'), -- Priest
(23418, 'spell_class_call_handler'), -- Paladin
(23425, 'spell_class_call_handler'), -- Shaman
(23427, 'spell_class_call_handler'), -- Warlock
(23436, 'spell_class_call_handler'), -- Hunter
(23414, 'spell_class_call_handler'), -- Rogue
(23424, 'spell_corrupted_totems'),
(23603, 'spell_class_call_polymorph'),
(23410, 'aura_class_call_wild_magic'),
(23418, 'aura_class_call_siphon_blessing'),
(23397, 'aura_class_call_berserk'),
(22664, 'spell_shadowblink');

DELETE FROM `spell_target_position` WHERE `ID` IN (22668, 22669, 22670, 22671, 22672, 22673, 22674, 22675, 22676);
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`) VALUES
(22668, 0, 469, -7581.11, -1216.19, 476.800, 0),
(22669, 0, 469, -7561.54, -1244.01, 476.800, 0),
(22670, 0, 469, -7542.47, -1191.92, 476.355, 0),
(22671, 0, 469, -7538.63, -1273.64, 476.800, 0),
(22672, 0, 469, -7524.36, -1219.12, 476.794, 0),
(22673, 0, 469, -7506.58, -1165.26, 476.796, 0),
(22674, 0, 469, -7500.70, -1249.89, 476.798, 0),
(22675, 0, 469, -7486.36, -1194.32, 476.800, 0),
(22676, 0, 469, -7469.93, -1227.93, 476.777, 0);

DELETE FROM `waypoint_data` WHERE `id` = 11583;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(11583, 1, -7348.85, -1495.13, 552.515, 2.190162, 0, 2, 0, 100, 0),
(11583, 2, -7348.54, -1494.18, 552.515, 2.190162, 0, 2, 0, 100, 0),
(11583, 3, -7392.87, -1475.70, 544.619, 2.190162, 0, 2, 0, 100, 0),
(11583, 4, -7423.42, -1437.66, 535.314, 2.190162, 0, 2, 0, 100, 0),
(11583, 5, -7445.25, -1402.11, 523.842, 2.190162, 0, 2, 0, 100, 0),
(11583, 6, -7460.38, -1372.60, 513.092, 2.190162, 0, 2, 0, 100, 0),
(11583, 7, -7479.81, -1331.76, 498.759, 2.190162, 0, 2, 0, 100, 0),
(11583, 8, -7492.58, -1295.35, 488.091, 2.190162, 0, 2, 0, 100, 0),
(11583, 9, -7502.00, -1256.50, 476.758, 2.174731, 0, 2, 0, 100, 0);

UPDATE `creature_template_movement` SET `Flight` = 2 WHERE `CreatureID` = 11583;

UPDATE `creature_template` SET `unit_flags` = `unit_flags`|2|256|131072|33554432, `flags_extra` = `flags_extra`|128|256 WHERE `entry` = 14667;

UPDATE `creature_template` SET `unit_flags` = `unit_flags`|131072, `flags_extra` = `flags_extra`|1|256|16384|4194304, `mechanic_immune_mask`=`mechanic_immune_mask`|1|2|4|8|16|128|256|512|1024|2048|4096|8192|16384|65536|131072|4194304|8388608|33554432|67108864|536870912 , `ScriptName` = 'npc_corrupted_totem' WHERE `entry` IN (14662, 14663, 14664, 14666);

UPDATE `creature_template` SET `mingold` = 0, `maxgold` = 0 WHERE `entry` = 14668;

DELETE FROM `creature_loot_template` WHERE `entry` = 11583 AND `Item` = 19364;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_09_01' WHERE sql_rev = '1643946548773673200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
