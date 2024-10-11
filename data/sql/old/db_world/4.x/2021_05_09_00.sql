-- DB update 2021_05_08_00 -> 2021_05_09_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_08_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_08_00 2021_05_09_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1620115611701757811'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620115611701757811');

SET 
@ROUGHSTONE = 2835,
@COPPERORE = 2770,
@COARSESTONE = 2836,
@TINORE = 2771,
@HEAVYSTONE = 2838,
@IRONORE = 2772,
@SOLIDSTONE = 7912,
@MITHRILORE = 3858,
@DENSESTONE = 12365,
@SOULDARITE = 19774,
@THORIUMORE = 10620;

-- Copper Vein
UPDATE `gameobject_loot_template` SET `MaxCount`= 6 WHERE FIND_IN_SET (`Entry`,'1502,1735,2626,18092') AND `Item` = @ROUGHSTONE; -- Rough Stone
UPDATE `gameobject_loot_template` SET `MinCount`= 1 WHERE FIND_IN_SET (`Entry`,'1502,1735,2626,18092') AND `Item` = @ROUGHSTONE; -- Rough Stone
UPDATE `gameobject_loot_template` SET `Chance`= 50 WHERE FIND_IN_SET (`Entry`,'1502,1735,2626,18092') AND `Item` = @ROUGHSTONE; -- Rough Stone
UPDATE `gameobject_loot_template` SET `MinCount`= 1 WHERE FIND_IN_SET (`Entry`,'1502,1735,2626,18092') AND `Item` = @COPPERORE; -- Copper Ore
UPDATE `gameobject_loot_template` SET `MaxCount`= 4 WHERE FIND_IN_SET (`Entry`,'1502,1735,2626,18092') AND `Item` = @COPPERORE; -- Copper Ore

-- Tin Vein
UPDATE `gameobject_loot_template` SET `MaxCount`= 6 WHERE FIND_IN_SET (`Entry`,'1503,1736,2627,18093') AND `Item` = @COARSESTONE; -- Coarse Stone
UPDATE `gameobject_loot_template` SET `MinCount`= 1 WHERE FIND_IN_SET (`Entry`,'1503,1736,2627,18093') AND `Item` = @COARSESTONE; -- Coarse Stone
UPDATE `gameobject_loot_template` SET `Chance`= 50 WHERE FIND_IN_SET (`Entry`,'1503,1736,2627,18093') AND `Item` = @COARSESTONE; -- Coarse Stone
UPDATE `gameobject_loot_template` SET `MinCount`= 1 WHERE FIND_IN_SET (`Entry`,'1503,1736,2627,18093') AND `Item` = @TINORE; -- Tin Ore
UPDATE `gameobject_loot_template` SET `MaxCount`= 4 WHERE FIND_IN_SET (`Entry`,'1503,1736,2627,18093') AND `Item` = @TINORE; -- Tin Ore

-- Iron Deposit
UPDATE `gameobject_loot_template` SET `Chance`= 50 WHERE `Entry` = 1505 AND `Item` = @HEAVYSTONE; -- Heavy Stone
UPDATE `gameobject_loot_template` SET `MinCount`= 1 WHERE `Entry` = 1505 AND `Item` = @HEAVYSTONE; -- Heavy Stone
UPDATE `gameobject_loot_template` SET `MaxCount`= 5 WHERE `Entry` = 1505 AND `Item` = @HEAVYSTONE; -- Heavy Stone
UPDATE `gameobject_loot_template` SET `MinCount`= 1 WHERE `Entry` = 1505 AND `Item` = @IRONORE; -- Iron Ore
UPDATE `gameobject_loot_template` SET `MaxCount`= 4 WHERE `Entry` = 1505 AND `Item` = @IRONORE; -- Iron Ore
UPDATE `gameobject_loot_template` SET `GroupId`= 1 WHERE `Entry` = 1505 AND `Item` = @HEAVYSTONE; -- Heavy Stone

-- Mithril Deposit
UPDATE `gameobject_loot_template` SET `MinCount`= 1 WHERE FIND_IN_SET (`Entry`,'1742,13961') AND `Item` = @MITHRILORE; -- Mithril Ore
UPDATE `gameobject_loot_template` SET `MaxCount`= 4 WHERE FIND_IN_SET (`Entry`,'1742,13961') AND `Item` = @MITHRILORE; -- Mithril Ore
UPDATE `gameobject_loot_template` SET `MinCount`= 1 WHERE FIND_IN_SET (`Entry`,'1742,13961') AND `Item` = @SOLIDSTONE; -- Solid Stone
UPDATE `gameobject_loot_template` SET `MaxCount`= 8 WHERE FIND_IN_SET (`Entry`,'1742,13961') AND `Item` = @SOLIDSTONE; -- Solid Stone
UPDATE `gameobject_loot_template` SET `Chance`= 50 WHERE FIND_IN_SET (`Entry`,'1742,13961') AND `Item` = @SOLIDSTONE; -- Solid Stone

