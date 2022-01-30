-- DB update 2021_12_19_05 -> 2021_12_20_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_19_05';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_19_05 2021_12_20_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1640021759359148700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640021759359148700');

DELETE FROM `command` WHERE `name` IN ('item refund');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('item refund', 3, 'Syntax: .item refund <name> <item> <extendedCost> \nRemoves the item and restores honor/arena/items according to extended cost.');

DELETE FROM `acore_string` WHERE `entry` IN (5071, 5072, 5073, 5074, 5075, 5076, 5077, 5078);
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(5071, 'The extendedcost entry provided does not exist.'),
(5072, 'Refunding %s (%u) would send the target over the honor points limit (limit: %u, current honor: %u, honor to be refunded: %u).'),
(5073, 'An attempt of refunding your item %s has failed because it would put you over the honor points limit.'),
(5074, 'Item %s (%u) was refunded, restoring %u honor points.'),
(5075, 'Refunding %s (%u) would send the target over the arena points limit (limit: %u, current arena points: %u, arena points to be refunded: %u).'),
(5076, 'An attempt of refunding your item %s has failed because it would put you over the arena points limit.'),
(5077, 'Item %s (%u) was refunded, restoring %u arena points.'),
(5078, 'Item not found in the character\'s inventory (bank included)');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_20_00' WHERE sql_rev = '1640021759359148700';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
