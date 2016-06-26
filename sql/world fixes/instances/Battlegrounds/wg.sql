
-- ----------------------------------------
-- OURS FIXES, contains self and corrected TC fixes
-- ----------------------------------------

-- Missile Spells, reduce damage by distance
DELETE FROM spell_script_names WHERE spell_id IN(57610, 57607, 50999, 51422);
INSERT INTO spell_script_names VALUES (57610, 'spell_wg_reduce_damage_by_distance');
INSERT INTO spell_script_names VALUES (57607, 'spell_wg_reduce_damage_by_distance');
INSERT INTO spell_script_names VALUES (50999, 'spell_wg_reduce_damage_by_distance');
INSERT INTO spell_script_names VALUES (51422, 'spell_wg_reduce_damage_by_distance');


-- Add Trinity String for Spirit Guide and wintergrasp battle mage
DELETE FROM trinity_string WHERE entry IN (20071, 20072, 20074, 20073, 20070, 20075, 20076, 20077, 20078);
INSERT INTO trinity_string(`entry`,`content_default`) VALUES 
(20071, 'Guide me to the Sunken Ring Graveyard.'),
(20072, 'Guide me to the Broken Temple Graveyard.'),
(20074, 'Guide me to the Eastspark Graveyard.'),
(20073, 'Guide me to the Westspark Graveyard.'),
(20070, 'Guide me to the Fortress Graveyard.'),
(20075, 'Guide me back to the Horde landing camp.'),
(20076, 'Guide me back to the Alliance landing camp.'),
(20077, 'Queue for Wintergrasp.'),
(20078, '|cffff0000[Wintergrasp]:|r Battle started!|r');

-- Correct Alliance Fueling The Demolishers quest data
UPDATE creature_template SET AIName='', ScriptName='npc_wg_quest_giver' WHERE entry=31108;
UPDATE quest_template SET RequiredRaces=1101, ExclusiveGroup=13153 WHERE Id=236;
DELETE FROM creature_queststarter WHERE quest IN(13197, 236);
DELETE FROM creature_questender WHERE quest IN(13197, 236);
INSERT INTO creature_queststarter VALUES (31108, 236),(31108, 13197);
INSERT INTO creature_questender VALUES (31108, 236),(31108, 13197);

-- Senior Demolitionist Legoso (31109)
UPDATE creature_template SET AIName='', ScriptName='npc_wg_quest_giver' WHERE entry=31109;


-- Quest Pools, Wintergrasp weeklies (pool defender verion only)
-- Alliance
DELETE FROM pool_quest WHERE entry IN(13154, 13196, 13156, 13195, 236, 13197, 13153, 13198);
INSERT INTO pool_quest VALUES(13154, 385, "Bones and Arrows");
-- INSERT INTO pool_quest VALUES(13196, 385, "Bones and Arrows");
INSERT INTO pool_quest VALUES(13156, 385, "A Rare Herb");
-- INSERT INTO pool_quest VALUES(13195, 385, "A Rare Herb");
INSERT INTO pool_quest VALUES(236, 385, "Fueling the Demolishers");
-- INSERT INTO pool_quest VALUES(13197, 385, "Fueling the Demolishers");
INSERT INTO pool_quest VALUES(13153, 385, "Warding the Warriors");
-- INSERT INTO pool_quest VALUES(13198, 385, "Warding the Warriors");
DELETE FROM pool_template WHERE description="Wintergrasp Alliance Weeklies";
INSERT INTO pool_template VALUES(385, 1, "Wintergrasp Alliance Weeklies");
-- Horde
DELETE FROM pool_quest WHERE entry IN(13193, 13199, 13191, 13200, 13194, 13201, 13192, 13202);
INSERT INTO pool_quest VALUES(13193, 384, "Bones and Arrows");
-- INSERT INTO pool_quest VALUES(13199, 384, "Bones and Arrows");
INSERT INTO pool_quest VALUES(13191, 384, "Fueling the Demolishers");
-- INSERT INTO pool_quest VALUES(13200, 384, "Fueling the Demolishers");
INSERT INTO pool_quest VALUES(13194, 384, "Healing with Roses");
-- INSERT INTO pool_quest VALUES(13201, 384, "Healing with Roses");
INSERT INTO pool_quest VALUES(13192, 384, "Warding the Walls");
-- INSERT INTO pool_quest VALUES(13202, 384, "Jinxing the Walls");
DELETE FROM pool_template WHERE description="Wintergrasp Horde Weeklies";
INSERT INTO pool_template VALUES(384, 1, "Wintergrasp Horde Weeklies");

