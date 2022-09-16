-- DB update 2021_11_23_00 -> 2021_11_23_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_23_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_23_00 2021_11_23_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1637094877418094500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637094877418094500');

-- Correct drop chance: [A Letter to Yvette] https://classic.wowhead.com/item=2839/a-letter-to-yvette

-- Darkeye Bonecaster
UPDATE `creature_loot_template` SET `Chance`=4 WHERE `Item`=2839 AND `Entry`=1522;

-- Rattlecage Soldier, Cracked Skull Soldier
UPDATE `creature_loot_template` SET `Chance`=3 WHERE `Item`=2839 AND `Entry` IN (1520,1523);

DELETE FROM `creature_loot_template` WHERE `Item`=2839 AND `Entry` IN(1664, 1770, 1548, 1537, 1530, 1532);

INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1664,2839,0,0.12,0,1,0,1,1,'Captain Vachon - A Letter to Yvette'),
(1770,2839,0,0.05,0,1,0,1,1,'Moonrage Darkrunner - A Letter to Yvette'),
(1548,2839,0,0.01,0,1,0,1,1,'Cursed Darkhound - A Letter to Yvette'),
(1537,2839,0,0.01,0,1,0,1,1,'Scarlet Zealot - A Letter to Yvette'),
(1530,2839,0,0.01,0,1,0,1,1,'Rotting Ancestor - A Letter to Yvette'),
(1532,2839,0,0.01,0,1,0,1,1,'Wandering Spirit - A Letter to Yvette');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_23_01' WHERE sql_rev = '1637094877418094500';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
