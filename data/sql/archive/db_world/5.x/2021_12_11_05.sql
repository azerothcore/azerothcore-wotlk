-- DB update 2021_12_11_04 -> 2021_12_11_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_11_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_11_04 2021_12_11_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1638733183561519300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638733183561519300');

UPDATE `gameobject_template` SET `AIName`='' WHERE `entry`=190351;
DELETE FROM `smart_scripts` WHERE `entryorguid`=190351 AND `source_type`=1;
DELETE FROM `spell_scripts` WHERE `id`=50499;
INSERT INTO `spell_scripts` (`id`,`effIndex`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`) VALUES
(50499,0,0,15,50493,0,0,0,0,0,0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_11_05' WHERE sql_rev = '1638733183561519300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