-- TC, remove some unused scripts
DELETE FROM spell_script_names WHERE ScriptName IN('spell_wintergrasp_defender_teleport', 'spell_wintergrasp_defender_teleport_trigger', 'spell_wintergrasp_grab_passenger');

-- Fix teleporters
DELETE FROM spell_linked_spell WHERE spell_trigger=54640;
INSERT INTO spell_linked_spell VALUES (54640, 54643, 0, 'WG teleporter');

-- Correct Queue npcs
UPDATE creature_template SET npcflag=npcflag|1 WHERE ScriptName='npc_wg_queue';

-- Arcanist Braedin <Wintergrasp Battle-Mage> (32169)
DELETE FROM creature_text WHERE entry=32169;
INSERT INTO creature_text VALUES(32169, 0, 0, 'Reinforcements are needed on the Wintergrasp battlefield! I have opened a portal for quick travel to the battle at The Silver Enclave.', 14, 0, 100, 0, 0, 0, 2, 'Arcanist Braedin');

-- Magister Surdiel <Wintergrasp Battle-Mage> (32170)
DELETE FROM creature_text WHERE entry=32170;
INSERT INTO creature_text VALUES(32170, 0, 0, 'The battle for control of Wintergrasp will begin in 5 minutes! Prepare yourselves for battle!', 14, 0, 100, 0, 0, 0, 2, 'Magister Surdiel');

-- Wrong Gossip
REPLACE INTO gossip_menu_option VALUES (10662, 0, 19, 'Queue for Wintergrasp.', 12, 1, 0, 0, 0, 0, '');
REPLACE INTO gossip_menu_option VALUES (10666, 0, 19, 'Queue for Wintergrasp.', 12, 1, 0, 0, 0, 0, '');

-- Hide small elementals during battle
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(30842, 30845, 30846, 30847, 30849));
REPLACE INTO creature_template_addon VALUES(30842, 0, 0, 0, 1, 0, '52107');
REPLACE INTO creature_template_addon VALUES(30845, 0, 0, 0, 1, 0, '52107');
REPLACE INTO creature_template_addon VALUES(30846, 0, 0, 0, 1, 0, '52107');
REPLACE INTO creature_template_addon VALUES(30847, 0, 0, 0, 1, 0, '52107');
REPLACE INTO creature_template_addon VALUES(30849, 0, 0, 0, 1, 0, '42617 52107');
DELETE FROM spell_script_names WHERE spell_id=52107;
INSERT INTO spell_script_names VALUES(52107, 'spell_wintergrasp_hide_small_elementals');

-- add vendor entries, wg mark of honor -> wg commendation
REPLACE INTO npc_vendor VALUES(32296, 0, 44115, 0, 0, 2576);
REPLACE INTO npc_vendor VALUES(32294, 0, 44115, 0, 0, 2576);

-- fix turrets orientation
UPDATE creature_template SET unit_flags=unit_flags|4, ScriptName="" WHERE entry=28366;

-- Remove unused KillCredit1
UPDATE creature_template SET KillCredit1=0 WHERE KillCredit1=31093;

-- Horde Guard - Fix faction
UPDATE creature_template SET faction=2132 WHERE entry=30739;

-- Add Player Loot for WG quests
DELETE FROM creature_loot_template WHERE entry=1 AND item IN(43314, 43322, 43323, 43324, 44808, 44809);
INSERT INTO creature_loot_template VALUES(1, 43314, -100, 1, 0, 5, 5);
INSERT INTO creature_loot_template VALUES(1, 43322, -100, 1, 0, 5, 5);
INSERT INTO creature_loot_template VALUES(1, 43323, -100, 1, 0, 5, 5);
INSERT INTO creature_loot_template VALUES(1, 43324, -100, 1, 0, 5, 5);
INSERT INTO creature_loot_template VALUES(1, 44808, -100, 1, 0, 5, 5);
INSERT INTO creature_loot_template VALUES(1, 44809, -100, 1, 0, 5, 5);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=1 AND SourceGroup=1 AND SourceEntry IN(43314, 43322, 43323, 43324, 44808, 44809);
INSERT INTO conditions VALUES(1, 1, 44808, 0, 0, 23, 0, 4585, 0, 0, 0, 0, 0, '', 'Requires Glacial Falls area');
INSERT INTO conditions VALUES(1, 1, 43322, 0, 0, 23, 0, 4585, 0, 0, 0, 0, 0, '', 'Requires Glacial Falls area');
INSERT INTO conditions VALUES(1, 1, 43314, 0, 0, 23, 0, 4584, 0, 0, 0, 0, 0, '', 'Requires Cauldron of Flames area');
INSERT INTO conditions VALUES(1, 1, 43323, 0, 0, 23, 0, 4587, 0, 0, 0, 0, 0, '', 'Requires Forest of Shadows area');
INSERT INTO conditions VALUES(1, 1, 43324, 0, 0, 23, 0, 4590, 0, 0, 0, 0, 0, '', 'Requires Steppe of Life area');
INSERT INTO conditions VALUES(1, 1, 44809, 0, 0, 23, 0, 4590, 0, 0, 0, 0, 0, '', 'Requires Steppe of Life area');

