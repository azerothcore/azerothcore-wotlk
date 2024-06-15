-- DB update 2022_02_03_04 -> 2022_02_03_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_02_03_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_02_03_04 2022_02_03_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1643745379505594100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643745379505594100');
 /* Duplicate of 247673 */
DELETE FROM `creature` WHERE  `guid` = 247680;
 /* Duplicate of 247676 */
DELETE FROM `creature` WHERE  `guid` = 247684;
 /* Duplicate of 247678 */
DELETE FROM `creature` WHERE  `guid` = 247688;
 /* Duplicate of 247669 */
DELETE FROM `creature` WHERE  `guid` = 247687;
 /* Duplicate of 247668 */
DELETE FROM `creature` WHERE  `guid` = 247692;
 /* Duplicate of 247667 */
DELETE FROM `creature` WHERE  `guid` = 247689;
 /* Duplicate of 247670 */
DELETE FROM `creature` WHERE  `guid` = 247681;
 /* Duplicate of 247911 */
DELETE FROM `creature` WHERE  `guid` = 247922;
 /* Duplicate of 247912 */
DELETE FROM `creature` WHERE  `guid` = 247921;
 /* Duplicate of 247910 */
DELETE FROM `creature` WHERE  `guid` = 247916;
 /* Duplicate of 247918 */
DELETE FROM `creature` WHERE  `guid` = 247914;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_02_03_05' WHERE sql_rev = '1643745379505594100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
