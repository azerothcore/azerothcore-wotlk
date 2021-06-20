-- DB update 2020_12_31_01 -> 2021_01_01_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_12_31_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_12_31_01 2021_01_01_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1609009225243254400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1609009225243254400');

UPDATE `gameobject` SET `spawntimesecs` = 2 WHERE `id` IN
(20691,  -- Cozzle's Footlocker
20925,   -- Captain's Footlocker
181110,  -- Soaked Tome
181133,  -- Rathis Tomber's Supplies
181238,  -- Dented Chest
181239,  -- Worn Chest
182011,  -- Crate of Ingots
182804,  -- Mysteries of the Light
183050,  -- The Saga of Terokk
126158,  -- Tallonkai's Dresser
187980); -- First Aid Supplies

-- Night Elf Plans: An'daroth, An'owyn, Scrying on the Sin'dorei
UPDATE `gameobject` SET `spawntimesecs` = 5 WHERE `id` IN (181138,181139,181140);
-- Sealed Box (Investigate Tuurem), Dawn Runner Cargo/Warped Crates
UPDATE `gameobject` SET `spawntimesecs` = 60 WHERE `id` IN (182542,181626);


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
