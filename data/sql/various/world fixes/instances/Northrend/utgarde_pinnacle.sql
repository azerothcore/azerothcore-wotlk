-- Assign correct script name
UPDATE instance_template SET script="instance_pinnacle" WHERE map=575;

-- -------------------------------------
-- SVALA SORROWGRAVE
-- -------------------------------------
-- Initial Area Trigger
DELETE FROM areatrigger_scripts WHERE entry=5140;
INSERT INTO areatrigger_scripts VALUES (5140, 'SmartTrigger');
DELETE FROM smart_scripts WHERE entryorguid=5140 AND source_type=2;
INSERT INTO smart_scripts VALUES (5140, 2, 0, 0, 46, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 126115, 29281, 0, 0, 0, 0, 0, "AreaTrigger - On Trigger - Set Data");
-- Remove unneded spawns
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(26668, 19871) and map=575);
DELETE FROM creature WHERE id IN(26668, 19871) and map=575;

-- Texts
DELETE FROM creature_text WHERE entry IN(29281, 29280, 26668);
INSERT INTO creature_text VALUES(29281, 0, 0, "My liege! I have done as you asked, and now beseech you for your blessing!", 14, 0, 100, 0, 0, 13856, 0, 'Svala');
INSERT INTO creature_text VALUES(29280, 0, 0, "Your sacrifice is a testament to your obedience. Indeed you are worthy of this charge. Arise, and forever be known as Svala Sorrowgrave!", 14, 0, 100, 0, 0, 14732, 0, 'Image of Arthas');
INSERT INTO creature_text VALUES(29280, 1, 0, "Your first test awaits you. Destroy our uninvited guests.", 14, 0, 100, 0, 0, 14733, 0, 'Image of Arthas');
INSERT INTO creature_text VALUES(26668, 0, 0, "The sensation is... beyond my imagining. I am yours to command, my king.", 14, 0, 100, 0, 0, 13857, 0, 'Svala');
INSERT INTO creature_text VALUES(26668, 1, 0, "I will be happy to slaughter them in your name! Come, enemies of the Scourge! I will show you the might of the Lich King!", 14, 0, 100, 0, 0, 13858, 0, 'Svala');
INSERT INTO creature_text VALUES(26668, 2, 0, 'I will vanquish your soul!', 14, 0, 0, 0, 0, 13842, 0, 'Svala Sorrowgrave SAY_AGGRO');
INSERT INTO creature_text VALUES(26668, 3, 0, 'You were a fool to challenge the power of the Lich King!', 14, 0, 0, 0, 0, 13845, 0, 'Svala Sorrowgrave SAY_SLAY_1');
INSERT INTO creature_text VALUES(26668, 3, 1, 'Your will is done, my king.', 14, 0, 0, 0, 0, 13847, 0, 'Svala Sorrowgrave SAY_SLAY_2');
INSERT INTO creature_text VALUES(26668, 3, 2, 'Another soul for my master.', 14, 0, 0, 0, 0, 13848, 0, 'Svala Sorrowgrave SAY_SLAY_3');
INSERT INTO creature_text VALUES(26668, 4, 0, 'Nooo! I did not come this far... to...', 14, 0, 0, 0, 0, 13855, 0, 'Svala Sorrowgrave SAY_DEATH');
INSERT INTO creature_text VALUES(26668, 5, 0, 'Your death approaches.', 14, 0, 0, 0, 0, 13850, 0, 'Svala Sorrowgrave SAY_SACRIFICE_1');
INSERT INTO creature_text VALUES(26668, 5, 1, 'Go now to my master.', 14, 0, 0, 0, 0, 13851, 0, 'Svala Sorrowgrave SAY_SACRIFICE_2');
INSERT INTO creature_text VALUES(26668, 5, 2, 'Your end is inevitable.', 14, 0, 0, 0, 0, 13852, 0, 'Svala Sorrowgrave SAY_SACRIFICE_3');
INSERT INTO creature_text VALUES(26668, 5, 3, 'Yor-guul mak!', 14, 0, 0, 0, 0, 13853, 0, 'Svala Sorrowgrave SAY_SACRIFICE_4');
INSERT INTO creature_text VALUES(26668, 5, 4, 'Any last words?', 14, 0, 0, 0, 0, 13854, 0, 'Svala Sorrowgrave SAY_SACRIFICE_5');

