

-- -------------------------------------------
--                TRASH
-- -------------------------------------------

-- Azure Magus (26722, 30457)
UPDATE creature_template SET lootid=26722, dmg_multiplier=6, pickpocketloot=0, skinloot=70212, mechanic_immune_mask=0, AIName='SmartAI', ScriptName='' WHERE entry=26722;
UPDATE creature_template SET lootid=26722, dmg_multiplier=12, pickpocketloot=0, skinloot=70212, mechanic_immune_mask=0, AIName='', ScriptName='' WHERE entry=30457;
DELETE FROM smart_scripts WHERE entryorguid=26722 AND source_type=0;
INSERT INTO smart_scripts VALUES (26722, 0, 0, 0, 0, 0, 100, 2, 0, 1000, 2000, 2500, 11, 15530, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Azure Magus - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (26722, 0, 1, 0, 0, 0, 100, 4, 0, 1000, 2000, 2500, 11, 56775, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Azure Magus - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (26722, 0, 2, 0, 0, 0, 100, 2, 2000, 10000, 15000, 15000, 11, 37132, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Azure Magus - In Combat - Cast Arcane Shock');
INSERT INTO smart_scripts VALUES (26722, 0, 3, 0, 0, 0, 100, 4, 2000, 10000, 15000, 15000, 11, 56776, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Azure Magus - In Combat - Cast Arcane Shock');

-- Azure Warder (26716, 30459)
UPDATE creature_template SET lootid=26716, dmg_multiplier=6, pickpocketloot=0, skinloot=70212, mechanic_immune_mask=0, AIName='SmartAI', ScriptName='' WHERE entry=26716;
UPDATE creature_template SET lootid=26716, dmg_multiplier=12, pickpocketloot=0, skinloot=70212, mechanic_immune_mask=0, AIName='', ScriptName='' WHERE entry=30459;
DELETE FROM smart_scripts WHERE entryorguid=26716 AND source_type=0;
INSERT INTO smart_scripts VALUES (26716, 0, 0, 0, 2, 0, 100, 2, 0, 40, 30000, 30000, 11, 17741, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Azure Warder - Between HP 0-40% - Cast Mana Shield');
INSERT INTO smart_scripts VALUES (26716, 0, 1, 0, 2, 0, 100, 4, 0, 40, 30000, 30000, 11, 56778, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Azure Warder - Between HP 0-40% - Cast Mana Shield');
INSERT INTO smart_scripts VALUES (26716, 0, 2, 0, 0, 0, 100, 2, 2000, 10000, 15000, 15000, 11, 6726, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Azure Warder - In Combat - Cast Silence');
INSERT INTO smart_scripts VALUES (26716, 0, 3, 0, 0, 0, 100, 4, 2000, 10000, 15000, 15000, 11, 56777, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Azure Warder - In Combat - Cast Silence');

-- Mage Slayer (26730, 30473)
UPDATE creature_template SET lootid=26730, dmg_multiplier=6, pickpocketloot=0, skinloot=70212, mechanic_immune_mask=0, AIName='SmartAI', ScriptName='' WHERE entry=26730;
UPDATE creature_template SET lootid=26730, dmg_multiplier=12, pickpocketloot=0, skinloot=70212, mechanic_immune_mask=0, AIName='', ScriptName='' WHERE entry=30473;
DELETE FROM smart_scripts WHERE entryorguid=26730 AND source_type=0;
INSERT INTO smart_scripts VALUES (26730, 0, 0, 0, 0, 0, 100, 0, 2000, 10000, 15000, 25000, 11, 50131, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mage Slayer - In Combat - Cast Draw Magic');
INSERT INTO smart_scripts VALUES (26730, 0, 1, 0, 13, 0, 100, 0, 8000, 12000, 0, 0, 11, 30849, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mage Slayer - Victim Casting - Cast Spell Lock');

-- Mage Hunter Ascendant (26727, 30460)
UPDATE creature SET spawndist=0, MovementType=0 WHERE id=26727;
UPDATE creature_template SET lootid=26727, dmg_multiplier=6, pickpocketloot=26727, skinloot=0, mechanic_immune_mask=0, AIName='SmartAI', ScriptName='' WHERE entry=26727;
UPDATE creature_template SET lootid=26727, dmg_multiplier=12, pickpocketloot=26727, skinloot=0, mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=30460;
DELETE FROM smart_scripts WHERE entryorguid=26727 AND source_type=0;
INSERT INTO smart_scripts VALUES (26727, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 30, 1, 2, 3, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mage Hunter Ascendant - On Reset - Set Random Event Phase');
INSERT INTO smart_scripts VALUES (26727, 0, 1, 0, 0, 1, 100, 2, 5000, 10000, 60000, 60000, 11, 50182, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mage Hunter Ascendant - In Combat - Cast Aura of Arcane Haste');
INSERT INTO smart_scripts VALUES (26727, 0, 2, 0, 0, 1, 100, 4, 5000, 10000, 60000, 60000, 11, 56827, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mage Hunter Ascendant - In Combat - Cast Aura of Arcane Haste');
INSERT INTO smart_scripts VALUES (26727, 0, 3, 0, 0, 1, 100, 1, 0, 0, 0, 0, 11, 35191, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mage Hunter Ascendant - In Combat - Cast Arcane Explosion Proc');
INSERT INTO smart_scripts VALUES (26727, 0, 4, 0, 0, 1, 100, 0, 3000, 6000, 30000, 40000, 11, 47789, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mage Hunter Ascendant - In Combat - Cast Arcane Trap');
INSERT INTO smart_scripts VALUES (26727, 0, 5, 0, 0, 1, 100, 0, 3000, 6000, 5000, 10000, 11, 13323, 0, 0, 0, 0, 0, 6, 30, 0, 0, 0, 0, 0, 0, 'Mage Hunter Ascendant - In Combat - Cast Polymorph');
INSERT INTO smart_scripts VALUES (26727, 0, 6, 0, 0, 2, 100, 2, 0, 1000, 3000, 3500, 11, 12737, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mage Hunter Ascendant - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (26727, 0, 7, 0, 0, 2, 100, 4, 0, 1000, 3000, 3500, 11, 56837, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mage Hunter Ascendant - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (26727, 0, 8, 0, 0, 2, 100, 2, 4000, 9000, 12000, 12500, 11, 15244, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mage Hunter Ascendant - In Combat - Cast Cone of Cold');
INSERT INTO smart_scripts VALUES (26727, 0, 9, 0, 0, 2, 100, 4, 4000, 9000, 12000, 12500, 11, 38384, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mage Hunter Ascendant - In Combat - Cast Cone of Cold');
INSERT INTO smart_scripts VALUES (26727, 0, 10, 0, 0, 2, 100, 0, 3000, 6000, 30000, 40000, 11, 55040, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mage Hunter Ascendant - In Combat - Cast Freezing Trap');
INSERT INTO smart_scripts VALUES (26727, 0, 11, 0, 0, 4, 100, 2, 0, 1000, 3000, 3500, 11, 12466, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mage Hunter Ascendant - In Combat - Cast Fireball');
INSERT INTO smart_scripts VALUES (26727, 0, 12, 0, 0, 4, 100, 4, 0, 1000, 3000, 3500, 11, 17290, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mage Hunter Ascendant - In Combat - Cast Fireball');
INSERT INTO smart_scripts VALUES (26727, 0, 13, 0, 0, 4, 100, 2, 4000, 9000, 22000, 25500, 11, 36808, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Mage Hunter Ascendant - In Combat - Cast Rain of Fire');
INSERT INTO smart_scripts VALUES (26727, 0, 14, 0, 0, 4, 100, 4, 4000, 9000, 22000, 25500, 11, 39376, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Mage Hunter Ascendant - In Combat - Cast Rain of Fire');
INSERT INTO smart_scripts VALUES (26727, 0, 15, 0, 0, 4, 100, 0, 3000, 6000, 30000, 40000, 11, 47784, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mage Hunter Ascendant - In Combat - Cast Immolation Trap');

-- Steward (26729, 30485)
UPDATE creature_template SET lootid=26729, dmg_multiplier=6, pickpocketloot=26729, skinloot=0, mechanic_immune_mask=0, AIName='SmartAI', ScriptName='' WHERE entry=26729;
UPDATE creature_template SET lootid=26729, dmg_multiplier=12, pickpocketloot=26729, skinloot=0, mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=30485;
DELETE FROM smart_scripts WHERE entryorguid=26729 AND source_type=0;
INSERT INTO smart_scripts VALUES (26729, 0, 0, 0, 0, 0, 100, 0, 2000, 10000, 10000, 15000, 11, 47779, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Steward - In Combat - Cast Arcane Torrent');
INSERT INTO smart_scripts VALUES (26729, 0, 1, 0, 0, 0, 100, 0, 1000, 7000, 10000, 12000, 11, 47780, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Steward - In Combat - Cast Spellbreaker');

-- Mage Hunter Initiate (26728, 30478)
UPDATE creature_template SET lootid=26728, dmg_multiplier=6, pickpocketloot=25430, skinloot=0, mechanic_immune_mask=0, AIName='SmartAI', ScriptName='' WHERE entry=26728;
UPDATE creature_template SET lootid=26728, dmg_multiplier=12, pickpocketloot=25430, skinloot=0, mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=30478;
DELETE FROM smart_scripts WHERE entryorguid=26728 AND source_type=0;
INSERT INTO smart_scripts VALUES (26728, 0, 0, 0, 0, 0, 100, 0, 2000, 10000, 15000, 25000, 11, 17682, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mage Hunter Initiate - In Combat - Cast Drain Mana');
INSERT INTO smart_scripts VALUES (26728, 0, 1, 0, 0, 0, 100, 2, 1000, 5000, 7000, 9000, 11, 50198, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Mage Hunter Initiate - In Combat - Cast Magic Burn');
INSERT INTO smart_scripts VALUES (26728, 0, 2, 0, 0, 0, 100, 4, 1000, 5000, 7000, 9000, 11, 56860, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Mage Hunter Initiate - In Combat - Cast Magic Burn');
INSERT INTO smart_scripts VALUES (26728, 0, 3, 0, 14, 0, 100, 0, 5000, 40, 9000, 9000, 11, 25058, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Mage Hunter Initiate - Friendly Missing Health - Cast Renew');

-- Azure Enforcer (26734, 30516)
UPDATE creature SET spawndist=0, MovementType=0, unit_flags=0, dynamicflags=0 WHERE id=26734;
UPDATE creature_template SET lootid=26734, dmg_multiplier=6, pickpocketloot=0, skinloot=70211, mechanic_immune_mask=0, AIName='SmartAI', ScriptName='' WHERE entry=26734;
UPDATE creature_template SET lootid=26734, dmg_multiplier=12, pickpocketloot=0, skinloot=70211, mechanic_immune_mask=0, AIName='', ScriptName='' WHERE entry=30516;
DELETE FROM smart_scripts WHERE entryorguid=26734 AND source_type=0;
INSERT INTO smart_scripts VALUES (26734, 0, 0, 0, 0, 0, 100, 0, 2000, 10000, 10000, 15000, 11, 58460, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Azure Enforcer - In Combat - Cast Brutal Strike');
INSERT INTO smart_scripts VALUES (26734, 0, 1, 0, 0, 0, 100, 0, 1000, 7000, 10000, 12000, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Azure Enforcer - In Combat - Cast Cleave');

-- Azure Scale-Binder (26735, 30517)
UPDATE creature_template SET lootid=26735, dmg_multiplier=6, pickpocketloot=0, skinloot=70211, mechanic_immune_mask=0, AIName='SmartAI', ScriptName='' WHERE entry=26735;
UPDATE creature_template SET lootid=26735, dmg_multiplier=12, pickpocketloot=0, skinloot=70211, mechanic_immune_mask=0, AIName='', ScriptName='' WHERE entry=30517;
DELETE FROM smart_scripts WHERE entryorguid=26735 AND source_type=0;
INSERT INTO smart_scripts VALUES (26735, 0, 0, 0, 0, 0, 100, 2, 1000, 3000, 3000, 4000, 11, 38881, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Azure Scale-Binder - In Combat - Cast Arcane Blast');
INSERT INTO smart_scripts VALUES (26735, 0, 1, 0, 0, 0, 100, 4, 1000, 3000, 3000, 4000, 11, 56969, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Azure Scale-Binder - In Combat - Cast Arcane Blast');
INSERT INTO smart_scripts VALUES (26735, 0, 2, 0, 14, 0, 100, 2, 5000, 40, 6000, 6000, 11, 15586, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Azure Scale-Binder - Friendly Missing Health - Cast Heal');
INSERT INTO smart_scripts VALUES (26735, 0, 3, 0, 14, 0, 100, 4, 10000, 40, 6000, 6000, 11, 61326, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Azure Scale-Binder - Friendly Missing Health - Cast Heal');

-- Crazed Mana-Surge (26737, 30519)
UPDATE creature_template SET lootid=26737, dmg_multiplier=6, unit_flags=0, pickpocketloot=0, skinloot=0, mechanic_immune_mask=0, AIName='SmartAI', ScriptName='' WHERE entry=26737;
UPDATE creature_template SET lootid=26737, dmg_multiplier=12, unit_flags=0, pickpocketloot=0, skinloot=0, mechanic_immune_mask=0, AIName='', ScriptName='' WHERE entry=30519;
DELETE FROM smart_scripts WHERE entryorguid=26737 AND source_type=0;
INSERT INTO smart_scripts VALUES (26737, 0, 0, 0, 0, 0, 100, 2, 1000, 7000, 6000, 12000, 11, 47696, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crazed Mana-Surge - In Combat - Cast Arcane Nova');
INSERT INTO smart_scripts VALUES (26737, 0, 1, 0, 0, 0, 100, 4, 1000, 7000, 6000, 12000, 11, 57046, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crazed Mana-Surge - In Combat - Cast Arcane Nova');
INSERT INTO smart_scripts VALUES (26737, 0, 2, 0, 0, 0, 100, 2, 1000, 7000, 6000, 12000, 11, 48054, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crazed Mana-Surge - In Combat - Cast Mana Burn');
INSERT INTO smart_scripts VALUES (26737, 0, 3, 0, 0, 0, 100, 4, 1000, 7000, 6000, 12000, 11, 57047, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crazed Mana-Surge - In Combat - Cast Mana Burn');
INSERT INTO smart_scripts VALUES (26737, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 29882, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crazed Mana-Surge - On Death - Cast Loose Mana');

-- Crystalline Tender (28231, 30525)
UPDATE creature_template SET lootid=28231, dmg_multiplier=6, pickpocketloot=0, skinloot=0, mechanic_immune_mask=0, AIName='SmartAI', ScriptName='' WHERE entry=28231;
UPDATE creature_template SET lootid=28231, dmg_multiplier=12, pickpocketloot=0, skinloot=0, mechanic_immune_mask=0, AIName='', ScriptName='' WHERE entry=30525;
DELETE FROM smart_scripts WHERE entryorguid=28231 AND source_type=0;
INSERT INTO smart_scripts VALUES (28231, 0, 0, 0, 0, 0, 100, 0, 2000, 10000, 20000, 20000, 11, 50994, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crystalline Tender - In Combat - Cast Toughen Hide');
INSERT INTO smart_scripts VALUES (28231, 0, 1, 0, 0, 0, 100, 2, 7000, 12000, 15000, 15000, 11, 51972, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crystalline Tender - In Combat - Cast Tranquility');
INSERT INTO smart_scripts VALUES (28231, 0, 2, 0, 0, 0, 100, 4, 7000, 12000, 15000, 15000, 11, 57054, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crystalline Tender - In Combat - Cast Tranquility');

-- Crystalline Protector (26792, 30524)
DELETE FROM creature_loot_template WHERE entry IN(26792, 30524);
INSERT INTO creature_loot_template VALUES (26792, 35490, -100, 1, 0, 1, 1);
UPDATE creature_template SET lootid=26792, dmg_multiplier=6, pickpocketloot=0, skinloot=80007, mechanic_immune_mask=0, AIName='SmartAI', ScriptName='' WHERE entry=26792;
UPDATE creature_template SET lootid=26792, dmg_multiplier=12, pickpocketloot=0, skinloot=80007, mechanic_immune_mask=0, AIName='', ScriptName='' WHERE entry=30524;
DELETE FROM smart_scripts WHERE entryorguid=26792 AND source_type=0;
INSERT INTO smart_scripts VALUES (26792, 0, 0, 0, 0, 0, 100, 0, 2000, 7000, 10000, 15000, 11, 30633, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crystalline Protector - In Combat - Cast Thunderclap');
INSERT INTO smart_scripts VALUES (26792, 0, 1, 0, 0, 0, 100, 2, 1000, 7000, 13000, 18000, 11, 47698, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Crystalline Protector - In Combat - Cast Crystal Chains');
INSERT INTO smart_scripts VALUES (26792, 0, 2, 0, 0, 0, 100, 4, 1000, 7000, 13000, 18000, 11, 57050, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Crystalline Protector - In Combat - Cast Crystal Chains');
INSERT INTO smart_scripts VALUES (26792, 0, 3, 0, 0, 0, 100, 2, 1000, 7000, 13000, 18000, 11, 50302, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crystalline Protector - In Combat - Cast Shard Spray');
INSERT INTO smart_scripts VALUES (26792, 0, 4, 0, 0, 0, 100, 4, 1000, 7000, 13000, 18000, 11, 57051, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crystalline Protector - In Combat - Cast Shard Spray');

-- Crystalline Keeper (26782, 30526)
UPDATE creature_template SET lootid=26782, dmg_multiplier=6, pickpocketloot=0, skinloot=80007, mechanic_immune_mask=0, AIName='SmartAI', ScriptName='' WHERE entry=26782;
UPDATE creature_template SET lootid=26782, dmg_multiplier=12, pickpocketloot=0, skinloot=80007, mechanic_immune_mask=0, AIName='', ScriptName='' WHERE entry=30526;
DELETE FROM smart_scripts WHERE entryorguid=26782 AND source_type=0;
INSERT INTO smart_scripts VALUES (26782, 0, 0, 0, 1, 0, 100, 0, 0, 0, 120000, 120000, 11, 47699, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crystalline Keeper - Out of Combat - Cast Crystal Brak');
INSERT INTO smart_scripts VALUES (26782, 0, 1, 0, 0, 0, 100, 2, 2000, 4000, 6000, 8000, 11, 33688, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crystalline Keeper - In Combat - Cast Crystal Strike');
INSERT INTO smart_scripts VALUES (26782, 0, 2, 0, 0, 0, 100, 4, 2000, 4000, 6000, 8000, 11, 57052, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crystalline Keeper - In Combat - Cast Crystal Strike');

-- Crystalline Frayer (26793, 30528)
REPLACE INTO creature_text VALUES(26793, 0, 0, 'Crystalline Frayer begins to emerge from its Seed Pod', 16, 0, 100, 0, 0, 0, 0, 'Crystalline Frayer');
UPDATE creature_template SET RegenHealth=1, AIName='', ScriptName='npc_crystalline_frayer' WHERE entry=26793;
UPDATE creature_template SET RegenHealth=1, AIName='', ScriptName='' WHERE entry=30528;
DELETE FROM smart_scripts WHERE entryorguid=26793 and source_type=0;

-- SPELL Aura of Regeneration (52067)
-- SPELL Aura of Regeneration (57056)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(52067, 57056);
INSERT INTO conditions VALUES(13, 3, 52067, 0, 0, 31, 0, 3, 0, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 3, 52067, 0, 1, 31, 0, 4, 0, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 7, 57056, 0, 0, 31, 0, 3, 0, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 7, 57056, 0, 1, 31, 0, 4, 0, 0, 0, 0, 0, '', '');



-- -------------------------------------------
--                BOSSES
-- -------------------------------------------

-- Grand Magus Telestra (26731, 30510)
DELETE FROM creature_text WHERE entry=26731;
INSERT INTO creature_text VALUES (26731, 0, 0, 'You know what they say about curiosity...', 14, 0, 100, 0, 0, 13319, 0, 'grand magus telestra SAY_AGGRO');
INSERT INTO creature_text VALUES (26731, 1, 0, 'Death becomes you!', 14, 0, 100, 0, 0, 13324, 0, 'grand magus telestra SAY_KILL');
INSERT INTO creature_text VALUES (26731, 2, 0, 'Damn the... luck.', 14, 0, 100, 0, 0, 13320, 0, 'grand magus telestra SAY_DEATH');
INSERT INTO creature_text VALUES (26731, 3, 0, 'Now to finish the job!', 14, 0, 100, 0, 0, 13323, 0, 'grand magus telestra SAY_MERGE');
INSERT INTO creature_text VALUES (26731, 4, 0, 'There''s plenty of me to go around.', 14, 0, 100, 0, 0, 13321, 0, 'grand magus telestra SAY_SPLIT_1');
INSERT INTO creature_text VALUES (26731, 4, 1, 'I''ll give you more than you can handle.', 14, 0, 100, 0, 0, 13322, 0, 'grand magus telestra SAY_SPLIT_2');
UPDATE creature_template SET dmg_multiplier=10, lootid=26731, pickpocketloot=0, skinloot=0, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='boss_magus_telestra' WHERE entry=26731;
UPDATE creature_template SET dmg_multiplier=20, lootid=30510, pickpocketloot=0, skinloot=0, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='' WHERE entry=30510;

-- Grand Magus Telestra (26928, 30511), FIRE
REPLACE INTO creature_template_addon VALUES (26928, 0, 0, 0, 4097, 0, '47705');
REPLACE INTO creature_template_addon VALUES (30511, 0, 0, 0, 4097, 0, '47705');
UPDATE creature_template SET lootid=0, dmg_multiplier=5, pickpocketloot=0, skinloot=0, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='SmartAI', ScriptName='' WHERE entry=26928;
UPDATE creature_template SET lootid=0, dmg_multiplier=10, pickpocketloot=0, skinloot=0, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='' WHERE entry=30511;
DELETE FROM smart_scripts WHERE entryorguid=26928 AND source_type=0;
INSERT INTO smart_scripts VALUES (26928, 0, 0, 0, 0, 0, 100, 2, 0, 2000, 8000, 10000, 11, 47721, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grand Magus Telestra - In Combat - Cast Fire Blast');
INSERT INTO smart_scripts VALUES (26928, 0, 1, 0, 0, 0, 100, 4, 0, 2000, 8000, 10000, 11, 56939, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grand Magus Telestra - In Combat - Cast Fire Blast');
INSERT INTO smart_scripts VALUES (26928, 0, 2, 0, 0, 0, 100, 2, 0, 1000, 3000, 3000, 11, 47723, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Grand Magus Telestra - In Combat - Cast Scorch');
INSERT INTO smart_scripts VALUES (26928, 0, 3, 0, 0, 0, 100, 4, 0, 1000, 3000, 3000, 11, 56938, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Grand Magus Telestra - In Combat - Cast Scorch');
INSERT INTO smart_scripts VALUES (26928, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 47711, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Magus Telestra - On Death - Cast Telestra Clone Dies (Fire)');

-- Grand Magus Telestra (26930, 30513), FROST
REPLACE INTO creature_template_addon VALUES (26930, 0, 0, 0, 4097, 0, '47706');
REPLACE INTO creature_template_addon VALUES (30513, 0, 0, 0, 4097, 0, '47706');
UPDATE creature_template SET lootid=0, dmg_multiplier=5, pickpocketloot=0, skinloot=0, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='SmartAI', ScriptName='' WHERE entry=26930;
UPDATE creature_template SET lootid=0, dmg_multiplier=10, pickpocketloot=0, skinloot=0, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='' WHERE entry=30513;
DELETE FROM smart_scripts WHERE entryorguid=26930 AND source_type=0;
INSERT INTO smart_scripts VALUES (26930, 0, 0, 0, 0, 0, 100, 2, 0, 2000, 10000, 12000, 11, 47727, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grand Magus Telestra - In Combat - Cast Blizzard');
INSERT INTO smart_scripts VALUES (26930, 0, 1, 0, 0, 0, 100, 4, 0, 2000, 10000, 12000, 11, 56936, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grand Magus Telestra - In Combat - Cast Fire Blast');
INSERT INTO smart_scripts VALUES (26930, 0, 2, 0, 0, 0, 100, 2, 0, 1000, 3000, 3000, 11, 47729, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Grand Magus Telestra - In Combat - Cast Ice Barb');
INSERT INTO smart_scripts VALUES (26930, 0, 3, 0, 0, 0, 100, 4, 0, 1000, 3000, 3000, 11, 56937, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Grand Magus Telestra - In Combat - Cast Ice Barb');
INSERT INTO smart_scripts VALUES (26930, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 47712, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Magus Telestra - On Death - Cast Telestra Clone Dies (Frost)');

-- Grand Magus Telestra (26929, 30512), ARCANE
REPLACE INTO creature_template_addon VALUES (26929, 0, 0, 0, 4097, 0, '47704');
REPLACE INTO creature_template_addon VALUES (30512, 0, 0, 0, 4097, 0, '47704');
UPDATE creature_template SET lootid=0, dmg_multiplier=5, pickpocketloot=0, skinloot=0, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='SmartAI', ScriptName='' WHERE entry=26929;
UPDATE creature_template SET lootid=0, dmg_multiplier=10, pickpocketloot=0, skinloot=0, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='' WHERE entry=30512;
DELETE FROM smart_scripts WHERE entryorguid=26929 AND source_type=0;
INSERT INTO smart_scripts VALUES (26929, 0, 0, 0, 0, 0, 100, 0, 0, 2000, 12000, 12000, 11, 47736, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Magus Telestra - In Combat - Cast Time Stop');
INSERT INTO smart_scripts VALUES (26929, 0, 1, 0, 0, 0, 100, 0, 0, 5000, 10000, 10000, 11, 47731, 64, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Grand Magus Telestra - In Combat - Cast Critter');
INSERT INTO smart_scripts VALUES (26929, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 47713, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Magus Telestra - On Death - Cast Telestra Clone Dies (Arcane)');

-- World Trigger (Alliance Friendly + Invis Man) (20213)
UPDATE creature_template SET modelid1=15435, modelid2=0 WHERE entry=20213;

-- SPELL Telestra Clone Dies (Fire) (47711)
-- SPELL Telestra Clone Dies (Frost) (47712)
-- SPELL Telestra Clone Dies (Arcane) (47713)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(47711, 47712, 47713);
INSERT INTO conditions VALUES(13, 1, 47711, 0, 0, 31, 0, 3, 26731, 0, 0, 0, 0, '', 'Target Grand Magus Telestra');
INSERT INTO conditions VALUES(13, 1, 47712, 0, 0, 31, 0, 3, 26731, 0, 0, 0, 0, '', 'Target Grand Magus Telestra');
INSERT INTO conditions VALUES(13, 1, 47713, 0, 0, 31, 0, 3, 26731, 0, 0, 0, 0, '', 'Target Grand Magus Telestra');

-- SPELL Summon Telestra Clones (47710)
DELETE FROM spell_script_names WHERE spell_id=47710;
INSERT INTO spell_script_names VALUES(47710, 'spell_boss_magus_telestra_summon_telestra_clones');

-- SPELL Gravity Well Effect (47764)
DELETE FROM spell_script_names WHERE spell_id=47764;
INSERT INTO spell_script_names VALUES(47764, 'spell_boss_magus_telestra_gravity_well');

-- Anomalus (26763, 30529)
DELETE FROM creature_text WHERE entry=26763;
INSERT INTO creature_text VALUES (26763, 0, 0, 'Chaos beckons.', 14, 0, 100, 0, 0, 13186, 0, 'anomalus SAY_AGGRO');
INSERT INTO creature_text VALUES (26763, 1, 0, 'Of course.', 14, 0, 100, 0, 0, 13187, 0, 'anomalus SAY_DEATH');
INSERT INTO creature_text VALUES (26763, 2, 0, 'Reality... unwoven.', 14, 0, 100, 0, 0, 13188, 0, 'anomalus SAY_RIFT');
INSERT INTO creature_text VALUES (26763, 2, 1, 'Indestructible.', 14, 0, 100, 0, 0, 13189, 0, 'anomalus SAY_RIFT');
INSERT INTO creature_text VALUES (26763, 3, 0, '%s opens a Chaotic Rift!', 41, 0, 100, 0, 0, 0, 0, 'Anomalus EMOTE_RIFT');
INSERT INTO creature_text VALUES (26763, 4, 0, '%s shields himself and diverts his power to the rifts!', 41, 0, 100, 0, 0, 0, 0, 'Anomalus EMOTE_SHIELD');
UPDATE creature_template SET dmg_multiplier=10, lootid=26763, pickpocketloot=0, skinloot=0, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='boss_anomalus' WHERE entry=26763;
UPDATE creature_template SET dmg_multiplier=20, lootid=30529, pickpocketloot=0, skinloot=0, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='' WHERE entry=30529;

-- Chaotic Rift (26918, 30522)
REPLACE INTO creature VALUES (126434, 26918, 576, 3, 1, 0, 0, 688.774, -141.804, -28.8962, 4.85202, 3600, 0, 0, 16724, 0, 0, 0, 0, 0);
REPLACE INTO creature VALUES (126435, 26918, 576, 3, 1, 0, 0, 634.917, -207.815, -15.1531, 3.76991, 3600, 0, 0, 16724, 0, 0, 0, 0, 0);
REPLACE INTO creature VALUES (126436, 26918, 576, 3, 1, 0, 0, 556.735, -199.446, -23.4018, 0.331613, 3600, 0, 0, 16724, 0, 0, 0, 0, 0);
REPLACE INTO creature VALUES (126437, 26918, 576, 3, 1, 0, 0, 571.52, -120.983, -26.5417, 4.85202, 3600, 0, 0, 16724, 0, 0, 0, 0, 0);
REPLACE INTO creature VALUES (126438, 26918, 576, 3, 1, 0, 0, 625.385, -109.864, -15.1531, 0.575959, 3600, 0, 0, 16724, 0, 0, 0, 0, 0);
REPLACE INTO creature VALUES (126439, 26918, 576, 3, 1, 0, 0, 721.098, -148.022, -28.8962, 3.03687, 3600, 0, 0, 16724, 0, 0, 0, 0, 0);
REPLACE INTO creature_template_addon VALUES (26918, 0, 0, 0, 4097, 0, '48019 47687');
REPLACE INTO creature_template_addon VALUES (30522, 0, 0, 0, 4097, 0, '48019 47687');
UPDATE creature_template SET unit_flags=4|131072, lootid=0, pickpocketloot=0, skinloot=0, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='SmartAI', ScriptName='' WHERE entry=26918;
UPDATE creature_template SET unit_flags=4|131072, lootid=0, pickpocketloot=0, skinloot=0, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='' WHERE entry=30522;
DELETE FROM smart_scripts WHERE entryorguid=26918 AND source_type=0;
INSERT INTO smart_scripts VALUES (26918, 0, 0, 0, 60, 0, 100, 0, 5000, 5000, 10000, 10000, 11, 47692, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Chaotic Rift - On Update - Cast Summon Arcane Wraith');
INSERT INTO smart_scripts VALUES (26918, 0, 1, 2, 8, 0, 100, 0, 47747, 0, 0, 0, 28, 47687, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Chaotic Rift - On Spell Hit - Remove Aura Chaotic Rift Aura');
INSERT INTO smart_scripts VALUES (26918, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 11, 47733, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Chaotic Rift - On Spell Hit - Cast Chaotic Rift Aura');
INSERT INTO smart_scripts VALUES (26918, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Chaotic Rift - On Spell Hit - Set Event Phase');
INSERT INTO smart_scripts VALUES (26918, 0, 4, 0, 60, 1, 100, 0, 10000, 10000, 10000, 10000, 11, 47692, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Chaotic Rift - On Update - Cast Summon Arcane Wraith');
INSERT INTO smart_scripts VALUES (26918, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 45, 26763, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Chaotic Rift - On Death - Set Data');

-- Crazed Mana-Wraith (26746, 30520)
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=26746);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=26746);
DELETE FROM creature WHERE id=26746;
UPDATE creature_template SET lootid=0, pickpocketloot=0, skinloot=0, AIName='SmartAI', ScriptName='' WHERE entry=26746;
UPDATE creature_template SET lootid=0, pickpocketloot=0, skinloot=0, AIName='', ScriptName='' WHERE entry=30520;
DELETE FROM smart_scripts WHERE entryorguid=26746 AND source_type=0;
INSERT INTO smart_scripts VALUES (26746, 0, 0, 0, 0, 0, 100, 0, 0, 5000, 10000, 10000, 11, 33832, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crazed Mana-Wraith - In Combat - Cast Arcane Missiles');
INSERT INTO smart_scripts VALUES (26746, 0, 1, 0, 54, 0, 100, 0, 0, 0, 0, 0, 11, 51347, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crazed Mana-Wraith - Is Summoned By - Cast Teleport Visual');
INSERT INTO smart_scripts VALUES (26746, 0, 2, 0, 1, 0, 100, 1, 0, 0, 0, 0, 89, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crazed Mana-Wraith - Out of Combat - Move Random');

-- SPELL Close Rifts (47745)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(47745);
INSERT INTO conditions VALUES(13, 3, 47745, 0, 0, 31, 0, 3, 26731, 0, 0, 0, 0, '', 'Target Chaotic Rift');
INSERT INTO conditions VALUES(13, 3, 47745, 0, 1, 31, 0, 3, 26746, 0, 0, 0, 0, '', 'Target Crazed Mana-Wraith');

-- SPELL Charge Rifts (47747)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(47747);
INSERT INTO conditions VALUES(13, 1, 47747, 0, 0, 31, 0, 3, 26918, 0, 0, 0, 0, '', 'Target Chaotic Rift');
INSERT INTO conditions VALUES(13, 1, 47747, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', '');

-- Ormorok the Tree-Shaper (26794, 30532)
DELETE FROM creature_text WHERE entry=26794;
INSERT INTO creature_text VALUES (26794, 1, 0, 'Noo!', 14, 0, 0, 0, 0, 13328, 0, 'ormorok SAY_AGGRO');
INSERT INTO creature_text VALUES (26794, 2, 0, 'Aaggh!', 14, 0, 0, 0, 0, 13330, 0, 'ormorok SAY_DEATH');
INSERT INTO creature_text VALUES (26794, 3, 0, 'Back!', 14, 0, 0, 0, 0, 13331, 0, 'ormorok SAY_REFLECT');
INSERT INTO creature_text VALUES (26794, 4, 0, 'Bleed!', 14, 0, 0, 0, 0, 13332, 0, 'ormorok SAY_CRYSTAL_SPIKES');
INSERT INTO creature_text VALUES (26794, 5, 0, 'Aaggh! Kill!', 14, 0, 0, 0, 0, 13329, 0, 'ormorok SAY_KILL');
INSERT INTO creature_text VALUES (26794, 6, 0, '%s goes into a frenzy!', 41, 0, 100, 0, 0, 0, 0, 'Ormorok the Tree-Shaper');
UPDATE creature_template SET dmg_multiplier=10, lootid=26794, pickpocketloot=0, skinloot=0, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='boss_ormorok' WHERE entry=26794;
UPDATE creature_template SET dmg_multiplier=20, lootid=30532, pickpocketloot=0, skinloot=0, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='' WHERE entry=30532;

-- Crystalline Tangler (32665)
REPLACE INTO creature_template_addon VALUES (32665, 0, 0, 0, 4097, 0, '61555');
UPDATE creature_template SET dmg_multiplier=2, lootid=0, pickpocketloot=0, skinloot=0, AIName='', ScriptName='' WHERE entry=32665;
DELETE FROM smart_scripts WHERE entryorguid=32665 AND source_type=0;

-- Crystal Spike (27099, 30539)
UPDATE creature_template SET unit_flags=33554944, lootid=0, pickpocketloot=0, skinloot=0, AIName='', ScriptName='npc_crystal_spike' WHERE entry=27099;
UPDATE creature_template SET unit_flags=33554944, lootid=0, pickpocketloot=0, skinloot=0, AIName='', ScriptName='' WHERE entry=30539;
DELETE FROM smart_scripts WHERE entryorguid=27099 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=2709900 AND source_type=9;

-- Crystal Spike Trigger (27079)
UPDATE creature_template SET AIName='NullCreatureAI', ScriptName='' WHERE entry=27079;

-- Crystal Spike Initial Trigger (27101)
UPDATE creature_template SET AIName='NullCreatureAI', ScriptName='' WHERE entry=27101;

-- SPELL Crystal Spike (47941)
DELETE FROM spell_script_names WHERE ScriptName='spell_crystal_spike' AND spell_id=47941;

-- Keristrasza (26723, 30540)
DELETE FROM creature_text WHERE entry=26723;
INSERT INTO creature_text VALUES (26723, 0, 0, 'Preserve? Why? There''s no truth in it. No no no... only in the taking! I see that now!', 14, 0, 100, 0, 0, 13450, 0, 'keristrasza SAY_AGGRO');
INSERT INTO creature_text VALUES (26723, 1, 0, 'Now we''ve come to the truth!', 14, 0, 100, 0, 0, 13453, 0, 'keristrasza SAY_SLAY');
INSERT INTO creature_text VALUES (26723, 2, 0, 'Finish it! FINISH IT! Kill me, or I swear by the Dragonqueen you''ll never see daylight again!', 14, 0, 100, 0, 0, 13452, 0, 'keristrasza SAY_ENRAGE');
INSERT INTO creature_text VALUES (26723, 3, 0, 'Dragonqueen... Life-Binder... preserve... me.', 14, 0, 100, 0, 0, 13454, 0, 'keristrasza SAY_DEATH');
INSERT INTO creature_text VALUES (26723, 4, 0, 'Stay. Enjoy your final moments.', 14, 0, 100, 0, 0, 13451, 0, 'keristrasza SAY_CRYSTAL_NOVA');
INSERT INTO creature_text VALUES (26723, 5, 0, '%s goes into a frenzy!', 41, 0, 100, 0, 0, 0, 0, 'Keristrasza');
UPDATE creature_template SET dmg_multiplier=10, lootid=26723, pickpocketloot=0, skinloot=0, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='boss_keristrasza' WHERE entry=26723;
UPDATE creature_template SET dmg_multiplier=20, lootid=30540, pickpocketloot=0, skinloot=0, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='' WHERE entry=30540;

-- Breath Caster (27048)
UPDATE creature SET spawndist=0, MovementType=0, spawntimesecs=86400 WHERE id=27048;
UPDATE creature_template SET faction=35, InhabitType=4, flags_extra=130, AIName='SmartAI', ScriptName='' WHERE entry=27048;
DELETE FROM smart_scripts WHERE entryorguid=27048 AND source_type=0;
INSERT INTO smart_scripts VALUES (27048, 0, 0, 0, 60, 0, 100, 1, 0, 0, 0, 0, 11, 47842, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Breath Caster - On Update - Cast Frost Breath');

-- GO Telestra's Containment Sphere (188526)
-- GO Anomalus's Containment Sphere (188527)
-- GO Ormorok's Containment Sphere (188528)
UPDATE gameobject_template SET flags=48, data3=86400000, AIName='SmartGameObjectAI', ScriptName='' WHERE entry IN(188526, 188527, 188528);
DELETE FROM smart_scripts WHERE entryorguid IN(188526, 188527, 188528) AND source_type=1;
INSERT INTO smart_scripts VALUES(188526, 1, 0, 1, 64, 0, 100, 0, 0, 0, 0, 0, 34, 188526, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sphere - On Gossip Hello - Set Instance Data');
INSERT INTO smart_scripts VALUES(188526, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 27048, 40, 0, 0, 0, 0, 0, 'Sphere - On Gossip Hello - Despawn Target');
INSERT INTO smart_scripts VALUES(188526, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 26723, 0, 0, 0, 0, 0, 19, 26723, 100, 0, 0, 0, 0, 0, 'Sphere - On Gossip Hello - Set Data');
INSERT INTO smart_scripts VALUES(188527, 1, 0, 1, 64, 0, 100, 0, 0, 0, 0, 0, 34, 188527, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sphere - On Gossip Hello - Set Instance Data');
INSERT INTO smart_scripts VALUES(188527, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 27048, 40, 0, 0, 0, 0, 0, 'Sphere - On Gossip Hello - Despawn Target');
INSERT INTO smart_scripts VALUES(188527, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 26723, 0, 0, 0, 0, 0, 19, 26723, 100, 0, 0, 0, 0, 0, 'Sphere - On Gossip Hello - Set Data');
INSERT INTO smart_scripts VALUES(188528, 1, 0, 1, 64, 0, 100, 0, 0, 0, 0, 0, 34, 188528, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sphere - On Gossip Hello - Set Instance Data');
INSERT INTO smart_scripts VALUES(188528, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 27048, 40, 0, 0, 0, 0, 0, 'Sphere - On Gossip Hello - Despawn Target');
INSERT INTO smart_scripts VALUES(188528, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 26723, 0, 0, 0, 0, 0, 19, 26723, 100, 0, 0, 0, 0, 0, 'Sphere - On Gossip Hello - Set Data');

-- SPELL Intense Cold (48095)
DELETE FROM spell_script_names WHERE ScriptName='spell_intense_cold' AND spell_id=48095;

-- Commander Stoutbeard (26796, 30398)
UPDATE creature SET spawntimesecs=86400 WHERE id=26796;
DELETE FROM creature_text WHERE entry=26796;
INSERT INTO creature_text VALUES (26796, 0, 0, 'What? Where in the-- don''t just stand around lads; kill somebody!', 14, 0, 100, 0, 0, 13193, 0, 'Commander Stoutbeard SAY_AGGRO');
INSERT INTO creature_text VALUES (26796, 1, 0, 'Is that all you''ve...', 14, 0, 100, 0, 0, 13194, 0, 'Commander Stoutbeard SAY_DEATH');
INSERT INTO creature_text VALUES (26796, 2, 0, 'Now we''re gettin'' someplace!', 14, 0, 100, 0, 0, 13195, 0, 'Commander Stoutbeard SAY_KILL');
UPDATE creature_template SET dmg_multiplier=10, lootid=26796, pickpocketloot=0, skinloot=0, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='boss_commander_stoutbeard' WHERE entry=26796;
UPDATE creature_template SET dmg_multiplier=20, lootid=30398, pickpocketloot=0, skinloot=0, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='' WHERE entry=30398;
DELETE FROM smart_scripts WHERE entryorguid=26796 AND source_type=0;
DELETE FROM creature_formations WHERE leaderGUID=4764;
REPLACE INTO creature_addon VALUES (4764, 0, 0, 0, 4097, 0, 47543);

-- Commander Kolurg (26798, 30397)
DELETE FROM creature_text WHERE entry=26798;
INSERT INTO creature_text VALUES (26798, 0, 0, 'What is this? Mok-thorin ka! Kill them!', 14, 0, 100, 0, 0, 13458, 0, 'Commander Kolurg SAY_AGGRO');
INSERT INTO creature_text VALUES (26798, 1, 0, 'Gaagh...', 14, 0, 100, 0, 0, 13460, 0, 'Commander Kolurg SAY_DEATH');
INSERT INTO creature_text VALUES (26798, 2, 0, 'Our task is not yet done!', 14, 0, 100, 0, 0, 13459, 0, 'Commander Kolurg SAY_KILL');
UPDATE creature_template SET dmg_multiplier=10, lootid=26798, pickpocketloot=0, skinloot=0, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='boss_commander_stoutbeard' WHERE entry=26798;
UPDATE creature_template SET dmg_multiplier=20, lootid=30397, pickpocketloot=0, skinloot=0, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='' WHERE entry=30397;
DELETE FROM smart_scripts WHERE entryorguid=26798 AND source_type=0;
DELETE FROM creature_formations WHERE leaderGUID=4764;

-- Horde Ranger (26801, 30508)
UPDATE creature_template SET lootid=26801, dmg_multiplier=6, pickpocketloot=0, skinloot=0, mechanic_immune_mask=1, AIName='SmartAI', ScriptName='' WHERE entry=26801;
UPDATE creature_template SET lootid=26801, dmg_multiplier=12, pickpocketloot=0, skinloot=0, mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=30508;
DELETE FROM smart_scripts WHERE entryorguid=26801 AND source_type=0;
INSERT INTO smart_scripts VALUES (26801, 0, 0, 0, 0, 0, 100, 2, 0, 1000, 2000, 2000, 11, 15620, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Horde Ranger - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES (26801, 0, 1, 0, 0, 0, 100, 4, 0, 1000, 2000, 2000, 11, 22907, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Horde Ranger - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES (26801, 0, 2, 0, 0, 0, 100, 0, 7000, 10000, 20000, 30000, 11, 48191, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Horde Ranger - In Combat - Cast Rapid Shot');
INSERT INTO smart_scripts VALUES (26801, 0, 3, 0, 0, 0, 100, 2, 3000, 3000, 15000, 15000, 11, 47777, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Horde Ranger - In Combat - Cast Incendiary Shot');
INSERT INTO smart_scripts VALUES (26801, 0, 4, 0, 0, 0, 100, 4, 3000, 3000, 15000, 15000, 11, 56933, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Horde Ranger - In Combat - Cast Incendiary Shot');
INSERT INTO smart_scripts VALUES (26801, 0, 5, 0, 4, 0, 100, 0, 0, 0, 0, 0, 28, 47543, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Horde Ranger - On Aggro - Remove Aura Frozen Prison');

-- Horde Berserker (26799, 30495)
UPDATE creature_template SET lootid=26799, dmg_multiplier=6, pickpocketloot=0, skinloot=0, mechanic_immune_mask=1, AIName='SmartAI', ScriptName='' WHERE entry=26799;
UPDATE creature_template SET lootid=26799, dmg_multiplier=12, pickpocketloot=0, skinloot=0, mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=30495;
DELETE FROM smart_scripts WHERE entryorguid=26799 AND source_type=0;
INSERT INTO smart_scripts VALUES (26799, 0, 0, 0, 0, 0, 100, 0, 0, 5000, 30000, 30000, 11, 21049, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Horde Berserker - In Combat - Cast Bloodlust');
INSERT INTO smart_scripts VALUES (26799, 0, 1, 0, 0, 0, 100, 0, 10000, 10000, 15000, 15000, 11, 47774, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Horde Berserker - In Combat - Cast Frenzy');
INSERT INTO smart_scripts VALUES (26799, 0, 2, 0, 0, 0, 100, 0, 5000, 10000, 15000, 20000, 11, 38682, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Horde Berserker - In Combat - Cast War Stomp');
INSERT INTO smart_scripts VALUES (26799, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 28, 47543, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Horde Berserker - On Aggro - Remove Aura Frozen Prison');

-- Horde Commander (27947)
UPDATE creature_template SET lootid=27947, dmg_multiplier=6, pickpocketloot=0, skinloot=0, mechanic_immune_mask=1, AIName='SmartAI', ScriptName='' WHERE entry=27947;
DELETE FROM smart_scripts WHERE entryorguid=27947 AND source_type=0;
INSERT INTO smart_scripts VALUES (27947, 0, 0, 0, 0, 0, 100, 0, 0, 0, 60000, 60000, 11, 31403, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Horde Commander - In Combat - Cast Battle Shout');
INSERT INTO smart_scripts VALUES (27947, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 60067, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Horde Commander - On Aggro - Cast Charge');
INSERT INTO smart_scripts VALUES (27947, 0, 2, 0, 0, 0, 100, 0, 5000, 10000, 10000, 10000, 11, 38618, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Horde Commander - In Combat - Cast Whirlwind');
INSERT INTO smart_scripts VALUES (27947, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 28, 47543, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Horde Commander - On Aggro - Remove Aura Frozen Prison');

-- Horde Cleric (26803, 30497)
UPDATE creature_template SET lootid=26803, dmg_multiplier=6, pickpocketloot=0, skinloot=0, mechanic_immune_mask=1, AIName='SmartAI', ScriptName='' WHERE entry=26803;
UPDATE creature_template SET lootid=26803, dmg_multiplier=12, pickpocketloot=0, skinloot=0, mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=30497;
DELETE FROM smart_scripts WHERE entryorguid=26803 AND source_type=0;
INSERT INTO smart_scripts VALUES (26803, 0, 0, 0, 16, 0, 100, 2, 17139, 40, 6000, 6000, 11, 17139, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Horde Cleric - Friendly Missing Aura - Cast Power Word: Shield');
INSERT INTO smart_scripts VALUES (26803, 0, 1, 0, 16, 0, 100, 4, 35944, 40, 6000, 6000, 11, 35944, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Horde Cleric - Friendly Missing Aura - Cast Power Word: Shield');
INSERT INTO smart_scripts VALUES (26803, 0, 2, 0, 0, 0, 100, 2, 3000, 3000, 15000, 15000, 11, 47697, 64, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Horde Cleric - In Combat - Cast Shadow Word: Death');
INSERT INTO smart_scripts VALUES (26803, 0, 3, 0, 0, 0, 100, 4, 3000, 3000, 15000, 15000, 11, 56920, 64, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Horde Cleric - In Combat - Cast Shadow Word: Death');
INSERT INTO smart_scripts VALUES (26803, 0, 4, 0, 14, 0, 100, 2, 10000, 40, 3000, 3000, 11, 17843, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Horde Cleric - Friendly Missing Health - Cast Flash Heal');
INSERT INTO smart_scripts VALUES (26803, 0, 5, 0, 14, 0, 100, 4, 20000, 40, 3000, 3000, 11, 56919, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Horde Cleric - Friendly Missing Health - Cast Flash Heal');
INSERT INTO smart_scripts VALUES (26803, 0, 6, 0, 4, 0, 100, 0, 0, 0, 0, 0, 28, 47543, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Horde Cleric - On Aggro - Remove Aura Frozen Prison');

-- Alliance Ranger (26802, 30509)
DELETE FROM pickpocketing_loot_template WHERE entry IN(26802, 30509);
UPDATE creature_template SET lootid=26802, dmg_multiplier=6, pickpocketloot=0, skinloot=0, mechanic_immune_mask=1, AIName='SmartAI', ScriptName='' WHERE entry=26802;
UPDATE creature_template SET lootid=26802, dmg_multiplier=12, pickpocketloot=0, skinloot=0, mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=30509;
DELETE FROM smart_scripts WHERE entryorguid=26802 AND source_type=0;
INSERT INTO smart_scripts VALUES (26802, 0, 0, 0, 0, 0, 100, 2, 0, 1000, 2000, 2000, 11, 15620, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Alliance Ranger - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES (26802, 0, 1, 0, 0, 0, 100, 4, 0, 1000, 2000, 2000, 11, 22907, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Alliance Ranger - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES (26802, 0, 2, 0, 0, 0, 100, 0, 7000, 10000, 20000, 30000, 11, 48191, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Alliance Ranger - In Combat - Cast Rapid Shot');
INSERT INTO smart_scripts VALUES (26802, 0, 3, 0, 0, 0, 100, 2, 3000, 3000, 15000, 15000, 11, 47777, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Alliance Ranger - In Combat - Cast Incendiary Shot');
INSERT INTO smart_scripts VALUES (26802, 0, 4, 0, 0, 0, 100, 4, 3000, 3000, 15000, 15000, 11, 56933, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Alliance Ranger - In Combat - Cast Incendiary Shot');
INSERT INTO smart_scripts VALUES (26802, 0, 5, 0, 4, 0, 100, 0, 0, 0, 0, 0, 28, 47543, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Alliance Ranger - On Aggro - Remove Aura Frozen Prison');

-- Alliance Berserker (26800, 30496)
DELETE FROM pickpocketing_loot_template WHERE entry IN(26800, 30496);
UPDATE creature_template SET lootid=26800, dmg_multiplier=6, pickpocketloot=0, skinloot=0, mechanic_immune_mask=1, AIName='SmartAI', ScriptName='' WHERE entry=26800;
UPDATE creature_template SET lootid=26800, dmg_multiplier=12, pickpocketloot=0, skinloot=0, mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=30496;
DELETE FROM smart_scripts WHERE entryorguid=26800 AND source_type=0;
INSERT INTO smart_scripts VALUES (26800, 0, 0, 0, 0, 0, 100, 0, 0, 5000, 30000, 30000, 11, 21049, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Alliance Berserker - In Combat - Cast Bloodlust');
INSERT INTO smart_scripts VALUES (26800, 0, 1, 0, 0, 0, 100, 0, 10000, 10000, 15000, 15000, 11, 47774, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Alliance Berserker - In Combat - Cast Frenzy');
INSERT INTO smart_scripts VALUES (26800, 0, 2, 0, 0, 0, 100, 0, 5000, 10000, 15000, 20000, 11, 38682, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Alliance Berserker - In Combat - Cast War Stomp');
INSERT INTO smart_scripts VALUES (26800, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 28, 47543, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Alliance Berserker - On Aggro - Remove Aura Frozen Prison');

-- Alliance Commander (27949)
DELETE FROM creature WHERE id=27949;
INSERT INTO creature VALUES (247105, 27949, 576, 1, 1, 0, 1, 424.547, 185.962, -34.9367, 4.72984, 3600, 0, 0, 1, 0, 0, 0, 0, 0);
UPDATE creature_template SET lootid=27949, dmg_multiplier=6, pickpocketloot=0, skinloot=0, mechanic_immune_mask=1, AIName='SmartAI', ScriptName='' WHERE entry=27949;
DELETE FROM smart_scripts WHERE entryorguid=27949 AND source_type=0;
INSERT INTO smart_scripts VALUES (27949, 0, 0, 0, 0, 0, 100, 0, 0, 0, 60000, 60000, 11, 31403, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Alliance Commander - In Combat - Cast Battle Shout');
INSERT INTO smart_scripts VALUES (27949, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 60067, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Alliance Commander - On Aggro - Cast Charge');
INSERT INTO smart_scripts VALUES (27949, 0, 2, 0, 0, 0, 100, 0, 5000, 10000, 10000, 10000, 11, 38618, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Alliance Commander - In Combat - Cast Whirlwind');
INSERT INTO smart_scripts VALUES (27949, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 28, 47543, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Alliance Commander - On Aggro - Remove Aura Frozen Prison');

-- Alliance Cleric (26805, 30498)
UPDATE creature_template SET lootid=26805, dmg_multiplier=6, pickpocketloot=0, skinloot=0, mechanic_immune_mask=1, AIName='SmartAI', ScriptName='' WHERE entry=26805;
UPDATE creature_template SET lootid=26805, dmg_multiplier=12, pickpocketloot=0, skinloot=0, mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=30498;
DELETE FROM smart_scripts WHERE entryorguid=26805 AND source_type=0;
INSERT INTO smart_scripts VALUES (26805, 0, 0, 0, 16, 0, 100, 2, 17139, 40, 6000, 6000, 11, 17139, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Alliance Cleric - Friendly Missing Aura - Cast Power Word: Shield');
INSERT INTO smart_scripts VALUES (26805, 0, 1, 0, 16, 0, 100, 4, 35944, 40, 6000, 6000, 11, 35944, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Alliance Cleric - Friendly Missing Aura - Cast Power Word: Shield');
INSERT INTO smart_scripts VALUES (26805, 0, 2, 0, 0, 0, 100, 2, 3000, 3000, 15000, 15000, 11, 47697, 64, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Alliance Cleric - In Combat - Cast Shadow Word: Death');
INSERT INTO smart_scripts VALUES (26805, 0, 3, 0, 0, 0, 100, 4, 3000, 3000, 15000, 15000, 11, 56920, 64, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Alliance Cleric - In Combat - Cast Shadow Word: Death');
INSERT INTO smart_scripts VALUES (26805, 0, 4, 0, 14, 0, 100, 2, 10000, 40, 3000, 3000, 11, 17843, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Alliance Cleric - Friendly Missing Health - Cast Flash Heal');
INSERT INTO smart_scripts VALUES (26805, 0, 5, 0, 14, 0, 100, 4, 20000, 40, 3000, 3000, 11, 56919, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Alliance Cleric - Friendly Missing Health - Cast Flash Heal');
INSERT INTO smart_scripts VALUES (26805, 0, 6, 0, 4, 0, 100, 0, 0, 0, 0, 0, 28, 47543, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Alliance Cleric - On Aggro - Remove Aura Frozen Prison');




-- -------------------------------------
--             MISC
-- -------------------------------------

-- Mage Hunter Ascendant formations
UPDATE creature SET spawndist=0, movementType=2 WHERE guid=126455;
REPLACE INTO creature_addon VALUES (126455, 1264550, 0, 0, 4097, 0, '');
DELETE FROM waypoint_data WHERE id=1264550;
INSERT INTO waypoint_data VALUES (1264550, 1, 360.473, 152.082, -33.7985, 0, 0, 0, 0, 100, 0),(1264550, 2, 352.539, 154.114, -31.4133, 0, 0, 0, 0, 100, 0),(1264550, 3, 344.515, 157.575, -29.324, 0, 0, 0, 0, 100, 0),(1264550, 4, 338.777, 158.411, -29.3768, 0, 0, 0, 0, 100, 0),(1264550, 5, 331.778, 158.516, -26.3442, 0, 0, 0, 0, 100, 0),(1264550, 6, 323.07, 158.978, -23.5294, 0, 0, 0, 0, 100, 0),(1264550, 7, 317.143, 157.297, -23.5707, 0, 0, 0, 0, 100, 0),(1264550, 8, 306.37, 147.569, -18.8138, 0, 0, 0, 0, 100, 0),(1264550, 9, 303.812, 142.275, -18.4027, 0, 0, 0, 0, 100, 0),(1264550, 10, 302.542, 134.184, -16.042, 0, 0, 0, 0, 100, 0),(1264550, 11, 304.131, 141.576, -18.4027, 0, 0, 0, 0, 100, 0),
(1264550, 12, 306.08, 147.281, -18.7521, 0, 0, 0, 0, 100, 0),(1264550, 13, 317.558, 156.76, -23.5122, 0, 0, 0, 0, 100, 0),(1264550, 14, 323.676, 159.08, -23.7109, 0, 0, 0, 0, 100, 0),(1264550, 15, 338.847, 158.327, -29.3836, 0, 0, 0, 0, 100, 0),(1264550, 16, 344.648, 157.998, -29.3576, 0, 0, 0, 0, 100, 0),(1264550, 17, 363.402, 151.75, -34.6226, 0, 0, 0, 0, 100, 0);
DELETE FROM creature_formations WHERE memberGUID IN(126455, 126474, 126475);
INSERT INTO creature_formations VALUES (126455, 126455, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES (126455, 126474, 3, 90, 2, 0, 0);
INSERT INTO creature_formations VALUES (126455, 126475, 3, 270, 2, 0, 0);

UPDATE creature SET spawndist=0, movementType=2 WHERE guid=126461;
REPLACE INTO creature_addon VALUES (126461, 1264610, 0, 0, 4097, 0, '');
DELETE FROM waypoint_data WHERE id=1264610;
INSERT INTO waypoint_data VALUES (1264610, 1, 501.528, 157.566, -29.3293, 0, 0, 0, 0, 100, 0),(1264610, 2, 508.427, 158.754, -29.1337, 0, 0, 0, 0, 100, 0),(1264610, 3, 523.665, 158.949, -23.5319, 0, 0, 0, 0, 100, 0),(1264610, 4, 529.028, 156.539, -23.4933, 0, 0, 0, 0, 100, 0),(1264610, 5, 539.586, 147.456, -18.8089, 0, 0, 0, 0, 100, 0),(1264610, 6, 542.173, 142.501, -18.4044, 0, 0, 0, 0, 100, 0),(1264610, 7, 543.969, 135.755, -17.1249, 0, 0, 0, 0, 100, 0),(1264610, 8, 542.826, 141.451, -18.3242, 0, 0, 0, 0, 100, 0),(1264610, 9, 540.545, 146.871, -18.6914, 0, 0, 0, 0, 100, 0),
(1264610, 10, 537.099, 151.635, -20.238, 0, 0, 0, 0, 100, 0),(1264610, 11, 528.545, 157.725, -23.5797, 0, 0, 0, 0, 100, 0),(1264610, 12, 522.953, 159.759, -23.8229, 0, 0, 0, 0, 100, 0),(1264610, 13, 507.803, 158.885, -29.3776, 0, 0, 0, 0, 100, 0),(1264610, 14, 499.669, 157.954, -29.9349, 0, 0, 0, 0, 100, 0),(1264610, 15, 482.85, 151.586, -34.6232, 0, 0, 0, 0, 100, 0);
DELETE FROM creature_formations WHERE memberGUID IN(126461, 126478, 126479);
INSERT INTO creature_formations VALUES (126461, 126461, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES (126461, 126478, 3, 90, 2, 0, 0);
INSERT INTO creature_formations VALUES (126461, 126479, 3, 270, 2, 0, 0);

UPDATE creature SET spawndist=0, movementType=2 WHERE guid=126457;
REPLACE INTO creature_addon VALUES (126457, 1264570, 0, 0, 4097, 0, '');
DELETE FROM waypoint_data WHERE id=1264570;
INSERT INTO waypoint_data VALUES (1264570, 1, 631.056, 73.355, -20.5273, 0, 0, 0, 0, 100, 0),(1264570, 2, 633.364, 59.4756, -21.3911, 0, 0, 0, 0, 100, 0),(1264570, 3, 634.812, 55.0149, -21.4361, 0, 0, 0, 0, 100, 0),(1264570, 4, 632.696, 64.153, -21.0734, 0, 0, 0, 0, 100, 0),(1264570, 5, 629.724, 74.2237, -20.4911, 0, 0, 0, 0, 100, 0),(1264570, 6, 624.595, 83.3857, -20.1679, 0, 0, 0, 0, 100, 0),(1264570, 7, 620.574, 90.0707, -19.1733, 0, 0, 0, 0, 100, 0),(1264570, 8, 618.36, 93.5003, -18.2589, 0, 0, 0, 0, 100, 0),(1264570, 9, 621.875, 87.4468, -19.8288, 0, 0, 0, 0, 100, 0);
DELETE FROM creature_formations WHERE memberGUID IN(126457, 126476, 126477);
INSERT INTO creature_formations VALUES (126457, 126457, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES (126457, 126476, 3, 90, 2, 0, 0);
INSERT INTO creature_formations VALUES (126457, 126477, 3, 270, 2, 0, 0);

-- Azure Skyrazor (26736, 30518)
UPDATE creature SET spawndist=0, MovementType=0 WHERE id=26736;
UPDATE creature_template SET unit_flags=33104+2+4, lootid=0, dmg_multiplier=1, pickpocketloot=0, skinloot=0, mechanic_immune_mask=0, flags_extra=2, AIName='SmartAI', ScriptName='' WHERE entry=26736;
UPDATE creature_template SET unit_flags=33104+2+4, lootid=0, dmg_multiplier=1, pickpocketloot=0, skinloot=0, mechanic_immune_mask=0, flags_extra=2, AIName='', ScriptName='' WHERE entry=30518;
DELETE FROM smart_scripts WHERE entryorguid=26736 AND source_type=0;
INSERT INTO smart_scripts VALUES (26736, 0, 0, 0, 60, 0, 100, 0, 0, 0, 4000, 4000, 11, 47959, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Alliance Commander - On Update - Cast Arcane Bolt');
INSERT INTO smart_scripts VALUES (26736, 0, 1, 0, 31, 0, 100, 0, 47959, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Alliance Commander - Spell Hit Target - Set Orientation');

-- SPELL Arcane Bolt (47959)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(47959);
INSERT INTO conditions VALUES(13, 1, 47959, 0, 0, 31, 0, 3, 26761, 0, 0, 0, 0, '', 'Target Crazed Mana-Wyrm');
INSERT INTO conditions VALUES(13, 1, 47959, 0, 0, 1, 0, 29266, 0, 0, 1, 0, 0, '', 'No Aura');

-- Crazed Mana-Wyrm (26761, 30521)
UPDATE creature SET spawndist=0, MovementType=0, unit_flags=0, dynamicflags=0 WHERE id=26761;
UPDATE creature_template SET unit_flags=33104+4, lootid=0, dmg_multiplier=1, pickpocketloot=0, skinloot=0, mechanic_immune_mask=0, flags_extra=2, AIName='SmartAI', ScriptName='' WHERE entry=26761;
UPDATE creature_template SET unit_flags=33104+4, lootid=0, dmg_multiplier=1, pickpocketloot=0, skinloot=0, mechanic_immune_mask=0, flags_extra=2, AIName='', ScriptName='' WHERE entry=30521;
DELETE FROM smart_scripts WHERE entryorguid=26761 AND source_type=0;
INSERT INTO smart_scripts VALUES (26761, 0, 0, 0, 0, 0, 100, 1, 3000, 3000, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Alliance Commander - In Combat - Evade');

-- Nexus 70 - Buying Time Bunny (27837)
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id IN(27837));
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(27837));
DELETE FROM creature WHERE id IN(27837);

-- Crystalline Tender formations
UPDATE creature SET spawndist=0, movementType=2 WHERE guid=126443;
REPLACE INTO creature_addon VALUES (126443, 1264430, 0, 0, 4097, 0, '');
DELETE FROM waypoint_data WHERE id=1264430;
INSERT INTO waypoint_data VALUES (1264430, 1, 455.111, -174.27, -14.0888, 0, 0, 0, 0, 100, 0),(1264430, 2, 447.017, -174.9, -14.0888, 0, 0, 0, 0, 100, 0),(1264430, 3, 441.216, -175.22, -14.0888, 0, 0, 0, 0, 100, 0),(1264430, 4, 431.951, -176.133, -14.0888, 0, 0, 0, 0, 100, 0),(1264430, 5, 440.066, -175.877, -14.0888, 0, 0, 0, 0, 100, 0),(1264430, 6, 448.252, -175.619, -14.0888, 0, 0, 0, 0, 100, 0),(1264430, 7, 456.336, -176.383, -14.0888, 0, 0, 0, 0, 100, 0),(1264430, 8, 464.197, -181.501, -14.0888, 0, 0, 0, 0, 100, 0),(1264430, 9, 467.969, -188.692, -14.0888, 0, 0, 0, 0, 100, 0),(1264430, 10, 462.646, -182.56, -14.0888, 0, 0, 0, 0, 100, 0),(1264430, 11, 457.224, -175.376, -14.0888, 0, 0, 0, 0, 100, 0);
DELETE FROM creature_formations WHERE memberGUID IN(126443, 126603, 126604);
INSERT INTO creature_formations VALUES (126443, 126443, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES (126443, 126603, 4, 90, 2, 0, 0);
INSERT INTO creature_formations VALUES (126443, 126604, 4, 270, 2, 0, 0);

UPDATE creature SET spawndist=0, movementType=2 WHERE guid=126442;
REPLACE INTO creature_addon VALUES (126442, 1264420, 0, 0, 4097, 0, '');
DELETE FROM waypoint_data WHERE id=1264420;
INSERT INTO waypoint_data VALUES (1264420, 1, 390.393, -186.121, -14.0888, 0, 0, 0, 0, 100, 0),(1264420, 2, 397.612, -189.989, -14.0888, 0, 0, 0, 0, 100, 0),(1264420, 3, 404.926, -195.862, -14.0888, 0, 0, 0, 0, 100, 0),(1264420, 4, 409.086, -205.503, -14.0888, 0, 0, 0, 0, 100, 0),(1264420, 5, 404.608, -194.78, -14.0888, 0, 0, 0, 0, 100, 0),(1264420, 6, 397.251, -191.344, -14.0888, 0, 0, 0, 0, 100, 0),(1264420, 7, 383.796, -187.476, -14.0888, 0, 0, 0, 0, 100, 0),(1264420, 8, 376.03, -184.876, -14.0888, 0, 0, 0, 0, 100, 0),(1264420, 9, 368.012, -183.206, -14.0888, 0, 0, 0, 0, 100, 0);
DELETE FROM creature_formations WHERE memberGUID IN(126442, 126602);
INSERT INTO creature_formations VALUES (126442, 126442, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES (126442, 126602, 4, 90, 2, 0, 0);

UPDATE creature SET spawndist=0, movementType=2 WHERE guid=126440;
REPLACE INTO creature_addon VALUES (126440, 1264400, 0, 0, 4097, 0, '');
DELETE FROM waypoint_data WHERE id=1264400;
INSERT INTO waypoint_data VALUES (1264400, 1, 355.944, -181.159, -14.5042, 0, 0, 0, 0, 100, 0),(1264400, 2, 346.697, -182.234, -14.5042, 0, 0, 0, 0, 100, 0),(1264400, 3, 336.277, -177.092, -14.2774, 0, 0, 0, 0, 100, 0),(1264400, 4, 327.227, -169.693, -14.4796, 0, 0, 0, 0, 100, 0),(1264400, 5, 317.255, -161.54, -14.6058, 0, 0, 0, 0, 100, 0),(1264400, 6, 325.664, -167.829, -14.55, 0, 0, 0, 0, 100, 0),(1264400, 7, 335.699, -175.903, -14.2976, 0, 0, 0, 0, 100, 0),(1264400, 8, 346.418, -182.916, -14.5043, 0, 0, 0, 0, 100, 0),(1264400, 9, 356.901, -183.515, -14.5043, 0, 0, 0, 0, 100, 0),(1264400, 10, 363.851, -184.353, -14.0888, 0, 0, 0, 0, 100, 0);
DELETE FROM creature_formations WHERE memberGUID IN(126440, 126600);
INSERT INTO creature_formations VALUES (126440, 126440, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES (126440, 126600, 4, 90, 2, 0, 0);

UPDATE creature SET spawndist=0, movementType=2 WHERE guid=126447;
REPLACE INTO creature_addon VALUES (126447, 1264470, 0, 0, 4097, 0, '');
DELETE FROM waypoint_data WHERE id=1264470;
INSERT INTO waypoint_data VALUES (1264470, 1, 431.387, -271.386, -14.0888, 0, 0, 0, 0, 100, 0),(1264470, 2, 423.667, -268.651, -14.0888, 0, 0, 0, 0, 100, 0),(1264470, 3, 415.947, -265.916, -14.5316, 0, 0, 0, 0, 100, 0),(1264470, 4, 412.088, -261.479, -14.5316, 0, 0, 0, 0, 100, 0),(1264470, 5, 409.971, -248.845, -14.0888, 0, 0, 0, 0, 100, 0),(1264470, 6, 409.956, -239.465, -14.0888, 0, 0, 0, 0, 100, 0),(1264470, 7, 411.304, -226.656, -14.5316, 0, 0, 0, 0, 100, 0),(1264470, 8, 420.747, -222.063, -14.0888, 0, 0, 0, 0, 100, 0),(1264470, 9, 426.444, -220.923, -14.0888, 0, 0, 0, 0, 100, 0),(1264470, 10, 436.806, -219.228, -14.0888, 0, 0, 0, 0, 100, 0),
(1264470, 11, 446.074, -217.787, -14.0888, 0, 0, 0, 0, 100, 0),(1264470, 12, 436.875, -219.217, -14.0888, 0, 0, 0, 0, 100, 0),(1264470, 13, 425.324, -221.014, -14.0888, 0, 0, 0, 0, 100, 0),(1264470, 14, 412.714, -223.64, -14.5316, 0, 0, 0, 0, 100, 0),(1264470, 15, 410.04, -231.381, -14.0888, 0, 0, 0, 0, 100, 0),(1264470, 16, 410.221, -245.38, -14.0888, 0, 0, 0, 0, 100, 0),(1264470, 17, 411.826, -256.888, -14.0888, 0, 0, 0, 0, 100, 0),(1264470, 18, 414.464, -270.637, -14.5316, 0, 0, 0, 0, 100, 0),(1264470, 19, 422.523, -272.1, -14.0888, 0, 0, 0, 0, 100, 0),(1264470, 20, 436.298, -274.6, -14.0888, 0, 0, 0, 0, 100, 0),(1264470, 21, 444.875, -278.22, -14.0888, 0, 0, 0, 0, 100, 0);
DELETE FROM creature_formations WHERE memberGUID IN(126447, 126609);
INSERT INTO creature_formations VALUES (126447, 126447, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES (126447, 126609, 4, 90, 2, 0, 0);

UPDATE creature SET spawndist=0, movementType=2 WHERE guid=126446;
REPLACE INTO creature_addon VALUES (126446, 1264460, 0, 0, 4097, 0, '');
DELETE FROM waypoint_data WHERE id=1264460;
INSERT INTO waypoint_data VALUES (1264460, 1, 389.243, -319.356, -14.0888, 0, 0, 0, 0, 100, 0),(1264460, 2, 380.066, -320.923, -14.0888, 0, 0, 0, 0, 100, 0),(1264460, 3, 368.611, -322.879, -14.0888, 0, 0, 0, 0, 100, 0),(1264460, 4, 358.042, -322.799, -14.0888, 0, 0, 0, 0, 100, 0),(1264460, 5, 348.244, -316.422, -14.4535, 0, 0, 0, 0, 100, 0),(1264460, 6, 343.627, -308.257, -14.0888, 0, 0, 0, 0, 100, 0),(1264460, 7, 333.674, -293.863, -14.5306, 0, 0, 0, 0, 100, 0),(1264460, 8, 323.76, -279.527, -14.0888, 0, 0, 0, 0, 100, 0),(1264460, 9, 331.906, -290.913, -14.5305, 0, 0, 0, 0, 100, 0),
(1264460, 10, 342.125, -305.206, -14.0888, 0, 0, 0, 0, 100, 0),(1264460, 11, 352.303, -319.441, -14.4535, 0, 0, 0, 0, 100, 0),(1264460, 12, 367.312, -321.273, -14.0888, 0, 0, 0, 0, 100, 0),(1264460, 13, 381.281, -320.336, -14.0888, 0, 0, 0, 0, 100, 0),(1264460, 14, 394.046, -319.273, -14.0888, 0, 0, 0, 0, 100, 0),(1264460, 15, 406.482, -315.92, -14.2638, 0, 0, 0, 0, 100, 0),(1264460, 16, 413.05, -311.146, -14.5316, 0, 0, 0, 0, 100, 0),(1264460, 17, 403.319, -315.09, -14.0888, 0, 0, 0, 0, 100, 0);
DELETE FROM creature_formations WHERE memberGUID IN(126446, 126607, 126608);
INSERT INTO creature_formations VALUES (126446, 126446, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES (126446, 126607, 4, 90, 2, 0, 0);
INSERT INTO creature_formations VALUES (126446, 126608, 4, 270, 2, 0, 0);

UPDATE creature SET spawndist=0, movementType=2 WHERE guid=126445;
REPLACE INTO creature_addon VALUES (126445, 1264450, 0, 0, 4097, 0, '');
DELETE FROM waypoint_data WHERE id=1264450;
INSERT INTO waypoint_data VALUES (1264450, 1, 258.853, -240.519, -9.10091, 0, 0, 0, 0, 100, 0),(1264450, 2, 266.729, -242.493, -8.32708, 0, 0, 0, 0, 100, 0),(1264450, 3, 275.521, -239.43, -8.25407, 0, 0, 0, 0, 100, 0),(1264450, 4, 281.801, -232.557, -8.25407, 0, 0, 0, 0, 100, 0),(1264450, 5, 287.606, -233.488, -8.484, 0, 0, 0, 0, 100, 0),(1264450, 6, 296.215, -237.034, -11.5626, 0, 0, 0, 0, 100, 0),(1264450, 7, 303.604, -240.565, -14.0888, 0, 0, 0, 0, 100, 0),(1264450, 8, 317.284, -247.168, -14.0888, 0, 0, 0, 0, 100, 0),(1264450, 9, 321.445, -249.176, -14.0888, 0, 0, 0, 0, 100, 0),(1264450, 10, 314.126, -245.501, -14.0888, 0, 0, 0, 0, 100, 0),(1264450, 11, 306.529, -242.441, -14.0888, 0, 0, 0, 0, 100, 0),
(1264450, 12, 302.244, -240.714, -13.7846, 0, 0, 0, 0, 100, 0),(1264450, 13, 292.602, -236.383, -10.4792, 0, 0, 0, 0, 100, 0),(1264450, 14, 288.324, -234.462, -8.82875, 0, 0, 0, 0, 100, 0),(1264450, 15, 282.729, -232.895, -8.25401, 0, 0, 0, 0, 100, 0),(1264450, 16, 277.275, -238.912, -8.25401, 0, 0, 0, 0, 100, 0),(1264450, 17, 268.603, -244.83, -8.25406, 0, 0, 0, 0, 100, 0),(1264450, 18, 258.127, -244.109, -8.25406, 0, 0, 0, 0, 100, 0),(1264450, 19, 253.805, -238.514, -8.49638, 0, 0, 0, 0, 100, 0),(1264450, 20, 247.398, -227.432, -8.49771, 0, 0, 0, 0, 100, 0);
DELETE FROM creature_formations WHERE memberGUID IN(126444, 126445, 126605, 126606);
INSERT INTO creature_formations VALUES (126445, 126445, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES (126445, 126444, 4, 0, 2, 0, 0);
INSERT INTO creature_formations VALUES (126445, 126606, 5.66, 45, 2, 0, 0);
INSERT INTO creature_formations VALUES (126445, 126605, 4, 90, 2, 0, 0);

DELETE FROM linked_respawn WHERE guid IN(126441, 126601);
DELETE FROM creature_addon WHERE guid IN(126441, 126601);
DELETE FROM creature WHERE guid IN(126441, 126601);

-- -------------------------------------
--             ACHIEVEMENTS
-- -------------------------------------

-- The Nexus (478)
DELETE FROM disables WHERE sourceType=4 AND entry IN(195, 196, 197, 198);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(195, 196, 197, 198);
INSERT INTO achievement_criteria_data VALUES(195, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(196, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(197, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(198, 12, 0, 0, "");

-- Heroic: The Nexus (490)
DELETE FROM disables WHERE sourceType=4 AND entry IN(5245, 5246, 5247, 5248);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(5245, 5246, 5247, 5248);
INSERT INTO achievement_criteria_data VALUES(5245, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(5246, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(5247, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(5248, 12, 1, 0, "");

-- Chaos Theory (2037)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7316);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7316);
INSERT INTO achievement_criteria_data VALUES(7316, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7316, 11, 0, 0, "achievement_chaos_theory");

-- Split Personality (2150)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7577);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7577);
INSERT INTO achievement_criteria_data VALUES(7577, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7577, 11, 0, 0, "achievement_split_personality");

-- Intense Cold (2036)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7315);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7315);
INSERT INTO achievement_criteria_data VALUES(7315, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7315, 11, 0, 0, "achievement_intense_cold");


-- -------------------------------------------
--           SPELL DIFFICULTY
-- -------------------------------------------

-- Arcane Explosion (34933, 56825)
DELETE FROM spelldifficulty_dbc WHERE id IN(34933, 56825) OR spellid0 IN(34933, 56825) OR spellid1 IN(34933, 56825) OR spellid2 IN(34933, 56825) OR spellid3 IN(34933, 56825);
INSERT INTO spelldifficulty_dbc VALUES (34933, 34933, 56825, 0, 0);

-- Ice Nova (47772, 56935)
DELETE FROM spelldifficulty_dbc WHERE id IN(47772, 56935) OR spellid0 IN(47772, 56935) OR spellid1 IN(47772, 56935) OR spellid2 IN(47772, 56935) OR spellid3 IN(47772, 56935);
INSERT INTO spelldifficulty_dbc VALUES (47772, 47772, 56935, 0, 0);

-- Firebomb (47773, 56934)
DELETE FROM spelldifficulty_dbc WHERE id IN(47773, 56934) OR spellid0 IN(47773, 56934) OR spellid1 IN(47773, 56934) OR spellid2 IN(47773, 56934) OR spellid3 IN(47773, 56934);
INSERT INTO spelldifficulty_dbc VALUES (47773, 47773, 56934, 0, 0);

-- Spark (47751, 57062)
DELETE FROM spelldifficulty_dbc WHERE id IN(47751, 57062) OR spellid0 IN(47751, 57062) OR spellid1 IN(47751, 57062) OR spellid2 IN(47751, 57062) OR spellid3 IN(47751, 57062);
INSERT INTO spelldifficulty_dbc VALUES (47751, 47751, 57062, 0, 0);

-- Aura of Regeneration (52067, 57056)
DELETE FROM spelldifficulty_dbc WHERE id IN(52067, 57056) OR spellid0 IN(52067, 57056) OR spellid1 IN(52067, 57056) OR spellid2 IN(52067, 57056) OR spellid3 IN(52067, 57056);
INSERT INTO spelldifficulty_dbc VALUES (52067, 52067, 57056, 0, 0);

-- Crystal Spikes (47958, 57082)
DELETE FROM spelldifficulty_dbc WHERE id IN(47958, 57082) OR spellid0 IN(47958, 57082) OR spellid1 IN(47958, 57082) OR spellid2 IN(47958, 57082) OR spellid3 IN(47958, 57082);
INSERT INTO spelldifficulty_dbc VALUES (47958, 47958, 57082, 0, 0);

-- Crystal Spike Damage (47944, 57067)
DELETE FROM spelldifficulty_dbc WHERE id IN(47944, 57067) OR spellid0 IN(47944, 57067) OR spellid1 IN(47944, 57067) OR spellid2 IN(47944, 57067) OR spellid3 IN(47944, 57067);
INSERT INTO spelldifficulty_dbc VALUES (47944, 47944, 57067, 0, 0);

-- Trample (48016, 57066)
DELETE FROM spelldifficulty_dbc WHERE id IN(48016, 57066) OR spellid0 IN(48016, 57066) OR spellid1 IN(48016, 57066) OR spellid2 IN(48016, 57066) OR spellid3 IN(48016, 57066);
INSERT INTO spelldifficulty_dbc VALUES (48016, 48016, 57066, 0, 0);

-- Crystalfire Breath (48096, 57091)
DELETE FROM spelldifficulty_dbc WHERE id IN(48096, 57091) OR spellid0 IN(48096, 57091) OR spellid1 IN(48096, 57091) OR spellid2 IN(48096, 57091) OR spellid3 IN(48096, 57091);
INSERT INTO spelldifficulty_dbc VALUES (48096, 48096, 57091, 0, 0);
