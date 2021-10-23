-- DB update 2021_07_11_00 -> 2021_07_12_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_11_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_11_00 2021_07_12_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1625841824336043500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625841824336043500');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 29414;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29414);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29414, 0, 0, 1, 25, 0, 100, 256, 0, 0, 0, 0, 0, 60, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bone Gryphon - On Reset - Set Fly On'),
(29414, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 207, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bone Gryphon - On Reset - Set hover 0'),
(29414, 0, 2, 0, 28, 0, 100, 0, 0, 0, 0, 0, 0, 11, 45472, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Bone Gryphon - On Passenger Removed - Cast \'Parachute\''),
(29414, 0, 3, 0, 1, 0, 100, 1, 300, 300, 0, 0, 0, 11, 54476, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bone Gryphon - Out of Combat - Cast \'Blood Presence\' (No Repeat)');

-- no use, spell removed
DELETE FROM `npc_spellclick_spells` WHERE  `npc_entry`=29414 AND `spell_id`=18277;

-- fix Radius: 3 yards
-- https://www.wowhead.com/spell=18277/call-bone-gryphon
DELETE FROM `spell_script_names` WHERE `spell_id`=18277 AND `ScriptName`='spell_onslaught_or_call_bone_gryphon';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (18277, 'spell_onslaught_or_call_bone_gryphon');

-- only aura fly
UPDATE `creature_template_addon` SET `auras` = '54422' WHERE (`entry` = 29414);

INSERT IGNORE INTO `spell_dbc` VALUES
(54469, 0, 3, 0, 16, 131584, 0, 262144, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 80, 80, 29, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 121, 6, 98, 1, 1, 1, 0, 0, 0, 1999, 549, 149, 0, 0, 0, 18, 18, 18, 16, 16, 16, 0, 0, 0, 0, 3, 0, 0, 3000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 127, 350, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11965, 0, 2719, 0, 50, 'Plague Strike', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 16712190, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 16712188, 'A vicious strike that deals talon damage plus $s1 modified by attack power and plagues the target, dealing $o2 Shadow damage over $d.  Only useful versus Onslaught Gryphon Riders.', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 16712190, 'Deals $o2 Shadow damage over $d.', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 16712190, 0, 133, 1500, 0, 0, 0, 0, 0, 0, 2, 2, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 32, 1102, 0, 0, 0, 0, 0, 0, 0);

-- Radius 5 Yards
-- I tested it with Knock Back (350), which is a very far distance. Therefore, I reduced it to 200
-- https://www.wowhead.com/spell=54469/plague-strike
UPDATE `spell_dbc` SET `EffectRadiusIndex_1`=8, `EffectRadiusIndex_2`=8, `EffectRadiusIndex_3`=8, `EffectMiscValue_3` = 200 WHERE  `ID`=54469;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_12_00' WHERE sql_rev = '1625841824336043500';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
