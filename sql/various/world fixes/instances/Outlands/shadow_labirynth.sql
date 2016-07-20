
UPDATE creature SET spawntimesecs=86400 WHERE map=555 AND spawntimesecs>0;

-- -------------------------------------------
--               FORMATIONS
-- -------------------------------------------


-- -------------------------------------------
--                TRASH
-- -------------------------------------------
-- Cabal Acolyte (18633, 20638)
DELETE FROM creature_text WHERE entry=18633;
INSERT INTO creature_text VALUES (18633, 0, 0, "I do as I must!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Acolyte');
INSERT INTO creature_text VALUES (18633, 0, 1, "I shall be rewarded!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Acolyte');
INSERT INTO creature_text VALUES (18633, 0, 2, "In Sargeras' name!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Acolyte');
INSERT INTO creature_text VALUES (18633, 0, 3, "Ruin finds us all!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Acolyte');
INSERT INTO creature_text VALUES (18633, 0, 4, "The end comes for you!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Acolyte');
INSERT INTO creature_text VALUES (18633, 0, 5, "The Legion reigns!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Acolyte');
UPDATE creature_template SET pickpocketloot=18633, AIName='SmartAI', ScriptName='' WHERE entry=18633;
UPDATE creature_template SET pickpocketloot=18633, AIName='', ScriptName='' WHERE entry=20638;
DELETE FROM smart_scripts WHERE entryorguid=18633 AND source_type=0;
INSERT INTO smart_scripts VALUES (18633, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cabal Acolyte - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18633, 0, 1, 0, 14, 0, 100, 2, 1000, 40, 7000, 10000, 11, 12039, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Cabal Acolyte - HP Friendly - Cast Heal');
INSERT INTO smart_scripts VALUES (18633, 0, 2, 0, 14, 0, 100, 4, 1000, 40, 7000, 10000, 11, 38209, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Cabal Acolyte - HP Friendly - Cast Heal');
INSERT INTO smart_scripts VALUES (18633, 0, 3, 0, 16, 0, 100, 2, 25058, 40, 7000, 10000, 11, 25058, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Cabal Acolyte - Missing Buff - Cast Renew');
INSERT INTO smart_scripts VALUES (18633, 0, 4, 0, 16, 0, 100, 4, 38210, 40, 7000, 10000, 11, 38210, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Cabal Acolyte - Missing Buff - Cast Renew');
INSERT INTO smart_scripts VALUES (18633, 0, 5, 0, 1, 0, 100, 0, 0, 0, 3600000, 3600000, 11, 33482, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cabal Acolyte - Out of Combat - Cast Shadow Defense');

-- Cabal Deathsworn (18635, 20641)
DELETE FROM creature_text WHERE entry=18635;
INSERT INTO creature_text VALUES (18635, 0, 0, "I do as I must!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Deathsworn');
INSERT INTO creature_text VALUES (18635, 0, 1, "I shall be rewarded!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Deathsworn');
INSERT INTO creature_text VALUES (18635, 0, 2, "In Sargeras' name!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Deathsworn');
INSERT INTO creature_text VALUES (18635, 0, 3, "Ruin finds us all!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Deathsworn');
INSERT INTO creature_text VALUES (18635, 0, 4, "The end comes for you!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Deathsworn');
INSERT INTO creature_text VALUES (18635, 0, 5, "The Legion reigns!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Deathsworn');
UPDATE creature_template SET pickpocketloot=18635, AIName='SmartAI', ScriptName='' WHERE entry=18635;
UPDATE creature_template SET pickpocketloot=18635, AIName='', ScriptName='' WHERE entry=20641;
DELETE FROM smart_scripts WHERE entryorguid=18635 AND source_type=0;
INSERT INTO smart_scripts VALUES (18635, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cabal Deathsworn - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18635, 0, 1, 0, 0, 0, 100, 0, 3000, 7000, 12000, 15000, 11, 11428, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cabal Deathsworn - In Combat - Cast Knockdown');
INSERT INTO smart_scripts VALUES (18635, 0, 2, 0, 0, 0, 100, 2, 8000, 9000, 11000, 13000, 11, 33480, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cabal Deathsworn - In Combat - Cast Black Cleave');
INSERT INTO smart_scripts VALUES (18635, 0, 3, 0, 0, 0, 100, 4, 8000, 9000, 11000, 13000, 11, 38226, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cabal Deathsworn - In Combat - Cast Black Cleave');
INSERT INTO smart_scripts VALUES (18635, 0, 4, 0, 2, 0, 100, 1, 0, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cabal Deathsworn - HP 30% - Cast Enrage');

-- Cabal Warlock (18640, 20649)
DELETE FROM creature_text WHERE entry=18640;
INSERT INTO creature_text VALUES (18640, 0, 0, "I do as I must!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Warlock');
INSERT INTO creature_text VALUES (18640, 0, 1, "I shall be rewarded!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Warlock');
INSERT INTO creature_text VALUES (18640, 0, 2, "In Sargeras' name!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Warlock');
INSERT INTO creature_text VALUES (18640, 0, 3, "Ruin finds us all!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Warlock');
INSERT INTO creature_text VALUES (18640, 0, 4, "The end comes for you!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Warlock');
INSERT INTO creature_text VALUES (18640, 0, 5, "The Legion reigns!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Warlock');
UPDATE creature_template SET pickpocketloot=18640, AIName='SmartAI', ScriptName='' WHERE entry=18640;
UPDATE creature_template SET pickpocketloot=18640, AIName='', ScriptName='' WHERE entry=20649;
DELETE FROM smart_scripts WHERE entryorguid=18640 AND source_type=0;
INSERT INTO smart_scripts VALUES (18640, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cabal Warlock - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18640, 0, 1, 0, 0, 0, 100, 2, 7000, 7000, 18000, 25000, 11, 32863, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Cabal Warlock - In Combat - Cast Seed of Corruption');
INSERT INTO smart_scripts VALUES (18640, 0, 2, 0, 0, 0, 100, 4, 7000, 7000, 18000, 25000, 11, 38252, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Cabal Warlock - In Combat - Cast Seed of Corruption');
INSERT INTO smart_scripts VALUES (18640, 0, 3, 0, 0, 0, 100, 2, 0, 0, 4000, 4000, 11, 12471, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cabal Warlock - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (18640, 0, 4, 0, 0, 0, 100, 4, 0, 0, 4000, 4000, 11, 15232, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cabal Warlock - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (18640, 0, 5, 0, 1, 0, 100, 0, 0, 0, 1800000, 1800000, 11, 13787, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cabal Warlock - Out of Combat - Cast Demon Armor');

-- Cabal Familiar (18641, 20643)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=18641;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=20643;
DELETE FROM smart_scripts WHERE entryorguid=18641 AND source_type=0;
INSERT INTO smart_scripts VALUES (18641, 0, 0, 0, 0, 0, 100, 2, 0, 0, 3000, 3000, 11, 20801, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cabal Familiar - In Combat - Cast Firebolt');
INSERT INTO smart_scripts VALUES (18641, 0, 1, 0, 0, 0, 100, 4, 0, 0, 3000, 3000, 11, 38239, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cabal Familiar - In Combat - Cast Firebolt');

-- Fel Guardhound (18642, 20651)
UPDATE creature_template SET skinloot=70162, AIName='SmartAI', ScriptName='' WHERE entry=18642;
UPDATE creature_template SET skinloot=70162, AIName='', ScriptName='' WHERE entry=20651;
DELETE FROM smart_scripts WHERE entryorguid=18642 AND source_type=0;
INSERT INTO smart_scripts VALUES (18642, 0, 0, 0, 13, 0, 100, 0, 7000, 9000, 0, 0, 11, 30849, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fel Guardhound - On Target Cast - Cast Spell Lock');

-- Cabal Ritualist (18794, 20645)
DELETE FROM creature_text WHERE entry=18794;
INSERT INTO creature_text VALUES (18794, 0, 0, "I do as I must!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Ritualist');
INSERT INTO creature_text VALUES (18794, 0, 1, "I shall be rewarded!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Ritualist');
INSERT INTO creature_text VALUES (18794, 0, 2, "In Sargeras' name!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Ritualist');
INSERT INTO creature_text VALUES (18794, 0, 3, "Ruin finds us all!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Ritualist');
INSERT INTO creature_text VALUES (18794, 0, 4, "The end comes for you!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Ritualist');
INSERT INTO creature_text VALUES (18794, 0, 5, "The Legion reigns!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Ritualist');
UPDATE creature_template SET pickpocketloot=18794, AIName='SmartAI', ScriptName='' WHERE entry=18794;
UPDATE creature_template SET pickpocketloot=18794, AIName='', ScriptName='' WHERE entry=20645;
DELETE FROM smart_scripts WHERE entryorguid=18794 AND source_type=0;
INSERT INTO smart_scripts VALUES (18794, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cabal Ritualist - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18794, 0, 1, 0, 0, 0, 100, 0, 7000, 7000, 18000, 25000, 11, 33487, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Cabal Ritualist - In Combat - Cast Addle Humanoid');
INSERT INTO smart_scripts VALUES (18794, 0, 2, 0, 0, 0, 100, 0, 8000, 9000, 12000, 15000, 11, 12540, 0, 0, 0, 0, 0, 5, 5, 0, 0, 0, 0, 0, 0, 'Cabal Ritualist - In Combat - Cast Gouge');
INSERT INTO smart_scripts VALUES (18794, 0, 3, 0, 0, 0, 100, 2, 6000, 6000, 11000, 16000, 11, 20795, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Cabal Ritualist - In Combat - Cast Fire Blast');
INSERT INTO smart_scripts VALUES (18794, 0, 4, 0, 0, 0, 100, 4, 6000, 6000, 11000, 16000, 11, 14145, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Cabal Ritualist - In Combat - Cast Fire Blast');

-- Fel Overseer (18796, 20652)
DELETE FROM creature_text WHERE entry=18796;
INSERT INTO creature_text VALUES (18796, 0, 0, "Embrace the Nothing!", 12, 0, 100, 0, 0, 0, 0, 'Fel Overseer');
INSERT INTO creature_text VALUES (18796, 0, 1, "I'll feast on your soul!", 12, 0, 100, 0, 0, 0, 0, 'Fel Overseer');
INSERT INTO creature_text VALUES (18796, 0, 2, "None can stand against the Legion!", 12, 0, 100, 0, 0, 0, 0, 'Fel Overseer');
INSERT INTO creature_text VALUES (18796, 0, 3, "Pathetic worm!", 12, 0, 100, 0, 0, 0, 0, 'Fel Overseer');
INSERT INTO creature_text VALUES (18796, 0, 4, "The end is come!", 12, 0, 100, 0, 0, 0, 0, 'Fel Overseer');
INSERT INTO creature_text VALUES (18796, 0, 5, "The only justice is death!", 12, 0, 100, 0, 0, 0, 0, 'Fel Overseer');
INSERT INTO creature_text VALUES (18796, 0, 6, "This world shall burn!", 12, 0, 100, 0, 0, 0, 0, 'Fel Overseer');
INSERT INTO creature_text VALUES (18796, 0, 7, "You shall not escape.", 12, 0, 100, 0, 0, 0, 0, 'Fel Overseer');
UPDATE creature_template SET pickpocketloot=18796, AIName='SmartAI', ScriptName='' WHERE entry=18796;
UPDATE creature_template SET pickpocketloot=18796, AIName='', ScriptName='' WHERE entry=20652;
DELETE FROM smart_scripts WHERE entryorguid=18796 AND source_type=0;
INSERT INTO smart_scripts VALUES (18796, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fel Overseer - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18796, 0, 1, 0, 0, 0, 100, 0, 20000, 20000, 25000, 25000, 11, 19134, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fel Overseer - In Combat - Cast Frightening Shout');
INSERT INTO smart_scripts VALUES (18796, 0, 2, 0, 0, 0, 100, 0, 5000, 5000, 12000, 15000, 11, 16856, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fel Overseer - In Combat - Cast Mortal Strike');
INSERT INTO smart_scripts VALUES (18796, 0, 3, 0, 0, 0, 100, 0, 6000, 9000, 9000, 16000, 11, 30471, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fel Overseer - In Combat - Cast Uppercut');
INSERT INTO smart_scripts VALUES (18796, 0, 4, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 27577, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Fel Overseer - On Aggro - Cast Intercept');
INSERT INTO smart_scripts VALUES (18796, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 34, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fel Overseer - On Death - Set instance data');


-- Cabal Cultist (18631, 20640)
DELETE FROM creature_text WHERE entry=18631;
INSERT INTO creature_text VALUES (18631, 0, 0, "I do as I must!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Cultist');
INSERT INTO creature_text VALUES (18631, 0, 1, "I shall be rewarded!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Cultist');
INSERT INTO creature_text VALUES (18631, 0, 2, "In Sargeras' name!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Cultist');
INSERT INTO creature_text VALUES (18631, 0, 3, "Ruin finds us all!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Cultist');
INSERT INTO creature_text VALUES (18631, 0, 4, "The end comes for you!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Cultist');
INSERT INTO creature_text VALUES (18631, 0, 5, "The Legion reigns!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Cultist');
UPDATE creature_template SET pickpocketloot=18631, AIName='SmartAI', ScriptName='' WHERE entry=18631;
UPDATE creature_template SET pickpocketloot=18631, AIName='', ScriptName='' WHERE entry=20640;
DELETE FROM smart_scripts WHERE entryorguid=18631 AND source_type=0;
INSERT INTO smart_scripts VALUES (18631, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cabal Cultist - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18631, 0, 1, 0, 0, 0, 100, 0, 3000, 7000, 10000, 12000, 11, 3391, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cabal Cultist - In Combat - Cast Thrash');
INSERT INTO smart_scripts VALUES (18631, 0, 2, 0, 13, 0, 100, 0, 10000, 11000, 0, 0, 11, 15614, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cabal Cultist - On Target Cast - Cast Kick');

-- Cabal Shadow Priest (18637, 20646)
DELETE FROM creature_text WHERE entry=18637;
INSERT INTO creature_text VALUES (18637, 0, 0, "I do as I must!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Shadow Priest');
INSERT INTO creature_text VALUES (18637, 0, 1, "I shall be rewarded!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Shadow Priest');
INSERT INTO creature_text VALUES (18637, 0, 2, "In Sargeras' name!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Shadow Priest');
INSERT INTO creature_text VALUES (18637, 0, 3, "Ruin finds us all!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Shadow Priest');
INSERT INTO creature_text VALUES (18637, 0, 4, "The end comes for you!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Shadow Priest');
INSERT INTO creature_text VALUES (18637, 0, 5, "The Legion reigns!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Shadow Priest');
UPDATE creature_template SET pickpocketloot=18637, AIName='SmartAI', ScriptName='' WHERE entry=18637;
UPDATE creature_template SET pickpocketloot=18637, AIName='', ScriptName='' WHERE entry=20646;
DELETE FROM smart_scripts WHERE entryorguid=18637 AND source_type=0;
INSERT INTO smart_scripts VALUES (18637, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cabal Shadow Priest - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18637, 0, 1, 0, 0, 0, 100, 2, 5000, 7000, 10000, 15000, 11, 14032, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Cabal Shadow Priest - In Combat - Cast Shadow Word: Pain');
INSERT INTO smart_scripts VALUES (18637, 0, 2, 0, 0, 0, 100, 4, 5000, 7000, 10000, 15000, 11, 17146, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Cabal Shadow Priest - In Combat - Cast Shadow Word: Pain');
INSERT INTO smart_scripts VALUES (18637, 0, 3, 0, 0, 0, 100, 2, 1000, 1000, 8000, 9000, 11, 17165, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Cabal Shadow Priest - In Combat - Cast Mind Flay');
INSERT INTO smart_scripts VALUES (18637, 0, 4, 0, 0, 0, 100, 4, 1000, 1000, 8000, 9000, 11, 38243, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Cabal Shadow Priest - In Combat - Cast Mind Flay');
INSERT INTO smart_scripts VALUES (18637, 0, 5, 0, 1, 0, 100, 0, 0, 0, 1800000, 1800000, 11, 16592, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cabal Shadow Priest - Out of Combat - Cast Shadowform');

-- Malicious Instructor (18848, 20656)
DELETE FROM creature_text WHERE entry=18848;
INSERT INTO creature_text VALUES (18848, 0, 0, "Embrace the Nothing!", 12, 0, 100, 0, 0, 0, 0, 'Malicious Instructor');
INSERT INTO creature_text VALUES (18848, 0, 1, "I'll feast on your soul!", 12, 0, 100, 0, 0, 0, 0, 'Malicious Instructor');
INSERT INTO creature_text VALUES (18848, 0, 2, "None can stand against the Legion!", 12, 0, 100, 0, 0, 0, 0, 'Malicious Instructor');
INSERT INTO creature_text VALUES (18848, 0, 3, "Pathetic worm!", 12, 0, 100, 0, 0, 0, 0, 'Malicious Instructor');
INSERT INTO creature_text VALUES (18848, 0, 4, "The end is come!", 12, 0, 100, 0, 0, 0, 0, 'Malicious Instructor');
INSERT INTO creature_text VALUES (18848, 0, 5, "The only justice is death!", 12, 0, 100, 0, 0, 0, 0, 'Malicious Instructor');
INSERT INTO creature_text VALUES (18848, 0, 6, "This world shall burn!", 12, 0, 100, 0, 0, 0, 0, 'Malicious Instructor');
INSERT INTO creature_text VALUES (18848, 0, 7, "You shall not escape.", 12, 0, 100, 0, 0, 0, 0, 'Malicious Instructor');
UPDATE creature_template SET pickpocketloot=18848, AIName='SmartAI', ScriptName='' WHERE entry=18848;
UPDATE creature_template SET pickpocketloot=18848, AIName='', ScriptName='' WHERE entry=20656;
DELETE FROM smart_scripts WHERE entryorguid=18848 AND source_type=0;
INSERT INTO smart_scripts VALUES (18848, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Malicious Instructor - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18848, 0, 1, 0, 0, 0, 100, 0, 2000, 10000, 10000, 20000, 11, 6713, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Malicious Instructor - In Combat - Cast Disarm');
INSERT INTO smart_scripts VALUES (18848, 0, 2, 0, 0, 0, 100, 0, 7000, 9000, 12000, 15000, 11, 33501, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Malicious Instructor - In Combat - Cast Shadow Nova');
INSERT INTO smart_scripts VALUES (18848, 0, 3, 0, 0, 0, 100, 0, 9000, 11000, 30000, 30000, 11, 33493, 0, 0, 0, 0, 0, 5, 8, 0, 0, 0, 0, 0, 0, 'Malicious Instructor - In Combat - Cast Mark of Malice');

-- Tortured Skeleton (18797, 20662)
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=18797;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=20662;
DELETE FROM smart_scripts WHERE entryorguid=18797 AND source_type=0;

-- Cabal Fanatic (18830, 20644)
DELETE FROM creature_text WHERE entry=18830;
INSERT INTO creature_text VALUES (18830, 0, 0, "I do as I must!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Fanatic');
INSERT INTO creature_text VALUES (18830, 0, 1, "I shall be rewarded!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Fanatic');
INSERT INTO creature_text VALUES (18830, 0, 2, "In Sargeras' name!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Fanatic');
INSERT INTO creature_text VALUES (18830, 0, 3, "Ruin finds us all!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Fanatic');
INSERT INTO creature_text VALUES (18830, 0, 4, "The end comes for you!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Fanatic');
INSERT INTO creature_text VALUES (18830, 0, 5, "The Legion reigns!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Fanatic');
UPDATE creature_template SET pickpocketloot=18830, AIName='SmartAI', ScriptName='' WHERE entry=18830;
UPDATE creature_template SET pickpocketloot=18830, AIName='', ScriptName='' WHERE entry=20644;
DELETE FROM smart_scripts WHERE entryorguid=18830 AND source_type=0;
INSERT INTO smart_scripts VALUES (18830, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cabal Fanatic - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18830, 0, 1, 0, 0, 0, 100, 0, 5000, 7000, 12000, 15000, 11, 12021, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cabal Fanatic - In Combat - Cast Fixate');

-- Cabal Zealot (18638, 20650)
DELETE FROM creature_text WHERE entry=18638;
INSERT INTO creature_text VALUES (18638, 0, 0, "I do as I must!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Zealot');
INSERT INTO creature_text VALUES (18638, 0, 1, "I shall be rewarded!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Zealot');
INSERT INTO creature_text VALUES (18638, 0, 2, "In Sargeras' name!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Zealot');
INSERT INTO creature_text VALUES (18638, 0, 3, "Ruin finds us all!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Zealot');
INSERT INTO creature_text VALUES (18638, 0, 4, "The end comes for you!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Zealot');
INSERT INTO creature_text VALUES (18638, 0, 5, "The Legion reigns!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Zealot');
UPDATE creature_template SET pickpocketloot=18638, AIName='SmartAI', ScriptName='' WHERE entry=18638;
UPDATE creature_template SET pickpocketloot=18638, AIName='', ScriptName='' WHERE entry=20650;
DELETE FROM smart_scripts WHERE entryorguid=18638 AND source_type=0;
INSERT INTO smart_scripts VALUES (18638, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cabal Zealot - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18638, 0, 1, 0, 0, 0, 100, 2, 0, 0, 4000, 4000, 11, 12471, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cabal Zealot - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (18638, 0, 2, 0, 0, 0, 100, 4, 0, 0, 4000, 4000, 11, 15472, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cabal Zealot - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (18638, 0, 3, 0, 2, 0, 100, 1, 0, 30, 0, 0, 11, 33499, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cabal Zealot - HP 30% - Cast Shape of the Beast');

-- Cabal Summoner (18634, 20648)
DELETE FROM creature_text WHERE entry=18634;
INSERT INTO creature_text VALUES (18634, 0, 0, "I do as I must!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Summoner');
INSERT INTO creature_text VALUES (18634, 0, 1, "I shall be rewarded!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Summoner');
INSERT INTO creature_text VALUES (18634, 0, 2, "In Sargeras' name!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Summoner');
INSERT INTO creature_text VALUES (18634, 0, 3, "Ruin finds us all!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Summoner');
INSERT INTO creature_text VALUES (18634, 0, 4, "The end comes for you!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Summoner');
INSERT INTO creature_text VALUES (18634, 0, 5, "The Legion reigns!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Summoner');
UPDATE creature_template SET pickpocketloot=18634, AIName='SmartAI', ScriptName='' WHERE entry=18634;
UPDATE creature_template SET pickpocketloot=18634, AIName='', ScriptName='' WHERE entry=20648;
DELETE FROM smart_scripts WHERE entryorguid=18634 AND source_type=0;
INSERT INTO smart_scripts VALUES (18634, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cabal Summoner - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18634, 0, 1, 0, 2, 0, 100, 1, 0, 90, 0, 0, 11, 33506, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cabal Summoner - In Combat - Cast Summon Cabal Acolyte');
INSERT INTO smart_scripts VALUES (18634, 0, 2, 0, 2, 0, 100, 1, 0, 40, 0, 0, 11, 33507, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cabal Summoner - In Combat - Cast Summon Cabal Deathsworn');
INSERT INTO smart_scripts VALUES (18634, 0, 3, 0, 0, 0, 100, 2, 0, 0, 4000, 4000, 11, 14034, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cabal Summoner - In Combat - Cast Fireball');
INSERT INTO smart_scripts VALUES (18634, 0, 4, 0, 0, 0, 100, 4, 0, 0, 4000, 4000, 11, 15228, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cabal Summoner - In Combat - Cast Fireball');

-- Summoned Cabal Acolyte (19208, 20660)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=19208;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=20660;
DELETE FROM smart_scripts WHERE entryorguid=19208 AND source_type=0;
INSERT INTO smart_scripts VALUES (19208, 0, 0, 0, 14, 0, 100, 2, 1000, 40, 7000, 10000, 11, 12039, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Summoned Cabal Acolyte - HP Friendly - Cast Heal');
INSERT INTO smart_scripts VALUES (19208, 0, 1, 0, 14, 0, 100, 4, 1000, 40, 7000, 10000, 11, 38209, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Summoned Cabal Acolyte - HP Friendly - Cast Heal');
INSERT INTO smart_scripts VALUES (19208, 0, 2, 0, 16, 0, 100, 2, 25058, 40, 7000, 10000, 11, 25058, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Summoned Cabal Acolyte - Missing Buff - Cast Renew');
INSERT INTO smart_scripts VALUES (19208, 0, 3, 0, 16, 0, 100, 4, 38210, 40, 7000, 10000, 11, 38210, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Summoned Cabal Acolyte - Missing Buff - Cast Renew');
INSERT INTO smart_scripts VALUES (19208, 0, 4, 0, 1, 0, 100, 0, 0, 0, 3600000, 3600000, 11, 33482, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Summoned Cabal Acolyte - Out of Combat - Cast Shadow Defense');

-- Summoned Cabal Deathsworn (19209, 20661)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=19209;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=20661;
DELETE FROM smart_scripts WHERE entryorguid=19209 AND source_type=0;
INSERT INTO smart_scripts VALUES (19209, 0, 0, 0, 0, 0, 100, 0, 3000, 7000, 12000, 15000, 11, 11428, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Summoned Cabal Deathsworn - In Combat - Cast Knockdown');
INSERT INTO smart_scripts VALUES (19209, 0, 1, 0, 0, 0, 100, 2, 8000, 9000, 11000, 13000, 11, 33480, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Summoned Cabal Deathsworn - In Combat - Cast Black Cleave');
INSERT INTO smart_scripts VALUES (19209, 0, 2, 0, 0, 0, 100, 4, 8000, 9000, 11000, 13000, 11, 38226, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Summoned Cabal Deathsworn - In Combat - Cast Black Cleave');
INSERT INTO smart_scripts VALUES (19209, 0, 3, 0, 2, 0, 100, 1, 0, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Summoned Cabal Deathsworn - HP 30% - Cast Enrage');

-- Cabal Assassin (18636, 20639)
DELETE FROM creature_text WHERE entry=18636;
INSERT INTO creature_text VALUES (18636, 0, 0, "I do as I must!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Assassin');
INSERT INTO creature_text VALUES (18636, 0, 1, "I shall be rewarded!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Assassin');
INSERT INTO creature_text VALUES (18636, 0, 2, "In Sargeras' name!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Assassin');
INSERT INTO creature_text VALUES (18636, 0, 3, "Ruin finds us all!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Assassin');
INSERT INTO creature_text VALUES (18636, 0, 4, "The end comes for you!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Assassin');
INSERT INTO creature_text VALUES (18636, 0, 5, "The Legion reigns!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Assassin');
UPDATE creature_template SET pickpocketloot=18636, AIName='SmartAI', ScriptName='' WHERE entry=18636;
UPDATE creature_template SET pickpocketloot=18636, AIName='', ScriptName='' WHERE entry=20639;
DELETE FROM smart_scripts WHERE entryorguid=18636 AND source_type=0;
INSERT INTO smart_scripts VALUES (18636, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cabal Assassin - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18636, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 30986, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cabal Assassin - On Aggro - Cast Cheap Shot');
INSERT INTO smart_scripts VALUES (18636, 0, 2, 0, 0, 0, 100, 0, 5000, 9000, 12000, 17000, 11, 30981, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cabal Assassin - In Combat - Cast Crippling Poison');
INSERT INTO smart_scripts VALUES (18636, 0, 3, 0, 0, 0, 100, 0, 2000, 3000, 12000, 17000, 11, 36974, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cabal Assassin - In Combat - Cast Wound Poison');
INSERT INTO smart_scripts VALUES (18636, 0, 4, 0, 1, 0, 100, 0, 0, 0, 3600000, 3600000, 11, 30991, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cabal Assassin - Out of Combat - Cast Stealth');

-- Cabal Executioner (18632, 20642)
DELETE FROM creature_text WHERE entry=18632;
INSERT INTO creature_text VALUES (18632, 0, 0, "I do as I must!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Executioner');
INSERT INTO creature_text VALUES (18632, 0, 1, "I shall be rewarded!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Executioner');
INSERT INTO creature_text VALUES (18632, 0, 2, "In Sargeras' name!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Executioner');
INSERT INTO creature_text VALUES (18632, 0, 3, "Ruin finds us all!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Executioner');
INSERT INTO creature_text VALUES (18632, 0, 4, "The end comes for you!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Executioner');
INSERT INTO creature_text VALUES (18632, 0, 5, "The Legion reigns!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Executioner');
UPDATE creature_template SET pickpocketloot=18632, AIName='SmartAI', ScriptName='' WHERE entry=18632;
UPDATE creature_template SET pickpocketloot=18632, AIName='', ScriptName='' WHERE entry=20642;
DELETE FROM smart_scripts WHERE entryorguid=18632 AND source_type=0;
INSERT INTO smart_scripts VALUES (18632, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cabal Executioner - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18632, 0, 1, 0, 0, 0, 100, 0, 7000, 9000, 9000, 11000, 11, 33500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cabal Executioner - In Combat - Cast Whirlwind');
INSERT INTO smart_scripts VALUES (18632, 0, 2, 0, 2, 0, 100, 1, 0, 30, 0, 0, 11, 30485, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cabal Executioner - HP 30% - Cast Enrage');
INSERT INTO smart_scripts VALUES (18632, 0, 3, 0, 12, 0, 100, 0, 0, 20, 10000, 10000, 11, 7160, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cabal Executioner - On Target HP 20% - Cast Execute');

-- Cabal Spellbinder (18639, 20647)
DELETE FROM creature_text WHERE entry=18639;
INSERT INTO creature_text VALUES (18639, 0, 0, "I do as I must!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Spellbinder');
INSERT INTO creature_text VALUES (18639, 0, 1, "I shall be rewarded!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Spellbinder');
INSERT INTO creature_text VALUES (18639, 0, 2, "In Sargeras' name!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Spellbinder');
INSERT INTO creature_text VALUES (18639, 0, 3, "Ruin finds us all!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Spellbinder');
INSERT INTO creature_text VALUES (18639, 0, 4, "The end comes for you!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Spellbinder');
INSERT INTO creature_text VALUES (18639, 0, 5, "The Legion reigns!", 12, 0, 100, 0, 0, 0, 0, 'Cabal Spellbinder');
UPDATE creature_template SET pickpocketloot=18639, AIName='SmartAI', ScriptName='' WHERE entry=18639;
UPDATE creature_template SET pickpocketloot=18639, AIName='', ScriptName='' WHERE entry=20647;
DELETE FROM smart_scripts WHERE entryorguid=18639 AND source_type=0;
INSERT INTO smart_scripts VALUES (18639, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cabal Spellbinder - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18639, 0, 1, 0, 0, 0, 100, 0, 0, 0, 4000, 4000, 11, 15232, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cabal Spellbinder - In Combat - Cast Shadow bolt');
INSERT INTO smart_scripts VALUES (18639, 0, 2, 0, 13, 0, 100, 0, 8000, 8000, 0, 0, 11, 32691, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cabal Spellbinder - On Target Cast - Cast Spell Shock');



-- -------------------------------------------
--                BOSSES
-- -------------------------------------------
-- Ambassador Hellmaw (18731, 20636)
UPDATE creature_template SET speed_run=1.71429, pickpocketloot=18731, mechanic_immune_mask=612646911, AIName='', ScriptName='boss_ambassador_hellmaw' WHERE entry=18731;
UPDATE creature_template SET speed_run=1.71429, pickpocketloot=18731, mechanic_immune_mask=612646911, AIName='', ScriptName='' WHERE entry=20636;
DELETE FROM smart_scripts WHERE entryorguid=18731 AND source_type=0;

-- Blackheart the Inciter (18667, 20637)
UPDATE creature_template SET speed_run=1.71429, pickpocketloot=18667, AIName='', ScriptName='boss_blackheart_the_inciter' WHERE entry=18667;
UPDATE creature_template SET speed_run=1.71429, pickpocketloot=18667, AIName='', ScriptName='' WHERE entry=20637;
DELETE FROM smart_scripts WHERE entryorguid=18667 AND source_type=0;

-- Grandmaster Vorpil (18732, 20653)
UPDATE creature_template SET speed_run=1.42857, pickpocketloot=18732, AIName='', ScriptName='boss_grandmaster_vorpil' WHERE entry=18732;
UPDATE creature_template SET speed_run=1.42857, pickpocketloot=18732, AIName='', ScriptName='' WHERE entry=20653;
DELETE FROM smart_scripts WHERE entryorguid=18732 AND source_type=0;
-- Void Traveler (19226, 20664)
UPDATE creature_template SET AIName='', ScriptName='npc_voidtraveler' WHERE entry=19226;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=20664;
DELETE FROM smart_scripts WHERE entryorguid=19226 AND source_type=0;
-- Void Portal (19224, 20663)
UPDATE creature_template SET AIName='NullCreatureAI', ScriptName='' WHERE entry=19224;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=20663;
DELETE FROM smart_scripts WHERE entryorguid=19224 AND source_type=0;

-- Murmur (18708, 20657)
DELETE FROM creature_text WHERE entry=18708;
INSERT INTO creature_text VALUES (18708, 0, 0, "%s draws energy from the air.", 42, 0, 100, 0, 0, 0, 0, 'Murmur EMOTE_SONIC_BOOM');
UPDATE creature_template SET pickpocketloot=18708, AIName='', ScriptName='boss_murmur' WHERE entry=18708;
UPDATE creature_template SET pickpocketloot=18708, AIName='', ScriptName='' WHERE entry=20657;
DELETE FROM smart_scripts WHERE entryorguid=18708 AND source_type=0;
DELETE FROM spell_script_names WHERE spell_id IN(33666, 38795);
INSERT INTO spell_script_names VALUES(33666, 'spell_murmur_sonic_boom_effect');
INSERT INTO spell_script_names VALUES(38795, 'spell_murmur_sonic_boom_effect');
DELETE FROM spell_script_names WHERE spell_id IN(39365);
INSERT INTO spell_script_names VALUES(39365, 'spell_murmur_thundering_storm');
-- TC
DELETE FROM spell_script_names WHERE ScriptName='spell_murmur_sonic_boom' AND spell_id IN(33923, 38796);

-- -------------------------------------------
--                MISC
-- -------------------------------------------
