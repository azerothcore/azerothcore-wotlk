

-- -------------------------------------------
--                TRASH
-- -------------------------------------------

-- Anub'ar Warrior (28732, 31608)
DELETE FROM creature_text WHERE entry=28732;
UPDATE creature_template SET speed_walk=1, speed_run=1.42857, lootid=28732, dmg_multiplier=4, pickpocketloot=0, skinloot=70205, mechanic_immune_mask=8388624, AIName='SmartAI', ScriptName='' WHERE entry=28732;
UPDATE creature_template SET speed_walk=1, speed_run=1.42857, lootid=28732, dmg_multiplier=7, pickpocketloot=0, skinloot=70205, mechanic_immune_mask=8388624, AIName='', ScriptName='' WHERE entry=31608;
DELETE FROM smart_scripts WHERE entryorguid=28732 AND source_type=0;
INSERT INTO smart_scripts VALUES (28732, 0, 0, 0, 1, 0, 100, 0, 2000, 5000, 6000, 8000, 11, 52532, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Warrior - In Combat - Cast Strike');
INSERT INTO smart_scripts VALUES (28732, 0, 1, 0, 0, 0, 100, 0, 2000, 10000, 15000, 15000, 11, 49806, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Warrior - In Combat - Cast Cleave');

-- Anub'ar Webspinner (29335, 31609)
DELETE FROM creature_text WHERE entry=29335;
UPDATE creature_template SET speed_walk=1, speed_run=1.42857, lootid=29335, dmg_multiplier=4, pickpocketloot=0, skinloot=70205, mechanic_immune_mask=8388624, AIName='SmartAI', ScriptName='' WHERE entry=29335;
UPDATE creature_template SET speed_walk=1, speed_run=1.42857, lootid=29335, dmg_multiplier=7, pickpocketloot=0, skinloot=70205, mechanic_immune_mask=8388624, AIName='', ScriptName='' WHERE entry=31609;
DELETE FROM smart_scripts WHERE entryorguid=29335 AND source_type=0;
INSERT INTO smart_scripts VALUES (29335, 0, 0, 0, 0, 0, 100, 2, 2000, 5000, 6000, 8000, 11, 54290, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Webspinner - In Combat - Cast Web Shot');
INSERT INTO smart_scripts VALUES (29335, 0, 1, 0, 0, 0, 100, 4, 5000, 12000, 16000, 21000, 11, 52086, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Anub''ar Webspinner - In Combat - Cast Web Wrap');
INSERT INTO smart_scripts VALUES (29335, 0, 2, 0, 0, 0, 100, 0, 2000, 10000, 15000, 15000, 11, 49806, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Webspinner - In Combat - Cast Cleave');

-- SPELL Web Wrap (52086)
DELETE FROM spell_script_names WHERE spell_id IN(52086);
INSERT INTO spell_script_names VALUES (52086, 'spell_azjol_nerub_web_wrap');

-- Web Wrap (28619)
DELETE FROM creature_text WHERE entry=28619;
UPDATE creature_template SET unit_flags=131072|4, flags_extra=2, AIName='SmartAI', ScriptName='' WHERE entry=28619;
DELETE FROM smart_scripts WHERE entryorguid=28619 AND source_type=0;
INSERT INTO smart_scripts VALUES (28619, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Web Wrap - On AI Init - Set React Passive');
INSERT INTO smart_scripts VALUES (28619, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 28, 52087, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Web Wrap - On Death - Remove Aura From Owner');

-- Anub'ar Skirmisher (28734, 31606)
DELETE FROM creature_text WHERE entry=28734;
UPDATE creature_template SET speed_walk=1, speed_run=1.42857, lootid=28734, dmg_multiplier=4, pickpocketloot=0, skinloot=70205, mechanic_immune_mask=8388624, AIName='SmartAI', ScriptName='' WHERE entry=28734;
UPDATE creature_template SET speed_walk=1, speed_run=1.42857, lootid=28734, dmg_multiplier=7, pickpocketloot=0, skinloot=70205, mechanic_immune_mask=8388624, AIName='', ScriptName='' WHERE entry=31606;
DELETE FROM smart_scripts WHERE entryorguid=28734 AND source_type=0;
INSERT INTO smart_scripts VALUES (28734, 0, 0, 0, 67, 0, 100, 0, 7000, 7000, 0, 0, 11, 52540, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Skirmisher - Behind Target - Cast Backstab');
INSERT INTO smart_scripts VALUES (28734, 0, 1, 0, 0, 0, 100, 0, 5000, 10000, 15000, 15000, 11, 52536, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Anub''ar Skirmisher - In Combat - Cast Fixate Trigger');

-- SPELL Fixate Trigger (52536)
DELETE FROM spell_script_names WHERE spell_id IN(52536);
INSERT INTO spell_script_names VALUES (52536, 'spell_azjol_nerub_fixate');

-- Anub'ar Shadowcaster (28733, 31605)
DELETE FROM creature_text WHERE entry=28733;
UPDATE creature_template SET speed_walk=1, speed_run=1.42857, lootid=28733, dmg_multiplier=4, pickpocketloot=0, skinloot=70205, mechanic_immune_mask=8388624, AIName='SmartAI', ScriptName='' WHERE entry=28733;
UPDATE creature_template SET speed_walk=1, speed_run=1.42857, lootid=28733, dmg_multiplier=7, pickpocketloot=0, skinloot=70205, mechanic_immune_mask=8388624, AIName='', ScriptName='' WHERE entry=31605;
DELETE FROM smart_scripts WHERE entryorguid=28733 AND source_type=0;
INSERT INTO smart_scripts VALUES (28733, 0, 0, 0, 0, 0, 100, 2, 0, 0, 2000, 2500, 11, 52534, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Shadowcaster - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (28733, 0, 1, 0, 0, 0, 100, 4, 0, 0, 2000, 2500, 11, 59357, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Shadowcaster - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (28733, 0, 2, 0, 0, 0, 100, 2, 6000, 12000, 12000, 20000, 11, 52535, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Shadowcaster - In Combat - Cast Shadow Nova');
INSERT INTO smart_scripts VALUES (28733, 0, 3, 0, 0, 0, 100, 4, 6000, 12000, 12000, 20000, 11, 59358, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Shadowcaster - In Combat - Cast Shadow Nova');

-- Skittering Swarmer (32593)
UPDATE creature_template SET lootid=0, dmg_multiplier=1, pickpocketloot=0, skinloot=0, mechanic_immune_mask=8388624, AIName='', ScriptName='' WHERE entry=32593;

-- Anub'ar Brood Keeper (29340, 31587)
UPDATE creature_template SET lootid=0, dmg_multiplier=1, pickpocketloot=0, skinloot=0, mechanic_immune_mask=8388624, AIName='', ScriptName='' WHERE entry=29340;
UPDATE creature_template SET lootid=0, dmg_multiplier=2, pickpocketloot=0, skinloot=0, mechanic_immune_mask=8388624, AIName='', ScriptName='' WHERE entry=31587;

-- Anub'ar Prime Guard (29128, 31604)
UPDATE creature_template SET speed_walk=1, speed_run=1.42857, lootid=29128, dmg_multiplier=4, pickpocketloot=0, skinloot=70205, mechanic_immune_mask=8388624, AIName='SmartAI', ScriptName='' WHERE entry=29128;
UPDATE creature_template SET speed_walk=1, speed_run=1.42857, lootid=29128, dmg_multiplier=7, pickpocketloot=0, skinloot=70205, mechanic_immune_mask=8388624, AIName='', ScriptName='' WHERE entry=31604;
DELETE FROM smart_scripts WHERE entryorguid=29128 AND source_type=0;
INSERT INTO smart_scripts VALUES (29128, 0, 0, 0, 0, 0, 100, 2, 0, 10000, 10000, 10000, 11, 54314, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Shadowcaster - In Combat - Cast Drain Power');
INSERT INTO smart_scripts VALUES (29128, 0, 1, 0, 0, 0, 100, 4, 0, 10000, 10000, 10000, 11, 59354, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Shadowcaster - In Combat - Cast Drain Power');
INSERT INTO smart_scripts VALUES (29128, 0, 2, 0, 0, 0, 100, 2, 6000, 12000, 12000, 25000, 11, 54309, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Anub''ar Shadowcaster - In Combat - Cast Mark of Darkness');
INSERT INTO smart_scripts VALUES (29128, 0, 3, 0, 0, 0, 100, 4, 6000, 12000, 12000, 25000, 11, 59352, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Anub''ar Shadowcaster - In Combat - Cast Mark of Darkness');



-- -------------------------------------------
--                BOSSES
-- -------------------------------------------

-- Krik'thir the Gatewatcher (28684, 31612)
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE map=601 AND position_x > 495 AND position_x < 563 AND position_y > 653 AND position_y < 686 AND position_z > 765 AND position_z < 780);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE map=601 AND position_x > 495 AND position_x < 563 AND position_y > 653 AND position_y < 686 AND position_z > 765 AND position_z < 780);
DELETE FROM creature WHERE map=601 AND position_x > 495 AND position_x < 563 AND position_y > 653 AND position_y < 686 AND position_z > 765 AND position_z < 780;

DELETE FROM creature_text WHERE entry=28684;
INSERT INTO creature_text VALUES (28684, 0, 0, 'This kingdom belongs to the Scourge! Only the dead may enter.', 14, 0, 100, 0, 0, 14075, 0, 'krik thir SAY_AGGRO');
INSERT INTO creature_text VALUES (28684, 1, 0, 'You were foolish to come.', 14, 0, 100, 0, 0, 14077, 0, 'krik thir SAY_SLAY_1');
INSERT INTO creature_text VALUES (28684, 1, 1, 'As Anub''Arak commands!', 14, 0, 100, 0, 0, 14078, 0, 'krik thir SAY_SLAY_2');
INSERT INTO creature_text VALUES (28684, 2, 0, 'I should be grateful. But I long ago lost the capacity.', 14, 0, 100, 0, 0, 14087, 0, 'krik thir SAY_DEATH');
INSERT INTO creature_text VALUES (28684, 3, 0, 'They hunger.', 14, 0, 100, 0, 0, 14085, 0, 'krik thir SAY_SWARM_1');
INSERT INTO creature_text VALUES (28684, 3, 1, 'Dinner time, my pets.', 14, 0, 100, 0, 0, 14086, 0, 'krik thir SAY_SWARM_2');
INSERT INTO creature_text VALUES (28684, 4, 0, 'Keep an eye on the tunnel. We must not let anyone through!', 14, 0, 100, 0, 0, 14082, 0, 'krik thir SAY_PREFIGHT_1');
INSERT INTO creature_text VALUES (28684, 4, 1, 'I hear footsteps. Be on your guard.', 14, 0, 100, 0, 0, 14083, 0, 'krik thir SAY_PREFIGHT_2');
INSERT INTO creature_text VALUES (28684, 4, 2, 'I sense the living. Be ready.', 14, 0, 100, 0, 0, 14084, 0, 'krik thir SAY_PREFIGHT_3');
INSERT INTO creature_text VALUES (28684, 5, 0, 'We are besieged. Strike out and bring back their corpses!', 14, 0, 100, 0, 0, 14079, 0, 'krik thir SAY_SEND_GROUP_1');
INSERT INTO creature_text VALUES (28684, 5, 1, 'We must hold the gate. Attack! Tear them limb from limb!', 14, 0, 100, 0, 0, 14080, 0, 'krik thir SAY_SEND_GROUP_2');
INSERT INTO creature_text VALUES (28684, 5, 2, 'The gate must be protected at all costs. Rip them to shreds!', 14, 0, 100, 0, 0, 14081, 0, 'krik thir SAY_SEND_GROUP_3');
UPDATE creature_template SET baseattacktime=2000, dmg_multiplier=10, lootid=28684, pickpocketloot=0, skinloot=70205, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='boss_krik_thir' WHERE entry=28684;
UPDATE creature_template SET baseattacktime=2000, dmg_multiplier=20, lootid=31612, pickpocketloot=0, skinloot=70205, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='' WHERE entry=31612;

-- Watcher Gashra (28730, 31615)
DELETE FROM creature_loot_template WHERE entry IN(28730, 31615);
DELETE FROM creature_text WHERE entry=28730;
UPDATE creature_template SET speed_walk=1, speed_run=1.42857, lootid=0, dmg_multiplier=7, pickpocketloot=0, skinloot=70205, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='SmartAI', ScriptName='' WHERE entry=28730;
UPDATE creature_template SET speed_walk=1, speed_run=1.42857, lootid=0, dmg_multiplier=13, pickpocketloot=0, skinloot=70205, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='' WHERE entry=31615;
DELETE FROM smart_scripts WHERE entryorguid=28730 AND source_type=0;
INSERT INTO smart_scripts VALUES (28730, 0, 0, 0, 0, 0, 100, 0, 2000, 6000, 15000, 20000, 11, 52470, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Watcher Gashra - In Combat - Cast Enrage');
INSERT INTO smart_scripts VALUES (28730, 0, 1, 0, 0, 0, 100, 0, 6000, 15000, 20000, 25000, 11, 52086, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Watcher Gashra - In Combat - Cast Web Wrap');
INSERT INTO smart_scripts VALUES (28730, 0, 2, 0, 0, 0, 100, 2, 4000, 12000, 9000, 15000, 11, 52469, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Watcher Gashra - In Combat - Cast Infected Bite');
INSERT INTO smart_scripts VALUES (28730, 0, 3, 0, 0, 0, 100, 4, 4000, 12000, 9000, 15000, 11, 59364, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Watcher Gashra - In Combat - Cast Infected Bite');
INSERT INTO smart_scripts VALUES (28730, 0, 4, 0, 8, 0, 100, 0, 52343, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Watcher Gashra - On Spell Hit - Set In Combat With Zone');
INSERT INTO smart_scripts VALUES (28730, 0, 5, 0, 0, 0, 100, 1, 500, 500, 0, 0, 39, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Watcher Gashra - On Spell Hit - Call For Help');

-- Watcher Silthik (28731, 31617)
DELETE FROM creature_loot_template WHERE entry IN(28731, 31617);
DELETE FROM creature_text WHERE entry=28731;
UPDATE creature_template SET speed_walk=1, speed_run=1.42857, lootid=0, dmg_multiplier=7, pickpocketloot=0, skinloot=70205, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='SmartAI', ScriptName='' WHERE entry=28731;
UPDATE creature_template SET speed_walk=1, speed_run=1.42857, lootid=0, dmg_multiplier=13, pickpocketloot=0, skinloot=70205, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='' WHERE entry=31617;
DELETE FROM smart_scripts WHERE entryorguid=28731 AND source_type=0;
INSERT INTO smart_scripts VALUES (28731, 0, 0, 0, 0, 0, 100, 2, 2000, 6000, 15000, 20000, 11, 52493, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Watcher Silthik - In Combat - Cast Poison Spray');
INSERT INTO smart_scripts VALUES (28731, 0, 1, 0, 0, 0, 100, 4, 2000, 6000, 15000, 20000, 11, 52493, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Watcher Silthik - In Combat - Cast Poison Spray');
INSERT INTO smart_scripts VALUES (28731, 0, 2, 0, 0, 0, 100, 0, 6000, 15000, 20000, 25000, 11, 52086, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Watcher Silthik - In Combat - Cast Web Wrap');
INSERT INTO smart_scripts VALUES (28731, 0, 3, 0, 0, 0, 100, 2, 4000, 12000, 9000, 15000, 11, 52469, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Watcher Silthik - In Combat - Cast Infected Bite');
INSERT INTO smart_scripts VALUES (28731, 0, 4, 0, 0, 0, 100, 4, 4000, 12000, 9000, 15000, 11, 59364, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Watcher Silthik - In Combat - Cast Infected Bite');
INSERT INTO smart_scripts VALUES (28731, 0, 5, 0, 8, 0, 100, 0, 52343, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Watcher Silthik - On Spell Hit - Set In Combat With Zone');
INSERT INTO smart_scripts VALUES (28731, 0, 6, 0, 0, 0, 100, 1, 500, 500, 0, 0, 39, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Watcher Silthik - On Spell Hit - Call For Help');

-- Watcher Narjil (28729, 31616)
DELETE FROM creature_loot_template WHERE entry IN(28729, 31616);
DELETE FROM creature_text WHERE entry=28729;
UPDATE creature_template SET speed_walk=1, speed_run=1.42857, lootid=0, dmg_multiplier=7, pickpocketloot=0, skinloot=70205, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='SmartAI', ScriptName='' WHERE entry=28729;
UPDATE creature_template SET speed_walk=1, speed_run=1.42857, lootid=0, dmg_multiplier=13, pickpocketloot=0, skinloot=70205, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='' WHERE entry=31616;
DELETE FROM smart_scripts WHERE entryorguid=28729 AND source_type=0;
INSERT INTO smart_scripts VALUES (28729, 0, 0, 0, 0, 0, 100, 2, 2000, 6000, 15000, 20000, 11, 52524, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Watcher Narjil - In Combat - Cast Binding Webs');
INSERT INTO smart_scripts VALUES (28729, 0, 1, 0, 0, 0, 100, 4, 2000, 6000, 15000, 20000, 11, 59365, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Watcher Narjil - In Combat - Cast Binding Webs');
INSERT INTO smart_scripts VALUES (28729, 0, 2, 0, 0, 0, 100, 0, 6000, 15000, 20000, 25000, 11, 52086, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Watcher Narjil - In Combat - Cast Web Wrap');
INSERT INTO smart_scripts VALUES (28729, 0, 3, 0, 0, 0, 100, 2, 4000, 12000, 9000, 15000, 11, 52469, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Watcher Narjil - In Combat - Cast Infected Bite');
INSERT INTO smart_scripts VALUES (28729, 0, 4, 0, 0, 0, 100, 4, 4000, 12000, 9000, 15000, 11, 59364, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Watcher Narjil - In Combat - Cast Infected Bite');
INSERT INTO smart_scripts VALUES (28729, 0, 5, 0, 8, 0, 100, 0, 52343, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Watcher Narjil - On Spell Hit - Set In Combat With Zone');
INSERT INTO smart_scripts VALUES (28729, 0, 6, 0, 0, 0, 100, 1, 500, 500, 0, 0, 39, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Watcher Narjil - On Spell Hit - Call For Help');

-- Skittering Infector (28736, 31613)
DELETE FROM creature_loot_template WHERE entry IN(28736, 31613);
DELETE FROM creature_text WHERE entry=28736;
UPDATE creature_template SET speed_walk=1, speed_run=1.42857, lootid=0, dmg_multiplier=1, pickpocketloot=0, skinloot=0, mechanic_immune_mask=8388624, flags_extra=64, AIName='SmartAI', ScriptName='' WHERE entry=28736;
UPDATE creature_template SET speed_walk=1, speed_run=1.42857, lootid=0, dmg_multiplier=2, pickpocketloot=0, skinloot=0, mechanic_immune_mask=8388624, flags_extra=64, AIName='', ScriptName='' WHERE entry=31613;
DELETE FROM smart_scripts WHERE entryorguid=28736 AND source_type=0;
INSERT INTO smart_scripts VALUES (28736, 0, 0, 0, 6, 0, 100, 2, 0, 0, 0, 0, 11, 52446, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skittering Infector - On Death - Cast Acid Splash');
INSERT INTO smart_scripts VALUES (28736, 0, 1, 0, 6, 0, 100, 4, 0, 0, 0, 0, 11, 59363, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skittering Infector - On Death - Cast Acid Splash');
INSERT INTO smart_scripts VALUES (28736, 0, 2, 0, 60, 0, 100, 257, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skittering Infector - On Update - Set In Combat With Zone');

-- Skittering Swarmer (28735, 31614)
DELETE FROM creature_loot_template WHERE entry IN(28735, 31614);
DELETE FROM creature_text WHERE entry=28735;
UPDATE creature_template SET speed_walk=1, speed_run=1.42857, lootid=0, dmg_multiplier=1, pickpocketloot=0, skinloot=0, mechanic_immune_mask=8388624, flags_extra=64, AIName='SmartAI', ScriptName='' WHERE entry=28735;
UPDATE creature_template SET speed_walk=1, speed_run=1.42857, lootid=0, dmg_multiplier=2, pickpocketloot=0, skinloot=0, mechanic_immune_mask=8388624, flags_extra=64, AIName='', ScriptName='' WHERE entry=31614;
DELETE FROM smart_scripts WHERE entryorguid=28735 AND source_type=0;
INSERT INTO smart_scripts VALUES (28735, 0, 2, 0, 60, 0, 100, 257, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skittering Infector - On Update - Set In Combat With Zone');

-- SPELL Krik'Thir Subboss Aggro Trigger (52343)
DELETE FROM conditions WHERE SourceEntry IN(52343) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES (13, 1, 52343, 0, 0, 31, 0, 3, 28730, 0, 0, 0, 0, '', 'Target Watcher Gashra');
INSERT INTO conditions VALUES (13, 1, 52343, 0, 0, 38, 0, 100, 0, 0, 0, 0, 0, '', 'Target 100% HP');
INSERT INTO conditions VALUES (13, 1, 52343, 0, 1, 31, 0, 3, 28731, 0, 0, 0, 0, '', 'Target Watcher Silthik');
INSERT INTO conditions VALUES (13, 1, 52343, 0, 1, 38, 0, 100, 0, 0, 0, 0, 0, '', 'Target 100% HP');
INSERT INTO conditions VALUES (13, 1, 52343, 0, 2, 31, 0, 3, 28729, 0, 0, 0, 0, '', 'Target Watcher Narjil');
INSERT INTO conditions VALUES (13, 1, 52343, 0, 2, 38, 0, 100, 0, 0, 0, 0, 0, '', 'Target 100% HP');

-- SPELL Summon Skittering Infector (52449)
DELETE FROM conditions WHERE SourceEntry IN(52449) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES (13, 1, 52449, 0, 0, 31, 0, 3, 22515, 0, 0, 0, 0, '', 'Target World Trigger');
DELETE FROM spell_script_names WHERE spell_id IN(52449);
INSERT INTO spell_script_names VALUES (52449, 'spell_gen_select_target_count_7_1');

-- SPELL Summon Skittering Swarmer (52438)
DELETE FROM conditions WHERE SourceEntry IN(52438) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES (13, 1, 52438, 0, 0, 31, 0, 3, 22515, 0, 0, 0, 0, '', 'Target World Trigger');
DELETE FROM spell_script_names WHERE spell_id IN(52438);
INSERT INTO spell_script_names VALUES (52438, 'spell_gen_select_target_count_7_1');

-- Hadronox (28921, 31611)
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE map=601 AND (id=28922 OR id=29118 OR id=29117 OR id=29064 OR id=29063 OR id=29062 OR id=29097 OR id=29098 OR id=29096));
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE map=601 AND (id=28922 OR id=29118 OR id=29117 OR id=29064 OR id=29063 OR id=29062 OR id=29097 OR id=29098 OR id=29096));
DELETE FROM creature WHERE map=601 AND (id=28922 OR id=29118 OR id=29117 OR id=29064 OR id=29063 OR id=29062 OR id=29097 OR id=29098 OR id=29096);

DELETE FROM creature_text WHERE entry=28921;
INSERT INTO creature_text VALUES (28921, 0, 0, '%s moves up the tunnel!', 41, 0, 100, 0, 0, 0, 0, 'Hadronox');
UPDATE creature_template SET baseattacktime=2000, dmg_multiplier=10, lootid=28921, pickpocketloot=0, skinloot=70205, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='boss_hadronox' WHERE entry=28921;
UPDATE creature_template SET baseattacktime=2000, dmg_multiplier=20, lootid=31611, pickpocketloot=0, skinloot=70205, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='' WHERE entry=31611;

DELETE FROM waypoint_data WHERE id IN(3000012, 3000013, 3000014);
INSERT INTO waypoint_data VALUES (3000012, 1, 486.00, 610.95, 771.44, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (3000012, 2, 511.375, 589.639, 737.815, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (3000012, 3, 533.247, 559.627, 732.734, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (3000012, 4, 558.815, 567.69, 728.756, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (3000012, 5, 570.954, 570.796, 726.784, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (3000012, 6, 584.382, 574.232, 725.939, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (3000012, 7, 601.121, 570.891, 722.183, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (3000012, 8, 614.804, 547.918, 710.88, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (3000012, 9, 611.116, 531.174, 703.707, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (3000012, 10, 599.057, 511.966, 695.001, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (3000012, 11, 578.222, 513.952, 698.343, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (3000012, 12, 553.224, 522.398, 689.236, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (3000013, 1, 574.78, 610.73, 771.42, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (3000013, 2, 546.708, 587.279, 734.15, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (3000013, 3, 531.064, 573.271, 733.146, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (3000013, 4, 545.809, 563.977, 730.977, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (3000013, 5, 572.928, 570.945, 726.649, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (3000013, 6, 597.991, 576.044, 723.952, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (3000013, 7, 609.618, 555.842, 715.518, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (3000013, 8, 619.799, 536.204, 704.178, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (3000013, 9, 618.858, 522.838, 695.921, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (3000013, 10, 602.974, 513.122, 695.167, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (3000013, 11, 572.431, 514.042, 698.303, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (3000013, 12, 555.565, 520.774, 690.931, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (3000014, 1, 590.08, 596.79, 739.09, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (3000014, 2, 596.313, 588.864, 728.681, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (3000014, 3, 613.696, 554.596, 714.619, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (3000014, 4, 621.476, 526.044, 697.194, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (3000014, 5, 598.996, 509.469, 695.042, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (3000014, 6, 579.313, 511.708, 698.207, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (3000014, 7, 568.218, 515.16, 698.324, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (3000014, 8, 558.703, 519.601, 693.192, 0, 0, 1, 0, 100, 0);

-- Anub'ar Crusher (28922, 31592)
DELETE FROM creature_loot_template WHERE entry IN(28922, 31592);
DELETE FROM creature_text WHERE entry=28922;
INSERT INTO creature_text VALUES (28922, 0, 0, 'The gate has been breached! Quickly, divert forces to deal with these invaders!', 14, 0, 100, 0, 0, 0, 0, 'Anub''ar Crusher');
INSERT INTO creature_text VALUES (28922, 1, 0, '%s goes into a frenzy!', 41, 0, 100, 0, 0, 0, 0, 'Anub''ar Crusher');
UPDATE creature_template SET baseattacktime=2000, dmg_multiplier=7, lootid=0, pickpocketloot=0, skinloot=0, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='npc_anub_ar_crusher' WHERE entry=28922;
UPDATE creature_template SET baseattacktime=2000, dmg_multiplier=13, lootid=0, pickpocketloot=0, skinloot=0, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='' WHERE entry=31592;
DELETE FROM smart_scripts WHERE entryorguid=28922 AND source_type=0;

-- Anub'ar Champion (29062, 31589)
DELETE FROM creature_loot_template WHERE entry IN(29062, 31589);
DELETE FROM creature_text WHERE entry=29062;
UPDATE creature_template SET speed_walk=1, speed_run=1.42857, lootid=0, dmg_multiplier=2, pickpocketloot=0, skinloot=0, mechanic_immune_mask=8388624, flags_extra=0, AIName='SmartAI', ScriptName='' WHERE entry=29062;
UPDATE creature_template SET speed_walk=1, speed_run=1.42857, lootid=0, dmg_multiplier=4, pickpocketloot=0, skinloot=0, mechanic_immune_mask=8388624, flags_extra=0, AIName='', ScriptName='' WHERE entry=31589;
DELETE FROM smart_scripts WHERE entryorguid=29062 AND source_type=0;
INSERT INTO smart_scripts VALUES (29062, 0, 0, 0, 0, 0, 100, 2, 4000, 7000, 12000, 18000, 11, 53317, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Champion - In Combat - Cast Rend');
INSERT INTO smart_scripts VALUES (29062, 0, 1, 0, 0, 0, 100, 4, 4000, 7000, 12000, 18000, 11, 59343, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Champion - In Combat - Cast Rend');
INSERT INTO smart_scripts VALUES (29062, 0, 2, 0, 13, 0, 100, 2, 9000, 13000, 0, 0, 11, 53394, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Champion - Target Casting - Cast Pummel');
INSERT INTO smart_scripts VALUES (29062, 0, 3, 0, 13, 0, 100, 4, 9000, 13000, 0, 0, 11, 59344, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Champion - Target Casting - Cast Pummel');
-- INSERT INTO smart_scripts VALUES (29062, 0, 4, 0, 54, 0, 100, 0, 0, 0, 0, 0, 11, 53798, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Champion - Is Summoned By - Cast Taunt');
INSERT INTO smart_scripts VALUES (29062, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Champion - On Death - Despawn');
-- DELETE FROM conditions WHERE SourceEntry IN(29062) AND SourceTypeOrReferenceId=22;
-- INSERT INTO conditions VALUES (22, 5, 29062, 0, 0, 31, 0, 3, 23472, 0, 0, 0, 0, '', 'Run if invoker is World Trigger');

-- Anub'ar Necromancer (29063, 31594)
DELETE FROM creature_loot_template WHERE entry IN(29063, 31594);
DELETE FROM creature_text WHERE entry=29063;
UPDATE creature_template SET speed_walk=1, speed_run=1.42857, lootid=0, dmg_multiplier=2, pickpocketloot=0, skinloot=0, mechanic_immune_mask=8388624, flags_extra=0, AIName='SmartAI', ScriptName='' WHERE entry=29063;
UPDATE creature_template SET speed_walk=1, speed_run=1.42857, lootid=0, dmg_multiplier=4, pickpocketloot=0, skinloot=0, mechanic_immune_mask=8388624, flags_extra=0, AIName='', ScriptName='' WHERE entry=31594;
DELETE FROM smart_scripts WHERE entryorguid=29063 AND source_type=0;
INSERT INTO smart_scripts VALUES (29063, 0, 0, 0, 0, 0, 100, 2, 4000, 7000, 9000, 12000, 11, 53330, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Necromancer - In Combat - Cast Infected Wound');
INSERT INTO smart_scripts VALUES (29063, 0, 1, 0, 0, 0, 100, 4, 4000, 7000, 9000, 12000, 11, 59348, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Necromancer - In Combat - Cast Infected Wound');
INSERT INTO smart_scripts VALUES (29063, 0, 2, 0, 0, 0, 100, 2, 9000, 12000, 13000, 17000, 11, 53322, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Anub''ar Necromancer - In Combat - Cast Crushing Webs');
INSERT INTO smart_scripts VALUES (29063, 0, 3, 0, 0, 0, 100, 4, 9000, 12000, 10000, 13000, 11, 59347, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Anub''ar Necromancer - In Combat - Cast Crushing Webs');
-- INSERT INTO smart_scripts VALUES (29063, 0, 4, 0, 54, 0, 100, 0, 0, 0, 0, 0, 11, 53798, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Necromancer - Is Summoned By - Cast Taunt');
INSERT INTO smart_scripts VALUES (29063, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Necromancer - On Death - Despawn');
-- DELETE FROM conditions WHERE SourceEntry IN(29063) AND SourceTypeOrReferenceId=22;
-- INSERT INTO conditions VALUES (22, 5, 29063, 0, 0, 31, 0, 3, 23472, 0, 0, 0, 0, '', 'Run if invoker is World Trigger');

-- Anub'ar Crypt Fiend (29064, 31601)
DELETE FROM creature_loot_template WHERE entry IN(29064, 31601);
DELETE FROM creature_text WHERE entry=29064;
UPDATE creature_template SET speed_walk=1, speed_run=1.42857, lootid=0, dmg_multiplier=2, pickpocketloot=0, skinloot=0, mechanic_immune_mask=8388624, flags_extra=0, AIName='SmartAI', ScriptName='' WHERE entry=29064;
UPDATE creature_template SET speed_walk=1, speed_run=1.42857, lootid=0, dmg_multiplier=4, pickpocketloot=0, skinloot=0, mechanic_immune_mask=8388624, flags_extra=0, AIName='', ScriptName='' WHERE entry=31601;
DELETE FROM smart_scripts WHERE entryorguid=29064 AND source_type=0;
INSERT INTO smart_scripts VALUES (29064, 0, 0, 0, 1, 0, 100, 0, 0, 1000, 2000, 3000, 11, 53333, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Crypt Fiend - In Combat - Cast Shadow Bolt');
-- INSERT INTO smart_scripts VALUES (29064, 0, 1, 0, 54, 0, 100, 0, 0, 0, 0, 0, 11, 53798, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Crypt Fiend - Is Summoned By - Cast Taunt');
INSERT INTO smart_scripts VALUES (29064, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Crypt Fiend - On Death - Despawn');
-- DELETE FROM conditions WHERE SourceEntry IN(29064) AND SourceTypeOrReferenceId=22;
-- INSERT INTO conditions VALUES (22, 2, 29064, 0, 0, 31, 0, 3, 23472, 0, 0, 0, 0, '', 'Run if invoker is World Trigger');

-- World Trigger (23472)
REPLACE INTO creature_addon VALUES (127378, 0, 0, 0, 0, 0, '53035 53036 53037');
REPLACE INTO creature_addon VALUES (127377, 0, 0, 0, 0, 0, '53035 53036 53037');
REPLACE INTO creature_addon VALUES (127376, 0, 0, 0, 0, 0, '53035 53036 53037');

-- SPELL Summon Anub'ar Periodic (53035, 53036, 53037)
DELETE FROM spell_script_names WHERE spell_id IN(53035, 53036, 53037);
INSERT INTO spell_script_names VALUES (53035, 'spell_hadronox_summon_periodic_champion');
INSERT INTO spell_script_names VALUES (53036, 'spell_hadronox_summon_periodic_necromancer');
INSERT INTO spell_script_names VALUES (53037, 'spell_hadronox_summon_periodic_crypt_fiend');

-- SPELL Web Front Doors (53177)
DELETE FROM conditions WHERE SourceEntry IN(53177) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES (13, 1, 53177, 0, 0, 31, 0, 3, 23472, 0, 0, 0, 0, '', 'Target World Trigger');

-- SPELL Taunt (53798)
DELETE FROM conditions WHERE SourceEntry IN(53798) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES (13, 1, 53798, 0, 0, 31, 0, 3, 28921, 0, 0, 0, 0, '', 'Target Hadronox');
DELETE FROM spell_script_names WHERE spell_id IN(53798);
INSERT INTO spell_script_names VALUES (53798, 'spell_azjol_nerub_fixate');

-- SPELL Leech Poison (53030, 59417)
DELETE FROM spell_script_names WHERE spell_id IN(53030, 59417);
INSERT INTO spell_script_names VALUES (53030, 'spell_hadronox_leech_poison');
INSERT INTO spell_script_names VALUES (59417, 'spell_hadronox_leech_poison');

-- Anub'arak (29120, 31610)
DELETE FROM creature_text WHERE entry=29120;
INSERT INTO creature_text VALUES (29120, 0, 0, 'Eternal aggony awaits you!', 14, 0, 100, 0, 0, 14054, 0, 'anub arak SAY_AGGRO');
INSERT INTO creature_text VALUES (29120, 1, 0, 'Soon, the Master''s voice will call to you.', 14, 0, 100, 0, 0, 14057, 0, 'anub arak SAY_SLAY_1');
INSERT INTO creature_text VALUES (29120, 1, 1, 'You have made your choice.', 14, 0, 100, 0, 0, 14056, 0, 'anub arak SAY_SLAY_2');
INSERT INTO creature_text VALUES (29120, 1, 2, 'You shall experience my torment, first-hand!', 14, 0, 100, 0, 0, 14055, 0, 'anub arak SAY_SLAY_3');
INSERT INTO creature_text VALUES (29120, 2, 0, 'Ahhh... RAAAAAGH! Never thought... I would be free of him...', 14, 0, 100, 0, 0, 14069, 0, 'anub arak SAY_DEATH');
INSERT INTO creature_text VALUES (29120, 3, 0, 'Your armor is useless againts my locusts.', 14, 0, 100, 0, 0, 14060, 0, 'anub arak SAY_LOCUST_1');
INSERT INTO creature_text VALUES (29120, 3, 1, 'Uunak-hissss tik-k-k-k-k!', 14, 0, 100, 0, 0, 14067, 0, 'anub arak SAY_LOCUST_2');
INSERT INTO creature_text VALUES (29120, 3, 2, 'The pestilence upon you!', 14, 0, 100, 0, 0, 14068, 0, 'anub arak SAY_LOCUST_3');
INSERT INTO creature_text VALUES (29120, 4, 0, 'Auum na-l ak-k-k-k, isshhh.', 14, 0, 100, 0, 0, 14058, 0, 'anub arak SAY_SUBMERGE_1');
INSERT INTO creature_text VALUES (29120, 4, 1, 'Come forth my brethren! Feast on their flesh.', 14, 0, 100, 0, 0, 14059, 0, 'anub arak SAY_SUBMERGE_2');
INSERT INTO creature_text VALUES (29120, 5, 0, 'I was king of this empire once, long ago. In life I stood as champion. In death I returned as conqueror. Now I protect the kingdom once more. Ironic, yes?' , 14, 0, 100, 0, 0, 14053, 0, 'anub arak SAY_INTRO');
UPDATE creature_template SET dmg_multiplier=10, skinloot=70205, mechanic_immune_mask=650854271, flags_extra=0+0x200000 WHERE entry=29120;
UPDATE creature_template SET dmg_multiplier=20, skinloot=70205, mechanic_immune_mask=650854271, flags_extra=1+0x200000 WHERE entry=31610;

-- SPELL Carrion Beetels (53520)
DELETE FROM spell_script_names WHERE spell_id IN(53520);
INSERT INTO spell_script_names VALUES (53520, 'spell_azjol_nerub_carrion_beetels');

-- SPELL Pound (53472, 59433)
DELETE FROM spell_script_names WHERE spell_id IN(53472, 59433);
INSERT INTO spell_script_names VALUES (53472, 'spell_azjol_nerub_pound');
INSERT INTO spell_script_names VALUES (59433, 'spell_azjol_nerub_pound');

-- Anub'ar Assassin (29214, 31586)
REPLACE INTO creature_template_addon VALUES (29214, 0, 0, 0, 0, 0, '53611');
REPLACE INTO creature_template_addon VALUES (31586, 0, 0, 0, 0, 0, '53611');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=29214;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=31586;
DELETE FROM smart_scripts WHERE entryorguid=29214 AND source_type=0;
INSERT INTO smart_scripts VALUES (29214, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 97, 20, 10, 1, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'Anub''ar Assassin - On Respawn - Jump To Pos');
INSERT INTO smart_scripts VALUES (29214, 0, 1, 0, 67, 0, 100, 0, 5000, 5000, 0, 0, 11, 52540, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Assassin - Behind Target - Cast Spell Backstab');

-- Anub'ar Darter (29213, 31597)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=29213;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=31597;
DELETE FROM smart_scripts WHERE entryorguid=29213 AND source_type=0;
INSERT INTO smart_scripts VALUES (29213, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 97, 20, 10, 1, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'Anub''ar Darter - On Respawn - Jump To Pos');
INSERT INTO smart_scripts VALUES (29213, 0, 1, 0, 0, 0, 100, 2, 4000, 5000, 7000, 7000, 11, 53602, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Darter - In Combat - Cast Spell Dart');
INSERT INTO smart_scripts VALUES (29213, 0, 2, 0, 0, 0, 100, 4, 4000, 5000, 7000, 7000, 11, 59349, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Darter - In Combat - Cast Spell Dart');

-- Anub'ar Guardian (29216, 31599)
DELETE FROM creature_loot_template WHERE entry IN(29216, 31599);
UPDATE creature_template SET lootid=0, skinloot=0, AIName='SmartAI', ScriptName='' WHERE entry=29216;
UPDATE creature_template SET lootid=0, skinloot=0, AIName='', ScriptName='' WHERE entry=31599;
DELETE FROM smart_scripts WHERE entryorguid=29216 AND source_type=0;
INSERT INTO smart_scripts VALUES (29216, 0, 0, 0, 0, 0, 100, 2, 5000, 8000, 6000, 6000, 11, 53618, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Guardian - In Combat - Cast Spell Sunder Armor');
INSERT INTO smart_scripts VALUES (29216, 0, 1, 0, 0, 0, 100, 4, 5000, 8000, 6000, 6000, 11, 59350, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Guardian - In Combat - Cast Spell Sunder Armor');
INSERT INTO smart_scripts VALUES (29216, 0, 2, 0, 0, 0, 100, 0, 2000, 3000, 8000, 8000, 11, 52532, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Guardian - In Combat - Cast Spell Strike');

-- Anub'ar Venomancer (29217, 31607)
DELETE FROM creature_loot_template WHERE entry IN(29217, 31607);
UPDATE creature_template SET lootid=0, skinloot=0, AIName='SmartAI', ScriptName='' WHERE entry=29217;
UPDATE creature_template SET lootid=0, skinloot=0, AIName='', ScriptName='' WHERE entry=31607;
DELETE FROM smart_scripts WHERE entryorguid=29217 AND source_type=0;
INSERT INTO smart_scripts VALUES (29217, 0, 0, 0, 0, 0, 100, 2, 5000, 8000, 18000, 22000, 11, 53616, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Venomancer - In Combat - Cast Spell Poison Bolt Volley');
INSERT INTO smart_scripts VALUES (29217, 0, 1, 0, 0, 0, 100, 4, 5000, 8000, 18000, 22000, 11, 59360, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Venomancer - In Combat - Cast Spell Poison Bolt Volley');
INSERT INTO smart_scripts VALUES (29217, 0, 2, 0, 0, 0, 100, 2, 2000, 3000, 7000, 7000, 11, 53617, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Venomancer - In Combat - Cast Spell Poison Bolt');
INSERT INTO smart_scripts VALUES (29217, 0, 3, 0, 0, 0, 100, 4, 2000, 3000, 7000, 7000, 11, 59359, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Venomancer - In Combat - Cast Spell Poison Bolt');

-- Impale Target (29184)
UPDATE creature_template SET unit_flags=33554432+4+131072, flags_extra=130, AIName='SmartAI', ScriptName='' WHERE entry=29184;
DELETE FROM smart_scripts WHERE entryorguid=29184 AND source_type=0;
INSERT INTO smart_scripts VALUES (29184, 0, 0, 0, 60, 0, 100, 257, 0, 0, 0, 0, 11, 53455, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Impale Target - On Update - Cast Spell');
INSERT INTO smart_scripts VALUES (29184, 0, 1, 0, 60, 0, 100, 259, 4000, 4000, 0, 0, 11, 53454, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Impale Target - On Update - Cast Spell');
INSERT INTO smart_scripts VALUES (29184, 0, 2, 0, 60, 0, 100, 261, 4000, 4000, 0, 0, 11, 59446, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Impale Target - On Update - Cast Spell');
INSERT INTO smart_scripts VALUES (29184, 0, 3, 0, 60, 0, 100, 257, 4200, 4200, 0, 0, 28, 53455, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Impale Target - On Update - Remove Aura');
INSERT INTO smart_scripts VALUES (29184, 0, 4, 0, 25, 0, 100, 257, 0, 0, 0, 0, 41, 7000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Impale Target - On Reset - Despawn');

-- SPELL Impale (53457)
DELETE FROM spell_script_names WHERE spell_id IN(53457);
INSERT INTO spell_script_names VALUES (53457, 'spell_gen_select_target_count_15_1');

-- SPELL Impale (53458)
DELETE FROM spell_script_names WHERE spell_id IN(53458);
INSERT INTO spell_script_names VALUES (53458, 'spell_azjol_nerub_impale_summon');


-- -------------------------------------
--             MISC
-- -------------------------------------


-- -------------------------------------
--             ACHIEVEMENTS
-- -------------------------------------

-- Azjol-Nerub (480)
DELETE FROM disables WHERE sourceType=4 AND entry IN(2041, 2042, 2043);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(2041, 2042, 2043);
INSERT INTO achievement_criteria_data VALUES (2041, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES (2042, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES (2043, 12, 0, 0, '');

-- Heroic: Azjol-Nerub (491)
DELETE FROM disables WHERE sourceType=4 AND entry IN(6848, 6849, 6850);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(6848, 6849, 6850);
INSERT INTO achievement_criteria_data VALUES (6848, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES (6849, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES (6850, 12, 1, 0, '');

-- Watch Him Die (1296)
DELETE FROM disables WHERE sourceType=4 AND entry IN(4240);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(4240);
INSERT INTO achievement_criteria_data VALUES (4240, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES (4240, 11, 0, 0, 'achievement_watch_him_die');

-- Hadronox Denied (1297)
DELETE FROM disables WHERE sourceType=4 AND entry IN(4244);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(4244);
INSERT INTO achievement_criteria_data VALUES (4244, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES (4244, 11, 0, 0, 'achievement_hadronox_denied');


-- -------------------------------------------
--           SPELL DIFFICULTY
-- -------------------------------------------

-- Mind Flay (52586, 59367)
DELETE FROM spelldifficulty_dbc WHERE id IN(52586, 59367) OR spellid0 IN(52586, 59367) OR spellid1 IN(52586, 59367) OR spellid2 IN(52586, 59367) OR spellid3 IN(52586, 59367);
INSERT INTO spelldifficulty_dbc VALUES (52586, 52586, 59367, 0, 0);

-- Curse of Fatigue (52592, 59368)
DELETE FROM spelldifficulty_dbc WHERE id IN(52592, 59368) OR spellid0 IN(52592, 59368) OR spellid1 IN(52592, 59368) OR spellid2 IN(52592, 59368) OR spellid3 IN(52592, 59368);
INSERT INTO spelldifficulty_dbc VALUES (52592, 52592, 59368, 0, 0);

-- Smash (53318, 59346)
DELETE FROM spelldifficulty_dbc WHERE id IN(53318, 59346) OR spellid0 IN(53318, 59346) OR spellid1 IN(53318, 59346) OR spellid2 IN(53318, 59346) OR spellid3 IN(53318, 59346);
INSERT INTO spelldifficulty_dbc VALUES (53318, 53318, 59346, 0, 0);

-- Acid Cloud (53400, 59419)
DELETE FROM spelldifficulty_dbc WHERE id IN(53400, 59419) OR spellid0 IN(53400, 59419) OR spellid1 IN(53400, 59419) OR spellid2 IN(53400, 59419) OR spellid3 IN(53400, 59419);
INSERT INTO spelldifficulty_dbc VALUES (53400, 53400, 59419, 0, 0);

-- Leech Poison (53030, 59417)
DELETE FROM spelldifficulty_dbc WHERE id IN(53030, 59417) OR spellid0 IN(53030, 59417) OR spellid1 IN(53030, 59417) OR spellid2 IN(53030, 59417) OR spellid3 IN(53030, 59417);
INSERT INTO spelldifficulty_dbc VALUES (53030, 53030, 59417, 0, 0);

-- Web Grab (57731, 59421)
DELETE FROM spelldifficulty_dbc WHERE id IN(57731, 59421) OR spellid0 IN(57731, 59421) OR spellid1 IN(57731, 59421) OR spellid2 IN(57731, 59421) OR spellid3 IN(57731, 59421);
INSERT INTO spelldifficulty_dbc VALUES (57731, 57731, 59421, 0, 0);

-- Leeching Swarm (53467, 59430)
DELETE FROM spelldifficulty_dbc WHERE id IN(53467, 59430) OR spellid0 IN(53467, 59430) OR spellid1 IN(53467, 59430) OR spellid2 IN(53467, 59430) OR spellid3 IN(53467, 59430);
INSERT INTO spelldifficulty_dbc VALUES (53467, 53467, 59430, 0, 0);

-- Pound (53472)
DELETE FROM spelldifficulty_dbc WHERE id IN(53472, 59433) OR spellid0 IN(53472, 59433) OR spellid1 IN(53472, 59433) OR spellid2 IN(53472, 59433) OR spellid3 IN(53472, 59433);

-- Pound (53509
DELETE FROM spelldifficulty_dbc WHERE id IN(53509, 59432) OR spellid0 IN(53509, 59432) OR spellid1 IN(53509, 59432) OR spellid2 IN(53509, 59432) OR spellid3 IN(53509, 59432);