-- Update spellclicks for vehicles (gear scaling)
DELETE FROM npc_spellclick_spells WHERE npc_entry IN(27881, 28094, 28312, 32627);
INSERT INTO npc_spellclick_spells VALUES (27881, 60968, 1, 0);
INSERT INTO npc_spellclick_spells VALUES (28094, 60968, 1, 0);
INSERT INTO npc_spellclick_spells VALUES (28312, 60968, 1, 0);
INSERT INTO npc_spellclick_spells VALUES (32627, 60968, 1, 0);
UPDATE creature_template SET AIName='', ScriptName='npc_wg_siege_machine' WHERE entry IN(27881, 28094, 28312, 32627);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=18 AND SourceGroup IN(27881, 28094, 28312, 32627);

-- fix visual arms control targetting
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=49899;
INSERT INTO conditions VALUES (13, 1, 49899, 0, 0, 31, 0, 3, 27852, 0, 0, 0, 0, '', 'Target entry 27852');
INSERT INTO conditions VALUES (13, 1, 49899, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Target must be alive');
DELETE FROM spell_scripts WHERE id=49899;
INSERT INTO spell_scripts VALUES(49899, 0, 0, 1, 416, 0, 0, 0, 0, 0, 0);


-- Conditions
-- Add gossip_menu condition for 9904 Horde
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=9904;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=9923;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=9904;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=9923;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`NegativeCondition`) VALUES
(14,9904,13759,0,1,33280, 0), -- Must have Rank 1: Corporal
(14,9904,13759,1,1,55629, 0), -- Or must have Rank 2: First Lieutenant
(14,9904,13761,0,1,33280, 1), -- Must not have Rank 1: Corporal
(14,9904,13761,0,1,55629, 1), -- Must not have Rank 2: First Lieutenant
-- Add gossip_menu condition for 9923 Alliance
(14,9923,13798,0,1,33280, 0), -- Must have Rank 1: Corporal
(14,9923,13798,1,1,55629, 0), -- Or must have Rank 2: First Lieutenant
(14,9923,14172,0,1,33280, 1), -- Must not have Rank 1: Corporal
(14,9923,14172,0,1,55629, 1), -- Must not have Rank 2: First Lieutenant
-- Add conditions to gossip options horde
(15,9904,0,0,1,33280, 0), -- Must have reached Rank 1: Corporal
(15,9904,0,1,1,55629, 0), -- Or must have reached Rank 2: First Lieutenant
(15,9904,1,0,1,55629, 0), -- Must have reached Rank 2: First Lieutenant
(15,9904,2,0,1,55629, 0), -- Must have reached Rank 2: First Lieutenant
-- Add conditions to gossip options alliance
(15,9923,0,0,1,33280, 0), -- Must have reached Rank 1: Corporal
(15,9923,0,1,1,55629, 0), -- Or must have reached Rank 2: First Lieutenant
(15,9923,1,0,1,55629, 0), -- Must have reached Rank 2: First Lieutenant
(15,9923,2,0,1,55629, 0); -- Must have reached Rank 2: First Lieutenant

