-- ============================================================================
-- Black Rose progression support.
--
-- Adds compressed upgrade costs, rare soulbound currency, inert class Jewel
-- scaffolding, tier unlock quests, and daily/weekly reward placeholders.
-- ============================================================================

SET @ROSY := 900140;
SET @BLACK_ROSE_TRINKET := 900105;
SET @BLACK_ROSE_UPGRADE_USE := 900901;

SET @BLACK_MIASMA := 900200;
SET @BLACK_PETALS := 900201;
SET @BLACK_THORNS := 900202;

SET @RED_GEM_BASE := 900300;
SET @YELLOW_GEM_BASE := 900400;
SET @RED_UPGRADE_BASE := 900500;
SET @YELLOW_UPGRADE_BASE := 900600;
SET @JEWEL_GEM_BASE := 901000;
SET @JEWEL_UPGRADE_BASE := 901100;

SET @MIA_EXT_BASE := 900700;
SET @PETAL_EXT_BASE := 900710;
SET @THORN_EXT_BASE := 900720;

SET @QUEST_UNLOCK_T5 := 901200;
SET @QUEST_UNLOCK_T6 := 901201;
SET @QUEST_UNLOCK_T7 := 901202;
SET @QUEST_DAILY := 901210;
SET @QUEST_WEEKLY := 901211;
SET @BLACK_ROSE_SORT := 9009;

-- ----------------------------------------------------------------------------
-- Existing currencies and enhancements become soulbound progression items.
-- ----------------------------------------------------------------------------
UPDATE `item_template` SET `Quality` = 3, `bonding` = 1 WHERE `entry` IN (@BLACK_MIASMA, @BLACK_PETALS, @BLACK_THORNS);

UPDATE `item_template` SET `bonding` = 1 WHERE (`entry` BETWEEN @RED_GEM_BASE AND @RED_GEM_BASE + 89) OR (`entry` BETWEEN @YELLOW_GEM_BASE AND @YELLOW_GEM_BASE + 49) OR (`entry` BETWEEN @RED_UPGRADE_BASE AND @RED_UPGRADE_BASE + 89) OR (`entry` BETWEEN @YELLOW_UPGRADE_BASE AND @YELLOW_UPGRADE_BASE + 49);

UPDATE `item_template` SET `description` = 'Used by Rosy to shape red Black Rose Ribbons.' WHERE `entry` = @BLACK_MIASMA;

UPDATE `item_template` SET `description` = 'Used by Rosy to shape yellow Black Rose Mists.' WHERE `entry` = @BLACK_PETALS;

UPDATE `item_template` SET `description` = 'Used by Rosy to shape class Black Rose Jewels.' WHERE `entry` = @BLACK_THORNS;

-- ----------------------------------------------------------------------------
-- Compressed T1 vendor costs. T2-T7 upgrade costs are enforced in C++.
-- ----------------------------------------------------------------------------
REPLACE INTO `itemextendedcost_dbc`
    (`ID`, `ItemID_1`, `ItemCount_1`)
SELECT @MIA_EXT_BASE + `rank`.`id`,
       @BLACK_MIASMA,
       `rank`.`cost`
  FROM (
       SELECT 0 AS `id`, 1 AS `cost`
       UNION ALL SELECT 1, 3
       UNION ALL SELECT 2, 8
       UNION ALL SELECT 3, 15
       UNION ALL SELECT 4, 30
       UNION ALL SELECT 5, 60
       UNION ALL SELECT 6, 100
       ) AS `rank`
UNION ALL
SELECT @PETAL_EXT_BASE + `rank`.`id`,
       @BLACK_PETALS,
       `rank`.`cost`
  FROM (
       SELECT 0 AS `id`, 1 AS `cost`
       UNION ALL SELECT 1, 3
       UNION ALL SELECT 2, 8
       UNION ALL SELECT 3, 15
       UNION ALL SELECT 4, 30
       UNION ALL SELECT 5, 60
       UNION ALL SELECT 6, 100
       ) AS `rank`
UNION ALL
SELECT @THORN_EXT_BASE + `rank`.`id`,
       @BLACK_THORNS,
       `rank`.`cost`
  FROM (
       SELECT 0 AS `id`, 1 AS `cost`
       UNION ALL SELECT 1, 3
       UNION ALL SELECT 2, 8
       UNION ALL SELECT 3, 15
       UNION ALL SELECT 4, 30
       UNION ALL SELECT 5, 60
       UNION ALL SELECT 6, 100
       ) AS `rank`;

