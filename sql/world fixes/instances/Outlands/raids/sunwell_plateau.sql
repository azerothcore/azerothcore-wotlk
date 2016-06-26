
UPDATE creature SET spawntimesecs=7*86400 WHERE map=580 AND spawntimesecs>0;
DELETE FROM disables WHERE sourceType=2 AND entry=580;

-- -------------------------------------------
--                TRASH
-- -------------------------------------------

-- Sunblade Protector (25507)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=25507;
DELETE FROM smart_scripts WHERE entryorguid=25507 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(SELECT -guid FROM creature WHERE id=25507 AND MovementType=0 AND guid<>54999) AND source_type=0;
INSERT INTO smart_scripts VALUES (25507, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 11, 18950, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - In Combat - Cast Invisibility and Stealth Detection');
INSERT INTO smart_scripts VALUES (25507, 0, 1, 0, 0, 0, 100, 0, 5800, 6800, 10400, 11400, 11, 46480, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - In Combat - Cast Fel Lightning');
INSERT INTO smart_scripts SELECT -guid, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 11, 18950, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - In Combat - Cast Invisibility and Stealth Detection' FROM creature WHERE id=25507 AND MovementType=0 AND guid<>54999;
INSERT INTO smart_scripts SELECT -guid, 0, 1, 0, 0, 0, 100, 0, 5800, 6800, 10400, 11400, 11, 46480, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - In Combat - Cast Fel Lightning' FROM creature WHERE id=25507 AND MovementType=0 AND guid<>54999;
INSERT INTO smart_scripts SELECT -guid, 0, 2, 3, 25, 0, 100, 257, 0, 0, 0, 0, 11, 59123, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - On Reset - Cast Banish' FROM creature WHERE id=25507 AND MovementType=0 AND guid<>54999;
INSERT INTO smart_scripts SELECT -guid, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 18, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - On Reset - Add Unit Flag' FROM creature WHERE id=25507 AND MovementType=0 AND guid<>54999;
INSERT INTO smart_scripts SELECT -guid, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - On Reset - Set React State' FROM creature WHERE id=25507 AND MovementType=0 AND guid<>54999;
INSERT INTO smart_scripts SELECT -guid, 0, 5, 6, 8, 0, 100, 0, 46476, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - On Spell Hit - Set React State' FROM creature WHERE id=25507 AND MovementType=0 AND guid<>54999;
INSERT INTO smart_scripts SELECT -guid, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - On Spell Hit - Remove All Auras' FROM creature WHERE id=25507 AND MovementType=0 AND guid<>54999;
INSERT INTO smart_scripts SELECT -guid, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - On Spell Hit - Set In Combat With Zone' FROM creature WHERE id=25507 AND MovementType=0 AND guid<>54999;
INSERT INTO smart_scripts SELECT -guid, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 19, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - On Spell Hit - Remove Unit Flag' FROM creature WHERE id=25507 AND MovementType=0 AND guid<>54999;

-- Sunblade Cabalist (25363)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=25363;
DELETE FROM smart_scripts WHERE entryorguid=25363 AND source_type=0;
INSERT INTO smart_scripts VALUES (25363, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 2500, 3000, 11, 47248, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Cabalist - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (25363, 0, 1, 0, 0, 0, 100, 0, 2000, 12000, 30000, 48000, 11, 46544, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Cabalist - In Combat - Cast Summon Imp');
INSERT INTO smart_scripts VALUES (25363, 0, 2, 0, 0, 0, 100, 0, 6000, 12000, 20000, 20000, 11, 46543, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Sunblade Cabalist - In Combat - Cast Ignite Mana');
INSERT INTO smart_scripts VALUES (25363, 0, 3, 0, 1, 0, 100, 0, 0, 0, 15000, 45000, 11, 46319, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Cabalist - Out Of Combat - Cast Felblood Channel');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=25363;
INSERT INTO conditions VALUES(22, 4, 25363, 0, 0, 29, 1, 25953, 20, 0, 0, 0, 0, '', 'Reqires Fel Crystal Spell Target in range');

-- SPELL Felblood Channel (46319)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=46319;
INSERT INTO conditions VALUES(13, 1, 46319, 0, 0, 31, 0, 3, 25953, 0, 0, 0, 0, '', 'Fel Crystal Spell Target');

-- Fire Fiend (26101)
UPDATE creature_template SET dmg_multiplier=10, AIName='SmartAI', ScriptName='' WHERE entry=26101;
DELETE FROM smart_scripts WHERE entryorguid=26101 AND source_type=0;
INSERT INTO smart_scripts VALUES (26101, 0, 0, 0, 0, 0, 100, 0, 1000, 5000, 8500, 13000, 11, 46551, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fire Fiend - In Combat - Cast Fire Nova');

-- Sunblade Dawn Priest (25371)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=25371;
DELETE FROM smart_scripts WHERE entryorguid=25371 AND source_type=0;
INSERT INTO smart_scripts VALUES (25371, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 46565, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Dawn Priest - On Aggro - Cast Holyform');
INSERT INTO smart_scripts VALUES (25371, 0, 1, 0, 14, 0, 100, 0, 40000, 40, 10000, 15000, 11, 46563, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Dawn Priest - Friendly Missing Health - Cast Renew');
INSERT INTO smart_scripts VALUES (25371, 0, 2, 0, 0, 0, 100, 0, 4000, 9000, 10000, 10000, 11, 46564, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Dawn Priest - In Combat - Cast Holy Nova');
INSERT INTO smart_scripts VALUES (25371, 0, 3, 0, 1, 0, 100, 0, 0, 0, 15000, 45000, 11, 46319, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Dawn Priest - Out Of Combat - Cast Felblood Channel');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=25371;
INSERT INTO conditions VALUES(22, 4, 25371, 0, 0, 29, 1, 25953, 20, 0, 0, 0, 0, '', 'Reqires Fel Crystal Spell Target in range');

-- Sunblade Dragonhawk (25867)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=25867;
DELETE FROM smart_scripts WHERE entryorguid=25867 AND source_type=0;
INSERT INTO smart_scripts VALUES (25867, 0, 0, 0, 0, 0, 100, 0, 1000, 5000, 8500, 13000, 11, 47251, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Dragonhawk - In Combat - Cast Flame Breath');

-- Sunblade Dusk Priest (25370)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=25370;
DELETE FROM smart_scripts WHERE entryorguid=25370 AND source_type=0;
INSERT INTO smart_scripts VALUES (25370, 0, 0, 0, 0, 0, 100, 0, 6000, 7000, 15500, 19000, 11, 46561, 0, 0, 0, 0, 0, 5, 25, 0, 0, 0, 0, 0, 0, 'Sunblade Dusk Priest - In Combat - Cast Fear');
INSERT INTO smart_scripts VALUES (25370, 0, 1, 0, 0, 0, 100, 0, 2000, 5000, 10000, 10000, 11, 46560, 0, 0, 0, 0, 0, 5, 50, 0, 0, 0, 0, 0, 0, 'Sunblade Dusk Priest - In Combat - Cast Shadow Word: Pain');
INSERT INTO smart_scripts VALUES (25370, 0, 2, 0, 0, 0, 100, 0, 2000, 5000, 7000, 8000, 11, 46562, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Dusk Priest - In Combat - Cast Mind Flay');
INSERT INTO smart_scripts VALUES (25370, 0, 3, 0, 1, 0, 100, 0, 0, 0, 15000, 45000, 11, 46319, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Dusk Priest - Out Of Combat - Cast Felblood Channel');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=25370;
INSERT INTO conditions VALUES(22, 4, 25370, 0, 0, 29, 1, 25953, 20, 0, 0, 0, 0, '', 'Reqires Fel Crystal Spell Target in range');

-- Sunblade Scout (25372)
DELETE FROM creature_text WHERE entry=25372;
INSERT INTO creature_text VALUES (25372, 0, 0, "Wretched, meddling insects! Release me, and perhaps I will grant you a merciful death!", 14, 0, 100, 0, 0, 0, 0, 'Sunblade Scout');
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=25372;
DELETE FROM smart_scripts WHERE entryorguid=25372 AND source_type=0;
INSERT INTO smart_scripts VALUES (25372, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 46475, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Scout - On Aggro - Cast Activate Sunblade Protector');
INSERT INTO smart_scripts VALUES (25372, 0, 1, 0, 31, 0, 100, 0, 46475, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Scout - On Spell Hit Target - Talk');
INSERT INTO smart_scripts VALUES (25372, 0, 2, 0, 0, 0, 100, 0, 2000, 5000, 7000, 8000, 11, 46558, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Scout - In Combat - Cast Sinister Strike');
INSERT INTO smart_scripts VALUES (25372, 0, 3, 0, 1, 0, 100, 0, 0, 0, 15000, 45000, 11, 46319, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Scout - Out Of Combat - Cast Felblood Channel');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=25372;
INSERT INTO conditions VALUES(22, 4, 25372, 0, 0, 29, 1, 25953, 20, 0, 0, 0, 0, '', 'Reqires Fel Crystal Spell Target in range');

-- SPELL Activate Sunblade Protector (46475)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=46475;
INSERT INTO conditions VALUES(13, 1, 46475, 0, 0, 31, 0, 3, 25507, 0, 0, 0, 0, '', 'Target Sunblade Protector');
INSERT INTO conditions VALUES(13, 1, 46475, 0, 0, 1, 0, 46475, 0, 0, 1, 0, 0, '', 'Requires No Aura');

-- Sunblade Slayer (25368)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=25368;
DELETE FROM smart_scripts WHERE entryorguid=25368 AND source_type=0;
INSERT INTO smart_scripts VALUES (25368, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2000, 2000, 11, 47001, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Slayer - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES (25368, 0, 1, 0, 0, 0, 100, 0, 2000, 5000, 10000, 15000, 11, 46681, 0, 0, 0, 0, 0, 5, 15, 0, 0, 0, 0, 0, 0, 'Sunblade Slayer - In Combat - Cast Scatter Shot');
INSERT INTO smart_scripts VALUES (25368, 0, 2, 0, 0, 0, 100, 0, 6000, 9000, 17000, 18000, 11, 46557, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Sunblade Slayer - In Combat - Cast Slaying Shot');
INSERT INTO smart_scripts VALUES (25368, 0, 3, 0, 1, 0, 100, 0, 0, 0, 15000, 45000, 11, 46319, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Slayer - Out Of Combat - Cast Felblood Channel');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=25368;
INSERT INTO conditions VALUES(22, 4, 25368, 0, 0, 29, 1, 25953, 20, 0, 0, 0, 0, '', 'Reqires Fel Crystal Spell Target in range');

-- Sunblade Vindicator (25369)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=25369;
DELETE FROM smart_scripts WHERE entryorguid=25369 AND source_type=0;
INSERT INTO smart_scripts VALUES (25369, 0, 0, 0, 0, 0, 100, 0, 5000, 8000, 10000, 12000, 11, 58460, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Vindicator - In Combat - Cast Brutal Strike');
INSERT INTO smart_scripts VALUES (25369, 0, 1, 0, 0, 0, 100, 0, 2000, 5000, 10000, 15000, 11, 46559, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Vindicator - In Combat - Cast 46559');
INSERT INTO smart_scripts VALUES (25369, 0, 2, 0, 1, 0, 100, 0, 0, 0, 15000, 45000, 11, 46319, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Vindicator - Out Of Combat - Cast Felblood Channel');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=25369;
INSERT INTO conditions VALUES(22, 3, 25369, 0, 0, 29, 1, 25953, 20, 0, 0, 0, 0, '', 'Reqires Fel Crystal Spell Target in range');

-- Sunblade Arch Mage (25367)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=25367;
DELETE FROM smart_scripts WHERE entryorguid=25367 AND source_type=0;
INSERT INTO smart_scripts VALUES (25367, 0, 0, 0, 0, 0, 100, 0, 1000, 4000, 15000, 15000, 11, 46555, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Arch Mage - In Combat - Cast Frost Nova');
INSERT INTO smart_scripts VALUES (25367, 0, 1, 0, 0, 0, 100, 0, 4000, 7000, 10000, 10000, 11, 46553, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Arch Mage - In Combat - Cast Arcane Explosion');
INSERT INTO smart_scripts VALUES (25367, 0, 2, 0, 1, 0, 100, 0, 0, 0, 15000, 45000, 11, 46319, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Arch Mage - Out Of Combat - Cast Felblood Channel');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=25367;
INSERT INTO conditions VALUES(22, 3, 25367, 0, 0, 29, 1, 25953, 20, 0, 0, 0, 0, '', 'Reqires Fel Crystal Spell Target in range');

-- Shadowsword Vanquisher (25486)
DELETE FROM creature_text WHERE entry=25486;
INSERT INTO creature_text VALUES (25486, 0, 0, "Intruders! Do not let them into the Sanctum!", 14, 0, 100, 0, 0, 0, 0, 'Shadowsword Vanquisher');
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=25486;
DELETE FROM smart_scripts WHERE entryorguid=25486 AND source_type=0;
INSERT INTO smart_scripts VALUES (25486, 0, 1, 0, 0, 0, 100, 0, 2000, 5000, 7000, 18000, 11, 46468, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadowsword Vanquisher - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (25486, 0, 2, 0, 0, 0, 100, 0, 8000, 10000, 17000, 28000, 11, 46469, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadowsword Vanquisher - In Combat - Cast Melt Armor');

-- Shadowsword Manafiend (25483)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=25483;
REPLACE INTO creature_template_addon VALUES (25483, 0, 0, 0, 4097, 0, '46744');
DELETE FROM smart_scripts WHERE entryorguid=25483 AND source_type=0;
INSERT INTO smart_scripts VALUES (25483, 0, 0, 0, 0, 0, 100, 0, 2000, 5000, 14000, 18000, 11, 46453, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowsword Manafiend - In Combat - Cast Drain Mana');
INSERT INTO smart_scripts VALUES (25483, 0, 1, 0, 0, 0, 100, 0, 6000, 10000, 17000, 28000, 11, 46457, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowsword Manafiend - In Combat - Cast Arcane Explosion');

-- Shadowsword Lifeshaper (25506)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=25506;
DELETE FROM smart_scripts WHERE entryorguid=25506 AND source_type=0;
INSERT INTO smart_scripts VALUES (25506, 0, 0, 0, 0, 0, 100, 0, 2000, 5000, 14000, 18000, 11, 46466, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadowsword Lifeshaper - In Combat - Cast Drain Life');

-- Shadowsword Soulbinder (25373)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=25373;
DELETE FROM smart_scripts WHERE entryorguid=25373 AND source_type=0;
INSERT INTO smart_scripts VALUES (25373, 0, 0, 0, 0, 0, 100, 0, 2000, 5000, 14000, 18000, 11, 46442, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadowsword Soulbinder - In Combat - Cast Flash of Darkness');
INSERT INTO smart_scripts VALUES (25373, 0, 1, 0, 0, 0, 100, 0, 6000, 10000, 17000, 28000, 11, 46434, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Shadowsword Soulbinder - In Combat - Cast Curse of Exhaustion');
INSERT INTO smart_scripts VALUES (25373, 0, 2, 0, 0, 0, 100, 0, 11000, 12000, 27000, 28000, 11, 46427, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowsword Soulbinder - In Combat - Cast Domination');

-- Shadowsword Assassin (25484)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=25484;
DELETE FROM smart_scripts WHERE entryorguid IN(25484, -44268) AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(25484*100) AND source_type=9;
INSERT INTO smart_scripts VALUES (25484, 0, 0, 0, 1, 0, 100, 1, 500, 500, 0, 0, 11, 16380, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowsword Assassin - Out of Combat - Cast Greater Invisbility');
INSERT INTO smart_scripts VALUES (25484, 0, 1, 0, 1, 0, 100, 0, 2000, 2000, 2000, 2000, 49, 0, 0, 0, 0, 0, 0, 21, 15, 0, 0, 0, 0, 0, 0, 'Shadowsword Assassin - Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES (25484, 0, 2, 3, 0, 0, 100, 0, 12000, 15000, 24000, 28000, 11, 46463, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Shadowsword Assassin - In Combat - Cast Shadowstep');
INSERT INTO smart_scripts VALUES (25484, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 14, 0, 100, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowsword Assassin - In Combat - Reset All Threat');
INSERT INTO smart_scripts VALUES (25484, 0, 4, 0, 9, 0, 100, 0, 10, 35, 5000, 5000, 11, 46460, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadowsword Assassin - Within Range 10-35yd - Cast Aimed Shot');
INSERT INTO smart_scripts VALUES (25484, 0, 5, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 46459, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Shadowsword Assassin - On Aggro - Cast Assassins Mark');
INSERT INTO smart_scripts VALUES (-44268, 0, 0, 0, 1, 0, 100, 1, 500, 500, 0, 0, 11, 16380, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowsword Assassin - Out of Combat - Cast Greater Invisbility');
INSERT INTO smart_scripts VALUES (-44268, 0, 1, 0, 1, 0, 100, 0, 2000, 2000, 2000, 2000, 49, 0, 0, 0, 0, 0, 0, 21, 15, 0, 0, 0, 0, 0, 0, 'Shadowsword Assassin - Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES (-44268, 0, 2, 3, 0, 0, 100, 0, 12000, 15000, 24000, 28000, 11, 46463, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Shadowsword Assassin - In Combat - Cast Shadowstep');
INSERT INTO smart_scripts VALUES (-44268, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 14, 0, 100, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowsword Assassin - In Combat - Reset All Threat');
INSERT INTO smart_scripts VALUES (-44268, 0, 4, 0, 9, 0, 100, 0, 10, 35, 5000, 5000, 11, 46460, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadowsword Assassin - Within Range 10-35yd - Cast Aimed Shot');
INSERT INTO smart_scripts VALUES (-44268, 0, 5, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 46459, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Shadowsword Assassin - On Aggro - Cast Assassins Mark');
INSERT INTO smart_scripts VALUES (-44268, 0, 6, 0, 4, 0, 100, 257, 0, 0, 0, 0, 80, 25484*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowsword Assassin - On Aggro - Run Script9');
INSERT INTO smart_scripts VALUES (-44268, 0, 7, 0, 17, 0, 100, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Shadowsword Assassin - Summoned Unit - Store Target');
INSERT INTO smart_scripts VALUES (25484*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 25486, 8, 0, 0, 0, 0, 8, 0, 0, 0, 1807.98, 581.39, 50.70, 2.93, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (25484*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Script9 - Talk Target');
INSERT INTO smart_scripts VALUES (25484*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 130, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 1796.31, 560.63, 54.81, 0, 'Script9 - Move Target To Pos');
INSERT INTO smart_scripts VALUES (25484*100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 25486, 8, 0, 0, 0, 0, 8, 0, 0, 0, 1794.91, 587.13, 50.70, 5.93, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (25484*100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 130, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 1787.19, 567.94, 54.65, 0, 'Script9 - Move Target To Pos');

-- Oblivion Mage (25597)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=25597;
DELETE FROM smart_scripts WHERE entryorguid=25597 AND source_type=0;
INSERT INTO smart_scripts VALUES (25597, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 3000, 3000, 11, 46279, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Oblivion Mage - In Combat - Cast Flame Buffet');
INSERT INTO smart_scripts VALUES (25597, 0, 1, 0, 0, 0, 100, 0, 8000, 9000, 10000, 10000, 11, 46280, 0, 0, 0, 0, 0, 6, 20, 0, 0, 0, 0, 0, 0, 'Oblivion Mage - In Combat - Cast Polymorph');
INSERT INTO smart_scripts VALUES (25597, 0, 2, 0, 1, 0, 100, 0, 0, 0, 15000, 45000, 11, 46219, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Oblivion Mage - Out Of Combat - Cast Fire Channeling');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=25597;
INSERT INTO conditions VALUES(22, 3, 25597, 0, 0, 29, 1, 25592, 15, 0, 0, 0, 0, '', 'Reqires Doomfire destroyer in range');

-- SPELL Fire Channeling (46219)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=46219;
INSERT INTO conditions VALUES(13, 1, 46219, 0, 0, 31, 0, 3, 25592, 0, 0, 0, 0, '', 'Target Doomfire destroyer');

-- Doomfire Destroyer (25592)
UPDATE creature_template SET dmg_multiplier=40, AIName='SmartAI', ScriptName='' WHERE entry=25592;
DELETE FROM smart_scripts WHERE entryorguid=25592 AND source_type=0;
INSERT INTO smart_scripts VALUES (25592, 0, 0, 0, 0, 0, 100, 0, 1000, 2000, 10000, 10000, 11, 46306, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Doomfire Destroyer - In Combat - Cast Create Doomfire Shard');

-- Doomfire Shard (25948)
UPDATE creature_template SET dmg_multiplier=10, AIName='SmartAI', ScriptName='' WHERE entry=25948;
DELETE FROM smart_scripts WHERE entryorguid=25948 AND source_type=0;
INSERT INTO smart_scripts VALUES (25948, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 1000, 1000, 11, 46305, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Doomfire Shard - In Combat - Cast Avenging Rage');

-- Painbringer (25591)
UPDATE creature_template SET dmg_multiplier=20, AIName='', ScriptName='' WHERE entry=25591;
REPLACE INTO creature_template_addon VALUES (25591, 0, 0, 0, 4097, 0, '46277');
DELETE FROM smart_scripts WHERE entryorguid=25591 AND source_type=0;

-- Priestess of Torment (25509)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=25509;
DELETE FROM smart_scripts WHERE entryorguid=25509 AND source_type=0;
INSERT INTO smart_scripts VALUES (25509, 0, 0, 0, 0, 0, 100, 0, 2000, 6000, 15000, 20000, 11, 46270, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Priestess of Torment - In Combat - Cast Whirlwind');

-- Apocalypse Guard (25593)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=25593;
DELETE FROM smart_scripts WHERE entryorguid=25593 AND source_type=0;
INSERT INTO smart_scripts VALUES (25593, 0, 0, 0, 0, 0, 100, 0, 11000, 12000, 15000, 20000, 11, 45029, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Apocalypse Guard - In Combat - Cast Corrupting Strike');
INSERT INTO smart_scripts VALUES (25593, 0, 1, 0, 0, 0, 100, 0, 1000, 4000, 9000, 10000, 11, 40504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Apocalypse Guard - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (25593, 0, 2, 0, 0, 0, 100, 0, 4000, 6000, 15000, 20000, 11, 46283, 0, 0, 0, 0, 0, 5, 25, 0, 0, 0, 0, 0, 0, 'Apocalypse Guard - In Combat - Cast Death Coil');
INSERT INTO smart_scripts VALUES (25593, 0, 3, 0, 2, 0, 100, 1, 0, 20, 0, 0, 11, 46287, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Apocalypse Guard - Between 0-20% HP - Cast Infernal Defense');

-- Chaos Gazer (25595)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=25595;
DELETE FROM smart_scripts WHERE entryorguid=25595 AND source_type=0;
INSERT INTO smart_scripts VALUES (25595, 0, 0, 0, 0, 0, 100, 0, 10000, 10000, 30000, 30000, 11, 46291, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Chaos Gazer - In Combat - Cast Drain Life');
INSERT INTO smart_scripts VALUES (25595, 0, 1, 0, 0, 0, 100, 0, 1000, 2000, 25000, 25000, 11, 46288, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Chaos Gazer - In Combat - Cast Petrify');
INSERT INTO smart_scripts VALUES (25595, 0, 2, 0, 0, 0, 100, 0, 5000, 6000, 8000, 10000, 11, 46290, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Chaos Gazer - In Combat - Cast Tentacle Sweep');

-- Cataclysm Hound (25599)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=25599;
DELETE FROM smart_scripts WHERE entryorguid=25599 AND source_type=0;
INSERT INTO smart_scripts VALUES (25599, 0, 0, 0, 0, 0, 100, 0, 10000, 15000, 15000, 30000, 11, 46292, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cataclysm Hound - In Combat - Cast Cataclysm Breath');
INSERT INTO smart_scripts VALUES (25599, 0, 1, 0, 2, 0, 100, 1, 0, 20, 0, 0, 11, 47399, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cataclysm Hound - Between 0-20% HP - Cast Enrage');

-- SPELL Cataclysm Breath (46292)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(46292, -46292);
DELETE FROM spell_script_names WHERE spell_id IN(46292);
INSERT INTO spell_script_names VALUES(46292, 'spell_cataclysm_breath');

-- Shadowsword Guardian (25508)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=25508;
DELETE FROM smart_scripts WHERE entryorguid=25508 AND source_type=0;
INSERT INTO smart_scripts VALUES (25508, 0, 0, 0, 0, 0, 100, 0, 4000, 7000, 20000, 20000, 11, 46239, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Shadowsword Guardian - In Combat - Cast Bear Down');
INSERT INTO smart_scripts VALUES (25508, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 46932, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowsword Guardian - On Aggro - Cast Earthquake');



-- -------------------------------------------
--                BOSSES
-- -------------------------------------------

-- Kalecgos (24850)
DELETE FROM creature_text WHERE entry=24850;
INSERT INTO creature_text VALUES (24850, 0, 0, 'Aggh! No longer will I be a slave to Malygos! Challenge me and you will be destroyed!', 14, 0, 100, 0, 0, 12422, 0, 'kalecgos SAY_EVIL_AGGRO');
INSERT INTO creature_text VALUES (24850, 1, 0, 'In the name of Kil''jaeden!', 14, 0, 100, 0, 0, 12425, 0, 'kalecgos SAY_EVIL_SLAY1');
INSERT INTO creature_text VALUES (24850, 1, 1, 'You were warned!', 14, 0, 100, 0, 0, 12426, 0, 'kalecgos SAY_EVIL_SLAY2');
INSERT INTO creature_text VALUES (24850, 2, 0, 'I am forever in your debt. Once we have triumphed over Kil''jaeden, this entire world will be in your debt as well.', 12, 0, 100, 0, 0, 12431, 0, 'kalecgos SAY_GOOD_PLRWIN');
INSERT INTO creature_text VALUES (24850, 3, 0, 'My awakening is complete! You shall all perish!', 14, 0, 100, 0, 0, 12427, 0, 'kalecgos SAY_EVIL_ENRAGE');
INSERT INTO creature_text VALUES (24850, 4, 0, 'Sathrovarr drives Kalecgos into a crazed rage!', 41, 0, 100, 0, 0, 0, 0, 'kalecgos SAY_SATH_ENRAGE_ME');
INSERT INTO creature_text VALUES (24850, 5, 0, 'Kalecgos drives Sathrovarr into a crazed rage!', 41, 0, 100, 0, 0, 0, 0, 'kalecgos SAY_KALEC_ENRAGE_SATH');
UPDATE creature_template SET dmg_multiplier=70, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='boss_kalecgos' WHERE entry=24850;

-- Normal Realm (25795)
UPDATE creature_template SET flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=25795;

-- Spectral Realm (25796)
UPDATE creature_template SET flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=25796;

-- SPELL Spectral Realm (44811)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(44811, -44811);
DELETE FROM spell_script_names WHERE spell_id IN(44811);
INSERT INTO spell_script_names VALUES(44811, 'spell_kalecgos_spectral_realm_dummy');

-- SPELL Spectral Blast (44869)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(44869, -44869);
DELETE FROM spell_script_names WHERE spell_id IN(44869);
INSERT INTO spell_script_names VALUES(44869, 'spell_kalecgos_spectral_blast_dummy');

-- SPELL Teleport: Spectral Realm (46019)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(46019, -46019);
INSERT INTO spell_linked_spell VALUES (46019, 46021, 1, 'Trigger Spectral Realm');

-- SPELL Spectral Realm (46021)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(46021, -46021);
DELETE FROM spell_script_names WHERE spell_id IN(46021);
INSERT INTO spell_script_names VALUES(46021, 'spell_kalecgos_spectral_realm');

-- SPELL Teleport: Normal Realm (46020)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(46020, -46020);

-- SPELL Spectral Exhaustion (44867)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(44867, -44867);

-- Sathrovarr the Corruptor (24892)
REPLACE INTO creature_model_info VALUES (26628, 2, 4, 0, 0);
DELETE FROM creature_text WHERE entry=24892;
INSERT INTO creature_text VALUES (24892, 0, 0, 'There will be no reprieve. My work here is nearly finished.', 14, 0, 100, 0, 0, 12451, 0, 'sathrovarr SAY_SATH_AGGRO');
INSERT INTO creature_text VALUES (24892, 1, 0, 'Pitious mortal!', 14, 0, 100, 0, 0, 12455, 0, 'sathrovarr SAY_SATH_SLAY1');
INSERT INTO creature_text VALUES (24892, 1, 1, 'Haven''t you heard? I always win!', 14, 0, 100, 0, 0, 12456, 0, 'sathrovarr SAY_SATH_SLAY2');
INSERT INTO creature_text VALUES (24892, 2, 0, 'I''m... never on... the losing... side...', 14, 0, 100, 0, 0, 12452, 0, 'sathrovarr SAY_SATH_DEATH');
INSERT INTO creature_text VALUES (24892, 3, 0, 'Your misery is my delight!', 14, 0, 100, 0, 0, 12453, 0, 'sathrovarr SAY_SATH_SPELL1');
INSERT INTO creature_text VALUES (24892, 4, 0, 'I will watch you bleed!', 14, 0, 100, 0, 0, 12454, 0, 'sathrovarr SAY_SATH_SPELL2');
UPDATE creature_template SET faction=16, dmg_multiplier=70, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='boss_sathrovarr' WHERE entry=24892;
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=24892);
DELETE FROM creature WHERE id=24892;

-- SPELL Spectral Blast (45032)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(45032, -45032);
DELETE FROM spell_script_names WHERE spell_id IN(45032);
INSERT INTO spell_script_names VALUES(45032, 'spell_kalecgos_curse_of_boundless_agony');

-- Kalecgos (24891), human
DELETE FROM creature_text WHERE entry=24891;
INSERT INTO creature_text VALUES (24891, 0, 0, 'I need... your help... Cannot... resist him... much longer...', 14, 0, 100, 0, 0, 12428, 0, 'kalecgos SAY_GOOD_AGGRO');
INSERT INTO creature_text VALUES (24891, 1, 0, 'Aaahhh! Help me, before I lose my mind!', 14, 0, 100, 0, 0, 12429, 0, 'kalecgos SAY_GOOD_NEAR_DEATH');
INSERT INTO creature_text VALUES (24891, 2, 0, 'Hurry! There is not much of me left!', 14, 0, 100, 0, 0, 12430, 0, 'kalecgos SAY_GOOD_NEAR_DEATH2');
INSERT INTO creature_text VALUES (24891, 3, 0, 'Madrigosa deserved a far better fate. You did what had to be done, but this battle is far from over.', 14, 0, 100, 0, 0, 12439, 0, 'kalecgos - MADRIGOSA');
UPDATE creature_template SET faction=42, dmg_multiplier=10, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='boss_kalec' WHERE entry=24891;
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=24891);
DELETE FROM creature WHERE id=24891;

-- GO Spectral Rift (187055)
UPDATE gameobject_template SET flags=32, data3=1000, AIName='SmartGameObjectAI', ScriptName='' WHERE entry=187055;
DELETE FROM smart_scripts WHERE entryorguid=187055 AND source_type=1;
INSERT INTO smart_scripts VALUES (187055, 1, 0, 0, 60, 0, 100, 1, 15000, 15000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Rift - On Update - Despawn');

-- Brutallus (24882)
DELETE FROM creature_text WHERE entry=24882;
INSERT INTO creature_text VALUES (24882, 0, 0, 'Puny lizard! Death is the only answer you''ll find here!', 14, 0, 100, 1, 0, 12458, 0, 'brutallus YELL_INTRO');
INSERT INTO creature_text VALUES (24882, 1, 0, 'Grah! Your magic is weak!', 14, 0, 100, 0, 0, 12459, 0, 'brutallus YELL_INTRO_BREAK_ICE');
INSERT INTO creature_text VALUES (24882, 2, 0, 'I will crush you!', 14, 0, 100, 0, 0, 12460, 0, 'brutallus YELL_INTRO_CHARGE');
INSERT INTO creature_text VALUES (24882, 3, 0, 'That was fun, but I still await a true challenge!', 14, 0, 100, 0, 0, 12461, 0, 'brutallus YELL_INTRO_KILL_MADRIGOSA');
INSERT INTO creature_text VALUES (24882, 4, 0, 'Come, try your luck!', 14, 0, 100, 0, 0, 12462, 0, 'brutallus YELL_INTRO_TAUNT');
INSERT INTO creature_text VALUES (24882, 5, 0, 'Ahh! More lambs to the slaughter!', 14, 0, 100, 0, 0, 12463, 0, 'brutallus YELL_AGGRO');
INSERT INTO creature_text VALUES (24882, 6, 0, 'Perish, insect!', 14, 0, 100, 0, 0, 12464, 0, 'brutallus YELL_KILL1');
INSERT INTO creature_text VALUES (24882, 6, 1, 'You are meat!', 14, 0, 100, 0, 0, 12465, 0, 'brutallus YELL_KILL2');
INSERT INTO creature_text VALUES (24882, 6, 2, 'Too easy!', 14, 0, 100, 0, 0, 12466, 0, 'brutallus YELL_KILL3');
INSERT INTO creature_text VALUES (24882, 7, 0, 'Bring the fight to me!', 14, 0, 100, 0, 0, 12467, 0, 'brutallus YELL_LOVE1');
INSERT INTO creature_text VALUES (24882, 7, 1, 'Another day, another glorious battle!', 14, 0, 100, 0, 0, 12468, 0, 'brutallus YELL_LOVE2');
INSERT INTO creature_text VALUES (24882, 7, 2, 'I live for this!', 14, 0, 100, 0, 0, 12469, 0, 'brutallus YELL_LOVE3');
INSERT INTO creature_text VALUES (24882, 8, 0, 'So much for a real challenge... Die!', 14, 0, 100, 0, 0, 12470, 0, 'brutallus YELL_BERSERK');
INSERT INTO creature_text VALUES (24882, 9, 0, 'Gah! Well done... Now... this gets... interesting...', 14, 0, 100, 0, 0, 12471, 0, 'brutallus YELL_DEATH');
UPDATE creature_template SET dmg_multiplier=60, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='boss_brutallus' WHERE entry=24882;

-- Madrigosa (24895)
DELETE FROM creature_text WHERE entry=24895;
INSERT INTO creature_text VALUES (24895, 0, 0, 'Hold, friends! There is information to be had before this devil meets his fate!', 14, 0, 100, 0, 0, 12472, 0, 'madrigosa YELL_MADR_ICE_BARRIER');
INSERT INTO creature_text VALUES (24895, 1, 0, 'Where is Anveena, demon? What has become of Kalec?', 14, 0, 100, 1, 0, 12473, 0, 'madrigosa YELL_MADR_INTRO');
INSERT INTO creature_text VALUES (24895, 2, 0, 'You will tell me where they are!', 14, 0, 100, 0, 0, 12474, 0, 'madrigosa YELL_MADR_ICE_BLOCK');
INSERT INTO creature_text VALUES (24895, 3, 0, 'Speak, I grow weary of asking!', 14, 0, 100, 0, 0, 12475, 0, 'madrigosa YELL_MADR_TRAP');
INSERT INTO creature_text VALUES (24895, 4, 0, 'Malygos, my lord! I did my best!', 14, 0, 100, 0, 0, 12476, 0, 'madrigosa YELL_MADR_DEATH');
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=24895);
DELETE FROM creature WHERE id=24895;
REPLACE INTO creature VALUES (54812, 24895, 580, 1, 1, 0, 0, 1477.94, 643.22, 21.21, 4.93474, 604800, 0, 0, 695800, 3387, 0, 0, 0, 0);
UPDATE creature_template SET unit_flags=0, speed_walk=2, speed_run=2.3, faction=42, InhabitType=5, AIName='', ScriptName='npc_madrigosa' WHERE entry=24895;
REPLACE INTO creature_template_addon VALUES (24895, 0, 0, 0, 4097, 0, '');

-- SPELL Freeze (46609)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=46609;
INSERT INTO conditions VALUES(13, 1, 46609, 0, 0, 31, 0, 3, 19871, 0, 0, 0, 0, '', 'Target World Trigger (Not Immune NPC)');
DELETE FROM spell_linked_spell WHERE spell_trigger IN(46609, -46609, 46610, -46610);
INSERT INTO spell_linked_spell VALUES (46609, 46610, 1, 'Freeze (Madrigosa barrier');

-- SPELL Freeze (46610)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=46610;
INSERT INTO conditions VALUES(13, 1, 46610, 0, 0, 31, 0, 5, 188119, 0, 0, 0, 0, '', 'Target Sunwell Ice Barrier');
DELETE FROM spell_script_names WHERE spell_id IN(46610);
INSERT INTO spell_script_names VALUES(46610, 'spell_madrigosa_activate_barrier');

-- SPELL Break Ice (46637)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=46637;
INSERT INTO conditions VALUES(13, 1, 46637, 0, 0, 31, 0, 3, 19871, 0, 0, 0, 0, '', 'Target World Trigger (Not Immune NPC)');
DELETE FROM spell_linked_spell WHERE spell_trigger IN(46637, -46637, 46638, -46638, 47030, -47030);
INSERT INTO spell_linked_spell VALUES (-46637, 46638, 0, 'Break Ice (Madrigosa barrier');
INSERT INTO spell_linked_spell VALUES (-46637, 47030, 0, 'Break Ice (Madrigosa barrier');

-- SPELL Break Ice (46638)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=46638;
INSERT INTO conditions VALUES(13, 1, 46638, 0, 0, 31, 0, 5, 188119, 0, 0, 0, 0, '', 'Target Sunwell Ice Barrier');
DELETE FROM spell_script_names WHERE spell_id IN(46638);
INSERT INTO spell_script_names VALUES(46638, 'spell_madrigosa_deactivate_barrier');

-- SPELL Break Ice (47030)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=47030;
INSERT INTO conditions VALUES(13, 1, 47030, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Target All Players');

-- SPELL Frost Blast (44872)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=44872;
INSERT INTO conditions VALUES(13, 1, 44872, 0, 0, 31, 0, 3, 24882, 0, 0, 0, 0, '', 'Target Brutallus');

-- SPELL Encapsulate (44883)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=44883;
INSERT INTO conditions VALUES(13, 1, 44883, 0, 0, 31, 0, 3, 24882, 0, 0, 0, 0, '', 'Target Brutallus');

-- SPELL Charge (44884)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=44884;
INSERT INTO conditions VALUES(13, 1, 44884, 0, 0, 31, 0, 3, 24895, 0, 0, 0, 0, '', 'Target Madrigosa');

-- SPELL Fel Fireball (44844)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=44844;
INSERT INTO conditions VALUES(13, 3, 44844, 0, 0, 31, 0, 3, 24895, 0, 0, 0, 0, '', 'Target Madrigosa');

-- SPELL Burn (45141)
-- SPELL Burn (45151)
DELETE FROM spell_script_names WHERE spell_id IN(45141, 45151);
INSERT INTO spell_script_names VALUES(45141, 'spell_brutallus_burn');
INSERT INTO spell_script_names VALUES(45151, 'spell_brutallus_burn');

-- Target World Trigger (Not Immune NPC) (19871)
UPDATE creature_template SET AIName='NullCreatureAI', ScriptName='' WHERE entry=19871;

-- Doodad_Sunwell_Ice_Barrier01 (188119)
UPDATE gameobject SET state=0 WHERE id=188119;
UPDATE gameobject_template SET AIName='', ScriptName='' WHERE entry=188119;

-- Brutallus Death Cloud (25703)
UPDATE creature_template SET flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=25703;
REPLACE INTO creature_template_addon VALUES (25703, 0, 0, 0, 0, 0, '45212');

-- Felmyst (25038)
DELETE FROM creature_text WHERE entry=25038;
INSERT INTO creature_text VALUES (25038, 0, 0, 'Glory to Kil''jaeden! Death to all who oppose!', 14, 0, 100, 0, 0, 12477, 0, 'felmyst - YELL_BIRTH');
INSERT INTO creature_text VALUES (25038, 1, 0, 'I kill for the master!', 14, 0, 100, 0, 0, 12480, 0, 'felmyst - YELL_KILL1');
INSERT INTO creature_text VALUES (25038, 1, 1, 'The end has come!', 14, 0, 100, 0, 0, 12481, 0, 'felmyst - YELL_KILL2');
INSERT INTO creature_text VALUES (25038, 2, 0, 'Choke on your final breath!', 14, 0, 100, 0, 0, 12478, 0, 'felmyst - YELL_BREATH');
INSERT INTO creature_text VALUES (25038, 3, 0, 'I am stronger than ever before!', 14, 0, 100, 0, 0, 12479, 0, 'felmyst - YELL_TAKEOFF');
INSERT INTO creature_text VALUES (25038, 4, 0, 'No more hesitation! Your fates are written!', 14, 0, 100, 0, 0, 12482, 0, 'felmyst - YELL_BERSERK');
INSERT INTO creature_text VALUES (25038, 5, 0, 'Kil''jaeden... will... prevail...', 14, 0, 100, 0, 0, 12483, 0, 'felmyst - YELL_DEATH');
INSERT INTO creature_text VALUES (25038, 6, 0, '%s takes a deep breath.', 41, 0, 100, 0, 0, 0, 0, 'felmyst - EMOTE_BREATH');
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=25038);
DELETE FROM creature WHERE id=25038;
REPLACE INTO creature VALUES (NULL, 25038, 580, 1, 1, 0, 0, 1477.94, 643.22, 21.21, 4.93474, 604800, 0, 0, 695800, 3387, 0, 0, 0, 0);
UPDATE creature_template SET modelid1=22838, modelid2=0, speed_walk=2, speed_run=2, InhabitType=5, dmg_multiplier=70, mechanic_immune_mask=650854271, flags_extra=257|0x200000, AIName='', ScriptName='boss_felmyst' WHERE entry=25038;
REPLACE INTO creature_template_addon VALUES (25038, 0, 0, 0, 4097, 0, '');
REPLACE INTO creature_model_info VALUES (22838, 10, 10, 1, 0);

-- Demonic Vapor (25265)
REPLACE INTO creature_template_addon VALUES (25265, 0, 0, 0, 0, 0, '');
UPDATE creature_template SET modelid1=1126, modelid2=11686, speed_walk=0.8, speed_run=0.8, flags_extra=130, AIName='', ScriptName='npc_demonic_vapor' WHERE entry=25265;

-- Demonic Vapor (Trail) (25267)
REPLACE INTO creature_template_addon VALUES (25267, 0, 0, 0, 0, 0, '');
UPDATE creature_template SET modelid1=1126, modelid2=11686, flags_extra=130, AIName='', ScriptName='npc_demonic_vapor_trail' WHERE entry=25267;

-- Unyielding Dead (25268)
REPLACE INTO creature_template_addon VALUES (25268, 0, 0, 0, 0, 0, '45415');
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=25268;

-- Felmyst Flight Target - Left (25357)
UPDATE creature_template SET flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=25357;

-- Felmyst Flight Target - Right (25358)
UPDATE creature_template SET flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=25358;

-- SPELL Encapsulate (45661)
DELETE FROM spell_linked_spell WHERE spell_trigger=45661;
INSERT INTO spell_linked_spell VALUES (45661, 45665, 1, 'Encapsulate');

-- SPELL Demonic Vapor Spawn Trigger (45388)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=45388;
INSERT INTO conditions VALUES(13, 1, 45388, 0, 0, 31, 0, 3, 25038, 0, 0, 0, 0, '', 'Target Felmyst');

-- SPELL Demonic Vapor Beam Visual (45389)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=45389;
INSERT INTO conditions VALUES(13, 1, 45389, 0, 0, 31, 0, 3, 25265, 0, 0, 0, 0, '', 'Target Demonic Vapor');

-- SPELL Fog of Corruption (45714)
DELETE FROM spell_script_names WHERE spell_id IN(45714);
INSERT INTO spell_script_names VALUES(45714, 'spell_felmyst_fog_of_corruption');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=45714;
INSERT INTO conditions VALUES(13, 1, 45714, 0, 0, 31, 0, 3, 25038, 0, 0, 0, 0, '', 'Target Felmyst');

-- SPELL Fog of Corruption (45717)
DELETE FROM spell_script_names WHERE spell_id IN(45717);
INSERT INTO spell_script_names VALUES(45717, 'spell_felmyst_fog_of_corruption_charm');
DELETE FROM spell_linked_spell WHERE spell_trigger IN(45717, -45717);
INSERT INTO spell_linked_spell VALUES (45717, 45726, 1, 'Fog of Corruption - Charm');
INSERT INTO spell_linked_spell VALUES (-45717, -45726, 0, 'Fog of Corruption - Charm');

-- SPELL Open Brutallus Back Door (46650)
DELETE FROM spell_script_names WHERE spell_id IN(46650);
INSERT INTO spell_script_names VALUES(46650, 'spell_felmyst_open_brutallus_back_doors');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=46650;
INSERT INTO conditions VALUES(13, 1, 46650, 0, 0, 31, 0, 3, 23472, 0, 0, 0, 0, '', 'Target World Trigger');

-- Grand Warlock Alythess (25166)
DELETE FROM creature_text WHERE entry=25166;
INSERT INTO creature_text VALUES (25166, 0, 0, 'Depravity... hatred... chaos. These are the pillars...', 12, 0, 100, 0, 0, 0, 0, 'eredar - SAY_INTRO');
INSERT INTO creature_text VALUES (25166, 4, 0, '%s directs Conflagration at $n', 41, 0, 100, 0, 0, 0, 0, 'eredar - EMOTE_CONFLAGRATION');
INSERT INTO creature_text VALUES (25166, 5, 0, 'Fire consume.', 14, 0, 100, 0, 0, 12490, 0, 'eredar - YELL_ALY_KILL_1');
INSERT INTO creature_text VALUES (25166, 5, 1, 'Ed-ir Halach!', 14, 0, 100, 0, 0, 12491, 0, 'eredar - YELL_ALY_KILL_2');
INSERT INTO creature_text VALUES (25166, 6, 0, 'De-ek Anur!', 14, 0, 100, 0, 0, 12494, 0, 'eredar - YELL_ALY_DEAD');
INSERT INTO creature_text VALUES (25166, 7, 0, 'Sacrolash!', 14, 0, 100, 0, 0, 12492, 0, 'eredar - YELL_SISTER_SACROLASH_DEAD');
INSERT INTO creature_text VALUES (25166, 8, 0, 'Fire to the aid of shadow!', 14, 0, 100, 0, 0, 12489, 0, 'eredar - YELL_CANFLAGRATION');
INSERT INTO creature_text VALUES (25166, 9, 0, 'Your luck has run its curse!', 14, 0, 100, 0, 0, 12493, 0, 'eredar - YELL_BERSERK');
UPDATE creature_template SET dmg_multiplier=70, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='boss_alythess' WHERE entry=25166;

-- Lady Sacrolash (25165)
DELETE FROM creature_text WHERE entry=25165;
INSERT INTO creature_text VALUES (25165, 0, 0, 'Misery... confusion... mistrust. These are the hallmarks.', 12, 0, 100, 0, 0, 12484, 0, 'eredar - YELL_INTRO_SAC_1');
INSERT INTO creature_text VALUES (25165, 4, 0, 'I... fade.', 14, 0, 100, 0, 0, 0, 0, 'eredar - YELL_SAC_DEAD');
INSERT INTO creature_text VALUES (25165, 5, 0, '%s directs Shadow Nova at $n', 41, 0, 100, 0, 0, 0, 0, 'eredar - EMOTE_SHADOW_NOVA');
INSERT INTO creature_text VALUES (25165, 6, 0, 'Time is a luxury you no longer possess!', 14, 0, 100, 0, 0, 0, 0, 'eredar - YELL_ENRAGE');
INSERT INTO creature_text VALUES (25165, 7, 0, 'Alythess! Your fire burns within me!', 14, 0, 100, 0, 0, 12488, 0, 'eredar - YELL_SISTER_ALYTHESS_DEAD');
INSERT INTO creature_text VALUES (25165, 8, 0, 'Shadow engulf.', 14, 0, 100, 0, 0, 12486, 0, 'eredar - YELL_SAC_KILL_1');
INSERT INTO creature_text VALUES (25165, 8, 1, 'Ee-nok Kryul!', 14, 0, 100, 0, 0, 12487, 0, 'eredar - YELL_SAC_KILL_2');
INSERT INTO creature_text VALUES (25165, 9, 0, 'Shadow to the aid of fire!', 14, 0, 100, 0, 0, 12485, 0, 'eredar - YELL_SHADOW_NOVA');
UPDATE creature_template SET dmg_multiplier=70, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='boss_sacrolash' WHERE entry=25165;

-- Shadow Image (25214)
REPLACE INTO creature_template_addon VALUES (25214, 0, 0, 0, 4097, 0, '45263');
UPDATE creature_template SET unit_flags=33554432, AIName='SmartAI', ScriptName='' WHERE entry=25214;
DELETE FROM smart_scripts WHERE entryorguid=25214 AND source_type=0;
INSERT INTO smart_scripts VALUES (25214, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadow Image - In Combat - Set No Melee');
INSERT INTO smart_scripts VALUES (25214, 0, 1, 0, 0, 0, 100, 0, 1000, 2000, 3000, 3000, 11, 45271, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadow Image - In Combat - Cast Dark Strike');
INSERT INTO smart_scripts VALUES (25214, 0, 2, 0, 0, 0, 100, 1, 7000, 10000, 0, 0, 11, 45270, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Shadow Image - In Combat - Cast Shadowfury');

-- SPELL Confounding Blow (45256)
-- SPELL Shadow Blades (45248)
-- SPELL Shadow Nova (45329)
-- SPELL Shadowfury (45270)
-- SPELL Dark Strike (45271)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(45256, 45248, 45329, 45270, 45271);
DELETE FROM spell_script_names WHERE spell_id IN(45256, 45248, 45329, 45270, 45271);
INSERT INTO spell_script_names VALUES (45256, 'spell_eredar_twins_apply_dark_touched');
INSERT INTO spell_script_names VALUES (45248, 'spell_eredar_twins_apply_dark_touched');
INSERT INTO spell_script_names VALUES (45329, 'spell_eredar_twins_apply_dark_touched');
INSERT INTO spell_script_names VALUES (45270, 'spell_eredar_twins_apply_dark_touched');
INSERT INTO spell_script_names VALUES (45271, 'spell_eredar_twins_apply_dark_touched');

-- SPELL Conflagration (45342)
-- SPELL Flame Sear (46771)
-- SPELL Blaze (45235)
-- SPELL Burn (45246)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(45342, 46771, 45246, 45235);
DELETE FROM spell_script_names WHERE spell_id IN(45342, 46771, 45246, 45235);
INSERT INTO spell_script_names VALUES (45342, 'spell_eredar_twins_apply_flame_touched');
INSERT INTO spell_script_names VALUES (46771, 'spell_eredar_twins_apply_flame_touched');
INSERT INTO spell_script_names VALUES (45246, 'spell_eredar_twins_apply_flame_touched');
INSERT INTO spell_script_names VALUES (45235, 'spell_eredar_twins_apply_flame_touched');
INSERT INTO spell_script_names VALUES (45235, 'spell_eredar_twins_blaze');

-- SPELL Dark Touched (45347)
-- SPELL Flame Touched (45348)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(45347, 45348);
DELETE FROM spell_script_names WHERE spell_id IN(45347, 45348);
INSERT INTO spell_script_names VALUES (45347, 'spell_eredar_twins_handle_touch');
INSERT INTO spell_script_names VALUES (45348, 'spell_eredar_twins_handle_touch');

-- M'uru (25741)
REPLACE INTO creature_model_info VALUES (23200, 10, 12, 0, 0);
UPDATE creature_template SET unit_flags=4+131072, dmg_multiplier=70, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='boss_muru' WHERE entry=25741;

-- Entropius (25840)
UPDATE creature_template SET dmg_multiplier=70, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='boss_entropius' WHERE entry=25840;

-- M'uru Portal Target (25770)
UPDATE creature_template SET unit_flags=4, flags_extra=130, AIName='SmartAI', ScriptName='' WHERE entry=25770;
DELETE FROM smart_scripts WHERE entryorguid=25770 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(25770*100, 25770*100+1) AND source_type=9;
INSERT INTO smart_scripts VALUES (25770, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Muru Portal Target - On Reset - Set React Passive');
INSERT INTO smart_scripts VALUES (25770, 0, 1, 0, 8, 0, 100, 0, 45976, 0, 0, 0, 80, 25770*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Muru Portal Target - On Spell Hit - Start Script');
INSERT INTO smart_scripts VALUES (25770, 0, 2, 0, 17, 0, 100, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Muru Portal Target - Just Summoned - Store Target');
INSERT INTO smart_scripts VALUES (25770, 0, 3, 0, 31, 0, 100, 0, 45989, 0, 0, 0, 86, 45988, 2, 12, 1, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Muru Portal Target - Spell Hit Target - Cross Cast Summon Void Sentinel');
INSERT INTO smart_scripts VALUES (25770, 0, 4, 0, 8, 0, 100, 0, 46177, 0, 0, 0, 80, 25770*100+1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Muru Portal Target - On Spell Hit - Start Script');
INSERT INTO smart_scripts VALUES (25770*100, 9, 0, 0, 0, 0, 100, 0, 500, 500, 0, 0, 11, 45977, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Open Portal');
INSERT INTO smart_scripts VALUES (25770*100, 9, 1, 0, 0, 0, 100, 0, 4500, 4500, 0, 0, 11, 45978, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Summon Void Sentinel Summoner');
INSERT INTO smart_scripts VALUES (25770*100, 9, 2, 0, 0, 0, 100, 0, 500, 500, 0, 0, 11, 45989, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Summon Void Sentinel Summoner Visual');
INSERT INTO smart_scripts VALUES (25770*100+1, 9, 0, 0, 0, 0, 100, 0, 200, 200, 0, 0, 11, 45977, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Muru Portal Target - On Spell Hit - Cast Open Portal');
INSERT INTO smart_scripts VALUES (25770*100+1, 9, 1, 0, 0, 0, 100, 0, 2500, 2500, 0, 0, 11, 46178, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Muru Portal Target - On Spell Hit - Cast Transform Visual Missile');
INSERT INTO smart_scripts VALUES (25770*100+1, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 46208, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Muru Portal Target - On Spell Hit - Cast Transform Visual Missile');
INSERT INTO smart_scripts VALUES (25770*100+1, 9, 3, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 11, 46178, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Muru Portal Target - On Spell Hit - Cast Transform Visual Missile');
INSERT INTO smart_scripts VALUES (25770*100+1, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 46208, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Muru Portal Target - On Spell Hit - Cast Transform Visual Missile');
INSERT INTO smart_scripts VALUES (25770*100+1, 9, 5, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 11, 46178, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Muru Portal Target - On Spell Hit - Cast Transform Visual Missile');
INSERT INTO smart_scripts VALUES (25770*100+1, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 46208, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Muru Portal Target - On Spell Hit - Cast Transform Visual Missile');
INSERT INTO smart_scripts VALUES (25770*100+1, 9, 7, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 11, 46178, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Muru Portal Target - On Spell Hit - Cast Transform Visual Missile');
INSERT INTO smart_scripts VALUES (25770*100+1, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 46208, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Muru Portal Target - On Spell Hit - Cast Transform Visual Missile');
INSERT INTO smart_scripts VALUES (25770*100+1, 9, 9, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 11, 46178, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Muru Portal Target - On Spell Hit - Cast Transform Visual Missile');
INSERT INTO smart_scripts VALUES (25770*100+1, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 46208, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Muru Portal Target - On Spell Hit - Cast Transform Visual Missile');

-- Dark Fiend (25744)
UPDATE creature_template SET modelid1=23842, modelid2=0, speed_run=0.8, unit_flags=131072, flags_extra=2, AIName='SmartAI', ScriptName='' WHERE entry=25744; 
DELETE FROM smart_scripts WHERE entryorguid=25744 AND source_type=0;
INSERT INTO smart_scripts VALUES (25744, 0, 0, 1, 37, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dark Fiend - On Reset - Set React Passive');
INSERT INTO smart_scripts VALUES (25744, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 11, 45934, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dark Fiend - On Reset - Cast Spell');
INSERT INTO smart_scripts VALUES (25744, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 11, 45936, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dark Fiend - On Reset - Cast Spell');
INSERT INTO smart_scripts VALUES (25744, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 42, 1, 100, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dark Fiend - On Reset - Set Invincibility hp');
INSERT INTO smart_scripts VALUES (25744, 0, 4, 0, 60, 0, 100, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'Dark Fiend - On Update - Set Follow');
INSERT INTO smart_scripts VALUES (25744, 0, 5, 6, 9, 0, 100, 1, 0, 4, 0, 0, 11, 45944, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dark Fiend - Within Range 0-5yd - Cast Spell');
INSERT INTO smart_scripts VALUES (25744, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dark Fiend - Within Range 0-5yd - Despawn');

-- Void Sentinel (25772)
UPDATE creature_template SET dmg_multiplier=70, AIName='SmartAI', ScriptName='' WHERE entry=25772;
DELETE FROM smart_scripts WHERE entryorguid=25772 AND source_type=0;
INSERT INTO smart_scripts VALUES (25772, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 11, 46086, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Void Sentinel - On Reset - Cast Shadow Pulse Periodic');
INSERT INTO smart_scripts VALUES (25772, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'Void Sentinel - On Reset - Attack Start');
INSERT INTO smart_scripts VALUES (25772, 0, 2, 0, 0, 0, 100, 0, 20000, 20000, 45000, 45000, 11, 46161, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Void Sentinel - In Combat - Cast Void Blast');
INSERT INTO smart_scripts VALUES (25772, 0, 3, 4, 6, 0, 100, 0, 0, 0, 0, 0, 11, 46071, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Void Sentinel - On Death - Cast Summon Void Spawn');
INSERT INTO smart_scripts VALUES (25772, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 11, 46071, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Void Sentinel - On Death - Cast Summon Void Spawn');
INSERT INTO smart_scripts VALUES (25772, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 11, 46071, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Void Sentinel - On Death - Cast Summon Void Spawn');
INSERT INTO smart_scripts VALUES (25772, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 11, 46071, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Void Sentinel - On Death - Cast Summon Void Spawn');
INSERT INTO smart_scripts VALUES (25772, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 11, 46071, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Void Sentinel - On Death - Cast Summon Void Spawn');
INSERT INTO smart_scripts VALUES (25772, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 11, 46071, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Void Sentinel - On Death - Cast Summon Void Spawn');
INSERT INTO smart_scripts VALUES (25772, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 11, 46071, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Void Sentinel - On Death - Cast Summon Void Spawn');
INSERT INTO smart_scripts VALUES (25772, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 46071, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Void Sentinel - On Death - Cast Summon Void Spawn');

-- Void Spawn (25824)
UPDATE creature_template SET dmg_multiplier=10, AIName='SmartAI', ScriptName='' WHERE entry=25824;
DELETE FROM smart_scripts WHERE entryorguid=25824 AND source_type=0;
INSERT INTO smart_scripts VALUES (25824, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'Void Spawn - On Reset - Attack Start');
INSERT INTO smart_scripts VALUES (25824, 0, 1, 0, 0, 0, 100, 0, 3000, 12000, 15000, 20000, 11, 46082, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Void Spawn - In Combat - Cast Shadow Bolt Volley');

-- Shadowsword Fury Mage (25799)
UPDATE creature_template SET dmg_multiplier=14, AIName='SmartAI', ScriptName='' WHERE entry=25799;
DELETE FROM smart_scripts WHERE entryorguid=25799 AND source_type=0;
INSERT INTO smart_scripts VALUES (25799, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'Shadowsword Fury Mage - On Reset - Attack Start');
INSERT INTO smart_scripts VALUES (25799, 0, 1, 0, 0, 0, 100, 0, 1000, 1000, 5000, 5000, 11, 46101, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadowsword Fury Mage - In Combat - Cast Fel Fireball');
INSERT INTO smart_scripts VALUES (25799, 0, 2, 0, 0, 0, 100, 0, 15000, 15000, 45000, 45000, 11, 46102, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowsword Fury Mage - In Combat - Cast Spell Fury');

-- Shadowsword Berserker (25798)
UPDATE creature_template SET dmg_multiplier=14, AIName='SmartAI', ScriptName='' WHERE entry=25798;
DELETE FROM smart_scripts WHERE entryorguid=25798 AND source_type=0;
INSERT INTO smart_scripts VALUES (25798, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'Shadowsword Berserker - On Reset - Attack Start');
INSERT INTO smart_scripts VALUES (25798, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 29651, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowsword Berserker - On Reset - Cast Dual Wield');
INSERT INTO smart_scripts VALUES (25798, 0, 2, 0, 0, 0, 100, 0, 10000, 10000, 20000, 20000, 11, 46160, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowsword Berserker - In Combat - Cast Flurry');

-- Darkness (25879)
UPDATE creature_template SET flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=25879;
REPLACE INTO creature_template_addon VALUES (25879, 0, 0, 0, 0, 0, '46262 46265');

-- Singularity (25855)
UPDATE creature_template SET faction=14, flags_extra=130, AIName='', ScriptName='npc_singularity' WHERE entry=25855;
REPLACE INTO creature_template_addon VALUES (25855, 0, 0, 0, 0, 0, '');

-- SPELL Negative Energy (46008)
DELETE FROM spell_script_names WHERE spell_id IN(46008);
INSERT INTO spell_script_names VALUES (46008, 'spell_gen_select_target_count_15_5');

-- SPELL Summon Blood Elves Periodic (46041)
DELETE FROM spell_script_names WHERE spell_id IN(46041);
INSERT INTO spell_script_names VALUES (46041, 'spell_muru_summon_blood_elves_periodic');

-- SPELL Darkness (45996)
DELETE FROM spell_script_names WHERE spell_id IN(45996);
INSERT INTO spell_script_names VALUES (45996, 'spell_muru_darkness');

-- SPELL Open Portal (45976)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=45976;
INSERT INTO conditions VALUES(13, 1, 45976, 0, 0, 31, 0, 3, 25770, 0, 0, 0, 0, '', 'Target Muru Portal Target');
DELETE FROM spell_script_names WHERE spell_id IN(45976);
INSERT INTO spell_script_names VALUES (45976, 'spell_gen_select_target_count_7_1');

-- SPELL Open All Portals (46177)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=46177;
INSERT INTO conditions VALUES(13, 1, 46177, 0, 0, 31, 0, 3, 25770, 0, 0, 0, 0, '', 'Target Muru Portal Target');

-- SPELL Transform Visual Missile (46178)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=46178;
INSERT INTO conditions VALUES(13, 1, 46178, 0, 0, 31, 0, 3, 25741, 0, 0, 0, 0, '', 'Target Muru');

-- SPELL Transform Visual Missile (46208)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=46208;
INSERT INTO conditions VALUES(13, 1, 46208, 0, 0, 31, 0, 3, 25741, 0, 0, 0, 0, '', 'Target Muru');

-- SPELL Negative Energy (46289)
DELETE FROM spell_script_names WHERE spell_id IN(46289);
INSERT INTO spell_script_names VALUES (46289, 'spell_entropius_negative_energy');

-- SPELL Void Zone Pre-effect Visual (46265)
DELETE FROM spell_script_names WHERE spell_id IN(46265);
INSERT INTO spell_script_names VALUES (46265, 'spell_entropius_void_zone_visual');

-- SPELL Black Hole Effect (46230)
DELETE FROM spell_script_names WHERE spell_id IN(46230);
INSERT INTO spell_script_names VALUES (46230, 'spell_entropius_black_hole_effect');

-- SPELL Summon Berserker (46037)
-- SPELL Summon Fury Mage (46038)
-- SPELL Summon Fury Mage (46039)
-- SPELL Summon Berserker (46040)
DELETE FROM spell_target_position WHERE id IN(46037, 46038, 46039, 46040);
INSERT INTO spell_target_position VALUES (46037, 0, 580, 1780.16, 666.83, 71.19, 5.21);
INSERT INTO spell_target_position VALUES (46038, 0, 580, 1780.16, 666.83, 71.19, 5.21);
INSERT INTO spell_target_position VALUES (46039, 0, 580, 1847.93, 600.30, 71.30, 2.57);
INSERT INTO spell_target_position VALUES (46040, 0, 580, 1847.93, 600.30, 71.30, 2.57);

-- Kil'jaeden (25315)
DELETE FROM creature_text WHERE entry=25315;
INSERT INTO creature_text VALUES (25315, 0, 0, 'Nooooooooooooo!', 14, 0, 100, 0, 0, 12527, 0, 'KJ - SAY_KJ_DEATH');
INSERT INTO creature_text VALUES (25315, 1, 0, 'Another step towards destruction!', 14, 0, 100, 0, 0, 12501, 0, 'KJ - SAY_KJ_SLAY1');
INSERT INTO creature_text VALUES (25315, 1, 1, 'Anak-ky''ri!', 14, 0, 100, 0, 0, 12502, 0, 'KJ - SAY_KJ_SLAY2');
INSERT INTO creature_text VALUES (25315, 2, 0, 'Who can you trust?', 14, 0, 100, 0, 0, 12503, 0, 'KJ - SAY_KJ_REFLECTION1');
INSERT INTO creature_text VALUES (25315, 2, 1, 'The enemy is among you.', 14, 0, 100, 0, 0, 12504, 0, 'KJ - SAY_KJ_REFLECTION2');
INSERT INTO creature_text VALUES (25315, 3, 0, 'The expendible have perished... So be it! Now I shall succeed where Sargeras could not! I will bleed this wretched world and secure my place as the true master of the Burning Legion. The end has come! Let the unraveling of this world commence!', 14, 0, 100, 0, 0, 12500, 0, 'KJ - SAY_KJ_EMERGE');
INSERT INTO creature_text VALUES (25315, 4, 0, 'Chaos!', 14, 0, 100, 0, 0, 12505, 0, 'KJ - SAY_KJ_DARKNESS1');
INSERT INTO creature_text VALUES (25315, 4, 1, 'Destruction!', 14, 0, 100, 0, 0, 12506, 0, 'KJ - SAY_KJ_DARKNESS2');
INSERT INTO creature_text VALUES (25315, 4, 2, 'Oblivion!', 14, 0, 100, 0, 0, 12507, 0, 'KJ - SAY_KJ_DARKNESS3');
INSERT INTO creature_text VALUES (25315, 5, 0, 'I will not be denied! This world shall fall!', 14, 0, 100, 0, 0, 12508, 0, 'KJ - SAY_KJ_PHASE3');
INSERT INTO creature_text VALUES (25315, 6, 0, 'Do not harbor false hope. You cannot win!', 14, 0, 100, 0, 0, 12509, 0, 'KJ - SAY_KJ_PHASE4');
INSERT INTO creature_text VALUES (25315, 7, 0, 'Aggghh! The powers of the Sunwell... turned... against me! What have you done? WHAT HAVE YOU DONE?', 14, 0, 100, 0, 0, 12510, 0, 'KJ - SAY_KJ_PHASE5');
INSERT INTO creature_text VALUES (25315, 8, 0, '%s begins to channel dark energy', 41, 0, 100, 0, 0, 0, 0, 'KJ - EMOTE_KJ_DARKNESS');
UPDATE creature_template SET unit_flags=4, dmg_multiplier=80, mechanic_immune_mask=650854271, InhabitType=4, flags_extra=1|0x200000, AIName='', ScriptName='boss_kiljaeden' WHERE entry=25315;

-- Kalecgos (25319)
DELETE FROM creature_text WHERE entry=25319;
INSERT INTO creature_text VALUES (25319, 0, 0, 'Strike now, heroes, while he is weakened! Vanquish the Deceiver!', 14, 0, 100, 0, 0, 12449, 0, 'KJ - SAY_KALECGOS_ENCOURAGE');
INSERT INTO creature_text VALUES (25319, 1, 0, 'I will channel my power into the orbs, be ready!', 14, 0, 100, 0, 0, 12440, 0, 'KJ - SAY_KALECGOS_READY1');
INSERT INTO creature_text VALUES (25319, 2, 0, 'I have empowered another orb! Use it quickly!', 14, 0, 100, 0, 0, 12441, 0, 'KJ - SAY_KALECGOS_READY2');
INSERT INTO creature_text VALUES (25319, 2, 1, 'Another orb is ready! Make haste!', 14, 0, 100, 0, 0, 12442, 0, 'KJ - SAY_KALECGOS_READY2');
INSERT INTO creature_text VALUES (25319, 3, 0, 'I have channeled all I can! The power is in your hands!', 14, 0, 100, 0, 0, 12443, 0, 'KJ - SAY_KALECGOS_READY_ALL');
INSERT INTO creature_text VALUES (25319, 5, 0, 'Anveena, you must awaken, this world needs you!', 14, 0, 100, 0, 0, 12445, 0, 'KJ - SAY_KALECGOS_AWAKEN');
INSERT INTO creature_text VALUES (25319, 6, 0, 'You must let go! You must become what you were always meant to be! The time is now, Anveena!', 14, 0, 100, 0, 0, 12446, 0, 'KJ - SAY_KALECGOS_LETGO');
INSERT INTO creature_text VALUES (25319, 7, 0, 'Anveena, I love you! Focus on my voice, come back for me now! Only you can cleanse the Sunwell!', 14, 0, 100, 0, 0, 12447, 0, 'KJ - SAY_KALECGOS_FOCUS');
INSERT INTO creature_text VALUES (25319, 8, 0, 'Yes, Anveena! Let fate embrace you now!', 14, 0, 100, 0, 0, 12448, 0, 'KJ - SAY_KALECGOS_FATE');
INSERT INTO creature_text VALUES (25319, 9, 0, 'Goodbye, Anveena, my love. Few will remember your name, yet this day you change the course of destiny. What was once corrupt is now pure. Heroes, do not let her sacrifice be in vain.', 12, 0, 100, 0, 0, 12450, 0, 'KJ - SAY_KALECGOS_GOODBYE');
INSERT INTO creature_text VALUES (25319, 10, 0, 'You are not alone. The Blue Dragonflight shall help you vanquish the Deceiver.', 14, 0, 100, 0, 0, 12438, 0, 'KJ - SAY_KALECGOS_JOIN');
UPDATE creature_template SET unit_flags=33554432, InhabitType=4, AIName='', ScriptName='npc_kalecgos_kj' WHERE entry=25319;

-- Kil'jaeden (25608), CONTROLLER
UPDATE creature_template SET InhabitType=4, AIName='', ScriptName='npc_kiljaeden_controller' WHERE entry=25608;

-- Hand of the Deceiver (25588)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=25588);
DELETE FROM creature WHERE id=25588;
UPDATE creature_template SET dmg_multiplier=35, mechanic_immune_mask=650854271, AIName='SmartAI', ScriptName='' WHERE entry=25588;
DELETE FROM smart_scripts WHERE entryorguid=25588 AND source_type=0;
INSERT INTO smart_scripts VALUES (25588, 0, 0, 0, 0, 0, 100, 0, 10000, 25000, 30000, 30000, 11, 46875, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hand of the Deceiver - In Combat - Cast Felfire Portal');
INSERT INTO smart_scripts VALUES (25588, 0, 1, 0, 0, 0, 100, 0, 6000, 12000, 12000, 12000, 11, 45770, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hand of the Deceiver - In Combat - Cast Shadow Bolt Volley');
INSERT INTO smart_scripts VALUES (25588, 0, 2, 0, 2, 0, 100, 1, 0, 20, 0, 0, 11, 45772, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hand of the Deceiver - Between Health 0-20% - Cast Shadow Infusion');
INSERT INTO smart_scripts VALUES (25588, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 50, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hand of the Deceiver - On Aggro - Call For Help');
INSERT INTO smart_scripts VALUES (25588, 0, 4, 0, 1, 0, 100, 0, 500, 500, 0, 0, 11, 46757, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hand of the Deceiver - Out of Combat - Cast Shadow Channeling');

-- Anveena (26046)
DELETE FROM creature_text WHERE entry=26046;
INSERT INTO creature_text VALUES (26046, 0, 0, 'I serve only the Master now.', 12, 0, 100, 0, 0, 12511, 0, 'KJ - SAY_ANVEENA_IMPRISONED');
INSERT INTO creature_text VALUES (26046, 1, 0, 'But I''m... lost... I cannot find my way back!', 12, 0, 100, 0, 0, 12512, 0, 'KJ - SAY_ANVEENA_LOST');
INSERT INTO creature_text VALUES (26046, 2, 0, 'Kalec... Kalec?', 12, 0, 100, 0, 0, 12513, 0, 'KJ - SAY_ANVEENA_KALEC');
INSERT INTO creature_text VALUES (26046, 3, 0, 'The nightmare is over, the spell is broken! Goodbye, Kalec, my love!', 12, 0, 100, 0, 0, 12514, 0, 'KJ - SAY_ANVEENA_GOODBYE');
REPLACE INTO creature_template_addon VALUES (26046, 0, 0, 0, 0, 0, '46367');
UPDATE creature_template SET unit_flags=33554432, InhabitType=4, AIName='NullCreatureAI', ScriptName='' WHERE entry=26046;

-- Power of the Blue Flight (25653)
REPLACE INTO creature_template_addon VALUES (25653, 0, 0, 0, 0, 0, '');
UPDATE creature_template SET InhabitType=1, faction=35, spell1=45862, spell2=45856, spell3=45860, spell4=45848, AIName='NullCreatureAI', ScriptName='' WHERE entry=25653;

-- Felfire Portal (25603)
REPLACE INTO creature_template_addon VALUES (25603, 0, 0, 0, 0, 0, '46907 46464');
UPDATE creature_template SET unit_flags=4, flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=25603;
DELETE FROM smart_scripts WHERE entryorguid=25603 AND source_type=0;

-- Volatile Felfire Fiend (25598)
UPDATE creature_template SET unit_flags=131072, AIName='SmartAI', ScriptName='' WHERE entry=25598;
DELETE FROM smart_scripts WHERE entryorguid=25598 AND source_type=0;
INSERT INTO smart_scripts VALUES (25598, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'Volatile Felfire Fiend - On Reset - Attack Start');
INSERT INTO smart_scripts VALUES (25598, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 45779, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Volatile Felfire Fiend - On Death - Cast Felfire Fission');
INSERT INTO smart_scripts VALUES (25598, 0, 2, 3, 9, 0, 100, 1, 0, 5, 0, 0, 11, 45779, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Volatile Felfire Fiend - Within Range 0-5yd - Cast Felfire Fission');
INSERT INTO smart_scripts VALUES (25598, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Volatile Felfire Fiend - Within Range 0-5yd - Despawn');

-- Shield Orb (25502)
REPLACE INTO creature_template_addon VALUES (25502, 0, 0, 0, 0, 0, '45679');
UPDATE creature_template SET faction=14, InhabitType=4, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='NullCreatureAI', ScriptName='' WHERE entry=25502;

-- Armageddon Target (25735)
UPDATE creature_template SET faction=14, InhabitType=4, flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=25735;

-- Sinister Reflection (25708)
UPDATE creature_template SET faction=14, dmg_multiplier=35, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='SmartAI', ScriptName='' WHERE entry=25708;
DELETE FROM smart_scripts WHERE entryorguid=25708 AND source_type=0;
INSERT INTO smart_scripts VALUES (25708, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - On Reset - Attack Start');
INSERT INTO smart_scripts VALUES (25708, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 41, 2000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - On Death - Despawn');
INSERT INTO smart_scripts VALUES (25708, 0, 2, 0, 38, 0, 100, 0, 1, 1, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - On Data Set - Set Phase');
INSERT INTO smart_scripts VALUES (25708, 0, 3, 0, 38, 0, 100, 0, 1, 2, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - On Data Set - Set Phase');
INSERT INTO smart_scripts VALUES (25708, 0, 4, 0, 38, 0, 100, 0, 1, 3, 0, 0, 22, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - On Data Set - Set Phase');
INSERT INTO smart_scripts VALUES (25708, 0, 5, 0, 38, 0, 100, 0, 1, 4, 0, 0, 22, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - On Data Set - Set Phase');
INSERT INTO smart_scripts VALUES (25708, 0, 6, 0, 38, 0, 100, 0, 1, 5, 0, 0, 22, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - On Data Set - Set Phase');
INSERT INTO smart_scripts VALUES (25708, 0, 7, 0, 38, 0, 100, 0, 1, 6, 0, 0, 22, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - On Data Set - Set Phase');
INSERT INTO smart_scripts VALUES (25708, 0, 8, 0, 38, 0, 100, 0, 1, 7, 0, 0, 22, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - On Data Set - Set Phase');
INSERT INTO smart_scripts VALUES (25708, 0, 9, 0, 38, 0, 100, 0, 1, 8, 0, 0, 22, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - On Data Set - Set Phase');
INSERT INTO smart_scripts VALUES (25708, 0, 10, 0, 38, 0, 100, 0, 1, 9, 0, 0, 22, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - On Data Set - Set Phase');
INSERT INTO smart_scripts VALUES (25708, 0, 11, 0, 38, 0, 100, 0, 1, 11, 0, 0, 22, 11, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - On Data Set - Set Phase');
INSERT INTO smart_scripts VALUES (25708, 0, 12, 0, 54, 0, 100, 0, 0, 0, 0, 0, 85, 45785, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - Is Summoned - Invoker Cast');
INSERT INTO smart_scripts VALUES (25708, 0, 20, 0, 0, 1, 100, 1, 0, 0, 0, 0, 11, 42459, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - WARRIOR - Cast Dual Wield');
INSERT INTO smart_scripts VALUES (25708, 0, 21, 0, 0, 1, 100, 0, 1000, 5000, 9000, 13000, 11, 17207, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - WARRIOR - Cast Whirlwind');
INSERT INTO smart_scripts VALUES (25708, 0, 30, 0, 0, 2, 100, 0, 1000, 5000, 5000, 8000, 11, 38921, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - PALADIN - Cast Holy Shock');
INSERT INTO smart_scripts VALUES (25708, 0, 31, 0, 0, 2, 100, 0, 3000, 10000, 15000, 25000, 11, 37369, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - PALADIN - Cast Hammer of Justice');
INSERT INTO smart_scripts VALUES (25708, 0, 40, 0, 9, 4, 100, 0, 5, 30, 2000, 2000, 11, 16496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - HUNTER - Cast Shot');
INSERT INTO smart_scripts VALUES (25708, 0, 41, 0, 9, 4, 100, 0, 5, 30, 10000, 15000, 11, 48098, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - HUNTER - Cast Multi-Shot');
INSERT INTO smart_scripts VALUES (25708, 0, 42, 0, 9, 4, 100, 0, 0, 5, 15000, 25000, 11, 40652, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - HUNTER - Cast Wing Clip');
INSERT INTO smart_scripts VALUES (25708, 0, 43, 0, 9, 4, 100, 0, 0, 20, 0, 0, 21, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - HUNTER - Disable Combat Movement');
INSERT INTO smart_scripts VALUES (25708, 0, 44, 0, 9, 4, 100, 0, 25, 100, 0, 0, 21, 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - HUNTER - Enable Combat Movement');
INSERT INTO smart_scripts VALUES (25708, 0, 50, 0, 0, 8, 100, 1, 0, 0, 0, 0, 11, 42459, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - ROGUE - Cast Dual Wield');
INSERT INTO smart_scripts VALUES (25708, 0, 51, 0, 0, 8, 100, 0, 1000, 3000, 4000, 6000, 11, 45897, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - ROGUE - Cast Hemorrhage');
INSERT INTO smart_scripts VALUES (25708, 0, 60, 0, 0, 16, 100, 0, 1000, 4000, 4000, 5000, 11, 47077, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - PRIEST - Cast Holy Smite');
INSERT INTO smart_scripts VALUES (25708, 0, 61, 0, 14, 16, 100, 0, 10000, 40, 10000, 15000, 11, 47079, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - PRIEST - Cast Renew');
INSERT INTO smart_scripts VALUES (25708, 0, 62, 0, 9, 16, 100, 0, 0, 20, 0, 0, 21, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - PRIEST - Disable Combat Movement');
INSERT INTO smart_scripts VALUES (25708, 0, 63, 0, 9, 16, 100, 0, 25, 100, 0, 0, 21, 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - PRIEST - Enable Combat Movement');
INSERT INTO smart_scripts VALUES (25708, 0, 70, 0, 0, 32, 100, 1, 0, 0, 0, 0, 11, 42459, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - DEATH KINGHT - Cast Dual Wield');
INSERT INTO smart_scripts VALUES (25708, 0, 71, 0, 0, 32, 100, 0, 1000, 5000, 4000, 6000, 11, 58843, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - DEATH KNIGHT - Cast Plague Strike');
INSERT INTO smart_scripts VALUES (25708, 0, 80, 0, 0, 64, 100, 1, 0, 0, 0, 0, 11, 42459, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - SHAMAN - Cast Dual Wield');
INSERT INTO smart_scripts VALUES (25708, 0, 81, 0, 0, 64, 100, 0, 1000, 5000, 6000, 10000, 11, 47071, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - SHAMAN - Cast Earth Shock');
INSERT INTO smart_scripts VALUES (25708, 0, 90, 0, 0, 128, 100, 0, 1000, 2000, 2000, 3000, 11, 47074, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - MAGE - Cast Fireball');
INSERT INTO smart_scripts VALUES (25708, 0, 91, 0, 9, 128, 100, 0, 0, 20, 0, 0, 21, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - MAGE - Disable Combat Movement');
INSERT INTO smart_scripts VALUES (25708, 0, 92, 0, 9, 128, 100, 0, 25, 100, 0, 0, 21, 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - MAGE - Enable Combat Movement');
INSERT INTO smart_scripts VALUES (25708, 0, 100, 0, 0, 256, 100, 0, 1000, 1500, 1500, 2500, 11, 47076, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - WARLOCK - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (25708, 0, 101, 0, 0, 256, 100, 0, 4000, 5000, 10000, 12000, 11, 46190, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - WARLOCK - Cast Curse of Agony');
INSERT INTO smart_scripts VALUES (25708, 0, 102, 0, 9, 256, 100, 0, 0, 20, 0, 0, 21, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - WARLOCK - Disable Combat Movement');
INSERT INTO smart_scripts VALUES (25708, 0, 103, 0, 9, 256, 100, 0, 25, 100, 0, 0, 21, 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - WARLOCK - Enable Combat Movement');
INSERT INTO smart_scripts VALUES (25708, 0, 110, 0, 0, 1024, 100, 0, 1000, 2000, 2000, 3000, 11, 47072, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - DRUID - Cast Moonfire');
INSERT INTO smart_scripts VALUES (25708, 0, 111, 0, 9, 1024, 100, 0, 0, 20, 0, 0, 21, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - DRUID - Disable Combat Movement');
INSERT INTO smart_scripts VALUES (25708, 0, 112, 0, 9, 1024, 100, 0, 25, 100, 0, 0, 21, 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sinister Reflection - DRUID - Enable Combat Movement');

-- GO Orb of the Blue Flight (188415, 187869, 188114, 188115, 188116)
UPDATE gameobject_template SET AIName='', ScriptName='' WHERE entry=188415;
UPDATE gameobject_template SET flags=16, AIName='SmartGameObjectAI', ScriptName='' WHERE entry IN(187869, 188114, 188115, 188116);
DELETE FROM smart_scripts WHERE entryorguid IN(187869, 188114, 188115, 188116) AND source_type=1;
INSERT INTO smart_scripts VALUES (187869, 1, 0, 1, 64, 0, 100, 0, 0, 0, 0, 0, 104, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Orb of the Blue Flight - On Gossip Hello - Set GO Flags');
INSERT INTO smart_scripts VALUES (188114, 1, 0, 1, 64, 0, 100, 0, 0, 0, 0, 0, 104, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Orb of the Blue Flight - On Gossip Hello - Set GO Flags');
INSERT INTO smart_scripts VALUES (188115, 1, 0, 1, 64, 0, 100, 0, 0, 0, 0, 0, 104, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Orb of the Blue Flight - On Gossip Hello - Set GO Flags');
INSERT INTO smart_scripts VALUES (188116, 1, 0, 1, 64, 0, 100, 0, 0, 0, 0, 0, 104, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Orb of the Blue Flight - On Gossip Hello - Set GO Flags');
INSERT INTO smart_scripts VALUES (187869, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 12999, 10, 0, 0, 0, 0, 0, 'Orb of the Blue Flight - On Gossip Hello - Despawn Target');
INSERT INTO smart_scripts VALUES (188114, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 12999, 10, 0, 0, 0, 0, 0, 'Orb of the Blue Flight - On Gossip Hello - Despawn Target');
INSERT INTO smart_scripts VALUES (188115, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 12999, 10, 0, 0, 0, 0, 0, 'Orb of the Blue Flight - On Gossip Hello - Despawn Target');
INSERT INTO smart_scripts VALUES (188116, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 12999, 10, 0, 0, 0, 0, 0, 'Orb of the Blue Flight - On Gossip Hello - Despawn Target');
DELETE FROM gameobject WHERE id IN(187869, 188114, 188115, 188116);
INSERT INTO gameobject VALUES (NULL, 187869, 580, 1, 1, 1695.93, 675.326, 28.0503, 4.73554, 0, 0, 0.698873, -0.715246, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (NULL, 188114, 580, 1, 1, 1653, 635.798, 28.0941, 6.28277, 0, 0, 0.000206145, -1, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (NULL, 188115, 580, 1, 1, 1704.5, 582.851, 28.1673, 1.64521, 0, 0, 0.732919, 0.680316, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (NULL, 188116, 580, 1, 1, 1747.1, 621.843, 28.0503, 2.98269, 0, 0, 0.996846, 0.0793661, 300, 0, 1, 0);

-- SPELL Shadow Bolt (45680)
DELETE FROM spell_script_names WHERE spell_id IN(45680);
INSERT INTO spell_script_names VALUES (45680, 'spell_gen_select_target_count_7_1');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=45680;
INSERT INTO conditions VALUES(13, 1, 45680, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Target Players');
INSERT INTO conditions VALUES(13, 1, 45680, 0, 0, 1, 0, 45839, 2, 0, 1, 0, 0, '', 'Require no aura');

-- SPELL Shadow Spike (46680)
DELETE FROM spell_script_names WHERE spell_id IN(46680);
INSERT INTO spell_script_names VALUES (46680, 'spell_kiljaeden_shadow_spike');

-- SPELL Sinister Reflection (45892)
DELETE FROM spell_script_names WHERE spell_id IN(45892);
INSERT INTO spell_script_names VALUES (45892, 'spell_kiljaeden_sinister_reflection');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=45892;
INSERT INTO conditions VALUES(13, 1, 45892, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Target Players');

-- SPELL Sinister Reflection Clone (45785)
DELETE FROM spell_script_names WHERE spell_id IN(45785);
INSERT INTO spell_script_names VALUES (45785, 'spell_kiljaeden_sinister_reflection_clone');
INSERT INTO spell_script_names VALUES (45785, 'spell_gen_clone');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=45785;
INSERT INTO conditions VALUES(13, 7, 45785, 0, 0, 31, 0, 3, 25708, 0, 0, 0, 0, '', 'Target Sinister Reflection');
INSERT INTO conditions VALUES(13, 7, 45785, 0, 0, 1, 0, 45785, 0, 0, 1, 0, 0, '', 'Target with no aura');

-- SPELL Flame Dart (45737)
DELETE FROM spell_script_names WHERE spell_id IN(45737);
INSERT INTO spell_script_names VALUES (45737, 'spell_kiljaeden_flame_dart');

-- SPELL Darkness of a Thousand Souls (46605)
DELETE FROM spell_script_names WHERE spell_id IN(46605);
INSERT INTO spell_script_names VALUES (46605, 'spell_kiljaeden_darkness');

-- SPELL Power of the Blue Flight (45833)
DELETE FROM spell_script_names WHERE spell_id IN(45833);
INSERT INTO spell_script_names VALUES (45833, 'spell_kiljaeden_power_of_the_blue_flight');

-- SPELL Vengeance of the Blue Flight (45839)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=45839;
INSERT INTO conditions VALUES(13, 3, 45839, 0, 0, 31, 0, 3, 25653, 0, 0, 0, 0, '', 'Target Power of the Blue Flight');
DELETE FROM spell_script_names WHERE spell_id IN(45839);
INSERT INTO spell_script_names VALUES (45839, 'spell_kiljaeden_vengeance_of_the_blue_flight');

-- SPELL Sacrifice of Anveena (46474)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=46474;
INSERT INTO conditions VALUES(13, 1, 46474, 0, 0, 31, 0, 3, 25315, 0, 0, 0, 0, '', 'Target Kiljaeden');

-- SPELL Armageddon (45921)
DELETE FROM spell_script_names WHERE spell_id IN(45921);
INSERT INTO spell_script_names VALUES (45921, 'spell_kiljaeden_armageddon_periodic');

-- SPELL Armageddon (45909)
DELETE FROM spell_script_names WHERE spell_id IN(45909);
INSERT INTO spell_script_names VALUES (45909, 'spell_kiljaeden_armageddon_missile');

-- SPELL Breath: Haste (45856)
-- SPELL Breath: Revitalize (45860)
DELETE FROM spell_script_names WHERE spell_id IN(45856, 45860);
INSERT INTO spell_script_names VALUES (45856, 'spell_kiljaeden_dragon_breath');
INSERT INTO spell_script_names VALUES (45860, 'spell_kiljaeden_dragon_breath');

-- SPELL Destroy All Drakes (46707)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=46707;
INSERT INTO conditions VALUES(13, 1, 46707, 0, 0, 31, 0, 3, 25653, 0, 0, 0, 0, '', 'Target Power of the Blue Flight');


-- -------------------------------------------
--                POST EVENT
-- -------------------------------------------

-- Shattrath Portal Dummy (26251)
UPDATE creature_template SET flags_extra=130, InhabitType=4, AIName='NullCreatureAI', ScriptName='' WHERE entry=26251;

-- Inert Portal (26254)
REPLACE INTO creature_template_addon VALUES (26254, 0, 0, 0, 0, 0, '');
UPDATE creature_template SET flags_extra=130, InhabitType=4, AIName='NullCreatureAI', ScriptName='' WHERE entry=26254;

-- Shattered Sun Soldier (26259)
UPDATE creature_template SET AIName='NullCreatureAI', ScriptName='' WHERE entry=26259;

-- Lady Liadrin <Blood Knight Matriarch> (26247)
DELETE FROM creature_text WHERE entry=26247;
INSERT INTO creature_text VALUES (26247, 0, 0, 'Our arrogance was unpardonable. We damned one of the most noble beings of all. We may never atone for this sin.', 12, 0, 100, 1, 0, 12524, 0, 'Lady Liadrin');
INSERT INTO creature_text VALUES (26247, 1, 0, 'Can it be?', 12, 0, 100, 1, 0, 12525, 0, 'Lady Liadrin');
INSERT INTO creature_text VALUES (26247, 2, 0, 'Blessed ancestors! I feel it... so much love... so much grace... there are... no words... impossible to describe...', 12, 0, 100, 1, 0, 12526, 0, 'Lady Liadrin');
UPDATE creature_template SET AIName='NullCreatureAI', ScriptName='' WHERE entry=26247;

-- Prophet Velen (26246)
DELETE FROM creature_text WHERE entry=26246;
INSERT INTO creature_text VALUES (26246, 0, 0, 'Mortal heroes - your victory here today was foretold long ago. My brother''s anguished cry of defeat will echo across the universe - bringing renewed hope to all those who still stand against the Burning Crusade.', 12, 0, 100, 1, 0, 12515, 0, 'Prophet Velen');
INSERT INTO creature_text VALUES (26246, 1, 0, 'As the Legion''s final defeat draws ever-nearer, stand proud in the knowledge that you have saved worlds without number from the flame.', 12, 0, 100, 1, 0, 12516, 0, 'Prophet Velen');
INSERT INTO creature_text VALUES (26246, 2, 0, 'Just as this day marks an ending, so too does it herald a new beginning...', 12, 0, 100, 1, 0, 12517, 0, 'Prophet Velen');
INSERT INTO creature_text VALUES (26246, 3, 0, 'The creature Entropius, whom you were forced to destroy, was once the noble naaru, M''uru. In life, M''uru channeled vast energies of LIGHT and HOPE. For a time, a misguided few sought to steal those energies...', 12, 0, 100, 1, 0, 12518, 0, 'Prophet Velen');
INSERT INTO creature_text VALUES (26246, 4, 0, 'Then fortunate it is, that I have reclaimed the noble naaru''s spark from where it fell! Where faith dwells, hope is never lost, young blood elf.', 12, 0, 100, 1, 0, 12519, 0, 'Prophet Velen');
INSERT INTO creature_text VALUES (26246, 5, 0, 'Gaze now, mortals - upon the HEART OF M''URU! Unblemished. Bathed by the light of Creation - just as it was at the Dawn.', 12, 0, 100, 1, 0, 12520, 0, 'Prophet Velen');
INSERT INTO creature_text VALUES (26246, 6, 0, 'In time, the light and hope held within - will rebirth more than this mere fount of power... Mayhap, they will rebirth the soul of a nation.', 12, 0, 100, 1, 0, 12521, 0, 'Prophet Velen');
INSERT INTO creature_text VALUES (26246, 7, 0, 'Salvation, young one. It waits for us all.', 12, 0, 100, 1, 0, 12522, 0, 'Prophet Velen');
INSERT INTO creature_text VALUES (26246, 8, 0, 'Farewell...', 12, 0, 100, 0, 0, 12523, 0, 'Prophet Velen');
REPLACE INTO creature_template_addon VALUES (26246, 0, 0, 0, 0, 0, '');
UPDATE creature_template SET AIName='NullCreatureAI', ScriptName='' WHERE entry=26246;

-- The Core of Entropius (26262)
REPLACE INTO creature_template_addon VALUES (26262, 0, 0, 0, 0, 0, '46819');
UPDATE creature_template SET flags_extra=130, InhabitType=4, AIName='NullCreatureAI', ScriptName='' WHERE entry=26262;

-- SPELL Teleport and Transform (46473)
REPLACE INTO spell_target_position VALUES (46473, 1, 580, 1666.88, 631.915, 28.06, 6.14);

-- SPELL Call Entropius (46818)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=46818;
INSERT INTO conditions VALUES(13, 1, 46818, 0, 0, 31, 0, 3, 26262, 0, 0, 0, 0, '', 'Target The Core of Entropius');


-- -------------------------------------------
--                MISC
-- -------------------------------------------

DELETE FROM areatrigger_scripts WHERE entry=4853;
INSERT INTO areatrigger_scripts VALUES (4853, 'at_sunwell_madrigosa');

DELETE FROM areatrigger_scripts WHERE entry=4937;
INSERT INTO areatrigger_scripts VALUES (4937, 'at_sunwell_eredar_twins');


-- Gauntlet Imp Trigger (25848)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=25848);
DELETE FROM creature WHERE id=25848;
INSERT INTO creature VALUES (247106, 25848, 580, 1, 1, 0, 0, 1697.96, 501.758, 86.4468, 1.97682, 604800, 0, 0, 3828, 0, 0, 0, 33554432, 0);
UPDATE creature_template SET flags_extra=130, AIName='SmartAI', ScriptName='' WHERE entry=25848;
REPLACE INTO creature_template_addon VALUES (25848, 0, 0, 0, 0, 0, '46172');
DELETE FROM smart_scripts WHERE entryorguid=25848 AND source_type=0;
INSERT INTO smart_scripts VALUES (25848, 0, 0, 0, 60, 0, 100, 0, 0, 0, 10000, 10000, 11, 46214, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gauntlet Imp Trigger - On Update - Cast Summon Imp');

-- Shadowsword Commander (25837)
DELETE FROM creature_text WHERE entry=25837;
INSERT INTO creature_text VALUES (25837, 0, 0, "Bring forth the imps!", 14, 0, 100, 0, 0, 0, 0, 'Shadowsword Commander');
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=25837);
DELETE FROM creature WHERE id=25837;
INSERT INTO creature VALUES (247107, 25837, 580, 1, 1, 0, 1, 1684.47, 533.048, 85.2745, 1.99645, 604800, 0, 0, 175935, 0, 0, 0, 0, 0);
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=25837;
DELETE FROM smart_scripts WHERE entryorguid=25837 AND source_type=0;
INSERT INTO smart_scripts VALUES (25837, 0, 0, 0, 37, 0, 100, 257, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowsword Commander - On AI Init - Talk');
INSERT INTO smart_scripts VALUES (25837, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 41, 20000, 0, 0, 0, 0, 0, 19, 25848, 200, 0, 0, 0, 0, 0, 'Shadowsword Commander - On Death - Despawn Target');
INSERT INTO smart_scripts VALUES (25837, 0, 2, 0, 0, 0, 100, 0, 0, 0, 30000, 30000, 11, 46763, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowsword Commander - In Combat - Cast Battle Shout');
INSERT INTO smart_scripts VALUES (25837, 0, 3, 0, 0, 0, 100, 0, 4000, 8000, 15000, 20000, 11, 46762, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadowsword Commander - In Combat - Cast Shield Slam');

-- Volatile Fiend (25851)
UPDATE creature_template SET unit_flags=32768+131072, AIName='SmartAI', ScriptName='' WHERE entry=25851;
DELETE FROM smart_scripts WHERE entryorguid=25851 AND source_type=0;
INSERT INTO smart_scripts VALUES (25851, 0, 0, 1, 54, 0, 100, 1, 0, 0, 0, 0, 11, 46308, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Volatile Fiend - Just Summoned - Cast Burning Winds');
INSERT INTO smart_scripts VALUES (25851, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Volatile Fiend - Just Summoned - Set Phase mask');
INSERT INTO smart_scripts VALUES (25851, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 53, 1, 25851, 0, 0, 2500, 2, 1, 0, 0, 0, 0, 0, 0, 0, 'Volatile Fiend - Just Summoned - Start WP');
INSERT INTO smart_scripts VALUES (25851, 0, 3, 8, 40, 0, 100, 0, 20, 0, 0, 0, 11, 47287, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Volatile Fiend - On WP Reached - Cast Burning Destruction');
INSERT INTO smart_scripts VALUES (25851, 0, 4, 0, 6, 1, 100, 0, 0, 0, 0, 0, 11, 46218, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Volatile Fiend - On Death - Cast Burning Destruction');
INSERT INTO smart_scripts VALUES (25851, 0, 5, 0, 6, 2, 100, 0, 0, 0, 0, 0, 11, 45779, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Volatile Fiend - On Death - Cast Felfire Fission');
INSERT INTO smart_scripts VALUES (25851, 0, 6, 8, 9, 1, 100, 1, 0, 5, 0, 0, 11, 46218, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Volatile Fiend - Within Range 0-5yd - Cast Burning Destruction');
INSERT INTO smart_scripts VALUES (25851, 0, 7, 8, 9, 2, 100, 1, 0, 5, 0, 0, 11, 45779, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Volatile Fiend - Within Range 0-5yd - Cast Felfire Fission');
INSERT INTO smart_scripts VALUES (25851, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Volatile Fiend - On WP Reached - Despawn');
INSERT INTO smart_scripts VALUES (25851, 0, 9, 0, 25, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Volatile Fiend - On Reset - Set Phase mask');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=25851;
DELETE FROM waypoints WHERE entry=25851;
INSERT INTO waypoints VALUES (25851, 1, 1691.8, 513.581, 85.272, 'Volatile Fiend'),(25851, 2, 1685.3, 531.707, 85.2726, 'Volatile Fiend'),(25851, 3, 1678.34, 548.748, 85.1301, 'Volatile Fiend'),(25851, 4, 1666.06, 562.532, 85.0835, 'Volatile Fiend'),(25851, 5, 1637.52, 577.188, 85.0895, 'Volatile Fiend'),(25851, 6, 1614.78, 593.407, 84.98, 'Volatile Fiend'),(25851, 7, 1597.61, 586.214, 84.9866, 'Volatile Fiend'),(25851, 8, 1600.17, 579.387, 84.8456, 'Volatile Fiend'),
(25851, 9, 1614.05, 560.661, 73.5036, 'Volatile Fiend'),(25851, 10, 1628.04, 541.932, 63.0932, 'Volatile Fiend'),(25851, 11, 1647.24, 530.052, 53.9219, 'Volatile Fiend'),(25851, 12, 1654.32, 527.089, 50.6408, 'Volatile Fiend'),(25851, 13, 1659.93, 519.575, 50.5756, 'Volatile Fiend'),(25851, 14, 1653.65, 505.556, 50.5756, 'Volatile Fiend'),(25851, 15, 1632.21, 514.799, 50.5756, 'Volatile Fiend'),(25851, 16, 1614, 529.46, 50.5756, 'Volatile Fiend'),(25851, 17, 1596.71, 543.375, 50.5756, 'Volatile Fiend'),
(25851, 18, 1583.25, 560.562, 50.5756, 'Volatile Fiend'),(25851, 19, 1570.92, 574.75, 50.6095, 'Volatile Fiend'),(25851, 20, 1557.81, 569.841, 50.5778, 'Volatile Fiend');