-- Spell area for filight zone and essence of Wintergrasp
DELETE FROM `spell_area` WHERE `spell` IN (58730,57940,58045);
INSERT INTO `spell_area` (`spell`,`area`,`quest_start`,`quest_end`,`aura_spell`,`racemask`,`gender`,`autocast`) VALUES
(58730,4581,0,0,0,0,2,1), -- Restricted Flight Area (Wintergrasp Eject)
(58730,4539,0,0,0,0,2,1),(58730,4197,0,0,0,0,2,1),(58730,4585,0,0,0,0,2,1),(58730,4612,0,0,0,0,2,1),(58730,4582,0,0,0,0,2,1),
(58730,4583,0,0,0,0,2,1),(58730,4589,0,0,0,0,2,1),(58730,4575,0,0,0,0,2,1),(58730,4538,0,0,0,0,2,1),(58730,4577,0,0,0,0,2,1),
(57940,65,0,0,0,0,2,1), -- Essence of Wintergrasp OUTSIDE wintergrasp
(57940,66,0,0,0,0,2,1),(57940,67,0,0,0,0,2,1),(57940,206,0,0,0,0,2,1),(57940,210,0,0,0,0,2,1),(57940,394,0,0,0,0,2,1),
(57940,395,0,0,0,0,2,1),(57940,1196,0,0,0,0,2,1),(57940,2817,0,0,0,0,2,1),(57940,3456,0,0,0,0,2,1),(57940,3477,0,0,0,0,2,1),
(57940,3537,0,0,0,0,2,1),(57940,3711,0,0,0,0,2,1),(57940,4100,0,0,0,0,2,1),(57940,4196,0,0,0,0,2,1),(57940,4228,0,0,0,0,2,1),
(57940,4264,0,0,0,0,2,1),(57940,4265,0,0,0,0,2,1),(57940,4272,0,0,0,0,2,1),(57940,4273,0,0,0,0,2,1),(57940,4395,0,0,0,0,2,1),
(57940,4415,0,0,0,0,2,1),(57940,4436,0,0,0,0,2,1),(57940,4493,0,0,0,0,2,1),(57940,4494,0,0,0,0,2,1),(57940,4603,0,0,0,0,2,1),
(57940,4277,0,0,0,0,2,1),(57940,4723,0,0,0,0,2,1),(57940,4416,0,0,0,0,2,1),(57940,480,0,0,0,0,2,1),(57940,4813,0,0,0,0,2,1),
(58045,4197,0,0,0,0,2,1); -- Essence of Wintergrasp INSIDE wintergrasp

SET @SPELL_HORDE := 56618;
SET @SPELL_ALLIANCE := 56617;

SET @AREA_SUNKEN_RING := 4538;
SET @AREA_BROKEN_TEMPLE := 4539;
SET @AREA_CHILLED_QUAGMIRE := 4589; -- chilled quagmire
SET @AREA_W_WORKSHOP := 4611;
SET @AREA_E_WORKSHOP := 4612;

DELETE FROM `spell_area` WHERE `spell` IN (@SPELL_HORDE, @SPELL_ALLIANCE);
INSERT INTO `spell_area` (`spell`,`area`,`autocast`) VALUES
(@SPELL_HORDE, @AREA_SUNKEN_RING, 1),(@SPELL_ALLIANCE, @AREA_SUNKEN_RING, 1),
(@SPELL_HORDE, @AREA_BROKEN_TEMPLE, 1),(@SPELL_ALLIANCE, @AREA_BROKEN_TEMPLE, 1),
(@SPELL_HORDE, @AREA_CHILLED_QUAGMIRE, 1),(@SPELL_ALLIANCE, @AREA_CHILLED_QUAGMIRE, 1),
(@SPELL_HORDE, @AREA_W_WORKSHOP, 1),(@SPELL_ALLIANCE, @AREA_W_WORKSHOP, 1),
(@SPELL_HORDE, @AREA_E_WORKSHOP, 1),(@SPELL_ALLIANCE, @AREA_E_WORKSHOP, 1);

-- fix NE flight in WG
REPLACE INTO spell_area VALUES(55173, 4197, 0, 0, 8326, 8, 2, 1, 64, 11);

-- fix spirit guids phasemask!
UPDATE creature SET phaseMask=16 WHERE id=31841;
UPDATE creature SET phaseMask=32 WHERE id=31842;
UPDATE creature SET phaseMask=64 WHERE guid=88314; -- fortress - needs horde control
UPDATE creature SET phaseMask=128+64 WHERE guid=88315; -- Horde outside
UPDATE creature SET phaseMask=128 WHERE guid=88320; -- fortress - needs alliance control
UPDATE creature SET phaseMask=64+128 WHERE guid=88321; -- Ally outside

-- Delete invalid trigger
DELETE FROM creature_addon WHERE guid=131724;
DELETE FROM creature WHERE guid=131724;

-- Fix trash phasemask :)
-- only controlling faction can see them
UPDATE creature SET phaseMask=256 WHERE id IN(30877, 30876, 30875, 30873, 34300, 30872);
UPDATE creature SET phaseMask=1 WHERE id IN(30845, 30849, 30842, 30846, 30848);
-- DELETE CREATURES FROM SPAWNS, SPAWNED MANUALLY BY CORE
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE map=571 AND id IN(30739,30740,31102,32296,31101,39173,31091,31151,31106,31053,31107,31052,32294,31051,
39172,31036,31153,31108,31054,31109,28312,32627,27881,28094,28366, 32616, 32617, 32618, 32619, 32620, 32621, 32622, 32623, 32624, 32625));
DELETE FROM creature WHERE map=571 AND id IN(30739,30740,31102,32296,31101,39173,31091,31151,31106,31053,31107,31052,32294,31051,
39172,31036,31153,31108,31054,31109,28312,32627,27881,28094,28366, 32616, 32617, 32618, 32619, 32620, 32621, 32622, 32623, 32624, 32625);
DELETE FROM gameobject WHERE map=571 AND id IN(190763, 192951, 190356, 190357, 190358, 191810, 190375, 191797, 191798, 191805, 190221, 190373, 190377,
190378, 190219, 190220, 191795, 191796, 191799, 191800, 191801, 191802, 191803, 191804, 191806, 191807, 191808, 191809, 190369, 190370, 190371, 190372, 
190374, 190376, 194162, 194323);