-- ----------------------------------------------------------------------------
-- Jewel scaffolding: class-specific, inert socketable blue enhancements.
-- ----------------------------------------------------------------------------
REPLACE INTO `item_template`
    (`entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`,
     `displayid`, `Quality`, `BuyCount`, `BuyPrice`, `SellPrice`,
     `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
     `RequiredLevel`, `maxcount`, `stackable`, `bonding`, `description`,
     `Material`, `GemProperties`, `VerifiedBuild`)
SELECT @JEWEL_GEM_BASE + `class`.`id` * 10 + `rank`.`id`,
       3, 4, -1,
       CONCAT(`class`.`name`, ' Jewel'),
       54319, 4, 1, 0, 0,
       0, `class`.`mask`, -1, 20,
       20, 1, 1, 1,
       CONCAT('A dormant ', `class`.`name`,
              ' Jewel for The Black Rose. Class effects will be added later.'),
       -1,
       @JEWEL_GEM_BASE + `class`.`id` * 10 + `rank`.`id`,
       0
  FROM (
       SELECT 0 AS `id`, 'Warrior' AS `name`, 1 AS `mask`
       UNION ALL SELECT 1, 'Paladin', 2
       UNION ALL SELECT 2, 'Hunter', 4
       UNION ALL SELECT 3, 'Rogue', 8
       UNION ALL SELECT 4, 'Priest', 16
       UNION ALL SELECT 5, 'Death Knight', 32
       UNION ALL SELECT 6, 'Shaman', 64
       UNION ALL SELECT 7, 'Mage', 128
       UNION ALL SELECT 8, 'Warlock', 256
       UNION ALL SELECT 9, 'Druid', 1024
       ) AS `class`
 CROSS JOIN (
       SELECT 0 AS `id` UNION ALL SELECT 1 UNION ALL SELECT 2
       UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
       UNION ALL SELECT 6
       ) AS `rank`;

REPLACE INTO `item_template`
    (`entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`,
     `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`,
     `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
     `RequiredLevel`, `maxcount`, `stackable`, `spellid_1`,
     `spelltrigger_1`, `spellcooldown_1`, `bonding`, `description`,
     `Material`, `ScriptName`, `VerifiedBuild`)
SELECT @JEWEL_UPGRADE_BASE + `class`.`id` * 10 + `rank`.`id` - 2,
       12, 0, -1,
       CONCAT(`class`.`name`, ' Jewel Upgrade Tier ', `rank`.`id`),
       54319, 4, 64, 1, 0, 0,
       0, `class`.`mask`, -1, 20,
       20, 0, 1, @BLACK_ROSE_UPGRADE_USE,
       0, 1000, 1,
       CONCAT('Use to empower ', `class`.`name`,
              ' Jewel. The class effect is reserved for a later pass.'),
       -1, 'item_black_rose_gem_upgrade', 0
  FROM (
       SELECT 0 AS `id`, 'Warrior' AS `name`, 1 AS `mask`
       UNION ALL SELECT 1, 'Paladin', 2
       UNION ALL SELECT 2, 'Hunter', 4
       UNION ALL SELECT 3, 'Rogue', 8
       UNION ALL SELECT 4, 'Priest', 16
       UNION ALL SELECT 5, 'Death Knight', 32
       UNION ALL SELECT 6, 'Shaman', 64
       UNION ALL SELECT 7, 'Mage', 128
       UNION ALL SELECT 8, 'Warlock', 256
       UNION ALL SELECT 9, 'Druid', 1024
       ) AS `class`
 CROSS JOIN (
       SELECT 2 AS `id` UNION ALL SELECT 3 UNION ALL SELECT 4
       UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7
       ) AS `rank`;

