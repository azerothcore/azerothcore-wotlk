
UPDATE creature SET spawntimesecs=86400 WHERE map=36 AND spawntimesecs>0;
UPDATE gameobject SET spawntimesecs=86400 WHERE map=36 AND spawntimesecs>0;

-- -------------------------------------------
--               FORMATIONS
-- -------------------------------------------


-- -------------------------------------------
--                TRASH
-- -------------------------------------------

-- Defias Miner (598)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=598;
DELETE FROM smart_scripts WHERE entryorguid=598 AND source_type=0;
INSERT INTO smart_scripts VALUES (598, 0, 0, 0, 0, 0, 100, 0, 2000, 10000, 15000, 20000, 11, 6016, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Defias Miner - In Combat - Cast Pierce Armor');
INSERT INTO smart_scripts VALUES (598, 0, 1, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defias Miner - Between 0-15% Health - Flee For Assist');

-- Defias Overseer (634)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=634;
DELETE FROM smart_scripts WHERE entryorguid=634 AND source_type=0;
INSERT INTO smart_scripts VALUES (634, 0, 0, 0, 0, 0, 100, 0, 2000, 10000, 15000, 25000, 11, 6016, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defias Overseer - In Combat - Cast Battle Command');
INSERT INTO smart_scripts VALUES (634, 0, 1, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defias Overseer - Between 0-15% Health - Flee For Assist');

-- Defias Evoker (1729)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=1729;
DELETE FROM smart_scripts WHERE entryorguid=1729 AND source_type=0;
INSERT INTO smart_scripts VALUES (1729, 0, 0, 0, 1, 0, 100, 0, 1000, 1000, 1200000, 1200000, 11, 12544, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defias Evoker - Out of Combat - Cast Frost Armor');
INSERT INTO smart_scripts VALUES (1729, 0, 1, 0, 0, 0, 100, 0, 0, 1200, 3100, 17100, 11, 11829, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Defias Evoker - In Combat - Cast Flamestrike');
INSERT INTO smart_scripts VALUES (1729, 0, 2, 0, 0, 0, 100, 0, 1100, 21100, 42600, 63500, 11, 4979, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defias Evoker - In Combat - Cast Quick Flame Ward');
INSERT INTO smart_scripts VALUES (1729, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defias Evoker - Between 0-15% Health - Flee For Assist');

-- Defias Watchman (1725)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=1725;
DELETE FROM smart_scripts WHERE entryorguid=1725 AND source_type=0;
INSERT INTO smart_scripts VALUES (1725, 0, 0, 0, 9, 0, 100, 0, 5, 30, 2000, 2000, 11, 6660, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Defias Watchman - Within Range 5-30yd - Cast Shoot');

-- Goblin Woodcarver (641)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=641;
DELETE FROM smart_scripts WHERE entryorguid=641 AND source_type=0;
INSERT INTO smart_scripts VALUES (641, 0, 0, 0, 0, 0, 100, 0, 2000, 10000, 15000, 20000, 11, 6466, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Goblin Woodcarver - In Combat - Cast Axe Toss');
INSERT INTO smart_scripts VALUES (641, 0, 1, 0, 0, 0, 100, 0, 2000, 10000, 7000, 12000, 11, 40505, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Goblin Woodcarver - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (641, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Goblin Woodcarver - Between 0-15% Health - Flee For Assist');

-- Defias Strip Miner (4416)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4416;
DELETE FROM smart_scripts WHERE entryorguid=4416 AND source_type=0;
INSERT INTO smart_scripts VALUES (4416, 0, 0, 0, 0, 0, 100, 0, 2000, 10000, 15000, 20000, 11, 6016, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Defias Strip Miner - In Combat - Cast Pierce Armor');
INSERT INTO smart_scripts VALUES (4416, 0, 1, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defias Strip Miner - Between 0-15% Health - Flee For Assist');

-- Defias Taskmaster (4417)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4417;
DELETE FROM smart_scripts WHERE entryorguid=4417 AND source_type=0;
INSERT INTO smart_scripts VALUES (4417, 0, 0, 0, 9, 0, 100, 0, 5, 30, 2000, 2000, 11, 6660, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Defias Taskmaster - Within Range 5-30yd - Cast Shoot');
INSERT INTO smart_scripts VALUES (4417, 0, 1, 0, 0, 0, 100, 0, 3000, 8000, 12000, 12000, 11, 6685, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Defias Taskmaster - In Combat - Cast Piercing Shot');

-- Defias Wizard (4418)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4418;
DELETE FROM smart_scripts WHERE entryorguid=4418 AND source_type=0;
INSERT INTO smart_scripts VALUES (4418, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 3000, 4000, 11, 9053, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Defias Wizard - In Combat - Cast Fireball');
INSERT INTO smart_scripts VALUES (4418, 0, 1, 0, 0, 0, 100, 0, 3000, 8000, 20000, 30000, 11, 113, 32, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Defias Wizard - In Combat - Cast Chains of Ice');
INSERT INTO smart_scripts VALUES (4418, 0, 2, 0, 0, 0, 100, 0, 1100, 21100, 42600, 63500, 11, 4979, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defias Wizard - In Combat - Cast Quick Flame Ward');

-- Goblin Craftsman (1731)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=1731;
DELETE FROM smart_scripts WHERE entryorguid=1731 AND source_type=0;
INSERT INTO smart_scripts VALUES (1731, 0, 0, 0, 0, 0, 100, 0, 2000, 10000, 15000, 35000, 11, 5159, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Goblin Craftsman - In Combat - Cast Melt Ore');
INSERT INTO smart_scripts VALUES (1731, 0, 1, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Goblin Craftsman - Between 0-15% Health - Flee For Assist');

-- Goblin Engineer (622)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=622;
DELETE FROM smart_scripts WHERE entryorguid=622 AND source_type=0;
INSERT INTO smart_scripts VALUES (622, 0, 0, 0, 9, 0, 100, 0, 5, 30, 2000, 2000, 11, 6660, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Goblin Engineer - Within Range 5-30yd - Cast Shoot');
INSERT INTO smart_scripts VALUES (622, 0, 1, 0, 0, 0, 100, 0, 1000, 9000, 35000, 35000, 11, 3605, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Goblin Engineer - In Combat - Cast Summon Remote-Controlled Golem');
INSERT INTO smart_scripts VALUES (622, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Goblin Engineer - Between 0-15% Health - Flee For Assist');

-- Remote-Controlled Golem (2520)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=2520);
DELETE FROM creature WHERE id=2520;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=2520;
DELETE FROM smart_scripts WHERE entryorguid=2520 AND source_type=0;

-- Defias Pirate (657)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=657;
DELETE FROM smart_scripts WHERE entryorguid=657 AND source_type=0;
INSERT INTO smart_scripts VALUES (657, 0, 0, 0, 1, 0, 70, 0, 1000, 1000, 0, 0, 11, 5172, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defias Pirate - Out of Combat - Cast Bloodsail Companion');
DELETE FROM creature_addon WHERE guid IN(79290, 79289);
DELETE FROM creature WHERE id=657 AND guid IN(79290, 79289);

-- Defias Companion (3450)
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=3450);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=3450);
DELETE FROM creature WHERE id=3450;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=3450;
DELETE FROM smart_scripts WHERE entryorguid=3450 AND source_type=0;

-- Defias Squallshaper (1732)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=1732;
DELETE FROM smart_scripts WHERE entryorguid=1732 AND source_type=0;
INSERT INTO smart_scripts VALUES (1732, 0, 0, 0, 1, 0, 100, 0, 1000, 1000, 1200000, 1200000, 11, 12544, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defias Squallshaper - Out of Combat - Cast Frost Armor');
INSERT INTO smart_scripts VALUES (1732, 0, 1, 0, 0, 0, 100, 0, 0, 1200, 3100, 17100, 11, 2138, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Defias Squallshaper - In Combat - Cast Fire Blast');
INSERT INTO smart_scripts VALUES (1732, 0, 2, 0, 0, 0, 100, 0, 1100, 21100, 42600, 63500, 11, 4979, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defias Squallshaper - In Combat - Cast Frost Nova');
INSERT INTO smart_scripts VALUES (1732, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defias Squallshaper - Between 0-15% Health - Flee For Assist');
INSERT INTO smart_scripts VALUES (1732, 0, 4, 0, 54, 0, 100, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, -102.20, -660.64, 7.43, 0, 'Defias Squallshaper - Is Summoned - Move Point');

-- Goblin Shipbuilder (3947)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3947;
DELETE FROM smart_scripts WHERE entryorguid=3947 AND source_type=0;
INSERT INTO smart_scripts VALUES (3947, 0, 0, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Goblin Shipbuilder - Between 0-15% Health - Flee For Assist');

-- Defias Blackguard (636)
DELETE FROM creature_text WHERE entry=636;
INSERT INTO creature_text VALUES (636, 0, 0, '%s jumps out of the shadows!', 16, 0, 100, 0, 0, 0, 0, 'Defias Blackguard');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=636;
DELETE FROM smart_scripts WHERE entryorguid=636 AND source_type=0;
INSERT INTO smart_scripts VALUES (636, 0, 0, 0, 1, 0, 100, 1, 0, 0, 0, 0, 11, 6408, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defias Blackguard - Out of Combat - Cast Faded');
INSERT INTO smart_scripts VALUES (636, 0, 1, 2, 4, 0, 100, 0, 0, 0, 0, 0, 11, 1833, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Defias Blackguard - On Aggro - Cast Cheap Shot');
INSERT INTO smart_scripts VALUES (636, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 28, 6408, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defias Blackguard - On Aggro - Remove Aura Faded');
INSERT INTO smart_scripts VALUES (636, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defias Blackguard - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (636, 0, 4, 0, 0, 0, 100, 0, 3000, 10000, 10000, 15000, 11, 14903, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defias Blackguard - In Combat - Cast Rupture');


-- -------------------------------------------
--                BOSSES
-- -------------------------------------------

-- Rhahk'Zor (644)
DELETE FROM creature_text WHERE entry=644;
INSERT INTO creature_text VALUES (644, 0, 0, 'VanCleef pay big for your heads!', 14, 0, 100, 0, 0, 5774, 0, 'Rhahk''Zor - Aggro Say');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=644;
DELETE FROM smart_scripts WHERE entryorguid=644 AND source_type=0;
INSERT INTO smart_scripts VALUES (644, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rhahk''Zor - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (644, 0, 1, 0, 0, 0, 100, 0, 800, 8500, 11000, 17200, 11, 6304, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rhahk''Zor - In Combat - Cast Rhahk''Zor Slam');
INSERT INTO smart_scripts VALUES (644, 0, 2, 3, 6, 0, 100, 0, 0, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 14, 30533, 13965, 0, 0, 0, 0, 0, 'Rhahk''Zor - On Just Died - Set GO State');
INSERT INTO smart_scripts VALUES (644, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 34, 0, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rhahk''Zor - On Just Died - Set Instance Data 0 to 3');

-- Sneed's Shredder <Lumbermaster> (642)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=642;
DELETE FROM smart_scripts WHERE entryorguid=642 AND source_type=0;
INSERT INTO smart_scripts VALUES (642, 0, 0, 0, 0, 0, 100, 0, 7000, 7000, 15000, 15000, 11, 7399, 0, 0, 0, 0, 0, 5, 5, 0, 0, 0, 0, 0, 0, 'Sneed''s Shredder - In Combat - Cast Terrify');
INSERT INTO smart_scripts VALUES (642, 0, 1, 0, 0, 0, 100, 0, 4000, 4000, 15000, 15000, 11, 3603, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sneed''s Shredder - In Combat - Cast Distracting Pain');
INSERT INTO smart_scripts VALUES (642, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 5141, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sneed''s Shredder - On Just Died - Cast Eject Sneed');

-- Sneed (643)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=643;
DELETE FROM smart_scripts WHERE entryorguid=643 AND source_type=0;
INSERT INTO smart_scripts VALUES (643, 0, 0, 0, 0, 0, 100, 0, 1000, 7000, 20000, 25000, 11, 6713, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sneed - In Combat - Cast Disarm');

-- Gilnid <The Smelter> (1763)
DELETE FROM creature_text WHERE entry=1763;
INSERT INTO creature_text VALUES (1763, 0, 0, 'Get those parts moving down to the ship!', 12, 0, 100, 0, 0, 0, 0, 'Gilnid');
INSERT INTO creature_text VALUES (1763, 0, 1, 'Anyone want to take a break?  Well too bad!  Get to work you oafs!', 12, 0, 100, 0, 0, 0, 0, 'Gilnid');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=1763;
DELETE FROM smart_scripts WHERE entryorguid=1763 AND source_type=0;
INSERT INTO smart_scripts VALUES (1763, 0, 0, 0, 0, 0, 100, 0, 1000, 6000, 15000, 25000, 11, 5213, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gilnid - In Combat - Cast Molten Metal');
INSERT INTO smart_scripts VALUES (1763, 0, 1, 0, 1, 0, 100, 0, 120000, 120000, 120000, 120000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gilnid - Out of Combat - Say Line 0');

-- Mr. Smite <The Ship's First Mate> (646)
DELETE FROM creature_text WHERE entry=646;
INSERT INTO creature_text VALUES (646, 0, 0, 'You there, check out that noise!', 14, 0, 100, 0, 0, 5775, 3, 'Mr. Smite');
INSERT INTO creature_text VALUES (646, 1, 0, 'We''re under attack! A vast, ye swabs! Repel the invaders!', 14, 0, 100, 0, 0, 5777, 3, 'Mr. Smite');
INSERT INTO creature_text VALUES (646, 2, 0, 'You landlubbers are tougher than I thought, I''ll have to improvise!', 14, 0, 100, 0, 0, 5778, 0, 'Mr. Smite');
INSERT INTO creature_text VALUES (646, 3, 0, 'Now you''re making me angry!', 14, 0, 100, 0, 0, 5779, 0, 'Mr. Smite');
REPLACE INTO creature_template_addon VALUES (646, 0, 0, 0, 4097, 0, '3417 6433');
UPDATE creature_template SET AIName='', ScriptName='boss_mr_smite' WHERE entry=646;
DELETE FROM smart_scripts WHERE entryorguid=646 AND source_type=0;
DELETE FROM creature_equip_template WHERE entry=646;
INSERT INTO creature_equip_template VALUES (646, 1, 2179, 0, 0, 0);
INSERT INTO creature_equip_template VALUES (646, 2, 2179, 2179, 0, 0);
INSERT INTO creature_equip_template VALUES (646, 3, 7230, 0, 0, 0);
REPLACE INTO creature_model_info VALUES (2026, 1.2, 2.0, 0, 0);

-- Miner Johnson (3586)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3586;
DELETE FROM smart_scripts WHERE entryorguid=3586 AND source_type=0;
INSERT INTO smart_scripts VALUES (3586, 0, 0, 0, 37, 0, 60, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Miner Johnson - On AI Init - Despawn'); -- No more than 50% when he appears
INSERT INTO smart_scripts VALUES (3586, 0, 1, 0, 0, 0, 100, 0, 1000, 7000, 20000, 25000, 11, 12097, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Miner Johnson - In Combat - Cast Pierce Armor');

-- Cookie <The Ship's Cook> (645)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=645;
DELETE FROM smart_scripts WHERE entryorguid=645 AND source_type=0;
INSERT INTO smart_scripts VALUES (645, 0, 0, 0, 0, 0, 100, 0, 1000, 7000, 20000, 25000, 11, 6306, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cookie - In Combat - Cast Acid Splash');
INSERT INTO smart_scripts VALUES (645, 0, 1, 0, 0, 0, 100, 0, 10000, 12000, 15000, 25000, 11, 5174, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cookie - In Combat - Cast Cookie''s Cooking');

-- Captain Greenskin (647)
UPDATE creature_model_info SET modelid_other_gender= 0 WHERE modelid=7113; -- Fix model
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=647;
DELETE FROM smart_scripts WHERE entryorguid=647 AND source_type=0;
INSERT INTO smart_scripts VALUES (647, 0, 0, 0, 0, 0, 100, 0, 1000, 7000, 10000, 15000, 11, 40505, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Captain Greenskin - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (647, 0, 1, 0, 0, 0, 100, 0, 10000, 12000, 25000, 35000, 11, 5208, 0, 0, 0, 0, 0, 5, 10, 0, 0, 0, 0, 0, 0, 'Captain Greenskin - In Combat - Cast Poisoned Harpoon');

-- Edwin VanCleef <Defias Kingpin> (639)
DELETE FROM creature_text WHERE entry=639;
INSERT INTO creature_text VALUES (639, 0, 0, 'None may challenge the Brotherhood!', 14, 0, 100, 0, 0, 5780, 0, 'Edwin VanCleef');
INSERT INTO creature_text VALUES (639, 1, 0, 'Lapdogs, all of you!', 14, 0, 100, 0, 0, 5782, 0, 'Edwin VanCleef');
INSERT INTO creature_text VALUES (639, 2, 0, '%s calls more of his allies out of the shadows.', 16, 0, 100, 0, 0, 0, 0, 'Edwin VanCleef');
INSERT INTO creature_text VALUES (639, 3, 0, 'Fools! Our cause is righteous!', 14, 0, 100, 0, 0, 5783, 0, 'Edwin VanCleef');
INSERT INTO creature_text VALUES (639, 4, 0, 'And stay down!', 14, 0, 100, 0, 0, 5781, 0, 'Edwin VanCleef');
INSERT INTO creature_text VALUES (639, 5, 0, 'The Brotherhood will prevail!', 14, 0, 100, 0, 0, 5784, 0, 'Edwin VanCleef');
REPLACE INTO creature_template_addon VALUES (639, 0, 0, 0, 4097, 0, '3417');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=639;
DELETE FROM smart_scripts WHERE entryorguid=639 AND source_type=0;
INSERT INTO smart_scripts VALUES (639, 0, 0, 0, 1, 0, 100, 257, 1000, 1000, 0, 0, 11, 674, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Edwin VanCleef - Out of Combat - Cast Dual Wield');
INSERT INTO smart_scripts VALUES (639, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Edwin VanCleef - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (639, 0, 3, 0, 2, 0, 100, 1, 34, 66, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Edwin VanCleef - Between 34-66% Health - Say Line 1');
INSERT INTO smart_scripts VALUES (639, 0, 4, 5, 2, 0, 100, 1, 26, 50, 0, 0, 11, 5200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Edwin VanCleef - Between 26-50% Health - Cast VanCleef''s Allies');
INSERT INTO smart_scripts VALUES (639, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Edwin VanCleef - Between 26-50% Health - Say Line 2');
INSERT INTO smart_scripts VALUES (639, 0, 6, 0, 2, 0, 100, 1, 0, 33, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Edwin VanCleef - Between 0-33% Health - Say Line 3');
INSERT INTO smart_scripts VALUES (639, 0, 7, 8, 2, 0, 100, 1, 0, 25, 0, 0, 11, 5200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Edwin VanCleef - Between 0-25% Health - Cast VanCleef''s Allies');
INSERT INTO smart_scripts VALUES (639, 0, 8, 0, 61, 0, 100, 0, 0, 25, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Edwin VanCleef - Between 0-25% Health - Say Line 2');
INSERT INTO smart_scripts VALUES (639, 0, 9, 0, 5, 0, 100, 0, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Edwin VanCleef - On Killed Unit - Say Line 4');
INSERT INTO smart_scripts VALUES (639, 0, 10, 0, 6, 0, 100, 0, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Edwin VanCleef - On Just Died - Say Line 5');


-- -------------------------------------------
--                MISC
-- -------------------------------------------

-- Goblin Woodcarver - missing emotes
REPLACE INTO creature_addon VALUES (79192, 0, 0, 0, 4097, 173, '');
REPLACE INTO creature_addon VALUES (79221, 0, 0, 0, 4097, 173, '');
REPLACE INTO creature_addon VALUES (79193, 0, 0, 0, 4097, 173, '');
REPLACE INTO creature_addon VALUES (79231, 0, 0, 0, 4097, 173, '');
REPLACE INTO creature_addon VALUES (79202, 0, 0, 0, 4097, 173, '');
REPLACE INTO creature_addon VALUES (79224, 0, 0, 0, 4097, 173, '');
REPLACE INTO creature_addon VALUES (79241, 0, 0, 0, 4097, 173, '');
REPLACE INTO creature_addon VALUES (79219, 0, 0, 0, 4097, 173, '');

-- GO Defias Cannon (16398)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=16398;
DELETE FROM smart_scripts WHERE entryorguid=16398 AND source_type=1;
DELETE FROM smart_scripts WHERE entryorguid=16398*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (16398, 1, 0, 1, 8, 0, 100, 0, 6250, 0, 0, 0, 80, 16398*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defias Cannon - Spell Hit - Run Script');
INSERT INTO smart_scripts VALUES (16398*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 93, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defias Cannon - Script9 - Send Custom Anim');
INSERT INTO smart_scripts VALUES (16398*100, 9, 1, 0, 0, 0, 100, 0, 500, 500, 0, 0, 131, 2, 0, 0, 0, 0, 0, 14, 30534, 16397, 0, 0, 0, 0, 0, 'Defias Cannon - Script9 - Set GO State');
INSERT INTO smart_scripts VALUES (16398*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 34, 1, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defias Cannon - Script9 - Set Instance Data 1 to 3');
INSERT INTO smart_scripts VALUES (16398*100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 10, 79337, 646, 0, 0, 0, 0, 0, 'Defias Cannon - Script9 - Say Line 0');
INSERT INTO smart_scripts VALUES (16398*100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 1732, 8, 0, 0, 0, 0, 8, 0, 0, 0, -100.73, -709.36, 8.96, 1.58, 'Defias Cannon - Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (16398*100, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 1732, 8, 0, 0, 0, 0, 8, 0, 0, 0, -90.20, -708.74, 8.88, 1.74, 'Defias Cannon - Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (16398*100, 9, 6, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 10, 79337, 646, 0, 0, 0, 0, 0, 'Defias Cannon - Script9 - Say Line 1');

-- ITEM Defias Gunpowder (5397)
UPDATE item_template SET ScriptName='' WHERE entry=5397;

-- GO Door Lever (101833)
UPDATE gameobject_template SET flags=16 WHERE entry=101833;
