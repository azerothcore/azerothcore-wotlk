-- DB update 2021_12_03_02 -> 2021_12_03_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_03_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_03_02 2021_12_03_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1638046780431340000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638046780431340000');

UPDATE `creature_template` SET `AiName`='', `ScriptName`='boss_kormok' WHERE `entry`=16118;
DELETE FROM `smart_scripts` WHERE `entryorguid`=16118 AND `source_type`=0;

DELETE FROM `creature_text` WHERE `creatureid`=16118;
INSERT INTO `creature_text` VALUES
(16118,0,0,'You think you can summon us? We are the ones that summon, not you! We bash you good for this and suck the marrow from your bones!',14,0,100,0,0,0,11968,0,'Kormok - Talk Summon'),
(16118,1,0,'You so little and puny... you no make good servants for Kormok!',12,0,100,0,0,0,11959,0,'Kormok - Talk Aggro'),
(16118,2,0,'%s becomes enraged!',16,0,100,0,0,0,10677,0,'Kormok - Enrage'),
(16118,3,0,'We am free! Thank you little, puny ones.',14,0,100,0,0,0,11873,0,'Kormok - Death');

UPDATE `spell_dbc` SET `Effect_1`=28, `EffectMiscValueB_1`=64 WHERE `ID` IN (27690,27691,27692,27693);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_03_03' WHERE sql_rev = '1638046780431340000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
