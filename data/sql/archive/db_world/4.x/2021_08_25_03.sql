-- DB update 2021_08_25_02 -> 2021_08_25_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_25_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_25_02 2021_08_25_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1629360903817888286'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629360903817888286');

-- Delete Thick Wolfhide from various creatures
DELETE FROM `skinning_loot_template` WHERE `item` = 8368 AND `entry` IN (1817, 2680, 2681, 2730, 2923, 2924, 2925, 2926, 5286, 5287, 5288, 5984, 5985, 7055, 8211, 8921, 8922, 9042, 9416, 9690, 9694, 9696, 9697, 10150, 10156, 10221, 10981, 12121, 12122, 12418, 13036, 14282, 22540, 22546, 22737, 22738, 31964, 31970, 31975, 31977, 37294, 37296);

-- Adjust skinning drop rates for Diseased Wolf
UPDATE `skinning_loot_template` SET `Chance` = 41.3 WHERE `Entry` = 1817 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 4.1 WHERE `Entry` = 1817 AND `Item` = 8169;
UPDATE `skinning_loot_template` SET `Chance` = 50.9 WHERE `Entry` = 1817 AND `Item` = 8170;
UPDATE `skinning_loot_template` SET `Chance` = 3.7 WHERE `Entry` = 1817 AND `Item` = 8171;

-- Adjust skinning drop rates for Vilebranch Wolf Pup
UPDATE `skinning_loot_template` SET `Chance` = 72.7 WHERE `Entry` = 2680 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 4.8 WHERE `Entry` = 2680 AND `Item` = 8169;
UPDATE `skinning_loot_template` SET `Chance` = 22.5 WHERE `Entry` = 2680 AND `Item` = 8170;

-- Adjust skinning drop rates for Vilebranch Raiding Wolf
UPDATE `skinning_loot_template` SET `Chance` = 73.4 WHERE `Entry` = 2681 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 4.6 WHERE `Entry` = 2681 AND `Item` = 8169;
UPDATE `skinning_loot_template` SET `Chance` = 22 WHERE `Entry` = 2681 AND `Item` = 8170;

-- Adjust skinning drop rates for Rabid Crag Coyote
UPDATE `skinning_loot_template` SET `Chance` = 38.6 WHERE `Entry` = 2730 AND `Item` = 4234;
UPDATE `skinning_loot_template` SET `Chance` = 3 WHERE `Entry` = 2730 AND `Item` = 4235;
UPDATE `skinning_loot_template` SET `Chance` = 52.5 WHERE `Entry` = 2730 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 5.9 WHERE `Entry` = 2730 AND `Item` = 8169;

-- Adjust skinning drop rates for Mangy Silvermane
UPDATE `skinning_loot_template` SET `Chance` = 41.3 WHERE `Entry` = 2923 AND `Item` = 4234;
UPDATE `skinning_loot_template` SET `Chance` = 3.9 WHERE `Entry` = 2923 AND `Item` = 4235;
UPDATE `skinning_loot_template` SET `Chance` = 50.6 WHERE `Entry` = 2923 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 4.2 WHERE `Entry` = 2923 AND `Item` = 8169;

-- Adjust skinning drop rates for Silvermane Wolf
UPDATE `skinning_loot_template` SET `Chance` = 41.3 WHERE `Entry` = 2924 AND `Item` = 4234;
UPDATE `skinning_loot_template` SET `Chance` = 3.9 WHERE `Entry` = 2924 AND `Item` = 4235;
UPDATE `skinning_loot_template` SET `Chance` = 51.2 WHERE `Entry` = 2924 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 3.7 WHERE `Entry` = 2924 AND `Item` = 8169;

-- Adjust skinning drop rates for Silvermane Howler
UPDATE `skinning_loot_template` SET `Chance` = 74.6 WHERE `Entry` = 2925 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 5.4 WHERE `Entry` = 2925 AND `Item` = 8169;
UPDATE `skinning_loot_template` SET `Chance` = 20 WHERE `Entry` = 2925 AND `Item` = 8170;

