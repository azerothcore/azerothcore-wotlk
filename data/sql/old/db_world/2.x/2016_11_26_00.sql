-- DB update 2016_11_19_00 -> 2016_11_26_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS 
FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2016_11_19_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2016_11_19_00 2016_11_26_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1478948588825091300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world(`sql_rev`) VALUES ('1478948588825091300');

-- Mute for player
DELETE FROM trinity_string WHERE entry = 30000;
INSERT INTO trinity_string(`entry`,`content_default`,`content_loc6`,`content_loc7`,`content_loc8`) VALUES 
(30000, 'Speaking is allowed after playing for at least %d. You may use party and guild chat.','Podrás hablar cuando hayas jugado durante al menos %d. Puedes usar el chat de grupo y de hermandad.','Podrás hablar cuando hayas jugado durante al menos %d. Puedes usar el chat de grupo y de hermandad','Вы сможете говорить после %d проведенных минут в игре, но можете использовать чат гильдии и группы.');
--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