REPLACE INTO `spellitemenchantment_dbc`
    (`ID`, `Charges`, `Effect_1`, `Effect_2`, `Effect_3`,
     `EffectPointsMin_1`, `EffectPointsMin_2`, `EffectPointsMin_3`,
     `EffectPointsMax_1`, `EffectPointsMax_2`, `EffectPointsMax_3`,
     `EffectArg_1`, `EffectArg_2`, `EffectArg_3`, `Name_Lang_enUS`,
     `Name_Lang_enGB`, `Name_Lang_Mask`, `ItemVisual`, `Flags`,
     `Src_ItemID`, `Condition_Id`, `RequiredSkillID`, `RequiredSkillRank`,
     `MinLevel`)
SELECT @JEWEL_GEM_BASE + `class`.`id` * 10 + `rank`.`id`,
       0, 0, 0, 0,
       0, 0, 0,
       0, 0, 0,
       0, 0, 0,
       CONCAT(`class`.`name`, ' Jewel'),
       CONCAT(`class`.`name`, ' Jewel'),
       1, 0, 0,
       @JEWEL_GEM_BASE + `class`.`id` * 10 + `rank`.`id`,
       0, 0, 0, 0
  FROM (
       SELECT 0 AS `id`, 'Warrior' AS `name`
       UNION ALL SELECT 1, 'Paladin'
       UNION ALL SELECT 2, 'Hunter'
       UNION ALL SELECT 3, 'Rogue'
       UNION ALL SELECT 4, 'Priest'
       UNION ALL SELECT 5, 'Death Knight'
       UNION ALL SELECT 6, 'Shaman'
       UNION ALL SELECT 7, 'Mage'
       UNION ALL SELECT 8, 'Warlock'
       UNION ALL SELECT 9, 'Druid'
       ) AS `class`
 CROSS JOIN (
       SELECT 0 AS `id` UNION ALL SELECT 1 UNION ALL SELECT 2
       UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
       UNION ALL SELECT 6
       ) AS `rank`;

REPLACE INTO `gemproperties_dbc`
    (`ID`, `Enchant_Id`, `Maxcount_Inv`, `Maxcount_Item`, `Type`)
SELECT @JEWEL_GEM_BASE + `class`.`id` * 10 + `rank`.`id`,
       @JEWEL_GEM_BASE + `class`.`id` * 10 + `rank`.`id`,
       0,
       0,
       8
  FROM (
       SELECT 0 AS `id` UNION ALL SELECT 1 UNION ALL SELECT 2
       UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
       UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8
       UNION ALL SELECT 9
       ) AS `class`
 CROSS JOIN (
       SELECT 0 AS `id` UNION ALL SELECT 1 UNION ALL SELECT 2
       UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
       UNION ALL SELECT 6
       ) AS `rank`;

REPLACE INTO `npc_vendor`
    (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`,
     `VerifiedBuild`)
SELECT @ROSY,
       500 + `class`.`id`,
       @JEWEL_GEM_BASE + `class`.`id` * 10,
       0,
       0,
       @THORN_EXT_BASE,
       0
  FROM (
       SELECT 0 AS `id` UNION ALL SELECT 1 UNION ALL SELECT 2
       UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
       UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8
       UNION ALL SELECT 9
       ) AS `class`;

REPLACE INTO `conditions`
    (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`,
     `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`,
     `ConditionValue1`, `ConditionValue2`, `ConditionValue3`,
     `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`,
     `Comment`)
SELECT 23, @ROSY,
       @JEWEL_GEM_BASE + `class`.`id` * 10,
       0, 0, 2, 0,
       @BLACK_ROSE_TRINKET, 1, 0,
       0, 0, 0, '',
       'Rosy sells Black Rose Jewels only to players with The Black Rose'
  FROM (
       SELECT 0 AS `id` UNION ALL SELECT 1 UNION ALL SELECT 2
       UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
       UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8
       UNION ALL SELECT 9
       ) AS `class`;

-- ----------------------------------------------------------------------------
-- Tier unlock and repeatable reward support. Objectives are placeholders.
-- ----------------------------------------------------------------------------
REPLACE INTO `quest_template`
    (`ID`, `QuestType`, `QuestSortID`, `QuestLevel`, `MinLevel`, `Flags`,
     `RewardItem1`, `RewardAmount1`, `RewardItem2`, `RewardAmount2`,
     `RewardItem3`, `RewardAmount3`, `AllowableRaces`, `LogTitle`,
     `LogDescription`, `QuestDescription`, `QuestCompletionLog`,
     `VerifiedBuild`)
