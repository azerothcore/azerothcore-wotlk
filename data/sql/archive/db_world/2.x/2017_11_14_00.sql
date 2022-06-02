-- DB update 2017_10_17_02 -> 2017_11_14_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_10_17_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_10_17_02 2017_11_14_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1509271997120618300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1509271997120618300');

-- Quest: A Suitable Test Subject (11719)
DELETE FROM `spell_script_names` WHERE `ScriptName`="spell_q11719_bloodspore_ruination_45997";
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(45997, "spell_q11719_bloodspore_ruination_45997");

UPDATE `creature_template` SET `ScriptName`="npc_bloodmage_laurith" WHERE `entry`=25381;

DELETE FROM `creature_text` WHERE `entry`=25381;
INSERT INTO `creature_text` (`entry`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(25381, 0, 0, "How positively awful! You were totally incapacitated? Weak? Hot flashes?", 15, 0, 100, 21, 0, 0, 24992, 0, "Bloodmage Laurith");--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
