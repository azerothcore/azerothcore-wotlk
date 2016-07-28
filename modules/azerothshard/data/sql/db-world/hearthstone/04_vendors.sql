DELETE FROM npc_text WHERE ID IN (32001, 32002);
INSERT INTO npc_text (ID, text0_0, text0_1, lang0, Prob0, em0_0) VALUES 
(32001, "Qui si paga in Marks of Azeroth!", 0, 0, 100, 0),
(32002, "Ti serve più reputazione!", 0, 0, 100, 0);

-- Quartermaster Ozorg (Dk start set vendor)
-- FRIENDLY
DELETE FROM `creature_template` WHERE (entry = 100100);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES
(100100, 0, 0, 0, 0, 0, 16214, 0, 0, 0, 'Quartermaster Ozorg', 'Acherus Quartermaster', '', 0, 72, 72, 1, 35, 128, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 33555202, 2048, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 4, 1, 1, 0, 0, 1, 0, 128, '', 12340);

-- requires friendly with azerothshard (3000 rep)
UPDATE creature_template SET resistance2 = 3000, `npcflag` = 129, `unit_flags` = 768, `type_flags` = 134217728, `flags_extra` = 2, scriptname = "npc_azth_vendor", `type` = 6  WHERE entry = 100100; 

DELETE FROM npc_vendor WHERE entry = 100100;
INSERT INTO npc_vendor (entry, item, extendedcost) VALUES 
(100100, 38632, 100030), -- weapon
(100100, 38633, 100030), -- weapon
(100100, 38661, 100020), -- head
(100100, 38662, 100005), -- neck
(100100, 38663, 100015), -- shoulder
(100100, 38664, 100010), -- back
(100100, 38665, 100020), -- chest
(100100, 38666, 100010), -- bracer
(100100, 38667, 100015), -- hands
(100100, 38668, 100010), -- waist
(100100, 38669, 100020), -- leg
(100100, 38670, 100010), -- feet
(100100, 38671, 100005), -- ring
(100100, 38672, 100005), -- ring
(100100, 38674, 100005), -- trinket
(100100, 38675, 100005), -- trinket
(100100, 39320, 100010), -- back
(100100, 39322, 100010), -- back
(100100, 38707, 100030), -- weapon
(100100, 34648, 100008), -- feet
(100100, 34649, 100012), -- hands
(100100, 34650, 100016), -- chest
(100100, 34651, 100008), -- waist
(100100, 34652, 100018), -- head
(100100, 34653, 100008), -- wrist
(100100, 34655, 100012), -- shoulder
(100100, 34656, 100016), -- leg
(100100, 34657, 100003), -- neck
(100100, 34658, 100003), -- ring
(100100, 34659, 100008), -- back
(100100, 34661, 100030), -- weapon
(100100, 38147, 100003); -- ring 

-- gossip id inside resistance1 to send the vendor with the gossip
UPDATE creature_template SET resistance1 = 32000, gossip_menu_id = 32001 WHERE entry = 100100;

DELETE FROM npc_text WHERE ID = 32000;
INSERT INTO npc_text (ID, text0_0, text0_1, lang0, Prob0, em0_0) VALUES 
(32000, "Se tu vuoi comprare, tu dare me Marks of Azeroth!", 0, 0, 100, 0);

UPDATE creature_template SET MovementType = 1 WHERE entry = 100100; -- set some random movement

-- T3 Vendor
-- HONORED
DELETE FROM `creature_template` WHERE (entry = 100101);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES
(100101, 0, 0, 0, 0, 0, 10478, 0, 0, 0, 'Lord Raymond George', 'The Argent Dawn', '', 0, 72, 72, 1, 35, 128, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 33555202, 2048, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 4, 1, 1, 0, 0, 1, 0, 128, '', 12340);

-- requires friendly with azerothshard (3000 rep)
UPDATE creature_template SET resistance2 = 6000, `npcflag` = 129, `unit_flags` = 768, `type_flags` = 134217728, `flags_extra` = 2, scriptname = "npc_azth_vendor", `type` = 6  WHERE entry = 100101; 

