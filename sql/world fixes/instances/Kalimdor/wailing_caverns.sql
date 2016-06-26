
UPDATE creature SET spawntimesecs=86400 WHERE map=43 AND spawntimesecs>0;
UPDATE gameobject SET spawntimesecs=86400 WHERE map=43 AND spawntimesecs>0;

-- -------------------------------------------
--               FORMATIONS
-- -------------------------------------------


-- -------------------------------------------
--                TRASH
-- -------------------------------------------

-- Deviate Guardian (3637)
DELETE FROM creature_text WHERE entry=3637;
INSERT INTO creature_text VALUES (3637, 0, 0, '%s lets out a shriek, calling for help!', 16, 0, 100, 0, 0, 0, 0, 'Deviate Guardian');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3637;
DELETE FROM smart_scripts WHERE entryorguid=3637 AND source_type=0;
INSERT INTO smart_scripts VALUES (3637, 0, 0, 1, 2, 0, 100, 1, 0, 15, 0, 0, 25, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deviate Guardian - Between 0-15% Health - Flee For Assist');
INSERT INTO smart_scripts VALUES (3637, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deviate Guardian - Between 0-15% Health - Say Line 0');

-- Deviate Ravager (3636)
REPLACE INTO creature_template_addon VALUES (3636, 0, 0, 0, 4097, 0, '3417');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3636;
DELETE FROM smart_scripts WHERE entryorguid=3636 AND source_type=0;
INSERT INTO smart_scripts VALUES (3636, 0, 0, 0, 54, 0, 100, 257, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deviate Ravager - Just Summoned - Set In Combat With Zone');

-- Evolving Ectoplasm (3640)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3640;
DELETE FROM smart_scripts WHERE entryorguid=3640 AND source_type=0;
INSERT INTO smart_scripts VALUES (3640, 0, 0, 0, 60, 0, 100, 0, 0, 0, 15000, 20000, 140, 1, 4, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Evolving Ectoplasm - On Update - Run Random Timed Event');
INSERT INTO smart_scripts VALUES (3640, 0, 1, 0, 59, 0, 100, 0, 1, 0, 0, 0, 11, 7946, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Evolving Ectoplasm - On Timed Event - Cast Evolving Ectoplasm (Black)');
INSERT INTO smart_scripts VALUES (3640, 0, 2, 0, 59, 0, 100, 0, 2, 0, 0, 0, 11, 7944, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Evolving Ectoplasm - On Timed Event - Cast Evolving Ectoplasm (Blue)');
INSERT INTO smart_scripts VALUES (3640, 0, 3, 0, 59, 0, 100, 0, 3, 0, 0, 0, 11, 7945, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Evolving Ectoplasm - On Timed Event - Cast Evolving Ectoplasm (Green)');
INSERT INTO smart_scripts VALUES (3640, 0, 4, 0, 59, 0, 100, 0, 4, 0, 0, 0, 11, 7943, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Evolving Ectoplasm - On Timed Event - Cast Evolving Ectoplasm (Red)');

-- SPELL Evolving Ectoplasm (Black) (7946)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(7946, -7946);
INSERT INTO spell_linked_spell VALUES (7946, 7743, 2, 'Evolving Ectoplasm (Black) - trigger Shadow Immunity');
INSERT INTO spell_linked_spell VALUES (7946, -7944, 1, 'Evolving Ectoplasm (Black) - Remove Evolving Ectoplasm Blue');
INSERT INTO spell_linked_spell VALUES (7946, -7945, 1, 'Evolving Ectoplasm (Black) - Remove Evolving Ectoplasm Green');
INSERT INTO spell_linked_spell VALUES (7946, -7943, 1, 'Evolving Ectoplasm (Black) - Remove Evolving Ectoplasm Red');

-- SPELL Evolving Ectoplasm (Blue) (7944)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(7944, -7944);
INSERT INTO spell_linked_spell VALUES (7944, 7940, 2, 'Evolving Ectoplasm (Blue) - trigger Frost Immunity');
INSERT INTO spell_linked_spell VALUES (7944, -7946, 1, 'Evolving Ectoplasm (Blue) - Remove Evolving Ectoplasm Black');
INSERT INTO spell_linked_spell VALUES (7944, -7945, 1, 'Evolving Ectoplasm (Blue) - Remove Evolving Ectoplasm Green');
INSERT INTO spell_linked_spell VALUES (7944, -7943, 1, 'Evolving Ectoplasm (Blue) - Remove Evolving Ectoplasm Red');

-- SPELL Evolving Ectoplasm (Green) (7945)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(7945, -7945);
INSERT INTO spell_linked_spell VALUES (7945, 7941, 2, 'Evolving Ectoplasm (Green) - trigger Nature Immunity');
INSERT INTO spell_linked_spell VALUES (7945, -7946, 1, 'Evolving Ectoplasm (Green) - Remove Evolving Ectoplasm Black');
INSERT INTO spell_linked_spell VALUES (7945, -7944, 1, 'Evolving Ectoplasm (Green) - Remove Evolving Ectoplasm Blue');
INSERT INTO spell_linked_spell VALUES (7945, -7943, 1, 'Evolving Ectoplasm (Green) - Remove Evolving Ectoplasm Red');

-- SPELL Evolving Ectoplasm (Red) (7943)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(7943, -7943);
INSERT INTO spell_linked_spell VALUES (7943, 7942, 2, 'Evolving Ectoplasm (Red) - trigger Fire Immunity');
INSERT INTO spell_linked_spell VALUES (7943, -7946, 1, 'Evolving Ectoplasm (Green) - Remove Evolving Ectoplasm Black');
INSERT INTO spell_linked_spell VALUES (7943, -7944, 1, 'Evolving Ectoplasm (Green) - Remove Evolving Ectoplasm Blue');
INSERT INTO spell_linked_spell VALUES (7943, -7945, 1, 'Evolving Ectoplasm (Green) - Remove Evolving Ectoplasm Green');

-- Druid of the Fang (3840)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3840;
DELETE FROM smart_scripts WHERE entryorguid=3840 AND source_type=0;
INSERT INTO smart_scripts VALUES (3840, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2400, 3800, 11, 9532, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Druid of the Fang - In Combat - Cast Lightning Bolt');
INSERT INTO smart_scripts VALUES (3840, 0, 1, 0, 0, 0, 100, 0, 8000, 11000, 10000, 20000, 11, 8040, 32, 0, 0, 0, 0, 6, 30, 0, 0, 0, 0, 0, 0, 'Druid of the Fang - In Combat - Cast Druid''s Slumber');
INSERT INTO smart_scripts VALUES (3840, 0, 2, 0, 14, 0, 100, 0, 400, 40, 12000, 18000, 11, 5187, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Druid of the Fang - Friendly Missing Health - Cast Healing Touch');
INSERT INTO smart_scripts VALUES (3840, 0, 3, 4, 2, 0, 100, 1, 0, 30, 20000, 25000, 11, 8041, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Druid of the Fang - Between 0-30% Health - Cast Serpent Form');
INSERT INTO smart_scripts VALUES (3840, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 135, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Druid of the Fang - Between 0-30% Health - Set Caster Dist');
INSERT INTO smart_scripts VALUES (3840, 0, 5, 6, 1, 0, 100, 0, 5000, 60000, 60000, 90000, 11, 13236, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Druid of the Fang - Out of Combat - Cast Nature Channeling');
INSERT INTO smart_scripts VALUES (3840, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 6000, 30000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Druid of the Fang - Out of Combat - Create Timed Event');
INSERT INTO smart_scripts VALUES (3840, 0, 7, 0, 59, 0, 100, 0, 1, 0, 0, 0, 28, 13236, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Druid of the Fang - Timed Event - Remove Aura Nature Channeling');

-- Deviate Crocolisk (5053)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=5053;
DELETE FROM smart_scripts WHERE entryorguid=5053 AND source_type=0;
INSERT INTO smart_scripts VALUES (5053, 0, 0, 0, 0, 0, 100, 0, 4000, 7000, 10000, 12000, 11, 3604, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Deviate Crocolisk - In Combat - Cast Tendon Rip');

-- Deviate Adder (5048)
REPLACE INTO creature_template_addon VALUES (5048, 0, 0, 0, 4097, 0, '3616');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=5048;
DELETE FROM smart_scripts WHERE entryorguid=5048 AND source_type=0;
INSERT INTO smart_scripts VALUES (5048, 0, 0, 0, 54, 0, 100, 257, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deviate Adder - Just Summoned - Set In Combat With Zone');

-- Deviate Viper (5755)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=5755;
DELETE FROM smart_scripts WHERE entryorguid=5755 AND source_type=0;
INSERT INTO smart_scripts VALUES (5755, 0, 0, 0, 0, 0, 100, 0, 4000, 7000, 12000, 15000, 11, 7947, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Deviate Viper - In Combat - Cast Localized Toxin');
INSERT INTO smart_scripts VALUES (5755, 0, 1, 0, 54, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deviate Viper - Is Summoned - Set In Combat With Zone');

-- Deviate Python (8886)
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=8886;
DELETE FROM smart_scripts WHERE entryorguid=8886 AND source_type=0;

-- Deviate Shambler (5761)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=5761;
DELETE FROM smart_scripts WHERE entryorguid=5761 AND source_type=0;
INSERT INTO smart_scripts VALUES (5761, 0, 0, 0, 2, 0, 100, 0, 0, 70, 15000, 21000, 11, 7948, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Deviate Shambler - Between 0-70% Health - Cast Wild Regeneration');

-- Deviate Lasher (5055)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=5055;
DELETE FROM smart_scripts WHERE entryorguid=5055 AND source_type=0;
INSERT INTO smart_scripts VALUES (5055, 0, 0, 0, 0, 0, 100, 0, 4000, 7000, 9000, 12000, 11, 7342, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Deviate Lasher - In Combat - Cast Wide Slash');

-- Deviate Dreadfang (5056)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=5056;
DELETE FROM smart_scripts WHERE entryorguid=5056 AND source_type=0;
INSERT INTO smart_scripts VALUES (5056, 0, 0, 0, 0, 0, 100, 0, 3000, 9000, 15000, 22000, 11, 7399, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Deviate Dreadfang - In Combat - Cast Terrify');

-- Deviate Venomwing (5756)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=5756;
DELETE FROM smart_scripts WHERE entryorguid=5756 AND source_type=0;
INSERT INTO smart_scripts VALUES (5756, 0, 0, 0, 0, 0, 100, 0, 3000, 8000, 7000, 12000, 11, 7951, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Deviate Venomwing - In Combat - Cast Toxic Spit');


-- -------------------------------------------
--                BOSSES
-- -------------------------------------------

-- Lady Anacondra <Fanglord> (3671)
DELETE FROM creature_text WHERE entry=3671;
INSERT INTO creature_text VALUES (3671, 0, 0, 'None can stand against the Serpent Lords!', 14, 0, 100, 0, 0, 5786, 0, 'Lady Anacondra');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3671;
DELETE FROM smart_scripts WHERE entryorguid=3671 AND source_type=0;
INSERT INTO smart_scripts VALUES (3671, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lady Anacondra - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (3671, 0, 1, 0, 0, 0, 100, 0, 0, 0, 2400, 3800, 11, 9532, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lady Anacondra - In Combat - Cast Lightning Bolt');
INSERT INTO smart_scripts VALUES (3671, 0, 2, 0, 0, 0, 100, 0, 8000, 11000, 10000, 20000, 11, 8040, 32, 0, 0, 0, 0, 6, 30, 0, 0, 0, 0, 0, 0, 'Lady Anacondra - In Combat - Cast Druid''s Slumber');
INSERT INTO smart_scripts VALUES (3671, 0, 3, 0, 14, 0, 100, 0, 400, 40, 12000, 18000, 11, 5187, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Lady Anacondra - Friendly Missing Health - Cast Healing Touch');
INSERT INTO smart_scripts VALUES (3671, 0, 4, 0, 0, 0, 100, 0, 1000, 3000, 40000, 40000, 11, 8148, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lady Anacondra - In Combat - Cast Thorns');
INSERT INTO smart_scripts VALUES (3671, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 34, 2, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lady Anacondra - On Just Died - Set Instance Data 2 to 3');

-- Lord Cobrahn <Fanglord> (3669)
DELETE FROM creature_text WHERE entry=3669;
INSERT INTO creature_text VALUES (3669, 0, 0, 'You will never wake the dreamer!', 14, 0, 100, 0, 0, 5785, 0, 'Lord Cobrahn');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3669;
DELETE FROM smart_scripts WHERE entryorguid=3669 AND source_type=0;
INSERT INTO smart_scripts VALUES (3669, 0, 0, 1, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lord Cobrahn - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (3669, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lord Cobrahn - On Aggro - Set Event Phase 1');
INSERT INTO smart_scripts VALUES (3669, 0, 2, 0, 0, 1, 100, 0, 0, 0, 2400, 3800, 11, 9532, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lord Cobrahn - In Combat - Cast Lightning Bolt');
INSERT INTO smart_scripts VALUES (3669, 0, 3, 0, 0, 1, 100, 0, 8000, 11000, 10000, 20000, 11, 8040, 32, 0, 0, 0, 0, 6, 30, 0, 0, 0, 0, 0, 0, 'Lord Cobrahn - In Combat - Cast Druid''s Slumber');
INSERT INTO smart_scripts VALUES (3669, 0, 4, 0, 14, 1, 100, 0, 400, 40, 12000, 18000, 11, 5187, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Lord Cobrahn - Friendly Missing Health - Cast Healing Touch');
INSERT INTO smart_scripts VALUES (3669, 0, 5, 6, 2, 0, 100, 1, 0, 30, 0, 0, 11, 7965, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lord Cobrahn - Health Between 0-30% - Cast Cobrahn Serpent Form');
INSERT INTO smart_scripts VALUES (3669, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 135, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lord Cobrahn - Between 0-30% Health - Set Caster Dist');
INSERT INTO smart_scripts VALUES (3669, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 3616, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lord Cobrahn - Between 0-30% Health - Cast Poison Proc');
INSERT INTO smart_scripts VALUES (3669, 0, 8, 0, 6, 0, 100, 0, 0, 0, 0, 0, 34, 0, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lord Cobrahn - On Just Died - Set Instance Data 0 to 3');

-- Lord Serpentis <Fanglord> (3673)
DELETE FROM creature_text WHERE entry=3673;
INSERT INTO creature_text VALUES (3673, 0, 0, 'Intruders have assaulted our lair. Be on your guard!', 14, 0, 100, 0, 0, 0, 3, 'Lord Serpentis');
INSERT INTO creature_text VALUES (3673, 1, 0, 'I am the serpent king! I can do anything!', 14, 0, 100, 0, 0, 5788, 0, 'Lord Serpentis');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3673;
DELETE FROM smart_scripts WHERE entryorguid=3673 AND source_type=0;
INSERT INTO smart_scripts VALUES (3673, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lord Serpentis - On Aggro - Say Line 1');
INSERT INTO smart_scripts VALUES (3673, 0, 1, 0, 0, 0, 100, 0, 0, 0, 2400, 3800, 11, 9532, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lord Serpentis - In Combat - Cast Lightning Bolt');
INSERT INTO smart_scripts VALUES (3673, 0, 2, 0, 0, 0, 100, 0, 8000, 11000, 10000, 20000, 11, 8040, 32, 0, 0, 0, 0, 6, 30, 0, 0, 0, 0, 0, 0, 'Lord Serpentis - In Combat - Cast Druid''s Slumber');
INSERT INTO smart_scripts VALUES (3673, 0, 3, 0, 14, 0, 100, 0, 600, 40, 12000, 18000, 11, 6778, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Lord Serpentis - Friendly Missing Health - Cast Healing Touch');
INSERT INTO smart_scripts VALUES (3673, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 34, 3, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lord Serpentis - On Just Died - Set Instance Data 3 to 3');

-- Lord Pythas <Fanglord> (3670)
DELETE FROM creature_text WHERE entry=3670;
INSERT INTO creature_text VALUES (3670, 0, 0, 'The coils of death will crush you!', 14, 0, 100, 0, 0, 5787, 0, 'Lord Pythas');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3670;
DELETE FROM smart_scripts WHERE entryorguid=3670 AND source_type=0;
INSERT INTO smart_scripts VALUES (3670, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lord Pythas - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (3670, 0, 1, 0, 0, 0, 100, 0, 0, 0, 2400, 3800, 11, 9532, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lord Pythas - In Combat - Cast Lightning Bolt');
INSERT INTO smart_scripts VALUES (3670, 0, 2, 0, 0, 0, 100, 0, 8000, 11000, 10000, 20000, 11, 8040, 32, 0, 0, 0, 0, 6, 30, 0, 0, 0, 0, 0, 0, 'Lord Pythas - In Combat - Cast Druid''s Slumber');
INSERT INTO smart_scripts VALUES (3670, 0, 3, 0, 14, 0, 100, 0, 400, 40, 12000, 18000, 11, 5187, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Lord Pythas - Friendly Missing Health - Cast Healing Touch');
INSERT INTO smart_scripts VALUES (3670, 0, 4, 0, 0, 0, 100, 0, 6000, 9000, 20000, 25000, 11, 8147, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lord Pythas - In Combat - Cast Thunder Clap');
INSERT INTO smart_scripts VALUES (3670, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 34, 1, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lord Pythas - On Just Died - Set Instance Data 1 to 3');

-- Kresh (3653)
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=3653;
DELETE FROM smart_scripts WHERE entryorguid=3653 AND source_type=0;

-- Skum (3674)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3674;
DELETE FROM smart_scripts WHERE entryorguid=3674 AND source_type=0;
INSERT INTO smart_scripts VALUES (3674, 0, 0, 0, 0, 0, 100, 0, 1000, 2000, 4000, 8000, 11, 6254, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Skum - In Combat - Cast Chained Bolt');

-- Deviate Faerie Dragon (5912)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=5912;
DELETE FROM smart_scripts WHERE entryorguid=5912 AND source_type=0;
INSERT INTO smart_scripts VALUES (5912, 0, 0, 0, 37, 0, 85, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deviate Faerie Dragon - On AI Init - Despawn');

-- Verdan the Everliving (5775)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=5775;
DELETE FROM smart_scripts WHERE entryorguid=5775 AND source_type=0;
INSERT INTO smart_scripts VALUES (5775, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 10000, 13000, 11, 8142, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Verdan the Everliving - In Combat - Cast Grasping Vines');



-- -------------------------------------------
--                MISC
-- -------------------------------------------

-- Disciple of Naralex (3678)
UPDATE creature SET spawntimesecs=300 WHERE id=3678;
DELETE FROM creature_text WHERE entry=3678;
INSERT INTO creature_text VALUES (3678, 0, 0, 'At last! Naralex can be awakened! Come aid me, brave adventurers!', 14, 0, 100, 0, 0, 0, 0, 'disciple SAY_AT_LAST');
INSERT INTO creature_text VALUES (3678, 1, 0, 'I must make the necessary preparations before the awakening ritual can begin. You must protect me!', 12, 0, 100, 1, 0, 0, 0, 'disciple SAY_MAKE_PREPARATIONS');
INSERT INTO creature_text VALUES (3678, 2, 0, 'These caverns were once a temple of promise for regrowth in the Barrens. Now, they are the halls of nightmares.', 12, 0, 100, 1, 0, 0, 0, 'disciple SAY_TEMPLE_OF_PROMISE');
INSERT INTO creature_text VALUES (3678, 3, 0, 'Come. We must continue. There is much to be done before we can pull Naralex from his nightmare.', 12, 0, 100, 0, 0, 0, 0, 'disciple SAY_MUST_CONTINUE');
INSERT INTO creature_text VALUES (3678, 4, 0, 'Within this circle of fire I must cast the spell to banish the spirits of the slain Fanglords.', 12, 0, 100, 0, 0, 0, 0, 'disciple SAY_BANISH_THE_SPIRITS');
INSERT INTO creature_text VALUES (3678, 5, 0, 'The caverns have been purified. To Naralex''s chamber we go!', 12, 0, 100, 0, 0, 0, 0, 'disciple SAY_CAVERNS_PURIFIED');
INSERT INTO creature_text VALUES (3678, 6, 0, 'Beyond this corridor, Naralex lies in fitful sleep. Let us go awaken him before it is too late.', 12, 0, 100, 397, 0, 0, 0, 'disciple SAY_BEYOND_THIS_CORRIDOR');
INSERT INTO creature_text VALUES (3678, 7, 0, 'Protect me brave souls as I delve into this Emerald Dream to rescue Naralex and put an end to this corruption!', 12, 0, 100, 20, 0, 0, 0, 'disciple SAY_EMERALD_DREAM');
INSERT INTO creature_text VALUES (3678, 8, 0, '%s begins to perform the awakening ritual on Naralex.', 16, 0, 100, 0, 0, 0, 0, 'disciple EMOTE_AWAKENING_RITUAL');
INSERT INTO creature_text VALUES (3678, 9, 0, 'This Mutanus the Devourer is a minion from Naralex''s nightmare no doubt!', 12, 0, 100, 0, 0, 0, 0, 'disciple SAY_MUTANUS_THE_DEVOURER');
INSERT INTO creature_text VALUES (3678, 10, 0, 'At last! Naralex awakes from the nightmare.', 12, 0, 100, 0, 0, 0, 0, 'disciple SAY_NARALEX_AWAKES');
INSERT INTO creature_text VALUES (3678, 11, 0, 'Attacked! Help get this $N off of me!', 12, 0, 100, 0, 0, 0, 0, 'disciple SAY_ATTACKED');
INSERT INTO creature_text VALUES (3678, 11, 1, 'Deal with this $N! I need to prepare to awake Naralex!', 12, 0, 100, 0, 0, 0, 0, 'disciple SAY_ATTACKED');
INSERT INTO creature_text VALUES (3678, 11, 2, 'Help!', 12, 0, 100, 0, 0, 0, 0, 'disciple SAY_ATTACKED');
DELETE FROM gossip_menu_option WHERE menu_id=201;
INSERT INTO gossip_menu_option VALUES (201, 0, 0, 'Let the event begin!', 1, 1, 0, 0, 0, 0, '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=201;
INSERT INTO conditions VALUES(15, 201, 0, 0, 0, 13, 0, 0, 3, 0, 0, 0, 0, '', 'Instance GetData(0) == DONE');
INSERT INTO conditions VALUES(15, 201, 0, 0, 0, 13, 0, 1, 3, 0, 0, 0, 0, '', 'Instance GetData(1) == DONE');
INSERT INTO conditions VALUES(15, 201, 0, 0, 0, 13, 0, 2, 3, 0, 0, 0, 0, '', 'Instance GetData(2) == DONE');
INSERT INTO conditions VALUES(15, 201, 0, 0, 0, 13, 0, 3, 3, 0, 0, 0, 0, '', 'Instance GetData(3) == DONE');
UPDATE creature_template SET speed_walk=1.4, unit_flags=256, AIName='SmartAI', ScriptName='' WHERE entry=3678;
DELETE FROM smart_scripts WHERE entryorguid=3678 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=3678*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (3678, 0, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 11, 5232, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Gossip Hello - Cast Mark of the Wild');
INSERT INTO smart_scripts VALUES (3678, 0, 1, 2, 62, 0, 100, 0, 201, 0, 0, 0, 2, 250, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Gossip Select - Set Faction');
INSERT INTO smart_scripts VALUES (3678, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Gossip Select - Set Active');
INSERT INTO smart_scripts VALUES (3678, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 53, 0, 3678, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Gossip Select - Start WP');
INSERT INTO smart_scripts VALUES (3678, 0, 4, 5, 40, 0, 100, 0, 1, 3678, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On WP Reached - Pause WP');
INSERT INTO smart_scripts VALUES (3678, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On WP Reached - Say Line 1');
INSERT INTO smart_scripts VALUES (3678, 0, 6, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 11, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Aggro - Say Line 11');
INSERT INTO smart_scripts VALUES (3678, 0, 7, 8, 40, 0, 100, 0, 5, 3678, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On WP Reached - Pause WP');
INSERT INTO smart_scripts VALUES (3678, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On WP Reached - Say Line 2');
INSERT INTO smart_scripts VALUES (3678, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 12, 3636, 8, 0, 0, 0, 0, 8, 0, 0, 0, -73.57, 214.39, -93.66, 2.34, 'Disciple of Naralex - On WP Reached - Summon Creature');
INSERT INTO smart_scripts VALUES (3678, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 12, 3636, 8, 0, 0, 0, 0, 8, 0, 0, 0, -70.85, 211.60, -93.49, 2.34, 'Disciple of Naralex - On WP Reached - Summon Creature');
INSERT INTO smart_scripts VALUES (3678, 0, 11, 0, 56, 0, 100, 0, 5, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On WP Resumed - Say Line 3');
INSERT INTO smart_scripts VALUES (3678, 0, 12, 13, 40, 0, 100, 0, 12, 3678, 0, 0, 54, 32500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On WP Reached - Pause WP');
INSERT INTO smart_scripts VALUES (3678, 0, 13, 14, 61, 0, 100, 0, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On WP Reached - Say Line 4');
INSERT INTO smart_scripts VALUES (3678, 0, 14, 15, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 10000, 10000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On WP Reached - Create Timed Event');
INSERT INTO smart_scripts VALUES (3678, 0, 15, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 6270, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On WP Reached - Cast Serpentine Cleansing');
INSERT INTO smart_scripts VALUES (3678, 0, 16, 0, 59, 0, 100, 0, 1, 0, 0, 0, 107, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - Timed Event - Summon Creature Group');
INSERT INTO smart_scripts VALUES (3678, 0, 17, 0, 56, 0, 100, 0, 12, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On WP Resumed - Say Line 5');
INSERT INTO smart_scripts VALUES (3678, 0, 18, 19, 40, 0, 100, 0, 20, 3678, 0, 0, 54, 7000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On WP Reached - Pause WP');
INSERT INTO smart_scripts VALUES (3678, 0, 19, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 2, 500, 500, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On WP Reached - Create Timed Event');
INSERT INTO smart_scripts VALUES (3678, 0, 20, 21, 40, 0, 100, 0, 25, 3678, 0, 0, 54, 1800000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On WP Reached - Pause Path');
INSERT INTO smart_scripts VALUES (3678, 0, 21, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 3678*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On WP Reached - Start Script');
INSERT INTO smart_scripts VALUES (3678, 0, 22, 0, 17, 0, 100, 0, 0, 0, 0, 0, 130, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 115.76, 236.51, -96.0, 0, 'Disciple of Naralex - Just Summoned - Move To Point Target');
INSERT INTO smart_scripts VALUES (3678, 0, 23, 24, 38, 0, 100, 0, 2, 2, 0, 0, 60, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - Script9 - Set Can Fly');
INSERT INTO smart_scripts VALUES (3678, 0, 24, 0, 61, 0, 100, 0, 0, 0, 0, 0, 53, 1, 3679, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - Script9 - Start WP');
INSERT INTO smart_scripts VALUES (3678, 0, 25, 0, 25, 0, 100, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Reset - Set Visible false');
INSERT INTO smart_scripts VALUES (3678, 0, 26, 27, 59, 0, 100, 0, 2, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0.0, 'Disciple of Naralex - On Timed Event - Set Orientation');
INSERT INTO smart_scripts VALUES (3678, 0, 27, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - On Timed Event - Say Line 6');
INSERT INTO smart_scripts VALUES (3678*100, 9, 0, 0, 0, 0, 100, 0, 500, 500, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - Script9 - Say Line 7');
INSERT INTO smart_scripts VALUES (3678*100, 9, 1, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - Script9 - Say Line 8');
INSERT INTO smart_scripts VALUES (3678*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 6271, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Disciple of Naralex - Script9 - Cast Naralex''s Awakening');
INSERT INTO smart_scripts VALUES (3678*100, 9, 3, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 12, 5762, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 143.57, 218.98, -102.90, 2.37, 'Disciple of Naralex - Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (3678*100, 9, 4, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 12, 5762, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 132.35, 268.00, -102.5, 4.144, 'Disciple of Naralex - Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (3678*100, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 3679, 10, 0, 0, 0, 0, 0, 'Disciple of Naralex - Script9 - Say Line 0 Target');
INSERT INTO smart_scripts VALUES (3678*100, 9, 6, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 12, 5762, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 94.86, 265.23, -102.9, 5.42, 'Disciple of Naralex - Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (3678*100, 9, 7, 0, 0, 0, 100, 0, 15000, 15000, 0, 0, 12, 5763, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 143.57, 218.98, -102.90, 2.37, 'Disciple of Naralex - Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (3678*100, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 3679, 10, 0, 0, 0, 0, 0, 'Disciple of Naralex - Script9 - Say Line 1 Target');
INSERT INTO smart_scripts VALUES (3678*100, 9, 9, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 12, 5763, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 107.55, 276.57, -102.4, 4.92, 'Disciple of Naralex - Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (3678*100, 9, 10, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 12, 5763, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 134.44, 205.36, -102.65, 2.03, 'Disciple of Naralex - Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (3678*100, 9, 11, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 12, 5763, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 150.11, 225.36, -102.9, 2.68, 'Disciple of Naralex - Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (3678*100, 9, 12, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 12, 5763, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 149.14, 252.73, -102.62, 3.5, 'Disciple of Naralex - Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (3678*100, 9, 13, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 12, 5763, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 143.57, 218.98, -102.90, 2.37, 'Disciple of Naralex - Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (3678*100, 9, 14, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 12, 5763, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 137.94, 262.89, -102.85, 3.99, 'Disciple of Naralex - Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (3678*100, 9, 15, 0, 0, 0, 100, 0, 20000, 20000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, 3679, 10, 0, 0, 0, 0, 0, 'Disciple of Naralex - Script9 - Say Line 2 Target');
INSERT INTO smart_scripts VALUES (3678*100, 9, 16, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 3654, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 151.27, 252.26, -102.82, 3.38, 'Disciple of Naralex - Script9 - Summon Creature');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=3678;
INSERT INTO conditions VALUES(22, 26, 3678, 0, 0, 13, 1, 4, 3, 0, 0, 0, 0, '', 'Instance GetData(4) == DONE');
DELETE FROM script_waypoint WHERE entry=3678;
DELETE FROM waypoints WHERE entry=3678;
INSERT INTO waypoints VALUES (3678, 1, -120.864, 132.825, -79.2972, 'Disciple of Naralex'),(3678, 2, -109.944, 155.417, -80.4659, 'Disciple of Naralex'),(3678, 3, -106.104, 198.456, -80.597, 'Disciple of Naralex'),(3678, 4, -110.246, 214.763, -85.6669, 'Disciple of Naralex'),(3678, 5, -105.609, 236.184, -92.1732, 'Disciple of Naralex'),(3678, 6, -93.5297, 227.956, -90.7522, 'Disciple of Naralex'),(3678, 7, -85.3155, 226.976, -93.1286, 'Disciple of Naralex'),(3678, 8, -62.151, 206.673, -93.551, 'Disciple of Naralex'),(3678, 9, -45.0534, 205.58, -96.2435, 'Disciple of Naralex'),
(3678, 10, -31.1235, 234.225, -94.0841, 'Disciple of Naralex'),(3678, 11, -49.2158, 269.141, -92.8442, 'Disciple of Naralex'),(3678, 12, -54.122, 274.717, -92.8442, 'Disciple of Naralex'),(3678, 13, -58.965, 282.274, -92.538, 'Disciple of Naralex'),(3678, 14, -38.3566, 306.239, -90.0192, 'Disciple of Naralex'),(3678, 15, -28.8928, 312.842, -89.2155, 'Disciple of Naralex'),(3678, 16, -1.58198, 296.127, -85.5984, 'Disciple of Naralex'),(3678, 17, 9.89992, 272.008, -85.7759, 'Disciple of Naralex'),(3678, 18, 26.8162, 259.218, -87.3938, 'Disciple of Naralex'),
(3678, 19, 49.1166, 227.259, -88.3379, 'Disciple of Naralex'),(3678, 20, 54.4171, 209.316, -90, 'Disciple of Naralex'),(3678, 21, 71.038, 205.404, -93.0422, 'Disciple of Naralex'),(3678, 22, 81.5941, 212.832, -93.0154, 'Disciple of Naralex'),(3678, 23, 94.3376, 236.933, -95.8261, 'Disciple of Naralex'),(3678, 24, 114.619, 235.908, -96.0495, 'Disciple of Naralex'),(3678, 25, 114.777, 237.155, -96.0304, 'Disciple of Naralex');
DELETE FROM creature_summon_groups WHERE summonerId=3678 AND summonerType=0;
INSERT INTO creature_summon_groups VALUES (3678, 0, 1, 5048, -47.61, 271.52, -92.84, 2.54, 4, 60000);
INSERT INTO creature_summon_groups VALUES (3678, 0, 1, 5048, -61.81, 271.145, -92.84, 0.36, 4, 60000);
INSERT INTO creature_summon_groups VALUES (3678, 0, 1, 5755, -57.49, 280.59, -92.84, 5.22, 4, 60000);

-- SPELL Naralex's Awakening (8136)
DELETE FROM spell_target_position WHERE id=8136;
INSERT INTO spell_target_position VALUES (8136, 0, 43, 116.24, 239.928, -94.8, 0.0);

-- Deviate Moccasin (5762)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=5762;
DELETE FROM smart_scripts WHERE entryorguid=5762 AND source_type=0;
INSERT INTO smart_scripts VALUES (5762, 0, 0, 0, 1, 0, 100, 257, 3000, 3000, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deviate Moccasin - Out of Combat - Set In Combat With Zone');

-- Nightmare Ectoplasm (5763)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=5763;
DELETE FROM smart_scripts WHERE entryorguid=5763 AND source_type=0;
INSERT INTO smart_scripts VALUES (5763, 0, 0, 0, 1, 0, 100, 257, 3000, 3000, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nightmare Ectoplasm - Out of Combat - Set In Combat With Zone');

-- Mutanus the Devourer (3654)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3654;
DELETE FROM smart_scripts WHERE entryorguid=3654 AND source_type=0;
INSERT INTO smart_scripts VALUES (3654, 0, 0, 0, 60, 0, 100, 257, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 115.76, 236.51, -96.0, 0, 'Mutanus the Devourer - On Update - Move To Position');
INSERT INTO smart_scripts VALUES (3654, 0, 1, 0, 60, 0, 100, 257, 4000, 4000, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mutanus the Devourer - On Update - Set In Combat With Zone');
INSERT INTO smart_scripts VALUES (3654, 0, 2, 0, 0, 0, 100, 0, 11000, 15000, 32400, 33800, 11, 7967, 0, 0, 0, 0, 0, 6, 30, 0, 0, 0, 0, 0, 0, 'Mutanus the Devourer - In Combat - Cast Naralex''s Nightmare');
INSERT INTO smart_scripts VALUES (3654, 0, 3, 0, 0, 0, 100, 0, 8000, 11000, 18000, 25000, 11, 7399, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mutanus the Devourer - In Combat - Cast Terrify');
INSERT INTO smart_scripts VALUES (3654, 0, 4, 0, 0, 0, 100, 0, 5000, 6000, 15000, 20000, 11, 8150, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mutanus the Devourer - In Combat - Cast Thundercrack');
INSERT INTO smart_scripts VALUES (3654, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 3679, 100, 0, 0, 0, 0, 0, 'Mutanus the Devourer - On Just Died - Set Data');
INSERT INTO smart_scripts VALUES (3654, 0, 6, 0, 6, 0, 100, 0, 0, 0, 0, 0, 34, 4, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mutanus the Devourer - On Just Died - Set Instance Data 4 to 3');

-- Naralex (3679)
DELETE FROM creature_text WHERE entry=3679;
INSERT INTO creature_text VALUES (3679, 0, 0, '%s tosses fitfully in troubled sleep.', 16, 0, 100, 0, 0, 0, 0, 'naralex EMOTE_TROUBLED_SLEEP');
INSERT INTO creature_text VALUES (3679, 1, 0, '%s writhes in agony. The Disciple seems to be breaking through.', 16, 0, 100, 0, 0, 0, 0, 'naralex EMOTE_WRITHE_IN_AGONY');
INSERT INTO creature_text VALUES (3679, 2, 0, '%s dreams up a horrendous vision. Something stirs beneath the murky waters.', 16, 0, 100, 0, 0, 0, 0, 'naralex EMOTE_HORRENDOUS_VISION');
INSERT INTO creature_text VALUES (3679, 3, 0, 'I AM AWAKE, AT LAST!', 14, 0, 100, 0, 0, 5789, 0, 'naralex SAY_I_AM_AWAKE');
INSERT INTO creature_text VALUES (3679, 4, 0, 'Ah, to be pulled from the dreaded nightmare! I thank you, my loyal Disciple, along with your brave companions.', 12, 0, 100, 0, 0, 0, 0, 'naralex SAY_THANK_YOU');
INSERT INTO creature_text VALUES (3679, 5, 0, 'We must go and gather with the other Disciples. There is much work to be done before I can make another attempt to restore the Barrens. Farewell, brave souls!', 12, 0, 100, 0, 0, 0, 0, 'naralex SAY_FAREWELL');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3679;
DELETE FROM smart_scripts WHERE entryorguid=3679 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=3679*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (3679, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 80, 3679*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Naralex - On Data Set - Start Script');
INSERT INTO smart_scripts VALUES (3679, 0, 1, 0, 37, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Naralex - On AI Init - Set React Passive');
INSERT INTO smart_scripts VALUES (3679*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Naralex - Script9 - Say Line 3');
INSERT INTO smart_scripts VALUES (3679*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 19, 3678, 10, 0, 0, 0, 0, 0, 'Naralex - Script9 - Remove Auras');
INSERT INTO smart_scripts VALUES (3679*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 91, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Naralex - Script9 - Remove Bytes1');
INSERT INTO smart_scripts VALUES (3679*100, 9, 3, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Naralex - Script9 - Say Line 4');
INSERT INTO smart_scripts VALUES (3679*100, 9, 4, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Naralex - Script9 - Say Line 4');
INSERT INTO smart_scripts VALUES (3679*100, 9, 5, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 11, 8153, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Naralex - Script9 - Cast Owl Form');
INSERT INTO smart_scripts VALUES (3679*100, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 86, 8153, 0, 19, 3678, 10, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Naralex - Script9 - Cross Cast Owl Form');
INSERT INTO smart_scripts VALUES (3679*100, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Naralex - Script9 - Despawn');
INSERT INTO smart_scripts VALUES (3679*100, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 19, 3678, 10, 0, 0, 0, 0, 0, 'Naralex - Script9 - Despawn Target');
INSERT INTO smart_scripts VALUES (3679*100, 9, 9, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 148, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Naralex - Script9 - No Environment Update');
INSERT INTO smart_scripts VALUES (3679*100, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 148, 0, 0, 0, 0, 0, 0, 19, 3678, 10, 0, 0, 0, 0, 0, 'Naralex - Script9 - No Environment Update');
INSERT INTO smart_scripts VALUES (3679*100, 9, 11, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, 3678, 10, 0, 0, 0, 0, 0, 'Naralex - Script9 - Set Data');
INSERT INTO smart_scripts VALUES (3679*100, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 60, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Naralex - Script9 - Set Can Fly');
INSERT INTO smart_scripts VALUES (3679*100, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 53, 1, 3679, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Naralex - Script9 - Start WP');
DELETE FROM waypoints WHERE entry=3679;
INSERT INTO waypoints VALUES (3679, 1, 130.67, 249.73, -89, 'Naralex');
INSERT INTO waypoints VALUES (3679, 2, 104.82, 276.36, -91.43, 'Naralex');
INSERT INTO waypoints VALUES (3679, 3, 84.08, 222.3, -86.51, 'Naralex');