-- Svala (29281, 30809)
UPDATE creature_template SET unit_flags=0, mechanic_immune_mask=650854271, flags_extra=0+0x200000, InhabitType=3, HoverHeight=3, AIName='', ScriptName='boss_svala' WHERE entry=29281;
UPDATE creature_template SET unit_flags=0, mechanic_immune_mask=650854271, flags_extra=1+0x200000, InhabitType=3, HoverHeight=3, AIName='', ScriptName='' WHERE entry=30809;

-- Svala Sorrowgrave (26668, 30810)
UPDATE creature_template SET unit_flags=0, mechanic_immune_mask=650854271, flags_extra=0+0x200000, InhabitType=3, AIName='', ScriptName='' WHERE entry=26668;
UPDATE creature_template SET unit_flags=0, mechanic_immune_mask=650854271, flags_extra=1+0x200000, InhabitType=3, AIName='', ScriptName='' WHERE entry=30810;
UPDATE creature_model_info SET bounding_radius=1, combat_reach=1.5 WHERE modelid=26096;

-- Image of Arthas (29280, 30778)
REPLACE INTO creature_template_addon VALUES (29280, 0, 0, 0, 1, 0, '54134');
REPLACE INTO creature_template_addon VALUES (30778, 0, 0, 0, 1, 0, '54134');
UPDATE creature_template SET unit_flags=33555200, AIName='NullCreatureAI', ScriptName='' WHERE entry=29280;
UPDATE creature_template SET unit_flags=33555200, AIName='', ScriptName='' WHERE entry=30778;

-- Flame Brazier (27273, 30771)
DELETE FROM smart_scripts WHERE entryorguid=27273 AND source_type=0;
UPDATE creature_template SET unit_flags=33554432, flags_extra=128, InhabitType=7, AIName='NullCreatureAI', ScriptName='' WHERE entry=27273;
UPDATE creature_template SET unit_flags=33554432, flags_extra=128, InhabitType=7, AIName='', ScriptName='' WHERE entry=30771;

-- Ritual Channeler (27281, 30804)
UPDATE creature_template SET AIName='', ScriptName='npc_ritual_channeler' WHERE entry=27281;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=30804;

