-- DB update 2020_04_17_01 -> 2020_04_17_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_04_17_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_04_17_01 2020_04_17_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1584389363968563900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1584389363968563900');

UPDATE `quest_offer_reward` SET `RewardText`= 'This... this pendant.  I gave it to Old Whitebark after his people helped us rebuild our village.$B$BI guess this means he''s...$B$B<The blood elf clears her throat as she regains her composure.>$B$BI appreciate you bringing this to me, $N.  There is something I''d like to ask of you.' WHERE `ID`=8474;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
