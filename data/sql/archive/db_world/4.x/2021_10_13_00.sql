-- DB update 2021_10_12_03 -> 2021_10_13_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_12_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_12_03 2021_10_13_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1633950727186349900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633950727186349900');

-- Server-side spell 'Summon Darrowshire Poltergeinst (DND)'
UPDATE `spell_dbc` SET `Effect_1` = 28, `EffectMiscValueB_1` = 64 WHERE `id` = 17694;

-- Darrowshire Poltergeinst
SET @NPC_GHOST := 11296;

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = @NPC_GHOST;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 11296) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@NPC_GHOST, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Darrowshire Poltergeist - On Just Summoned - Say Line 0'),
(@NPC_GHOST, 0, 1, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 29, 5, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Darrowshire Poltergeist - On Just Summoned - Start Follow Owner Or Summoner');

DELETE FROM `creature_text` WHERE `CreatureId` = @NPC_GHOST;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(@NPC_GHOST, 0, 0, 'The Light must prevail!', 12, 0, 100, 0, 0, 0, 7209, 0, 'Darrowshire Poltergeist'),
(@NPC_GHOST, 0, 1, 'Captain Redpath! How could you forsake us?', 12, 0, 100, 0, 0, 0, 7212, 0, 'Darrowshire Poltergeist'),
(@NPC_GHOST, 0, 2, 'End our suffering!', 12, 0, 100, 0, 0, 0, 7205, 0, 'Darrowshire Poltergeist'),
(@NPC_GHOST, 0, 3, 'Oh, Darrowshire! I would give a thousand lives for you!', 12, 0, 100, 0, 0, 0, 7207, 0, 'Darrowshire Poltergeist'),
(@NPC_GHOST, 0, 4, 'You must save him!', 12, 0, 100, 0, 0, 0, 7206, 0, 'Darrowshire Poltergeist'),
(@NPC_GHOST, 0, 5, 'I was devoured by Horgus! I can still feel his teeth upon me!', 12, 0, 100, 0, 0, 0, 7211, 0, 'Darrowshire Poltergeist'),
(@NPC_GHOST, 0, 6, 'Beware Marduk! Beware, or your strength will wither.', 12, 0, 100, 0, 0, 0, 7210, 0, 'Darrowshire Poltergeist');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_13_00' WHERE sql_rev = '1633950727186349900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