VALUES
    (@QUEST_UNLOCK_T5, 2, -@BLACK_ROSE_SORT, 60, 60, 0,
     0, 0, 0, 0,
     0, 0, 0, 'Black Rose: Tier 5 Unlock',
     'Placeholder unlock support for Tier 5 Black Rose upgrades.',
     'The Tier 5 Black Rose unlock objective will be designed later.',
     'Return to the Black Rose when the Tier 5 trial is complete.', 0),
    (@QUEST_UNLOCK_T6, 2, -@BLACK_ROSE_SORT, 70, 70, 0,
     0, 0, 0, 0,
     0, 0, 0, 'Black Rose: Tier 6 Unlock',
     'Placeholder unlock support for Tier 6 Black Rose upgrades.',
     'The Tier 6 Black Rose unlock objective will be designed later.',
     'Return to the Black Rose when the Tier 6 trial is complete.', 0),
    (@QUEST_UNLOCK_T7, 2, -@BLACK_ROSE_SORT, 80, 80, 0,
     0, 0, 0, 0,
     0, 0, 0, 'Black Rose: Tier 7 Unlock',
     'Placeholder unlock support for Tier 7 Black Rose upgrades.',
     'The Tier 7 Black Rose unlock objective will be designed later.',
     'Return to the Black Rose when the Tier 7 trial is complete.', 0),
    (@QUEST_DAILY, 2, -@BLACK_ROSE_SORT, 80, 20, 4096,
     @BLACK_MIASMA, 1, @BLACK_PETALS, 1,
     @BLACK_THORNS, 1, 0, 'Black Rose: Daily Tribute',
     'Daily placeholder reward support for Black Rose currencies.',
     'The daily tribute objective will be designed later.',
     'Return to the Black Rose when the daily tribute is complete.', 0),
    (@QUEST_WEEKLY, 2, -@BLACK_ROSE_SORT, 80, 20, 32768,
     @BLACK_MIASMA, 2, @BLACK_PETALS, 2,
     @BLACK_THORNS, 2, 0, 'Black Rose: Weekly Tribute',
     'Weekly placeholder reward support for Black Rose currencies.',
     'The weekly tribute objective will be designed later.',
     'Return to the Black Rose when the weekly tribute is complete.', 0);

REPLACE INTO `quest_template_addon` (`ID`, `SpecialFlags`)
VALUES
    (@QUEST_UNLOCK_T5, 0),
    (@QUEST_UNLOCK_T6, 0),
    (@QUEST_UNLOCK_T7, 0),
    (@QUEST_DAILY, 1),
    (@QUEST_WEEKLY, 1);

REPLACE INTO `quest_request_items`
    (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `CompletionText`,
     `VerifiedBuild`)
VALUES
    (@QUEST_UNLOCK_T5, 1, 0,
     'Has the Rose taught you the next shape?', 0),
    (@QUEST_UNLOCK_T6, 1, 0,
     'Has the Rose taught you the next shape?', 0),
    (@QUEST_UNLOCK_T7, 1, 0,
     'Has the Rose taught you the next shape?', 0),
    (@QUEST_DAILY, 1, 0,
     'Does the daily tribute rest in your hands?', 0),
    (@QUEST_WEEKLY, 1, 0,
     'Does the weekly tribute rest in your hands?', 0);

REPLACE INTO `quest_offer_reward`
    (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`,
     `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`,
     `VerifiedBuild`)
VALUES
    (@QUEST_UNLOCK_T5, 1, 0, 0, 0, 0,
     0, 0, 0, 'The fifth bloom opens. Tier 5 upgrades are yours.', 0),
    (@QUEST_UNLOCK_T6, 1, 0, 0, 0, 0,
     0, 0, 0, 'The sixth bloom opens. Tier 6 upgrades are yours.', 0),
    (@QUEST_UNLOCK_T7, 1, 0, 0, 0, 0,
     0, 0, 0, 'The seventh bloom opens. Tier 7 upgrades are yours.', 0),
    (@QUEST_DAILY, 1, 0, 0, 0, 0,
     0, 0, 0, 'A small tribute. The Rose remembers.', 0),
    (@QUEST_WEEKLY, 1, 0, 0, 0, 0,
     0, 0, 0, 'A greater tribute. The Rose remembers.', 0);
