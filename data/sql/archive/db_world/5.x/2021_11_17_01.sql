-- DB update 2021_11_17_00 -> 2021_11_17_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_17_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_17_00 2021_11_17_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1636980654557070200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636980654557070200');

DROP TABLE IF EXISTS `player_loot_template`;
CREATE TABLE IF NOT EXISTS `player_loot_template` (
  `Entry` MEDIUMINT UNSIGNED NOT NULL DEFAULT 0,
  `Item` MEDIUMINT UNSIGNED NOT NULL DEFAULT 0,
  `Reference` MEDIUMINT NOT NULL DEFAULT 0,
  `Chance` FLOAT NOT NULL DEFAULT 100,
  `QuestRequired` TINYINT NOT NULL DEFAULT 0,
  `LootMode` SMALLINT UNSIGNED NOT NULL DEFAULT 1,
  `GroupId` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `MinCount` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `MaxCount` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `Comment` TEXT DEFAULT NULL,
  PRIMARY KEY (`Entry`,`Item`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8mb4 COMMENT='Loot System';

DELETE FROM `player_loot_template` WHERE `Entry` IN (1, 0);
INSERT INTO `player_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1, 17306, 0, 50, 0, 1, 0, 2, 5, 'Alterac Valley - Alliance - Stormpike Soldier\s Blood'),
(1, 17326, 0, 30, 0, 1, 0, 1, 1, 'Alterac Valley - Alliance - Stormpike Soldier\s Flesh'),
(1, 17327, 0, 20, 0, 1, 0, 1, 1, 'Alterac Valley - Alliance - Stormpike Lieutenant\s Flesh'),
(1, 17328, 0, 10, 0, 1, 0, 1, 1, 'Alterac Valley - Alliance - Stormpike Commander\'s Flesh'),
(1, 17422, 0, 85, 0, 1, 0, 15, 22, 'Alterac Valley - Alliance - Armor Scrapts'),
(1, 18228, 0, 1, 0, 1, 0,  1, 1, 'Alterac Valley - Alliance - Autographed Picture of Foror & Tigule'),
(0, 17423, 0, 50, 0, 1, 0, 2, 5, 'Alterac Valley - Horde - Storm Crystal'),  -- Horde
(0, 17502, 0, 30, 0, 1, 0, 1, 1, 'Alterac Valley - Horde - Frostwolf Soldier\s Medal'),
(0, 17503, 0, 20, 0, 1, 0, 1, 1, 'Alterac Valley - Horde - Frostwolf Lieutenant\s Medal'),
(0, 17504, 0, 10, 0, 1, 0, 1, 1, 'Alterac Valley - Horde - Frostwolf Commander\'s Medal'),
(0, 17422, 0, 85, 0, 1, 0, 15, 22, 'Alterac Valley - Horde - Armor Scraps'),
(0, 18228, 0, 1, 0, 1, 0, 1, 1, 'Alterac Valley - Horde - Autographed Picture of Foror & Tigule');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 28) AND (`SourceGroup` IN (0, 1)) AND (`SourceEntry` IN (17306, 17326, 17327, 17328, 17422, 18228, 17423, 17502, 17503, 17504));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(28, 1, 17306, 0, 0, 22, 0, 30, 0, 0, 0, 0, 0, '', 'Stormpike Soldier Blood Hat only drops inside Alterac Valley Battleground'),
(28, 1, 17326, 0, 0, 22, 0, 30, 0, 0, 0, 0, 0, '', 'Stormpike Soldier Flesh only drops inside Alterac Valley Battleground'),
(28, 1, 17327, 0, 0, 22, 0, 30, 0, 0, 0, 0, 0, '', 'Stormpike Lieutenant Flesh only drops inside Alterac Valley Battleground'),
(28, 1, 17328, 0, 0, 22, 0, 30, 0, 0, 0, 0, 0, '', 'Stormpike Commander Flesh only drops inside Alterac Valley Battleground'),
(28, 1, 17422, 0, 0, 22, 0, 30, 0, 0, 0, 0, 0, '', 'Armor Scrap only drops inside Alterac Valley Battleground'),
(28, 1, 18228, 0, 0, 22, 0, 30, 0, 0, 0, 0, 0, '', 'Autographed Picture of Foror & Tigule only drops inside Alterac Valley Battleground'),
(28, 0, 17423, 0, 0, 22, 0, 30, 0, 0, 0, 0, 0, '', 'Storm Crystal only drops inside Alterac Valley Battleground'),
(28, 0, 17502, 0, 0, 22, 0, 30, 0, 0, 0, 0, 0, '', 'Frostwolf Soldier\s Medal only drops inside Alterac Valley Battleground'),
(28, 0, 17503, 0, 0, 22, 0, 30, 0, 0, 0, 0, 0, '', 'Frostwolf Lieutenant\s Medal only drops inside Alterac Valley Battleground'),
(28, 0, 17504, 0, 0, 22, 0, 30, 0, 0, 0, 0, 0, '', 'Frostwolf Commander\'s Medal only drops inside Alterac Valley Battleground'),
(28, 0, 17422, 0, 0, 22, 0, 30, 0, 0, 0, 0, 0, '', 'Armor Scrap only drops inside Alterac Valley Battleground'),
(28, 0, 18228, 0, 0, 22, 0, 30, 0, 0, 0, 0, 0, '', 'Autographed Picture of Foror & Tigule only drops inside Alterac Valley Battleground');

DELETE FROM `command` WHERE `name` IN ('reload player_loot_template');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('reload player_loot_template', 3, 'Syntax: .reload player_loot_template\nReload player_loot_template table.'); 

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_17_01' WHERE sql_rev = '1636980654557070200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
