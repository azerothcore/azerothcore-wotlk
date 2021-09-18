-- Put only sql data in this file (insert, update, replace into, delete etc...).

DELETE FROM `item_template` WHERE `entry` = 5621798;
INSERT INTO `item_template` (`entry`, `name`, `displayid`, `Quality`, `stackable`, `spellid_1`, `spellcooldown_1`, `description`, `ScriptName`)
    VALUES (5621798, 'Loot Box', 12331, 6, 250, 7931299, 1000, "I can't believe it's not gambling!", 'LootBoxItem');

UPDATE `item_template`
    SET `name` = 'Macaroon', `displayid` = 51567, `maxcount` = 2147483647, `stackable` = 2147483647, `description` = 'Time is money, friend.'
    WHERE entry = 37711;

UPDATE `item_template`
    SET `bonding` = 0, `maxcount` = 0
    WHERE `entry` IN (45037, 19160, 33223, 32588, 46779, 54455);

DELETE FROM `creature_model_info` WHERE `DisplayID` = 7359065;
INSERT INTO `creature_model_info` (`DisplayID`, `CombatReach`, `Gender`)
    VALUES (7359065, 1.5, 1);

DELETE FROM `creature_template` WHERE `entry` = 5126979;
INSERT INTO `creature_template` (
        `entry`, `modelid1`, `name`, `subname`, `gossip_menu_id`, `minlevel`,
        `maxlevel`, `faction`, `npcflag`, `DamageModifier`, `BaseAttackTime`,
        `RangeAttackTime`, `unit_class`, `unit_flags`, `unit_flags2`, `type`,
        `flags_extra`, `VerifiedBuild`
    ) VALUES (
        5126979, 7359065, 'Winzig', 'Wobbling Goblin', 0, 60, 60, 35, 128, 1,
        2000, 2000, 4, 768, 2048, 7, 2, 12340
    );
-- Replace Landro Longshot.
UPDATE `creature` SET `id` = 5126979, `modelid` = 7359065 WHERE `id` = 17249 AND `modelid` = 16941;
-- Rename `subname` of the two guards.
UPDATE `creature_template` SET `subname` = 'Wobbling Goblin' WHERE `entry` = 21045;

-- Populate Winzig's stock.
DELETE FROM `npc_vendor` WHERE `entry` = 5126979;
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `ExtendedCost`) VALUES
    (5126979, 0, 5621798, 3870077), -- Loot Box
    (5126979, 1, 3386, 3870075), -- Potion of Curing
    (5126979, 2, 6048, 3870075), -- Shadow Protection Potion
    (5126979, 3, 3388, 3870075), -- Strong Troll's Blood Elixir
    (5126979, 4, 45621, 3870075), -- Elixir of Minor Accuracy
    (5126979, 5, 4496, 3870076), -- Small Brown Pouch
    (5126979, 6, 4498, 3870077); -- Brown Leather Satchel
