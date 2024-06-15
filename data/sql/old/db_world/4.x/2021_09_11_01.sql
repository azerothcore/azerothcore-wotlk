-- DB update 2021_09_11_00 -> 2021_09_11_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_11_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_11_00 2021_09_11_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1631031703375947799'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631031703375947799');

-- Adds Emperor Dagran Thaurissan to a formation as leader of the whole throne, so when pulled all will come to the aid
DELETE FROM `creature_formations` WHERE `leaderGUID` = 47613;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(47613, 47613, 300, 0, 1, 0, 0),
(47613, 47217, 300, 0, 2, 0, 0),
(47613, 47478, 300, 0, 1, 0, 0),
(47613, 47561, 300, 0, 1, 0, 0),
(47613, 47562, 300, 0, 1, 0, 0),
(47613, 47563, 300, 0, 1, 0, 0),
(47613, 47564, 300, 0, 1, 0, 0),
(47613, 47565, 300, 0, 1, 0, 0),
(47613, 47566, 300, 0, 1, 0, 0),
(47613, 47568, 300, 0, 1, 0, 0),
(47613, 47569, 300, 0, 1, 0, 0),
(47613, 47586, 300, 0, 1, 0, 0),
(47613, 47587, 300, 0, 1, 0, 0),
(47613, 47588, 300, 0, 1, 0, 0),
(47613, 47589, 300, 0, 1, 0, 0),
(47613, 47590, 300, 0, 1, 0, 0),
(47613, 47591, 300, 0, 1, 0, 0),
(47613, 47592, 300, 0, 1, 0, 0),
(47613, 47593, 300, 0, 1, 0, 0),
(47613, 47594, 300, 0, 1, 0, 0),
(47613, 47595, 300, 0, 1, 0, 0),
(47613, 47598, 300, 0, 1, 0, 0),
(47613, 47599, 300, 0, 1, 0, 0),
(47613, 47601, 300, 0, 1, 0, 0),
(47613, 47602, 300, 0, 1, 0, 0),
(47613, 47603, 300, 0, 1, 0, 0),
(47613, 47606, 300, 0, 1, 0, 0),
(47613, 47611, 300, 0, 1, 0, 0),
(47613, 47612, 300, 0, 1, 0, 0),
(47613, 90596, 300, 0, 1, 0, 0),
(47613, 90597, 300, 0, 1, 0, 0),
(47613, 90598, 300, 0, 1, 0, 0),
(47613, 90599, 300, 0, 1, 0, 0),
(47613, 90600, 300, 0, 1, 0, 0),
(47613, 90601, 300, 0, 1, 0, 0),
(47613, 90602, 300, 0, 1, 0, 0),
(47613, 90603, 300, 0, 1, 0, 0),
(47613, 90604, 300, 0, 1, 0, 0),
(47613, 90605, 300, 0, 1, 0, 0),
(47613, 90606, 300, 0, 1, 0, 0),
(47613, 90607, 300, 0, 1, 0, 0),
(47613, 90608, 300, 0, 1, 0, 0),
(47613, 90609, 300, 0, 1, 0, 0),
(47613, 90610, 300, 0, 1, 0, 0),
(47613, 90611, 300, 0, 1, 0, 0),
(47613, 90612, 300, 0, 1, 0, 0),
(47613, 90613, 300, 0, 1, 0, 0),
(47613, 90614, 300, 0, 1, 0, 0),
(47613, 90615, 300, 0, 1, 0, 0),
(47613, 90616, 300, 0, 1, 0, 0),
(47613, 90617, 300, 0, 1, 0, 0),
(47613, 90618, 300, 0, 1, 0, 0),
(47613, 90619, 300, 0, 1, 0, 0),
(47613, 90620, 300, 0, 1, 0, 0),
(47613, 90621, 300, 0, 1, 0, 0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_11_01' WHERE sql_rev = '1631031703375947799';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