-- Adjust skinning drop rates for Silvermane Stalker
UPDATE `skinning_loot_template` SET `Chance` = 73.2 WHERE `Entry` = 2926 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 5 WHERE `Entry` = 2926 AND `Item` = 8169;
UPDATE `skinning_loot_template` SET `Chance` = 21.8 WHERE `Entry` = 2926 AND `Item` = 8170;

-- Adjust skinning drop rates for Longtooth Runner
UPDATE `skinning_loot_template` SET `Chance` = 40.2 WHERE `Entry` = 5286 AND `Item` = 4234;
UPDATE `skinning_loot_template` SET `Chance` = 4.2 WHERE `Entry` = 5286 AND `Item` = 4235;
UPDATE `skinning_loot_template` SET `Chance` = 51.6 WHERE `Entry` = 5286 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 4 WHERE `Entry` = 5286 AND `Item` = 8169;

-- Adjust skinning drop rates for Longtooth Howler
UPDATE `skinning_loot_template` SET `Chance` = 40 WHERE `Entry` = 5287 AND `Item` = 4234;
UPDATE `skinning_loot_template` SET `Chance` = 4.5 WHERE `Entry` = 5287 AND `Item` = 4235;
UPDATE `skinning_loot_template` SET `Chance` = 51.6 WHERE `Entry` = 5287 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 3.9 WHERE `Entry` = 5287 AND `Item` = 8169;

-- Adjust skinning drop rates for Rabid Longtooth
UPDATE `skinning_loot_template` SET `Chance` = 74.4 WHERE `Entry` = 5288 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 5.2 WHERE `Entry` = 5288 AND `Item` = 8169;
UPDATE `skinning_loot_template` SET `Chance` = 20.4 WHERE `Entry` = 5288 AND `Item` = 8170;

-- Adjust skinning drop rates for Tamed Cat
UPDATE `skinning_loot_template` SET `Chance` = 74.7 WHERE `Entry` = 10150 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 4.2 WHERE `Entry` = 10150 AND `Item` = 8169;
UPDATE `skinning_loot_template` SET `Chance` = 21.1 WHERE `Entry` = 10150 AND `Item` = 8170;

-- Adjust skinning drop rates for Starving Snickerfang
UPDATE `skinning_loot_template` SET `Chance` = 74 WHERE `Entry` = 5984 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 5.1 WHERE `Entry` = 5984 AND `Item` = 8169;
UPDATE `skinning_loot_template` SET `Chance` = 20.9 WHERE `Entry` = 5984 AND `Item` = 8170;

-- Adjust skinning drop rates for Snickerfang Hyena
UPDATE `skinning_loot_template` SET `Chance` = 76.2 WHERE `Entry` = 5985 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 5.4 WHERE `Entry` = 5985 AND `Item` = 8169;
UPDATE `skinning_loot_template` SET `Chance` = 18.4 WHERE `Entry` = 5985 AND `Item` = 8170;

-- Adjust skinning drop rates for Blackrock Worg
UPDATE `skinning_loot_template` SET `Chance` = 39.2 WHERE `Entry` = 7055 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 1.8 WHERE `Entry` = 7055 AND `Item` = 8169;
UPDATE `skinning_loot_template` SET `Chance` = 54.5 WHERE `Entry` = 7055 AND `Item` = 8170;
UPDATE `skinning_loot_template` SET `Chance` = 4.5 WHERE `Entry` = 7055 AND `Item` = 8171;

-- Adjust skinning drop rates for Old Cliff Jumper
UPDATE `skinning_loot_template` SET `Chance` = 59.2 WHERE `Entry` = 8211 AND `Item` = 4234;
UPDATE `skinning_loot_template` SET `Chance` = 4.5 WHERE `Entry` = 8211 AND `Item` = 4235;
UPDATE `skinning_loot_template` SET `Chance` = 31.8 WHERE `Entry` = 8211 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 4.5 WHERE `Entry` = 8211 AND `Item` = 8169;

-- Adjust skinning drop rates for Bloodhound
UPDATE `skinning_loot_template` SET `Chance` = 74.8 WHERE `Entry` = 8921 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 4.9 WHERE `Entry` = 8921 AND `Item` = 8169;
UPDATE `skinning_loot_template` SET `Chance` = 20.3 WHERE `Entry` = 8921 AND `Item` = 8170;

