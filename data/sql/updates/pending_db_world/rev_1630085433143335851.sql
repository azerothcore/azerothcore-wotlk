INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630085433143335851');

-- Add lootid for Ur'dan

DELETE FROM `creature_template` WHERE (`entry` = 14522);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES
(14522, 0, 0, 0, 0, 0, 14564, 0, 0, 0, 'Ur\'dan', NULL, NULL, 0, 54, 54, 0, 1434, 129, 1, 1.14286, 1, 0, 0, 1, 2000, 2000, 1, 1, 2, 32768, 2048, 0, 0, 0, 0, 0, 0, 7, 0, 14522, 0, 0, 0, 0, 100, 136, '', 0, 3, 1, 1.3, 1, 1, 0, 0, 1, 0, 0, 0, '', 12340);

-- Change drop rate

DELETE FROM `creature_loot_template` WHERE (`Entry` = 7118) AND (`Item` IN (13140));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(7118, 13140, 0, 5.6, 0, 1, 0, 1, 1, 'Jaedenar Darkweaver - Blood Red Key');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 7120) AND (`Item` IN (13140));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(7120, 13140, 0, 5.7, 0, 1, 0, 1, 1, 'Jaedenar Warlock - Blood Red Key');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 7114) AND (`Item` IN (13140));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(7114, 13140, 0, 6.2, 0, 1, 0, 1, 1, 'Jaedenar Enforcer - Blood Red Key');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 14523) AND (`Item` IN (13140));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14523, 13140, 0, 4, 0, 1, 0, 1, 1, 'Ulathek - Blood Red Key');
 
DELETE FROM `creature_loot_template` WHERE (`Entry` = 14522) AND (`Item` IN (13140));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14522, 13140, 0, 3.7, 0, 1, 0, 1, 1, 'Ur\'dan - Blood Red Key');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 9862) AND (`Item` IN (13140));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(9862, 13140, 0, 3.1, 0, 1, 0, 1, 1, 'Jaedenar Legionnaire - Blood Red Key');
