-- DB update 2021_12_17_01 -> 2021_12_17_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_17_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_17_01 2021_12_17_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1639254587029816900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1639254587029816900');

DELETE FROM `spelldifficulty_dbc` WHERE `id` IN (63356, 63821, 63666, 62478, 62411);
INSERT INTO `spelldifficulty_dbc`(`id`, `DifficultySpellID_1`, `DifficultySpellID_2`) VALUES
(63356, 63356, 64003), -- Kologarn - Overhead Smash
(63821, 63821, 64001), -- Mimiron - Falling Rubble
(63666, 63666, 65026), -- Mimiron - Napalm Shell
(62478, 62478, 63512), -- Hodir - Frozen Blows
(62528, 62528, 62892), -- Freya - Touch of Eonar
(62411, 62411, 62413 /* Ancient Rune Giant (Thorim) - Stomp */);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_17_02' WHERE sql_rev = '1639254587029816900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