DELETE FROM npc_vendor WHERE entry = 100101;
INSERT INTO npc_vendor (entry, item, extendedcost) VALUES 
(100101, 22349, 100100),
(100101, 22350, 100100),
(100101, 22351, 100100),
(100101, 22352, 100100),
(100101, 22353, 100100),
(100101, 22354, 100080),
(100101, 22355, 100050),
(100101, 22356, 100050),
(100101, 22357, 100080),
(100101, 22358, 100050),
(100101, 22359, 100100),
(100101, 22360, 100100),
(100101, 22361, 100080),
(100101, 22362, 100050),
(100101, 22363, 100050),
(100101, 22364, 100080),
(100101, 22365, 100050),
(100101, 22366, 100100),
(100101, 22367, 100100),
(100101, 22368, 100080),
(100101, 22369, 100050),
(100101, 22370, 100050),
(100101, 22371, 100050),
(100101, 22372, 100050),
(100101, 22373, 100010),
(100101, 22374, 100010),
(100101, 22375, 100010),
(100101, 22376, 100010);

-- gossip id inside resistance1 to send the vendor with the gossip
UPDATE creature_template SET resistance1 = 32002, gossip_menu_id = 32001 WHERE entry = 100101;

DELETE FROM npc_text WHERE ID = 32002;
INSERT INTO npc_text (ID, text0_0, text0_1, lang0, Prob0, em0_0) VALUES 
(32002, "Salve, $N. Sei qui per aiutare gli Argent Dawn? I tuoi Marks of Azeroth saranno estremamente utili per le nostre spese...", 0, 0, 100, 0);

-- Heirloom Vendor
-- Neutral
DELETE FROM `creature_template` WHERE (entry = 100102);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES
(100102, 0, 0, 0, 0, 0, 3709, 0, 0, 0, 'Arsenio', '', '', 0, 80, 80, 1, 35, 128, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 33555202, 2048, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 4, 1, 1, 0, 0, 1, 0, 128, '', 12340);

-- requires neutral with azerothshard (0 rep)
UPDATE creature_template SET resistance2 = 0, `npcflag` = 129, `unit_flags` = 768, `type_flags` = 134217728, 
`flags_extra` = 2, scriptname = "npc_azth_vendor", `type` = 6 WHERE entry = 100102; 

DELETE FROM npc_vendor WHERE entry = 100102;
INSERT INTO npc_vendor (entry, item, extendedcost) VALUES 
(100102,'42943', 100030),
(100102,'42944', 100030),
(100102,'42945', 100030),
(100102,'42946', 100030),
(100102,'42947', 100030),
(100102,'42948', 100030),
(100102,'42949', 100030),
(100102,'42950', 100030),
(100102,'42951', 100030),
(100102,'42952', 100030),
(100102,'42984', 100030),
(100102,'42985', 100030),
(100102,'42991', 100030),
(100102,'42992', 100030),
(100102,'44091', 100030),
(100102,'44092', 100030),
(100102,'44093', 100030),
(100102,'44094', 100030),
(100102,'44095', 100030),
(100102,'44096', 100030),
(100102,'44097', 100030),
(100102,'44098', 100030),
(100102,'44099', 100030),
(100102,'44100', 100030),
(100102,'44101', 100030),
(100102,'44102', 100030),
(100102,'44103', 100030),
(100102,'44105', 100030),
(100102,'44107', 100030),
(100102,'48685', 100030),
(100102,'48691', 100030),
(100102,'48677', 100030),
(100102,'48687', 100030),
(100102,'48689', 100030),
(100102,'48683', 100030),
(100102,'48716', 100030),
(100102,'48718', 100030),
(100102,'50255', 100030);

-- gossip id inside resistance1 to send the vendor with the gossip
UPDATE creature_template SET resistance1 = 32003, gossip_menu_id = 32001 WHERE entry = 100102;

DELETE FROM npc_text WHERE ID = 32003;
INSERT INTO npc_text (ID, text0_0, text0_1, lang0, Prob0, em0_0) VALUES 
(32003, "Hey, tu! Vuoi un po' di roba? L'ho rubat.. ricevuta giusto ieri... In cambio ti chiedo solo qualche Mark of Azeroth per delle... ehm.. ricerche...", 0, 0, 100, 0);