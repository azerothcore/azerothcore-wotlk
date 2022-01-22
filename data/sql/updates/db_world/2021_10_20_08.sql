-- DB update 2021_10_20_07 -> 2021_10_20_08
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_20_07';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_20_07 2021_10_20_08 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1633797104916104200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633797104916104200');

UPDATE `quest_template_addon` SET `RequiredMinRepFaction`=890 WHERE `id` IN (7863,7864,7865);
UPDATE `quest_template_addon` SET `RequiredMinRepFaction`=889 WHERE `id` IN (7866,7867,7868);
UPDATE `quest_template_addon` SET `RequiredMinRepFaction`=509 WHERE `id` IN (8260,8261,8262);
UPDATE `quest_template_addon` SET `RequiredMinRepFaction`=510 WHERE `id` IN (8263,8264,8265);

UPDATE `quest_template_addon` SET `RequiredMinRepValue`=3000 WHERE `id` IN (7863,7866,8260,8263);
UPDATE `quest_template_addon` SET `RequiredMinRepValue`=9000 WHERE `id` IN (7864,7867,8261,8264);
UPDATE `quest_template_addon` SET `RequiredMinRepValue`=21000 WHERE `id` IN (7865,7868,8262,8265);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_20_08' WHERE sql_rev = '1633797104916104200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
