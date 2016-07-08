
UPDATE creature SET spawntimesecs=86400 WHERE map=585 AND spawntimesecs>0;

-- -------------------------------------------
--               FORMATIONS
-- -------------------------------------------


-- -------------------------------------------
--                TRASH
-- -------------------------------------------

-- Sunblade Mage Guard (24683, 25568)
UPDATE creature_template SET pickpocketloot=24683, AIName='SmartAI', ScriptName='' WHERE entry=24683;
UPDATE creature_template SET pickpocketloot=24683, AIName='', ScriptName='' WHERE entry=25568;
DELETE FROM smart_scripts WHERE entryorguid=24683 AND source_type=0;
INSERT INTO smart_scripts VALUES (24683, 0, 0, 0, 9, 0, 100, 2, 10, 60, 4000, 6000, 11, 44478, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Mage Guard - In Combat - Cast Glaive Throw');
INSERT INTO smart_scripts VALUES (24683, 0, 1, 0, 9, 0, 100, 4, 10, 60, 4000, 6000, 11, 46028, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Mage Guard - In Combat - Cast Glaive Throw');
INSERT INTO smart_scripts VALUES (24683, 0, 2, 0, 0, 0, 100, 1, 1000, 4000, 0, 0, 11, 44475, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Mage Guard - In Combat - Cast Magic Dampening Field');
INSERT INTO smart_scripts VALUES (24683, 0, 3, 0, 1, 0, 100, 1, 2000, 2000, 0, 0, 11, 44574, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Mage Guard - Out of Combat - Cast Fel Energy Cosmetic');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=24683;
INSERT INTO conditions VALUES(22, 4, 24683, 0, 0, 29, 1, 24808, 5, 0, 0, 0, 0, '', 'Requires Broken Sentinel in 10yd to run event');
DELETE FROM pickpocketing_loot_template WHERE entry=24683;
INSERT INTO pickpocketing_loot_template VALUES (24683, 29569, 2, 1, 0, 1, 1);
INSERT INTO pickpocketing_loot_template VALUES (24683, 29571, 2, 1, 0, 1, 1);
INSERT INTO pickpocketing_loot_template VALUES (24683, 30458, 0.5, 1, 0, 1, 1);
INSERT INTO pickpocketing_loot_template VALUES (24683, 22829, 0.5, 1, 0, 1, 1);
INSERT INTO pickpocketing_loot_template VALUES (24683, 27856, 0.5, 1, 0, 1, 1);
INSERT INTO pickpocketing_loot_template VALUES (24683, 27855, 0.5, 1, 0, 1, 1);

-- Sunblade Physician (24687, 25570)
UPDATE creature_template SET pickpocketloot=24683, AIName='SmartAI', ScriptName='' WHERE entry=24687;
UPDATE creature_template SET pickpocketloot=24683, AIName='', ScriptName='' WHERE entry=25570;
DELETE FROM smart_scripts WHERE entryorguid=24687 AND source_type=0;
INSERT INTO smart_scripts VALUES (24687, 0, 0, 0, 0, 0, 100, 2, 0, 0, 10000, 10000, 11, 44599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Physician - In Combat - Cast Inject Poison');
INSERT INTO smart_scripts VALUES (24687, 0, 1, 0, 0, 0, 100, 4, 0, 0, 10000, 10000, 11, 46046, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Physician - In Combat - Cast Inject Poison');
INSERT INTO smart_scripts VALUES (24687, 0, 2, 0, 2, 0, 100, 2, 0, 60, 30000, 30000, 11, 44583, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Physician - In Combat - Cast Prayer of Mending');
INSERT INTO smart_scripts VALUES (24687, 0, 3, 0, 2, 0, 100, 4, 0, 60, 30000, 30000, 11, 46045, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Physician - In Combat - Cast Prayer of Mending');
INSERT INTO smart_scripts VALUES (24687, 0, 4, 0, 1, 0, 100, 1, 2000, 2000, 0, 0, 11, 44574, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Physician - Out of Combat - Cast Fel Energy Cosmetic');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=24687;
INSERT INTO conditions VALUES(22, 5, 24687, 0, 0, 29, 1, 24808, 5, 0, 0, 0, 0, '', 'Requires Broken Sentinel in 10yd to run event');

-- Sunblade Magister (24685, 25569)
REPLACE INTO creature_template_addon VALUES (24685, 0, 0, 0, 4097, 0, '44604');
REPLACE INTO creature_template_addon VALUES (25569, 0, 0, 0, 4097, 0, '44604');
UPDATE creature_template SET pickpocketloot=24683, AIName='SmartAI', ScriptName='' WHERE entry=24685;
UPDATE creature_template SET pickpocketloot=24683, AIName='', ScriptName='' WHERE entry=25569;
DELETE FROM smart_scripts WHERE entryorguid=24685 AND source_type=0;
INSERT INTO smart_scripts VALUES (24685, 0, 0, 0, 0, 0, 100, 2, 0, 0, 3000, 4000, 11, 44606, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Magister - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (24685, 0, 1, 0, 0, 0, 100, 4, 0, 0, 3000, 4000, 11, 46035, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Magister - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (24685, 0, 2, 0, 9, 0, 100, 2, 0, 8, 20000, 20000, 11, 44644, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Magister - Within Range 0 - 10 - Cast Arcane Nova');
INSERT INTO smart_scripts VALUES (24685, 0, 3, 0, 9, 0, 100, 4, 0, 8, 20000, 20000, 11, 46036, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Magister - Within Range 0 - 10 - Cast Arcane Nova');
INSERT INTO smart_scripts VALUES (24685, 0, 4, 0, 1, 0, 100, 1, 2000, 2000, 0, 0, 11, 44574, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Magister - Out of Combat - Cast Fel Energy Cosmetic');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=24685;
INSERT INTO conditions VALUES(22, 5, 24685, 0, 0, 29, 1, 24808, 5, 0, 0, 0, 0, '', 'Requires Broken Sentinel in 10yd to run event');

-- Sunblade Warlock (24686, 25572)
UPDATE creature_template SET pickpocketloot=24683, AIName='SmartAI', ScriptName='' WHERE entry=24686;
UPDATE creature_template SET pickpocketloot=24683, AIName='', ScriptName='' WHERE entry=25572;
DELETE FROM smart_scripts WHERE entryorguid=24686 AND source_type=0;
INSERT INTO smart_scripts VALUES (24686, 0, 0, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 11, 44517, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Warlock - Out of Combat - Cast Summon Sunblade Imp');
INSERT INTO smart_scripts VALUES (24686, 0, 1, 0, 1, 0, 100, 1, 1, 1000, 180000, 180000, 11, 44520, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Warlock - Out of Combat - Cast Fel Armor');
INSERT INTO smart_scripts VALUES (24686, 0, 2, 0, 0, 0, 100, 2, 0, 0, 3000, 4000, 11, 44518, 64, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Sunblade Warlock - In Combat - Cast Immolate');
INSERT INTO smart_scripts VALUES (24686, 0, 3, 0, 0, 0, 100, 4, 0, 0, 3000, 4000, 11, 46042, 64, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Sunblade Warlock - In Combat - Cast Immolate');
INSERT INTO smart_scripts VALUES (24686, 0, 4, 0, 0, 0, 100, 2, 8000, 8000, 15000, 20000, 11, 44519, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Warlock - In Combat - Cast Incinerate');
INSERT INTO smart_scripts VALUES (24686, 0, 5, 0, 0, 0, 100, 4, 8000, 8000, 15000, 20000, 11, 46043, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Warlock - In Combat - Cast Incinerate');
INSERT INTO smart_scripts VALUES (24686, 0, 6, 0, 1, 0, 100, 1, 2000, 2000, 0, 0, 11, 44574, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Warlock - Out of Combat - Cast Fel Energy Cosmetic');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=24686;
INSERT INTO conditions VALUES(22, 7, 24686, 0, 0, 29, 1, 24808, 5, 0, 0, 0, 0, '', 'Requires Broken Sentinel in 10yd to run event');

-- Sunblade Imp (24815, 25566)
UPDATE creature_template SET unit_flags=131072, AIName='SmartAI', ScriptName='' WHERE entry=24815;
UPDATE creature_template SET unit_flags=131072, AIName='', ScriptName='' WHERE entry=25566;
DELETE FROM smart_scripts WHERE entryorguid=24815 AND source_type=0;
INSERT INTO smart_scripts VALUES (24815, 0, 0, 0, 0, 0, 100, 2, 0, 0, 3000, 4000, 11, 44577, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Imp - In Combat - Cast Firebolt');
INSERT INTO smart_scripts VALUES (24815, 0, 1, 0, 0, 0, 100, 4, 0, 0, 3000, 4000, 11, 46044, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Imp - In Combat - Cast Firebolt');

-- Sunblade Blood Knight (24684, 25565)
UPDATE creature_template SET pickpocketloot=24683, AIName='SmartAI', ScriptName='' WHERE entry=24684;
UPDATE creature_template SET pickpocketloot=24683, AIName='', ScriptName='' WHERE entry=25565;
DELETE FROM smart_scripts WHERE entryorguid=24684 AND source_type=0;
INSERT INTO smart_scripts VALUES (24684, 0, 0, 0, 0, 0, 100, 2, 0, 0, 30000, 30000, 11, 44480, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Blood Knight - In Combat - Cast Seal of Wrath');
INSERT INTO smart_scripts VALUES (24684, 0, 1, 0, 0, 0, 100, 4, 0, 0, 30000, 30000, 11, 46030, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Blood Knight - In Combat - Cast Seal of Wrath');
INSERT INTO smart_scripts VALUES (24684, 0, 2, 0, 0, 0, 100, 2, 5000, 10000, 10000, 15000, 11, 44482, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Blood Knight - In Combat - Cast Judgement of Wrath');
INSERT INTO smart_scripts VALUES (24684, 0, 3, 0, 0, 0, 100, 4, 5000, 10000, 10000, 15000, 11, 46033, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Blood Knight - In Combat - Cast Judgement of Wrath');
INSERT INTO smart_scripts VALUES (24684, 0, 4, 0, 74, 0, 100, 2, 0, 40, 15000, 20000, 11, 44479, 1, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Blood Knight - On Friendly Between 0-40% Health - Cast Holy Light');
INSERT INTO smart_scripts VALUES (24684, 0, 5, 0, 74, 0, 100, 4, 0, 40, 15000, 20000, 11, 46029, 1, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Blood Knight - On Friendly Between 0-40% Health - Cast Holy Light');
INSERT INTO smart_scripts VALUES (24684, 0, 6, 0, 1, 0, 100, 1, 2000, 2000, 0, 0, 11, 44574, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Blood Knight - Out of Combat - Cast Fel Energy Cosmetic');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=24684;
INSERT INTO conditions VALUES(22, 7, 24684, 0, 0, 29, 1, 24808, 5, 0, 0, 0, 0, '', 'Requires Broken Sentinel in 10yd to run event');

-- Wretched Bruiser (24689, 25575)
DELETE FROM creature_text WHERE entry=24689;
INSERT INTO creature_text VALUES (24689, 0, 0, "Get away from my crystals!", 12, 0, 100, 0, 0, 0, 0, 'Wretched Bruiser');
INSERT INTO creature_text VALUES (24689, 0, 1, "I'll never stop. Never...", 12, 0, 100, 0, 0, 0, 0, 'Wretched Bruiser');
INSERT INTO creature_text VALUES (24689, 0, 2, "It seethes and burns...", 12, 0, 100, 0, 0, 0, 0, 'Wretched Bruiser');
INSERT INTO creature_text VALUES (24689, 0, 3, "It's MINE!", 12, 0, 100, 0, 0, 0, 0, 'Wretched Bruiser');
INSERT INTO creature_text VALUES (24689, 0, 4, "The power! More, more, more!", 12, 0, 100, 0, 0, 0, 0, 'Wretched Bruiser');
INSERT INTO creature_text VALUES (24689, 0, 5, "You wish to steal the power! Die!", 12, 0, 100, 0, 0, 0, 0, 'Wretched Bruiser');
UPDATE creature_template SET pickpocketloot=24689, AIName='SmartAI', ScriptName='' WHERE entry=24689;
UPDATE creature_template SET pickpocketloot=24689, dmg_multiplier=1.2, AIName='', ScriptName='' WHERE entry=25575;
DELETE FROM smart_scripts WHERE entryorguid=24689 AND source_type=0;
INSERT INTO smart_scripts VALUES (24689, 0, 0, 0, 4, 0, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wretched Bruiser - On Aggro - Talk');
INSERT INTO smart_scripts VALUES (24689, 0, 1, 0, 1, 0, 100, 1, 2000, 2000, 0, 0, 11, 44374, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wretched Bruiser - Out of Combat - Cast Spell Fel Crystal Cosmetic');
INSERT INTO smart_scripts VALUES (24689, 0, 2, 0, 2, 0, 100, 0, 0, 20, 23000, 33000, 11, 44505, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wretched Bruiser - Between 0-20% Health - Cast Drink Fel Infusion');
INSERT INTO smart_scripts VALUES (24689, 0, 3, 0, 0, 0, 100, 0, 3800, 3800, 6000, 11000, 11, 44534, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wretched Bruiser - In Combat - Cast Wretched Strike');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=24689;
INSERT INTO conditions VALUES(22, 2, 24689, 0, 0, 29, 1, 24722, 10, 0, 0, 0, 0, '', 'Requires Fel Crystal in 10yd to run event');
DELETE FROM pickpocketing_loot_template WHERE entry=24689;
INSERT INTO pickpocketing_loot_template VALUES (24689, 29569, 2, 1, 0, 1, 1);
INSERT INTO pickpocketing_loot_template VALUES (24689, 29570, 1.5, 1, 0, 1, 1);
INSERT INTO pickpocketing_loot_template VALUES (24689, 22829, 0.5, 1, 0, 1, 1);
INSERT INTO pickpocketing_loot_template VALUES (24689, 27854, 0.5, 1, 0, 1, 1);
INSERT INTO pickpocketing_loot_template VALUES (24689, 27855, 0.5, 1, 0, 1, 1);

-- Wretched Husk (24690, 25576)
DELETE FROM creature_text WHERE entry=24690;
INSERT INTO creature_text VALUES (24690, 0, 0, "Get away from my crystals!", 12, 0, 100, 0, 0, 0, 0, 'Wretched Husk');
INSERT INTO creature_text VALUES (24690, 0, 1, "I'll never stop. Never...", 12, 0, 100, 0, 0, 0, 0, 'Wretched Husk');
INSERT INTO creature_text VALUES (24690, 0, 2, "It seethes and burns...", 12, 0, 100, 0, 0, 0, 0, 'Wretched Husk');
INSERT INTO creature_text VALUES (24690, 0, 3, "It's MINE!", 12, 0, 100, 0, 0, 0, 0, 'Wretched Husk');
INSERT INTO creature_text VALUES (24690, 0, 4, "The power! More, more, more!", 12, 0, 100, 0, 0, 0, 0, 'Wretched Husk');
INSERT INTO creature_text VALUES (24690, 0, 5, "You wish to steal the power! Die!", 12, 0, 100, 0, 0, 0, 0, 'Wretched Husk');
UPDATE creature_template SET pickpocketloot=24689, AIName='SmartAI', ScriptName='' WHERE entry=24690;
UPDATE creature_template SET pickpocketloot=24689, dmg_multiplier=1.2, AIName='', ScriptName='' WHERE entry=25576;
DELETE FROM smart_scripts WHERE entryorguid=24690 AND source_type=0;
INSERT INTO smart_scripts VALUES (24690, 0, 0, 0, 4, 0, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wretched Husk - On Aggro - Talk');
INSERT INTO smart_scripts VALUES (24690, 0, 1, 0, 1, 0, 100, 1, 2000, 2000, 0, 0, 11, 44374, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wretched Husk - Out of Combat - Cast Spell Fel Crystal Cosmetic');
INSERT INTO smart_scripts VALUES (24690, 0, 2, 0, 2, 0, 100, 0, 0, 20, 23000, 33000, 11, 44505, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wretched Husk - Between 0-20% Health - Cast Drink Fel Infusion');
INSERT INTO smart_scripts VALUES (24690, 0, 3, 0, 0, 0, 100, 0, 0, 0, 6000, 6000, 11, 44503, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wretched Husk - In Combat - Cast Wretched Fireball');
INSERT INTO smart_scripts VALUES (24690, 0, 4, 0, 0, 0, 100, 0, 3000, 3000, 6000, 6000, 11, 44504, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wretched Husk - In Combat - Cast Wretched Frostbolt');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=24690;
INSERT INTO conditions VALUES(22, 2, 24690, 0, 0, 29, 1, 24722, 10, 0, 0, 0, 0, '', 'Requires Fel Crystal in 10yd to run event');

-- Wretched Skulker (24688, 25577)
DELETE FROM creature_text WHERE entry=24688;
INSERT INTO creature_text VALUES (24688, 0, 0, "Get away from my crystals!", 12, 0, 100, 0, 0, 0, 0, 'Wretched Skulker');
INSERT INTO creature_text VALUES (24688, 0, 1, "I'll never stop. Never...", 12, 0, 100, 0, 0, 0, 0, 'Wretched Skulker');
INSERT INTO creature_text VALUES (24688, 0, 2, "It seethes and burns...", 12, 0, 100, 0, 0, 0, 0, 'Wretched Skulker');
INSERT INTO creature_text VALUES (24688, 0, 3, "It's MINE!", 12, 0, 100, 0, 0, 0, 0, 'Wretched Skulker');
INSERT INTO creature_text VALUES (24688, 0, 4, "The power! More, more, more!", 12, 0, 100, 0, 0, 0, 0, 'Wretched Skulker');
INSERT INTO creature_text VALUES (24688, 0, 5, "You wish to steal the power! Die!", 12, 0, 100, 0, 0, 0, 0, 'Wretched Skulker');
UPDATE creature_template SET pickpocketloot=24689, AIName='SmartAI', ScriptName='' WHERE entry=24688;
UPDATE creature_template SET pickpocketloot=24689, dmg_multiplier=1.2, AIName='', ScriptName='' WHERE entry=25577;
DELETE FROM smart_scripts WHERE entryorguid=24688 AND source_type=0;
INSERT INTO smart_scripts VALUES (24688, 0, 0, 0, 4, 0, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wretched Skulker - On Aggro - Talk');
INSERT INTO smart_scripts VALUES (24688, 0, 1, 0, 1, 0, 100, 1, 2000, 2000, 0, 0, 11, 44374, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wretched Skulker - Out of Combat - Cast Spell Fel Crystal Cosmetic');
INSERT INTO smart_scripts VALUES (24688, 0, 2, 0, 2, 0, 100, 0, 0, 20, 23000, 33000, 11, 44505, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wretched Skulker - Between 0-20% Health - Cast Drink Fel Infusion');
INSERT INTO smart_scripts VALUES (24688, 0, 3, 0, 0, 0, 100, 0, 0, 0, 4000, 6000, 11, 44533, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wretched Skulker - In Combat - Cast Wretched Stab');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=24688;
INSERT INTO conditions VALUES(22, 2, 24688, 0, 0, 29, 1, 24722, 10, 0, 0, 0, 0, '', 'Requires Fel Crystal in 10yd to run event');

-- Brightscale Wyrm (24761, 25545)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=24761;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=25545;
DELETE FROM smart_scripts WHERE entryorguid=24761 AND source_type=0;
INSERT INTO smart_scripts VALUES (24761, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 85, 44406, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Brightscale Wyrm - On Death - Invoker Cast Energy Infusion');

-- Sunblade Sentinel (24777, 25571)
UPDATE creature_template SET speed_run=1.42857, dmgschool=2, AIName='', ScriptName='' WHERE entry=24777;
UPDATE creature_template SET speed_run=1.42857, dmgschool=2, AIName='', ScriptName='' WHERE entry=25571;

-- Sister of Torment (24697, 25563)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=24697;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=25563;
DELETE FROM smart_scripts WHERE entryorguid=24697 AND source_type=0;
INSERT INTO smart_scripts VALUES (24697, 0, 0, 0, 0, 0, 100, 0, 3000, 3000, 25000, 25000, 11, 44547, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Sister of Torment - In Combat - Cast Deadly Embrace');
INSERT INTO smart_scripts VALUES (24697, 0, 1, 0, 0, 0, 100, 0, 0, 0, 10000, 10000, 11, 44640, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sister of Torment - In Combat - Cast Lash of Pain');

-- Ethereum Smuggler (24698, 25551)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=24698;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=25551;
DELETE FROM smart_scripts WHERE entryorguid=24698 AND source_type=0;
INSERT INTO smart_scripts VALUES (24698, 0, 0, 0, 0, 0, 100, 0, 3000, 3000, 10000, 10000, 11, 44538, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Smuggler - In Combat - Cast Arcane Explosion');

-- Coilskar Witch (24696, 25547)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=24696;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=25547;
DELETE FROM smart_scripts WHERE entryorguid=24696 AND source_type=0;
INSERT INTO smart_scripts VALUES (24696, 0, 0, 0, 0, 0, 100, 2, 3000, 3000, 15000, 20000, 11, 20299, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilskar Witch - In Combat - Cast Forked Lightning');
INSERT INTO smart_scripts VALUES (24696, 0, 1, 0, 0, 0, 100, 4, 3000, 3000, 15000, 20000, 11, 46150, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilskar Witch - In Combat - Cast Forked Lightning');
INSERT INTO smart_scripts VALUES (24696, 0, 2, 0, 0, 0, 100, 0, 7000, 7000, 15000, 20000, 11, 44639, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilskar Witch - In Combat - Cast Frost Arrow');
INSERT INTO smart_scripts VALUES (24696, 0, 3, 0, 0, 0, 100, 2, 0, 0, 3000, 3000, 11, 35946, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilskar Witch - In Combat - Cast Shot');
INSERT INTO smart_scripts VALUES (24696, 0, 4, 0, 0, 0, 100, 4, 0, 0, 3000, 3000, 11, 22907, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilskar Witch - In Combat - Cast Shot');
INSERT INTO smart_scripts VALUES (24696, 0, 5, 0, 2, 0, 100, 3, 0, 50, 0, 0, 11, 17741, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilskar Witch - Between 0-50% Health - Cast Mana Shield');
INSERT INTO smart_scripts VALUES (24696, 0, 6, 0, 2, 0, 100, 5, 0, 50, 0, 0, 11, 46151, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilskar Witch - Between 0-50% Health - Cast Mana Shield');


-- -------------------------------------------
--                BOSSES
-- -------------------------------------------

-- Selin Fireheart (24723, 25562)
DELETE FROM creature_text WHERE entry=24723;
INSERT INTO creature_text VALUES (24723, 0, 0, 'You only waste my time!', 14, 0, 100, 0, 0, 12378, 0, 'selin SAY_AGGRO');
INSERT INTO creature_text VALUES (24723, 1, 0, 'My hunger knows no bounds!', 14, 0, 100, 0, 0, 12381, 0, 'selin SAY_ENERGY');
INSERT INTO creature_text VALUES (24723, 2, 0, 'Yes! I am a god!', 14, 0, 100, 0, 0, 12382, 0, 'selin SAY_EMPOWERED');
INSERT INTO creature_text VALUES (24723, 3, 0, 'Enough distractions!', 14, 0, 100, 0, 0, 12388, 0, 'selin SAY_KILL_1');
INSERT INTO creature_text VALUES (24723, 3, 1, 'I am invincible!', 14, 0, 100, 0, 0, 12385, 0, 'selin SAY_KILL_2');
INSERT INTO creature_text VALUES (24723, 4, 0, 'No! More... I must have more!', 14, 0, 100, 0, 0, 12383, 0, 'selin SAY_DEATH');
INSERT INTO creature_text VALUES (24723, 5, 0, '%s begins to channel from the nearby Fel Crystal...', 16, 0, 100, 0, 0, 0, 0, 'selin EMOTE_CRYSTAL');
UPDATE creature_template SET unit_flags2=0, AIName='', ScriptName='boss_selin_fireheart' WHERE entry=24723;
UPDATE creature_template SET unit_flags2=0, AIName='', ScriptName='' WHERE entry=25562; 

-- Fel Crystal (24722, 25552)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=24722);
DELETE FROM creature WHERE id=24722;
UPDATE creature_template SET unit_flags=33555200, AIName='SmartAI', ScriptName='' WHERE entry=24722;
UPDATE creature_template SET unit_flags=33555200, AIName='', ScriptName='' WHERE entry=25552; 
DELETE FROM smart_scripts WHERE entryorguid=24722 AND source_type=0;
INSERT INTO smart_scripts VALUES (24722, 0, 0, 0, 1, 0, 100, 0, 0, 0, 6000, 6000, 11, 44355, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fel Crystal - Cast Spell - Fel Crystal Visual');

-- SPELL Fel Crystal Cosmetic (44374)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=44374;
INSERT INTO conditions VALUES(13, 1, 44374, 0, 0, 31, 0, 3, 24722, 0, 0, 0, 0, '', 'Target Fel Crystal');

-- SPELL Fel Crystal Visual (44355)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=44355;
INSERT INTO conditions VALUES(13, 1, 44355, 0, 0, 31, 0, 3, 24723, 0, 0, 0, 0, '', 'Target Selin Fireheart');
INSERT INTO conditions VALUES(13, 1, 44355, 0, 0, 13, 0, 0, 0, 0, 0, 0, 0, '', 'Instance - Get Data - Encounter 0 = Not Started');

-- Vexallus (24744, 25573)
DELETE FROM creature_text WHERE entry=24744;
INSERT INTO creature_text VALUES (24744, 0, 0, 'Drain...life!', 14, 0, 100, 0, 0, 12389, 0, 'vexallus SAY_AGGRO');
INSERT INTO creature_text VALUES (24744, 1, 0, 'Un...con...tainable.', 14, 0, 100, 0, 0, 12392, 0, 'vexallus SAY_ENERGY');
INSERT INTO creature_text VALUES (24744, 2, 0, 'Un...leash...', 14, 0, 100, 0, 0, 12390, 0, 'vexallus SAY_OVERLOAD');
INSERT INTO creature_text VALUES (24744, 3, 0, 'Con...sume.', 14, 0, 100, 0, 0, 12393, 0, 'vexallus SAY_KILL');
INSERT INTO creature_text VALUES (24744, 4, 0, '%s discharges pure energy!', 41, 0, 100, 0, 0, 0, 0, 'vexallus EMOTE_DISCHARGE_ENERGY');
UPDATE creature_template SET dmgschool=6, AIName='', ScriptName='boss_vexallus' WHERE entry=24744;
UPDATE creature_template SET dmgschool=6, AIName='', ScriptName='' WHERE entry=25573;

-- Pure Energy (24745)
REPLACE INTO creature_template_addon VALUES (24745, 0, 0, 0, 0, 0, '44326 46156');
UPDATE creature_template SET modelid1=17612, modelid2=0, flags_extra=0, AIName='NullCreatureAI', ScriptName='' WHERE entry=24745;

-- Priestess Delrissa (24560, 25560)
DELETE FROM creature_text WHERE entry=24560;
INSERT INTO creature_text VALUES (24560, 0, 0, "Annihilate them!", 14, 0, 100, 0, 0, 12395, 0, 'delrissa SAY_AGGRO');
INSERT INTO creature_text VALUES (24560, 1, 0, "Oh, the horror.", 14, 0, 100, 0, 0, 12398, 0, 'delrissa LackeyDeath1');
INSERT INTO creature_text VALUES (24560, 2, 0, "Well, aren't you lucky?", 14, 0, 100, 0, 0, 12400, 0, 'delrissa LackeyDeath2');
INSERT INTO creature_text VALUES (24560, 3, 0, "Now I'm getting annoyed.", 14, 0, 100, 0, 0, 12401, 0, 'delrissa LackeyDeath3');
INSERT INTO creature_text VALUES (24560, 4, 0, "Lackies be damned! I'll finish you myself!", 14, 0, 100, 0, 0, 12403, 0, 'delrissa LackeyDeath4');
INSERT INTO creature_text VALUES (24560, 5, 0, "I call that a good start.", 14, 0, 100, 0, 0, 12405, 0, 'delrissa PlayerDeath1');
INSERT INTO creature_text VALUES (24560, 6, 0, "I could have sworn there were more of you.", 14, 0, 100, 0, 0, 12407, 0, 'delrissa PlayerDeath2');
INSERT INTO creature_text VALUES (24560, 7, 0, "Not really much of a group, anymore, is it?", 14, 0, 100, 0, 0, 12409, 0, 'delrissa PlayerDeath3');
INSERT INTO creature_text VALUES (24560, 8, 0, "One is such a lonely number.", 14, 0, 100, 0, 0, 12410, 0, 'delrissa PlayerDeath4');
INSERT INTO creature_text VALUES (24560, 9, 0, "It's been a kick, really.", 14, 0, 100, 0, 0, 12411, 0, 'delrissa PlayerDeath5');
INSERT INTO creature_text VALUES (24560, 10, 0, "Not what I had... planned...", 14, 0, 100, 0, 0, 12397, 0, 'delrissa SAY_DEATH');
UPDATE creature_template SET flags_extra=256, AIName='', ScriptName='boss_priestess_delrissa' WHERE entry=24560;
UPDATE creature_template SET flags_extra=257, AIName='', ScriptName='' WHERE entry=25560;

-- Kagani Nightstrike (24557, 25556)
UPDATE creature_template SET flags_extra=256, AIName='', ScriptName='boss_kagani_nightstrike' WHERE entry=24557;
UPDATE creature_template SET flags_extra=256, AIName='', ScriptName='' WHERE entry=25556;

-- Ellrys Duskhallow (24558, 25549)
UPDATE creature_template SET flags_extra=256, AIName='', ScriptName='boss_ellris_duskhallow' WHERE entry=24558;
UPDATE creature_template SET flags_extra=256, AIName='', ScriptName='' WHERE entry=25549;

-- Eramas Brightblaze (24554, 25550)
UPDATE creature_template SET flags_extra=256, AIName='', ScriptName='boss_eramas_brightblaze' WHERE entry=24554;
UPDATE creature_template SET flags_extra=256, AIName='', ScriptName='' WHERE entry=25550;

-- Yazzai (24561, 25578)
UPDATE creature_template SET flags_extra=256, AIName='', ScriptName='boss_yazzai' WHERE entry=24561;
UPDATE creature_template SET flags_extra=256, AIName='', ScriptName='' WHERE entry=25578;

-- Warlord Salaris (24559, 25574)
UPDATE creature_template SET flags_extra=256, AIName='', ScriptName='boss_warlord_salaris' WHERE entry=24559;
UPDATE creature_template SET flags_extra=256, AIName='', ScriptName='' WHERE entry=25574;

-- Garaxxas (24555, 25555)
UPDATE creature_template SET flags_extra=256, AIName='', ScriptName='boss_garaxxas' WHERE entry=24555;
UPDATE creature_template SET flags_extra=256, AIName='', ScriptName='' WHERE entry=25555;

-- Apoko (24553, 25541)
UPDATE creature_template SET flags_extra=256, AIName='', ScriptName='boss_apoko' WHERE entry=24553;
UPDATE creature_template SET flags_extra=256, AIName='', ScriptName='' WHERE entry=25541;
-- Earthbind Totem (2630)
UPDATE creature_template SET spell1=6474 WHERE entry=2630;
-- Fire Nova Totem VII (15483)
UPDATE creature_template SET spell1=46551 WHERE entry=15483;
-- Summoned Windfury Totem (22897)
UPDATE creature_template SET spell1=32911 WHERE entry=22897;

-- Zelfan (24556, 25579)
UPDATE creature_template SET flags_extra=256, AIName='', ScriptName='boss_zelfan' WHERE entry=24556;
UPDATE creature_template SET flags_extra=256, AIName='', ScriptName='' WHERE entry=25579;

-- Fizzle (24656, 25553)
UPDATE creature_template SET unit_flags=131072, AIName='SmartAI', ScriptName='' WHERE entry=24656;
UPDATE creature_template SET unit_flags=131072, AIName='', ScriptName='' WHERE entry=25553;
DELETE FROM smart_scripts WHERE entryorguid=24656 AND source_type=0;
INSERT INTO smart_scripts VALUES (24656, 0, 0, 0, 0, 0, 100, 0, 3000, 3000, 10000, 10000, 11, 44164, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fizzle - In Combat - Cast Firebolt');

-- Fizzle (24552, 25564)
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=24552;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=25564;

-- High Explosive Sheep (24715)
UPDATE creature_template SET AIName='', ScriptName='npc_pet_gen_target_following_bomb' WHERE entry=24715;

-- Kael'thas Sunstrider (24664, 24857)
DELETE FROM creature_text WHERE entry=24664;
INSERT INTO creature_text VALUES (24664, 0, 0, "Don't look so smug! I know what you're thinking, but Tempest Keep was merely a set back. Did you honestly believe I would trust the future to some blind, half-night elf mongrel? Oh no, he was merely an instrument, a stepping stone to a much larger plan! It has all led to this, and this time, you will not interfere!", 14, 0, 100, 0, 0, 12413, 0, 'kaelthas MT SAY_AGGRO');
INSERT INTO creature_text VALUES (24664, 1, 0, "Vengeance burns!", 14, 0, 100, 0, 0, 12415, 0, 'kaelthas MT SAY_PHOENIX');
INSERT INTO creature_text VALUES (24664, 2, 0, "Felomin ashal!", 14, 0, 100, 0, 0, 12417, 0, 'kaelthas MT SAY_FLAMESTRIKE');
INSERT INTO creature_text VALUES (24664, 3, 0, "I'll turn your world... upside... down...", 14, 0, 100, 0, 0, 12418, 0, 'kaelthas MT SAY_GRAVITY_LAPSE');
INSERT INTO creature_text VALUES (24664, 4, 0, "Master... grant me strength.", 14, 0, 100, 0, 0, 12419, 0, 'kaelthas MT SAY_TIRED');
INSERT INTO creature_text VALUES (24664, 5, 0, "Do not... get too comfortable.", 14, 0, 100, 0, 0, 12420, 0, 'kaelthas MT SAY_RECAST_GRAVITY');
INSERT INTO creature_text VALUES (24664, 6, 0, "My demise accomplishes nothing! The Master will have you! You will drown in your own blood! This world shall burn! Aaaghh!", 14, 0, 100, 0, 0, 12421, 0, 'kaelthas MT SAY_DEATH');
UPDATE creature_template SET AIName='', ScriptName='boss_felblood_kaelthas' WHERE entry=24664;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=24857;

-- Flame Strike Trigger (Kael - 5Man) (24666, 25554)
UPDATE creature_template SET minlevel=70, maxlevel=70, flags_extra=130, AIName='SmartAI', ScriptName='' WHERE entry=24666;
UPDATE creature_template SET minlevel=70, maxlevel=70, flags_extra=130, AIName='', ScriptName='' WHERE entry=25554;
DELETE FROM smart_scripts WHERE entryorguid=24666 AND source_type=0;
INSERT INTO smart_scripts VALUES (24666, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 11, 44191, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Flame Strike Trigger - On AI Init - Cast Spell Flame Strike');
INSERT INTO smart_scripts VALUES (24666, 0, 1, 3, 60, 0, 100, 3, 5000, 5000, 0, 0, 11, 44190, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Flame Strike Trigger - On Update - Cast Spell Flame Strike');
INSERT INTO smart_scripts VALUES (24666, 0, 2, 3, 60, 0, 100, 5, 5000, 5000, 0, 0, 11, 46163, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Flame Strike Trigger - On Update - Cast Spell Flame Strike');
INSERT INTO smart_scripts VALUES (24666, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 2000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Flame Strike Trigger - On Update - Despawn');

-- Phoenix (24674)
UPDATE creature_template SET unit_flags=32768, InhabitType=4, AIName='SmartAI', ScriptName='' WHERE entry=24674;
DELETE FROM smart_scripts WHERE entryorguid=24674 AND source_type=0;
INSERT INTO smart_scripts VALUES (24674, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 11, 44196, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - On Reset - Cast Spell Rebirth');
INSERT INTO smart_scripts VALUES (24674, 0, 1, 0, 60, 0, 100, 257, 2000, 2000, 0, 0, 11, 44197, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - On Update - Cast Spell Burn');
INSERT INTO smart_scripts VALUES (24674, 0, 2, 0, 0, 0, 100, 0, 5000, 5000, 5000, 5000, 11, 44202, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - On Update - Cast Spell Fireball');
INSERT INTO smart_scripts VALUES (24674, 0, 3, 0, 25, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Phoenix - On Rest - Attack Start');
INSERT INTO smart_scripts VALUES (24674, 0, 4, 5, 6, 0, 100, 0, 0, 0, 0, 0, 12, 24675, 3, 20000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - On Death - Summon Phoenix Egg');
INSERT INTO smart_scripts VALUES (24674, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - On Death - Despawn');
DELETE FROM spell_script_names WHERE spell_id IN(44198);
INSERT INTO spell_script_names VALUES(44198, 'spell_mt_phoenix_burn');

-- Phoenix Egg (24675)
UPDATE creature_template SET flags_extra=2, AIName='SmartAI', ScriptName='' WHERE entry=24675;
DELETE FROM smart_scripts WHERE entryorguid=24675 AND source_type=0;
INSERT INTO smart_scripts VALUES (24675, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Phoenix Egg - On AI Init - Set React State');
INSERT INTO smart_scripts VALUES (24675, 0, 1, 2, 60, 0, 100, 1, 15000, 15000, 0, 0, 12, 24674, 4, 20000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Phoenix Egg - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (24675, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Phoenix Egg - On Update - Despawn');

-- Arcane Sphere (24708, 25543)
REPLACE INTO creature_template_addon VALUES (24708, 0, 0, 0, 0, 0, '44263');
REPLACE INTO creature_template_addon VALUES (25543, 0, 0, 0, 0, 0, '44263');
UPDATE creature_template SET minlevel=70, maxlevel=70, unit_flags=33554432+131072, InhabitType=4, flags_extra=130, AIName='SmartAI', ScriptName='' WHERE entry=24708;
UPDATE creature_template SET minlevel=70, maxlevel=70, unit_flags=33554432+131072, InhabitType=4, flags_extra=130, AIName='', ScriptName='' WHERE entry=25543;
DELETE FROM smart_scripts WHERE entryorguid=24708 AND source_type=0;
INSERT INTO smart_scripts VALUES (24708, 0, 0, 1, 25, 0, 100, 257, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Arcane Sphere - On Reset - Set In Combat With Zone');
INSERT INTO smart_scripts VALUES (24708, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Arcane Sphere - On Reset - Set Walk');
INSERT INTO smart_scripts VALUES (24708, 0, 2, 0, 60, 0, 100, 1, 30000, 30000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Arcane Sphere - On Update - Despawn');
INSERT INTO smart_scripts VALUES (24708, 0, 3, 0, 60, 0, 100, 0, 200, 200, 10000, 10000, 49, 0, 0, 0, 0, 0, 0, 5, 50, 0, 0, 0, 0, 0, 0, 'Arcane Sphere - On Update - Attack Start');

-- SPELL Gravity Lapse (44224)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=44224;
INSERT INTO conditions VALUES(13, 1, 44224, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Target All Players');

-- SPELL Gravity Lapse - Center Teleport (44218)
DELETE FROM spell_target_position WHERE id=44218;
INSERT INTO spell_target_position VALUES (44218, 0, 585, 148.54, 181.13, -16.72, 4.724);

-- SPELL Power Feedback (44233)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=44233;
INSERT INTO conditions VALUES(13, 4, 44233, 0, 0, 31, 0, 5, 188165, 0, 0, 0, 0, '', 'Target Kael Statu');
INSERT INTO conditions VALUES(13, 4, 44233, 0, 1, 31, 0, 5, 188166, 0, 0, 0, 0, '', 'Target Kael Statu');
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry IN(188165, 188166);
DELETE FROM smart_scripts WHERE entryorguid IN(188165, 188166) AND source_type=1;
INSERT INTO smart_scripts VALUES (188165, 1, 0, 0, 8, 0, 100, 0, 44233, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kael Status - On Spell Hit - Set GO State');
INSERT INTO smart_scripts VALUES (188166, 1, 0, 0, 8, 0, 100, 0, 44233, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kael Status - On Spell Hit - Set GO State');


-- -------------------------------------------
--                MISC
-- -------------------------------------------

-- Crystal Beam (24861) First Boss Middle Trigger, probably wrong ID
REPLACE INTO creature_template_addon VALUES (24861, 0, 0, 0, 0, 0, '62720');
DELETE FROM creature WHERE id=24861;
INSERT INTO creature VALUES (NULL, 24861, 585, 3, 1, 17188, 0, 233.956, 0.047, -2.976, 0, 300, 0, 0, 8982, 0, 0, 0, 0, 0);
UPDATE creature_template SET flags_extra=130 WHERE entry=24861;

-- Kalecgos (24844), Support for The Scryer's Scryer (11490)
-- Kalecgos (24848), Support for The Scryer's Scryer (11490)
UPDATE creature_template SET gossip_menu_id=0, npcflag=0, AIName='SmartAI', ScriptName='' WHERE entry=24844;
UPDATE creature_template SET gossip_menu_id=9199, npcflag=3, AIName='SmartAI', ScriptName='' WHERE entry=24848;
DELETE FROM smart_scripts WHERE entryorguid=24844 AND source_type=0;
INSERT INTO smart_scripts VALUES (24844, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 225.045, -276.236, -7.85, 0, 'Kalecgos - On Reset - Move Point');
INSERT INTO smart_scripts VALUES (24844, 0, 1, 2, 60, 0, 100, 1, 25000, 25000, 0, 0, 11, 46307, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kalecgos - On Update - Cast Spell Scrying Orb Kill Credit');
INSERT INTO smart_scripts VALUES (24844, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 11, 44670, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kalecgos - On Update - Cast Spell KalecgosTransform into Kalec');
INSERT INTO smart_scripts VALUES (24844, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 36, 24848, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kalecgos - On Update - Update Entry');
DELETE FROM gossip_menu WHERE entry IN(9199, 9200, 9201, 9295, 9296, 9297);
INSERT INTO gossip_menu VALUES (9199, 12498),(9200, 12500),(9201, 12502),(9295, 12606),(9296, 12607),(9297, 12608);
DELETE FROM gossip_menu_option WHERE menu_id IN(9199, 9200, 9201, 9295, 9296, 9297);
INSERT INTO gossip_menu_option VALUES (9199, 0, 0, 'Who are you?', 1, 1, 9200, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (9200, 0, 0, 'What can we do to assist you?', 1, 1, 9295, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (9199, 1, 0, 'What brings you to the Sunwell?', 1, 1, 9295, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (9295, 0, 0, 'You''re not alone here?', 1, 1, 9296, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (9296, 0, 0, 'What would Kil''jaeden want with a mortal woman?', 1, 1, 9297, 0, 0, 0, '');
DELETE FROM event_scripts WHERE id=16547;
INSERT INTO event_scripts VALUES(16547, 0, 10, 24844, 300000, 1, 209.912, -318.697, 14.005, 1.181);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=46307;
INSERT INTO conditions VALUES(13, 1, 46307, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Target All Players');

-- Broken Sentinel (24808, 25546)
REPLACE INTO creature_template_addon VALUES (24808, 0, 0, 7, 0, 0, '29266');
REPLACE INTO creature_template_addon VALUES (25546, 0, 0, 7, 0, 0, '29266');
UPDATE creature SET dynamicflags=0, unit_flags=0 WHERE id=24808;
UPDATE creature_template SET flags_extra=2, AIName='NullCreatureAI', ScriptName='' WHERE entry=24808;
UPDATE creature_template SET flags_extra=2, AIName='', ScriptName='' WHERE entry=25546;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=44574;
INSERT INTO conditions VALUES(13, 1, 44574, 0, 0, 31, 0, 3, 24808, 0, 0, 0, 0, '', 'Target Broken Sentinel');	

