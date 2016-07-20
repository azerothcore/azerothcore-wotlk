
-- Steam Tonk Controller (22728)
-- Battered Steam Tonk Controller (31666)
UPDATE creature_template SET spell1=24933, spell2=25024, spell3=0, spell4=27746 WHERE entry=19405; -- Steam Tonk
UPDATE creature_template SET unit_flags=4|131072, flags_extra=2, AIName='SmartAI', ScriptName='' WHERE entry=15368; -- Tonk Mine
DELETE FROM smart_scripts WHERE entryorguid=15368 AND source_type=0;
INSERT INTO smart_scripts VALUES (15368, 0, 0, 1, 60, 0, 100, 0, 3000, 3000, 1, 1, 11, 25099, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Cast Spell'); -- 3 sec arming time
INSERT INTO smart_scripts VALUES (15368, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Despawn Self');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND sourceEntry IN(24933, 25099, 27745);
INSERT INTO conditions VALUES(13, 1, 24933, 0, 0, 31, 0, 3, 19405, 0, 0, 0, 0, "", "Target Steam Tonk");
INSERT INTO conditions VALUES(13, 1, 25099, 0, 0, 31, 0, 3, 19405, 0, 0, 0, 0, "", "Target Steam Tonk");
INSERT INTO conditions VALUES(13, 1, 27745, 0, 0, 31, 0, 3, 19405, 0, 0, 0, 0, "", "Target Steam Tonk");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND sourceEntry=15368;
INSERT INTO conditions VALUES(22, 1, 15368, 0, 0, 29, 1, 19405, 2, 0, 0, 0, 0, "", "Requires Steam Tonk nearby");

-- Goblin Bomb Dispenser (10587), trinket
-- Explosive Sheep (4384)
UPDATE creature_template SET AIName="", ScriptName="npc_pet_gen_target_following_bomb" WHERE entry IN(2675, 8937); -- sheep, bomb

-- Gnomish Flame Turret (23841)
UPDATE creature_template SET unit_flags=unit_flags|4, baseattacktime=1000, spell1=30527, AIName='', ScriptName='npc_pet_gen_gnomish_flame_turret' WHERE entry=17458;

-- Goblin Land Mine (4395)
DELETE FROM creature_text WHERE entry=7527;
INSERT INTO creature_text VALUES (7527, 0, 0, '%s will be armed in 10 seconds!', 16, 0, 100, 0, 0, 0, 0, 'Goblin Land Mine');
INSERT INTO creature_text VALUES (7527, 1, 0, '%s will be armed in 5 seconds!', 16, 0, 100, 0, 0, 5871, 0, 'Goblin Land Mine');
INSERT INTO creature_text VALUES (7527, 2, 0, '%s is now armed!', 16, 0, 100, 0, 0, 0, 0, 'Goblin Land Mine');
UPDATE creature_template SET unit_flags = unit_flags|4|131072, AIName='SmartAI', ScriptName='' WHERE entry=7527;
DELETE FROM smart_scripts WHERE entryorguid=7527 AND source_type=0;
INSERT INTO smart_scripts VALUES (7527, 0, 0, 1, 60, 0, 100, 257, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Goblin Land Mine - On Update - Say Line 0");
INSERT INTO smart_scripts VALUES (7527, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 11816, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Goblin Land Mine - On Update - Cast Land Mine Arming");
INSERT INTO smart_scripts VALUES (7527, 0, 2, 0, 60, 0, 100, 257, 5000, 5000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Goblin Land Mine - On Update - Say Line 1");
INSERT INTO smart_scripts VALUES (7527, 0, 3, 4, 60, 0, 100, 257, 10000, 10000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Goblin Land Mine - On Update - Say Line 2");
INSERT INTO smart_scripts VALUES (7527, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 28, 11816, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Goblin Land Mine - On Update - Remove Aura Land Mine Arming");
INSERT INTO smart_scripts VALUES (7527, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Goblin Land Mine - Out of Combat - Set Event Phase");
INSERT INTO smart_scripts VALUES (7527, 0, 6, 7, 9, 1, 100, 0, 0, 6, 0, 0, 11, 4043, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Goblin Land Mine - Within 0-6 Range - Cast Spell");
INSERT INTO smart_scripts VALUES (7527, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Goblin Land Mine - Within 0-6 Range - Despawn");

-- Vanquished Clutches of Yogg-Saron (46312)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry IN(34264, 34265, 34266);
DELETE FROM smart_scripts WHERE entryorguid IN(34264, 34265, 34266) AND source_type=0;
INSERT INTO smart_scripts VALUES (34264, 0, 0, 0, 0, 0, 100, 0, 2000, 3000, 4000, 4000, 11, 65038, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast spell on current Victim');
INSERT INTO smart_scripts VALUES (34265, 0, 0, 0, 0, 0, 100, 0, 2000, 3000, 4000, 4000, 11, 65035, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast spell on current Victim');
INSERT INTO smart_scripts VALUES (34266, 0, 0, 0, 0, 0, 100, 0, 2000, 3000, 4000, 4000, 11, 65033, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast spell on current Victim');

-- D.I.S.C.O. (38301)
DELETE FROM spell_linked_spell WHERE spell_trigger=50499;
INSERT INTO spell_linked_spell VALUES(50499, 50493, 1, "D.I.S.C.O.");

-- Goblin Gumbo Kettle (33219)
DELETE FROM spell_script_names WHERE spell_id=42760;
INSERT INTO spell_script_names VALUES(42760, "spell_item_goblin_gumbo_kettle");

-- Toy Train Set (44606)
DELETE FROM spell_linked_spell WHERE spell_trigger=61031;
INSERT INTO spell_linked_spell VALUES(61031, 61551, 0, "Toy Train Set");
DELETE FROM spell_script_names WHERE spell_id=61551;
INSERT INTO spell_script_names VALUES(61551, "spell_item_toy_train_set");
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=193963;
DELETE FROM smart_scripts WHERE entryorguid=193963 AND source_type=1;
INSERT INTO smart_scripts VALUES (193963, 1, 0, 0, 8, 0, 100, 0, 76092, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Despawn (Lil XT)');
INSERT INTO smart_scripts VALUES (193963, 1, 1, 0, 8, 0, 100, 0, 62943, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Despawn (Train Wrecker)');

-- Val'anyr, Hammer of Ancient Kings (46017)
DELETE FROM spell_script_names WHERE spell_id=68496;

-- Shifting Naaru Sliver (34429)
DELETE FROM spell_script_names WHERE spell_id IN(45042, 45043);
INSERT INTO spell_script_names VALUES(45042, "spell_item_shifting_naaru_silver");
INSERT INTO spell_script_names VALUES(45043, "spell_item_shifting_naaru_silver");

-- Instant Statue Pedestal (54212)
UPDATE creature_template SET VehicleId=732, AIName='NullCreatureAI', ScriptName='' WHERE entry=40246;
DELETE FROM spell_linked_spell WHERE spell_trigger IN(74890, 75731, -75731);
INSERT INTO spell_linked_spell VALUES(74890, 75055, 1, 'Instant Statue Pedestal');
INSERT INTO spell_linked_spell VALUES(-75731, -75055, 0, 'Instant Statue Pedestal');

-- Sandbox Tiger (45047)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=33357;
DELETE FROM smart_scripts WHERE entryorguid=33357 AND source_type=0;
INSERT INTO smart_scripts VALUES(33357, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sandbox Tiger - On reset set react state passive');
INSERT INTO smart_scripts VALUES(33357, 0, 1, 0, 27, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sandbox Tiger - On Passenger Board Set Event Phase');
INSERT INTO smart_scripts VALUES(33357, 0, 2, 0, 28, 0, 100, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sandbox Tiger - On Passenger Remove Set Event Phase');
INSERT INTO smart_scripts VALUES(33357, 0, 3, 0, 60, 1, 100, 0, 500, 500, 4000, 4000, 11, 63599, 0, 0, 0, 0, 0, 21, 5, 0, 0, 0, 0, 0, 0, 'Sandbox Tiger - On Update - Cast Spell');

-- Imp in a Ball (32542)
DELETE FROM spell_linked_spell WHERE spell_trigger=40527;
INSERT INTO spell_linked_spell VALUES(40527, 40528, 0, 'Imp In a Bottle');
UPDATE creature_template SET unit_flags=768+33554432, AIName='', ScriptName='npc_pet_gen_imp_in_a_bottle' WHERE entry=23224;
DELETE FROM creature_text WHERE entry=23224;
INSERT INTO creature_text VALUES(23224, 0, 0, "Hey! You try telling the future when someone's shaking up your house!", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 1, "I don't think so, boss.", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 2, "The answer's yes in here, don't see why it'd be different out there!", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 3, "I suppose.", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 4, "It's as sure as the warts on my backside.", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 5, "Yes, unless I have anything to do with it.", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 6, "Jump three times and dance for ten minutes and it will definitely happen!", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 7, "My sources say \"no\". Before the torture, that is.", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 8, "Definitely.", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 9, "I can't see why not, although, I can't see a lot of things right now.", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 10, "Yes, it will rain. That's not what you asked? Too bad!", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 11, "My fortune telling powers are immeasureable - your chances are though: NO CHANCE.", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 12, "The odds are 32.33 [repeating of course] percent change of success.", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 13, "Didn't you already ask that once? Yes already!", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 14, "Avoid taking unnecessary gambles. Your lucky numbers are two, two and a half, and eleven-teen.", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 15, "When Blackrock Freezes over.", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 16, "Survey says: BZZZZT!", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 17, "Imp in a ball is ignoring you.", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 18, "Hey! You try arranging furniture with some jerk shaking your house.", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 19, "Yes, but if anyone else asks... it wasn't me who told you.", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 20, "Hahahahahah, you're kidding right?", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 21, "Sure but you're not going to like it.", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 22, "I don't have to be a fortune-telling imp to know the answer to that one - No!", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 23, "Yes, now stop pestering me.", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 24, "Yes! I mean no! I mean... which answer will get me out of here?", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 25, "When dwarves fly. Oh they do? Then yes.", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 26, "Want to trade places?", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 27, "You remember that time you tried to drill that hole in your head?", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 28, "What happens in the twisting nether, stays in the twisting nether.", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 29, "Yes, yes, a thousand times, yes already!", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 30, "Not unless you're some kind of super-person. And don't kid yourself, you're not.", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 31, "NO - and don't try shaking me again for a better answer!", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 32, "Yes, but I hoped I would never have to answer that.", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 33, "Word on the peninsula is YES!", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 34, "Oh, that's one for sure.", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 35, "Do you ask this question to everything that's trapped in a ball?", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 36, "I ask myself that question everyday.", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 37, "Da King! Chort ready to serve.", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 38, "Are you making fun of me?", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 39, "It's like my mother always said: \"Razxx khaj jhashxx xashjx.\"", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 40, "It pains me to say this, but \"Yes\".", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 41, "This was NOT in my contract!", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 42, "It's times like these that I wish I had a cooldown.", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 43, "Are you my pal, Danny?", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 44, "Wouldn't you like to know?", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 45, "That's about as likely as me getting a date with a succubuss.", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 46, "Yes, it will rain. That's not what you asked? Too bad!", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 47, "Please... is Kil'jaeden red?", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 48, "You should be asking \"Is that rogue behind me going to kill me?\"", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 49, "Yes, is my answer..........NOT!", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 50, "Yeah, sure. You just keep thinking that.", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 51, "XRA RAHKI MAZIZRA!", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 52, "What kind of imp do you think I am?", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 53, "Three Words - \"ab - so - lutely\"!", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 54, "Looks good for you...and bad for me.", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 55, "You need Arcane Intellect, because that answer is obvious! NO!", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 56, "Ruk!", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 57, "It won't matter, you'll be dead by tomorrow.", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 58, "I can make that happen. Just sign below the dotted line...", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 59, "The outlook is very bad for YOU that is! Haha, take it!", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');
INSERT INTO creature_text VALUES(23224, 0, 60, "I've consulted my fellow imps, and we think YES, except for that one imp.", 15, 0, 100, 0, 0, 0, 0, 'Imp in a ball');

-- Foror's Fabled Steed (20221)
REPLACE INTO item_template VALUES (20221, 15, 5, -1, "Foror\'s Fabled Steed", 32728, 5, 0, 0, 1, 0, 0, 0, -1, -1, 40, 40, 762, 150, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 55884, 0, -1, 0, -1, 330, 3000, 24576, 6, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, 'Teaches you how to summon this mount.  This is a very fast mount.', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 1);

-- Sylvanas' Music Box (52253)
UPDATE creature_template SET speed_walk=0.2, speed_run=0.2, InhabitType=5, AIName='SmartAI', ScriptName='' WHERE entry=39048;
DELETE FROM smart_scripts WHERE entryorguid=39048 AND source_type=0;
INSERT INTO smart_scripts VALUES (39048, 0, 0, 1, 60, 0, 100, 1, 200, 200, 0, 0, 11, 37090, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sylvanas Lamenter - On Update - Cast Spell');
INSERT INTO smart_scripts VALUES (39048, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 4, 15095, 1, 0, 0, 0, 0, 18, 50, 0, 0, 0, 0, 0, 0, 'Sylvanas Lamenter - On Update - Play Sound to self');
INSERT INTO smart_scripts VALUES (39048, 0, 2, 3, 60, 0, 100, 1, 1000, 1000, 0, 0, 60, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sylvanas Lamenter - On Update - Set Fly');
INSERT INTO smart_scripts VALUES (39048, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 6, 0, 'Sylvanas Lamenter - On Update - Move Pos To Self offset Z');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND sourceEntry=73331; -- Xinef: music should be played on spell hit, ill do it in lameter ai
INSERT INTO conditions VALUES(13, 1, 73331, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, "", "Target all players");
REPLACE INTO creature_template_addon VALUES (39048, 0, 0, 50331648, 1, 0, '');

-- Blackblade of Shahram (12592)
DELETE FROM disables WHERE sourceType=0 AND entry=16602;
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10718;
DELETE FROM smart_scripts WHERE entryorguid=10718 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(10718*100, 10718*100+1, 10718*100+2, 10718*100+3, 10718*100+4, 10718*100+5) AND source_type=9;
INSERT INTO smart_scripts VALUES (10718, 0, 0, 1, 60, 0, 100, 1, 1000, 1000, 0, 0, 41, 20000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shahram - On Update - Despawn in 20secs');
INSERT INTO smart_scripts VALUES (10718, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Shahram - On Update - Follow Owner');
INSERT INTO smart_scripts VALUES (10718, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 87, 10718*100, 10718*100+1, 10718*100+2, 10718*100+3, 10718*100+4, 10718*100+5, 1, 0, 0, 0, 0, 0, 0, 0, 'Shahram - On Update - Start Random Script');
INSERT INTO smart_scripts VALUES (10718*100+0, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 16597, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shahram - Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (10718*100+1, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 16600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shahram - Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (10718*100+2, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 16601, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shahram - Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (10718*100+3, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 16599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shahram - Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (10718*100+4, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 16598, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shahram - Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (10718*100+5, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 16596, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shahram - Script9 - Cast Spell');

-- Rough Stone Statue (25498)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=18372;
DELETE FROM smart_scripts WHERE entryorguid=18372 AND source_type=0;
INSERT INTO smart_scripts VALUES (18372, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 41, 12500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Respawn - Despawn');
INSERT INTO smart_scripts VALUES (18372, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 32253, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'On Respawn - Cast Spell');
INSERT INTO smart_scripts VALUES (18372, 0, 2, 3, 37, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On AI Init - Set React Passive');
INSERT INTO smart_scripts VALUES (18372, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 18, 16777216, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On AI Init - Set Unit Flag');

-- Coarse Stone Statue (25880)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=18734;
DELETE FROM smart_scripts WHERE entryorguid=18734 AND source_type=0;
INSERT INTO smart_scripts VALUES (18734, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 41, 12500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Respawn - Despawn');
INSERT INTO smart_scripts VALUES (18734, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 32787, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'On Respawn - Cast Spell');
INSERT INTO smart_scripts VALUES (18734, 0, 2, 3, 37, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On AI Init - Set React Passive');
INSERT INTO smart_scripts VALUES (18734, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 18, 16777216, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On AI Init - Set Unit Flag');

-- Heavy Stone Statue (25881)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=18735;
DELETE FROM smart_scripts WHERE entryorguid=18735 AND source_type=0;
INSERT INTO smart_scripts VALUES (18735, 0, 0, 1, 60, 0, 100, 1, 0, 0, 0, 0, 41, 12500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Respawn - Despawn');
INSERT INTO smart_scripts VALUES (18735, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 32788, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'On Respawn - Cast Spell');
INSERT INTO smart_scripts VALUES (18735, 0, 2, 3, 37, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On AI Init - Set React Passive');
INSERT INTO smart_scripts VALUES (18735, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 18, 16777216, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On AI Init - Set Unit Flag');

-- Solid Stone Statue (25882)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=18736;
DELETE FROM smart_scripts WHERE entryorguid=18736 AND source_type=0;
INSERT INTO smart_scripts VALUES (18736, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 41, 12500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Respawn - Despawn');
INSERT INTO smart_scripts VALUES (18736, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 32790, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'On Respawn - Cast Spell');
INSERT INTO smart_scripts VALUES (18736, 0, 2, 3, 37, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On AI Init - Set React Passive');
INSERT INTO smart_scripts VALUES (18736, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 18, 16777216, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On AI Init - Set Unit Flag');

-- Dense Stone Statue (25883)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=18737;
DELETE FROM smart_scripts WHERE entryorguid=18737 AND source_type=0;
INSERT INTO smart_scripts VALUES (18737, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 41, 12500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Respawn - Despawn');
INSERT INTO smart_scripts VALUES (18737, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 32791, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'On Respawn - Cast Spell');
INSERT INTO smart_scripts VALUES (18737, 0, 2, 3, 37, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On AI Init - Set React Passive');
INSERT INTO smart_scripts VALUES (18737, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 18, 16777216, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On AI Init - Set Unit Flag');

-- Windle's Lighter (44435)
DELETE FROM spell_script_names WHERE spell_id IN(60535);
INSERT INTO spell_script_names VALUES(60535, "spell_item_light_lamp");
UPDATE gameobject_template SET flags=0 WHERE data3=28800000 AND faction=1375;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND sourceEntry=60535;
INSERT INTO conditions SELECT 13, 1, 60535, 0, entry, 31, 0, 5, entry, 0, 0, 0, 0, "", "Windle's Lighter, target dalaran lamp" FROM gameobject_template WHERE data3=28800000 AND faction=1375;
DELETE FROM disables WHERE entry=60535 AND sourceType=0 AND flags=64;
INSERT INTO disables VALUES(0, 60535, 64, '', '', 'Windles Lighter, disable LOS');

-- Fetch Ball (37431)
UPDATE creature_template SET AIName='', ScriptName='npc_pet_gen_fetch_ball' WHERE entry=27407;
DELETE FROM spell_script_names WHERE spell_id IN(48649);
INSERT INTO spell_script_names VALUES(48649, "spell_item_fetch_ball");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND sourceEntry=48649;
INSERT INTO conditions VALUES(13, 1, 48649, 0, 0, 31, 0, 3, 7394, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 1, 31, 0, 3, 7547, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 2, 31, 0, 3, 7565, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 3, 31, 0, 3, 7383, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 4, 31, 0, 3, 21056, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 5, 31, 0, 3, 21010, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 6, 31, 0, 3, 7385, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 7, 31, 0, 3, 14421, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 8, 31, 0, 3, 20472, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 9, 31, 0, 3, 7562, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 10, 31, 0, 3, 32591, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 11, 31, 0, 3, 7395, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 12, 31, 0, 3, 7384, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 13, 31, 0, 3, 7567, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 14, 31, 0, 3, 7544, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 15, 31, 0, 3, 7543, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 16, 31, 0, 3, 23258, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 17, 31, 0, 3, 7545, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 18, 31, 0, 3, 28883, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 19, 31, 0, 3, 29147, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 20, 31, 0, 3, 21055, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 21, 31, 0, 3, 7553, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 22, 31, 0, 3, 7387, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 23, 31, 0, 3, 7555, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 24, 31, 0, 3, 7391, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 25, 31, 0, 3, 14878, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 26, 31, 0, 3, 12419, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 27, 31, 0, 3, 18839, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 28, 31, 0, 3, 20408, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 29, 31, 0, 3, 8376, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 30, 31, 0, 3, 2671, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 31, 31, 0, 3, 22445, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 32, 31, 0, 3, 7382, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 33, 31, 0, 3, 16085, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 34, 31, 0, 3, 32595, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 35, 31, 0, 3, 32592, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 36, 31, 0, 3, 21064, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 37, 31, 0, 3, 21009, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 38, 31, 0, 3, 7389, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 39, 31, 0, 3, 7380, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 40, 31, 0, 3, 21063, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 41, 31, 0, 3, 7381, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 42, 31, 0, 3, 23909, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 43, 31, 0, 3, 10598, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 44, 31, 0, 3, 7560, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 45, 31, 0, 3, 16547, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 46, 31, 0, 3, 16701, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 47, 31, 0, 3, 9662, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 48, 31, 0, 3, 23274, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 49, 31, 0, 3, 32589, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 50, 31, 0, 3, 32590, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 51, 31, 0, 3, 21008, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 52, 31, 0, 3, 7549, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 53, 31, 0, 3, 30379, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 54, 31, 0, 3, 16549, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 55, 31, 0, 3, 7386, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 56, 31, 0, 3, 21018, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 57, 31, 0, 3, 7550, 0, 0, 0, 0, "", "Target Non-Combat Pet");
INSERT INTO conditions VALUES(13, 1, 48649, 0, 58, 31, 0, 3, 10259, 0, 0, 0, 0, "", "Target Non-Combat Pet");

-- Old Magic Broom (33183)
-- Flying Broom (33176)
-- Swift Flying Broom (33182)
-- Swift Flying Broom (33184)
UPDATE item_template SET duration=1209600, flagsCustom=flagsCustom|1 WHERE entry IN(33183, 33176, 33182, 33184);

-- Blue Ogre Brew (32783)
-- Red Ogre Brew (32784)
DELETE FROM spell_area WHERE spell IN(41304, 41306);
INSERT INTO spell_area VALUES (41304, 3522, 0, 0, 0, 0, 2, 0, 0, 0);
INSERT INTO spell_area VALUES (41306, 3522, 0, 0, 0, 0, 2, 0, 0, 0);

-- Autumnal Acorn Ale (37497)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=27867;
DELETE FROM smart_scripts WHERE entryorguid=27867 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(27867*100, 27867*100+1, 27867*100+2) AND source_type=9;
INSERT INTO smart_scripts VALUES (27867, 0, 0, 1, 60, 0, 100, 1, 0, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Squirel - On Update - Move Follow');
INSERT INTO smart_scripts VALUES (27867, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 87, 27867*100, 27867*100+1, 27867*100+2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Squirel - On Update - Random Action List');
INSERT INTO smart_scripts VALUES (27867*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 49757, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell Squirel Love Aura');
INSERT INTO smart_scripts VALUES (27867*100+1, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 46, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Move Forward');
INSERT INTO smart_scripts VALUES (27867*100+1, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 4000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Despawn');
INSERT INTO smart_scripts VALUES (27867*100+2, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 11, 49764, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell Squirel Hate');
INSERT INTO smart_scripts VALUES (27867*100+2, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Despawn');

-- Bartlett's Bitter Brew (37498)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(49869, -49869, 24919, -24919, 49870, -49870);
INSERT INTO spell_linked_spell VALUES (-49869, 24919, 0, 'Nauseous - trigger Stun');
INSERT INTO spell_linked_spell VALUES (-24919, 49867, 0, 'Nauseous Stun - trigger vomit');
INSERT INTO spell_linked_spell VALUES (49870, 49869, 1, 'Slimed! - trigger Nauseous');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND sourceEntry=49869;
INSERT INTO conditions VALUES(17, 0, 49869, 0, 0, 1, 0, 50056, 0, 0, 1, 27, 0, "", "Allow cast on targets without 50056 aura");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND sourceEntry=49870;
INSERT INTO conditions VALUES(13, 1, 49870, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, "", "Target all players");
INSERT INTO conditions VALUES(13, 1, 49870, 0, 0, 1, 0, 50056, 0, 0, 1, 0, 0, "", "Target units without 50056 aura");

-- Lord of Frost's Private Label (37499)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(50093, -50093);
INSERT INTO spell_linked_spell VALUES (-50093, 49886, 0, 'Chilled - trigger Breath Freeze!');

-- Wild Winter Pilsner (37488)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(50098, -50098);
INSERT INTO spell_linked_spell VALUES (-50098, 50099, 0, 'The Beast Within - trigger Unleash the Beast!');

-- Izzard's Ever Flavor (37489)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(49864, -49864);
INSERT INTO spell_linked_spell VALUES (-49864, 49860, 0, 'Gassy - trigger BOTM Belch Visual');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND sourceEntry=49862;
INSERT INTO conditions VALUES(13, 1, 49862, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, "", "Target all players");

-- Metok's Bubble Bock (37491)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(49822, -49822);
INSERT INTO spell_linked_spell VALUES (-49822, 49823, 0, 'Bloated - trigger BOTM - Bubble Brew - Summon Bubble');
UPDATE creature_template SET AIName='', ScriptName='npc_brew_bubble' WHERE entry=27882;

-- Blackrock Lager (37493)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(49738, -49738);
INSERT INTO spell_linked_spell VALUES (-49738, 49737, 0, 'BOTM - Fire Brew - Belch Fire Visual');

-- Stranglethorn Brew (37494)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(49962, -49962);
INSERT INTO spell_linked_spell VALUES (49962, 50010, 0, 'BOTM - Jungle Brew - Jungle Madness Vision Effect');
REPLACE INTO creature_template_addon VALUES (27908, 0, 0, 0, 0, 0, '50008');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=27908;
DELETE FROM smart_scripts WHERE entryorguid=27908 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=27908*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (27908, 0, 0, 1, 54, 0, 100, 1, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Angry Jungle Gnome - Just Summoned - Set Orientation');
INSERT INTO smart_scripts VALUES (27908, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 27908*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Angry Jungle Gnome - Just Summoned - Script9');
INSERT INTO smart_scripts VALUES (27908*100, 9, 0, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 46, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Angry Jungle Gnome - Script9 - Move Forward');
INSERT INTO smart_scripts VALUES (27908*100, 9, 1, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 11, 49965, 0, 0, 0, 0, 0, 21, 10, 0, 0, 0, 0, 0, 0, 'Angry Jungle Gnome - Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (27908*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 5, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Angry Jungle Gnome - Script9 - Play Emote');
INSERT INTO smart_scripts VALUES (27908*100, 9, 3, 0, 0, 0, 100, 0, 2500, 2500, 0, 0, 11, 50048, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Angry Jungle Gnome - Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (27908*100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 1200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Angry Jungle Gnome - Script9 - Despawn');

-- Draenic Pale Ale (37495)
DELETE FROM spell_script_names WHERE spell_id IN(50180);
INSERT INTO spell_script_names VALUES(50180, "spell_item_draenic_pale_ale");

-- Target Dummy (4366)
-- Advanced Target Dummy (4392)
-- Masterwork Target Dummy (16023)
REPLACE INTO creature_template_addon VALUES (2673, 0, 0, 0, 0, 0, '4044');
REPLACE INTO creature_template_addon VALUES (2674, 0, 0, 0, 0, 0, '4048');
REPLACE INTO creature_template_addon VALUES (12426, 0, 0, 0, 0, 0, '19809');
UPDATE creature_template SET lootid = entry, mechanic_immune_mask = mechanic_immune_mask|32, flags_extra = flags_extra | 262144, AIName='', ScriptName='npc_target_dummy' WHERE entry IN(2673, 2674, 12426);
UPDATE creature_template SET Health_mod=18.3809 WHERE entry=2673;
UPDATE creature_template SET Health_mod=63.619 WHERE entry=2674;
UPDATE creature_template SET Health_mod=124.4762 WHERE entry=12426;
DELETE FROM creature_loot_template WHERE entry IN(2673, 2674, 12426);
INSERT INTO creature_loot_template VALUES (2673, 4363, 0, 1, 1, 1, 1);
INSERT INTO creature_loot_template VALUES (2673, 2841, 0, 1, 1, 1, 1);
INSERT INTO creature_loot_template VALUES (2673, 2592, 0, 1, 1, 1, 1);
INSERT INTO creature_loot_template VALUES (2673, 4359, 0, 1, 1, 1, 2);
INSERT INTO creature_loot_template VALUES (2673, 7191, 20, 1, 0, 1, 1);
INSERT INTO creature_loot_template VALUES (2674, 4387, 0, 1, 1, 1, 1);
INSERT INTO creature_loot_template VALUES (2674, 4382, 0, 1, 1, 1, 1);
INSERT INTO creature_loot_template VALUES (2674, 4389, 0, 1, 1, 1, 1);
INSERT INTO creature_loot_template VALUES (2674, 4234, 0, 1, 1, 2, 4);
INSERT INTO creature_loot_template VALUES (2674, 7191, 20, 1, 0, 1, 1);
INSERT INTO creature_loot_template VALUES (12426, 10561, 0, 1, 1, 1, 1);
INSERT INTO creature_loot_template VALUES (12426, 16000, 0, 1, 1, 1, 1);
INSERT INTO creature_loot_template VALUES (12426, 15994, 0, 1, 1, 1, 2);
INSERT INTO creature_loot_template VALUES (12426, 8170, 0, 1, 1, 1, 2);
INSERT INTO creature_loot_template VALUES (12426, 14047, 0, 1, 1, 2, 4);
INSERT INTO creature_loot_template VALUES (12426, 7191, 20, 1, 0, 1, 1);

-- Schematic: Red Firework (18647)
-- Schematic: Blue Firework (18649)
UPDATE item_template SET FlagsExtra=0 WHERE entry=18647; -- old 1
UPDATE item_template SET FlagsExtra=0 WHERE entry=18649; -- old 2

-- Shattered Necklace (7666)
UPDATE item_template SET FlagsExtra=0 WHERE entry=7666; -- old 1

-- Plaguehound Cage (33221)
UPDATE item_template SET spellcooldown_1=60000 WHERE spellid_1=42769;

-- Gnomish Universal Remote (7506)
DELETE FROM spell_script_names WHERE spell_id IN(8344);
INSERT INTO spell_script_names VALUES(8344, "spell_item_gnomish_universal_remote");

-- Blacktip Shark (50289)
UPDATE item_template SET Duration=3600, flagsCustom=flagsCustom|1 WHERE entry=50289;

-- Speckled Tastyfish (19807)
UPDATE item_template SET Duration=14400, flagsCustom=flagsCustom|1 WHERE entry=19807;

-- Pattern: Raptor Hide Belt (13288)
UPDATE item_template SET FlagsExtra=0 WHERE entry=13288;

-- Item Enchantment Template (2010), eg. Grunt's Shield (15512)
DELETE FROM item_enchantment_template WHERE entry=2010 AND ench=1647;

-- Wrathful Gladiator's Frost Wyrm (50435)
REPLACE INTO item_template VALUES (50435, 15, 5, -1, 'Wrathful Gladiator''s Frost Wyrm', 59504, 4, 0, 0, 1, 2000000, 0, 0, -1, -1, 70, 70, 762, 300, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 55884, 0, -1, 0, -1, 330, 3000, 71810, 6, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, 'Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is an extremely fast mount.', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 12340);

-- Monster - Staff, Feathered Silver (13339)
REPLACE INTO item_template VALUES (13339, 2, 10, -1, 'Monster - Staff, Feathered Silver', 24016, 0, 0, 0, 1, 0, 0, 17, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1000, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, '', 0, 0, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 1);

-- Monster - Spear, The Thunderspike (30440)
REPLACE INTO item_template VALUES (30440, 2, 6, -1, 'Monster - Spear, The Thunderspike', 42044, 0, 0, 0, 1, 0, 0, 17, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1000, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, '', 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 1);

-- Westguard Command Insignia (43042)
DELETE FROM spell_script_names WHERE spell_id IN(43042);
INSERT INTO spell_script_names VALUES(43042, "spell_item_summon_or_dismiss");

-- Lafoo's Bug Bag (38622)
DELETE FROM spell_script_names WHERE spell_id IN(51190);
INSERT INTO spell_script_names VALUES(51190, "spell_item_summon_or_dismiss");

-- Jaloot's Favorite Crystal (38623)
DELETE FROM spell_script_names WHERE spell_id IN(51191);
INSERT INTO spell_script_names VALUES(51191, "spell_item_summon_or_dismiss");

-- Moodle's Stress Ball (38624)
DELETE FROM spell_script_names WHERE spell_id IN(51192);
INSERT INTO spell_script_names VALUES(51192, "spell_item_summon_or_dismiss");

-- X-52 Rocket Helmet (30847)
DELETE FROM spell_linked_spell WHERE spell_trigger=37896;
INSERT INTO spell_linked_spell VALUES (37896, 37897, 1, 'X-52 Rocket Helmet - Trigger Parachute');

-- Direbrew's Remote (37863)
DELETE FROM spell_scripts WHERE id=49466;
DELETE FROM spell_script_names WHERE spell_id IN(49466);
INSERT INTO spell_script_names VALUES(49466, "spell_item_direbrew_remote");
DELETE FROM spell_target_position WHERE id=47523;
INSERT INTO spell_target_position VALUES (47523, 0, 230, 901.315, -140.979, -49.75, 3.64);
UPDATE gameobject_template SET displayId=7510, AIName='SmartGameObjectAI' WHERE entry=190022;
DELETE FROM smart_scripts WHERE entryorguid=190022 AND source_type=1;
INSERT INTO smart_scripts VALUES (190022, 1, 0, 0, 60, 0, 100, 257, 0, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Personal Mole Machine - On Update - Set Gameobject State');

-- Ruby Sanctum items not disenchantable
UPDATE item_template SET DisenchantID=68 WHERE RequiredDisenchantSkill=375 AND entry > 53000 AND Quality=4 AND ItemLevel>=258 AND RequiredLevel=80;

