-- DB update 2020_12_18_02 -> 2020_12_19_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_12_18_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_12_18_02 2020_12_19_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1608331608234968600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1608331608234968600');

-- Update initial NPCs positions
UPDATE `creature` SET `position_x`=-6214.805, `position_y`=328.701, `position_z`=383.514, `orientation`=2.686 WHERE `guid`=351; -- Sten Stoutarm
UPDATE `creature` SET `position_x`=-3987.618, `position_y`=-13874.763, `position_z`=91.132, `orientation`=4.785 WHERE `guid`=57173; -- Megelon
UPDATE `creature` SET `position_x`=-606.627, `position_y`=-4251.340, `position_z`=38.957, `orientation`=3.175 WHERE `guid`=3442; -- Kaltunk
UPDATE `creature` SET `position_x`=1678.629, `position_y`=1667.528, `position_z`=135.827, `orientation`=3.534 WHERE `guid`=29803; -- Undertaker Mordo
UPDATE `creature` SET `position_x`=10357.584, `position_y`=-6369.816, `position_z`=36.141, `orientation`=2.321 WHERE `guid`=54984; -- Magistrix Erona


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
