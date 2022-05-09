-- DB update 2021_11_28_04 -> 2021_11_29_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_28_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_28_04 2021_11_29_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1637426939576443600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637426939576443600');

DELETE FROM `gameobject_loot_template` WHERE `Entry`=2265;
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
-- food: group 0
(2265, 159,  0, 36, 0, 1, 0, 1, 2,'Battered Chest - Refreshing Spring Water'),
(2265, 4536, 0, 19, 0, 1, 0, 1, 2,'Battered Chest - Shiny Red Apple'),
(2265, 4540, 0, 19, 0, 1, 0, 1, 2,'Battered Chest - Tough Hunk of Bread'),
(2265, 117,  0, 19, 0, 1, 0, 1, 2,'Battered Chest - Tough Jerky'),
(2265, 2070, 0, 18, 0, 1, 0, 1, 2,'Battered Chest - Darnassian Bleu'),
-- armor: group 1 (avergae dropchance: 4.16% claculated with arithmetic mean)
(2265, 1378, 0, 4.16, 0, 1, 1, 1, 1,'Battered Chest - Frayed Pants'),
(2265, 1380, 0, 4.16, 0, 1, 1, 1, 1,'Battered Chest - Frayed Pants'),
(2265, 3363, 0, 4.16, 0, 1, 1, 1, 1,'Battered Chest - Frayed Belt'),
(2265, 3365, 0, 4.16, 0, 1, 1, 1, 1,'Battered Chest - Frayed Bracers'),
(2265, 1376, 0, 4.16, 0, 1, 1, 1, 1,'Battered Chest - Frayed Cloak'),
(2265, 1377, 0, 4.16, 0, 1, 1, 1, 1,'Battered Chest - Frayed Gloves'),
(2265, 1374, 0, 4.16, 0, 1, 1, 1, 1,'Battered Chest - Frayed Shoes'),
(2265, 1370, 0, 4.16, 0, 1, 1, 1, 1,'Battered Chest - Ragged Leather Bracers'),
(2265, 1368, 0, 4.16, 0, 1, 1, 1, 1,'Battered Chest - Ragged Leather Gloves'),
(2265, 2210, 0, 4.16, 0, 1, 1, 1, 1,'Battered Chest - Battered Buckler'),
(2265, 2211, 0, 4.16, 0, 1, 1, 1, 1,'Battered Chest - Bent Large Shield'),
(2265, 2649, 0, 4.16, 0, 1, 1, 1, 1,'Battered Chest - Flimsy Chain Belt'),
(2265, 2653, 0, 4.16, 0, 1, 1, 1, 1,'Battered Chest - Flimsy Chain Gloves'),
(2265, 2654, 0, 4.16, 0, 1, 1, 1, 1,'Battered Chest - Flimsy Chain Pants'),
(2265, 2656, 0, 4.16, 0, 1, 1, 1, 1,'Battered Chest - Flimsy Chain Vest'),
(2265, 1372, 0, 4.16, 0, 1, 1, 1, 1,'Battered Chest - Ragged Cloak'),
(2265, 1369, 0, 4.16, 0, 1, 1, 1, 1,'Battered Chest - Ragged Leather Belt'),
(2265, 1367, 0, 4.16, 0, 1, 1, 1, 1,'Battered Chest - Ragged Leather Boots'),
(2265, 1366, 0, 4.16, 0, 1, 1, 1, 1,'Battered Chest - Ragged Leather Pants'),
(2265, 1364, 0, 4.16, 0, 1, 1, 1, 1,'Battered Chest - Ragged Leather Vest'),
(2265, 2650, 0, 4.16, 0, 1, 1, 1, 1,'Battered Chest - Flimsy Chain Boots'),
(2265, 2651, 0, 4.16, 0, 1, 1, 1, 1,'Battered Chest - Flimsy Chain Bracers'),
(2265, 2652, 0, 4.16, 0, 1, 1, 1, 1,'Battered Chest - Flimsy Chain Cloak');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_29_00' WHERE sql_rev = '1637426939576443600';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
