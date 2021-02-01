-- DB update 2018_12_28_00 -> 2018_12_29_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2018_12_28_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2018_12_28_00 2018_12_29_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1545780720578767600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO version_db_world (`sql_rev`) VALUES ('1545780720578767600');

DELETE FROM `creature_template_addon` WHERE `entry` = 27267;
INSERT INTO `creature_template_addon` (`entry`, `bytes1`, `bytes2`, `emote`) VALUES (27267, 0, 0, 233);
UPDATE `gossip_menu_option` SET `option_id` = 3, `npc_option_npcflag` = 128 WHERE `menu_id` = 9487;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
