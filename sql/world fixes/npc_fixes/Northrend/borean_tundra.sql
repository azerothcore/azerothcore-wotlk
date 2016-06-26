
-- Kara Thricestar <Air Traffic Controller> (26602)
DELETE FROM gossip_menu_option WHERE menu_id=9683 AND npc_option_npcflag=8192;
INSERT INTO gossip_menu_option VALUES (9683, 0, 2, 'Show me where I can fly.', 4, 8192, 0, 0, 0, 0, '');

-- Coldarra Spellweaver (25722)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=25722;
DELETE FROM smart_scripts WHERE entryorguid=25722 AND source_type=0;
INSERT INTO smart_scripts VALUES (25722, 0, 0, 0, 0, 0, 100, 0, 0, 0, 600, 5300, 11, 34447, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coldarra Spellweaver - In Combat - Cast Arcane Missiles');
INSERT INTO smart_scripts VALUES (25722, 0, 1, 0, 1, 0, 100, 1, 100, 100, 0, 0, 11, 39550, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coldarra Spellweaver - Out of Combat - Cast Arcane Channeling');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=25722;
INSERT INTO conditions VALUES(22, 2, 25722, 0, 0, 29, 1, 25720, 30, 0, 0, 0, 0, '', 'Run action if npc is nearby');

-- Coldarra Spellbinder (25719)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=25719;
DELETE FROM smart_scripts WHERE entryorguid=25719 AND source_type=0;
INSERT INTO smart_scripts VALUES (25719, 0, 0, 0, 0, 0, 100, 0, 0, 0, 3900, 5800, 11, 9672, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coldarra Spellbinder - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (25719, 0, 1, 0, 0, 0, 100, 0, 1700, 13500, 172100, 172100, 11, 50583, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coldarra Spellbinder - In Combat - Cast Summon Frozen Spheres');
INSERT INTO smart_scripts VALUES (25719, 0, 2, 0, 1, 0, 100, 1, 100, 100, 0, 0, 11, 39550, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coldarra Spellbinder - Out of Combat - Cast Arcane Channeling');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=25719;
INSERT INTO conditions VALUES(22, 3, 25719, 0, 0, 29, 1, 25720, 30, 0, 0, 0, 0, '', 'Run action if npc is nearby');

-- Raelorasz (26117)
DELETE FROM creature_text WHERE entry=26117;
INSERT INTO creature_text VALUES (26117, 0, 0, 'Sleep now, young one...', 12, 0, 100, 0, 0, 0, 0, 'Raelorasz');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup IN(9253, 9284) AND SourceEntry=1;
INSERT INTO conditions VALUES(15, 9253, 1, 0, 0, 8, 0, 11943, 0, 0, 0, 0, 0, '', 'Must reward 11943 before this option is visible');
INSERT INTO conditions VALUES(15, 9253, 1, 0, 0, 2, 0, 35671, 1, 0, 1, 0, 0, '', 'Must not have item 35671');
INSERT INTO conditions VALUES(15, 9253, 1, 0, 0, 8, 0, 11967, 0, 0, 1, 0, 0, '', 'Gossip Option requires Mustering the Reds not rewarded');
UPDATE creature_template SET npcflag=npcflag|1, gossip_menu_id=9253, AIName='SmartAI', ScriptName='' WHERE entry=26117; -- Raelorasz
DELETE FROM gossip_menu_option WHERE menu_id IN(9253, 9284) AND id=1;
INSERT INTO gossip_menu_option VALUES(9253, 1, 0, 'I seem to have lost the Augmented Arcane Prison. Did I leave it here with you?', 1, 1, 0, 0, 0, 0, '');
DELETE FROM smart_scripts WHERE entryorguid=26117 AND source_type=0;
INSERT INTO smart_scripts VALUES (26117, 0, 0, 1, 62, 0, 100, 0, 9253, 1, 0, 0, 85, 46764, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Raelorasz - On Gossip Select - Cross Cast Push Arcane Prison');
INSERT INTO smart_scripts VALUES (26117, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Raelorasz - On Gossip Select - Close Gossip');
INSERT INTO smart_scripts VALUES (26117, 0, 2, 0, 60, 0, 100, 0, 5000, 5000, 5000, 5000, 45, 1, 26127, 0, 0, 0, 0, 11, 26127, 30, 0, 0, 0, 0, 0, 'Raelorasz - On Update - Set Data');

-- Shadowstalker Luther (25328)
UPDATE creature_template SET unit_flags=unit_flags|4|2, flags_extra=2|4194304, AIName='NullCreatureAI', ScriptName='' WHERE entry=25328;

-- Mage Hunter Target (24862)
UPDATE creature SET spawndist=0, MovementType=0 WHERE id=24862;
UPDATE creature_template SET InhabitType=4, flags_extra=130 WHERE entry=24862;

-- Elder Kesuk (25397)
UPDATE creature SET modelid=0 WHERE id=25397;

-- Grunt Ragefist (25336)
UPDATE creature_template SET AIName='SmartAI' WHERE entry=25336;
DELETE FROM smart_scripts WHERE entryorguid=25336 AND source_type=0;
INSERT INTO smart_scripts VALUES (25336, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 80, 2533600, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grunt Ragefist - On Data Set 1 1 - Run Script');
INSERT INTO smart_scripts VALUES (25336, 0, 1, 2, 38, 0, 100, 0, 2, 2, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grunt Ragefist - On Data Set 2 2 - Set Run on');
INSERT INTO smart_scripts VALUES (25336, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 29, 2, 3, 0, 0, 0, 0, 19, 25335, 0, 0, 0, 0, 0, 0, 'Grunt Ragefist - On Data Set 2 2 - Follow Longrunner Proudhoof');
INSERT INTO smart_scripts VALUES (25336, 0, 3, 0, 38, 0, 100, 0, 3, 3, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grunt Ragefist - On Data Set 3 3 - Despawn');
INSERT INTO smart_scripts VALUES (25336, 0, 4, 0, 38, 0, 100, 0, 4, 4, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grunt Ragefist - On Data Set 4 4 - Set Home Position');
INSERT INTO smart_scripts VALUES (25336, 0, 5, 0, 1, 0, 100, 0, 0, 0, 2000, 2000, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grunt Ragefist - OOC - Set Home Position');
INSERT INTO smart_scripts VALUES (25336, 0, 6, 0, 11, 0, 100, 0, 0, 0, 0, 0, 81, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grunt Ragefist - On Respawn - Set NPC Flags');

-- Karen "I Don't Caribou" the Culler (25803)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=25803;
DELETE FROM smart_scripts WHERE entryorguid=25803 AND source_type=0;
INSERT INTO smart_scripts VALUES (25803, 0, 0, 0, 0, 0, 100, 0, 8000, 10000, 10000, 15000, 11, 42724, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Karen "I Don''t Caribou" the Culler - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (25803, 0, 1, 0, 0, 0, 100, 0, 4000, 4000, 15000, 21000, 11, 48280, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Karen "I Don''t Caribou" the Culler - In Combat - Cast Whirlwind');
INSERT INTO smart_scripts VALUES (25803, 0, 2, 0, 9, 0, 100, 0, 8, 25, 10000, 10000, 11, 27577, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Karen "I Don''t Caribou" the Culler - Within Range 8-25yd - Cast Intercept');

-- Marsh Caribou (25680)
UPDATE creature SET spawndist=0, MovementType=0, unit_flags=768, dynamicflags=32 WHERE id=25680 AND guid IN(103024, 103025, 103026, 103027, 103028);

-- Nerub'ar Venomspitter (24563)
UPDATE creature_template SET InhabitType=3 WHERE entry=24563;