-- Adjust skinning drop rates for Bloodhound Mastiff
UPDATE `skinning_loot_template` SET `Chance` = 43.1 WHERE `Entry` = 8922 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 3.5 WHERE `Entry` = 8922 AND `Item` = 8169;
UPDATE `skinning_loot_template` SET `Chance` = 47.7 WHERE `Entry` = 8922 AND `Item` = 8170;
UPDATE `skinning_loot_template` SET `Chance` = 5.7 WHERE `Entry` = 8922 AND `Item` = 8171;

-- Adjust skinning drop rates for Verek
UPDATE `skinning_loot_template` SET `Chance` = 33.1 WHERE `Entry` = 9042 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 3.9 WHERE `Entry` = 9042 AND `Item` = 8169;
UPDATE `skinning_loot_template` SET `Chance` = 57.4 WHERE `Entry` = 9042 AND `Item` = 8170;
UPDATE `skinning_loot_template` SET `Chance` = 5.6 WHERE `Entry` = 9042 AND `Item` = 8171;

-- Adjust skinning drop rates for Scarshield Worg
UPDATE `skinning_loot_template` SET `Chance` = 44.3 WHERE `Entry` = 9416 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 3.1 WHERE `Entry` = 9416 AND `Item` = 8169;
UPDATE `skinning_loot_template` SET `Chance` = 47.9 WHERE `Entry` = 9416 AND `Item` = 8170;
UPDATE `skinning_loot_template` SET `Chance` = 4.7 WHERE `Entry` = 9416 AND `Item` = 8171;

-- Adjust skinning drop rates for Ember Worg
UPDATE `skinning_loot_template` SET `Chance` = 39.6 WHERE `Entry` = 9690 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 2.7 WHERE `Entry` = 9690 AND `Item` = 8169;
UPDATE `skinning_loot_template` SET `Chance` = 53.3 WHERE `Entry` = 9690 AND `Item` = 8170;
UPDATE `skinning_loot_template` SET `Chance` = 4.4 WHERE `Entry` = 9690 AND `Item` = 8171;

-- Adjust skinning drop rates for Slavering Ember Worg
UPDATE `skinning_loot_template` SET `Chance` = 38.7 WHERE `Entry` = 9694 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 3.3 WHERE `Entry` = 9694 AND `Item` = 8169;
UPDATE `skinning_loot_template` SET `Chance` = 54.1 WHERE `Entry` = 9694 AND `Item` = 8170;
UPDATE `skinning_loot_template` SET `Chance` = 3.9 WHERE `Entry` = 9694 AND `Item` = 8171;

-- Adjust skinning drop rates for Bloodaxe Worg
UPDATE `skinning_loot_template` SET `Chance` = 11.4 WHERE `Entry` = 9696 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 83.9 WHERE `Entry` = 9696 AND `Item` = 8170;
UPDATE `skinning_loot_template` SET `Chance` = 4.7 WHERE `Entry` = 9696 AND `Item` = 8171;

-- Adjust skinning drop rates for Giant Ember Worg
UPDATE `skinning_loot_template` SET `Chance` = 37.3 WHERE `Entry` = 9697 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 5.5 WHERE `Entry` = 9697 AND `Item` = 8169;
UPDATE `skinning_loot_template` SET `Chance` = 51.8 WHERE `Entry` = 9697 AND `Item` = 8170;
UPDATE `skinning_loot_template` SET `Chance` = 5.5 WHERE `Entry` = 9697 AND `Item` = 8171;

-- Adjust skinning drop rates for Deathmaw
UPDATE `skinning_loot_template` SET `Chance` = 10.5 WHERE `Entry` = 10156 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 85.3 WHERE `Entry` = 10156 AND `Item` = 8170;
UPDATE `skinning_loot_template` SET `Chance` = 4.2 WHERE `Entry` = 10156 AND `Item` = 8171;

-- Adjust skinning drop rates for Bloodaxe Worg Pup
UPDATE `skinning_loot_template` SET `Chance` = 41.6 WHERE `Entry` = 10221 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 2.8 WHERE `Entry` = 10221 AND `Item` = 8169;
UPDATE `skinning_loot_template` SET `Chance` = 51.8 WHERE `Entry` = 10221 AND `Item` = 8170;
UPDATE `skinning_loot_template` SET `Chance` = 3.8 WHERE `Entry` = 10221 AND `Item` = 8171;

