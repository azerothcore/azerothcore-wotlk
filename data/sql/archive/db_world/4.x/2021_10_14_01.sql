-- DB update 2021_10_14_00 -> 2021_10_14_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_14_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_14_00 2021_10_14_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1632423232437840216'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632423232437840216');

DELETE FROM `reference_loot_template` WHERE (`Entry` = 44011);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(44011, 935, 0, 0, 0, 1, 1, 1, 1, 'Night Watch Shortsword'),
(44011, 12975, 0, 0, 0, 1, 1, 1, 1, 'Prospector Axe'),
(44011, 12976, 0, 0, 0, 1, 1, 1, 1, 'Ironpatch Blade'),
(44011, 12978, 0, 0, 0, 1, 1, 1, 1, 'Stormbringer Belt'),
(44011, 12979, 0, 0, 0, 1, 1, 1, 1, 'Firebane Cloak'),
(44011, 12982, 0, 0, 0, 1, 1, 1, 1, 'Silver-linked Footguards'),
(44011, 12983, 0, 0, 0, 1, 1, 1, 1, 'Rakzur Club'),
(44011, 12984, 0, 0, 0, 1, 1, 1, 1, 'Skycaller'),
(44011, 13136, 0, 0, 0, 1, 1, 1, 1, 'Lil Timmy\'s Peashooter');


DELETE FROM `creature_loot_template` WHERE (`Entry` = 435) AND (`Item` IN (24061)) AND (`Reference` IN (24061));
DELETE FROM `creature_loot_template` WHERE (`Entry` = 435) AND (`Item` IN (44011)) AND (`Reference` IN (44011));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(435, 44011, 44011, 0.5, 0, 1, 1, 1, 1, 'Blackrock Champion - (ReferenceTable)');


DELETE FROM `reference_loot_template` WHERE (`Entry` = 44012);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(44012, 720, 0, 0, 0, 1, 1, 1, 1, 'Brawler Gloves'),
(44012, 3203, 0, 0, 0, 1, 1, 1, 1, 'Dense Triangle Mace'),
(44012, 13005, 0, 0, 0, 1, 1, 1, 1, 'Amy\'s Blanket'),
(44012, 13031, 0, 0, 0, 1, 1, 1, 1, 'Orb of Mistmantle'),
(44012, 13057, 0, 0, 0, 1, 1, 1, 1, 'Bloodpike'),
(44012, 13097, 0, 0, 0, 1, 1, 1, 1, 'Thunderbrow Ring'),
(44012, 13099, 0, 0, 0, 1, 1, 1, 1, 'Moccasins of the White Hare'),
(44012, 13131, 0, 0, 0, 1, 1, 1, 1, 'Sparkleshell Mantle');


DELETE FROM `creature_loot_template` WHERE (`Entry` = 435) AND (`Item` IN (24069, 24069));
DELETE FROM `creature_loot_template` WHERE (`Entry` = 435) AND (`Item` IN (44012, 44012));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(435, 44012, 44012, 0.5, 0, 1, 1, 1, 1, 'Blackrock Champion - (ReferenceTable)');


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_14_01' WHERE sql_rev = '1632423232437840216';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
