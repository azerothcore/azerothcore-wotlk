-- DB update 2019_02_10_00 -> 2019_02_11_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_02_10_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_02_10_00 2019_02_11_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1549780782164153600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1549780782164153600');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=1 AND `SourceGroup`=7523 AND `SourceEntry`=21936 AND `SourceId`=0 AND `ElseGroup`=0 AND `ConditionTypeOrReference`=30 AND `ConditionTarget`=0 AND `ConditionValue1`=181057 AND `ConditionValue2`=15 AND `ConditionValue3`=0;
INSERT INTO `conditions` VALUES (1, 7523, 21936, 0, 0, 30, 0, 181057, 15, 0, 0, 0, 0, '', 'Frozen Ectoplasm can only be looted if Object Ectoplasmic Distiller is withing 15 yd');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=1 AND `SourceGroup`=7524 AND `SourceEntry`=21936 AND `SourceId`=0 AND `ElseGroup`=0 AND `ConditionTypeOrReference`=30 AND `ConditionTarget`=0 AND `ConditionValue1`=181057 AND `ConditionValue2`=15 AND `ConditionValue3`=0;
INSERT INTO `conditions` VALUES (1, 7524, 21936, 0, 0, 30, 0, 181057, 15, 0, 0, 0, 0, '', 'Frozen Ectoplasm can only be looted if Object Ectoplasmic Distiller is withing 15 yd');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=1 AND `SourceGroup`=8538 AND `SourceEntry`=21935 AND `SourceId`=0 AND `ElseGroup`=0 AND `ConditionTypeOrReference`=30 AND `ConditionTarget`=0 AND `ConditionValue1`=181057 AND `ConditionValue2`=15 AND `ConditionValue3`=0;
INSERT INTO `conditions` VALUES (1, 8538, 21935, 0, 0, 30, 0, 181057, 15, 0, 0, 0, 0, '', 'Stable Ectoplasm can only be looted if Object Ectoplasmic Distiller is withing 15 yd');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=1 AND `SourceGroup`=8539 AND `SourceEntry`=21935 AND `SourceId`=0 AND `ElseGroup`=0 AND `ConditionTypeOrReference`=30 AND `ConditionTarget`=0 AND `ConditionValue1`=181057 AND `ConditionValue2`=15 AND `ConditionValue3`=0;
INSERT INTO `conditions` VALUES (1, 8539, 21935, 0, 0, 30, 0, 181057, 15, 0, 0, 0, 0, '', 'Stable Ectoplasm can only be looted if Object Ectoplasmic Distiller is withing 15 yd');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=1 AND `SourceGroup`=8540 AND `SourceEntry`=21935 AND `SourceId`=0 AND `ElseGroup`=0 AND `ConditionTypeOrReference`=30 AND `ConditionTarget`=0 AND `ConditionValue1`=181057 AND `ConditionValue2`=15 AND `ConditionValue3`=0;
INSERT INTO `conditions` VALUES (1, 8540, 21935, 0, 0, 30, 0, 181057, 15, 0, 0, 0, 0, '', 'Stable Ectoplasm can only be looted if Object Ectoplasmic Distiller is withing 15 yd');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=1 AND `SourceGroup`=8541 AND `SourceEntry`=21935 AND `SourceId`=0 AND `ElseGroup`=0 AND `ConditionTypeOrReference`=30 AND `ConditionTarget`=0 AND `ConditionValue1`=181057 AND `ConditionValue2`=15 AND `ConditionValue3`=0;
INSERT INTO `conditions` VALUES (1, 8541, 21935, 0, 0, 30, 0, 181057, 15, 0, 0, 0, 0, '', 'Stable Ectoplasm can only be looted if Object Ectoplasmic Distiller is withing 15 yd');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=1 AND `SourceGroup`=8542 AND `SourceEntry`=21935 AND `SourceId`=0 AND `ElseGroup`=0 AND `ConditionTypeOrReference`=30 AND `ConditionTarget`=0 AND `ConditionValue1`=181057 AND `ConditionValue2`=15 AND `ConditionValue3`=0;
INSERT INTO `conditions` VALUES (1, 8542, 21935, 0, 0, 30, 0, 181057, 15, 0, 0, 0, 0, '', 'Stable Ectoplasm can only be looted if Object Ectoplasmic Distiller is withing 15 yd');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=1 AND `SourceGroup`=12178 AND `SourceEntry`=21937 AND `SourceId`=0 AND `ElseGroup`=0 AND `ConditionTypeOrReference`=30 AND `ConditionTarget`=0 AND `ConditionValue1`=181057 AND `ConditionValue2`=15 AND `ConditionValue3`=0;
INSERT INTO `conditions` VALUES (1, 12178, 21937, 0, 0, 30, 0, 181057, 15, 0, 0, 0, 0, '', 'Scorched Ectoplasm can only be looted if Object Ectoplasmic Distiller is withing 15 yd');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=1 AND `SourceGroup`=12179 AND `SourceEntry`=21937 AND `SourceId`=0 AND `ElseGroup`=0 AND `ConditionTypeOrReference`=30 AND `ConditionTarget`=0 AND `ConditionValue1`=181057 AND `ConditionValue2`=15 AND `ConditionValue3`=0;
INSERT INTO `conditions` VALUES (1, 12179, 21937, 0, 0, 30, 0, 181057, 15, 0, 0, 0, 0, '', 'Scorched Ectoplasm can only be looted if Object Ectoplasmic Distiller is withing 15 yd');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
