-- DB update 2021_06_03_00 -> 2021_06_04_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_03_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_03_00 2021_06_04_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1622268692168409196'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622268692168409196');

-- Cave Creeper -> removes Lefty's Brass Knuckle
DELETE FROM `creature_loot_template` WHERE `Entry` = 8933 AND `Item` = 22317;
-- Borer Beetle -> removes Shroud of Arcane Mastery 
DELETE FROM `creature_loot_template` WHERE `Entry` = 8932 AND `Item` = 22330;
-- Dark Screecher -> removes Lefty's Brass Knuckle, Malgen's Long Bow
DELETE FROM `creature_loot_template` WHERE `Entry` = 8927 AND `Item` IN (22317, 22318); 
-- Deep Stinger -> removes Ironweave Mantle
DELETE FROM `creature_loot_template` WHERE `Entry` = 8926  AND `Item` = 22305;
-- Dredge Worm -> removes Malgen's Long Bow
DELETE FROM `creature_loot_template` WHERE `Entry` = 8925 AND `Item` = 22318;
-- Unfettered Spirit -> removes Steelclaw Reaver 
DELETE FROM `creature_loot_template` WHERE `Entry` = 4308 AND `Item` = 7761;
-- Tink Sprocketwhistle -> removes Gnomeregan Amulet 
DELETE FROM `creature_loot_template` WHERE `Entry` = 9676 AND `Item` = 10299;
-- Wailing Death, Scarlet Spellbinder, Stitched Horror, Eyeless Watcher, Chromatic Whelp, 
-- Risen Aberration, Stonelash Flayer, Desert Rumbler, Carrion Swarmer -> removes Idol of Brutality
DELETE FROM `creature_loot_template` WHERE `Entry` IN (1804, 4494, 8543, 8539, 10442, 10485, 11737, 11746, 13160) AND `Item` = 23198;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_04_00' WHERE sql_rev = '1622268692168409196';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