-- Dragonflayer Spectator (26667, 30767)
REPLACE INTO creature_template_addon VALUES (26667, 0, 0, 1, 0, 0, '');
REPLACE INTO creature_template_addon VALUES (30767, 0, 0, 1, 0, 0, '');
UPDATE creature_template SET unit_flags=768, AIName='SmartAI', ScriptName='' WHERE entry=26667;
UPDATE creature_template SET unit_flags=768, AIName='', ScriptName='' WHERE entry=30767;
DELETE FROM smart_scripts WHERE entryorguid=26667 AND source_type=0;
INSERT INTO smart_scripts VALUES (26667, 0, 0, 0, 38, 0, 100, 0, 1, 2, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 297.69, -275.81, 86.36, 0, "On Data Set - Move To Pos");
INSERT INTO smart_scripts VALUES (26667, 0, 1, 0, 34, 0, 100, 0, 8, 1, 0, 0, 41, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Movement Inform - Despawn Self");

-- SPELL Arthas Transforming Svala (54142)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=54142;
INSERT INTO conditions VALUES(13, 1, 54142, 0, 0, 31, 0, 3, 29281, 0, 0, 0, 0, '', 'Target Svala');

-- SPELL Ritual Strike (48331, 59930)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(48331, 59930);
INSERT INTO conditions VALUES(13, 3, 48331, 0, 0, 31, 0, 3, 27327, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 3, 48331, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 59930, 0, 0, 31, 0, 3, 26555, 0, 0, 0, 0, '', '');

-- SPELL Ritual Strike(48277)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=48277;
INSERT INTO conditions VALUES(13, 4, 48277, 0, 0, 31, 0, 3, 26555, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 4, 48277, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', '');
DELETE FROM spell_script_names WHERE spell_id=48277;
INSERT INTO spell_script_names VALUES(48277, "spell_svala_ritual_strike");

-- SPELL Ball of Flames (48246)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=48246;
INSERT INTO conditions VALUES(13, 1, 48246, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 48246, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', '');
DELETE FROM event_scripts WHERE id=17841;
INSERT INTO event_scripts VALUES(17841, 0, 10, 27273, 3000, 0, 285.6, -357.5, 91.0833, 5.75959);
INSERT INTO event_scripts VALUES(17841, 0, 10, 27273, 3000, 0, 307, -357.5, 91.0833, 6.02139);

-- The Incredible Hulk Achievement
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7322);
DELETE FROM disables WHERE sourceType=4 AND entry IN(7322);
INSERT INTO disables VALUES(4, 7322, 0, '', '', "The Incredible Hulk Achievement, completed by script");

-- TC, remove some unused script
UPDATE creature_template SET ScriptName='' WHERE ScriptName='npc_scourge_hulk' AND entry=26555;
UPDATE creature_template SET ScriptName='' WHERE ScriptName='npc_spectator' AND entry=26667;
DELETE FROM spell_script_names WHERE ScriptName='spell_paralyze_pinnacle' AND spell_id=48278;

-- -------------------------------------
-- PALEHOOF
-- -------------------------------------
-- spawn trigger manually
DELETE FROM creature_addon WHERE guid=126256;
DELETE FROM creature WHERE guid=126256;

DELETE FROM creature_text WHERE entry=26687;
INSERT INTO creature_text VALUES(26687, 0, 0, 'What this place? I will destroy you!', 14, 0, 100, 0, 0, 13464, 0, 'Gortok Palehoof SAY_AGGRO');
INSERT INTO creature_text VALUES(26687, 1, 0, 'You die! That what master wants!', 14, 0, 100, 0, 0, 13465, 0, 'Gortok Palehoof SAY_SLAY_1');
INSERT INTO creature_text VALUES(26687, 1, 1, 'An easy task!', 14, 0, 100, 0, 0, 13466, 0, 'Gortok Palehoof SAY_SLAY_2');

REPLACE INTO creature_template VALUES (26683, 30772, 0, 0, 0, 0, 26327, 0, 0, 0, 'Frenzied Worgen', '', '', 0, 80, 80, 2, 974, 0, 1, 0.992063, 1.15, 1, 422, 586, 0, 642, 7.5, 2400, 0, 1, 33554752, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 1, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 10, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 650854271, 0+0x200000, 'npc_frenzied_worgen', 12340);
REPLACE INTO creature_template VALUES (26684, 30803, 0, 0, 0, 0, 23999, 0, 0, 0, 'Ravenous Furbolg', '', '', 0, 80, 80, 2, 974, 0, 0.666668, 0.992063, 1, 1, 417, 582, 0, 608, 7.5, 2400, 0, 2, 33554752, 2048, 8, 0, 0, 0, 0, 0, 341, 506, 80, 7, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 10, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 650854271, 0+0x200000, 'npc_ravenous_furbolg', 12340);
REPLACE INTO creature_template VALUES (26685, 30790, 0, 0, 0, 0, 24564, 0, 0, 0, 'Massive Jormungar', '', '', 0, 80, 80, 2, 974, 0, 1, 0.992063, 1, 1, 422, 586, 0, 642, 7.5, 2400, 0, 1, 33554752, 2048, 8, 42, 0, 0, 0, 0, 345, 509, 103, 1, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 10, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 650854271, 0+0x200000, 'npc_massive_jormungar', 12340);
REPLACE INTO creature_template VALUES (26686, 30770, 0, 0, 0, 0, 26284, 0, 0, 0, 'Ferocious Rhino', '', '', 0, 80, 80, 2, 974, 0, 1, 0.992063, 1, 1, 422, 586, 0, 642, 7.5, 2400, 0, 1, 33554752, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 1, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 10, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 650854271, 0+0x200000, 'npc_ferocious_rhino', 12340);
REPLACE INTO creature_template VALUES (27228, 30779, 0, 0, 0, 0, 15554, 0, 0, 0, 'Jormungar Worm', '', '', 0, 80, 80, 2, 14, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 0.25, 0.5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (30770, 0, 0, 0, 0, 0, 26284, 0, 0, 0, 'Ferocious Rhino (1)', '', '', 0, 82, 82, 2, 974, 0, 1, 0.992063, 1, 1, 488, 642, 0, 782, 13, 2000, 0, 1, 33554752, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 1, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 10, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 650854271, 0+0x200000, '', 12340);
REPLACE INTO creature_template VALUES (30772, 0, 0, 0, 0, 0, 26327, 0, 0, 0, 'Frenzied Worgen (1)', '', '', 0, 82, 82, 2, 974, 0, 1, 0.992063, 1.15, 1, 488, 642, 0, 782, 13, 2000, 0, 1, 33554752, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 1, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 10, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 650854271, 0+0x200000, '', 12340);
REPLACE INTO creature_template VALUES (30779, 0, 0, 0, 0, 0, 15554, 0, 0, 0, 'Jormungar Worm (1)', '', '', 0, 80, 81, 2, 14, 0, 1, 1.14286, 1, 0, 464, 604, 0, 708, 1, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 0.3125, 0.5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (30790, 0, 0, 0, 0, 0, 24564, 0, 0, 0, 'Massive Jormungar (1)', '', '', 0, 82, 82, 2, 974, 0, 1, 0.992063, 1, 1, 488, 642, 0, 782, 13, 2000, 0, 1, 33554752, 2048, 8, 42, 0, 0, 0, 0, 363, 521, 121, 1, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 10, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 650854271, 0+0x200000, '', 12340);
REPLACE INTO creature_template VALUES (30803, 0, 0, 0, 0, 0, 23999, 0, 0, 0, 'Ravenous Furbolg (1)', '', '', 0, 82, 82, 2, 974, 0, 0.666668, 0.992063, 1, 1, 463, 640, 0, 726, 13, 2000, 0, 2, 33554752, 2048, 8, 0, 0, 0, 0, 0, 360, 520, 91, 7, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 10, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 650854271, 0+0x200000, '', 12340);
REPLACE INTO creature_template VALUES (26687, 30774, 0, 0, 0, 0, 27419, 0, 0, 0, 'Gortok Palehoof', '', '', 0, 80, 80, 2, 974, 0, 1, 0.952381, 1, 1, 422, 586, 0, 642, 7.5, 2400, 0, 1, 33554752, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 7, 40, 26687, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5026, 8376, '', 0, 3, 1, 15, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 650854271, 0+0x200000, 'boss_palehoof', 12340);
REPLACE INTO creature_template VALUES (30774, 0, 0, 0, 0, 0, 27419, 0, 0, 0, 'Gortok Palehoof (1)', '', '', 0, 82, 82, 2, 974, 0, 1, 0.952381, 1, 1, 488, 642, 0, 782, 13, 2000, 0, 1, 33554752, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 7, 40, 30774, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10052, 16752, '', 0, 3, 1, 32, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 650854271, 1+0x200000, '', 12340);

-- awaken subboss
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=47669;
-- INSERT INTO conditions VALUES(13, 1, 47669, 0, 0, 31, 0, 3, 26683, 0, 0, 0, 0, '', '');
-- INSERT INTO conditions VALUES(13, 1, 47669, 0, 1, 31, 0, 3, 26684, 0, 0, 0, 0, '', '');
-- INSERT INTO conditions VALUES(13, 1, 47669, 0, 2, 31, 0, 3, 26685, 0, 0, 0, 0, '', '');
-- INSERT INTO conditions VALUES(13, 1, 47669, 0, 3, 31, 0, 3, 26686, 0, 0, 0, 0, '', '');
-- INSERT INTO conditions VALUES(13, 1, 47669, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', '');
-- INSERT INTO conditions VALUES(13, 1, 47669, 0, 1, 36, 0, 0, 0, 0, 0, 0, 0, '', '');
-- INSERT INTO conditions VALUES(13, 1, 47669, 0, 2, 36, 0, 0, 0, 0, 0, 0, 0, '', '');
-- INSERT INTO conditions VALUES(13, 1, 47669, 0, 3, 36, 0, 0, 0, 0, 0, 0, 0, '', '');

-- TC Script remove, no spawn in creature table
UPDATE creature_template SET ScriptName='' WHERE ScriptName='npc_palehoof_orb' AND entry=26688;


-- -------------------------------------
-- SKADI THE RUTHLESS
-- -------------------------------------
DELETE FROM linked_respawn WHERE guid=126052;
REPLACE INTO creature_template VALUES (26693, 30807, 0, 0, 0, 0, 27418, 0, 0, 0, 'Skadi the Ruthless', '', '', 0, 80, 80, 2, 21, 0, 1, 1.42857, 1, 1, 422, 586, 0, 642, 7.5, 2400, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 8, 26693, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 20, 5, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 650854271, 0+0x200000, 'boss_skadi', 12340);
REPLACE INTO creature_template VALUES (26893, 30775, 0, 0, 0, 0, 27043, 0, 0, 0, 'Grauf', '', '', 0, 80, 80, 2, 21, 0, 1.44444, 2.75, 1, 1, 422, 586, 0, 642, 7.5, 2000, 0, 1, 320, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 40, 0, 0, '', 0, 5, 1, 100, 5, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 650854271, 0+0x200000, 'boss_skadi_grauf', 12340);
REPLACE INTO creature_template VALUES (28351, 0, 0, 0, 0, 0, 18783, 16925, 0, 0, 'Flame Breath Trigger (Skadi)', '', '', 0, 80, 80, 2, 21, 0, 1, 0.992063, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 33554432, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 7, 1, 1.35, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 130, '', 12340);
REPLACE INTO creature_template VALUES (30775, 0, 0, 0, 0, 0, 27043, 0, 0, 0, 'Grauf (1)', '', '', 0, 82, 82, 2, 21, 0, 1.44444, 2.75, 1, 1, 488, 642, 0, 782, 13, 2000, 0, 1, 320, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 5, 1, 125, 5, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 650854271, 0+0x200000, '', 12340);
REPLACE INTO creature_template VALUES (30807, 0, 0, 0, 0, 0, 27418, 0, 0, 0, 'Skadi the Ruthless (1)', '', '', 0, 82, 82, 2, 21, 0, 1, 1.42857, 1, 1, 488, 642, 0, 782, 13, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 6, 8, 30807, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 32, 5, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 650854271, 1+0x200000, '', 12340);

DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(26893, 28351) and map=575);
DELETE FROM creature WHERE id IN(26893, 28351) and map=575;

UPDATE gameobject_template SET ScriptName="go_harpoon_canon" WHERE entry IN(192175, 192176, 192177);

-- conditions
-- chains
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=48641;
INSERT INTO conditions VALUES(13, 1, 48641, 0, 0, 31, 0, 3, 26893, 0, 0, 0, 0, '', '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=48642;
INSERT INTO conditions VALUES(13, 1, 48642, 0, 0, 31, 0, 3, 26893, 0, 0, 0, 0, '', '');
-- flame breath
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=47593;
INSERT INTO conditions VALUES(13, 1, 47593, 0, 0, 31, 0, 3, 28351, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 47593, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', '');
-- lodi dodi achievement
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7181);
DELETE FROM disables WHERE sourceType=4 AND entry IN(7181);
INSERT INTO achievement_criteria_data VALUES(7181, 1, 26693, 0, "");


-- -------------------------------------
-- KING YMIRON
-- -------------------------------------
REPLACE INTO creature_template VALUES (26861, 30788, 0, 0, 0, 0, 28019, 0, 0, 0, 'King Ymiron', '', '', 0, 82, 82, 2, 14, 0, 1, 1.07143, 1, 1, 488, 642, 0, 782, 7.5, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 6, 72, 26861, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 30, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 650854271, 0+0x200000, 'boss_ymiron', 12340);
REPLACE INTO creature_template VALUES (27303, 30780, 0, 0, 0, 0, 11686, 0, 0, 0, 'King Bjorn', '', '', 0, 83, 83, 2, 14, 0, 1, 1.14286, 1, 3, 509, 683, 0, 805, 35, 2000, 0, 1, 33555200, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 10, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 7, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 131, '', 12340);
REPLACE INTO creature_template VALUES (27304, 30781, 0, 0, 0, 0, 28085, 0, 0, 0, 'King Bjorn Visual', '', '', 0, 1, 1, 0, 35, 0, 1, 1.14286, 1, 3, 2, 2, 0, 24, 35, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 10, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 4, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (27307, 30782, 0, 0, 0, 0, 11686, 0, 0, 0, 'King Haldor', '', '', 0, 83, 83, 2, 14, 0, 1, 1.14286, 1, 3, 509, 683, 0, 805, 35, 2000, 0, 1, 33555200, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 10, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 7, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 131, '', 12340);
REPLACE INTO creature_template VALUES (27308, 30784, 0, 0, 0, 0, 11686, 0, 0, 0, 'King Ranulf', '', '', 0, 83, 83, 2, 14, 0, 1, 1.14286, 1, 3, 509, 683, 0, 805, 35, 2000, 0, 1, 33555200, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 10, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 7, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 131, '', 12340);
REPLACE INTO creature_template VALUES (27309, 30786, 0, 0, 0, 0, 11686, 0, 0, 0, 'King Tor', '', '', 0, 83, 83, 2, 14, 0, 1, 1.14286, 1, 3, 509, 683, 0, 805, 35, 2000, 0, 1, 33555200, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 10, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 7, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 131, '', 12340);
REPLACE INTO creature_template VALUES (27310, 30783, 0, 0, 0, 0, 28086, 0, 0, 0, 'King Haldor Visual', '', '', 0, 1, 1, 0, 35, 0, 1, 1.14286, 1, 3, 2, 2, 0, 24, 35, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 10, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 4, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (27311, 30785, 0, 0, 0, 0, 28087, 0, 0, 0, 'King Ranulf Visual', '', '', 0, 1, 1, 0, 35, 0, 1, 1.14286, 1, 3, 2, 2, 0, 24, 35, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 10, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 4, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (27312, 30787, 0, 0, 0, 0, 28088, 0, 0, 0, 'King Tor Visual', '', '', 0, 1, 1, 0, 35, 0, 1, 1.14286, 1, 3, 2, 2, 0, 24, 35, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 10, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 4, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (30780, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'King Bjorn (1)', '', '', 0, 80, 81, 2, 14, 0, 1, 1.14286, 1, 3, 464, 604, 0, 708, 70, 2000, 0, 1, 33555200, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 10, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 7, 1, 1.25, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 1);
REPLACE INTO creature_template VALUES (30781, 0, 0, 0, 0, 0, 28085, 0, 0, 0, 'King Bjorn Visual (1)', '', '', 0, 1, 1, 0, 35, 0, 1, 1.14286, 1, 3, 2, 2, 0, 24, 70, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 10, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 4, 1, 1.25, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (30782, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'King Haldor (1)', '', '', 0, 80, 81, 2, 14, 0, 1, 1.14286, 1, 3, 464, 604, 0, 708, 70, 2000, 0, 1, 33555200, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 10, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 7, 1, 1.25, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 1);
REPLACE INTO creature_template VALUES (30783, 0, 0, 0, 0, 0, 28086, 0, 0, 0, 'King Haldor Visual (1)', '', '', 0, 1, 1, 0, 35, 0, 1, 1.14286, 1, 3, 2, 2, 0, 24, 70, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 10, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 4, 1, 1.25, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (30784, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'King Ranulf (1)', '', '', 0, 80, 81, 2, 14, 0, 1, 1.14286, 1, 3, 464, 604, 0, 708, 70, 2000, 0, 1, 33555200, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 10, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 7, 1, 1.25, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 1);
REPLACE INTO creature_template VALUES (30785, 0, 0, 0, 0, 0, 28087, 0, 0, 0, 'King Ranulf Visual (1)', '', '', 0, 1, 1, 0, 35, 0, 1, 1.14286, 1, 3, 2, 2, 0, 24, 70, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 10, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 4, 1, 1.25, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (30786, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'King Tor (1)', '', '', 0, 80, 81, 2, 14, 0, 1, 1.14286, 1, 3, 464, 604, 0, 708, 70, 2000, 0, 1, 33555200, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 10, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 7, 1, 1.25, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 1);
REPLACE INTO creature_template VALUES (30787, 0, 0, 0, 0, 0, 28088, 0, 0, 0, 'King Tor Visual (1)', '', '', 0, 1, 1, 0, 35, 0, 1, 1.14286, 1, 3, 2, 2, 0, 24, 70, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 10, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 4, 1, 1.25, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (30788, 0, 0, 0, 0, 0, 28019, 0, 0, 0, 'King Ymiron (1)', '', '', 0, 82, 82, 2, 14, 0, 1, 1.07143, 1, 1, 488, 642, 0, 782, 13, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 6, 72, 30788, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 42, 1, 1, 0, 43669, 0, 0, 0, 0, 0, 0, 1, 650854271, 1+0x200000, '', 12340);
REPLACE INTO creature_template VALUES (27339, 30808, 0, 0, 0, 0, 11686, 0, 0, 0, 'Spirit Fount', '', '', 0, 80, 80, 2, 14, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 1024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 70, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (30808, 0, 0, 0, 0, 0, 169, 11686, 0, 0, 'Spirit Fount (1)', '', '', 0, 82, 82, 2, 14, 0, 1, 1.14286, 1, 0, 488, 642, 0, 782, 1, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 10, 1024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1.25, 1, 1, 0, 0, 0, 0, 0, 0, 0, 70, 1, 0, 130, '', 12340);

-- Avenging Spirit
REPLACE INTO creature_template VALUES (27386, 30756, 0, 0, 0, 0, 10771, 0, 0, 0, 'Avenging Spirit', '', '', 0, 80, 80, 2, 14, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 1024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 0.238095, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 650854271, 0+0x200000, '', 12340);
REPLACE INTO creature_template VALUES (30756, 0, 0, 0, 0, 0, 10771, 0, 0, 0, 'Avenging Spirit (1)', '', '', 0, 80, 80, 2, 14, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 1024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 0.952381, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 650854271, 0+0x200000, '', 12340);
REPLACE INTO creature_template_addon VALUES (27386, 0, 0, 0, 4097, 0, '48584');
REPLACE INTO creature_template_addon VALUES (30756, 0, 0, 0, 4097, 0, '48584');

-- -------------------------------------
-- ACHIEVEMENTS
-- -------------------------------------
-- Utgarde Pinnacle (488)
DELETE FROM disables WHERE sourceType=4 AND entry IN(207, 208, 209, 210);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(207, 208, 209, 210);
INSERT INTO achievement_criteria_data VALUES(207, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(208, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(209, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(210, 12, 0, 0, "");

-- Heroic: Utgarde Pinnacle (499)
DELETE FROM disables WHERE sourceType=4 AND entry IN(6863, 6864, 6865, 6866);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(6863, 6864, 6865, 6866);
INSERT INTO achievement_criteria_data VALUES(6863, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(6864, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(6865, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(6866, 12, 1, 0, "");

-- The Incredible Hulk (2043)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7322);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7322);
INSERT INTO achievement_criteria_data VALUES(7322, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7322, 18, 0, 0, "");

-- My Girl Loves to Skadi All the Time (2156)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7595);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7595);
INSERT INTO achievement_criteria_data VALUES(7595, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7595, 18, 0, 0, "");

-- Lodi Dodi We Loves the Skadi (1873)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7181);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7181);
INSERT INTO achievement_criteria_data VALUES(7181, 12, 1, 0, "");

-- King's Bane (2157)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7598);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7598);
INSERT INTO achievement_criteria_data VALUES(7598, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7598, 18, 0, 0, "");

