
-- Rocket Chicken (34492)
REPLACE INTO creature_template_addon VALUES(25109, 0, 0, 0, 0, 0, '45202');
DELETE FROM spell_script_names WHERE spell_id=45202;
INSERT INTO spell_script_names VALUES(45202, "spell_item_rocket_chicken");

-- Sleepy Willy (32617)
REPLACE INTO creature_template_addon VALUES(23231, 0, 0, 0, 0, 0, '40619');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND sourceEntry=40638;
INSERT INTO conditions VALUES(13, 1, 40638, 0, 0, 31, 0, 3, 0, 0, 0, 0, 0, "", "Sleepy Willy laser");
DELETE FROM spell_script_names WHERE spell_id=40638;
INSERT INTO spell_script_names VALUES(40638, "spell_item_sleepy_willy");

-- Tyrael's Hilt (39656)
REPLACE INTO creature_text VALUES(29089, 0, 0, '%s falls asleep.', 16, 0, 100, 15, 0, 0, 0, 'Mini-Tyrael');
REPLACE INTO creature_text VALUES(29089, 1, 0, '%s becomes enraged.', 16, 0, 100, 15, 0, 0, 0, 'Mini-Tyrael');
REPLACE INTO creature_template_addon VALUES(29089, 0, 0, 0, 0, 0, '69205');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=29089;
DELETE FROM smart_scripts WHERE entryorguid=29089 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(29089, 29089*100, 29089*100+1, 29089*100+2) AND source_type=9;
INSERT INTO smart_scripts VALUES (29089, 0, 0, 0, 22, 0, 100, 0, 34, 5000, 5000, 0, 5, 94, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Emote Receive - Dance');
INSERT INTO smart_scripts VALUES (29089, 0, 1, 2, 8, 0, 100, 0, 69204, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Talk');
INSERT INTO smart_scripts VALUES (29089, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 87, 29089*100, 29089*100, 29089*100+1, 29089*100+2, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Random Action List');
INSERT INTO smart_scripts VALUES (29089*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 28, 69204, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Remove aura');
INSERT INTO smart_scripts VALUES (29089*100+1, 9, 0, 0, 0, 0, 100, 0, 15000, 15000, 0, 0, 28, 69204, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Remove aura');
INSERT INTO smart_scripts VALUES (29089*100+2, 9, 0, 0, 0, 0, 100, 0, 15000, 15000, 0, 0, 28, 69204, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Remove aura');
INSERT INTO smart_scripts VALUES (29089*100+2, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');

-- Sinister Squashling (33154)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=23909;
DELETE FROM smart_scripts WHERE entryorguid=23909 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=23909*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (23909, 0, 0, 1, 60, 0, 100, 0, 6000, 9000, 600000, 900000, 11, 42598, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Cast Spell');
INSERT INTO smart_scripts VALUES (23909, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 23909*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Call action list');
INSERT INTO smart_scripts VALUES (23909*100, 9, 0, 0, 0, 0, 100, 0, 25000, 25000, 0, 0, 28, 42598, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Remove Aura');

-- Egbert (32616)
REPLACE INTO creature_template_addon VALUES(23258, 0, 0, 0, 0, 0, '40670');
DELETE FROM spell_script_names WHERE spell_id=40670;
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=23258;
DELETE FROM smart_scripts WHERE entryorguid=23258 AND source_type=0;
INSERT INTO smart_scripts VALUES (23258, 0, 0, 0, 8, 0, 66, 0, 40669, 0, 0, 0, 28, 40669, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Egbert - On Spell Hit - Remove Aura Egbert');

-- Dragon Kite (34493)
REPLACE INTO creature_template_addon VALUES(25110, 0, 0, 0, 0, 0, '45207');
REPLACE INTO creature_template_addon VALUES(25168, 0, 0, 0, 0, 0, '45213');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=25110;
UPDATE creature_template SET InhabitType=4, flags_extra=130, AIName='SmartAI', ScriptName='' WHERE entry=25168;
DELETE FROM smart_scripts WHERE entryorguid=25110 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=25168 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=25110*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (25110, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 11, 45192, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Dragon Kite - Is Summoned - Cast Kite String');
INSERT INTO smart_scripts VALUES (25110, 0, 1, 0, 60, 0, 100, 0, 180000, 600000, 180000, 600000, 80, 25110*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragon Kite - On Update - Run Script');
INSERT INTO smart_scripts VALUES (25110*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 45208, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragon Kite Script - Cast Summon Lightning Bunny');
INSERT INTO smart_scripts VALUES (25110*100, 9, 1, 0, 0, 0, 100, 0, 3400, 3400, 0, 0, 11, 45209, 2, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Dragon Kite Script - Cast .Kite - Lightning Strike Player');
INSERT INTO smart_scripts VALUES (25168, 0, 0, 0, 60, 0, 100, 1, 3000, 3000, 0, 0, 11, 45197, 2, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Kite Lightning Bunny - Is Summoned - Cast Kite - Lightning Strike Kite Aura');
DELETE FROM spell_script_names WHERE spell_id=45208;
INSERT INTO spell_script_names VALUES(45208, "spell_item_dragon_kite_summon_lightning_bunny");

-- Tuskarr Kite (49287)
REPLACE INTO creature_template_addon VALUES(36482, 0, 0, 0, 0, 0, '45207');
REPLACE INTO creature_template_addon VALUES(25212, 0, 0, 0, 0, 0, '45213');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=36482;
UPDATE creature_template SET InhabitType=4, flags_extra=130, AIName='SmartAI', ScriptName='' WHERE entry=25212;
DELETE FROM smart_scripts WHERE entryorguid=36482 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=25212 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=36482*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (36482, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 11, 45192, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Dragon Kite - Is Summoned - Cast Kite String');
INSERT INTO smart_scripts VALUES (36482, 0, 1, 0, 60, 0, 100, 0, 180000, 600000, 180000, 600000, 80, 36482*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragon Kite - On Update - Run Script');
INSERT INTO smart_scripts VALUES (36482*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 45253, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragon Kite Script - Cast Summon Sky Lightning Bunny');
INSERT INTO smart_scripts VALUES (36482*100, 9, 1, 0, 0, 0, 100, 0, 3400, 3400, 0, 0, 11, 45209, 2, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Dragon Kite Script - Cast .Kite - Lightning Strike Player');
INSERT INTO smart_scripts VALUES (25212, 0, 0, 0, 60, 0, 100, 1, 3000, 3000, 0, 0, 11, 45251, 2, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Kite Lightning Bunny - Is Summoned - Cast Kite -Sky  Lightning Strike Kite Aura');
DELETE FROM spell_script_names WHERE spell_id=45253;
INSERT INTO spell_script_names VALUES(45253, "spell_item_dragon_kite_summon_lightning_bunny");

-- Shimmering Wyrmling (46820)
-- Shimmering Wyrmling (46821)
REPLACE INTO creature_template_addon VALUES(34724, 0, 0, 33554432, 0, 0, '66102');
UPDATE creature_template SET InhabitType=4, HoverHeight=2 WHERE entry=34724;

-- Enchanted Broom (44982)
REPLACE INTO creature_template_addon VALUES(33227, 0, 0, 0, 0, 0, '62571');
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=33227;
DELETE FROM smart_scripts WHERE entryorguid=33227 AND source_type=0;
DELETE FROM spell_script_names WHERE spell_id IN(62571, 62570);
INSERT INTO spell_script_names VALUES(62571, "spell_item_enchanted_broom_periodic");

-- Ice Chip (53641)
REPLACE INTO creature_template_addon VALUES(40198, 0, 0, 0, 0, 0, '74957');
DELETE FROM spell_script_names WHERE spell_id=74960;
INSERT INTO spell_script_names VALUES(74960, "spell_gen_select_target_count_30_1");

-- Turkey Cage (44810)
REPLACE INTO creature_text VALUES(32818, 0, 0, '%s senses his destiny!', 16, 0, 100, 0, 0, 0, 0, 'Plump Turkey');
UPDATE creature_template SET AIName='', ScriptName='npc_pet_gen_plump_turkey' WHERE entry=32818;

-- Nurtured Penguin Egg (44723)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=32595;
DELETE FROM smart_scripts WHERE entryorguid=32595 AND source_type=0;
INSERT INTO smart_scripts VALUES (32595, 0, 0, 0, 22, 0, 100, 0, 80, 15000, 15000, 0, 11, 61174, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Emote Receive - Cast Spell');

-- Proto-Drake Whelp (44721)
REPLACE INTO creature_template_addon VALUES(32592, 0, 0, 50331648, 0, 0, '');
UPDATE creature_template SET InhabitType=4, HoverHeight=2, AIName='', ScriptName='' WHERE entry=32592;

-- Wind Rider Cub (49663)
REPLACE INTO creature_template_addon VALUES(36909, 0, 0, 0, 0, 0, '');
UPDATE creature_template SET InhabitType=5, AIName='', ScriptName='npc_pet_gen_wind_rider_cub' WHERE entry=36909;

-- Toxic Wasteling (50446)
REPLACE INTO creature_template_addon VALUES(38374, 0, 0, 0, 0, 0, '71849');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND sourceEntry=71848;
INSERT INTO conditions VALUES(13, 1, 71848, 0, 0, 31, 0, 3, 0, 0, 0, 0, 0, "", "Toxic Wasteling find target");
DELETE FROM spell_script_names WHERE spell_id IN(71848, 71874);
INSERT INTO spell_script_names VALUES(71848, "spell_item_sleepy_willy"); -- Same functionality
INSERT INTO spell_script_names VALUES(71874, "spell_item_toxic_wasteling");
DELETE FROM spell_linked_spell WHERE spell_trigger=71847;
INSERT INTO spell_linked_spell VALUES(71847, 71874, 0, 'Toxic Wasteling Devour');
UPDATE creature_template SET AIName='', ScriptName='npc_pet_gen_toxic_wasteling' WHERE entry=38374;

-- Lil' Phylactery (49693)
REPLACE INTO creature_template_addon VALUES(36979, 0, 0, 0, 0, 0, '69683');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND sourceEntry=69682;
INSERT INTO conditions VALUES(13, 1, 69682, 0, 0, 31, 0, 3, 0, 0, 0, 0, 0, "", "Lil' K.T find target");
DELETE FROM spell_script_names WHERE spell_id IN(69682);
INSERT INTO spell_script_names VALUES(69682, "spell_item_sleepy_willy"); -- Same functionality
DELETE FROM spell_script_names WHERE spell_id IN(69732);
INSERT INTO spell_script_names VALUES(69732, "spell_item_lil_phylactery");
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=36979;
DELETE FROM smart_scripts WHERE entryorguid=36979 AND source_type=0;
INSERT INTO smart_scripts VALUES (36979, 0, 0, 0, 60, 0, 100, 257, 0, 0, 0, 0, 86, 69732, 2, 23, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'On Update - Cross Cast (Never Repeat)');
INSERT INTO smart_scripts VALUES (36979, 0, 1, 0, 60, 0, 100, 0, 20000, 60000, 120000, 120000, 5, 402, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Play Emote');
INSERT INTO smart_scripts VALUES (36979, 0, 2, 0, 5, 0, 100, 0, 0, 0, 0, 0, 4, 16493, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Kill Unit - Play Sound');
INSERT INTO smart_scripts VALUES (36979, 0, 3, 0, 8, 0, 100, 0, 69731, 0, 0, 0, 4, 16493, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Play Sound');

-- Lil' XT (54847)
REPLACE INTO creature_text VALUES(40703, 0, 0, "I'm ready to play!", 12, 0, 100, 0, 0, 15726, 0, 'Lil XT');
REPLACE INTO creature_text VALUES(40703, 1, 0, "So tired... I'll rest for just a moment...", 12, 0, 100, 0, 0, 15725, 0, 'Lil XT');
REPLACE INTO creature_text VALUES(40703, 2, 0, "I guess it doesn't bend that way!", 12, 0, 100, 0, 0, 15729, 0, 'Lil XT');
REPLACE INTO creature_text VALUES(40703, 2, 1, "I think I broke it...", 12, 0, 100, 0, 0, 15728, 0, 'Lil XT');
REPLACE INTO creature_text VALUES(40703, 3, 0, "New toys? For me?", 12, 0, 100, 0, 0, 15724, 0, 'Lil XT');
REPLACE INTO creature_template_addon VALUES(40703, 0, 0, 0, 0, 0, '76099');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=40703;
DELETE FROM smart_scripts WHERE entryorguid=40703 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=40703*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (40703, 0, 0, 1, 25, 0, 100, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Talk');
INSERT INTO smart_scripts VALUES (40703, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Set Phase');
INSERT INTO smart_scripts VALUES (40703, 0, 2, 3, 60, 1, 100, 0, 35000, 45000, 120000, 120000, 11, 76116, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Cast Spell Sleep');
INSERT INTO smart_scripts VALUES (40703, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 'On Update - Talk');
INSERT INTO smart_scripts VALUES (40703, 0, 4, 0, 60, 1, 100, 0, 100000, 105000, 120000, 120000, 11, 76114, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Cast Spell Dance');
INSERT INTO smart_scripts VALUES (40703, 0, 5, 0, 60, 0, 100, 0, 5000, 5000, 30000, 30000, 80, 40703*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Script9');

INSERT INTO smart_scripts VALUES (40703*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Phase');
INSERT INTO smart_scripts VALUES (40703*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (40703*100, 9, 2, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 97, 10, 10, 1, 0, 0, 0, 20, 193963, 15, 0, 0, 0, 0, 0, 'Script9 - Jump To Target');
INSERT INTO smart_scripts VALUES (40703*100, 9, 3, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 11, 76092, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (40703*100, 9, 4, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Phase');
INSERT INTO smart_scripts VALUES (40703*100, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 29, 1, 1.57, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Follow');
INSERT INTO smart_scripts VALUES (40703*100, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND sourceEntry=76098;
INSERT INTO conditions VALUES(13, 1, 76098, 0, 0, 31, 0, 3, 32345, 0, 0, 0, 0, "", "Lil' XT find Grindgear Toy Gorilla");
INSERT INTO conditions VALUES(13, 1, 76098, 0, 1, 31, 0, 3, 17299, 0, 0, 0, 0, "", "Lil' XT find Crashin Trashin Robot");
INSERT INTO conditions VALUES(13, 1, 76098, 0, 2, 31, 0, 3, 27664, 0, 0, 0, 0, "", "Lil' XT find Crashin Trashin Racer");
INSERT INTO conditions VALUES(13, 1, 76098, 0, 3, 31, 0, 3, 40281, 0, 0, 0, 0, "", "Lil' XT find Crashin Trashin Racer Blue");
INSERT INTO conditions VALUES(13, 1, 76098, 0, 4, 31, 0, 3, 24968, 0, 0, 0, 0, "", "Lil' XT find Clockwork Rocket Bot");
INSERT INTO conditions VALUES(13, 1, 76098, 0, 5, 31, 0, 3, 40295, 0, 0, 0, 0, "", "Lil' XT find Blue Clockwork Rocket Bot");
INSERT INTO conditions VALUES(13, 1, 76098, 0, 6, 31, 0, 3, 32247, 0, 0, 0, 0, "", "Lil' XT find Zippy Copper Racer");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND sourceEntry=76092;
INSERT INTO conditions VALUES(13, 1, 76092, 0, 0, 31, 0, 5, 193963, 0, 0, 0, 0, "", "Lil' XT target Toy Train Set");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND sourceEntry=40703;
INSERT INTO conditions VALUES(22, 6, 40703, 0, 0, 30, 1, 193963, 10, 0, 0, 0, 0, "", "Run Action if GO Near");
DELETE FROM spell_script_names WHERE spell_id IN(76098, 76096);
INSERT INTO spell_script_names VALUES(76096, "spell_item_lil_xt");
INSERT INTO spell_script_names VALUES(76098, "spell_item_lil_xt");

-- Wind-Up Train Wrecker (45057)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND sourceEntry=62949;
INSERT INTO conditions VALUES(17, 0, 62949, 0, 0, 30, 0, 193963, 10, 0, 0, 0, 0, "", "Requires GO in range");
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=33404;
DELETE FROM smart_scripts WHERE entryorguid=33404 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=33404*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (33404, 0, 0, 0, 60, 0, 100, 1, 0, 0, 0, 0, 80, 33404*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Script9');
INSERT INTO smart_scripts VALUES (33404*100, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 20, 193963, 15, 0, 0, 0, 0, 0, 'Script9 - Set Orientation');
INSERT INTO smart_scripts VALUES (33404*100, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 46, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Move Forward');
INSERT INTO smart_scripts VALUES (33404*100, 9, 2, 0, 0, 0, 100, 0, 2500, 2500, 0, 0, 97, 5, 7, 1, 0, 0, 0, 20, 193963, 15, 0, 0, 0, 0, 0, 'Script9 - Jump To Pos');
INSERT INTO smart_scripts VALUES (33404*100, 9, 3, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 11, 62943, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (33404*100, 9, 4, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 11, 76114, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (33404*100, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Despawn');

-- Teldrassil Sproutling (44965)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=33188;
DELETE FROM smart_scripts WHERE entryorguid=33188 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(33188*100, 33188*100+1) AND source_type=9;
INSERT INTO smart_scripts VALUES (33188, 0, 0, 0, 60, 0, 40, 0, 30000, 30000, 30000, 30000, 87, 33188*100, 33188*100+1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Update - Random Action List');
INSERT INTO smart_scripts VALUES (33188*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 62504, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell Dance');
INSERT INTO smart_scripts VALUES (33188*100, 9, 1, 0, 0, 0, 100, 0, 10000, 25000, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Remove All Auras');
INSERT INTO smart_scripts VALUES (33188*100+1, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 62499, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell Sleep');
INSERT INTO smart_scripts VALUES (33188*100+1, 9, 1, 0, 0, 0, 100, 0, 10000, 25000, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Remove All Auras');

-- Lurky's Egg (30360)
DELETE FROM spell_script_names WHERE spell_id IN(24983, 24984);
INSERT INTO spell_script_names VALUES (24983, 'spell_gen_baby_murloc_passive');
INSERT INTO spell_script_names VALUES (24984, 'spell_gen_baby_murloc');
REPLACE INTO creature_template_addon VALUES (15358, 0, 0, 0, 0, 0, '24983');
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=15358;
DELETE FROM smart_scripts WHERE entryorguid=15358 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=15358*100 AND source_type=9;

-- Pink Murloc Egg (22114)
REPLACE INTO creature_template_addon VALUES (16069, 0, 0, 0, 0, 0, '24983');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=16069;
DELETE FROM smart_scripts WHERE entryorguid=16069 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=16069*100 AND source_type=9;

-- Blue Murloc Egg (20371)
REPLACE INTO creature_template_addon VALUES (15186, 0, 0, 0, 0, 0, '24983');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=15186;
DELETE FROM smart_scripts WHERE entryorguid=15186 AND source_type=0;

-- Pandaren Monk (49665)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=36911;
DELETE FROM smart_scripts WHERE entryorguid=36911 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(36911*100, 36911*100+1) AND source_type=9;
INSERT INTO smart_scripts VALUES (36911, 0, 0, 1, 22, 0, 100, 0, 17, 5000, 5000, 0, 66, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Emote Bow Receive - Set Orientation');
INSERT INTO smart_scripts VALUES (36911, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 36911*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Emote Bow Receive - Script9');
INSERT INTO smart_scripts VALUES (36911, 0, 2, 3, 22, 0, 100, 0, 35, 5000, 5000, 0, 66, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Emote Drink Receive - Set Orientation');
INSERT INTO smart_scripts VALUES (36911, 0, 3, 0, 61, 0, 100, 0, 35, 5000, 5000, 0, 80, 36911*100+1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Emote Drink Receive - Script9');
INSERT INTO smart_scripts VALUES (36911*100, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 5, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Emote Bow');
INSERT INTO smart_scripts VALUES (36911*100+1, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 11, 69800, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (36911*100+1, 9, 1, 0, 0, 0, 100, 0, 10000, 20000, 0, 0, 28, 69800, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Remove Aura');

-- Durotar Scorpion (44973)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=33198;
DELETE FROM smart_scripts WHERE entryorguid=33198 AND source_type=0;
INSERT INTO smart_scripts VALUES (33198, 0, 0, 0, 60, 0, 100, 0, 30000, 60000, 40000, 120000, 11, 62610, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'On Update - Cast Spell Durotar Scorpion Sting');

-- Elwynn Lamb (44974)
REPLACE INTO creature_template_addon VALUES (33200, 0, 0, 0, 0, 0, '62703'); -- Lamb With Periodic Summon Aura
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=33286;
DELETE FROM smart_scripts WHERE entryorguid=33286 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=33286*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (33286, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 19, 33200, 50, 0, 2, 2, 0, 0, 'On Rest - Move Point');
INSERT INTO smart_scripts VALUES (33286, 0, 1, 0, 34, 0, 100, 0, 8, 1, 0, 0, 80, 33286*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Movement Inform - Script9');
INSERT INTO smart_scripts VALUES (33286, 0, 2, 0, 31, 0, 100, 0, 62701, 0, 0, 0, 51, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Spellhit Target - Kill Unit');
INSERT INTO smart_scripts VALUES (33286*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 33200, 10, 0, 0, 0, 0, 0, 'Script9 - Set Facing');
INSERT INTO smart_scripts VALUES (33286*100, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 11, 62701, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (33286*100, 9, 2, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 11, 46765, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (33286*100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 5500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Despawn');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND sourceEntry=62701;
INSERT INTO conditions VALUES(13, 1, 62701, 0, 0, 31, 0, 3, 33200, 0, 0, 0, 0, "", "Target Closest Elwynn Lamb");

-- Soul-Trader Beacon (38050)
UPDATE creature_template SET gossip_menu_id=9619, unit_flags=2, IconName='Buy', npcflag=129, AIName='', ScriptName='npc_pet_gen_soul_trader_beacon' WHERE entry=27914;
DELETE FROM gossip_menu_option WHERE menu_id=9619;
INSERT INTO gossip_menu_option VALUES (9619, 0, 0, 'How does this work?', 1, 1, 9620, 0, 0, 0, ''),(9619, 1, 1, 'Show me what you have to trade.', 3, 128, 0, 0, 0, 0, '');
DELETE FROM gossip_menu WHERE entry IN (9619,9620) AND text_id IN (13005,13006);
INSERT INTO gossip_menu VALUES (9619, 13005),(9620, 13006);
DELETE FROM creature_text WHERE entry=27914;
INSERT INTO creature_text VALUES (27914, 0, 0, 'I have arrived. Shall we set to work, then?', 12, 0, 100, 0, 0, 0, 0, 'Ethereal Soul-Trader'),
(27914, 1, 0, 'Ah, more essence to capture...', 12, 0, 100, 0, 0, 0, 0, 'Ethereal Soul-Trader'),
(27914, 2, 0, 'Here is your share.', 12, 0, 100, 0, 0, 0, 0, 'Ethereal Soul-Trader');
DELETE FROM npc_text WHERE ID IN (13005,13006);
INSERT INTO npc_text VALUES
(13005, 'How may this one help you, $gsir:madame;?', '', 0, 1, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 18019),
(13006, 'My business partner slays things; I drain a portion of their essence... a pittance, really; the slightest of slivers. It won''t be missed.$B$BStill, to fulfil my portion of the contract, I pay in Ethereal Credits.$B$BOne may redeem these credits for items I sell at any time. I''m bound to have something that will interest you...', '', 0, 1, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 18019);
DELETE FROM npc_vendor WHERE entry=27914;
INSERT INTO npc_vendor VALUES(27914, 0, 38308, 0, 0, 2411),(27914, 0, 38300, 0, 0, 2411),(27914, 0, 38294, 0, 0, 2412),(27914, 0, 38291, 0, 0, 2408),
(27914, 0, 38163, 0, 0, 2408),(27914, 0, 38160, 0, 0, 2410),(27914, 0, 38286, 0, 0, 2407),(27914, 0, 38285, 0, 0, 2408),(27914, 0, 38161, 0, 0, 2409),(27914, 0, 38162, 0, 0, 2409);