-- Adjust skinning drop rates for Frostwolf
UPDATE `skinning_loot_template` SET `Chance` = 73.7 WHERE `Entry` = 10981 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 5.3 WHERE `Entry` = 10981 AND `Item` = 8169;
UPDATE `skinning_loot_template` SET `Chance` = 21 WHERE `Entry` = 10981 AND `Item` = 8170;

-- Adjust skinning drop rates for Drakan
UPDATE `skinning_loot_template` SET `Chance` = 8.1 WHERE `Entry` = 12121 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 83.1 WHERE `Entry` = 12121 AND `Item` = 8170;
UPDATE `skinning_loot_template` SET `Chance` = 7.3 WHERE `Entry` = 12121 AND `Item` = 8171;
UPDATE `skinning_loot_template` SET `Chance` = 1.6 WHERE `Entry` = 12121 AND `Item` = 25649;

-- Adjust skinning drop rates for Duros
UPDATE `skinning_loot_template` SET `Chance` = 15.4 WHERE `Entry` = 12122 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 79.7 WHERE `Entry` = 12122 AND `Item` = 8170;
UPDATE `skinning_loot_template` SET `Chance` = 3.5 WHERE `Entry` = 12122 AND `Item` = 8171;
UPDATE `skinning_loot_template` SET `Chance` = 0.7 WHERE `Entry` = 12122 AND `Item` = 21887;
UPDATE `skinning_loot_template` SET `Chance` = 0.7 WHERE `Entry` = 12122 AND `Item` = 25649;

-- Adjust skinning drop rates for Gordok Hyena
UPDATE `skinning_loot_template` SET `Chance` = 38.1 WHERE `Entry` = 12418 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 4 WHERE `Entry` = 12418 AND `Item` = 8169;
UPDATE `skinning_loot_template` SET `Chance` = 54.4 WHERE `Entry` = 12418 AND `Item` = 8170;
UPDATE `skinning_loot_template` SET `Chance` = 3.5 WHERE `Entry` = 12418 AND `Item` = 8171;

-- Adjust skinning drop rates for Gordok Mastiff
UPDATE `skinning_loot_template` SET `Chance` = 10.3 WHERE `Entry` = 13036 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 84.8 WHERE `Entry` = 13036 AND `Item` = 8170;
UPDATE `skinning_loot_template` SET `Chance` = 4.9 WHERE `Entry` = 13036 AND `Item` = 8171;

-- Adjust skinning drop rates for Frostwolf Bloodhound
UPDATE `skinning_loot_template` SET `Chance` = 36.8 WHERE `Entry` = 14282 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 3.1 WHERE `Entry` = 14282 AND `Item` = 8169;
UPDATE `skinning_loot_template` SET `Chance` = 56.1 WHERE `Entry` = 14282 AND `Item` = 8170;
UPDATE `skinning_loot_template` SET `Chance` = 4 WHERE `Entry` = 14282 AND `Item` = 8171;

-- Adjust skinning drop rates for Drakan (1)
UPDATE `skinning_loot_template` SET `Chance` = 8.1 WHERE `Entry` = 22540 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 83.1 WHERE `Entry` = 22540 AND `Item` = 8170;
UPDATE `skinning_loot_template` SET `Chance` = 7.3 WHERE `Entry` = 22540 AND `Item` = 8171;
UPDATE `skinning_loot_template` SET `Chance` = 1.6 WHERE `Entry` = 22540 AND `Item` = 25649;

-- Adjust skinning drop rates for Duros (1)
UPDATE `skinning_loot_template` SET `Chance` = 15.4 WHERE `Entry` = 22546 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 79.7 WHERE `Entry` = 22546 AND `Item` = 8170;
UPDATE `skinning_loot_template` SET `Chance` = 3.5 WHERE `Entry` = 22546 AND `Item` = 8171;
UPDATE `skinning_loot_template` SET `Chance` = 0.7 WHERE `Entry` = 22546 AND `Item` = 21887;
UPDATE `skinning_loot_template` SET `Chance` = 0.7 WHERE `Entry` = 22546 AND `Item` = 25649;