-- Fix battlemaster portals
DELETE FROM battlemaster_entry WHERE entry BETWEEN 32616 AND 32625;
INSERT INTO battlemaster_entry VALUES (32616, 1),(32617, 1),(32618, 3),(32619, 3),(32620, 7),(32621, 7),(32622, 9),(32623, 9),(32624, 2),(32625, 2);
REPLACE INTO creature_template VALUES (32616, 0, 0, 0, 0, 0, 26484, 0, 0, 0, 'Alterac Valley Portal', '', 'Interact', 0, 80, 80, 2, 534, 1048577, 1, 1, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 2147746560, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (32617, 0, 0, 0, 0, 0, 26494, 0, 0, 0, 'Alterac Valley Portal', '', 'Interact', 0, 80, 80, 2, 714, 1048577, 1, 1, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 2147746560, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (32618, 0, 0, 0, 0, 0, 26495, 0, 0, 0, 'Arathi Basin Portal', '', 'Interact', 0, 80, 80, 2, 534, 1048577, 1, 1, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 2147746560, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (32619, 0, 0, 0, 0, 0, 26496, 0, 0, 0, 'Arathi Basin Portal', '', 'Interact', 0, 80, 80, 2, 714, 1048577, 1, 1, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 2147746560, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (32620, 0, 0, 0, 0, 0, 26501, 0, 0, 0, 'Eye of the Storm Portal', '', 'Interact', 0, 80, 80, 2, 714, 1048577, 1, 1, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 2147746560, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (32621, 0, 0, 0, 0, 0, 26499, 0, 0, 0, 'Eye of the Storm Portal', '', 'Interact', 0, 80, 80, 2, 534, 1048577, 1, 1, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 2147746560, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (32622, 0, 0, 0, 0, 0, 26504, 0, 0, 0, 'Strand of the Ancients Portal', '', 'Interact', 0, 80, 80, 2, 534, 1048577, 1, 1, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 2147746560, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (32623, 0, 0, 0, 0, 0, 26505, 0, 0, 0, 'Strand of the Ancients Portal', '', 'Interact', 0, 80, 80, 2, 714, 1048577, 1, 1, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 2147746560, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (32624, 0, 0, 0, 0, 0, 26502, 0, 0, 0, 'Warsong Gulch Portal', '', 'Interact', 0, 80, 80, 2, 534, 1048577, 1, 1, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 2147746560, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (32625, 0, 0, 0, 0, 0, 26503, 0, 0, 0, 'Warsong Gulch Portal', '', 'Interact', 0, 80, 80, 2, 714, 1048577, 1, 1, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 2147746560, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);


DELETE FROM creature_addon WHERE guid=131839;
DELETE FROM creature WHERE guid=131839;

-- Add script names for build vehicle spells
-- triggered cast (creature->player)
DELETE FROM spell_script_names WHERE spell_id IN (61409, 56662, 56664, 56659, 49899);
INSERT INTO spell_script_names VALUES (61409, 'spell_wintergrasp_force_building');
INSERT INTO spell_script_names VALUES (56659, 'spell_wintergrasp_force_building');
INSERT INTO spell_script_names VALUES (56662, 'spell_wintergrasp_force_building');
INSERT INTO spell_script_names VALUES (56664, 'spell_wintergrasp_force_building');
DELETE FROM spell_script_names WHERE spell_id IN (56575, 56661, 56663, 61408);
INSERT INTO spell_script_names VALUES (56575, 'spell_wintergrasp_create_vehicle');
INSERT INTO spell_script_names VALUES (56661, 'spell_wintergrasp_create_vehicle');
INSERT INTO spell_script_names VALUES (56663, 'spell_wintergrasp_create_vehicle');
INSERT INTO spell_script_names VALUES (61408, 'spell_wintergrasp_create_vehicle');

-- RP-GG script
-- tracking spell
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(49761);
REPLACE INTO `conditions` VALUES (13, 1, 49761, 0, 0, 31, 0, 3, 28312, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 49761, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 49761, 0, 0, 34, 0, 1, 7, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 49761, 0, 1, 31, 0, 3, 32627, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 49761, 0, 1, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 49761, 0, 1, 34, 0, 1, 7, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 49761, 0, 2, 31, 0, 3, 28094, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 49761, 0, 2, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 49761, 0, 2, 34, 0, 1, 7, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 49761, 0, 3, 31, 0, 3, 27881, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 49761, 0, 3, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 49761, 0, 3, 34, 0, 1, 7, 0, 0, 0, 0, '', NULL);
-- damage spell
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(49760);
REPLACE INTO `conditions` VALUES (13, 2, 49760, 0, 0, 31, 0, 3, 28312, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 2, 49760, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 2, 49760, 0, 0, 34, 0, 1, 7, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 2, 49760, 0, 1, 31, 0, 3, 32627, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 2, 49760, 0, 1, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 2, 49760, 0, 1, 34, 0, 1, 7, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 2, 49760, 0, 2, 31, 0, 3, 28094, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 2, 49760, 0, 2, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 2, 49760, 0, 2, 34, 0, 1, 7, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 2, 49760, 0, 3, 31, 0, 3, 27881, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 2, 49760, 0, 3, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 2, 49760, 0, 3, 34, 0, 1, 7, 0, 0, 0, 0, '', NULL);

-- Wintergrasp water
DELETE FROM spell_script_names WHERE spell_id IN (36444);
INSERT INTO spell_script_names VALUES(36444, 'spell_wintergrasp_water');

-- RP-GG script :)
DELETE FROM spell_script_names WHERE spell_id IN (49761);
INSERT INTO spell_script_names VALUES(49761, 'spell_wintergrasp_rp_gg');

-- Portal to Wintergrasp (193772)
DELETE FROM gameobject WHERE id=193772;
INSERT INTO gameobject VALUES (61496, 193772, 571, 1, 1, 5686.8, 773.175, 647.752, 1.83259, 0, 0, 0, 1, 180, 255, 1, 0); -- TDB guid
INSERT INTO gameobject VALUES (NULL, 193772, 571, 1, 1, 5923.99, 570.509, 661.087, 5.89636, 0, 0, 0.192208, -0.981354, 300, 0, 1, 0);
DELETE FROM spell_script_names WHERE spell_id IN (58622);
INSERT INTO spell_script_names VALUES(58622, 'spell_wintergrasp_portal');
REPLACE INTO spell_target_position VALUES(59096, 0, 571, 5336.94, 2843.58, 409.24, 0);

-- NPC talk text insert from sniff
DELETE FROM `creature_text` WHERE `entry`=15214 AND `groupid` BETWEEN 0 AND 41;
DELETE FROM `creature_text` WHERE `entry` IN (31036,31091) AND `groupid` BETWEEN 0 AND 3;
DELETE FROM `creature_text` WHERE `entry` IN (31108,31109,34924) AND `groupid`=0;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(15214,0,0, 'Let the battle begin!',41,0,0,0,0,0, 'Invisible Stalker'),
(15214,1,0, 'The Winter\'s Edge Tower has been damaged!',41,0,0,0,0,0, 'Invisible Stalker'),
(15214,2,0, 'The Winter\'s Edge Tower has been destroyed!',41,0,0,0,0,0, 'Invisible Stalker'),
(15214,3,0, 'The Flamewatch Tower has been damaged!',41,0,0,0,0,0, 'Invisible Stalker'),
(15214,4,0, 'The Flamewatch Tower has been destroyed!',41,0,0,0,0,0, 'Invisible Stalker'),
(15214,5,0, 'The Shadowsight Tower has been damaged!',41,0,0,0,0,0, 'Invisible Stalker'),
(15214,6,0, 'The Shadowsight Tower has been destroyed!',41,0,0,0,0,0, 'Invisible Stalker'),
(15214,11,0, 'The Broken Temple siege workshop has been attacked by the Alliance!',41,0,0,0,0,0, 'Invisible Stalker'),
(15214,12,0, 'The Broken Temple siege workshop has been captured by the Alliance!',41,0,0,0,0,0, 'Invisible Stalker'),
(15214,13,0, 'The Broken Temple siege workshop has been attacked by the Horde!',41,0,0,0,0,0, 'Invisible Stalker'),
(15214,14,0, 'The Broken Temple siege workshop has been captured by the Horde!',41,0,0,0,0,0, 'Invisible Stalker'),
(15214,15,0, 'The Eastspark siege workshop has been attacked by the Alliance!',41,0,0,0,0,0, 'Invisible Stalker'),
(15214,16,0, 'The Eastspark siege workshop has been captured by the Alliance!',41,0,0,0,0,0, 'Invisible Stalker'),
(15214,17,0, 'The Eastspark siege workshop has been attacked by the Horde!',41,0,0,0,0,0, 'Invisible Stalker'),
(15214,18,0, 'The Eastspark siege workshop has been captured by the Horde!',41,0,0,0,0,0, 'Invisible Stalker'),
(15214,19,0, 'The Sunken Ring siege workshop has been attacked by the Alliance!',41,0,0,0,0,0, 'Invisible Stalker'),
(15214,20,0, 'The Sunken Ring siege workshop has been captured by the Alliance!',41,0,0,0,0,0, 'Invisible Stalker'),
(15214,21,0, 'The Sunken Ring siege workshop has been attacked by the Horde!',41,0,0,0,0,0, 'Invisible Stalker'),
(15214,22,0, 'The Sunken Ring siege workshop has been captured by the Horde!',41,0,0,0,0,0, 'Invisible Stalker'),
(15214,23,0, 'The Westspark siege workshop has been attacked by the Alliance!',41,0,0,0,0,0, 'Invisible Stalker'),
(15214,24,0, 'The Westspark siege workshop has been captured by the Alliance!',41,0,0,0,0,0, 'Invisible Stalker'),
(15214,25,0, 'The Westspark siege workshop has been attacked by the Horde!',41,0,0,0,0,0, 'Invisible Stalker'),
(15214,26,0, 'The Westspark siege workshop has been captured by the Horde!',41,0,0,0,0,0, 'Invisible Stalker'),
(15214,27,0, 'The Alliance has defended Wintergrasp Fortress!',41,0,0,0,0,0, 'Invisible Stalker'),
(15214,28,0, 'The Alliance has captured Wintergrasp Fortress!',41,0,0,0,0,0, 'Invisible Stalker'),
(15214,29,0, 'The Horde has defended Wintergrasp Fortress!',41,0,0,0,0,0, 'Invisible Stalker'),
(15214,30,0, 'The Horde has captured Wintergrasp Fortress!',41,0,0,0,0,0, 'Invisible Stalker'),
(15214,31,0, 'The battle for Wintergrasp is about to begin!',41,0,0,0,0,0, 'Invisible Stalker'),
(15214,32,0, 'You have reached Rank 1: Corporal',41,0,0,0,0,0, 'Invisible Stalker'),
(15214,33,0, 'You have reached Rank 2: First Lieutenant',41,0,0,0,0,0, 'Invisible Stalker'),
(15214,34,0, 'The north-western keep tower has been damaged!',41,0,0,0,0,0, 'Invisible Stalker'),
(15214,35,0, 'The north-western keep tower has been destroyed!',41,0,0,0,0,0, 'Invisible Stalker'),
(15214,36,0, 'The north-eastern keep tower has been damaged!',41,0,0,0,0,0, 'Invisible Stalker'),
(15214,37,0, 'The north-eastern keep tower has been destroyed!',41,0,0,0,0,0, 'Invisible Stalker'),
(15214,38,0, 'The south-western keep tower has been damaged!',41,0,0,0,0,0, 'Invisible Stalker'),
(15214,39,0, 'The south-western keep tower has been destroyed!',41,0,0,0,0,0, 'Invisible Stalker'),
(15214,40,0, 'The south-eastern keep tower has been damaged!',41,0,0,0,0,0, 'Invisible Stalker'),
(15214,41,0, 'The south-eastern keep tower has been destroyed!',41,0,0,0,0,0, 'Invisible Stalker'),
-- Not sure if all Alliance text is here, need horde text
(31036,0,0, 'The first of the Horde towers has fallen! Destroy all three and we will hasten their retreat!',1,7,100,0,0,0, 'Commander Zanneth'),
(31036,1,0, 'The second tower has fallen! Destroy the final tower and we will hasten their retreat!',1,7,100,0,0,0, 'Commander Zanneth'),
(31036,2,0, 'The Horde towers have fallen! We have forced their hand. Finish off the remaining forces!',1,7,100,0,0,0, 'Commander Zanneth'),
(31036,3,0, 'Show those animals no mercy, $n!',0,7,100,0,0,0, 'Commander Zanneth'),
(31091,0,0, 'The first of the Alliance towers has fallen! Destroy all three and we will hasten their retreat!',1,7,100,0,0,0, 'Commander Dardosh'),
(31091,1,0, 'Lok''tar! The second tower falls! Destroy the final tower and we will hasten their retreat!',1,7,100,0,0,0, 'Commander Dardosh'),
(31091,2,0, 'The Alliance towers have fallen! We have forced their hand. Finish off the remaining forces!',1,7,100,0,0,0, 'Commander Dardosh'),
(31091,3,0, 'Show those animals no mercy, $n!',0,7,100,0,0,0, 'Commander Dardosh'), -- ???
(31108,0,0, 'Stop the Horde from retrieving the embers, $n. We cannot risk them having the advantage when the battle resumes!',0,7,100,0,0,0, 'Siege Master Stouthandle'),
(31109,0,0, 'Destroy their foul machines of war, $n!',0,7,100,0,0,0, 'Senior Demolitionist Legoso'),
(34924,0,0, 'The gates have been breached! Defend the keep!',1,0,100,0,0,0, 'High Commander Halford Wyrmbane');

-- ----------------------------------------
-- ACHIEVEMENTS
-- ----------------------------------------
-- Destruction Derby (1737)
DELETE FROM disables WHERE sourceType=4 AND entry IN(6440, 6441, 6444, 6445);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(6440, 6441, 6444, 6445);
INSERT INTO achievement_criteria_data VALUES(6440, 0, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(6441, 0, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(6444, 0, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(6445, 0, 0, 0, "");

-- Destruction Derby (2476)
DELETE FROM disables WHERE sourceType=4 AND entry IN(9178, 9179, 9180, 9181);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(9178, 9179, 9180, 9181);
INSERT INTO achievement_criteria_data VALUES(9178, 0, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(9179, 0, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(9180, 0, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(9181, 0, 0, 0, "");

-- Didn't Stand a Chance (1751)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7703);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7703);
INSERT INTO achievement_criteria_data VALUES(7703, 6, 4197, 0, "");
INSERT INTO achievement_criteria_data VALUES(7703, 11, 0, 0, "achievement_wg_didnt_stand_a_chance");

-- Vehicular Gnomeslaughter (1723)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7704, 7705, 7706, 7707, 7708);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7704, 7705, 7706, 7707, 7708);
INSERT INTO achievement_criteria_data VALUES(7704, 6, 4197, 0, "");
INSERT INTO achievement_criteria_data VALUES(7704, 11, 0, 0, "achievement_wg_vehicular_gnomeslaughter");
INSERT INTO achievement_criteria_data VALUES(7705, 6, 4197, 0, "");
INSERT INTO achievement_criteria_data VALUES(7705, 11, 0, 0, "achievement_wg_vehicular_gnomeslaughter");
INSERT INTO achievement_criteria_data VALUES(7706, 6, 4197, 0, "");
INSERT INTO achievement_criteria_data VALUES(7706, 11, 0, 0, "achievement_wg_vehicular_gnomeslaughter");
INSERT INTO achievement_criteria_data VALUES(7707, 6, 4197, 0, "");
INSERT INTO achievement_criteria_data VALUES(7707, 11, 0, 0, "achievement_wg_vehicular_gnomeslaughter");
INSERT INTO achievement_criteria_data VALUES(7708, 6, 4197, 0, "");
INSERT INTO achievement_criteria_data VALUES(7708, 11, 0, 0, "achievement_wg_vehicular_gnomeslaughter");

-- Wintergrasp Ranger (2199)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7709, 7710, 7711, 7712, 7713, 7714, 7715, 7716, 7717, 7718, 7719);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7709, 7710, 7711, 7712, 7713, 7714, 7715, 7716, 7717, 7718, 7719);
INSERT INTO achievement_criteria_data VALUES(7709, 6, 4575, 0, "");
INSERT INTO achievement_criteria_data VALUES(7710, 6, 4612, 0, "");
INSERT INTO achievement_criteria_data VALUES(7711, 6, 4539, 0, "");
INSERT INTO achievement_criteria_data VALUES(7712, 6, 4538, 0, "");
INSERT INTO achievement_criteria_data VALUES(7713, 6, 4611, 0, "");
INSERT INTO achievement_criteria_data VALUES(7714, 6, 4581, 0, "");
INSERT INTO achievement_criteria_data VALUES(7715, 6, 4583, 0, "");
INSERT INTO achievement_criteria_data VALUES(7716, 6, 4582, 0, "");
INSERT INTO achievement_criteria_data VALUES(7718, 6, 4584, 0, "");
INSERT INTO achievement_criteria_data VALUES(7719, 6, 4589, 0, "");

-- Wintergrasp Veteran (1718)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7365);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7365);
INSERT INTO achievement_criteria_data VALUES(7365, 0, 0, 0, "");

-- Wintergrasp Victory (1717)
DELETE FROM disables WHERE sourceType=4 AND entry IN(6436);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(6436);
INSERT INTO achievement_criteria_data VALUES(6436, 0, 0, 0, "");

-- Within Our Grasp (1755)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7666);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7666);
INSERT INTO achievement_criteria_data VALUES(7666, 11, 0, 0, "achievement_wg_within_our_grasp");
