
UPDATE creature SET spawntimesecs=86400 WHERE map=560 AND spawntimesecs>0;

-- -------------------------------------------
--                TRASH
-- -------------------------------------------

-- Don Carlos (28132, 28171)
DELETE FROM creature_text WHERE entry=28132;
INSERT INTO creature_text VALUES (28132, 0, 0, 'Im... possible...', 14, 0, 100, 0, 0, 0, 0, 'Don Carlos');
UPDATE creature_template SET dmg_multiplier=7.5, mechanic_immune_mask=650854271, flags_extra=flags_extra|0x200000, AIName='SmartAI', ScriptName='' WHERE entry=28132;
UPDATE creature_template SET dmg_multiplier=13, mechanic_immune_mask=650854271, flags_extra=flags_extra|0x200000, AIName='', ScriptName='' WHERE entry=28171;
DELETE FROM smart_scripts WHERE entryorguid=28132 AND source_type=0;
INSERT INTO smart_scripts VALUES(28132, 0, 0, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 11, 50736, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Don Carlos - Out of Combat - Cast Summon Guerrero');
INSERT INTO smart_scripts VALUES(28132, 0, 1, 0, 0, 0, 100, 2, 0, 0, 2500, 2500, 11, 16100, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Don Carlos - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES(28132, 0, 2, 0, 0, 0, 100, 4, 0, 0, 2500, 2500, 11, 16496, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Don Carlos - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES(28132, 0, 3, 0, 9, 0, 100, 2, 0, 20, 15000, 17000, 11, 12024, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Don Carlos - In Combat - Cast Net');
INSERT INTO smart_scripts VALUES(28132, 0, 4, 0, 9, 0, 100, 4, 0, 30, 15000, 17000, 11, 50762, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Don Carlos - In Combat - Cast Net');
INSERT INTO smart_scripts VALUES(28132, 0, 5, 0, 9, 0, 100, 2, 0, 10, 20000, 20000, 11, 50733, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Don Carlos - In Combat - Cast Scatter Shot');
INSERT INTO smart_scripts VALUES(28132, 0, 6, 0, 9, 0, 100, 4, 0, 10, 20000, 20000, 11, 46681, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Don Carlos - In Combat - Cast Scatter Shot');
INSERT INTO smart_scripts VALUES(28132, 0, 7, 0, 6, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Don Carlos - Just Died - Talk');

-- Guerrero (28163, 28168)
UPDATE creature_template SET dmg_multiplier=4.6, baseattacktime=1200, mechanic_immune_mask=3405, AIName='SmartAI', ScriptName='' WHERE entry=28163;
UPDATE creature_template SET dmg_multiplier=5.9, baseattacktime=1200, mechanic_immune_mask=3405, AIName='', ScriptName='' WHERE entry=28168;
DELETE FROM smart_scripts WHERE entryorguid=28163 AND source_type=0;
INSERT INTO smart_scripts VALUES(28163, 0, 0, 0, 0, 0, 100, 0, 2000, 4000, 15000, 17000, 11, 50739, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Guerrero - In Combat - Cast Threatening Growl');
INSERT INTO smart_scripts VALUES(28163, 0, 1, 0, 0, 0, 100, 4, 7000, 8000, 15000, 17000, 11, 13738, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Guerrero - In Combat - Cast Rend');

-- Durnholde Sentry (17819, 20527)
DELETE FROM creature_text WHERE entry=17819;
INSERT INTO creature_text VALUES (17819, 0, 0, 'I hear that Blackmoore has been acting strange.', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Sentry');
INSERT INTO creature_text VALUES (17819, 0, 1, 'I''m thinking of a vacation. I hear Hearthglen is nice.', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Sentry');
INSERT INTO creature_text VALUES (17819, 0, 2, 'Quitting time can''t come too soon.', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Sentry');
INSERT INTO creature_text VALUES (17819, 1, 0, 'Blackmoore will have... your head!', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Sentry');
INSERT INTO creature_text VALUES (17819, 1, 1, 'Cursed scum!', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Sentry');
INSERT INTO creature_text VALUES (17819, 1, 2, 'I was just... following orders.', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Sentry');
INSERT INTO creature_text VALUES (17819, 1, 3, 'Why...?', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Sentry');
INSERT INTO creature_text VALUES (17819, 2, 0, 'Halt!', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Sentry');
INSERT INTO creature_text VALUES (17819, 2, 1, 'Stop them!', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Sentry');
INSERT INTO creature_text VALUES (17819, 2, 2, 'Surrender immediately!', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Sentry');
UPDATE creature_template SET pickpocketloot=17819, AIName='SmartAI', ScriptName='' WHERE entry=17819;
UPDATE creature_template SET pickpocketloot=17819, AIName='', ScriptName='' WHERE entry=20527;
DELETE FROM smart_scripts WHERE entryorguid=17819 AND source_type=0;
INSERT INTO smart_scripts VALUES(17819, 0, 0, 0, 0, 0, 100, 0, 4000, 9000, 8000, 11000, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Sentry - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES(17819, 0, 1, 0, 0, 0, 100, 0, 2000, 3000, 11000, 15000, 11, 9080, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Sentry - In Combat - Cast Hamstring');
INSERT INTO smart_scripts VALUES(17819, 0, 2, 0, 0, 0, 100, 0, 11000, 14000, 9000, 13000, 11, 14895, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Sentry - In Combat - Cast Overpower');
INSERT INTO smart_scripts VALUES(17819, 0, 3, 0, 2, 0, 50, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Sentry - Between 0-15% Health - Flee For Assist');
INSERT INTO smart_scripts VALUES(17819, 0, 4, 0, 6, 0, 5, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Sentry - On Death - Talk');
INSERT INTO smart_scripts VALUES(17819, 0, 5, 0, 1, 0, 3, 0, 10000, 60000, 30000, 60000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Sentry - Out of Combat - Talk');
INSERT INTO smart_scripts VALUES(17819, 0, 6, 0, 4, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 11, 18598, 10, 0, 0, 0, 0, 0, 'Durnholde Sentry - On Aggro - Set Data');
INSERT INTO smart_scripts VALUES(17819, 0, 7, 0, 4, 0, 10, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Sentry - On Aggro - Talk');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=17819;
INSERT INTO conditions VALUES(22, 8, 17819, 0, 0, 13, 1, 0, 3, 0, 0, 0, 0, '', 'Requires Instance data to run event');

-- Durnholde Rifleman (17820, 20526)
DELETE FROM creature_text WHERE entry=17820;
INSERT INTO creature_text VALUES (17820, 0, 0, 'I hear that Blackmoore has been acting strange.', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Rifleman');
INSERT INTO creature_text VALUES (17820, 0, 1, 'I''m thinking of a vacation. I hear Hearthglen is nice.', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Rifleman');
INSERT INTO creature_text VALUES (17820, 0, 2, 'Quitting time can''t come too soon.', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Rifleman');
INSERT INTO creature_text VALUES (17820, 1, 0, 'Blackmoore will have... your head!', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Rifleman');
INSERT INTO creature_text VALUES (17820, 1, 1, 'Cursed scum!', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Rifleman');
INSERT INTO creature_text VALUES (17820, 1, 2, 'I was just... following orders.', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Rifleman');
INSERT INTO creature_text VALUES (17820, 1, 3, 'Why...?', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Rifleman');
INSERT INTO creature_text VALUES (17820, 2, 0, 'Halt!', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Rifleman');
INSERT INTO creature_text VALUES (17820, 2, 1, 'Stop them!', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Rifleman');
INSERT INTO creature_text VALUES (17820, 2, 2, 'Surrender immediately!', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Rifleman');
UPDATE creature_template SET pickpocketloot=17820, AIName='SmartAI', ScriptName='' WHERE entry=17820;
UPDATE creature_template SET pickpocketloot=17820, AIName='', ScriptName='' WHERE entry=20526;
DELETE FROM smart_scripts WHERE entryorguid=17820 AND source_type=0;
INSERT INTO smart_scripts VALUES(17820, 0, 0, 0, 0, 0, 100, 2, 0, 0, 2500, 2500, 11, 15620, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Rifleman - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES(17820, 0, 1, 0, 0, 0, 100, 4, 0, 0, 2500, 2500, 11, 16100, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Rifleman - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES(17820, 0, 2, 0, 0, 0, 100, 2, 4000, 8000, 10500, 12500, 11, 31942, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Rifleman - In Combat - Cast Multi-Shot');
INSERT INTO smart_scripts VALUES(17820, 0, 3, 0, 0, 0, 100, 4, 4000, 8000, 10500, 12500, 11, 38383, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Rifleman - In Combat - Cast Multi-Shot');
INSERT INTO smart_scripts VALUES(17820, 0, 4, 0, 0, 0, 100, 0, 8000, 10000, 15500, 18500, 11, 23601, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Rifleman - In Combat - Cast Scatter Shot');
INSERT INTO smart_scripts VALUES(17820, 0, 5, 0, 2, 0, 50, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Rifleman - Between 0-15% Health - Flee For Assist');
INSERT INTO smart_scripts VALUES(17820, 0, 6, 0, 6, 0, 5, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Rifleman - On Death - Talk');
INSERT INTO smart_scripts VALUES(17820, 0, 7, 0, 1, 0, 3, 0, 10000, 60000, 30000, 60000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Rifleman - Out of Combat - Talk');
INSERT INTO smart_scripts VALUES(17820, 0, 8, 0, 4, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 11, 18598, 10, 0, 0, 0, 0, 0, 'Durnholde Rifleman - On Aggro - Set Data');
INSERT INTO smart_scripts VALUES(17820, 0, 9, 0, 4, 0, 10, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Rifleman - On Aggro - Talk');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=17820;
INSERT INTO conditions VALUES(22, 10, 17820, 0, 0, 13, 1, 0, 3, 0, 0, 0, 0, '', 'Requires Instance data to run event');

-- Durnholde Tracking Hound (17840, 20528)
DELETE FROM creature_text WHERE entry=17840;
INSERT INTO creature_text VALUES (17840, 0, 0, '%s goes into a frenzy!', 16, 0, 100, 0, 0, 0, 0, 'Durnholde Tracking Hound');
UPDATE creature_template SET unit_flags=0, baseattacktime=1200, skinloot=70065, AIName='SmartAI', ScriptName='' WHERE entry=17840;
UPDATE creature_template SET unit_flags=0, baseattacktime=1200, skinloot=70065, AIName='', ScriptName='' WHERE entry=20528;
DELETE FROM smart_scripts WHERE entryorguid=17840 AND source_type=0;
INSERT INTO smart_scripts VALUES(17840, 0, 0, 1, 2, 0, 100, 1, 0, 50, 0, 0, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Tracking Hound - Between HP 0-50% - Cast Frenzy');
INSERT INTO smart_scripts VALUES(17840, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Tracking Hound - Between HP 0-50% - Talk');

-- Durnholde Warden (17833, 20530)
DELETE FROM creature_text WHERE entry=17833;
INSERT INTO creature_text VALUES (17833, 0, 0, 'I hear that Blackmoore has been acting strange.', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Warden');
INSERT INTO creature_text VALUES (17833, 0, 1, 'I''m thinking of a vacation. I hear Hearthglen is nice.', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Warden');
INSERT INTO creature_text VALUES (17833, 0, 2, 'Quitting time can''t come too soon.', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Warden');
INSERT INTO creature_text VALUES (17833, 1, 0, 'Blackmoore will have... your head!', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Warden');
INSERT INTO creature_text VALUES (17833, 1, 1, 'Cursed scum!', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Warden');
INSERT INTO creature_text VALUES (17833, 1, 2, 'I was just... following orders.', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Warden');
INSERT INTO creature_text VALUES (17833, 1, 3, 'Why...?', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Warden');
INSERT INTO creature_text VALUES (17833, 2, 0, 'Halt!', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Warden');
INSERT INTO creature_text VALUES (17833, 2, 1, 'Stop them!', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Warden');
INSERT INTO creature_text VALUES (17833, 2, 2, 'Surrender immediately!', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Warden');
UPDATE creature_template SET pickpocketloot=17833, AIName='SmartAI', ScriptName='' WHERE entry=17833;
UPDATE creature_template SET pickpocketloot=17833, AIName='', ScriptName='' WHERE entry=20530;
DELETE FROM smart_scripts WHERE entryorguid=17833 AND source_type=0;
INSERT INTO smart_scripts VALUES(17833, 0, 0, 0, 0, 0, 100, 2, 0, 3000, 4000, 7000, 11, 15654, 64, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Durnholde Warden - In Combat - Cast Shadow Word: Pain');
INSERT INTO smart_scripts VALUES(17833, 0, 1, 0, 0, 0, 100, 4, 0, 3000, 4000, 7000, 11, 34941, 64, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Durnholde Warden - In Combat - Cast Shadow Word: Pain');
INSERT INTO smart_scripts VALUES(17833, 0, 2, 0, 14, 0, 100, 2, 500, 30, 5500, 6500, 11, 15586, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Warden - Friendly Health - Cast Heal');
INSERT INTO smart_scripts VALUES(17833, 0, 3, 0, 14, 0, 100, 4, 1000, 30, 5500, 6500, 11, 22883, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Warden - Friendly Health - Cast Heal');
INSERT INTO smart_scripts VALUES(17833, 0, 4, 0, 9, 0, 100, 0, 0, 8, 15500, 18500, 11, 22884, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Warden - Within Range 0-8yd - Cast Psychic Scream');
INSERT INTO smart_scripts VALUES(17833, 0, 5, 0, 15, 0, 100, 0, 30, 15500, 18500, 0, 11, 17201, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Warden - Friendly CC - Cast Dispel');
INSERT INTO smart_scripts VALUES(17833, 0, 6, 0, 2, 0, 50, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Warden - Between 0-15% Health - Flee For Assist');
INSERT INTO smart_scripts VALUES(17833, 0, 7, 0, 6, 0, 5, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Warden - On Death - Talk');
INSERT INTO smart_scripts VALUES(17833, 0, 8, 0, 1, 0, 3, 0, 10000, 60000, 30000, 60000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Warden - Out of Combat - Talk');
INSERT INTO smart_scripts VALUES(17833, 0, 9, 0, 4, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 11, 18598, 10, 0, 0, 0, 0, 0, 'Durnholde Warden - On Aggro - Set Data');
INSERT INTO smart_scripts VALUES(17833, 0, 10, 0, 4, 0, 10, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Warden - On Aggro - Talk');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=17833;
INSERT INTO conditions VALUES(22, 11, 17833, 0, 0, 13, 1, 0, 3, 0, 0, 0, 0, '', 'Requires Instance data to run event');

-- Durnholde Veteran (17860, 20529)
DELETE FROM creature_text WHERE entry=17860;
INSERT INTO creature_text VALUES (17860, 0, 0, 'I hear that Blackmoore has been acting strange.', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Veteran');
INSERT INTO creature_text VALUES (17860, 0, 1, 'I''m thinking of a vacation. I hear Hearthglen is nice.', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Veteran');
INSERT INTO creature_text VALUES (17860, 0, 2, 'Quitting time can''t come too soon.', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Veteran');
INSERT INTO creature_text VALUES (17860, 1, 0, 'Blackmoore will have... your head!', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Veteran');
INSERT INTO creature_text VALUES (17860, 1, 1, 'Cursed scum!', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Veteran');
INSERT INTO creature_text VALUES (17860, 1, 2, 'I was just... following orders.', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Veteran');
INSERT INTO creature_text VALUES (17860, 1, 3, 'Why...?', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Veteran');
INSERT INTO creature_text VALUES (17860, 2, 0, 'Halt!', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Veteran');
INSERT INTO creature_text VALUES (17860, 2, 1, 'Stop them!', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Veteran');
INSERT INTO creature_text VALUES (17860, 2, 2, 'Surrender immediately!', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Veteran');
UPDATE creature_template SET speed_walk=1, pickpocketloot=17860, AIName='SmartAI', ScriptName='' WHERE entry=17860;
UPDATE creature_template SET speed_walk=1, pickpocketloot=17860, AIName='', ScriptName='' WHERE entry=20529;
DELETE FROM smart_scripts WHERE entryorguid=17860 AND source_type=0;
INSERT INTO smart_scripts VALUES(17860, 0, 0, 0, 0, 0, 100, 0, 0, 2000, 6000, 8000, 11, 15581, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Veteran - In Combat - Cast Sinister Strike');
INSERT INTO smart_scripts VALUES(17860, 0, 1, 0, 67, 0, 100, 0, 6000, 6000, 0, 0, 11, 15582, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Veteran - Behind Target - Cast Backstab');
INSERT INTO smart_scripts VALUES(17860, 0, 2, 0, 2, 0, 50, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Veteran - Between 0-15% Health - Flee For Assist');
INSERT INTO smart_scripts VALUES(17860, 0, 3, 0, 6, 0, 5, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Veteran - On Death - Talk');
INSERT INTO smart_scripts VALUES(17860, 0, 4, 0, 1, 0, 3, 0, 10000, 60000, 30000, 60000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Veteran - Out of Combat - Talk');
INSERT INTO smart_scripts VALUES(17860, 0, 5, 0, 4, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 11, 18598, 10, 0, 0, 0, 0, 0, 'Durnholde Veteran - On Aggro - Set Data');
INSERT INTO smart_scripts VALUES(17860, 0, 6, 0, 4, 0, 10, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Veteran - On Aggro - Talk');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=17860;
INSERT INTO conditions VALUES(22, 7, 17860, 0, 0, 13, 1, 0, 3, 0, 0, 0, 0, '', 'Requires Instance data to run event');

-- Durnholde Mage (18934, 20525)
DELETE FROM creature_text WHERE entry=18934;
INSERT INTO creature_text VALUES (18934, 0, 0, 'I hear that Blackmoore has been acting strange.', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Mage');
INSERT INTO creature_text VALUES (18934, 0, 1, 'I''m thinking of a vacation. I hear Hearthglen is nice.', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Mage');
INSERT INTO creature_text VALUES (18934, 0, 2, 'Quitting time can''t come too soon.', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Mage');
INSERT INTO creature_text VALUES (18934, 1, 0, 'Blackmoore will have... your head!', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Mage');
INSERT INTO creature_text VALUES (18934, 1, 1, 'Cursed scum!', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Mage');
INSERT INTO creature_text VALUES (18934, 1, 2, 'I was just... following orders.', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Mage');
INSERT INTO creature_text VALUES (18934, 1, 3, 'Why...?', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Mage');
INSERT INTO creature_text VALUES (18934, 2, 0, 'Halt!', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Mage');
INSERT INTO creature_text VALUES (18934, 2, 1, 'Stop them!', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Mage');
INSERT INTO creature_text VALUES (18934, 2, 2, 'Surrender immediately!', 12, 0, 100, 0, 0, 0, 0, 'Durnholde Mage');
UPDATE creature_template SET pickpocketloot=18934, AIName='SmartAI', ScriptName='' WHERE entry=18934;
UPDATE creature_template SET pickpocketloot=18934, AIName='', ScriptName='' WHERE entry=20525;
DELETE FROM smart_scripts WHERE entryorguid=18934 AND source_type=0;
INSERT INTO smart_scripts VALUES(18934, 0, 0, 0, 1, 0, 100, 0, 500, 500, 1800000, 1800000, 11, 12544, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Mage - Out of Combat - Cast Frost Armor');
INSERT INTO smart_scripts VALUES(18934, 0, 1, 0, 0, 0, 100, 0, 4000, 4000, 20000, 20000, 11, 13323, 0, 0, 0, 0, 0, 6, 30, 0, 0, 0, 0, 0, 0, 'Durnholde Mage - In Combat - Cast Polymorph');
INSERT INTO smart_scripts VALUES(18934, 0, 2, 0, 0, 0, 100, 2, 0, 0, 3000, 3000, 11, 12466, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Mage - In Combat - Cast Fireball');
INSERT INTO smart_scripts VALUES(18934, 0, 3, 0, 0, 0, 100, 4, 0, 0, 3000, 3000, 11, 17290, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Mage - In Combat - Cast Fireball');
INSERT INTO smart_scripts VALUES(18934, 0, 4, 0, 9, 0, 100, 2, 0, 10, 15000, 15000, 11, 15244, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Mage - In Combat - Cast Cone of Cold');
INSERT INTO smart_scripts VALUES(18934, 0, 5, 0, 9, 0, 100, 4, 0, 10, 15000, 15000, 11, 38384, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Mage - In Combat - Cast Cone of Cold');
INSERT INTO smart_scripts VALUES(18934, 0, 6, 0, 2, 0, 50, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Mage - Between 0-15% Health - Flee For Assist');
INSERT INTO smart_scripts VALUES(18934, 0, 7, 0, 6, 0, 5, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Mage - On Death - Talk');
INSERT INTO smart_scripts VALUES(18934, 0, 8, 0, 4, 0, 10, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Durnholde Mage - On Aggro - Talk');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=18934;
INSERT INTO conditions VALUES(22, 9, 18934, 0, 0, 13, 1, 0, 3, 0, 0, 0, 0, '', 'Requires Instance data to run event');

-- Durnholde Cook (18765, 20524)
UPDATE creature_template SET unit_flags=768, AIName='NullCreatureAI', ScriptName='' WHERE entry=18765;
UPDATE creature_template SET unit_flags=768, AIName='', ScriptName='' WHERE entry=20524;

-- Durnholde Armorer (18764, 20523)
DELETE FROM creature_text WHERE entry=18764;
INSERT INTO creature_text VALUES (18764, 0, 0, 'What''s the meaning of this? GUARDS!', 12, 0, 100, 5, 0, 0, 0, 'Durnholde Armorer');
UPDATE creature_template SET unit_flags=768, AIName='NullCreatureAI', ScriptName='' WHERE entry=18764;
UPDATE creature_template SET unit_flags=768, AIName='', ScriptName='' WHERE entry=20523;
DELETE FROM creature WHERE id=18764;
INSERT INTO creature VALUES (83939, 18764, 560, 3, 1, 0, 0, 2183.038, 111.732, 89.4549, 4.185, 86400, 0, 0, 5914, 0, 0, 0, 0, 0);

-- Lordaeron Watchman (17814, 20525)
DELETE FROM creature_text WHERE entry=17814;
UPDATE creature_template SET pickpocketloot=17814, AIName='SmartAI', ScriptName='' WHERE entry=17814;
UPDATE creature_template SET pickpocketloot=17814, AIName='', ScriptName='' WHERE entry=20525;
DELETE FROM smart_scripts WHERE entryorguid=17814 AND source_type=0;
INSERT INTO smart_scripts VALUES(17814, 0, 0, 0, 0, 0, 100, 0, 2000, 3000, 5000, 10000, 11, 11976, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lordaeron Watchman - In Combat - Cast Strike');
INSERT INTO smart_scripts VALUES(17814, 0, 1, 0, 0, 0, 100, 0, 4000, 10000, 20000, 25000, 11, 12169, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lordaeron Watchman - In Combat - Cast Shield Block');
INSERT INTO smart_scripts VALUES(17814, 0, 2, 0, 2, 0, 50, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lordaeron Watchman - Between 0-15% Health - Flee For Assist');

-- Lordaeron Sentry (17815, 20537)
DELETE FROM creature_text WHERE entry=17815;
UPDATE creature_template SET pickpocketloot=17815, AIName='SmartAI', ScriptName='' WHERE entry=17815;
UPDATE creature_template SET pickpocketloot=17815, AIName='', ScriptName='' WHERE entry=20537;
DELETE FROM smart_scripts WHERE entryorguid=17815 AND source_type=0;
INSERT INTO smart_scripts VALUES(17815, 0, 0, 0, 0, 0, 100, 2, 0, 0, 2500, 2500, 11, 15620, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lordaeron Sentry - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES(17815, 0, 1, 0, 0, 0, 100, 4, 0, 0, 2500, 2500, 11, 16100, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lordaeron Sentry - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES(17815, 0, 2, 0, 2, 0, 50, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lordaeron Sentry - Between 0-15% Health - Flee For Assist');

-- Tarren Mill Horsehand (18646)
DELETE FROM creature WHERE id=18646 AND guid=83517;

-- Tarren Mill Lookout (18094, 20546)
DELETE FROM creature_text WHERE entry=18094;
INSERT INTO creature_text VALUES (18094, 0, 0, 'I thought I saw something go into the barn.', 12, 0, 100, 0, 0, 0, 0, 'Tarren Mill Lookout');
INSERT INTO creature_text VALUES (18094, 1, 0, 'Something riled that horse. Let''s go!', 12, 0, 100, 0, 0, 0, 0, 'Tarren Mill Lookout');
INSERT INTO creature_text VALUES (18094, 2, 0, 'Thrall''s trapped himself in the chapel. He can''t escape now.', 12, 0, 100, 0, 0, 0, 0, 'Tarren Mill Lookout');
INSERT INTO creature_text VALUES (18094, 3, 0, 'He''s here, stop him!', 12, 0, 100, 0, 0, 0, 0, 'Tarren Mill Lookout');
UPDATE creature_template SET unit_flags=32832, pickpocketloot=18094, AIName='SmartAI', ScriptName='' WHERE entry=18094;
UPDATE creature_template SET unit_flags=32832, pickpocketloot=18094, AIName='', ScriptName='' WHERE entry=20546;
DELETE FROM smart_scripts WHERE entryorguid=18094 AND source_type=0;
INSERT INTO smart_scripts VALUES(18094, 0, 0, 0, 0, 0, 100, 2, 0, 0, 3000, 3000, 11, 15620, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Lookout - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES(18094, 0, 1, 0, 0, 0, 100, 4, 0, 0, 3000, 3000, 11, 16100, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Lookout - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES(18094, 0, 2, 0, 0, 0, 100, 0, 3000, 4000, 15000, 20000, 11, 17174, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Lookout - In Combat - Cast Concussive Shot');
INSERT INTO smart_scripts VALUES(18094, 0, 3, 0, 0, 0, 100, 0, 5000, 6000, 10000, 15000, 11, 35511, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Tarren Mill Lookout - In Combat - Cast Serpent Sting');
INSERT INTO smart_scripts VALUES(18094, 0, 4, 0, 72, 0, 100, 0, 1, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Lookout - Do Action - Set Unit Flag');
INSERT INTO smart_scripts VALUES(18094, 0, 5, 0, 72, 0, 100, 0, 2, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Lookout - Do Action - Remove Unit Flag');

-- Tarren Mill Protector (18093, 20547)
DELETE FROM creature_text WHERE entry=18093;
UPDATE creature_template SET unit_flags=32832, pickpocketloot=18093, AIName='SmartAI', ScriptName='' WHERE entry=18093;
UPDATE creature_template SET unit_flags=32832, pickpocketloot=18093, AIName='', ScriptName='' WHERE entry=20547;
DELETE FROM smart_scripts WHERE entryorguid=18093 AND source_type=0;
INSERT INTO smart_scripts VALUES(18093, 0, 0, 0, 0, 0, 100, 0, 1000, 3000, 10000, 13000, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Protector - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES(18093, 0, 1, 0, 0, 0, 100, 0, 6000, 10000, 23000, 25000, 11, 32588, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Protector - In Combat - Cast Concussion Blow');
INSERT INTO smart_scripts VALUES(18093, 0, 2, 0, 0, 0, 100, 0, 3000, 4000, 15000, 20000, 11, 17174, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Protector - In Combat - Cast Concussive Shot');
INSERT INTO smart_scripts VALUES(18093, 0, 3, 0, 14, 0, 100, 2, 500, 30, 5500, 6500, 11, 17843, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Protector - Friendly Health - Cast Heal');
INSERT INTO smart_scripts VALUES(18093, 0, 4, 0, 14, 0, 100, 4, 1000, 30, 5500, 6500, 11, 17138, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Protector - Friendly Health - Cast Heal');
INSERT INTO smart_scripts VALUES(18093, 0, 5, 0, 15, 0, 100, 4, 30, 15500, 18500, 0, 11, 29380, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Protector - Friendly CC - Cast Cleanse');
INSERT INTO smart_scripts VALUES(18093, 0, 6, 0, 72, 0, 100, 0, 1, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Protector - Do Action - Set Unit Flag');
INSERT INTO smart_scripts VALUES(18093, 0, 7, 0, 72, 0, 100, 0, 2, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Protector - Do Action - Remove Unit Flag');

-- Tarren Mill Guardsman (18092, 20545)
DELETE FROM creature_text WHERE entry=18092;
UPDATE creature_template SET unit_flags=32832, pickpocketloot=18092, AIName='SmartAI', ScriptName='' WHERE entry=18092;
UPDATE creature_template SET unit_flags=32832, pickpocketloot=18092, AIName='', ScriptName='' WHERE entry=20545;
DELETE FROM smart_scripts WHERE entryorguid=18092 AND source_type=0;
INSERT INTO smart_scripts VALUES(18092, 0, 0, 0, 0, 0, 100, 0, 1000, 3000, 10000, 13000, 11, 16856, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Guardsman - In Combat - Cast Mortal Strike');
INSERT INTO smart_scripts VALUES(18092, 0, 1, 0, 9, 0, 100, 0, 8, 25, 13000, 15000, 11, 15749, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Guardsman - Within Range 8-25yd - Cast Shield Charge');
INSERT INTO smart_scripts VALUES(18092, 0, 2, 0, 72, 0, 100, 0, 1, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Guardsman - Do Action - Set Unit Flag');
INSERT INTO smart_scripts VALUES(18092, 0, 3, 0, 72, 0, 100, 0, 2, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Guardsman - Do Action - Remove Unit Flag');

-- Infinite Defiler (18171, 20532)
DELETE FROM pickpocketing_loot_template WHERE entry=18171;
DELETE FROM creature_text WHERE entry=18171;
UPDATE creature_template SET unit_flags=32832, pickpocketloot=0, skinloot=70063, AIName='SmartAI', ScriptName='' WHERE entry=18171;
UPDATE creature_template SET unit_flags=32832, pickpocketloot=0, skinloot=70063, AIName='', ScriptName='' WHERE entry=20532;
DELETE FROM smart_scripts WHERE entryorguid=18171 AND source_type=0;
INSERT INTO smart_scripts VALUES(18171, 0, 0, 0, 0, 0, 100, 2, 0, 1000, 3500, 3500, 11, 15232, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Infinite Defiler - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES(18171, 0, 1, 0, 0, 0, 100, 4, 0, 1000, 3500, 3500, 11, 38386, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Infinite Defiler - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES(18171, 0, 2, 0, 0, 0, 100, 0, 5000, 6000, 13000, 15000, 11, 21068, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Infinite Defiler - In Combat - Cast Corruption');
INSERT INTO smart_scripts VALUES(18171, 0, 3, 0, 0, 0, 100, 2, 0, 10000, 25000, 35000, 11, 31977, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Infinite Defiler - In Combat - Cast Curse of Infinity');
INSERT INTO smart_scripts VALUES(18171, 0, 4, 0, 0, 0, 100, 4, 0, 10000, 25000, 35000, 11, 38387, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Infinite Defiler - In Combat - Cast Bane of Infinity');
INSERT INTO smart_scripts VALUES(18171, 0, 5, 0, 72, 0, 100, 0, 5, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Infinite Defiler - Do Action - Set In Combat With Zone');

-- Infinite Saboteur (18172, 20533)
DELETE FROM pickpocketing_loot_template WHERE entry=18172;
DELETE FROM creature_text WHERE entry=18172;
UPDATE creature_template SET unit_flags=32832, pickpocketloot=0, skinloot=70063, AIName='SmartAI', ScriptName='' WHERE entry=18172;
UPDATE creature_template SET unit_flags=32832, pickpocketloot=0, skinloot=70063, AIName='', ScriptName='' WHERE entry=20533;
DELETE FROM smart_scripts WHERE entryorguid=18172 AND source_type=0;
INSERT INTO smart_scripts VALUES(18172, 0, 0, 0, 0, 0, 100, 0, 0, 5000, 8500, 10500, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Infinite Saboteur - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES(18172, 0, 1, 0, 0, 0, 100, 0, 6000, 10000, 20000, 30000, 11, 31976, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Infinite Saboteur - In Combat - Cast Shadow Shield');
INSERT INTO smart_scripts VALUES(18172, 0, 2, 0, 0, 0, 100, 0, 5000, 6000, 13000, 15000, 11, 17234, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Infinite Saboteur - In Combat - Cast Shadow Shock');
INSERT INTO smart_scripts VALUES(18172, 0, 3, 0, 72, 0, 100, 0, 5, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Infinite Saboteur - Do Action - Set In Combat With Zone');

-- Infinite Slayer (18170, 20534)
DELETE FROM pickpocketing_loot_template WHERE entry=18170;
DELETE FROM creature_text WHERE entry=18170;
UPDATE creature_template SET unit_flags=32832, pickpocketloot=0, skinloot=70063, AIName='SmartAI', ScriptName='' WHERE entry=18170;
UPDATE creature_template SET unit_flags=32832, pickpocketloot=0, skinloot=70063, AIName='', ScriptName='' WHERE entry=20534;
DELETE FROM smart_scripts WHERE entryorguid=18170 AND source_type=0;
INSERT INTO smart_scripts VALUES(18170, 0, 0, 0, 0, 0, 100, 0, 0, 5000, 8500, 10500, 11, 16856, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Infinite Slayer - In Combat - Cast Mortal Strike');
INSERT INTO smart_scripts VALUES(18170, 0, 1, 0, 72, 0, 100, 0, 5, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Infinite Slayer - Do Action - Set In Combat With Zone');

-- Tarren Mill Guardsman (23175, 23182)
UPDATE creature SET id=18092 WHERE id=23175;
DELETE FROM creature_text WHERE entry=23175;
UPDATE creature_template SET unit_flags=32832, AIName='SmartAI', ScriptName='' WHERE entry=23175;
UPDATE creature_template SET unit_flags=32832, AIName='', ScriptName='' WHERE entry=23182;
DELETE FROM smart_scripts WHERE entryorguid=23175 AND source_type=0;
INSERT INTO smart_scripts VALUES(23175, 0, 0, 0, 0, 0, 100, 0, 0, 5000, 8500, 10500, 11, 16856, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Infinite Slayer - In Combat - Cast Mortal Strike');
INSERT INTO smart_scripts VALUES(23175, 0, 1, 0, 72, 0, 100, 0, 1, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Guardsman - Do Action - Set Unit Flag');
INSERT INTO smart_scripts VALUES(23175, 0, 2, 0, 72, 0, 100, 0, 2, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Guardsman - Do Action - Remove Unit Flag');
INSERT INTO smart_scripts VALUES(23175, 0, 3, 0, 72, 0, 100, 0, 3, 0, 0, 0, 36, 18170, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Guardsman - Do Action - Update Template');
INSERT INTO smart_scripts VALUES(23175, 0, 4, 5, 72, 0, 100, 0, 4, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Guardsman - Do Action - Set Walk');
INSERT INTO smart_scripts VALUES(23175, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 2631.97, 692.97, 55.89, 0, 'Tarren Mill Guardsman - Do Action - Move Point');
INSERT INTO smart_scripts VALUES(23175, 0, 6, 0, 72, 0, 100, 0, 5, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Guardsman - Do Action - Set In Combat With Zone');
 
-- Tarren Mill Protector (23179, 23186)
UPDATE creature SET id=18093 WHERE id=23179;
DELETE FROM creature_text WHERE entry=23179;
UPDATE creature_template SET unit_flags=32832, pickpocketloot=0, AIName='SmartAI', ScriptName='' WHERE entry=23179;
UPDATE creature_template SET unit_flags=32832, pickpocketloot=0, AIName='', ScriptName='' WHERE entry=20533;
DELETE FROM smart_scripts WHERE entryorguid=23179 AND source_type=0;
INSERT INTO smart_scripts VALUES(23179, 0, 0, 0, 0, 0, 100, 0, 0, 5000, 8500, 10500, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Infinite Saboteur - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES(23179, 0, 1, 0, 0, 0, 100, 0, 6000, 10000, 20000, 30000, 11, 31976, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Infinite Saboteur - In Combat - Cast Shadow Shield');
INSERT INTO smart_scripts VALUES(23179, 0, 2, 0, 0, 0, 100, 0, 5000, 6000, 13000, 15000, 11, 17234, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Infinite Saboteur - In Combat - Cast Shadow Shock');
INSERT INTO smart_scripts VALUES(23179, 0, 3, 0, 72, 0, 100, 0, 1, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Protector - Do Action - Set Unit Flag');
INSERT INTO smart_scripts VALUES(23179, 0, 4, 0, 72, 0, 100, 0, 2, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Protector - Do Action - Remove Unit Flag');
INSERT INTO smart_scripts VALUES(23179, 0, 5, 0, 72, 0, 100, 0, 3, 0, 0, 0, 36, 18172, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Protector - Do Action - Update Template');
INSERT INTO smart_scripts VALUES(23179, 0, 6, 7, 72, 0, 100, 0, 4, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Protector - Do Action - Set Walk');
INSERT INTO smart_scripts VALUES(23179, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 2638.23, 697.06, 55.875, 0, 'Tarren Mill Protector - Do Action - Move Point');
INSERT INTO smart_scripts VALUES(23179, 0, 8, 0, 72, 0, 100, 0, 5, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Protector - Do Action - Set In Combat With Zone');

-- Tarren Mill Lookout (23177, 23184)
UPDATE creature SET id=18094 WHERE id=23177;
DELETE FROM creature_text WHERE entry=23177;
UPDATE creature_template SET unit_flags=32832, pickpocketloot=0, AIName='SmartAI', ScriptName='' WHERE entry=23177;
UPDATE creature_template SET unit_flags=32832, pickpocketloot=0, AIName='', ScriptName='' WHERE entry=20534;
DELETE FROM smart_scripts WHERE entryorguid=23177 AND source_type=0;
INSERT INTO smart_scripts VALUES(23177, 0, 0, 0, 0, 0, 100, 2, 0, 1000, 3500, 3500, 11, 15232, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Infinite Defiler - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES(23177, 0, 1, 0, 0, 0, 100, 4, 0, 1000, 3500, 3500, 11, 38386, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Infinite Defiler - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES(23177, 0, 2, 0, 0, 0, 100, 0, 5000, 6000, 13000, 15000, 11, 21068, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Infinite Defiler - In Combat - Cast Corruption');
INSERT INTO smart_scripts VALUES(23177, 0, 3, 0, 0, 0, 100, 2, 0, 10000, 25000, 35000, 11, 31977, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Infinite Defiler - In Combat - Cast Curse of Infinity');
INSERT INTO smart_scripts VALUES(23177, 0, 4, 0, 0, 0, 100, 4, 0, 10000, 25000, 35000, 11, 38387, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Infinite Defiler - In Combat - Cast Bane of Infinity');
INSERT INTO smart_scripts VALUES(23177, 0, 5, 0, 72, 0, 100, 0, 1, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Lookout - Do Action - Set Unit Flag');
INSERT INTO smart_scripts VALUES(23177, 0, 6, 0, 72, 0, 100, 0, 2, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Lookout - Do Action - Remove Unit Flag');
INSERT INTO smart_scripts VALUES(23177, 0, 7, 0, 72, 0, 100, 0, 3, 0, 0, 0, 36, 18171, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Lookout - Do Action - Update Template');
INSERT INTO smart_scripts VALUES(23177, 0, 8, 9, 72, 0, 100, 0, 4, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Lookout - Do Action - Set Walk');
INSERT INTO smart_scripts VALUES(23177, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 2643.37, 696.66, 55.805, 0, 'Tarren Mill Lookout - Do Action - Move Point');
INSERT INTO smart_scripts VALUES(23177, 0, 10, 0, 72, 0, 100, 0, 5, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Lookout - Do Action - Set In Combat With Zone');


-- -------------------------------------------
--                BOSSES
-- -------------------------------------------

-- Lieutenant Drake (17848, 20535)
DELETE FROM creature_text WHERE entry=17848;
INSERT INTO creature_text VALUES (17848, 0, 0, 'You there, fetch water quickly! Get these flames out before they spread to the rest of the keep! Hurry, damn you!', 14, 0, 100, 0, 0, 10428, 0, 'lieutenant drake SAY_ENTER');
INSERT INTO creature_text VALUES (17848, 1, 0, 'I know what you''re up to, and I mean to put an end to it, permanently!', 14, 0, 100, 0, 0, 10429, 0, 'lieutenant drake SAY_AGGRO');
INSERT INTO creature_text VALUES (17848, 2, 0, 'No more middling for you.', 14, 0, 100, 0, 0, 10432, 0, 'lieutenant drake SAY_SLAY1');
INSERT INTO creature_text VALUES (17848, 2, 1, 'You will not interfere!', 14, 0, 100, 0, 0, 10433, 0, 'lieutenant drake SAY_SLAY2');
INSERT INTO creature_text VALUES (17848, 3, 0, 'Time to bleed!', 14, 0, 100, 0, 0, 10430, 0, 'lieutenant drake SAY_MORTAL');
INSERT INTO creature_text VALUES (17848, 4, 0, 'Run, you blasted cowards!', 14, 0, 100, 0, 0, 10431, 0, 'lieutenant drake SAY_SHOUT');
INSERT INTO creature_text VALUES (17848, 5, 0, 'Thrall... must not... go free.', 14, 0, 100, 0, 0, 10434, 0, 'lieutenant drake SAY_DEATH');
UPDATE creature_template SET baseattacktime=1500, pickpocketloot=17848, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='boss_lieutenant_drake' WHERE entry=17848;
UPDATE creature_template SET baseattacktime=1400, pickpocketloot=17848, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='' WHERE entry=20535;
DELETE FROM waypoints WHERE entry=17848;
INSERT INTO waypoints VALUES (17848, 1, 2125.84, 88.2535, 54.8830, 'Lieutenant Drake'),(17848, 2, 2111.01, 93.8022, 52.6356, 'Lieutenant Drake'),(17848, 3, 2106.70, 114.753, 53.1965, 'Lieutenant Drake'),(17848, 4, 2107.76, 138.746, 52.5109, 'Lieutenant Drake'),(17848, 5, 2114.83, 160.142, 52.4738, 'Lieutenant Drake'),(17848, 6, 2125.24, 178.909, 52.7283, 'Lieutenant Drake'),(17848, 7, 2151.02, 208.901, 53.1551, 'Lieutenant Drake'),(17848, 8, 2177.00, 233.069, 52.4409, 'Lieutenant Drake'),(17848, 9, 2190.71, 227.831, 53.2742, 'Lieutenant Drake'),(17848, 10, 2178.14, 214.219, 53.0779, 'Lieutenant Drake'),
(17848, 11, 2154.99, 202.795, 52.6446, 'Lieutenant Drake'),(17848, 12, 2132.00, 191.834, 52.5709, 'Lieutenant Drake'),(17848, 13, 2117.59, 166.708, 52.7686, 'Lieutenant Drake'),(17848, 14, 2093.61, 139.441, 52.7616, 'Lieutenant Drake'),(17848, 15, 2086.29, 104.950, 52.9246, 'Lieutenant Drake'),(17848, 16, 2094.23, 81.2788, 52.6946, 'Lieutenant Drake'),(17848, 17, 2108.70, 85.3075, 53.3294, 'Lieutenant Drake'),(17848, 18, 2125.50, 88.9481, 54.7953, 'Lieutenant Drake'),(17848, 19, 2128.20, 70.9763, 64.4221, 'Lieutenant Drake');

-- Captain Skarloc (17862, 20521)
DELETE FROM creature_text WHERE entry=17862;
INSERT INTO creature_text VALUES (17862, 0, 0, 'Thrall! You didn''t really think you would escape did you? You and your allies shall answer to Blackmoore - after I''ve had my fun!', 12, 0, 100, 0, 0, 10406, 0, 'skarloc SAY_ENTER');
INSERT INTO creature_text VALUES (17862, 1, 0, 'You''re a slave. That''s all you''ll ever be.', 12, 0, 100, 0, 0, 10407, 0, 'skarloc SAY_TAUNT1');
INSERT INTO creature_text VALUES (17862, 1, 1, 'I don''t know what Blackmoore sees in you. For my money, you''re just another ignorant savage!', 12, 0, 100, 0, 0, 10408, 0, 'skarloc SAY_TAUNT2');
INSERT INTO creature_text VALUES (17862, 2, 0, 'Thrall will never be free!', 12, 0, 100, 0, 0, 10409, 0, 'skarloc SAY_SLAY1');
INSERT INTO creature_text VALUES (17862, 2, 1, 'Did you really think you would leave here alive?', 12, 0, 100, 0, 0, 10410, 0, 'skarloc SAY_SLAY2');
INSERT INTO creature_text VALUES (17862, 3, 0, 'Guards! Urgh..Guards..!', 14, 0, 100, 0, 0, 10411, 0, 'skarloc SAY_DEATH');
UPDATE creature_template SET speed_walk=1, speed_run=1.14286, baseattacktime=1500, pickpocketloot=17862, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='boss_captain_skarloc' WHERE entry=17862;
UPDATE creature_template SET speed_walk=1, speed_run=1.14286, baseattacktime=1500, pickpocketloot=17862, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='' WHERE entry=20521;

-- Epoch Hunter (18096, 20531)
DELETE FROM creature_text WHERE entry=18096;
INSERT INTO creature_text VALUES (18096, 0, 0, 'Thrall! Come outside and face your fate!', 14, 0, 100, 0, 0, 10418, 0, 'epoch hunter SAY_ENTER1');
INSERT INTO creature_text VALUES (18096, 1, 0, 'Taretha''s life hangs in the balance. Surely you care for her. Surely you wish to save her...', 14, 0, 100, 0, 0, 10419, 0, 'epoch hunter SAY_ENTER2');
INSERT INTO creature_text VALUES (18096, 2, 0, 'Ah, there you are. I had hoped to accomplish this with a bit of subtlety, but I suppose direct confrontation was inevitable. Your future, Thrall, must not come to pass and so...you and your troublesome friends must die!', 14, 0, 100, 0, 0, 10420, 0, 'epoch hunter SAY_ENTER3');
INSERT INTO creature_text VALUES (18096, 3, 0, 'Enough! I will erase your very existence!', 14, 0, 100, 0, 0, 10421, 0, 'epoch hunter SAY_AGGRO1');
INSERT INTO creature_text VALUES (18096, 3, 1, 'You cannot fight fate!', 14, 0, 100, 0, 0, 10422, 0, 'epoch hunter SAY_AGGRO2');
INSERT INTO creature_text VALUES (18096, 4, 0, 'You are...irrelevant.', 14, 0, 100, 0, 0, 10425, 0, 'epoch hunter SAY_SLAY1');
INSERT INTO creature_text VALUES (18096, 4, 1, 'Thrall will remain a slave. Taretha will die. You have failed.', 14, 0, 100, 0, 0, 10426, 0, 'epoch hunter SAY_SLAY2');
INSERT INTO creature_text VALUES (18096, 5, 0, 'Not so fast!', 14, 0, 100, 0, 0, 10423, 0, 'epoch hunter SAY_BREATH1');
INSERT INTO creature_text VALUES (18096, 5, 1, 'Struggle as much as you like!', 14, 0, 100, 0, 0, 10424, 0, 'epoch hunter SAY_BREATH2');
INSERT INTO creature_text VALUES (18096, 6, 0, 'No!...The master... will not... be pleased.', 14, 0, 100, 0, 0, 10427, 0, 'epoch hunter SAY_DEATH');
UPDATE creature_template SET InhabitType=4, skinloot=70063, baseattacktime=1500, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='boss_epoch_hunter' WHERE entry=18096;
UPDATE creature_template SET InhabitType=4, skinloot=70063, baseattacktime=1500, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='' WHERE entry=20531;


-- -------------------------------------------
--                MISC
-- -------------------------------------------

-- GO Barrel (182589)
UPDATE gameobject_template SET data3=86400000, AIName='SmartGameObjectAI', ScriptName='' WHERE entry=182589;
DELETE FROM smart_scripts WHERE entryorguid=182589 AND source_type=1;
INSERT INTO smart_scripts VALUES(182589, 1, 0, 0, 8, 0, 100, 0, 32744, 0, 0, 0, 34, 10, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Barrel - On Spell Hit - Set Instance Data');

-- GO Roaring Flame (182592)
DELETE FROM gameobject WHERE id=182592;
INSERT INTO gameobject VALUES (30287, 182592, 560, 3, 1, 2157.28, 234.934, 53.8488, 1.72788, 0, 0, 0.760406, 0.649448, -180, 100, 1, 0);
INSERT INTO gameobject VALUES (30288, 182592, 560, 3, 3, 2178.79, 254.287, 53.5769, -1.90241, 0, 0, 0.814116, -0.580703, -180, 100, 1, 0);
INSERT INTO gameobject VALUES (30289, 182592, 560, 3, 3, 2150.41, 249.103, 53.8624, -0.767945, 0, 0, 0.374607, -0.927184, -180, 100, 1, 0);
INSERT INTO gameobject VALUES (30290, 182592, 560, 3, 1, 2211.3, 246.804, 55.4124, -2.21657, 0, 0, 0.894934, -0.446198, -180, 100, 1, 0);
INSERT INTO gameobject VALUES (30291, 182592, 560, 3, 1, 2119.77, 42.0842, 53.7686, 2.67035, 0, 0, 0.97237, 0.233445, -180, 100, 1, 0);
INSERT INTO gameobject VALUES (30292, 182592, 560, 3, 3, 2081, 64.6541, 53.9115, 2.04204, 0, 0, 0.85264, 0.522499, -180, 100, 1, 0);
INSERT INTO gameobject VALUES (30293, 182592, 560, 3, 3, 2064.9, 69.6156, 53.6659, 1.53589, 0, 0, 0.694658, 0.71934, -180, 100, 1, 0);
INSERT INTO gameobject VALUES (30294, 182592, 560, 3, 1, 2070.08, 93.2598, 54.0862, -1.55334, 0, 0, 0.700909, -0.71325, -180, 100, 1, 0);
INSERT INTO gameobject VALUES (30295, 182592, 560, 3, 1, 2073.39, 142.325, 54.4632, -2.98451, 0, 0, 0.996917, -0.078459, -180, 100, 1, 0);
INSERT INTO gameobject VALUES (30296, 182592, 560, 3, 3, 2055.37, 111.925, 54.602, 2.42601, 0, 0, 0.936672, 0.350207, -180, 100, 1, 0);
INSERT INTO gameobject VALUES (30297, 182592, 560, 3, 1, 2069.83, 106.7, 54.6518, 0.959931, 0, 0, 0.461749, 0.887011, -180, 100, 1, 0);
INSERT INTO gameobject VALUES (30298, 182592, 560, 3, 1, 2086.59, 52.8431, 53.5683, -1.58825, 0, 0, 0.71325, -0.700909, -180, 100, 1, 0);
INSERT INTO gameobject VALUES (30299, 182592, 560, 3, 3, 2100.1, 42.5693, 53.575, 0.174533, 0, 0, 0.087156, 0.996195, -180, 100, 1, 0);
INSERT INTO gameobject VALUES (30300, 182592, 560, 3, 3, 2228.1, 251.4, 55.5517, -0.541052, 0, 0, 0.267238, -0.96363, -180, 100, 1, 0);
INSERT INTO gameobject VALUES (30301, 182592, 560, 3, 1, 2199.6, 271.738, 53.9931, 1.309, 0, 0, 0.608761, 0.793353, -180, 100, 1, 0);
INSERT INTO gameobject VALUES (30302, 182592, 560, 3, 1, 2171.96, 262.641, 63.3226, -0.872665, 0, 0, 0.422618, -0.906308, -180, 100, 1, 0);
INSERT INTO gameobject VALUES (30303, 182592, 560, 3, 3, 2176.22, 247.951, 53.9294, 0.593412, 0, 0, 0.292372, 0.956305, -180, 100, 1, 0);
INSERT INTO gameobject VALUES (30304, 182592, 560, 3, 1, 2070.19, 80.9965, 64.3421, 1.09956, 0, 0, 0.522499, 0.85264, -180, 100, 1, 0);
INSERT INTO gameobject VALUES (30305, 182592, 560, 3, 3, 2079.69, 74.5419, 53.7058, -0.15708, 0, 0, 0.078459, -0.996917, -180, 100, 1, 0);
INSERT INTO gameobject VALUES (30306, 182592, 560, 3, 1, 2069.07, 124.392, 54.444, -0.069813, 0, 0, 0.034899, -0.999391, -180, 100, 1, 0);
INSERT INTO gameobject VALUES (30307, 182592, 560, 3, 1, 2118.76, 51.5617, 53.8408, 1.43117, 0, 0, 0.656059, 0.75471, -180, 100, 1, 0);
INSERT INTO gameobject VALUES (30308, 182592, 560, 3, 3, 2100.35, 59.5064, 53.4081, -0.20944, 0, 0, 0.104528, -0.994522, -180, 100, 1, 0);
INSERT INTO gameobject VALUES (30309, 182592, 560, 3, 1, 2202.69, 256.725, 62.7723, -1.88496, 0, 0, 0.809017, -0.587785, -180, 100, 1, 0);
INSERT INTO gameobject VALUES (30310, 182592, 560, 3, 1, 2195.58, 257.778, 54.0599, -2.25148, 0, 0, 0.902585, -0.430511, -180, 100, 1, 0);

-- GO Prison Door (184393)
UPDATE gameobject_template SET flags=flags|16 WHERE entry=184393;

-- Image of Erozion (19438)
DELETE FROM creature_text WHERE entry=19438;
INSERT INTO creature_text VALUES (19438, 0, 0, 'My magical power can turn back time to before Thrall''s death, but be careful. My power to manipulate time is limited.', 12, 0, 100, 1, 0, 0, 0, 'Image of Erozion');
INSERT INTO creature_text VALUES (19438, 1, 0, 'I have set back the flow of time just once more. If you fail to prevent Thrall''s death, then all is lost.', 12, 0, 100, 1, 0, 0, 0, 'Image of Erozion');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=19438;
DELETE FROM smart_scripts WHERE entryorguid=19438 AND source_type=0;
INSERT INTO smart_scripts VALUES(19438, 0, 0, 0, 60, 0, 100, 1, 4000, 4000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Image of Erozion - Talk');
INSERT INTO smart_scripts VALUES(19438, 0, 1, 0, 60, 0, 100, 1, 4000, 4000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Image of Erozion - Talk');
INSERT INTO smart_scripts VALUES(19438, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 41, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Image of Erozion - Despawn');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=19438;
INSERT INTO conditions VALUES(22, 1, 19438, 0, 0, 13, 1, 0, 19, 0, 1, 0, 0, '', 'Requires Instance data to run event');
INSERT INTO conditions VALUES(22, 2, 19438, 0, 0, 13, 1, 0, 19, 0, 0, 0, 0, '', 'Requires Instance data to run event');

-- Erozion (18723)
DELETE FROM gossip_menu WHERE entry IN(7769, 7770);
INSERT INTO gossip_menu VALUES (7769, 9778),(7770, 9515);
DELETE FROM gossip_menu_option WHERE menu_id=7769;
INSERT INTO gossip_menu_option VALUES (7769, 0, 0, 'I need a pack of incendiary bombs.', 1, 1, 7770, 0, 0, 0, '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=7769;
INSERT INTO conditions VALUES(15, 7769, 0, 0, 0, 2, 0, 25853, 1, 0, 1, 0, 0, '', 'Requires No Item');
INSERT INTO conditions VALUES(15, 7769, 0, 0, 0, 13, 0, 0, 0, 0, 0, 0, 0, '', 'Requires Instance State');
DELETE FROM creature_text WHERE entry=18723;
INSERT INTO creature_text VALUES (18723, 0, 0, 'I believe I can explain everything to you two if you give me a moment of your time.', 12, 0, 100, 1, 0, 0, 0, 'Erozion');
INSERT INTO creature_text VALUES (18723, 1, 0, 'That spell should wipe their memories of us and what just happened. All they should remember now is what reality would be like without the attempted temporal interference. Well done. Thrall will journey on to find his destiny, and Taretha...', 12, 0, 100, 1, 0, 0, 0, 'Erozion');
INSERT INTO creature_text VALUES (18723, 2, 0, 'Her fate is regrettably unavoidable.', 12, 0, 100, 1, 0, 0, 0, 'Erozion');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=18723;
DELETE FROM smart_scripts WHERE entryorguid=18723 AND source_type=0;
INSERT INTO smart_scripts VALUES(18723, 0, 0, 1, 62, 0, 100, 0, 7769, 0, 0, 0, 56, 25853, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Erozion - On Gossip Select - Add Item');
INSERT INTO smart_scripts VALUES(18723, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Erozion - On Gossip Select - Close Gossip');
INSERT INTO smart_scripts VALUES(18723, 0, 2, 4, 61, 0, 100, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Erozion - On Gossip Select - Store Target');
INSERT INTO smart_scripts VALUES(18723, 0, 3, 4, 19, 0, 100, 0, 10283, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Erozion - On Quest Accept - Store Target');
INSERT INTO smart_scripts VALUES(18723, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 19, 18725, 20, 0, 0, 0, 0, 0, 'Erozion - Linked - Send Target To Target');
INSERT INTO smart_scripts VALUES(18723, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 18725, 20, 0, 0, 0, 0, 0, 'Erozion - Linked - Set Data');

-- SPELL Memory Wipe (33336)
-- SPELL Memory Wipe Resume (33337)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(33336, 33337);
INSERT INTO conditions VALUES(13, 1, 33336, 0, 0, 31, 0, 3, 17876, 0, 0, 0, 0, '', 'Target Thrall');
INSERT INTO conditions VALUES(13, 1, 33336, 0, 1, 31, 0, 3, 18887, 0, 0, 0, 0, '', 'Target Taretha');
INSERT INTO conditions VALUES(13, 1, 33337, 0, 0, 31, 0, 3, 17876, 0, 0, 0, 0, '', 'Target Thrall');
INSERT INTO conditions VALUES(13, 1, 33337, 0, 1, 31, 0, 3, 18887, 0, 0, 0, 0, '', 'Target Taretha');
DELETE FROM spell_linked_spell WHERE spell_trigger IN(33336, -33336, 33337, -33337);
INSERT INTO spell_linked_spell VALUES (33337, -33336, 1, 'Memory Wipe');

-- Brazen (18725)
DELETE FROM gossip_menu WHERE entry IN(7959);
INSERT INTO gossip_menu VALUES (7959, 9779),(7959, 9780);
DELETE FROM gossip_menu_option WHERE menu_id=7959;
INSERT INTO gossip_menu_option VALUES (7959, 0, 0, 'When you are ready to fly to Durnholde, let me know and I shall take you.', 1, 1, 0, 0, 0, 0, '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=14 AND SourceGroup=7959;
INSERT INTO conditions VALUES(14, 7959, 9780, 0, 0, 2, 0, 25853, 1, 0, 1, 0, 0, '', 'Requires No Item');
INSERT INTO conditions VALUES(14, 7959, 9779, 0, 0, 2, 0, 25853, 1, 0, 0, 0, 0, '', 'Requires Item');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=7959;
INSERT INTO conditions VALUES(15, 7959, 0, 0, 0, 2, 0, 25853, 1, 0, 0, 0, 0, '', 'Requires Item');
INSERT INTO conditions VALUES(15, 7959, 0, 0, 0, 13, 0, 0, 0, 0, 0, 0, 0, '', 'Requires Instance data');
DELETE FROM creature_text WHERE entry=18725;
INSERT INTO creature_text VALUES (18725, 0, 0, 'When you are ready to fly to Durnholde, let me know and I shall take you.', 15, 0, 100, 0, 0, 0, 0, 'Brazen');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=18725;
DELETE FROM smart_scripts WHERE entryorguid=18725 AND source_type=0;
INSERT INTO smart_scripts VALUES(18725, 0, 0, 1, 62, 0, 100, 0, 7959, 0, 0, 0, 52, 534, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Brazen - On Gossip Select - Add Item');
INSERT INTO smart_scripts VALUES(18725, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Erozion - On Gossip Select - Close Gossip');
INSERT INTO smart_scripts VALUES(18725, 0, 2, 0, 38, 0, 100, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Erozion - On Data Set - Talk');

-- Orc Prisoner (18598, 20541)
DELETE FROM creature_text WHERE entry=18598;
INSERT INTO creature_text VALUES(18598, 0, 0, 'Don''t feel... so good.', 12, 0, 100, 0, 0, 0, 0, 'Orc Prisoner');
INSERT INTO creature_text VALUES(18598, 0, 1, 'When do we eat again?', 12, 0, 100, 0, 0, 0, 0, 'Orc Prisoner');
INSERT INTO creature_text VALUES(18598, 0, 2, 'So-ngh-thirsty.', 12, 0, 100, 0, 0, 0, 0, 'Orc Prisoner');
INSERT INTO creature_text VALUES(18598, 0, 3, 'When can we eat again?', 12, 0, 100, 0, 0, 0, 0, 'Orc Prisoner');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=18598;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=20541;
DELETE FROM smart_scripts WHERE entryorguid=18598 AND source_type=0;
INSERT INTO smart_scripts VALUES(18598, 0, 0, 0, 1, 0, 50, 0, 10000, 60000, 60000, 240000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Orc Prisoner - Out of Combat - Talk');
INSERT INTO smart_scripts VALUES(18598, 0, 1, 2, 38, 0, 100, 0, 1, 1, 0, 0, 137, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Orc Prisoner - On Data Set - Flee');
INSERT INTO smart_scripts VALUES(18598, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 7000, 7000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Orc Prisoner - On Data Set - Create Timed Event');
INSERT INTO smart_scripts VALUES(18598, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 91, 255, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Orc Prisoner - On Data Set - Remove byte1');
INSERT INTO smart_scripts VALUES(18598, 0, 4, 0, 59, 0, 100, 0, 1, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Orc Prisoner - On Timed Event - Enter Evade');
INSERT INTO smart_scripts VALUES(18598, 0, 5, 0, 34, 0, 100, 0, 8, 1, 0, 0, 66, 0, 0, 0, 0, 0, 0, 20, 182592, 80, 0, 0, 0, 0, 0, 'Orc Prisoner - Movement Inform - Set Facing');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=18598;
INSERT INTO conditions VALUES(22, 1, 18598, 0, 0, 13, 1, 0, 0, 0, 0, 0, 0, '', 'Requires Instance data to run event');
DELETE FROM creature WHERE id=18598;
INSERT INTO creature VALUES (83456, 18598, 560, 3, 1, 0, 0, 2104.87, 91.259, 53.1445, 1.97364, 7200, 0, 0, 5914, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (83914, 18598, 560, 3, 1, 0, 0, 2097.88, 96.411, 52.8751, 6.24621, 7200, 0, 0, 5914, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (83915, 18598, 560, 3, 1, 0, 0, 2105.86, 99.483, 52.568, 3.881, 7200, 0, 0, 5914, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (83916, 18598, 560, 3, 1, 0, 0, 2106.94, 40.976, 54.554, 4.754, 7200, 0, 0, 5914, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (83917, 18598, 560, 3, 1, 0, 0, 2113.6, 80.1264, 53.0217, 1.78515, 7200, 0, 0, 5914, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (83918, 18598, 560, 3, 1, 0, 0, 2104.58, 55.877, 54.256, 1.691, 7200, 0, 0, 5914, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (83919, 18598, 560, 3, 1, 0, 0, 2062.86, 111.946, 55.394, 2.014, 7200, 0, 0, 5914, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (83920, 18598, 560, 3, 1, 0, 0, 2058.8, 117.234, 55.408, 2.587, 7200, 0, 0, 5914, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (83921, 18598, 560, 3, 1, 0, 0, 2068.06, 67.342, 54.356, 2.897, 7200, 0, 0, 5914, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (83925, 18598, 560, 3, 1, 0, 0, 2076.49, 75.11, 53.667, 5.08, 7200, 0, 0, 5914, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (83946, 18598, 560, 3, 1, 0, 0, 2111.03, 154.628, 52.4409, 4.23541, 7200, 0, 0, 5914, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (83947, 18598, 560, 3, 1, 0, 0, 2175.35, 234.429, 52.456, 4.59, 7200, 0, 0, 5914, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (83952, 18598, 560, 3, 1, 0, 0, 2186.21, 242.686, 52.7649, 5.80793, 7200, 0, 0, 5914, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (83953, 18598, 560, 3, 1, 0, 0, 2201.58, 241.879, 53.0639, 2.85876, 7200, 0, 0, 5914, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (83954, 18598, 560, 3, 1, 0, 0, 2191.29, 235.69, 52.468, 1.157, 7200, 0, 0, 5914, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (83957, 18598, 560, 3, 1, 0, 0, 2192.58, 238.444, 52.441, 4.23008, 7200, 0, 0, 5914, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (83960, 18598, 560, 3, 1, 0, 0, 2155.47, 236.9, 53.8478, 0.7, 7200, 0, 0, 5914, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (83961, 18598, 560, 3, 1, 0, 0, 2176.77, 252.22, 54.124, 1.55, 7200, 0, 0, 5914, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (83964, 18598, 560, 3, 1, 0, 0, 2208.77, 250.57, 54.463, 1.467, 7200, 0, 0, 5914, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (83965, 18598, 560, 3, 1, 0, 0, 2198.4, 265.62, 54.77, 0.396, 7200, 0, 0, 5914, 0, 0, 0, 0, 0);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=18598);
INSERT INTO creature_addon VALUES (83947, 0, 0, 1, 0, 0, '');
INSERT INTO creature_addon VALUES (83960, 0, 0, 1, 0, 0, '');
INSERT INTO creature_addon VALUES (83961, 0, 0, 3, 0, 0, '');
INSERT INTO creature_addon VALUES (83964, 0, 0, 3, 0, 0, '');
INSERT INTO creature_addon VALUES (83965, 0, 0, 3, 0, 0, '');
INSERT INTO creature_addon VALUES (83914, 0, 0, 4, 0, 0, '');
INSERT INTO creature_addon VALUES (83915, 0, 0, 5, 0, 0, '');
INSERT INTO creature_addon VALUES (83456, 0, 0, 5, 0, 0, '');
INSERT INTO creature_addon VALUES (83919, 0, 0, 3, 0, 0, '');
INSERT INTO creature_addon VALUES (83920, 0, 0, 3, 0, 0, '');
INSERT INTO creature_addon VALUES (83921, 0, 0, 3, 0, 0, '');
INSERT INTO creature_addon VALUES (83925, 0, 0, 1, 0, 0, '');
INSERT INTO creature_addon VALUES (83916, 0, 0, 3, 0, 0, '');
INSERT INTO creature_addon VALUES (83918, 0, 0, 3, 0, 0, '');

-- Thrall (17876, 20548)
DELETE FROM gossip_menu WHERE entry IN(7499, 7830, 7829, 7831, 7840, 7853);
INSERT INTO gossip_menu VALUES (7499, 9090),(7830, 9578),(7829, 9579),(7831, 9580),(7840, 9597),(7853, 9614);
DELETE FROM gossip_menu_option WHERE menu_id IN(7499, 7830, 7829, 7831, 7840, 7853);
INSERT INTO gossip_menu_option VALUES (7499, 0, 0, 'We are ready to get you out of here, Thrall. Let''s go!', 1, 1, 0, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (7499, 1, 0, 'We''re ready, Thrall.', 1, 1, 0, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (7830, 0, 0, 'Taretha cannot see you, Thrall.', 1, 1, 7829, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (7829, 0, 0, 'The situation is rather complicated, Thrall. It would be best for you to head into the mountains now, before more of Blackmoore''s men show up. We''ll make sure Taretha is safe.', 1, 1, 7831, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (7831, 0, 0, 'Tarren Mill.', 1, 1, 0, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (7840, 0, 0, 'We''re ready, Thrall.', 1, 1, 0, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (7853, 0, 0, 'We''re ready, Thrall.', 1, 1, 0, 0, 0, 0, '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=14 AND SourceGroup=7499;
INSERT INTO conditions VALUES(14, 7499, 9090, 0, 0, 13, 0, 0, 0, 0, 0, 0, 0, '', 'Requires Instance State');
INSERT INTO conditions VALUES(14, 7499, 9090, 0, 1, 13, 0, 0, 1, 0, 0, 0, 0, '', 'Requires Instance State');
INSERT INTO conditions VALUES(14, 7499, 9090, 0, 2, 13, 0, 0, 2, 0, 0, 0, 0, '', 'Requires Instance State');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=7499;
INSERT INTO conditions VALUES(15, 7499, 0, 0, 0, 13, 0, 0, 2, 0, 0, 0, 0, '', 'Requires Instance State');
INSERT INTO conditions VALUES(15, 7499, 1, 0, 0, 13, 0, 0, 3, 0, 0, 0, 0, '', 'Requires Instance State');
INSERT INTO conditions VALUES(15, 7499, 1, 0, 1, 13, 0, 0, 4, 0, 0, 0, 0, '', 'Requires Instance State');

DELETE FROM creature_text WHERE entry=17876;
INSERT INTO creature_text VALUES(17876, 0, 0, 'Very well then. Let''s go!', 12, 0, 100, 0, 0, 10465, 0, 'thrall hillsbrad SAY_TH_START_EVENT_PART1');
INSERT INTO creature_text VALUES(17876, 1, 0, 'As long as we''re going with a new plan, I may aswell pick up a weapon and some armor.', 12, 0, 100, 0, 0, 0, 0, 'thrall hillsbrad SAY_TH_ARMORY');
INSERT INTO creature_text VALUES(17876, 2, 0, 'A rider approaches.', 12, 0, 100, 0, 0, 10466, 0, 'thrall hillsbrad SAY_TH_SKARLOC_MEET');
INSERT INTO creature_text VALUES(17876, 3, 0, 'I''ll never be chained again!', 12, 0, 100, 0, 0, 10467, 0, 'thrall hillsbrad SAY_TH_SKARLOC_TAUNT');
INSERT INTO creature_text VALUES(17876, 4, 0, 'Very well. Tarren Mill lies just west of here. Since time is of the essence...', 12, 0, 100, 0, 0, 10468, 0, 'thrall hillsbrad SAY_TH_START_EVENT_PART2');
INSERT INTO creature_text VALUES(17876, 5, 0, 'Let''s ride!', 12, 0, 100, 0, 0, 10469, 0, 'thrall hillsbrad SAY_TH_MOUNTS_UP');
INSERT INTO creature_text VALUES(17876, 6, 0, 'Taretha must be in the inn. Let''s go.', 12, 0, 100, 0, 0, 0, 0, 'thrall hillsbrad SAY_TH_CHURCH_END');
INSERT INTO creature_text VALUES(17876, 7, 0, 'Taretha! What foul magic is this?', 12, 0, 100, 0, 0, 0, 0, 'thrall hillsbrad SAY_TH_MEET_TARETHA');
INSERT INTO creature_text VALUES(17876, 8, 0, 'Who or what was that?', 12, 0, 100, 0, 0, 10470, 0, 'thrall hillsbrad SAY_TH_EPOCH_WONDER');
INSERT INTO creature_text VALUES(17876, 9, 0, 'No!', 12, 0, 100, 0, 0, 10471, 0, 'thrall hillsbrad SAY_TH_EPOCH_KILL_TARETHA');
INSERT INTO creature_text VALUES(17876, 10, 0, 'Goodbye, Taretha. I will never forget your kindness.', 12, 0, 100, 0, 0, 10472, 0, 'thrall hillsbrad SAY_TH_EVENT_COMPLETE');
INSERT INTO creature_text VALUES(17876, 11, 0, 'Things are looking grim...', 12, 0, 100, 0, 0, 10458, 0, 'thrall hillsbrad SAY_TH_RANDOM_LOW_HP1');
INSERT INTO creature_text VALUES(17876, 11, 1, 'I will fight to the last!', 12, 0, 100, 0, 0, 10459, 0, 'thrall hillsbrad SAY_TH_RANDOM_LOW_HP2');
INSERT INTO creature_text VALUES(17876, 12, 0, 'Taretha...', 12, 0, 100, 0, 0, 10460, 0, 'thrall hillsbrad SAY_TH_RANDOM_DIE1');
INSERT INTO creature_text VALUES(17876, 12, 1, 'A good day...to die...', 12, 0, 100, 0, 0, 10461, 0, 'thrall hillsbrad SAY_TH_RANDOM_DIE2');
INSERT INTO creature_text VALUES(17876, 13, 0, 'I have earned my freedom!', 12, 0, 100, 0, 0, 10448, 0, 'thrall hillsbrad SAY_TH_RANDOM_AGGRO1');
INSERT INTO creature_text VALUES(17876, 13, 1, 'This day is long overdue. Out of my way!', 12, 0, 100, 0, 0, 10449, 0, 'thrall hillsbrad SAY_TH_RANDOM_AGGRO2');
INSERT INTO creature_text VALUES(17876, 13, 2, 'I am a slave no longer!', 12, 0, 100, 0, 0, 10450, 0, 'thrall hillsbrad SAY_TH_RANDOM_AGGRO3');
INSERT INTO creature_text VALUES(17876, 13, 3, 'Blackmoore has much to answer for!', 12, 0, 100, 0, 0, 10451, 0, 'thrall hillsbrad SAY_TH_RANDOM_AGGRO4');
INSERT INTO creature_text VALUES(17876, 14, 0, 'You have forced my hand!', 12, 0, 100, 0, 0, 10452, 0, 'thrall hillsbrad SAY_TH_RANDOM_KILL1');
INSERT INTO creature_text VALUES(17876, 14, 1, 'It should not have come to this!', 12, 0, 100, 0, 0, 10453, 0, 'thrall hillsbrad SAY_TH_RANDOM_KILL2');
INSERT INTO creature_text VALUES(17876, 14, 2, 'I did not ask for this!', 12, 0, 100, 0, 0, 10454, 0, 'thrall hillsbrad SAY_TH_RANDOM_KILL3');
INSERT INTO creature_text VALUES(17876, 15, 0, 'I am truly in your debt, strangers.', 12, 0, 100, 0, 0, 10455, 0, 'thrall hillsbrad SAY_TH_LEAVE_COMBAT1');
INSERT INTO creature_text VALUES(17876, 15, 1, 'Thank you, strangers. You have given me hope.', 12, 0, 100, 0, 0, 10456, 0, 'thrall hillsbrad SAY_TH_LEAVE_COMBAT2');
INSERT INTO creature_text VALUES(17876, 15, 2, 'I will not waste this chance. I will seek out my destiny.', 12, 0, 100, 0, 0, 10457, 0, 'thrall hillsbrad SAY_TH_LEAVE_COMBAT3');
INSERT INTO creature_text VALUES(17876, 16, 0, 'That''s enough out of him.', 12, 0, 100, 0, 0, 0, 0, 'thrall hillsbrad SAY_KILL_ARMORER');
INSERT INTO creature_text VALUES(17876, 17, 0, 'Let''s go.', 12, 0, 100, 0, 0, 0, 0, 'thrall hillsbrad SAY_GO_ARMORED');
INSERT INTO creature_text VALUES(17876, 18, 0, 'She''s not here.', 12, 0, 100, 0, 0, 0, 0, 'thrall hillsbrad SAY_ENTER_CHURCH');
INSERT INTO creature_text VALUES(17876, 19, 0, 'I''m glad you''re safe, Taretha. None of this would have been possible without your friends. They made all of this happen.', 12, 0, 100, 1, 0, 0, 0, 'thrall hillsbrad SAY_GREET_TARETHA');
INSERT INTO creature_text VALUES(17876, 20, 0, 'Then who are these people?', 12, 0, 100, 0, 0, 0, 0, 'thrall hillsbrad SAY_CHAT_TARETHA1');

UPDATE creature_template SET gossip_menu_id=7499, speed_walk=1, speed_run=1, AIName='', ScriptName='npc_thrall_old_hillsbrad' WHERE entry=17876;
UPDATE creature_template SET gossip_menu_id=7499, speed_walk=1, speed_run=1, AIName='', ScriptName='' WHERE entry=20548;
DELETE FROM script_waypoint WHERE entry=17876;
INSERT INTO script_waypoint VALUES (17876, 0, 2230.91, 118.765, 82.6947, 0, 'Speak event start'),(17876, 1, 2230.33, 114.98, 82.6946, 0, ''),(17876, 2, 2233.36, 111.057, 82.6996, 0, ''),(17876, 3, 2231.17, 108.486, 83.0624, 0, ''),(17876, 4, 2220.22, 114.605, 89.8264, 0, ''),(17876, 5, 2215.23, 115.99, 89.8549, 0, ''),(17876, 6, 2210, 106.849, 89.8549, 0, ''),(17876, 7, 2205.66, 105.234, 89.8549, 0, ''),(17876, 8, 2188.92, 114.265, 89.8549, 3500, 'Stop and call armorer'),(17876, 9, 2184.07, 112.039, 89.8548, 6000, 'Kill armorer'),
(17876, 10, 2181.62, 120.385, 89.8549, 11000, 'Get Armor and Weapons'),(17876, 11, 2189.44, 113.922, 89.8549, 0, ''),(17876, 12, 2195.63, 110.584, 89.8549, 0, ''),(17876, 13, 2201.09, 115.115, 89.8549, 0, 'Summon First Ambush'),(17876, 14, 2204.34, 121.036, 89.8355, 0, ''),(17876, 15, 2208.66, 129.127, 88.356, 0, 'First Ambush'),(17876, 16, 2193.09, 137.94, 88.6164, 0, 'Summon Second Ambush'),(17876, 17, 2173.39, 149.064, 88.3227, 0, ''),(17876, 18, 2164.25, 137.965, 85.4595, 0, 'Summon Third Ambush'),(17876, 19, 2149.31, 125.645, 77.4858, 0, 'Second Ambush'),(17876, 20, 2142.78, 127.173, 75.9954, 0, ''),
(17876, 21, 2139.28, 133.952, 74.0386, 0, ''),(17876, 22, 2139.54, 155.235, 67.5269, 0, 'Summon Fourth Ambush'),(17876, 23, 2145.38, 167.551, 65.2974, 0, 'Third Ambush'),(17876, 24, 2134.28, 175.304, 68.3446, 0, ''),(17876, 25, 2118.08, 187.387, 69.2141, 0, ''),(17876, 26, 2105.88, 195.461, 65.5854, 0, 'Fourth Ambush'),(17876, 27, 2096.77, 196.939, 65.6117, 0, ''),(17876, 28, 2083.9, 209.395, 65.2736, 0, 'Summon Captain Skarloc'),(17876, 29, 2062.9, 229.93, 64.454, 0, 'Waiting for Captain Skarloc'),(17876, 30, 2047.03, 250.852, 62.78, 10000, 'Enter Mount'),(17876, 31, 2039.2, 266.46, 63.4182, 0, ''),
(17876, 32, 2011.77, 278.478, 65.7388, 0, ''),(17876, 33, 2005.08, 289.676, 66.5179, 0, ''),(17876, 34, 2033.11, 337.45, 66.4948, 0, ''),(17876, 35, 2070.3, 416.208, 66.4893, 0, ''),(17876, 36, 2086.76, 469.768, 66.3182, 0, ''),(17876, 37, 2101.7, 497.955, 62.1881, 0, ''),(17876, 38, 2133.39, 530.933, 55.77, 0, ''),(17876, 39, 2157.91, 559.635, 48.9157, 0, ''),(17876, 40, 2167.34, 586.191, 42.8394, 0, ''),(17876, 41, 2174.17, 637.643, 34.3002, 0, ''),(17876, 42, 2179.31, 656.053, 35.123, 0, ''),(17876, 43, 2183.65, 670.941, 34.4318, 0, ''),(17876, 44, 2201.5, 668.616, 36.5236, 0, ''),
(17876, 45, 2221.56, 652.747, 37.0153, 0, ''),(17876, 46, 2238.97, 640.125, 37.6214, 0, ''),(17876, 47, 2251.17, 620.574, 40.5473, 0, ''),(17876, 48, 2261.98, 595.303, 41.8117, 0, ''),(17876, 49, 2278.67, 560.172, 39.309, 0, ''),(17876, 50, 2336.72, 528.327, 41.3369, 0, ''),(17876, 51, 2381.04, 519.612, 38.1312, 0, ''),(17876, 52, 2412.2, 515.425, 39.6068, 0, ''),(17876, 53, 2452.39, 516.174, 43.3387, 0, ''),(17876, 54, 2467.38, 539.389, 47.8992, 0, ''),(17876, 55, 2470.7, 554.333, 47.0668, 0, ''),(17876, 56, 2478.07, 575.321, 55.8549, 0, ''),(17876, 57, 2480, 585.408, 57.0921, 0, ''),
(17876, 58, 2482.67, 608.817, 56.0643, 0, ''),(17876, 59, 2485.62, 626.061, 58.4132, 2000, 'Dismount'),(17876, 60, 2486.91, 626.356, 58.4761, 0, 'Scare Horse'),(17876, 61, 2488.58, 660.94, 57.7913, 0, ''),(17876, 62, 2502.56, 686.059, 56.0252, 0, ''),(17876, 63, 2502.08, 694.36, 55.9083, 0, ''),(17876, 64, 2491.46, 694.321, 56.1163, 0, ''),(17876, 65, 2491.1, 703.3, 56.163, 0, ''),(17876, 66, 2485.64, 702.992, 56.1917, 0, ''),(17876, 67, 2479.1, 695.291, 56.1901, 10000, 'Look around'),(17876, 68, 2479.6, 697.747, 55.791, 0, ''),(17876, 69, 2480.1, 697.747, 55.791, 0, ''),
(17876, 70, 2480.6, 697.747, 55.791, 0, ''),(17876, 71, 2481.27, 697.747, 56.191, 0, ''),(17876, 72, 2486.31, 703.131, 56.1861, 0, ''),(17876, 73, 2490.76, 703.511, 56.1662, 0, ''),(17876, 74, 2491.3, 694.792, 56.1195, 0, ''),(17876, 75, 2518.69, 693.876, 55.5383, 0, ''),(17876, 76, 2531.33, 681.914, 55.5383, 0, ''),(17876, 77, 2568.25, 682.654, 55.5778, 0, ''),(17876, 78, 2589.61, 689.981, 55.5421, 0, ''),(17876, 79, 2634.74, 679.833, 55.0613, 0, ''),(17876, 80, 2630.41, 661.464, 54.6761, 0, ''),(17876, 81, 2629, 656.982, 56.4651, 0, ''),(17876, 82, 2620.84, 633.007, 56.43, 3000, 'Stop in church'),(17876, 83, 2622.99, 639.178, 56.43, 0, ''),
(17876, 84, 2628.73, 656.693, 56.461, 0, ''),(17876, 85, 2630.34, 661.135, 54.6738, 0, ''),(17876, 86, 2635.38, 672.243, 54.8508, 0, ''),(17876, 87, 2644.13, 668.158, 55.7797, 0, ''),(17876, 88, 2646.82, 666.74, 57.3898, 0, ''),(17876, 89, 2658.22, 665.432, 57.5725, 0, ''),(17876, 90, 2661.88, 674.849, 57.5725, 0, ''),(17876, 91, 2656.23, 677.208, 57.5725, 0, 'Summon inn'),(17876, 92, 2652.28, 670.27, 62.3353, 0, ''),(17876, 93, 2650.79, 664.29, 62.3302, 0, ''),(17876, 94, 2660.47, 659.223, 62.33, 0, 'Meet Taretha'),(17876, 95, 2654.28, 662.722, 62.33, 0, ''),(17876, 96, 2652.37, 670.561, 62.33, 0, ''),(17876, 97, 2656.05, 676.761, 57.5727, 0, ''),
(17876, 98, 2658.49, 677.166, 57.5727, 0, ''),(17876, 99, 2659.28, 667.117, 57.5727, 0, ''),(17876, 100, 2649.71, 665.387, 57.5727, 0, ''),(17876, 101, 2634.79, 672.964, 54.8577, 0, 'Outside Inn'),(17876, 102, 2631.72, 665.629, 54.6923, 0, 'Run off'),(17876, 103, 2647.4, 640.53, 56.1634, 0, 'Set invisible');

-- Taretha (18887)
DELETE FROM creature_text WHERE entry=18887;
INSERT INTO creature_text VALUES(18887, 0, 0, 'I''m free! Thank you all!', 12, 0, 100, 0, 0, 0, 0, 'taretha SAY_TARETHA_FREE');
INSERT INTO creature_text VALUES(18887, 1, 0, 'Thrall, you escaped!', 12, 0, 100, 4, 0, 0, 0, 'taretha SAY_TARETHA_ESCAPED');
INSERT INTO creature_text VALUES(18887, 2, 0, 'Thrall, I''ve never met these people before in my life.', 12, 0, 100, 1, 0, 0, 0, 'taretha SAY_TARETHA_TALK1');
INSERT INTO creature_text VALUES(18887, 3, 0, 'They call you a monster. But they''re the monsters, not you. Farewell, Thrall.', 12, 0, 100, 3, 0, 0, 0, 'taretha SAY_TARETHA_TALK2');
UPDATE creature_template SET gossip_menu_id=7852, AIName='', ScriptName='npc_taretha' WHERE entry=18887;
DELETE FROM script_waypoint WHERE entry=18887;
INSERT INTO script_waypoint VALUES (18887, 0, 2650.06, 665.473, 62.3305, 0, 'Taretha'),(18887, 1, 2652.44, 670.761, 62.337, 0, 'Taretha'),(18887, 2, 2655.96, 676.913, 57.5725, 0, 'Taretha'),(18887, 3, 2659.4, 677.317, 57.5725, 0, 'Taretha'),
(18887, 4, 2651.75, 664.482, 57.5725, 0, 'Taretha'),(18887, 5, 2647.49, 666.595, 57.4824, 0, 'Taretha'),(18887, 6, 2644.37, 668.167, 55.8182, 0, 'Taretha'),(18887, 7, 2640.96, 669.89, 55.1567, 58000, 'Taretha'),
(18887, 8, 2640.58, 703.14, 56.05, 0, 'Taretha'),(18887, 9, 2615.44, 732.52, 55.515, 0, 'Taretha');


-- -------------------------------------------
--                 FORMATIONS
-- -------------------------------------------

-- Lordaeron Patrol
REPLACE INTO creature_addon VALUES (31799, 317990, 0, 0, 1, 0, '');
UPDATE creature SET MovementType=2 WHERE guid=31799 AND id=17815;
DELETE FROM creature_formations WHERE leaderGUID IN(31799, 48021, 48022) OR memberGUID IN(31799, 48021, 48022);
INSERT INTO creature_formations VALUES (31799, 31799, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES (31799, 48021, 3, 30, 0, 0, 0);
INSERT INTO creature_formations VALUES (31799, 48022, 3, 330, 0, 0, 0);
DELETE FROM waypoint_data WHERE id=317990;
INSERT INTO waypoint_data VALUES (317990, 1, 2012.28, 303.305, 66.0961, 0, 0, 0, 0, 100, 0),(317990, 2, 2022.04, 319.246, 66.0961, 0, 0, 0, 0, 100, 0),(317990, 3, 2037.86, 345.096, 66.0707, 0, 0, 0, 0, 100, 0),(317990, 4, 2042.85, 356.895, 66.0883, 0, 0, 0, 0, 100, 0),(317990, 5, 2052.83, 380.501, 65.8842, 0, 0, 0, 0, 100, 0),(317990, 6, 2065.57, 410.609, 66.0785, 0, 0, 0, 0, 100, 0),(317990, 7, 2073.74, 429.951, 66.1518, 0, 0, 0, 0, 100, 0),(317990, 8, 2082.5, 456.594, 66.1713, 0, 0, 0, 0, 100, 0),(317990, 9, 2092.95, 481.287, 64.8365, 0, 0, 0, 0, 100, 0),(317990, 10, 2098.86, 495.277, 62.3943, 0, 0, 0, 0, 100, 0),
(317990, 11, 2106.43, 505.615, 60.4547, 0, 0, 0, 0, 100, 0),(317990, 12, 2126.77, 526.456, 56.405, 0, 0, 0, 0, 100, 0),(317990, 13, 2139.82, 539.833, 53.5062, 0, 0, 0, 0, 100, 0),(317990, 14, 2157.84, 562.642, 48.0064, 0, 0, 0, 0, 100, 0),(317990, 15, 2162.46, 572.073, 45.5769, 0, 0, 0, 0, 100, 0),(317990, 16, 2170.31, 606.138, 39.6039, 0, 0, 0, 0, 100, 0),(317990, 17, 2172.45, 617.631, 37.8184, 0, 0, 0, 0, 100, 0),(317990, 18, 2174.9, 636.02, 34.0883, 0, 0, 0, 0, 100, 0),(317990, 19, 2172.98, 624.487, 36.4453, 0, 0, 0, 0, 100, 0),(317990, 20, 2170.12, 607.224, 39.4342, 0, 0, 0, 0, 100, 0),
(317990, 21, 2165.16, 577.349, 44.325, 0, 0, 0, 0, 100, 0),(317990, 22, 2157.34, 560.372, 48.4329, 0, 0, 0, 0, 100, 0),(317990, 23, 2141.47, 541.619, 53.1609, 0, 0, 0, 0, 100, 0),(317990, 24, 2129.42, 527.383, 56.1197, 0, 0, 0, 0, 100, 0),(317990, 25, 2112.52, 511.374, 59.1048, 0, 0, 0, 0, 100, 0),(317990, 26, 2100.11, 494.181, 62.5011, 0, 0, 0, 0, 100, 0),(317990, 27, 2089.62, 476.307, 65.598, 0, 0, 0, 0, 100, 0),(317990, 28, 2078.53, 440.691, 66.2242, 0, 0, 0, 0, 100, 0),(317990, 29, 2068.76, 413.184, 66.0758, 0, 0, 0, 0, 100, 0),
(317990, 30, 2054.25, 381.335, 65.9459, 0, 0, 0, 0, 100, 0),(317990, 31, 2041.67, 353.725, 66.0826, 0, 0, 0, 0, 100, 0),(317990, 32, 2030.37, 333.337, 66.0948, 0, 0, 0, 0, 100, 0),(317990, 33, 2019.47, 315.384, 66.0948, 0, 0, 0, 0, 100, 0),(317990, 34, 2002.58, 287.546, 66.1893, 0, 0, 0, 0, 100, 0);

