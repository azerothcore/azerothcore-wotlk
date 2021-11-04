-- DB update 2021_05_11_01 -> 2021_05_12_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_11_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_11_01 2021_05_12_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1620674399849229322'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620674399849229322');
UPDATE `item_template` SET `minMoneyLoot`=50, `maxMoneyLoot`=100 WHERE `entry`=20708; -- Tightly Sealed Trunk
UPDATE `item_template` SET `minMoneyLoot`=100, `maxMoneyLoot`=200 WHERE `entry` IN (
21113, -- Watertight Trunk
21150, -- Iron Bound Trunk
21228); -- Mithril Bound Trunk

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
