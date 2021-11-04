-- DB update 2021_09_21_02 -> 2021_09_21_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_21_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_21_02 2021_09_21_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1631560059547242900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631560059547242900');

UPDATE `creature_template` SET `AIName`="", `ScriptName`="npc_sergeant_bly" WHERE `entry`=7604;
UPDATE `creature_template` SET `AIName`="", `ScriptName`="npc_weegli_blastfuse" WHERE `entry`=7607;
UPDATE `gameobject_template` SET `AIName`="", `ScriptName`="go_troll_cage" WHERE `entry` BETWEEN 141070 AND 141074;
UPDATE `creature_template` SET `AIName`="", `ScriptName`="npc_shadowpriest_sezziz" WHERE `entry`=7275;

DELETE FROM `gossip_menu_option` WHERE `MenuId` IN (940,941);
DELETE FROM `conditions` WHERE `Sourcetypeorreferenceid` IN (14,15) AND `SourceGroup` IN (940,941);

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (7604,7607,7275);
DELETE FROM `smart_scripts` WHERE `entryorguid` BETWEEN 760400 AND 760403;
DELETE FROM `smart_scripts` WHERE `entryorguid` BETWEEN 141070 AND 141074;

DELETE FROM `creature_summon_groups` WHERE `summonerId`=7604;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_21_03' WHERE sql_rev = '1631560059547242900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