-- Hakkari Thorium Vein
UPDATE `gameobject_loot_template` SET `GroupId`= 1 WHERE `Entry` = 17241 AND `Item` = @DENSESTONE; -- Dense Stone
UPDATE `gameobject_loot_template` SET `GroupId`= 1 WHERE `Entry` = 17241 AND `Item` = 1; -- Reference Tables
UPDATE `gameobject_loot_template` SET `Chance`= 50 WHERE `Entry` = 17241 AND `Item` = @DENSESTONE; -- Dense Stone
UPDATE `gameobject_loot_template` SET `MinCount`= 1 WHERE `Entry` = 17241 AND `Item` = @DENSESTONE; -- Dense Stone
UPDATE `gameobject_loot_template` SET `MaxCount`= 7 WHERE `Entry` = 17241 AND `Item` = @DENSESTONE; -- Dense Stone
UPDATE `gameobject_loot_template` SET `MinCount`= 1 WHERE `Entry` = 17241 AND `Item` = @SOULDARITE; -- Souldarite
UPDATE `gameobject_loot_template` SET `MaxCount`= 2 WHERE `Entry` = 17241 AND `Item` = @SOULDARITE; -- Souldarite
UPDATE `gameobject_loot_template` SET `MinCount`= 1 WHERE `Entry` = 17241 AND `Item` = @THORIUMORE; -- Thorium Ore
UPDATE `gameobject_loot_template` SET `MaxCount`= 5 WHERE `Entry` = 17241 AND `Item` = @THORIUMORE; -- Thorium Ore

-- Small Thorium Veins
UPDATE `gameobject_loot_template` SET `GroupId`= 1 WHERE FIND_IN_SET (`Entry`,'9597,13960') AND `Item` = @DENSESTONE; -- Dense Stone
UPDATE `gameobject_loot_template` SET `GroupId`= 1 WHERE Entry = 13960 AND `Item` = 11513; -- Tainted Vitriol
UPDATE `gameobject_loot_template` SET `GroupId`= 1 WHERE FIND_IN_SET (`Entry`,'9597,13960') AND `Item` = 1; -- Reference Tables
UPDATE `gameobject_loot_template` SET `Chance`= 50 WHERE FIND_IN_SET (`Entry`,'9597,13960') AND `Item` = @DENSESTONE; -- Dense Stone
UPDATE `gameobject_loot_template` SET `MinCount`= 1 WHERE FIND_IN_SET (`Entry`,'9597,13960') AND `Item` = @DENSESTONE; -- Dense Stone
UPDATE `gameobject_loot_template` SET `MaxCount`= 5 WHERE FIND_IN_SET (`Entry`,'9597,13960') AND `Item` = @DENSESTONE; -- Dense Stone
UPDATE `gameobject_loot_template` SET `MinCount`= 1 WHERE FIND_IN_SET (`Entry`,'9597,13960') AND `Item` = @THORIUMORE; -- Thorium Ore
UPDATE `gameobject_loot_template` SET `MaxCount`= 3 WHERE FIND_IN_SET (`Entry`,'9597,13960') AND `Item` = @THORIUMORE; -- Thorium Ore

-- Rich Thorium Vein
UPDATE `gameobject_loot_template` SET `GroupId`= 1 WHERE `Entry` = 12883 AND `Item` = @DENSESTONE; -- Dense Stone
UPDATE `gameobject_loot_template` SET `GroupId`= 1 WHERE `Entry` = 12883 AND `Item` = 1; -- Reference Tables
UPDATE `gameobject_loot_template` SET `Chance`= 50 WHERE `Entry` = 12883 AND `Item` = @DENSESTONE; -- Dense Stone
UPDATE `gameobject_loot_template` SET `MinCount`= 1 WHERE `Entry` = 12883 AND `Item` = @DENSESTONE; -- Dense Stone
UPDATE `gameobject_loot_template` SET `MaxCount`= 7 WHERE `Entry` = 12883 AND `Item` = @DENSESTONE; -- Dense Stone
UPDATE `gameobject_loot_template` SET `MinCount`= 1 WHERE `Entry` = 12883 AND `Item` = @THORIUMORE; -- Thorium Ore
UPDATE `gameobject_loot_template` SET `MaxCount`= 5 WHERE `Entry` = 12883 AND `Item` = @THORIUMORE; -- Thorium Ore


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
