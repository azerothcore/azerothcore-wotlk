-- DB update 2019_04_18_02 -> 2019_04_18_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_04_18_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_04_18_02 2019_04_18_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1555327481238291012'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1555327481238291012');

DELETE FROM `creature_text` WHERE `creatureid` = 22252;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`)
VALUES
(22252,0,0,'Me so hungry! YUM!',12,0,100,0,0,0,21120,0,'Dragonmaw Peon SAY_1'),
(22252,0,1,'It put the mutton in the stomach!',12,0,100,0,0,0,21121,0,'Dragonmaw Peon SAY_1'),
(22252,0,2,'Mmmm! FOOD!',12,0,100,0,0,0,21119,0,'Dragonmaw Peon SAY_1'),
(22252,0,3,'Time for eating?',12,0,100,0,0,0,21118,0,'Dragonmaw Peon SAY_1'),
(22252,1,0,'Hey...me not feel so good.',12,0,100,0,0,0,21122,0,'Dragonmaw Peon SAY_POISONED_1'),
(22252,1,1,'You is bad orc... baaad... or... argh!',12,0,100,0,0,0,21123,0,'Dragonmaw Peon SAY_POISONED_1');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
