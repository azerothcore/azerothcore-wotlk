
-- Ar'tor, Son of Oronok (21292)
REPLACE INTO creature_template_addon VALUES (21292, 0, 0, 0, 4097, 383, '');

-- Nethermine Burster (23285)
UPDATE creature_template SET flags_extra=0x200000, AIName='SmartAI', ScriptName='' WHERE entry=23285;
DELETE FROM smart_scripts WHERE entryorguid=23285 AND source_type=0;
INSERT INTO smart_scripts VALUES (23285, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 18, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nethermine Burster - On Reset - Set Unit Flag');
INSERT INTO smart_scripts VALUES (23285, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 19, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nethermine Burster - On Reset - Remove Unit Flag');
INSERT INTO smart_scripts VALUES (23285, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 11, 29147, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nethermine Burster - On Reset - Cast Tunnel Bore Passive');
INSERT INTO smart_scripts VALUES (23285, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 90, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nethermine Burster - On Reset - Set Bytes0');
INSERT INTO smart_scripts VALUES (23285, 0, 4, 5, 4, 0, 100, 0, 0, 0, 0, 0, 19, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nethermine Burster - On Aggro - Remove Unit Flag');
INSERT INTO smart_scripts VALUES (23285, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 18, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nethermine Burster - On Aggro - Set Unit Flag');
INSERT INTO smart_scripts VALUES (23285, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 28, 29147, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nethermine Burster - On Aggro - Remove Aura Tunnel Bore Passive');
INSERT INTO smart_scripts VALUES (23285, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 147, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nethermine Burster - On Aggro - Stop Motion');
INSERT INTO smart_scripts VALUES (23285, 0, 8, 0, 0, 0, 100, 1, 100, 100, 0, 0, 91, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nethermine Burster - In Combat - Remove Bytes0');
INSERT INTO smart_scripts VALUES (23285, 0, 9, 0, 0, 0, 100, 0, 1000, 6000, 8000, 11000, 11, 32738, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Nethermine Burster - In Combat - Cast Bore');
INSERT INTO smart_scripts VALUES (23285, 0, 10, 0, 9, 0, 100, 0, 4, 50, 2000, 3500, 11, 31747, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Nethermine Burster - Within Range 5-50yd - Cast Poison');

-- Kraator (18696)
UPDATE creature_template SET flags_extra=0x200000, AIName='SmartAI', ScriptName='' WHERE entry=18696;
DELETE FROM smart_scripts WHERE entryorguid=18696 AND source_type=0;
INSERT INTO smart_scripts VALUES (18696, 0, 0, 0, 0, 0, 100, 0, 1000, 9000, 10000, 18000, 11, 39293, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Kraator - In Combat - Cast Conflagration');
INSERT INTO smart_scripts VALUES (18696, 0, 1, 0, 0, 0, 100, 0, 0, 0, 20000, 40000, 11, 24670, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kraator - In Combat - Cast Inferno');

-- Infernal (22203)
UPDATE creature_template SET minlevel=68, maxlevel=69, exp=1, AIName='SmartAI', ScriptName='' WHERE entry=22203;
DELETE FROM smart_scripts WHERE entryorguid=22203 AND source_type=0;
INSERT INTO smart_scripts VALUES (22203, 0, 0, 0, 1, 0, 100, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Infernal - Out of Combat - Attack Start');

-- Uvuros (21102)
UPDATE creature_template SET flags_extra=0x200000, AIName='SmartAI', ScriptName='' WHERE entry=21102;
DELETE FROM smart_scripts WHERE entryorguid=21102 AND source_type=0;
INSERT INTO smart_scripts VALUES (21102, 0, 0, 0, 0, 0, 100, 0, 6000, 12000, 14000, 24000, 11, 38361, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Uvuros - In Combat - Cast Double Breath');
INSERT INTO smart_scripts VALUES (21102, 0, 1, 0, 0, 0, 100, 0, 3000, 15000, 20000, 40000, 11, 37939, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Uvuros - In Combat - Cast Terrifying Roar');

-- Ambassador Jerrikar <Servant of Illidan> (18695)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=18695;
DELETE FROM smart_scripts WHERE entryorguid=18695 AND source_type=0;
INSERT INTO smart_scripts VALUES (18695, 0, 0, 0, 0, 0, 100, 0, 4000, 8000, 7000, 11000, 11, 38926, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ambassador Jerrikar - In Combat - Cast Dark Strike');
INSERT INTO smart_scripts VALUES (18695, 0, 1, 0, 0, 0, 100, 0, 3000, 15000, 20000, 40000, 11, 38916, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ambassador Jerrikar - In Combat - Cast Diplomatic Immunity');
INSERT INTO smart_scripts VALUES (18695, 0, 2, 0, 0, 0, 100, 0, 3000, 15000, 14000, 25000, 11, 38913, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Ambassador Jerrikar - In Combat - Cast Silence');

-- Felspine the Greater (21897)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=21897;
DELETE FROM smart_scripts WHERE entryorguid=21897 AND source_type=0;
INSERT INTO smart_scripts VALUES (21897, 0, 0, 0, 0, 0, 100, 0, 6000, 12000, 10000, 17000, 11, 38356, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Felspine the Greater - In Combat - Cast Fel Flames');
INSERT INTO smart_scripts VALUES (21897, 0, 1, 0, 0, 0, 100, 0, 3000, 15000, 20000, 40000, 11, 37941, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Felspine the Greater - In Combat - Cast Flaming Wounds');

