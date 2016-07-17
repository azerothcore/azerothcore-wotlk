-- Quartermaster Ozorg (Dk start set vendor)
-- FRIENDLY
DELETE FROM `creature_template` WHERE (entry = 100100);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES
(100100, 0, 0, 0, 0, 0, 16214, 0, 0, 0, 'Quartermaster Ozorg', 'Acherus Quartermaster', '', 0, 72, 72, 1, 35, 128, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 33555202, 2048, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 4, 1, 1, 0, 0, 1, 0, 128, '', 12340);

-- requires friendly with azerothshard (3000 rep)
UPDATE creature_template SET resistance2 = 3000, `npcflag` = 129, `unit_flags` = 514, `type_flags` = 0, `flags_extra` = 0, scriptname = "npc_azth_vendor" WHERE entry = 100100; 

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
(100100, 38147, 100003),
(100100, 136942, 1002000); -- ring