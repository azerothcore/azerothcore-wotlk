-- DB update 2020_12_13_02 -> 2020_12_13_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_12_13_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_12_13_02 2020_12_13_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1606921345291246500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1606921345291246500');

-- update general tables
DELETE FROM `broadcast_text` WHERE `id` IN (100003, 100004, 100005);
INSERT INTO `broadcast_text` (`ID`, `Language`, `MaleText`, `FemaleText`, `EmoteID0`, `EmoteID1`, `EmoteID2`, `EmoteDelay0`, `EmoteDelay1`, `EmoteDelay2`, `SoundId`, `Unk1`, `Unk2`, `VerifiedBuild`)VALUES 
(100003, 0, 'Mooooo...', '', 5, 0, 0, 0, 0, 0, 0, 0, 1, 18019),
(100004, 0, 'Moooooooooo!', '', 5, 0, 0, 0, 0, 0, 0, 0, 1, 18019),
(100005, 0, 'Thank you for bringing back my Bessy, $N. I couldn\'t live without her!', '', 5, 0, 0, 0, 0, 0, 0, 0, 1, 18019);

-- update Bessy & Thadell messages
DELETE FROM `creature_text` WHERE `creatureId` IN (20415, 20464);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `id`, `text`, `type`, `language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(20415, 0, 0, 'Mooooo...', 12, 0, 100, 0, 0, 0, 100003, 0, 'Bessy calmly moo when quest starts'),
(20415, 1, 0, 'Moooooooooo!', 12, 0, 100, 0, 0, 0, 100004, 0, 'Bessy angry moo when being attacked'),
(20464, 2, 0, 'Bessy, you''re home. Thank the Light!', 12, 0, 100, 0, 0, 0, 18181, 0, 'Thadell say to Bessy'),
(20464, 3, 0, 'Thank you for bringing back my Bessy, $N. I couldn\'t live without her!', 12, 0, 100, 0, 0, 0, 100005, 0, 'Thadell say to player');


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