-- Adjust skinning drop rates for Frostwolf (1)
UPDATE `skinning_loot_template` SET `Chance` = 73.7 WHERE `Entry` = 22737 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 5.3 WHERE `Entry` = 22737 AND `Item` = 8169;
UPDATE `skinning_loot_template` SET `Chance` = 21 WHERE `Entry` = 22737 AND `Item` = 8170;

-- Adjust skinning drop rates for Frostwolf Bloodhound (1)
UPDATE `skinning_loot_template` SET `Chance` = 36.7 WHERE `Entry` = 22738 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 3.1 WHERE `Entry` = 22738 AND `Item` = 8169;
UPDATE `skinning_loot_template` SET `Chance` = 56.2 WHERE `Entry` = 22738 AND `Item` = 8170;
UPDATE `skinning_loot_template` SET `Chance` = 4 WHERE `Entry` = 22738 AND `Item` = 8171;

-- Adjust skinning drop rates for Drakan (2)
UPDATE `skinning_loot_template` SET `Chance` = 8.1 WHERE `Entry` = 31964 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 83.1 WHERE `Entry` = 31964 AND `Item` = 8170;
UPDATE `skinning_loot_template` SET `Chance` = 7.3 WHERE `Entry` = 31964 AND `Item` = 8171;
UPDATE `skinning_loot_template` SET `Chance` = 1.6 WHERE `Entry` = 31964 AND `Item` = 25649;

-- Adjust skinning drop rates for Duros (2)
UPDATE `skinning_loot_template` SET `Chance` = 15.4 WHERE `Entry` = 31970 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 79.7 WHERE `Entry` = 31970 AND `Item` = 8170;
UPDATE `skinning_loot_template` SET `Chance` = 3.5 WHERE `Entry` = 31970 AND `Item` = 8171;
UPDATE `skinning_loot_template` SET `Chance` = 0.7 WHERE `Entry` = 31970 AND `Item` = 21887;
UPDATE `skinning_loot_template` SET `Chance` = 0.7 WHERE `Entry` = 31970 AND `Item` = 25649;

-- Adjust skinning drop rates for Frostwolf (2)
UPDATE `skinning_loot_template` SET `Chance` = 73.7 WHERE `Entry` = 31975 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 5.3 WHERE `Entry` = 31975 AND `Item` = 8169;
UPDATE `skinning_loot_template` SET `Chance` = 21 WHERE `Entry` = 31975 AND `Item` = 8170;

-- Adjust skinning drop rates for Frostwolf Bloodhound (2)
UPDATE `skinning_loot_template` SET `Chance` = 36.7 WHERE `Entry` = 31977 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 3.1 WHERE `Entry` = 31977 AND `Item` = 8169;
UPDATE `skinning_loot_template` SET `Chance` = 56.2 WHERE `Entry` = 31977 AND `Item` = 8170;
UPDATE `skinning_loot_template` SET `Chance` = 4 WHERE `Entry` = 31977 AND `Item` = 8171;

-- Adjust skinning drop rates for Frostwolf (3)
UPDATE `skinning_loot_template` SET `Chance` = 73.7 WHERE `Entry` = 37294 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 5.3 WHERE `Entry` = 37294 AND `Item` = 8169;
UPDATE `skinning_loot_template` SET `Chance` = 21 WHERE `Entry` = 37294 AND `Item` = 8170;

-- Adjust skinning drop rates for Frostwolf Bloodhound (3)
UPDATE `skinning_loot_template` SET `Chance` = 36.7 WHERE `Entry` = 37296 AND `Item` = 4304;
UPDATE `skinning_loot_template` SET `Chance` = 3.1 WHERE `Entry` = 37296 AND `Item` = 8169;
UPDATE `skinning_loot_template` SET `Chance` = 56.2 WHERE `Entry` = 37296 AND `Item` = 8170;
UPDATE `skinning_loot_template` SET `Chance` = 4 WHERE `Entry` = 37296 AND `Item` = 8171;


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_25_03' WHERE sql_rev = '1629360903817888286';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
