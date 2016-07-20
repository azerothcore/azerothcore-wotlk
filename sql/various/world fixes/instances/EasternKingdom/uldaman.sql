
UPDATE creature SET spawntimesecs=86400 WHERE map=70 AND spawntimesecs>0;
UPDATE gameobject SET spawntimesecs=86400 WHERE map=70 AND spawntimesecs>0;

-- -------------------------------------------
--               FORMATIONS
-- -------------------------------------------

-- -------------------------------------------
--                TRASH
-- -------------------------------------------
-- Stonevault Rockchewer (4851)
DELETE FROM creature_text WHERE entry=4851;
INSERT INTO creature_text VALUES (4851, 0, 0, '%s goes into a frenzy!', 16, 0, 100, 0, 0, 0, 0, 'Stonevault Rockchewer');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4851;
DELETE FROM smart_scripts WHERE entryorguid=4851 AND source_type=0;
INSERT INTO smart_scripts VALUES (4851, 0, 0, 1, 2, 0, 100, 1, 0, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Rockchewer - Between 0-30% Health - Cast Frenzy');
INSERT INTO smart_scripts VALUES (4851, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Rockchewer - Between 0-30% Health - Say Line 0');

-- Stonevault Rockchewer (4852)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4852;
DELETE FROM smart_scripts WHERE entryorguid=4852 AND source_type=0;
INSERT INTO smart_scripts VALUES (4852, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 945, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Rockchewer - On Aggro - Cast Lightning Shield');
INSERT INTO smart_scripts VALUES (4852, 0, 1, 0, 0, 0, 100, 0, 0, 6000, 40000, 40000, 11, 5605, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Rockchewer - In Combat - Cast Healing Ward');
INSERT INTO smart_scripts VALUES (4852, 0, 2, 0, 0, 0, 100, 0, 22000, 22000, 40000, 40000, 11, 8264, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Rockchewer - In Combat - Cast Lava Spout Totem');
INSERT INTO smart_scripts VALUES (4852, 0, 3, 0, 14, 0, 100, 0, 700, 40, 10000, 15000, 11, 8005, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Rockchewer - Friendly Missing Health - Cast Healing Wave');
INSERT INTO smart_scripts VALUES (4852, 0, 4, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Rockchewer - Between 0-15% Health - Flee For Assist');

-- Stonevault Ambusher (7175)
DELETE FROM creature_text WHERE entry=7175;
INSERT INTO creature_text VALUES (7175, 0, 0, '%s goes into a frenzy!', 16, 0, 100, 0, 0, 0, 0, 'Stonevault Ambusher');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7175;
DELETE FROM smart_scripts WHERE entryorguid=7175 AND source_type=0;
INSERT INTO smart_scripts VALUES (7175, 0, 0, 0, 67, 0, 100, 0, 6000, 8000, 0, 0, 11, 8721, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Ambusher - Behind Target - Cast Backstab');
INSERT INTO smart_scripts VALUES (7175, 0, 1, 2, 2, 0, 100, 1, 0, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Ambusher - Between 0-30% Health - Cast Frenzy');
INSERT INTO smart_scripts VALUES (7175, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Ambusher - Between 0-30% Health - Say Line 0');

-- Stonevault Cave Lurker (4850)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4850;
DELETE FROM smart_scripts WHERE entryorguid=4850 AND source_type=0;
INSERT INTO smart_scripts VALUES (4850, 0, 0, 0, 1, 0, 100, 1, 0, 1000, 0, 0, 11, 22766, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Cave Lurker - Out of Combat - Cast Sneak');
INSERT INTO smart_scripts VALUES (4850, 0, 1, 0, 67, 0, 100, 0, 6000, 8000, 0, 0, 11, 8721, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Cave Lurker - Behind Target - Cast Backstab');
INSERT INTO smart_scripts VALUES (4850, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Cave Lurker - Between 0-15% Health - Flee For Assist');

-- Shrike Bat (4861)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4861;
DELETE FROM smart_scripts WHERE entryorguid=4861 AND source_type=0;
INSERT INTO smart_scripts VALUES (4861, 0, 0, 0, 0, 0, 100, 0, 1000, 11000, 16000, 24000, 11, 8281, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shrike Bat - In Combat - Cast Sonic Burst');

-- Jadespine Basilisk (4863)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4863;
DELETE FROM smart_scripts WHERE entryorguid=4863 AND source_type=0;
INSERT INTO smart_scripts VALUES (4863, 0, 0, 0, 0, 0, 100, 0, 1000, 11000, 16000, 24000, 11, 9906, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Jadespine Basilisk - In Combat - Cast Reflection');
INSERT INTO smart_scripts VALUES (4863, 0, 1, 0, 0, 0, 100, 0, 1000, 11000, 19000, 24000, 11, 3636, 0, 0, 0, 0, 0, 5, 5, 0, 0, 0, 0, 0, 0, 'Jadespine Basilisk - In Combat - Cast Crystalline Slumber');

-- Cleft Scorpid (7078)
REPLACE INTO creature_template_addon VALUES (7078, 0, 0, 0, 4097, 0, '3616');
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=7078;
DELETE FROM smart_scripts WHERE entryorguid=7078 AND source_type=0;

-- Deadly Cleft Scorpid (7405)
REPLACE INTO creature_template_addon VALUES (7405, 0, 0, 0, 4097, 0, '3616');
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=7405;
DELETE FROM smart_scripts WHERE entryorguid=7405 AND source_type=0;

-- Venomlash Scorpid (7022)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7022;
DELETE FROM smart_scripts WHERE entryorguid=7022 AND source_type=0;
INSERT INTO smart_scripts VALUES (7022, 0, 0, 0, 0, 0, 100, 0, 1000, 11000, 16000, 24000, 11, 8257, 0, 0, 0, 0, 0, 5, 5, 0, 0, 0, 0, 0, 0, 'Venomlash Scorpid - In Combat - Cast Venom Sting');

-- Shadowforge Relic Hunter (4847)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4847;
DELETE FROM smart_scripts WHERE entryorguid=4847 AND source_type=0;
INSERT INTO smart_scripts VALUES (4847, 0, 0, 0, 0, 0, 100, 0, 1000, 11000, 16000, 24000, 11, 2767, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Shadowforge Relic Hunter - In Combat - Cast Shadow Word: Pain');
INSERT INTO smart_scripts VALUES (4847, 0, 1, 0, 0, 0, 100, 0, 1000, 11000, 16000, 24000, 11, 6726, 0, 0, 0, 0, 0, 5, 20, 0, 1, 0, 0, 0, 0, 'Shadowforge Relic Hunter - In Combat - Cast Silence');
INSERT INTO smart_scripts VALUES (4847, 0, 2, 0, 14, 0, 100, 0, 700, 40, 11000, 14000, 11, 6064, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Shadowforge Relic Hunter - Friendly Missing Health - Cast Heal');
INSERT INTO smart_scripts VALUES (4847, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowforge Relic Hunter - Between 0-15% Health - Flee For Assist');

-- Shadowforge Geologist (7030)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7030;
DELETE FROM smart_scripts WHERE entryorguid=7030 AND source_type=0;
INSERT INTO smart_scripts VALUES (7030, 0, 0, 0, 0, 0, 100, 0, 1000, 11000, 16000, 24000, 11, 8814, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Shadowforge Geologist - In Combat - Cast Flame Spike');
INSERT INTO smart_scripts VALUES (7030, 0, 1, 0, 0, 0, 100, 0, 1000, 6000, 8000, 11000, 11, 3356, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Shadowforge Geologist - In Combat - Cast Flame Lash');

-- Earthen Rocksmasher (7011)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7011;
DELETE FROM smart_scripts WHERE entryorguid=7011 AND source_type=0;
INSERT INTO smart_scripts VALUES (7011, 0, 0, 0, 0, 0, 100, 1, 0, 2000, 0, 0, 11, 7165, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthen Rocksmasher - In Combat - Cast Battle Stance');
INSERT INTO smart_scripts VALUES (7011, 0, 1, 0, 0, 0, 100, 0, 1000, 6000, 6000, 9000, 11, 12057, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Earthen Rocksmasher - In Combat - Cast Strike');
INSERT INTO smart_scripts VALUES (7011, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthen Rocksmasher - Between 0-15% Health - Flee For Assist');

-- Earthen Sculptor (7012)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7012;
DELETE FROM smart_scripts WHERE entryorguid=7012 AND source_type=0;
INSERT INTO smart_scripts VALUES (7012, 0, 0, 0, 0, 0, 100, 0, 0, 8000, 20000, 30000, 11, 2602, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthen Sculptor - In Combat - Cast Fire Shield IV');
INSERT INTO smart_scripts VALUES (7012, 0, 1, 0, 0, 0, 100, 0, 1000, 5000, 8000, 13000, 11, 10452, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Earthen Sculptor - In Combat - Cast Flame Buffet');
INSERT INTO smart_scripts VALUES (7012, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthen Sculptor - Between 0-15% Health - Flee For Assist');

-- Stone Steward (4860)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4860;
DELETE FROM smart_scripts WHERE entryorguid=4860 AND source_type=0;
INSERT INTO smart_scripts VALUES (4860, 0, 0, 0, 0, 0, 100, 0, 0, 10000, 14000, 20000, 11, 6524, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stone Steward - In Combat - Cast Ground Tremor');

-- Shadowforge Sharpshooter (7290)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7290;
DELETE FROM smart_scripts WHERE entryorguid=7290 AND source_type=0;
INSERT INTO smart_scripts VALUES (7290, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 2000, 2000, 11, 6660, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadowforge Sharpshooter - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES (7290, 0, 1, 0, 0, 0, 100, 0, 1000, 6000, 11000, 19000, 11, 6685, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Shadowforge Sharpshooter - In Combat - Cast Piercing Shot');
INSERT INTO smart_scripts VALUES (7290, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowforge Sharpshooter - Between 0-15% Health - Flee For Assist');

-- Shadowforge Darkcaster (4848)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4848;
DELETE FROM smart_scripts WHERE entryorguid=4848 AND source_type=0;
INSERT INTO smart_scripts VALUES (4848, 0, 0, 0, 0, 0, 100, 0, 1000, 6000, 8000, 12000, 11, 9081, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowforge Darkcaster - In Combat - Cast Shadow Bolt Volley');
INSERT INTO smart_scripts VALUES (4848, 0, 1, 0, 0, 0, 100, 0, 1000, 6000, 11000, 19000, 11, 15800, 0, 0, 0, 0, 0, 5, 30, 0, 1, 0, 0, 0, 0, 'Shadowforge Darkcaster - In Combat - Cast Mana Burn');
INSERT INTO smart_scripts VALUES (4848, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowforge Darkcaster - Between 0-15% Health - Flee For Assist');

-- Shadowforge Archaeologist (4849)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4849;
DELETE FROM smart_scripts WHERE entryorguid=4849 AND source_type=0;
INSERT INTO smart_scripts VALUES (4849, 0, 0, 0, 0, 0, 100, 0, 0, 2000, 120000, 120000, 11, 7164, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowforge Archaeologist - In Combat - Cast Defensive Stance');
INSERT INTO smart_scripts VALUES (4849, 0, 1, 0, 13, 0, 100, 0, 11000, 11000, 0, 0, 11, 11972, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowforge Archaeologist - Victim Casting - Cast Shield Bash');
INSERT INTO smart_scripts VALUES (4849, 0, 2, 0, 0, 0, 100, 0, 1000, 11000, 11000, 19000, 11, 6713, 0, 0, 0, 0, 0, 2, 0, 0, 1, 0, 0, 0, 0, 'Shadowforge Archaeologist - In Combat - Cast Disarm');
INSERT INTO smart_scripts VALUES (4849, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowforge Archaeologist - Between 0-15% Health - Flee For Assist');

-- Stonevault Brawler (4855)
DELETE FROM creature_text WHERE entry=4855;
INSERT INTO creature_text VALUES (4855, 0, 0, '%s goes into a frenzy!', 16, 0, 100, 0, 0, 0, 0, 'Stonevault Brawler');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4855;
DELETE FROM smart_scripts WHERE entryorguid=4855 AND source_type=0;
INSERT INTO smart_scripts VALUES (4855, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 3417, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Brawler - On Reset - Cast Thrash');
INSERT INTO smart_scripts VALUES (4855, 0, 1, 0, 2, 0, 100, 1, 0, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Brawler - Between 0-30% Health - Cast Frenzy');
INSERT INTO smart_scripts VALUES (4855, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Brawler - Between 0-30% Health - Say Line 0');

-- Stonevault Geomancer (4853)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4853;
DELETE FROM smart_scripts WHERE entryorguid=4853 AND source_type=0;
INSERT INTO smart_scripts VALUES (4853, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 3000, 4000, 11, 9053, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Geomancer - In Combat - Cast Fireball');
INSERT INTO smart_scripts VALUES (4853, 0, 1, 0, 0, 0, 100, 0, 1000, 6000, 11000, 19000, 11, 10452, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Stonevault Geomancer - In Combat - Cast Flame Buffet');
INSERT INTO smart_scripts VALUES (4853, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Geomancer - Between 0-15% Health - Flee For Assist');

-- Stonevault Mauler (7320)
DELETE FROM creature_text WHERE entry=7320;
INSERT INTO creature_text VALUES (7320, 0, 0, '%s goes into a frenzy!', 16, 0, 100, 0, 0, 0, 0, 'Stonevault Mauler');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7320;
DELETE FROM smart_scripts WHERE entryorguid=7320 AND source_type=0;
INSERT INTO smart_scripts VALUES (7320, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 3417, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Mauler - On Reset - Cast Thrash');
INSERT INTO smart_scripts VALUES (7320, 0, 1, 0, 2, 0, 100, 1, 0, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Mauler - Between 0-30% Health - Cast Frenzy');
INSERT INTO smart_scripts VALUES (7320, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Mauler - Between 0-30% Health - Say Line 0');

-- Stonevault Flameweaver (7321)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7321;
DELETE FROM smart_scripts WHERE entryorguid=7321 AND source_type=0;
INSERT INTO smart_scripts VALUES (7321, 0, 0, 0, 0, 0, 100, 0, 4000, 10000, 7000, 14000, 11, 2941, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Stonevault Flameweaver - In Combat - Cast Immolate');
INSERT INTO smart_scripts VALUES (7321, 0, 1, 0, 0, 0, 100, 0, 1000, 9000, 17000, 25000, 11, 7739, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Flameweaver - In Combat - Cast Inferno Shell');
INSERT INTO smart_scripts VALUES (7321, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Flameweaver - Between 0-15% Health - Flee For Assist');

-- Earthen Stonebreaker (7396)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7396;
DELETE FROM smart_scripts WHERE entryorguid=7396 AND source_type=0;
INSERT INTO smart_scripts VALUES (7396, 0, 0, 0, 0, 0, 100, 1, 0, 2000, 0, 0, 11, 7165, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthen Stonebreaker - In Combat - Cast Battle Stance');
INSERT INTO smart_scripts VALUES (7396, 0, 1, 0, 0, 0, 100, 0, 1000, 6000, 6000, 9000, 11, 12057, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Earthen Stonebreaker - In Combat - Cast Strike');

-- Earthen Stonecarver (7397)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7397;
DELETE FROM smart_scripts WHERE entryorguid=7397 AND source_type=0;
INSERT INTO smart_scripts VALUES (7397, 0, 0, 0, 0, 0, 100, 0, 0, 8000, 20000, 30000, 11, 2602, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthen Stonecarver - In Combat - Cast Fire Shield IV');
INSERT INTO smart_scripts VALUES (7397, 0, 1, 0, 0, 0, 100, 0, 1000, 5000, 8000, 13000, 11, 10452, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Earthen Stonecarver - In Combat - Cast Flame Buffet');





-- -------------------------------------------
--                BOSSES
-- -------------------------------------------

-- Revelosh (6910)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6910;
DELETE FROM smart_scripts WHERE entryorguid=6910 AND source_type=0;
INSERT INTO smart_scripts VALUES (6910, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 3000, 4000, 11, 15801, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Revelosh - In Combat - Cast Lightning Bolt');
INSERT INTO smart_scripts VALUES (6910, 0, 1, 0, 0, 0, 100, 0, 6000, 10000, 10000, 15000, 11, 16006, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Revelosh - In Combat - Cast Chain Lightning');

-- Baelog (6906)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6906;
DELETE FROM smart_scripts WHERE entryorguid=6906 AND source_type=0;
INSERT INTO smart_scripts VALUES (6906, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2300, 3900, 11, 15620, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Baelog - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES (6906, 0, 1, 0, 0, 0, 100, 0, 4000, 7000, 9000, 13000, 11, 14516, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Baelog - In Combat - Cast Strike');

-- Eric "The Swift" (6907)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6907;
DELETE FROM smart_scripts WHERE entryorguid=6907 AND source_type=0;
INSERT INTO smart_scripts VALUES (6907, 0, 0, 0, 0, 0, 100, 0, 0, 0, 7000, 9000, 11, 6268, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Eric "The Swift" - In Combat - Cast Rushing Charge');

-- Olaf (6908)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6908;
DELETE FROM smart_scripts WHERE entryorguid=6908 AND source_type=0;
INSERT INTO smart_scripts VALUES (6908, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 8000, 11000, 11, 8242, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Olaf - In Combat - Cast Shield Slam');

-- Ironaya (7228)
DELETE FROM creature_text WHERE entry=7228;
INSERT INTO creature_text VALUES (7228, 0, 0, 'None may steal the secrets of the makers!', 14, 0, 100, 0, 0, 5851, 3, 'ironaya SAY_AGGRO');
UPDATE creature_template SET faction=59, AIName='SmartAI', ScriptName='' WHERE entry=7228;
DELETE FROM smart_scripts WHERE entryorguid=7228 AND source_type=0;
INSERT INTO smart_scripts VALUES (7228, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ironaya - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (7228, 0, 1, 0, 0, 0, 100, 0, 7000, 9000, 6000, 10000, 11, 8374, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ironaya - In Combat - Cast Arcing Smash');
INSERT INTO smart_scripts VALUES (7228, 0, 2, 0, 0, 0, 100, 0, 14000, 18000, 20000, 20000, 11, 10101, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ironaya - In Combat - Cast Knock Away');
INSERT INTO smart_scripts VALUES (7228, 0, 3, 0, 0, 0, 100, 0, 12000, 12000, 17000, 17000, 11, 11876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ironaya - In Combat - Cast War Stomp');

-- Obsidian Sentinel (7023)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7023;
DELETE FROM smart_scripts WHERE entryorguid=7023 AND source_type=0;
INSERT INTO smart_scripts VALUES (7023, 0, 0, 0, 0, 0, 100, 0, 1000, 11000, 16000, 24000, 11, 9906, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Obsidian Sentinel - In Combat - Cast Reflection');
INSERT INTO smart_scripts VALUES (7023, 0, 1, 0, 0, 0, 100, 0, 20000, 20000, 20000, 20000, 11, 10072, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Obsidian Sentinel - In Combat - Cast Splintered Obsidian');
INSERT INTO smart_scripts VALUES (7023, 0, 2, 0, 0, 0, 100, 0, 10000, 20000, 20000, 30000, 11, 10061, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Obsidian Sentinel - In Combat - Cast Summon Obsidian Shard');

-- Obsidian Shard (7209)
REPLACE INTO creature_template_addon VALUES (7209, 0, 0, 0, 4097, 0, '9941');
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=7209;
DELETE FROM smart_scripts WHERE entryorguid=7209 AND source_type=0;

-- Ancient Stone Keeper (7206)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7206;
DELETE FROM smart_scripts WHERE entryorguid=7206 AND source_type=0;
INSERT INTO smart_scripts VALUES (7206, 0, 0, 0, 0, 0, 100, 0, 5000, 5000, 20000, 20000, 11, 10132, 0, 0, 0, 0, 0, 5, 10, 0, 0, 0, 0, 0, 0, 'Ancient Stone Keeper - In Combat - Cast Sand Storm');
INSERT INTO smart_scripts VALUES (7206, 0, 1, 0, 0, 0, 100, 0, 5000, 5000, 20000, 20000, 11, 10094, 0, 0, 0, 0, 0, 17, 10, 30, 0, 0, 0, 0, 0, 'Ancient Stone Keeper - In Combat - Cast Sand Storm');
INSERT INTO smart_scripts VALUES (7206, 0, 2, 0, 17, 0, 100, 0, 0, 0, 0, 0, 89, 10, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Ancient Stone Keeper - Just Summoned - Move Random');

-- Sand Storm (7226)
REPLACE INTO creature_template_addon VALUES (7226, 0, 0, 0, 0, 0, '10092');
UPDATE creature_template SET flags_extra=128, AIName='NullCreatureAI', ScriptName='' WHERE entry=7226;
DELETE FROM smart_scripts WHERE entryorguid=7226 AND source_type=0;

-- Galgann Firehammer (7291)
DELETE FROM creature_text WHERE entry=7291;
INSERT INTO creature_text VALUES (7291, 0, 0, 'By Thaurissan''s beard! Slay them!', 14, 0, 100, 0, 0, 5852, 0, 'Galgann Firehammer');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7291;
DELETE FROM smart_scripts WHERE entryorguid=7291 AND source_type=0;
INSERT INTO smart_scripts VALUES (7291, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Galgann Firehammer - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (7291, 0, 1, 0, 0, 0, 100, 0, 5000, 5000, 20000, 20000, 11, 9482, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Galgann Firehammer - In Combat - Cast Amplify Flames');
INSERT INTO smart_scripts VALUES (7291, 0, 2, 0, 0, 0, 100, 0, 10000, 10000, 20000, 20000, 11, 11969, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Galgann Firehammer - In Combat - Cast Fire Nova');
INSERT INTO smart_scripts VALUES (7291, 0, 3, 0, 0, 0, 100, 0, 15000, 15000, 20000, 20000, 11, 3356, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Galgann Firehammer - In Combat - Cast Flame Lash');
INSERT INTO smart_scripts VALUES (7291, 0, 4, 0, 0, 0, 100, 0, 20000, 20000, 20000, 20000, 11, 8053, 0, 0, 0, 0, 0, 5, 25, 0, 0, 0, 0, 0, 0, 'Galgann Firehammer - In Combat - Cast Flame Shock');

-- Grimlok <Stonevault Chieftain> (4854)
DELETE FROM creature_text WHERE entry=4854;
INSERT INTO creature_text VALUES (4854, 0, 0, 'Me %s, king!', 14, 0, 100, 0, 0, 5853, 0, 'Grimlok');
INSERT INTO creature_text VALUES (4854, 1, 0, 'Die! Die!', 14, 0, 100, 0, 0, 5854, 0, 'Grimlok');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4854;
DELETE FROM smart_scripts WHERE entryorguid=4854 AND source_type=0;
INSERT INTO smart_scripts VALUES (4854, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grimlok - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (4854, 0, 1, 0, 5, 0, 100, 0, 5000, 5000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grimlok - On Kill - Say Line 1');
INSERT INTO smart_scripts VALUES (4854, 0, 2, 0, 0, 0, 100, 0, 0, 0, 3000, 4000, 11, 9532, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grimlok - In Combat - Cast Lightning Bolt');
INSERT INTO smart_scripts VALUES (4854, 0, 3, 0, 0, 0, 100, 0, 5000, 10000, 20000, 20000, 11, 8292, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Grimlok - In Combat - Cast Chain Bolt');
INSERT INTO smart_scripts VALUES (4854, 0, 4, 0, 0, 0, 100, 0, 5000, 15000, 25000, 40000, 11, 11892, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Grimlok - In Combat - Cast Shrink');
INSERT INTO smart_scripts VALUES (4854, 0, 5, 0, 0, 0, 100, 0, 0, 10000, 20000, 20000, 11, 8143, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grimlok - In Combat - Cast Tremor Totem');
INSERT INTO smart_scripts VALUES (4854, 0, 6, 0, 2, 0, 100, 1, 0, 40, 0, 0, 11, 6742, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grimlok - Between Health 0-40% - Cast Bloodlust');

-- Archaedas <Ancient Stone Watcher> (2748)
DELETE FROM creature_text WHERE entry=2748;
INSERT INTO creature_text VALUES (2748, 0, 0, 'Who dares awaken Archaedas? Who dares the wrath of the makers!', 14, 0, 100, 0, 0, 5855, 0, 'Archaedas On Aggro');
INSERT INTO creature_text VALUES (2748, 1, 0, 'Awake ye servants, defend the discs!', 14, 0, 100, 0, 0, 5856, 0, 'Archaedas On Summon Guardians');
INSERT INTO creature_text VALUES (2748, 2, 0, 'To my side, brothers. For the makers!', 14, 0, 100, 0, 0, 5857, 0, 'Archaedas On Summon Vault Walkers');
INSERT INTO creature_text VALUES (2748, 3, 0, 'Reckless mortal.', 14, 0, 100, 0, 0, 5858, 0, 'Archaedas On Player Kill');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=2748;
DELETE FROM smart_scripts WHERE entryorguid=2748 AND source_type=0;
INSERT INTO smart_scripts VALUES (2748, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 10255, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Archaedas - On Reset - Cast Stoned');
INSERT INTO smart_scripts VALUES (2748, 0, 1, 2, 38, 0, 100, 0, 1, 1, 0, 0, 11, 10347, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Archaedas - On Data Set - Cast Archaedas Awaken Visual (DND)');
INSERT INTO smart_scripts VALUES (2748, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 4000, 4000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Archaedas - On Data Set - Create Timed Event');
INSERT INTO smart_scripts VALUES (2748, 0, 3, 4, 59, 0, 100, 0, 1, 0, 0, 0, 28, 10255, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Archaedas - On Timed Event - Remove Aura Stoned');
INSERT INTO smart_scripts VALUES (2748, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 80, 0, 0, 0, 0, 0, 0, 'Archaedas - On Timed Event - Attack Start');
INSERT INTO smart_scripts VALUES (2748, 0, 5, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Archaedas - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (2748, 0, 6, 0, 5, 0, 100, 0, 5000, 5000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Archaedas - On Kill - Say Line 3');
INSERT INTO smart_scripts VALUES (2748, 0, 7, 8, 2, 0, 100, 1, 0, 70, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Archaedas - Health Between 0-70% - Say Line 1');
INSERT INTO smart_scripts VALUES (2748, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 10252, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Archaedas - Health Between 0-70% - Cast Awaken Earthen Guardian');
INSERT INTO smart_scripts VALUES (2748, 0, 9, 10, 2, 0, 100, 1, 0, 40, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Archaedas - Health Between 0-40% - Say Line 2');
INSERT INTO smart_scripts VALUES (2748, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 10258, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Archaedas - Health Between 0-40% - Cast Awaken Vault Warder');
INSERT INTO smart_scripts VALUES (2748, 0, 11, 0, 0, 0, 100, 0, 10000, 10000, 10000, 10000, 11, 10259, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Archaedas - In Combat - Awaken Earthen Dwarf');
INSERT INTO smart_scripts VALUES (2748, 0, 12, 0, 0, 0, 100, 0, 0, 10000, 14000, 20000, 11, 6524, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Archaedas - In Combat - Cast Ground Tremor');
INSERT INTO smart_scripts VALUES (2748, 0, 13, 14, 60, 0, 100, 257, 1000, 1000, 0, 0, 64, 1, 0, 0, 0, 0, 0, 11, 7076, 100, 0, 0, 0, 0, 0, 'Archaedas - On Update - Store Target List (Earthen Guardian)');
INSERT INTO smart_scripts VALUES (2748, 0, 14, 15, 61, 0, 100, 0, 0, 0, 0, 0, 64, 2, 0, 0, 0, 0, 0, 11, 10120, 100, 0, 0, 0, 0, 0, 'Archaedas - On Update - Store Target List (Vault Warder)');
INSERT INTO smart_scripts VALUES (2748, 0, 15, 16, 61, 0, 100, 0, 0, 0, 0, 0, 64, 3, 0, 0, 0, 0, 0, 11, 7077, 100, 0, 0, 0, 0, 0, 'Archaedas - On Update - Store Target List (Earthen Hellshaper)');
INSERT INTO smart_scripts VALUES (2748, 0, 16, 0, 61, 0, 100, 0, 0, 0, 0, 0, 64, 4, 0, 0, 0, 0, 0, 11, 7309, 100, 0, 0, 0, 0, 0, 'Archaedas - On Update - Store Target List (Earthen Custodian)');
INSERT INTO smart_scripts VALUES (2748, 0, 17, 18, 25, 0, 100, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Archaedas - On Reset - Respawn Target');
INSERT INTO smart_scripts VALUES (2748, 0, 18, 19, 61, 0, 100, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 'Archaedas - On Reset - Respawn Target');
INSERT INTO smart_scripts VALUES (2748, 0, 19, 20, 61, 0, 100, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 'Archaedas - On Reset - Respawn Target');
INSERT INTO smart_scripts VALUES (2748, 0, 20, 0, 61, 0, 100, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 12, 4, 0, 0, 0, 0, 0, 0, 'Archaedas - On Reset - Respawn Target');
INSERT INTO smart_scripts VALUES (2748, 0, 21, 0, 21, 0, 100, 0, 0, 0, 0, 0, 34, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Archaedas - Just Reached Home - Set Instance Data');
INSERT INTO smart_scripts VALUES (2748, 0, 22, 23, 6, 0, 100, 0, 0, 0, 0, 0, 34, 2, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Archaedas - On Death - Set Instance Data');
INSERT INTO smart_scripts VALUES (2748, 0, 23, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 10604, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Archaedas - On Death - Cast Destroy Earthen Guards');
INSERT INTO smart_scripts VALUES (2748, 0, 24, 0, 31, 0, 100, 0, 10604, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Archaedas - Spell Hit Target - Despawn');

-- SPELL Destroy Earthen Guards (10604)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=10604;
INSERT INTO conditions VALUES(13, 1, 10604, 0, 0, 31, 0, 3, 7076, 0, 0, 0, 0, '', 'Target Earthen Guardian');
INSERT INTO conditions VALUES(13, 1, 10604, 0, 1, 31, 0, 3, 10120, 0, 0, 0, 0, '', 'Target Vault Warder');
INSERT INTO conditions VALUES(13, 1, 10604, 0, 2, 31, 0, 3, 7077, 0, 0, 0, 0, '', 'Target Earthen Hallshaper');
INSERT INTO conditions VALUES(13, 1, 10604, 0, 3, 31, 0, 3, 7309, 0, 0, 0, 0, '', 'Target Earthen Custodian');

-- SPELL Uldaman Boss Agro (10340)
DELETE FROM spell_script_names WHERE spell_id=10340;
INSERT INTO spell_script_names VALUES(10340, 'spell_uldaman_boss_agro_archaedas');

-- Earthen Guardian (7076)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7076;
DELETE FROM smart_scripts WHERE entryorguid=7076 AND source_type=0;
INSERT INTO smart_scripts VALUES (7076, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 10255, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthen Guardian - On Reset - Cast Stoned');
INSERT INTO smart_scripts VALUES (7076, 0, 1, 2, 8, 0, 100, 0, 10252, 0, 0, 0, 11, 10254, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthen Guardian - On Spell Hit - Cast Stone Dwarf Awaken Visual');
INSERT INTO smart_scripts VALUES (7076, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 4000, 4000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthen Guardian - On Spell Hit - Create Timed Event');
INSERT INTO smart_scripts VALUES (7076, 0, 3, 4, 59, 0, 100, 0, 1, 0, 0, 0, 28, 10255, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthen Guardian - On Timed Event - Remove Aura Stoned');
INSERT INTO smart_scripts VALUES (7076, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthen Guardian - On Timed Event - Set In Combat With Zone');
INSERT INTO smart_scripts VALUES (7076, 0, 5, 0, 0, 0, 100, 0, 3000, 7000, 9000, 14000, 11, 17207, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthen Guardian - In Combat - Cast Whirlwind');

-- SPELL Awaken Earthen Guardian (10252)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=10252;
INSERT INTO conditions VALUES(13, 1, 10252, 0, 0, 31, 0, 3, 7076, 0, 0, 0, 0, '', 'Target Earthen Guardian');

-- Vault Warder (10120)
UPDATE creature_template SET faction=470, AIName='SmartAI', ScriptName='' WHERE entry=10120;
DELETE FROM smart_scripts WHERE entryorguid=10120 AND source_type=0;
INSERT INTO smart_scripts VALUES (10120, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 10255, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vault Warder - On Reset - Cast Stoned');
INSERT INTO smart_scripts VALUES (10120, 0, 1, 2, 8, 0, 100, 0, 10258, 0, 0, 0, 11, 10254, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vault Warder - On Spell Hit - Cast Stone Dwarf Awaken Visual');
INSERT INTO smart_scripts VALUES (10120, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 4000, 4000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Vault Warder - On Spell Hit - Create Timed Event');
INSERT INTO smart_scripts VALUES (10120, 0, 3, 4, 59, 0, 100, 0, 1, 0, 0, 0, 28, 10255, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vault Warder - On Timed Event - Remove Aura Stoned');
INSERT INTO smart_scripts VALUES (10120, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vault Warder - On Timed Event - Set In Combat With Zone');
INSERT INTO smart_scripts VALUES (10120, 0, 5, 0, 0, 0, 100, 0, 3000, 7000, 6000, 11000, 11, 5568, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Vault Warder - In Combat - Cast Trample');

-- SPELL Awaken Vault Warder (10258)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=10258;
INSERT INTO conditions VALUES(13, 1, 10258, 0, 0, 31, 0, 3, 10120, 0, 0, 0, 0, '', 'Target Vault Warder');

-- Earthen Hallshaper (7077)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7077;
DELETE FROM smart_scripts WHERE entryorguid=7077 AND source_type=0;
INSERT INTO smart_scripts VALUES (7077, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 10255, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthen Hallshaper - On Reset - Cast Stoned');
INSERT INTO smart_scripts VALUES (7077, 0, 1, 2, 8, 0, 100, 0, 10259, 0, 0, 0, 11, 10254, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthen Hallshaper - On Spell Hit - Cast Stone Dwarf Awaken Visual');
INSERT INTO smart_scripts VALUES (7077, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 3000, 3000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthen Hallshaper - On Spell Hit - Create Timed Event');
INSERT INTO smart_scripts VALUES (7077, 0, 3, 4, 59, 0, 100, 0, 1, 0, 0, 0, 28, 10255, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthen Hallshaper - On Timed Event - Remove Aura Stoned');
INSERT INTO smart_scripts VALUES (7077, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthen Hallshaper - On Timed Event - Set In Combat With Zone');
INSERT INTO smart_scripts VALUES (7077, 0, 5, 0, 0, 0, 100, 0, 3000, 7000, 20000, 30000, 11, 10260, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthen Hallshaper - In Combat - Cast Reconstruct');

-- Earthen Custodian (7309)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7309;
DELETE FROM smart_scripts WHERE entryorguid=7309 AND source_type=0;
INSERT INTO smart_scripts VALUES (7309, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 10255, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthen Custodian - On Reset - Cast Stoned');
INSERT INTO smart_scripts VALUES (7309, 0, 1, 2, 8, 0, 100, 0, 10259, 0, 0, 0, 11, 10254, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthen Custodian - On Spell Hit - Cast Stone Dwarf Awaken Visual');
INSERT INTO smart_scripts VALUES (7309, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 3000, 3000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthen Custodian - On Spell Hit - Create Timed Event');
INSERT INTO smart_scripts VALUES (7309, 0, 3, 4, 59, 0, 100, 0, 1, 0, 0, 0, 28, 10255, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthen Custodian - On Timed Event - Remove Aura Stoned');
INSERT INTO smart_scripts VALUES (7309, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthen Custodian - On Timed Event - Set In Combat With Zone');

-- SPELL Awaken Earthen Dwarf (10259)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=10259;
INSERT INTO conditions VALUES(13, 1, 10259, 0, 0, 31, 0, 3, 7077, 0, 0, 0, 0, '', 'Target Earthen Hallshaper');
INSERT INTO conditions VALUES(13, 1, 10259, 0, 0, 1, 0, 10255, 0, 0, 0, 0, 0, '', 'Has Aura Stoned');
INSERT INTO conditions VALUES(13, 1, 10259, 0, 1, 31, 0, 3, 7309, 0, 0, 0, 0, '', 'Target Earthen Custodian');
INSERT INTO conditions VALUES(13, 1, 10259, 0, 1, 1, 0, 10255, 0, 0, 0, 0, 0, '', 'Has Aura Stoned');

-- SPELL Reconstruct (10260)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=10260;
INSERT INTO conditions VALUES(13, 1, 10260, 0, 0, 31, 0, 3, 2748, 0, 0, 0, 0, '', 'Target Archaedas');

-- GO Altar of Archaedas (133234)
UPDATE gameobject_template SET AIName='', ScriptName='' WHERE entry=133234;


-- -------------------------------------------
--                MISC
-- -------------------------------------------

-- GO Keystone (124371)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=124371;
DELETE FROM smart_scripts WHERE entryorguid=124371 AND source_type=1;
INSERT INTO smart_scripts VALUES (124371, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 67, 1, 27000, 27000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Keystone - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (124371, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 104, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Keystone - On Gossip Hello - Set GO Flags');
INSERT INTO smart_scripts VALUES (124371, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 34, 0, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Keystone - On Gossip Hello - Set Instance Data');
INSERT INTO smart_scripts VALUES (124371, 1, 3, 4, 59, 0, 100, 0, 1, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 20, 124372, 100, 0, 0, 0, 0, 0, 'Keystone - On Gossip Hello - Set GO State');
INSERT INTO smart_scripts VALUES (124371, 1, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 19, 7228, 100, 0, 0, 0, 0, 0, 'Keystone - On Gossip Hello - Set In Combat With Zone');

-- AT Uldaman (822)
DELETE FROM areatrigger_scripts WHERE entry=822;
DELETE FROM areatrigger_involvedrelation WHERE id=822;
INSERT INTO areatrigger_involvedrelation VALUES (822, 2240);

-- SPELL Uldaman Sub-Boss Agro (11568)
DELETE FROM spell_script_names WHERE spell_id=11568;
INSERT INTO spell_script_names VALUES(11568, 'spell_uldaman_sub_boss_agro_keepers');

-- Stone Keeper (4857)
DELETE FROM creature_template_addon WHERE entry=4857;
UPDATE creature_template SET faction=59, AIName='SmartAI', ScriptName='' WHERE entry=4857;
DELETE FROM smart_scripts WHERE entryorguid=4857 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(-28368, -27794, -27555, -27554) AND source_type=0;
INSERT INTO smart_scripts VALUES (-28368, 0, 0, 0, 21, 0, 100, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 11, 4857, 100, 0, 0, 0, 0, 0, 'Stone Keeper - Just Reached Home - Respawn');
INSERT INTO smart_scripts VALUES (-28368, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 10255, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stone Keeper - On Reset - Cast Stoned');
INSERT INTO smart_scripts VALUES (-28368, 0, 2, 0, 0, 0, 100, 0, 3000, 7000, 7000, 11000, 11, 5568, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Stone Keeper - In Combat - Cast Trample');
INSERT INTO smart_scripts VALUES (-28368, 0, 3, 4, 6, 0, 100, 0, 0, 0, 0, 0, 11, 9874, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stone Keeper - On Death - Cast Self Destruct');
INSERT INTO smart_scripts VALUES (-28368, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 27794, 4857, 0, 0, 0, 0, 0, 'Stone Keeper - On Death - Set Data');
INSERT INTO smart_scripts VALUES (-28368, 0, 5, 6, 38, 0, 100, 0, 1, 1, 0, 0, 28, 10255, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stone Keeper - On Data Set - Remove Stoned');
INSERT INTO smart_scripts VALUES (-28368, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stone Keeper - On Data Set - Set In Combat With Zone');
INSERT INTO smart_scripts VALUES (-28368, 0, 7, 8, 6, 0, 100, 0, 0, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 20, 124367, 200, 0, 0, 0, 0, 0, 'Stone Keeper - On Death - Set GO State');
INSERT INTO smart_scripts VALUES (-28368, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 34, 1, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stone Keeper - On Death - Set Instance Data');
INSERT INTO smart_scripts VALUES (-27794, 0, 0, 0, 21, 0, 100, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 11, 4857, 100, 0, 0, 0, 0, 0, 'Stone Keeper - Just Reached Home - Respawn');
INSERT INTO smart_scripts VALUES (-27794, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 10255, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stone Keeper - On Reset - Cast Stoned');
INSERT INTO smart_scripts VALUES (-27794, 0, 2, 0, 0, 0, 100, 0, 3000, 7000, 7000, 11000, 11, 5568, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Stone Keeper - In Combat - Cast Trample');
INSERT INTO smart_scripts VALUES (-27794, 0, 3, 4, 6, 0, 100, 0, 0, 0, 0, 0, 11, 9874, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stone Keeper - On Death - Cast Self Destruct');
INSERT INTO smart_scripts VALUES (-27794, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 27555, 4857, 0, 0, 0, 0, 0, 'Stone Keeper - On Death - Set Data');
INSERT INTO smart_scripts VALUES (-27794, 0, 5, 6, 38, 0, 100, 0, 1, 1, 0, 0, 28, 10255, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stone Keeper - On Data Set - Remove Stoned');
INSERT INTO smart_scripts VALUES (-27794, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stone Keeper - On Data Set - Set In Combat With Zone');
INSERT INTO smart_scripts VALUES (-27794, 0, 7, 8, 6, 0, 100, 0, 0, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 20, 124367, 200, 0, 0, 0, 0, 0, 'Stone Keeper - On Death - Set GO State');
INSERT INTO smart_scripts VALUES (-27794, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 34, 1, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stone Keeper - On Death - Set Instance Data');
INSERT INTO smart_scripts VALUES (-27555, 0, 0, 0, 21, 0, 100, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 11, 4857, 100, 0, 0, 0, 0, 0, 'Stone Keeper - Just Reached Home - Respawn');
INSERT INTO smart_scripts VALUES (-27555, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 10255, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stone Keeper - On Reset - Cast Stoned');
INSERT INTO smart_scripts VALUES (-27555, 0, 2, 0, 0, 0, 100, 0, 3000, 7000, 7000, 11000, 11, 5568, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Stone Keeper - In Combat - Cast Trample');
INSERT INTO smart_scripts VALUES (-27555, 0, 3, 4, 6, 0, 100, 0, 0, 0, 0, 0, 11, 9874, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stone Keeper - On Death - Cast Self Destruct');
INSERT INTO smart_scripts VALUES (-27555, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 27554, 4857, 0, 0, 0, 0, 0, 'Stone Keeper - On Death - Set Data');
INSERT INTO smart_scripts VALUES (-27555, 0, 5, 6, 38, 0, 100, 0, 1, 1, 0, 0, 28, 10255, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stone Keeper - On Data Set - Remove Stoned');
INSERT INTO smart_scripts VALUES (-27555, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stone Keeper - On Data Set - Set In Combat With Zone');
INSERT INTO smart_scripts VALUES (-27555, 0, 7, 8, 6, 0, 100, 0, 0, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 20, 124367, 200, 0, 0, 0, 0, 0, 'Stone Keeper - On Death - Set GO State');
INSERT INTO smart_scripts VALUES (-27555, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 34, 1, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stone Keeper - On Death - Set Instance Data');
INSERT INTO smart_scripts VALUES (-27554, 0, 0, 0, 21, 0, 100, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 11, 4857, 100, 0, 0, 0, 0, 0, 'Stone Keeper - Just Reached Home - Respawn');
INSERT INTO smart_scripts VALUES (-27554, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 10255, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stone Keeper - On Reset - Cast Stoned');
INSERT INTO smart_scripts VALUES (-27554, 0, 2, 0, 0, 0, 100, 0, 3000, 7000, 7000, 11000, 11, 5568, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Stone Keeper - In Combat - Cast Trample');
INSERT INTO smart_scripts VALUES (-27554, 0, 3, 4, 6, 0, 100, 0, 0, 0, 0, 0, 11, 9874, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stone Keeper - On Death - Cast Self Destruct');
INSERT INTO smart_scripts VALUES (-27554, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 28368, 4857, 0, 0, 0, 0, 0, 'Stone Keeper - On Death - Set Data');
INSERT INTO smart_scripts VALUES (-27554, 0, 5, 6, 38, 0, 100, 0, 1, 1, 0, 0, 28, 10255, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stone Keeper - On Data Set - Remove Stoned');
INSERT INTO smart_scripts VALUES (-27554, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stone Keeper - On Data Set - Set In Combat With Zone');
INSERT INTO smart_scripts VALUES (-27554, 0, 7, 8, 6, 0, 100, 0, 0, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 20, 124367, 200, 0, 0, 0, 0, 0, 'Stone Keeper - On Death - Set GO State');
INSERT INTO smart_scripts VALUES (-27554, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 34, 1, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stone Keeper - On Death - Set Instance Data');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry IN(-28368, -27794, -27555, -27554);
INSERT INTO conditions VALUES(22, 8, -28368, 0, 0, 29, 1, 4857, 100, 0, 1, 0, 0, '', 'Run Action if no alive Stone Keepers in range');
INSERT INTO conditions VALUES(22, 8, -27794, 0, 0, 29, 1, 4857, 100, 0, 1, 0, 0, '', 'Run Action if no alive Stone Keepers in range');
INSERT INTO conditions VALUES(22, 8, -27555, 0, 0, 29, 1, 4857, 100, 0, 1, 0, 0, '', 'Run Action if no alive Stone Keepers in range');
INSERT INTO conditions VALUES(22, 8, -27554, 0, 0, 29, 1, 4857, 100, 0, 1, 0, 0, '', 'Run Action if no alive Stone Keepers in range');
INSERT INTO conditions VALUES(22, 1, -28368, 0, 0, 36, 1, 0, 0, 0, 0, 0, 0, '', 'Run Action if keeper is alive');
INSERT INTO conditions VALUES(22, 1, -27794, 0, 0, 36, 1, 0, 0, 0, 0, 0, 0, '', 'Run Action if keeper is alive');
INSERT INTO conditions VALUES(22, 1, -27555, 0, 0, 36, 1, 0, 0, 0, 0, 0, 0, '', 'Run Action if keeper is alive');
INSERT INTO conditions VALUES(22, 1, -27554, 0, 0, 36, 1, 0, 0, 0, 0, 0, 0, '', 'Run Action if keeper is alive');

-- SPELL Stoned (10255)
DELETE FROM spell_script_names WHERE spell_id=10255;
INSERT INTO spell_script_names VALUES(10255, 'spell_uldaman_stoned');

-- Quest The Platinum Discs (2279)
UPDATE quest_template SET PrevQuestId=2278 WHERE Id=2279;

-- GO Ancient Chest (141979)
DELETE FROM gameobject WHERE id=141979;
INSERT INTO gameobject VALUES (NULL, 141979, 70, 1, 1, 154.952, 290.27, -52.226, 2.78, 0, 0, 0, 0, 86400, 0, 1, 0);

-- Lore Keeper of Norgannon (7172)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=7172);
DELETE FROM creature WHERE id=7172;
DELETE FROM creature_text WHERE entry=7172;
INSERT INTO creature_text VALUES (7172, 0, 0, 'Greetings, mortals! I have been activated by the Discs of Norgannon to assist you!', 14, 0, 100, 0, 0, 0, 0, 'Lore Keeper of Norgannon');
INSERT INTO creature_text VALUES (7172, 1, 0, 'Your discs are now ready! Engage the Discs of Norgannon once again to retrieve them!', 14, 0, 100, 0, 0, 0, 0, 'Lore Keeper of Norgannon');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7172;
DELETE FROM smart_scripts WHERE entryorguid=7172 AND source_type=0;
INSERT INTO smart_scripts VALUES (7172, 0, 0, 12, 37, 0, 100, 257, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On AI Init - Say Line 0');
INSERT INTO smart_scripts VALUES (7172, 0, 1, 2, 62, 0, 100, 0, 576, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On Gossip Option 0 Selected - Close Gossip');
INSERT INTO smart_scripts VALUES (7172, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 26, 2278, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On Gossip Option 0 Selected - Quest Credit The Platinum Discs');
INSERT INTO smart_scripts VALUES (7172, 0, 3, 0, 62, 0, 100, 257, 576, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On Gossip Option 0 Selected - Say Line 1');
INSERT INTO smart_scripts VALUES (7172, 0, 4, 5, 62, 0, 100, 0, 567, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 20, 142488, 30, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On Gossip Option 0 Selected - Set GO State');
INSERT INTO smart_scripts VALUES (7172, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 20000, 20000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On Gossip Option 0 Selected - Create Timed Event');
INSERT INTO smart_scripts VALUES (7172, 0, 6, 0, 59, 0, 100, 0, 1, 0, 0, 0, 131, 1, 0, 0, 0, 0, 0, 20, 142488, 30, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On Timed Event - Set GO State');
INSERT INTO smart_scripts VALUES (7172, 0, 7, 0, 62, 0, 100, 0, 568, 0, 0, 0, 131, 1, 0, 0, 0, 0, 0, 20, 142488, 30, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On Gossip Option 0 Selected - Set GO State');
INSERT INTO smart_scripts VALUES (7172, 0, 8, 9, 62, 0, 100, 0, 569, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 20, 170353, 30, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On Gossip Option 0 Selected - Set GO State');
INSERT INTO smart_scripts VALUES (7172, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 2, 20000, 20000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On Gossip Option 0 Selected - Create Timed Event');
INSERT INTO smart_scripts VALUES (7172, 0, 10, 0, 59, 0, 100, 0, 2, 0, 0, 0, 131, 1, 0, 0, 0, 0, 0, 20, 170353, 30, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On Timed Event - Set GO State');
INSERT INTO smart_scripts VALUES (7172, 0, 11, 0, 62, 0, 100, 0, 570, 0, 0, 0, 131, 1, 0, 0, 0, 0, 0, 20, 170353, 30, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On Gossip Option 0 Selected - Set GO State');
INSERT INTO smart_scripts VALUES (7172, 0, 12, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 11012, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On AI Init - Cast Stone Watcher of Norgannon Spawn');

-- GO The Discs of Norgannon (131474)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=131474;
DELETE FROM smart_scripts WHERE entryorguid=131474 AND source_type=1;
INSERT INTO smart_scripts VALUES (131474, 1, 0, 0, 19, 0, 100, 257, 2278, 0, 0, 0, 12, 7172, 8, 0, 0, 0, 0, 8, 0, 0, 0, 148.65, 310.073, -52.19, 5.124, 'The Discs of Norgannon - On Quest Accept - Summon Creature');

-- SPELL Stone Watcher of Norgannon Spawn (11012)
DELETE FROM spell_target_position WHERE id=11012;
INSERT INTO spell_target_position VALUES (11012, 1, 70, 148.65, 310.073, -52.19, 5.124);
