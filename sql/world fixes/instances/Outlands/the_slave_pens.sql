
UPDATE creature SET spawntimesecs=86400 WHERE map=547 AND spawntimesecs>0;

-- -------------------------------------------
--               FORMATIONS
-- -------------------------------------------


-- -------------------------------------------
--                TRASH
-- -------------------------------------------
-- Bogstrok (17816, 19884)
UPDATE creature_template SET pickpocketloot=17816, mechanic_immune_mask=65553, AIName='SmartAI', ScriptName='' WHERE entry=17816;
UPDATE creature_template SET pickpocketloot=17816, mechanic_immune_mask=65553, AIName='', ScriptName='' WHERE entry=19884;
DELETE FROM smart_scripts WHERE entryorguid=17816 AND source_type=0;
INSERT INTO smart_scripts VALUES (17816, 0, 0, 0, 0, 0, 100, 0, 4100, 11900, 15700, 15700, 11, 31551, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bogstrok - In Combat - Cast Piercing Jab');

-- Greater Bogstrok (17817, 19892)
UPDATE creature_template SET pickpocketloot=17817, mechanic_immune_mask=65553, AIName='SmartAI', ScriptName='' WHERE entry=17817;
UPDATE creature_template SET pickpocketloot=17817, mechanic_immune_mask=65553, AIName='', ScriptName='' WHERE entry=19892;
DELETE FROM smart_scripts WHERE entryorguid=17817 AND source_type=0;
INSERT INTO smart_scripts VALUES (17817, 0, 0, 0, 0, 0, 100, 0, 6000, 13900, 7000, 13000, 11, 35760, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Greater Bogstrok - In Combat - Cast Decayed Strength');

-- Coilfang Slavehandler (17959, 19889)
DELETE FROM creature_text WHERE entry=17959;
INSERT INTO creature_text VALUES (17959, 0, 0, "Get back to work you!", 14, 0, 100, 0, 0, 0, 0, 'Coilfang Slavehandler');
INSERT INTO creature_text VALUES (17959, 0, 1, "Hurry up with it already! The longer you take, the more of a hurtin' I'm putting on you!", 14, 0, 100, 0, 0, 0, 0, 'Coilfang Slavehandler');
INSERT INTO creature_text VALUES (17959, 0, 2, "This is terrible..... my arms grow tired from beating on you lazy peons!", 14, 0, 100, 0, 0, 0, 0, 'Coilfang Slavehandler');
INSERT INTO creature_text VALUES (17959, 0, 3, "Too soon! You are slacking off too soon!", 14, 0, 100, 0, 0, 0, 0, 'Coilfang Slavehandler');
INSERT INTO creature_text VALUES (17959, 0, 4, "Wake up! Now get up and back to work!", 14, 0, 100, 0, 0, 0, 0, 'Coilfang Slavehandler');
INSERT INTO creature_text VALUES (17959, 0, 5, "What is this?! Didn't mommy and daddy teach you anything?!", 14, 0, 100, 0, 0, 0, 0, 'Coilfang Slavehandler');
INSERT INTO creature_text VALUES (17959, 1, 0, "By Nazjatar's Depths!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Slavehandler');
INSERT INTO creature_text VALUES (17959, 1, 1, "Die, warmblood!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Slavehandler');
INSERT INTO creature_text VALUES (17959, 1, 2, "For the Master!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Slavehandler');
INSERT INTO creature_text VALUES (17959, 1, 3, "Illidan reigns!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Slavehandler');
INSERT INTO creature_text VALUES (17959, 1, 4, "My blood is like venom!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Slavehandler');
UPDATE creature_template SET pickpocketloot=17959, mechanic_immune_mask=0, AIName='SmartAI', ScriptName='' WHERE entry=17959;
UPDATE creature_template SET pickpocketloot=17959, mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=19889;
DELETE FROM smart_scripts WHERE entryorguid=17959 AND source_type=0;
INSERT INTO smart_scripts VALUES (17959, 0, 0, 0, 4, 0, 75, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Slavehandler - On Aggro - Say Line 1');
INSERT INTO smart_scripts VALUES (17959, 0, 1, 0, 0, 0, 100, 0, 5800, 6200, 9000, 9000, 11, 9080, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Slavehandler - In Combat - Cast Hamstring');
INSERT INTO smart_scripts VALUES (17959, 0, 2, 0, 0, 0, 100, 0, 11100, 11100, 20000, 20000, 11, 16172, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Slavehandler - In Combat - Cast Head Crack');
INSERT INTO smart_scripts VALUES (17959, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 11, 17964, 15, 1, 0, 0, 0, 0, 'Coilfang Slavehandler - On Aggro - Set Data 2 2');
INSERT INTO smart_scripts VALUES (17959, 0, 4, 0, 4, 0, 100, 0, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 11, 17963, 15, 1, 0, 0, 0, 0, 'Coilfang Slavehandler - On Aggro - Set Data 2 2');
INSERT INTO smart_scripts VALUES (17959, 0, 5, 6, 1, 0, 100, 0, 5000, 25000, 20000, 40000, 11, 6754, 0, 0, 0, 0, 0, 19, 17964, 5, 0, 0, 0, 0, 0, 'Coilfang Slavehandler - Out Of Combat - Cast Slap!');
INSERT INTO smart_scripts VALUES (17959, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Slavehandler - Out Of Combat - Say Line 0');
INSERT INTO smart_scripts VALUES (17959, 0, 7, 0, 6, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 11, 17964, 15, 1, 0, 0, 0, 0, 'Coilfang Slavehandler - On Death - Set Data 1 1');
INSERT INTO smart_scripts VALUES (17959, 0, 8, 0, 6, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 11, 17963, 15, 1, 0, 0, 0, 0, 'Coilfang Slavehandler - On Death - Set Data 1 1');

-- Wastewalker Worker (17964, 19904)
DELETE FROM creature_text WHERE entry=17964;
INSERT INTO creature_text VALUES (17964, 0, 0, "Free at last!", 14, 0, 100, 0, 0, 0, 0, 'Wastewalker Worker');
INSERT INTO creature_text VALUES (17964, 0, 1, "Will the pain ever end?", 14, 0, 100, 0, 0, 0, 0, 'Wastewalker Worker');
INSERT INTO creature_text VALUES (17964, 0, 2, "We have waited forever for this day to come!", 14, 0, 100, 0, 0, 0, 0, 'Wastewalker Worker');
INSERT INTO creature_text VALUES (17964, 0, 3, "The pain is finally over.", 14, 0, 100, 0, 0, 0, 0, 'Wastewalker Worker');
INSERT INTO creature_text VALUES (17964, 0, 4, "How can we ever repay you for this?", 14, 0, 100, 0, 0, 0, 0, 'Wastewalker Worker');
INSERT INTO creature_text VALUES (17964, 0, 5, "I spit on the corpse of these filthy naga.", 14, 0, 100, 0, 0, 0, 0, 'Wastewalker Worker');
INSERT INTO creature_text VALUES (17964, 0, 6, "Thank you!", 14, 0, 100, 0, 0, 0, 0, 'Wastewalker Worker');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=17964;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=19904;
DELETE FROM smart_scripts WHERE entryorguid=17964 AND source_type=0;
INSERT INTO smart_scripts VALUES (17964, 0, 0, 0, 0, 0, 100, 2, 2300, 7700, 9000, 11000, 11, 13738, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wastewalker Worker - In Combat - Cast Rend');
INSERT INTO smart_scripts VALUES (17964, 0, 1, 0, 0, 0, 100, 4, 2300, 7700, 9000, 11000, 11, 37662, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wastewalker Worker - In Combat - Cast Rend');
INSERT INTO smart_scripts VALUES (17964, 0, 2, 3, 38, 0, 100, 0, 1, 1, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 63.3, -58.76, -1.5, 0, 'Wastewalker Worker - On Data Set - Move Point');
INSERT INTO smart_scripts VALUES (17964, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wastewalker Worker - On Data Set - Despawn');
INSERT INTO smart_scripts VALUES (17964, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wastewalker Worker - On Data Set - Say Line 0');
INSERT INTO smart_scripts VALUES (17964, 0, 5, 0, 38, 0, 100, 0, 2, 2, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Wastewalker Worker - On Data Set - Attack Start');

-- Wastewalker Slave (17963, 19902)
DELETE FROM creature_text WHERE entry=17963;
INSERT INTO creature_text VALUES (17963, 0, 0, "Free at last!", 14, 0, 100, 0, 0, 0, 0, 'Wastewalker Slave');
INSERT INTO creature_text VALUES (17963, 0, 1, "Will the pain ever end?", 14, 0, 100, 0, 0, 0, 0, 'Wastewalker Slave');
INSERT INTO creature_text VALUES (17963, 0, 2, "We have waited forever for this day to come!", 14, 0, 100, 0, 0, 0, 0, 'Wastewalker Slave');
INSERT INTO creature_text VALUES (17963, 0, 3, "The pain is finally over.", 14, 0, 100, 0, 0, 0, 0, 'Wastewalker Slave');
INSERT INTO creature_text VALUES (17963, 0, 4, "How can we ever repay you for this?", 14, 0, 100, 0, 0, 0, 0, 'Wastewalker Slave');
INSERT INTO creature_text VALUES (17963, 0, 5, "I spit on the corpse of these filthy naga.", 14, 0, 100, 0, 0, 0, 0, 'Wastewalker Slave');
INSERT INTO creature_text VALUES (17963, 0, 6, "Thank you!", 14, 0, 100, 0, 0, 0, 0, 'Wastewalker Slave');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=17963;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=19902;
DELETE FROM smart_scripts WHERE entryorguid=17963 AND source_type=0;
INSERT INTO smart_scripts VALUES (17963, 0, 0, 0, 1, 0, 100, 0, 1000, 1000, 900000, 900000, 11, 34880, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wastewalker Slave - Out of Combat - Cast Elemental Armor');
INSERT INTO smart_scripts VALUES (17963, 0, 1, 0, 0, 0, 100, 2, 6000, 7700, 19000, 21000, 11, 32192, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wastewalker Slave - In Combat - Cast Frost Nova');
INSERT INTO smart_scripts VALUES (17963, 0, 2, 0, 0, 0, 100, 4, 6000, 7700, 19000, 21000, 11, 15531, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wastewalker Slave - In Combat - Cast Frost Nova');
INSERT INTO smart_scripts VALUES (17963, 0, 3, 0, 0, 0, 100, 2, 1300, 3700, 5000, 8000, 11, 15497, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wastewalker Slave - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (17963, 0, 4, 0, 0, 0, 100, 4, 1300, 3700, 5000, 8000, 11, 12675, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wastewalker Slave - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (17963, 0, 5, 6, 38, 0, 100, 0, 1, 1, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 63.3, -58.76, -1.5, 0, 'Wastewalker Slave - On Data Set - Move Point');
INSERT INTO smart_scripts VALUES (17963, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wastewalker Slave - On Data Set - Despawn');
INSERT INTO smart_scripts VALUES (17963, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wastewalker Slave - On Data Set - Say Line 0');
INSERT INTO smart_scripts VALUES (17963, 0, 8, 0, 38, 0, 100, 0, 2, 2, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Wastewalker Slave - On Data Set - Attack Start');

-- Coilfang Champion (17957, 19885)
DELETE FROM creature_text WHERE entry=17957;
INSERT INTO creature_text VALUES (17957, 0, 0, "By Nazjatar's Depths!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Champion');
INSERT INTO creature_text VALUES (17957, 0, 1, "Die, warmblood!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Champion');
INSERT INTO creature_text VALUES (17957, 0, 2, "For the Master!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Champion');
INSERT INTO creature_text VALUES (17957, 0, 3, "Illidan reigns!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Champion');
INSERT INTO creature_text VALUES (17957, 0, 4, "My blood is like venom!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Champion');
UPDATE creature_template SET pickpocketloot=17957, AIName='SmartAI', ScriptName='' WHERE entry=17957;
UPDATE creature_template SET pickpocketloot=17957, AIName='', ScriptName='' WHERE entry=19885;
DELETE FROM smart_scripts WHERE entryorguid=17957 AND source_type=0;
INSERT INTO smart_scripts VALUES (17957, 0, 0, 0, 4, 0, 75, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Champion - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (17957, 0, 1, 0, 0, 0, 100, 0, 14200, 16200, 29000, 29000, 11, 19134, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Champion - In Combat - Cast Frightening Shout');
INSERT INTO smart_scripts VALUES (17957, 0, 2, 0, 0, 0, 100, 0, 4700, 9000, 11900, 17000, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Champion - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (17957, 0, 3, 0, 0, 0, 100, 0, 9500, 13100, 15100, 23000, 11, 16145, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Champion - In Combat - Cast Sunder Armor');

-- Coilfang Enchantress (17961, 19887)
DELETE FROM creature_text WHERE entry=17961;
INSERT INTO creature_text VALUES (17961, 0, 0, "By Nazjatar's Depths!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Enchantress');
INSERT INTO creature_text VALUES (17961, 0, 1, "Die, warmblood!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Enchantress');
INSERT INTO creature_text VALUES (17961, 0, 2, "For the Master!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Enchantress');
INSERT INTO creature_text VALUES (17961, 0, 3, "Illidan reigns!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Enchantress');
INSERT INTO creature_text VALUES (17961, 0, 4, "My blood is like venom!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Enchantress');
UPDATE creature_template SET pickpocketloot=17961, mechanic_immune_mask=0, AIName='SmartAI', ScriptName='' WHERE entry=17961;
UPDATE creature_template SET pickpocketloot=17961, mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=19887;
DELETE FROM smart_scripts WHERE entryorguid=17961 AND source_type=0;
INSERT INTO smart_scripts VALUES (17961, 0, 0, 0, 4, 0, 75, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Enchantress - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (17961, 0, 1, 0, 0, 0, 100, 0, 7200, 8200, 19000, 21000, 11, 32173, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Enchantress - In Combat - Cast Entangling Roots');
INSERT INTO smart_scripts VALUES (17961, 0, 2, 0, 0, 0, 100, 2, 4700, 5000, 8900, 10000, 11, 15234, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Enchantress - In Combat - Cast Lightning Bolt');
INSERT INTO smart_scripts VALUES (17961, 0, 3, 0, 0, 0, 100, 4, 4700, 5000, 8900, 10000, 11, 37664, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Enchantress - In Combat - Cast Lightning Bolt');
INSERT INTO smart_scripts VALUES (17961, 0, 4, 0, 0, 0, 100, 2, 10500, 13100, 12100, 15000, 11, 32193, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Enchantress - In Combat - Cast Lightning Cloud');
INSERT INTO smart_scripts VALUES (17961, 0, 5, 0, 0, 0, 100, 4, 10500, 13100, 12100, 15000, 11, 37665, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Enchantress - In Combat - Cast Lightning Cloud');

-- Coilfang Observer (17938, 19888)
DELETE FROM creature_text WHERE entry=17938;
INSERT INTO creature_text VALUES (17938, 0, 0, "By Nazjatar's Depths!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Observer');
INSERT INTO creature_text VALUES (17938, 0, 1, "Die, warmblood!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Observer');
INSERT INTO creature_text VALUES (17938, 0, 2, "For the Master!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Observer');
INSERT INTO creature_text VALUES (17938, 0, 3, "Illidan reigns!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Observer');
INSERT INTO creature_text VALUES (17938, 0, 4, "My blood is like venom!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Observer');
UPDATE creature_template SET pickpocketloot=17938, AIName='SmartAI', ScriptName='' WHERE entry=17938;
UPDATE creature_template SET pickpocketloot=17938, AIName='', ScriptName='' WHERE entry=19888;
DELETE FROM smart_scripts WHERE entryorguid=17938 AND source_type=0;
INSERT INTO smart_scripts VALUES (17938, 0, 0, 0, 4, 0, 75, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Observer - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (17938, 0, 1, 0, 0, 0, 100, 2, 4700, 5000, 8900, 10000, 11, 32191, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Observer - In Combat - Cast Lightning Bolt');
INSERT INTO smart_scripts VALUES (17938, 0, 2, 0, 0, 0, 100, 4, 4700, 5000, 8900, 10000, 11, 37666, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Observer - In Combat - Cast Lightning Bolt');
INSERT INTO smart_scripts VALUES (17938, 0, 3, 0, 0, 0, 100, 2, 10500, 13100, 12100, 15000, 11, 17883, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Observer - In Combat - Cast Lightning Cloud');
INSERT INTO smart_scripts VALUES (17938, 0, 4, 0, 0, 0, 100, 4, 10500, 13100, 12100, 15000, 11, 37668, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Observer - In Combat - Cast Lightning Cloud');

-- Coilfang Ray <Observer's Pet> (21128, 21841)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=21128;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=21841;
DELETE FROM smart_scripts WHERE entryorguid=21128 AND source_type=0;
INSERT INTO smart_scripts VALUES (21128, 0, 0, 0, 0, 0, 100, 0, 1300, 5000, 12100, 21300, 11, 34984, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Ray - In Combat - Cast Psychic Horror');
	
-- Coilfang Soothsayer (17960, 19890)
DELETE FROM creature_text WHERE entry=17960;
INSERT INTO creature_text VALUES (17960, 0, 0, "By Nazjatar's Depths!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Soothsayer');
INSERT INTO creature_text VALUES (17960, 0, 1, "Die, warmblood!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Soothsayer');
INSERT INTO creature_text VALUES (17960, 0, 2, "For the Master!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Soothsayer');
INSERT INTO creature_text VALUES (17960, 0, 3, "Illidan reigns!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Soothsayer');
INSERT INTO creature_text VALUES (17960, 0, 4, "My blood is like venom!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Soothsayer');
UPDATE creature_template SET pickpocketloot=17960, AIName='SmartAI', ScriptName='' WHERE entry=17960;
UPDATE creature_template SET pickpocketloot=17960, AIName='', ScriptName='' WHERE entry=19890;
DELETE FROM smart_scripts WHERE entryorguid=17960 AND source_type=0;
INSERT INTO smart_scripts VALUES (17960, 0, 0, 0, 4, 0, 75, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Soothsayer - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (17960, 0, 1, 0, 0, 0, 100, 0, 1700, 3000, 5900, 8000, 11, 15791, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Soothsayer - In Combat - Cast Arcane Missiles');
INSERT INTO smart_scripts VALUES (17960, 0, 2, 0, 0, 0, 100, 0, 12200, 13400, 8000, 11000, 11, 31555, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Soothsayer - In Combat - Cast Decayed Intellect');
INSERT INTO smart_scripts VALUES (17960, 0, 3, 0, 0, 0, 100, 0, 9700, 10900, 12000, 18000, 11, 30923, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Soothsayer - In Combat - Cast Domination');
	
-- Coilfang Defender (17958, 19886)
DELETE FROM creature_text WHERE entry=17958;
INSERT INTO creature_text VALUES (17958, 0, 0, "By Nazjatar's Depths!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Defender');
INSERT INTO creature_text VALUES (17958, 0, 1, "Die, warmblood!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Defender');
INSERT INTO creature_text VALUES (17958, 0, 2, "For the Master!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Defender');
INSERT INTO creature_text VALUES (17958, 0, 3, "Illidan reigns!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Defender');
INSERT INTO creature_text VALUES (17958, 0, 4, "My blood is like venom!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Defender');
UPDATE creature_template SET pickpocketloot=17958, AIName='SmartAI', ScriptName='' WHERE entry=17958;
UPDATE creature_template SET pickpocketloot=17958, AIName='', ScriptName='' WHERE entry=19886;
DELETE FROM smart_scripts WHERE entryorguid=17958 AND source_type=0;
INSERT INTO smart_scripts VALUES (17958, 0, 0, 0, 4, 0, 75, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Defender - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (17958, 0, 1, 0, 0, 0, 100, 0, 1700, 3000, 9000, 11000, 11, 15655, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Defender - In Combat - Cast Shield Slam');
INSERT INTO smart_scripts VALUES (17958, 0, 2, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 11, 18950, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Defender - Out of Combat - Cast Detection');
INSERT INTO smart_scripts VALUES (17958, 0, 3, 0, 0, 0, 100, 0, 9700, 10900, 22000, 28000, 11, 31554, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Defender - In Combat - Cast Spell Reflection');

-- Coilfang Technician (17940, 19891)
DELETE FROM creature_text WHERE entry=17940;
INSERT INTO creature_text VALUES (17940, 0, 0, "By Nazjatar's Depths!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Technician');
INSERT INTO creature_text VALUES (17940, 0, 1, "Die, warmblood!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Technician');
INSERT INTO creature_text VALUES (17940, 0, 2, "For the Master!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Technician');
INSERT INTO creature_text VALUES (17940, 0, 3, "Illidan reigns!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Technician');
INSERT INTO creature_text VALUES (17940, 0, 4, "My blood is like venom!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Technician');
UPDATE creature_template SET pickpocketloot=17940, AIName='SmartAI', ScriptName='' WHERE entry=17940;
UPDATE creature_template SET pickpocketloot=17940, AIName='', ScriptName='' WHERE entry=19891;
DELETE FROM smart_scripts WHERE entryorguid=17940 AND source_type=0;
INSERT INTO smart_scripts VALUES (17940, 0, 0, 0, 4, 0, 75, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Technician - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (17940, 0, 1, 0, 0, 0, 100, 0, 1700, 3000, 29000, 31000, 11, 21096, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Technician - In Combat - Cast Blizzard');
INSERT INTO smart_scripts VALUES (17940, 0, 2, 0, 0, 0, 100, 2, 13700, 14900, 29000, 31000, 11, 16005, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Technician - In Combat - Cast Rain of Fire');
INSERT INTO smart_scripts VALUES (17940, 0, 3, 0, 0, 0, 100, 4, 13700, 14900, 29000, 31000, 11, 39376, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Technician - In Combat - Cast Rain of Fire');

-- Coilfang Collaborator (17962, 19903)
UPDATE creature_template SET pickpocketloot=17962, AIName='SmartAI', ScriptName='' WHERE entry=17962;
UPDATE creature_template SET pickpocketloot=17962, AIName='', ScriptName='' WHERE entry=19903;
DELETE FROM smart_scripts WHERE entryorguid=17962 AND source_type=0;
INSERT INTO smart_scripts VALUES (17962, 0, 0, 0, 0, 0, 100, 0, 1700, 3000, 19000, 21000, 11, 33787, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Collaborator - In Combat - Cast Cripple');
INSERT INTO smart_scripts VALUES (17962, 0, 1, 0, 0, 0, 100, 0, 5700, 6900, 6000, 9000, 11, 19130, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Collaborator - In Combat - Cast Revenge');
INSERT INTO smart_scripts VALUES (17962, 0, 2, 0, 2, 0, 100, 1, 0, 30, 0, 0, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Collaborator - At 30% HP - Cast Frenzy');

-- Coilfang Tempest (21127, 21843)
DELETE FROM creature_text WHERE entry=21127;
INSERT INTO creature_text VALUES (21127, 0, 0, "By Nazjatar's Depths!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Tempest');
INSERT INTO creature_text VALUES (21127, 0, 1, "Die, warmblood!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Tempest');
INSERT INTO creature_text VALUES (21127, 0, 2, "For the Master!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Tempest');
INSERT INTO creature_text VALUES (21127, 0, 3, "Illidan reigns!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Tempest');
INSERT INTO creature_text VALUES (21127, 0, 4, "My blood is like venom!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Tempest');
UPDATE creature_template SET pickpocketloot=21127, AIName='SmartAI', ScriptName='' WHERE entry=21127;
UPDATE creature_template SET pickpocketloot=21127, AIName='', ScriptName='' WHERE entry=21843;
DELETE FROM smart_scripts WHERE entryorguid=21127 AND source_type=0;
INSERT INTO smart_scripts VALUES (21127, 0, 0, 0, 4, 0, 75, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Tempest - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (21127, 0, 1, 0, 0, 0, 100, 0, 1700, 3000, 5000, 7000, 11, 15667, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Tempest - In Combat - Cast Sinister Strike');
INSERT INTO smart_scripts VALUES (21127, 0, 2, 0, 0, 0, 100, 0, 6700, 7900, 13000, 15000, 11, 36872, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Tempest - In Combat - Cast Deadly Poison');

-- Coilfang Scale-Healer (21126, 21842)
DELETE FROM creature_text WHERE entry=21126;
INSERT INTO creature_text VALUES (21126, 0, 0, "By Nazjatar's Depths!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Scale-Healer');
INSERT INTO creature_text VALUES (21126, 0, 1, "Die, warmblood!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Scale-Healer');
INSERT INTO creature_text VALUES (21126, 0, 2, "For the Master!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Scale-Healer');
INSERT INTO creature_text VALUES (21126, 0, 3, "Illidan reigns!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Scale-Healer');
INSERT INTO creature_text VALUES (21126, 0, 4, "My blood is like venom!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Scale-Healer');
UPDATE creature_template SET pickpocketloot=21126, AIName='SmartAI', ScriptName='' WHERE entry=21126;
UPDATE creature_template SET pickpocketloot=21126, AIName='', ScriptName='' WHERE entry=21842;
DELETE FROM smart_scripts WHERE entryorguid=21126 AND source_type=0;
INSERT INTO smart_scripts VALUES (21126, 0, 0, 0, 4, 0, 75, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Scale-Healer - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (21126, 0, 1, 0, 14, 0, 100, 2, 1000, 40, 7000, 10000, 11, 34945, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Scale-Healer - HP Friendly - Cast Heal');
INSERT INTO smart_scripts VALUES (21126, 0, 2, 0, 14, 0, 100, 4, 1000, 40, 7000, 10000, 11, 39378, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Scale-Healer - HP Friendly - Cast Heal');
INSERT INTO smart_scripts VALUES (21126, 0, 3, 0, 0, 0, 100, 2, 6700, 7900, 16000, 18000, 11, 34944, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Scale-Healer - In Combat - Cast Holy Nova');
INSERT INTO smart_scripts VALUES (21126, 0, 4, 0, 0, 0, 100, 4, 6700, 7900, 16000, 18000, 11, 37669, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Scale-Healer - In Combat - Cast Holy Nova');
INSERT INTO smart_scripts VALUES (21126, 0, 5, 0, 16, 0, 100, 2, 17139, 40, 7000, 10000, 11, 17139, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Scale-Healer - Missing Buff - Cast Power Word: Shield');
INSERT INTO smart_scripts VALUES (21126, 0, 6, 0, 16, 0, 100, 4, 36052, 40, 7000, 10000, 11, 36052, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Scale-Healer - Missing Buff - Cast Power Word: Shield');


-- -------------------------------------------
--                BOSSES
-- -------------------------------------------
-- Mennu the Betrayer (17941, 19893)
DELETE FROM creature_text WHERE entry=17941;
INSERT INTO creature_text VALUES (17941, 0, 0, "The work must continue.", 14, 0, 100, 0, 0, 10376, 0, 'Mennu the Betrayer');
INSERT INTO creature_text VALUES (17941, 0, 1, "Don't make me kill you!", 14, 0, 100, 0, 0, 10378, 0, 'Mennu the Betrayer');
INSERT INTO creature_text VALUES (17941, 0, 2, "You brought this on yourselves.", 14, 0, 100, 0, 0, 10379, 0, 'Mennu the Betrayer');
INSERT INTO creature_text VALUES (17941, 1, 0, "It had to be done.", 14, 0, 100, 0, 0, 10380, 0, 'Mennu the Betrayer');
INSERT INTO creature_text VALUES (17941, 1, 1, "You should not have come.", 14, 0, 100, 0, 0, 10381, 0, 'Mennu the Betrayer');
INSERT INTO creature_text VALUES (17941, 2, 0, "I... Deserve this.", 14, 0, 100, 0, 0, 10382, 0, 'Mennu the Betrayer');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=17941;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=19893;
DELETE FROM smart_scripts WHERE entryorguid=17941 AND source_type=0;
INSERT INTO smart_scripts VALUES (17941, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mennu the Betrayer - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (17941, 0, 1, 0, 5, 0, 100, 0, 1000, 1000, 1, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mennu the Betrayer - On Kill - Say Line 1');
INSERT INTO smart_scripts VALUES (17941, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mennu the Betrayer - On Death - Say Line 2');
INSERT INTO smart_scripts VALUES (17941, 0, 3, 0, 0, 0, 100, 0, 18000, 18000, 26000, 26000, 11, 31985, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mennu the Betrayer - In Combat - Cast Tained Stoneskin Totem');
INSERT INTO smart_scripts VALUES (17941, 0, 4, 0, 0, 0, 100, 0, 19200, 19200, 26000, 26000, 11, 31981, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mennu the Betrayer - In Combat - Cast Tained Earthgrab Totem');
INSERT INTO smart_scripts VALUES (17941, 0, 5, 0, 0, 0, 100, 0, 20000, 20000, 26000, 26000, 11, 31991, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mennu the Betrayer - In Combat - Cast Corrupted Nova Totem');
INSERT INTO smart_scripts VALUES (17941, 0, 6, 0, 2, 0, 100, 0, 0, 60, 20000, 30000, 11, 34980, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mennu the Betrayer - At 60% HP - Cast Mennu Healing Ward');
INSERT INTO smart_scripts VALUES (17941, 0, 7, 0, 0, 0, 100, 0, 5000, 8000, 7000, 10000, 11, 35010, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mennu the Betrayer - In Combat - Cast Lightning Bolt');
-- Tainted Stoneskin Totem (18177, 19900)
UPDATE creature_template SET faction=74, spell1=31986, AIName='NullCreatureAI', ScriptName='' WHERE entry=18177;
UPDATE creature_template SET faction=74, spell1=31986, AIName='', ScriptName='' WHERE entry=19900;
DELETE FROM smart_scripts WHERE entryorguid=18177 AND source_type=0;
-- Tainted Earthgrab Totem (18176, 19897)
UPDATE creature_template SET faction=74, spell1=31982, AIName='NullCreatureAI', ScriptName='' WHERE entry=18176;
UPDATE creature_template SET faction=74, spell1=31982, AIName='', ScriptName='' WHERE entry=19897;
DELETE FROM smart_scripts WHERE entryorguid=18176 AND source_type=0;
-- Corrupted Nova Totem (18179, 19899)
UPDATE creature_template SET faction=74, spell1=33134, AIName='SmartAI', ScriptName='' WHERE entry=18179;
UPDATE creature_template SET faction=74, spell1=33134, AIName='', ScriptName='' WHERE entry=19899;
DELETE FROM smart_scripts WHERE entryorguid=18179 AND source_type=0;
INSERT INTO smart_scripts VALUES (18179, 0, 0, 0, 6, 0, 100, 2, 0, 0, 0, 0, 11, 33132, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Nova Totem - On Death - Cast Fire Nova');
INSERT INTO smart_scripts VALUES (18179, 0, 1, 6, 60, 0, 100, 3, 5000, 5000, 0, 0, 11, 33132, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Nova Totem - In Combat - Cast Fire Nova');
INSERT INTO smart_scripts VALUES (18179, 0, 2, 0, 6, 0, 100, 4, 0, 0, 0, 0, 11, 33132, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Nova Totem - On Death - Cast Fire Nova');
INSERT INTO smart_scripts VALUES (18179, 0, 3, 6, 60, 0, 100, 5, 15000, 15000, 0, 0, 11, 33132, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Nova Totem - In Combat - Cast Fire Nova');
INSERT INTO smart_scripts VALUES (18179, 0, 4, 0, 60, 0, 100, 1, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Nova Totem - On Update - Disable Combat Movement');
INSERT INTO smart_scripts VALUES (18179, 0, 5, 0, 60, 0, 100, 1, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Nova Totem - On Update - Disable Auto Attack');
INSERT INTO smart_scripts VALUES (18179, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Nova Totem - On Update - Despawn');
-- Mennu's Healing Ward (20208, 22322)
UPDATE creature_template SET faction=74, spell1=34978, AIName='NullCreatureAI', ScriptName='' WHERE entry=20208;
UPDATE creature_template SET faction=74, spell1=38799, AIName='', ScriptName='' WHERE entry=22322;

-- Rokmar the Crackler (17991, 19895)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=17991;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=19895;
DELETE FROM smart_scripts WHERE entryorguid=17991 AND source_type=0;
INSERT INTO smart_scripts VALUES (17991, 0, 0, 0, 0, 0, 100, 2, 8000, 8000, 20700, 20700, 11, 31956, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rokmar the Crackler - In Combat - Cast Grievous Wound');
INSERT INTO smart_scripts VALUES (17991, 0, 1, 0, 0, 0, 100, 4, 8000, 8000, 20700, 20700, 11, 38801, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rokmar the Crackler - In Combat - Grievous Wound');
INSERT INTO smart_scripts VALUES (17991, 0, 2, 0, 0, 0, 100, 0, 15300, 15300, 26000, 26000, 11, 31948, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Rokmar the Crackler - In Combat - Cast Ensnaring Moss');
INSERT INTO smart_scripts VALUES (17991, 0, 3, 0, 0, 0, 100, 0, 10700, 10700, 19000, 19000, 11, 35008, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rokmar the Crackler - In Combat - Cast Water Spit');
INSERT INTO smart_scripts VALUES (17991, 0, 4, 0, 2, 0, 100, 1, 0, 20, 0, 0, 11, 34970, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rokmar the Crackler - At 20% HP - Cast Frenzy');

-- Quagmirran (17942, 19894)
UPDATE creature_template SET speed_run=2, AIName='SmartAI', ScriptName='' WHERE entry=17942;
UPDATE creature_template SET speed_run=2, AIName='', ScriptName='' WHERE entry=19894;
DELETE FROM smart_scripts WHERE entryorguid=17942 AND source_type=0;
INSERT INTO smart_scripts VALUES (17942, 0, 0, 0, 0, 0, 100, 0, 9100, 9100, 18800, 24800, 11, 40504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Quagmirran - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (17942, 0, 1, 0, 0, 0, 100, 0, 20300, 20300, 21800, 21800, 11, 32055, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Quagmirran - In Combat - Uppercut');
INSERT INTO smart_scripts VALUES (17942, 0, 2, 0, 0, 0, 100, 0, 25200, 25200, 25000, 25000, 11, 38153, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Quagmirran - In Combat - Cast Acid Spray');
INSERT INTO smart_scripts VALUES (17942, 0, 3, 0, 0, 0, 100, 2, 31800, 31800, 24400, 24400, 11, 34780, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Quagmirran - In Combat - Poison Bolt Volley');
INSERT INTO smart_scripts VALUES (17942, 0, 4, 0, 0, 0, 100, 4, 31800, 31800, 24400, 24400, 11, 39340, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Quagmirran - In Combat - Poison Bolt Volley');


-- -------------------------------------------
--                MISC
-- -------------------------------------------
-- Wastewalker Captive (18206, 19901)
DELETE FROM creature_text WHERE entry=18206;
INSERT INTO creature_text VALUES (18206, 0, 0, "Will the pain ever end?", 12, 0, 100, 0, 0, 0, 0, 'Wastewalker Captive');
INSERT INTO creature_text VALUES (18206, 0, 1, "Help me!  Please help me!", 12, 0, 100, 0, 0, 0, 0, 'Wastewalker Captive');
INSERT INTO creature_text VALUES (18206, 0, 2, "How can you just leave me here?", 12, 0, 100, 0, 0, 0, 0, 'Wastewalker Captive');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=18206;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=19901;
DELETE FROM smart_scripts WHERE entryorguid=18206 AND source_type=0;
INSERT INTO smart_scripts VALUES (18206, 0, 0, 0, 1, 0, 100, 0, 5000, 25000, 30000, 50000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wastewalker Captive - Out of Combat - Say Line 0');
