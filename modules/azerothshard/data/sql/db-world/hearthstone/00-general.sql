-- FULL `creature_template` of entry 100000
DELETE FROM `creature_template` WHERE (entry = 100000);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES
(100000, 0, 0, 0, 0, 0, 23055, 0, 0, 0, 'Han\'al', 'Master Lorekeeper', NULL, 30000, 83, 83, 0, 2007, 3, 1.1, 1.5, 1.2, 1, 0, 0, 0, 8, 33536, 2048, 0, 0, 0, 0, 0, 0, 7, 32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 0, 10, 10, 1, 0, 0, 1, 0, 2, 'npc_han_al', 12341);

DELETE FROM npc_text WHERE ID IN (100000, 100001, 100002, 100003);
INSERT INTO npc_text (ID, text0_0, text0_1, lang0, Prob0, em0_0) VALUES 
(100000, "È bello che tu voglia aiutarmi $N, la storia dev'essere scrupolosamente registrata... nulla deve andar perso!", 0, 0,100, 0),
(100001, "Hai già delle missioni da completare, ritorna quando sarai riuscito a portarle a termine o quando avrai rinunciato...\nNonostante il fallimento potrei avere ancora bisogno di te, $R", 0, 0,100, 0),
(100002, "Grazie del tuo aiuto, $C, per oggi mi hai aiutato a sufficienza!\nRitorna domani.", 0, 0,100, 0),
(100003, "Hai già molto lavoro da fare, $N. Non vorrei che ti affaticassi troppo... torna da me quando avrai concluso un po' del tuo lavoro.", 0, 0,100, 0);

UPDATE `item_template` SET `Flags` = 64, `ScriptName` = 'item_azth_hearthstone_loot_sack', stackable = 1, `spellid_1` = 36177, maxcount = 5 WHERE (entry = 32558);


-- VENDORS (DEBUG)
-- NEUTRAL
DELETE FROM `creature_template` WHERE (entry = 100002);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES
(100002, 0, 0, 0, 0, 0, 22439, 0, 0, 0, 'Azth Neutral Vendor', 'AzerothShard', '', 0, 70, 70, 1, 35, 128, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 33555202, 2048, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 4, 1, 1, 0, 0, 1, 0, 128, '', 12340);

-- FRIENDLY
DELETE FROM `creature_template` WHERE (entry = 100003);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES
(100003, 0, 0, 0, 0, 0, 22439, 0, 0, 0, 'Azth Friendly Vendor', 'AzerothShard', '', 0, 70, 70, 1, 35, 128, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 33555202, 2048, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 4, 1, 1, 0, 0, 1, 0, 128, '', 12340);

-- HONORED
DELETE FROM `creature_template` WHERE (entry = 100004);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES
(100004, 0, 0, 0, 0, 0, 22439, 0, 0, 0, 'Azth Honored Vendor', 'AzerothShard', '', 0, 70, 70, 1, 35, 128, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 33555202, 2048, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 4, 1, 1, 0, 0, 1, 0, 128, '', 12340);

-- REVERED
DELETE FROM `creature_template` WHERE (entry = 100005);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES
(100005, 0, 0, 0, 0, 0, 22439, 0, 0, 0, 'Azth Revered Vendor', 'AzerothShard', '', 0, 70, 70, 1, 35, 128, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 33555202, 2048, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 4, 1, 1, 0, 0, 1, 0, 128, '', 12340);

-- EXALTED
DELETE FROM `creature_template` WHERE (entry = 100006);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES
(100006, 0, 0, 0, 0, 0, 22439, 0, 0, 0, 'Azth Exalted Vendor', 'AzerothShard', '', 0, 70, 70, 1, 35, 128, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 33555202, 2048, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 4, 1, 1, 0, 0, 1, 0, 128, '', 12340);

UPDATE creature_template SET resistance2 = 0 WHERE entry = 100002;
UPDATE creature_template SET resistance2 = 3000 WHERE entry = 100003;
UPDATE creature_template SET resistance2 = 6000 WHERE entry = 100004;
UPDATE creature_template SET resistance2 = 12000 WHERE entry = 100005;
UPDATE creature_template SET resistance2 = 21000 WHERE entry = 100006;

UPDATE creature_template SET  `npcflag` = 129, `unit_flags` = 768, `type_flags` = 134217728, `flags_extra` = 2, scriptname = "npc_azth_vendor", resistance1 = 32001, gossip_menu_id = 32001 WHERE entry IN (100002, 100003, 100004, 100005, 100006);


-- END VENDORS DEBUG

-- DEBUG ONLY
DELETE FROM npc_vendor WHERE entry IN (100002, 100003, 100004, 100005, 100006, 100007);
INSERT INTO npc_vendor (entry, item, extendedcost) VALUES 
(100002, 32558, 100010),
(100003, 32558, 100009),
(100004, 32558, 100008),
(100004, 32558, 100007),
(100005, 32558, 100006),
(100006, 32558, 100005),
(100003, 49426, 100005),
(100003, 47241, 100004),
(100003, 45624, 100003),
(100003, 40753, 100002),
(100003, 49752, 100001);
