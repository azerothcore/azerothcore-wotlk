-- DB update 2021_10_16_03 -> 2021_10_16_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_16_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_16_03 2021_10_16_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1634101865218672300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634101865218672300');

-- Summon Darrowsire Spirit
UPDATE `spell_dbc` SET `Effect_1` = 28, `EffectMiscValueB_1` = 64 WHERE `id` = 17310;

-- Cannibal Ghoul, Gibbering Ghoul, Diseased Flayer, Darrowshire Spirit
UPDATE `creature_template` SET `ScriptName` = '', `AIName` = 'SmartAI' WHERE `entry` IN (8530, 8531, 8532, 11064);

-- Darrowshire Spirit
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 11064);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11064, 0, 0, 0, 1, 0, 100, 0, 60000, 60000, 60000, 60000, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darrowshire Spirit - OOC - Despawn'),
(11064, 0, 1, 2, 11, 0, 100, 0, 0, 0, 0, 0, 0, 67, 1, 1000, 1000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darrowshire Spirit - On Reset - Create Timed Event 1'),
(11064, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 19, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darrowshire Spirit - On Reset - Remove Unit Flag Not selectable'),
(11064, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 11, 17327, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darrowshire Spirit - On Reset - Cast Spirit Particles'),
(11064, 0, 4, 5, 64, 0, 100, 1, 0, 0, 0, 0, 0, 33, 11064, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Darrowshire Spirit - On Gossip Hello - Kill Credit'),
(11064, 0, 5, 0, 61, 0, 100, 1, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darrowshire Spirit - On Gossip Hello - Despawn after 10 seconds'),
(11064, 0, 6, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 11, 17321, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darrowshire Spirit - On Timed Event - Cast Spirit Spawn-In');

-- Cannibal Ghoul
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 8530);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8530, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 11, 17310, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cannibal Ghoul - On Death - Cast Summon Darrowshire Spirit');

-- Gibbering Ghoul
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 8531);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8531, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 11, 17310, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gibbering Ghoul - On Death - Cast Summon Darrowshire Spirit'),
(8531, 0, 1, 0, 0, 0, 100, 0, 6000, 12000, 22000, 28000, 0, 11, 12889, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gibbering Ghoul - In Combat - Cast \'Curse of Tongues\'');

-- Diseased Flayer
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 8532);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8532, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 11, 17310, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Diseased Flayer - On Death - Cast Summon Darrowshire Spirit'),
(8532, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0,0, 11, 26047, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Diseased Flayer - On Respawn - Cast \'Birth\'');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_16_04' WHERE sql_rev = '1634101865218672300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
