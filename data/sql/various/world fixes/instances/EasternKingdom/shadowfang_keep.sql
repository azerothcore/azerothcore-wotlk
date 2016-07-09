
UPDATE creature SET spawntimesecs=86400 WHERE map=33 AND spawntimesecs>0;
UPDATE gameobject SET spawntimesecs=86400 WHERE map=33 AND spawntimesecs>0;

-- -------------------------------------------
--               FORMATIONS
-- -------------------------------------------


-- -------------------------------------------
--                TRASH
-- -------------------------------------------

-- Bleak Worg (3861)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3861;
DELETE FROM smart_scripts WHERE entryorguid IN(3861, -16239) AND source_type=0;
INSERT INTO smart_scripts VALUES (3861, 0, 0, 0, 0, 0, 100, 0, 2000, 10000, 15000, 20000, 11, 7127, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bleak Worg - In Combat - Cast Wavering Will');
INSERT INTO smart_scripts VALUES (-16239, 0, 0, 0, 0, 0, 100, 0, 2000, 10000, 15000, 20000, 11, 7127, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bleak Worg - In Combat - Cast Wavering Will');
INSERT INTO smart_scripts VALUES (-16239, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 19, 3927, 100, 0, 0, 0, 0, 0, 'Bleak Worg - On Just Died - Set Counter');

-- Shadowfang Whitescalp (3851)
REPLACE INTO creature_template_addon VALUES (3851, 0, 0, 0, 4097, 0, '7940');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3851;
DELETE FROM smart_scripts WHERE entryorguid=3851 AND source_type=0;
INSERT INTO smart_scripts VALUES (3851, 0, 0, 0, 1, 0, 100, 0, 1000, 1000, 1200000, 1200000, 11, 12544, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowfang Whitescalp - Out of Combat - Cast Frost Armor');

-- Haunted Servitor (3875)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3875;
DELETE FROM smart_scripts WHERE entryorguid=3875 AND source_type=0;
INSERT INTO smart_scripts VALUES (3875, 0, 0, 0, 0, 0, 100, 0, 2000, 10000, 15000, 20000, 11, 7057, 32, 0, 0, 0, 0, 5, 5, 0, 0, 0, 0, 0, 0, 'Haunted Servitor - In Combat - Cast Haunting Spirits');

-- SPELL Haunting Spirits (7057)
DELETE FROM spell_script_names WHERE spell_id IN(7057);
INSERT INTO spell_script_names VALUES(7057, 'spell_shadowfang_keep_haunting_spirits');

-- Slavering Worg (3862)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3862;
DELETE FROM smart_scripts WHERE entryorguid IN(3862, -16240) AND source_type=0;
INSERT INTO smart_scripts VALUES (-16240, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 19, 3927, 100, 0, 0, 0, 0, 0, 'lavering Worg - On Just Died - Set Counter');

-- Shadowfang Moonwalker (3853)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3853;
DELETE FROM smart_scripts WHERE entryorguid=3853 AND source_type=0;
INSERT INTO smart_scripts VALUES (3853, 0, 0, 0, 0, 0, 100, 0, 8000, 15000, 20000, 30000, 11, 7121, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowfang Moonwalker - In Combat - Cast Anti-Magic Shield');

-- Fel Steed (3864)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3864;
DELETE FROM smart_scripts WHERE entryorguid=3864 AND source_type=0;
INSERT INTO smart_scripts VALUES (3864, 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 14000, 21000, 11, 7139, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fel Steed - In Combat - Cast Fel Stomp');

-- Shadowfang Wolfguard (3854)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3854;
DELETE FROM smart_scripts WHERE entryorguid=3854 AND source_type=0;
INSERT INTO smart_scripts VALUES (3854, 0, 0, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 11, 7107, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowfang Wolfguard - Out of Combat - Cast Summon Wolfguard Worg');
INSERT INTO smart_scripts VALUES (3854, 0, 1, 0, 0, 0, 100, 0, 5000, 8000, 10000, 21000, 11, 7106, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowfang Wolfguard - In Combat - Cast Dark Restore');

-- Wolfguard Worg (5058)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=5058;
DELETE FROM smart_scripts WHERE entryorguid IN(5058, -16241) AND source_type=0;
INSERT INTO smart_scripts VALUES (-16241, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 19, 3927, 100, 0, 0, 0, 0, 0, 'Wolfguard Worg - On Just Died - Set Counter');

-- Shadowfang Darksoul (3855)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3855;
DELETE FROM smart_scripts WHERE entryorguid=3855 AND source_type=0;
INSERT INTO smart_scripts VALUES (3855, 0, 0, 0, 0, 0, 100, 0, 4000, 7000, 11000, 20000, 11, 8140, 32, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Shadowfang Darksoul - In Combat - Cast Befuddlement');
INSERT INTO smart_scripts VALUES (3855, 0, 1, 0, 0, 0, 100, 0, 2000, 4000, 9000, 12000, 11, 970, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Shadowfang Darksoul - In Combat - Cast Shadow Word: Pain');

-- Shadowfang Glutton (3857)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3857;
DELETE FROM smart_scripts WHERE entryorguid=3857 AND source_type=0;
INSERT INTO smart_scripts VALUES (3857, 0, 0, 0, 0, 0, 100, 0, 3000, 6000, 5000, 9000, 11, 7122, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadowfang Glutton - In Combat - Cast Blood Tap');

-- Wailing Guardsman (3877)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3877;
DELETE FROM smart_scripts WHERE entryorguid=3877 AND source_type=0;
INSERT INTO smart_scripts VALUES (3877, 0, 0, 0, 0, 0, 100, 0, 3000, 12000, 11000, 25000, 11, 7074, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wailing Guardsman - In Combat - Cast Screams of the Past');

-- Vile Bat (3866)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3866;
DELETE FROM smart_scripts WHERE entryorguid=3866 AND source_type=0;
INSERT INTO smart_scripts VALUES (3866, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 7000, 12000, 11, 7145, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Vile Bat - In Combat - Cast Diving Sweep');
INSERT INTO smart_scripts VALUES (3866, 0, 1, 0, 0, 0, 100, 0, 6000, 9000, 17000, 22000, 11, 6713, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Vile Bat - In Combat - Cast Disarm');

-- Blood Seeker (3868)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3868;
DELETE FROM smart_scripts WHERE entryorguid=3868 AND source_type=0;
INSERT INTO smart_scripts VALUES (3868, 0, 0, 0, 0, 0, 100, 0, 3000, 6000, 7000, 12000, 11, 7140, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Blood Seeker - In Combat - Cast Expose Weakness');

-- Tormented Officer (3873)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3873;
DELETE FROM smart_scripts WHERE entryorguid=3873 AND source_type=0;
INSERT INTO smart_scripts VALUES (3873, 0, 0, 0, 0, 0, 100, 0, 3000, 11000, 19000, 30000, 11, 7054, 0, 0, 0, 0, 0, 5, 5, 0, 0, 0, 0, 0, 0, 'Tormented Officer - In Combat - Cast Forsaken Skills');

-- SPELL Forsaken Skills (7054)
DELETE FROM spell_script_names WHERE spell_id IN(7054);
INSERT INTO spell_script_names VALUES(7054, 'spell_shadowfang_keep_forsaken_skills');

-- Shadowfang Ragetooth (3859)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3859;
DELETE FROM smart_scripts WHERE entryorguid=3859 AND source_type=0;
INSERT INTO smart_scripts VALUES (3859, 0, 0, 0, 2, 0, 100, 0, 0, 40, 60000, 60000, 11, 7072, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowfang Ragetooth - Between Health 0-40% - Cast Wild Rage');

-- Son of Arugal (2529)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=2529;
DELETE FROM smart_scripts WHERE entryorguid=2529 AND source_type=0;
INSERT INTO smart_scripts VALUES (2529, 0, 0, 0, 0, 0, 100, 0, 5000, 12000, 15000, 23000, 11, 7124, 32, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Son of Arugal - In Combat - Cast Aruga''s Gift');

-- Lupine Horror (3863)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3863;
DELETE FROM smart_scripts WHERE entryorguid IN(3863, -16238) AND source_type=0;
INSERT INTO smart_scripts VALUES (3863, 0, 0, 0, 0, 0, 100, 0, 4000, 12000, 60000, 60000, 11, 7132, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lupine Horror - In Combat - Cast Summon Lupine Delusions');
INSERT INTO smart_scripts VALUES (-16238, 0, 0, 0, 0, 0, 100, 0, 4000, 12000, 60000, 60000, 11, 7132, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lupine Horror - In Combat - Cast Summon Lupine Delusions');
INSERT INTO smart_scripts VALUES (-16238, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 19, 3927, 100, 0, 0, 0, 0, 0, 'Lupine Horror - On Just Died - Set Counter');

-- Lupine Delusion (5097)
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=5097);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=5097);
DELETE FROM creature WHERE id=5097;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=5097;
DELETE FROM smart_scripts WHERE entryorguid=5097 AND source_type=0;


-- -------------------------------------------
--                BOSSES
-- -------------------------------------------

-- Rethilgore <The Cell Keeper> (3914)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3914;
DELETE FROM smart_scripts WHERE entryorguid=3914 AND source_type=0;
INSERT INTO smart_scripts VALUES (3914, 0, 0, 0, 0, 0, 100, 0, 4000, 8000, 11000, 16000, 11, 7295, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Rethilgore - In Combat - Cast Soul Drain');
INSERT INTO smart_scripts VALUES (3914, 0, 1, 2, 6, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 3850, 100, 0, 0, 0, 0, 0, 'Rethilgore - On Just Died - Set Data');
INSERT INTO smart_scripts VALUES (3914, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 2, 0, 0, 0, 0, 19, 3849, 100, 0, 0, 0, 0, 0, 'Rethilgore - On Just Died - Set Data');

-- Commander Springvale (4278)
DELETE FROM creature_text WHERE entry=4278;
INSERT INTO creature_text VALUES (4278, 0, 0, 'Intruders in the keep! To arms!', 14, 0, 100, 0, 0, 0, 0, 'Commander Springvale');
INSERT INTO creature_text VALUES (4278, 1, 0, 'Our vigilance is eternal...', 14, 0, 100, 0, 0, 0, 0, 'Commander Springvale');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4278;
DELETE FROM smart_scripts WHERE entryorguid=4278 AND source_type=0;
INSERT INTO smart_scripts VALUES (4278, 0, 0, 0, 0, 0, 100, 0, 4000, 8000, 15000, 21000, 11, 5588, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Commander Springvale - In Combat - Cast Hammer of Justice');
INSERT INTO smart_scripts VALUES (4278, 0, 1, 0, 2, 0, 100, 0, 0, 60, 10000, 10000, 11, 1026, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Commander Springvale - Between Health 0-60% - Cast Holy Light');
INSERT INTO smart_scripts VALUES (4278, 0, 2, 0, 2, 0, 100, 0, 0, 30, 30000, 30000, 11, 33581, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Commander Springvale - Between Health 0-30% - Cast Divine Shield');
INSERT INTO smart_scripts VALUES (4278, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Commander Springvale - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (4278, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Commander Springvale - On Juts Died - Say Line 1');

-- Razorclaw the Butcher (3886)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3886;
DELETE FROM smart_scripts WHERE entryorguid=3886 AND source_type=0;
INSERT INTO smart_scripts VALUES (3886, 0, 0, 0, 0, 0, 100, 0, 4000, 8000, 11000, 16000, 11, 7485, 0, 0, 0, 0, 0, 6, 5, 0, 0, 0, 0, 0, 0, 'Razorclaw the Butcher - In Combat - Cast Butcher Drain');

-- Baron Silverlaine (3887)
DELETE FROM creature_text WHERE entry=3887;
INSERT INTO creature_text VALUES (3887, 0, 0, 'Leave this accursed place at once!', 14, 0, 100, 0, 0, 0, 0, 'Baron Silverlaine');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3887;
DELETE FROM smart_scripts WHERE entryorguid=3887 AND source_type=0;
INSERT INTO smart_scripts VALUES (3887, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Baron Silverlaine - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (3887, 0, 1, 0, 0, 0, 100, 0, 2000, 8000, 11000, 15000, 11, 7068, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Baron Silverlaine - In Combat - Cast Veil of Shadow');

-- Odo the Blindwatcher (4279)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4279;
DELETE FROM smart_scripts WHERE entryorguid=4279 AND source_type=0;
INSERT INTO smart_scripts VALUES (4279, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 40, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Odo the Blindwatcher - On Aggro - Call For Help');
INSERT INTO smart_scripts VALUES (4279, 0, 1, 0, 2, 0, 100, 1, 0, 70, 0, 0, 11, 7481, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Odo the Blindwatcher - Between Health 0-70% - Cast Howling Rage');
INSERT INTO smart_scripts VALUES (4279, 0, 2, 0, 2, 0, 100, 1, 0, 50, 0, 0, 11, 7483, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Odo the Blindwatcher - Between Health 0-50% - Cast Howling Rage');
INSERT INTO smart_scripts VALUES (4279, 0, 3, 0, 2, 0, 100, 1, 0, 30, 0, 0, 11, 7484, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Odo the Blindwatcher - Between Health 0-30% - Cast Howling Rage');

-- Deathsworn Captain (3872)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3872;
DELETE FROM smart_scripts WHERE entryorguid=3872 AND source_type=0;
INSERT INTO smart_scripts VALUES (3872, 0, 0, 0, 37, 0, 85, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deathsworn Captain - On AI Init - Despawn');
INSERT INTO smart_scripts VALUES (3872, 0, 1, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 11, 7165, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deathsworn Captain - Out of Combat - Cast Battle Stance');
INSERT INTO smart_scripts VALUES (3872, 0, 2, 0, 0, 0, 100, 0, 1000, 7000, 7000, 15000, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Deathsworn Captain - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (3872, 0, 3, 0, 0, 0, 100, 0, 5000, 12000, 9000, 15000, 11, 9080, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Deathsworn Captain - In Combat - Cast Hamstring');

-- Fenrus the Devourer (4274)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4274;
DELETE FROM smart_scripts WHERE entryorguid=4274 AND source_type=0;
INSERT INTO smart_scripts VALUES (4274, 0, 0, 0, 0, 0, 100, 0, 1000, 7000, 22000, 45000, 11, 7125, 0, 0, 0, 0, 0, 5, 5, 0, 0, 0, 0, 0, 0, 'Fenrus the Devourer - In Combat - Cast Toxic Saliva');
INSERT INTO smart_scripts VALUES (4274, 0, 1, 2, 6, 0, 100, 0, 0, 0, 0, 0, 34, 1, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fenrus the Devourer - On Just Died - Set Instance Data 1 to 3');
INSERT INTO smart_scripts VALUES (4274, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 4275, 100, 0, 0, 0, 0, 0, 'Fenrus the Devourer - On Just Died - Set Data');
INSERT INTO smart_scripts VALUES (4274, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 63, 1, 0, 1, 0, 0, 0, 19, 3927, 100, 0, 0, 0, 0, 0, 'Fenrus the Devourer - On Just Died - Set Counter');

-- Arugal's Voidwalker (4627)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4627;
DELETE FROM smart_scripts WHERE entryorguid=4627 AND source_type=0;
INSERT INTO smart_scripts VALUES (4627, 0, 0, 0, 14, 0, 100, 0, 100, 10, 5000, 11000, 11, 7154, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Arugal''s Voidwalker - Friendly Missing Health - Cast Dark Offering');
INSERT INTO smart_scripts VALUES (4627, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 14, 33785, 18972, 0, 0, 0, 0, 0, 'Arugal''s Voidwalker - On Just Died - Set GO State');
INSERT INTO smart_scripts VALUES (4627, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Arugal''s Voidwalker - On Reset - Attack Start');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=4627;
INSERT INTO conditions VALUES(22, 2, 4627, 0, 0, 29, 1, 4627, 50, 0, 1, 0, 0, '', 'Requires No Arugals Voidwalkers nearby');

-- Wolf Master Nandos (3927)
DELETE FROM creature_text WHERE entry=3927;
INSERT INTO creature_text VALUES (3927, 0, 0, 'I can''t believe it, you''ve destroyed my pack...Now face my wrath!', 14, 0, 100, 0, 0, 0, 0, 'Wolf Master Nandos');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3927;
DELETE FROM smart_scripts WHERE entryorguid=3927 AND source_type=0;
INSERT INTO smart_scripts VALUES (3927, 0, 0, 0, 0, 0, 100, 0, 5000, 5000, 75000, 75000, 11, 7489, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wolf Master Nandos - In Combat - Cast Call Lupine Horror');
INSERT INTO smart_scripts VALUES (3927, 0, 1, 0, 0, 0, 100, 0, 30000, 30000, 75000, 75000, 11, 7487, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wolf Master Nandos - In Combat - Cast Call Bleak Worg');
INSERT INTO smart_scripts VALUES (3927, 0, 2, 0, 0, 0, 100, 0, 55000, 55000, 75000, 75000, 11, 7489, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wolf Master Nandos - In Combat - Cast Call Lupine Horror');
INSERT INTO smart_scripts VALUES (3927, 0, 3, 4, 6, 0, 100, 0, 0, 0, 0, 0, 34, 2, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wolf Master Nandos - On Just Died - Set Instance Data 2 to 3');
INSERT INTO smart_scripts VALUES (3927, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 14, 33241, 18971, 0, 0, 0, 0, 0, 'Wolf Master Nandos - On Just Died - Set GO State');
INSERT INTO smart_scripts VALUES (3927, 0, 5, 6, 77, 0, 100, 0, 1, 4, 600000, 600000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wolf Master Nandos - On Counter Set - Say Line 0');
INSERT INTO smart_scripts VALUES (3927, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 60, 0, 0, 0, 0, 0, 0, 'Wolf Master Nandos - On Counter Set - Attack Start');

-- Archmage Arugal (4275)
DELETE FROM creature_summon_groups WHERE summonerId=4275 AND summonerType=0;
INSERT INTO creature_summon_groups VALUES (4275, 0, 1, 4627, -148.199, 2165.647, 128.448, 1.026, 4, 60000);
INSERT INTO creature_summon_groups VALUES (4275, 0, 1, 4627, -153.110, 2168.620, 128.448, 1.026, 4, 60000);
INSERT INTO creature_summon_groups VALUES (4275, 0, 1, 4627, -145.905, 2180.520, 128.448, 4.183, 4, 60000);
INSERT INTO creature_summon_groups VALUES (4275, 0, 1, 4627, -140.794, 2178.037, 128.448, 4.090, 4, 60000);
DELETE FROM creature_text WHERE entry=4275;
INSERT INTO creature_text VALUES (4275, 0, 0, 'Who dares interfere with the Sons of Arugal?', 14, 0, 100, 0, 0, 5791, 0, 'Archmage Arugal');
INSERT INTO creature_text VALUES (4275, 1, 0, 'You, too, shall serve!', 14, 0, 100, 0, 0, 5793, 0, 'Archmage Arugal');
INSERT INTO creature_text VALUES (4275, 2, 0, 'Release your rage!', 14, 0, 100, 0, 0, 5797, 0, 'Archmage Arugal');
INSERT INTO creature_text VALUES (4275, 3, 0, 'Another falls!', 14, 0, 100, 0, 0, 5795, 0, 'Archmage Arugal');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4275;
DELETE FROM smart_scripts WHERE entryorguid=4275 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=4275*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (4275, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 80, 4275*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Archmage Arugal - On Data Set - Start Script');
INSERT INTO smart_scripts VALUES (4275, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Archmage Arugal - On Aggro - Say Line 1');
INSERT INTO smart_scripts VALUES (4275, 0, 2, 0, 5, 0, 100, 0, 5000, 5000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Archmage Arugal - Killed Unit - Say Line 3');
INSERT INTO smart_scripts VALUES (4275, 0, 3, 0, 0, 0, 100, 0, 0, 500, 3000, 3500, 11, 7588, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Archmage Arugal - In Combat - Cast Void Bolt');
INSERT INTO smart_scripts VALUES (4275, 0, 4, 0, 0, 0, 100, 0, 7000, 16000, 25000, 27500, 11, 7803, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Archmage Arugal - In Combat - Cast Thundershock');
INSERT INTO smart_scripts VALUES (4275, 0, 5, 6, 0, 0, 100, 0, 7000, 16000, 25000, 27500, 11, 7621, 0, 0, 0, 0, 0, 6, 30, 0, 0, 0, 0, 0, 0, 'Archmage Arugal - In Combat - Cast Arugal''s Curse');
INSERT INTO smart_scripts VALUES (4275, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Archmage Arugal - Killed Unit - Say Line 2');
INSERT INTO smart_scripts VALUES (4275, 0, 7, 0, 0, 0, 100, 0, 3000, 3000, 13000, 13000, 140, 1, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Archmage Arugal - In Combat - Run Random Timed Event');
INSERT INTO smart_scripts VALUES (4275, 0, 8, 0, 59, 0, 100, 0, 1, 0, 0, 0, 11, 7136, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Archmage Arugal - On Timed Event - Cast Shadow Port');
INSERT INTO smart_scripts VALUES (4275, 0, 9, 0, 59, 0, 100, 0, 2, 0, 0, 0, 11, 7586, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Archmage Arugal - On Timed Event - Cast Shadow Port');
INSERT INTO smart_scripts VALUES (4275, 0, 10, 0, 59, 0, 100, 0, 3, 0, 0, 0, 11, 7587, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Archmage Arugal - On Timed Event - Cast Shadow Port');
INSERT INTO smart_scripts VALUES (4275*100, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Archmage Arugal - Script9 - Say Line 0');
INSERT INTO smart_scripts VALUES (4275*100, 9, 1, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 93, 0, 0, 0, 0, 0, 0, 20, 18973, 100, 0, 0, 0, 0, 0, 'Archmage Arugal - Script9 - Send Custom Anim');
INSERT INTO smart_scripts VALUES (4275*100, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 107, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Archmage Arugal - Script9 - Summon Creature Group');

-- SPELL Shadow Port (7136)
-- SPELL Shadow Port (7586)
-- SPELL Shadow Port (7587)
DELETE FROM spell_target_position WHERE id IN(7136, 7586, 7587);
INSERT INTO spell_target_position VALUES (7136, 0, 33, -105.654, 2154.98, 156.43, 1.24782);
INSERT INTO spell_target_position VALUES (7586, 0, 33, -84.99, 2151.01, 155.62, 1.11623);
INSERT INTO spell_target_position VALUES (7587, 0, 33, -103.46, 2122.1, 155.655, 4.4224);


-- -------------------------------------------
--                MISC
-- -------------------------------------------

-- Sorcerer Ashcrombe (3850)
DELETE FROM creature_text WHERE entry=3850;
INSERT INTO creature_text VALUES (3850, 0, 0, 'Follow me and I''ll open the courtyard door for you.', 12, 7, 100, 25, 0, 0, 0, 'prisoner ashcrombe SAY_FREE_AS');
INSERT INTO creature_text VALUES (3850, 1, 0, 'I have just the spell to get this door open. Too bad the cell doors weren''t locked so haphazardly.', 12, 7, 100, 1, 0, 0, 0, 'prisoner ashcrombe SAY_OPEN_DOOR_AS');
INSERT INTO creature_text VALUES (3850, 2, 0, 'There it is! Wide open. Good luck to you conquering what lies beyond. I must report back to the Kirin Tor at once!', 12, 7, 100, 1, 0, 0, 0, 'prisoner ashcrombe SAY_POST_DOOR_AS');
INSERT INTO creature_text VALUES (3850, 3, 0, '%s vanishes.', 16, 0, 100, 0, 0, 0, 0, 'prisoner ashcrombe SAY_POST_DOOR_AS');
INSERT INTO creature_text VALUES (3850, 4, 0, 'For once I agree with you... scum.', 12, 7, 100, 1, 0, 0, 0, 'prisoner ashcrombe SAY_BOSS_DIE_AS');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3850;
DELETE FROM smart_scripts WHERE entryorguid=3850 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=3850*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (3850, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 67, 1, 5000, 5000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Sorcerer Ashcrombe - On Data Set - Create Timed Event');
INSERT INTO smart_scripts VALUES (3850, 0, 1, 0, 59, 0, 100, 0, 1, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sorcerer Ashcrombe - On Timed Event - Say Line 0');
INSERT INTO smart_scripts VALUES (3850, 0, 2, 0, 62, 0, 100, 0, 21213, 0, 0, 0, 53, 0, 3850, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sorcerer Ashcrombe - On Data Set - Start WP');
INSERT INTO smart_scripts VALUES (3850, 0, 3, 4, 40, 0, 100, 0, 1, 0, 0, 0, 54, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sorcerer Ashcrombe - Wp Reached - Pause WP');
INSERT INTO smart_scripts VALUES (3850, 0, 4, 0, 61, 0, 100, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sorcerer Ashcrombe - Wp Reached - Say Line 0');
INSERT INTO smart_scripts VALUES (3850, 0, 5, 6, 40, 0, 100, 0, 12, 0, 0, 0, 54, 30000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sorcerer Ashcrombe - Wp Reached - Pause WP');
INSERT INTO smart_scripts VALUES (3850, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 3850*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sorcerer Ashcrombe - Wp Reached - Start Script');
INSERT INTO smart_scripts VALUES (3850*100, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sorcerer Ashcrombe - Script9 - Say Line 1');
INSERT INTO smart_scripts VALUES (3850*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 6421, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sorcerer Ashcrombe - Script9 - Cast Ashcrombe Unlock');
INSERT INTO smart_scripts VALUES (3850*100, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sorcerer Ashcrombe - Script9 - Say Line 2');
INSERT INTO smart_scripts VALUES (3850*100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 14, 20835, 18895, 0, 0, 0, 0, 0, 'Sorcerer Ashcrombe - Script9 - Set GO State');
INSERT INTO smart_scripts VALUES (3850*100, 9, 4, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 11, 6422, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sorcerer Ashcrombe - Script9 - Cast Ashcrombe Teleport');
INSERT INTO smart_scripts VALUES (3850*100, 9, 5, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sorcerer Ashcrombe - Script9 - Say Line 3');
INSERT INTO smart_scripts VALUES (3850*100, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 34, 0, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sorcerer Ashcrombe - Script9 - Set Instance Data 0 to 3');
INSERT INTO smart_scripts VALUES (3850*100, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sorcerer Ashcrombe - Script9 - Despawn');
DELETE FROM gossip_menu_option WHERE menu_id=21213;
INSERT INTO gossip_menu_option VALUES (21213, 0, 0, 'Please unlock the courtyard door.', 1, 1, 0, 0, 0, 0, '');
DELETE FROM script_waypoint WHERE entry=3850;
DELETE FROM waypoints WHERE entry=3850;
INSERT INTO waypoints VALUES (3850, 1, -241.817, 2122.9, 81.179, 'Sorcerer Ashcrombe'),(3850, 2, -247.139, 2124.89, 81.179, 'Sorcerer Ashcrombe'),(3850, 3, -253.179, 2127.41, 81.179, 'Sorcerer Ashcrombe'),(3850, 4, -253.898, 2130.87, 81.179, 'Sorcerer Ashcrombe'),(3850, 5, -249.889, 2142.31, 86.972, 'Sorcerer Ashcrombe'),(3850, 6, -248.205, 2144.02, 87.013, 'Sorcerer Ashcrombe'),(3850, 7, -240.553, 2140.55, 87.012, 'Sorcerer Ashcrombe'),(3850, 8, -237.514, 2142.07, 87.012, 'Sorcerer Ashcrombe'),
(3850, 9, -235.638, 2149.23, 90.587, 'Sorcerer Ashcrombe'),(3850, 10, -237.188, 2151.95, 90.624, 'Sorcerer Ashcrombe'),(3850, 11, -241.162, 2153.65, 90.624, 'Sorcerer Ashcrombe'),(3850, 12, -241.13, 2154.56, 90.624, 'Sorcerer Ashcrombe');

-- Deathstalker Adamant (3849)
DELETE FROM creature_text WHERE entry=3849;
INSERT INTO creature_text VALUES (3849, 0, 0, 'Free from this wretched cell at last! Let me show you to the courtyard....', 12, 1, 100, 0, 0, 0, 0, 'prisoner adamant SAY_FREE_AD');
INSERT INTO creature_text VALUES (3849, 1, 0, 'You are indeed courageous for wanting to brave the horrors that lie beyond this door.', 12, 1, 100, 0, 0, 0, 0, 'prisoner adamant SAY_OPEN_DOOR_AD');
INSERT INTO creature_text VALUES (3849, 2, 0, 'There we go!', 12, 1, 100, 0, 0, 0, 0, 'prisoner adamant SAY_POST1_DOOR_AD');
INSERT INTO creature_text VALUES (3849, 3, 0, 'Good luck with Arugal. I must hurry back to Hadrec now.', 12, 1, 100, 0, 0, 0, 0, 'prisoner adamant SAY_POST2_DOOR_AD');
INSERT INTO creature_text VALUES (3849, 4, 0, 'About time someone killed the wretch.', 12, 1, 100, 0, 0, 0, 0, 'prisoner adamant SAY_BOSS_DIE_AD');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3849;
DELETE FROM smart_scripts WHERE entryorguid=3849 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=3849*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (3849, 0, 0, 0, 38, 0, 100, 0, 1, 2, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deathstalker Adamant - On Data Set - Say Line 0');
INSERT INTO smart_scripts VALUES (3849, 0, 1, 0, 62, 0, 100, 0, 21214, 0, 0, 0, 53, 0, 3849, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deathstalker Adamant - On Data Set - Start WP');
INSERT INTO smart_scripts VALUES (3849, 0, 2, 3, 40, 0, 100, 0, 1, 0, 0, 0, 54, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deathstalker Adamant - Wp Reached - Pause WP');
INSERT INTO smart_scripts VALUES (3849, 0, 3, 0, 61, 0, 100, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deathstalker Adamant - Wp Reached - Say Line 0');
INSERT INTO smart_scripts VALUES (3849, 0, 4, 5, 40, 0, 100, 0, 12, 0, 0, 0, 54, 30000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deathstalker Adamant - Wp Reached - Pause WP');
INSERT INTO smart_scripts VALUES (3849, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 3849*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deathstalker Adamant - Wp Reached - Start Script');
INSERT INTO smart_scripts VALUES (3849*100, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deathstalker Adamant - Script9 - Say Line 1');
INSERT INTO smart_scripts VALUES (3849*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 5, 432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deathstalker Adamant - Script9 - Play Emote');
INSERT INTO smart_scripts VALUES (3849*100, 9, 2, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deathstalker Adamant - Script9 - Say Line 2');
INSERT INTO smart_scripts VALUES (3849*100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 14, 20835, 18895, 0, 0, 0, 0, 0, 'Deathstalker Adamant - Script9 - Set GO State');
INSERT INTO smart_scripts VALUES (3849*100, 9, 4, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deathstalker Adamant - Script9 - Say Line 3');
INSERT INTO smart_scripts VALUES (3849*100, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 34, 0, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deathstalker Adamant - Script9 - Set Instance Data 0 to 3');
INSERT INTO smart_scripts VALUES (3849*100, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, -209.00, 2139.89, 90.63, 0, 'Deathstalker Adamant - Script9 - Move To Pos');
INSERT INTO smart_scripts VALUES (3849*100, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deathstalker Adamant - Script9 - Despawn');
DELETE FROM gossip_menu_option WHERE menu_id=21214;
INSERT INTO gossip_menu_option VALUES (21214, 0, 0, 'Please unlock the courtyard door.', 1, 1, 0, 0, 0, 0, '');
DELETE FROM script_waypoint WHERE entry=3849;
DELETE FROM waypoints WHERE entry=3849;
INSERT INTO waypoints VALUES (3849, 1, -250.923, 2116.26, 81.179, 'Deathstalker Adamant'),(3849, 2, -255.049, 2119.39, 81.179, 'Deathstalker Adamant'),(3849, 3, -254.129, 2123.45, 81.179, 'Deathstalker Adamant'),(3849, 4, -253.898, 2130.87, 81.179, 'Deathstalker Adamant'),(3849, 5, -249.889, 2142.31, 86.972, 'Deathstalker Adamant'),(3849, 6, -248.205, 2144.02, 87.013, 'Deathstalker Adamant'),(3849, 7, -240.553, 2140.55, 87.012, 'Deathstalker Adamant'),(3849, 8, -237.514, 2142.07, 87.012, 'Deathstalker Adamant'),(3849, 9, -235.638, 2149.23, 90.587, 'Deathstalker Adamant'),
(3849, 10, -237.188, 2151.95, 90.624, 'Deathstalker Adamant'),(3849, 11, -241.162, 2153.65, 90.624, 'Deathstalker Adamant'),(3849, 12, -241.13, 2154.56, 90.624, 'Deathstalker Adamant');

-- Landen Stilwell (17822)
DELETE FROM gossip_menu WHERE entry=7530 AND text_id=9067;
INSERT INTO gossip_menu VALUES (7530, 9067);
UPDATE creature_template SET gossip_menu_id=7530, AIName='SmartAI', ScriptName='' WHERE entry=17822;
DELETE FROM smart_scripts WHERE entryorguid=17822 AND source_type=0;
INSERT INTO smart_scripts VALUES (17822, 0, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 5, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Landen Stilwell - On Gossip Hello - Play Emote');
INSERT INTO smart_scripts VALUES (17822, 0, 1, 0, 64, 0, 100, 1, 0, 0, 0, 0, 67, 1, 20000, 20000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Landen Stilwell - On Gossip Hello - Start Timed Event');
INSERT INTO smart_scripts VALUES (17822, 0, 2, 3, 59, 0, 100, 0, 1, 0, 0, 0, 11, 31310, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Landen Stilwell - On Timed Event - Cast Spell');
INSERT INTO smart_scripts VALUES (17822, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 2, 24, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Landen Stilwell - On Timed Event - Set Faction');
INSERT INTO smart_scripts VALUES (17822, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Landen Stilwell - On Timed Event - Attack Start');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=17822;
INSERT INTO conditions VALUES(22, 2, 17822, 0, 0, 12, 1, 25, 0, 0, 0, 0, 0, '', 'Requires Active Pyrewood Village Event');

-- Arugal (10000)
DELETE FROM creature_text WHERE entry=10000;
INSERT INTO creature_text VALUES (10000, 0, 0, 'I have changed my mind loyal servants, you do not need to bring the prisoner all the way to my study, I will deal with him here and now. Vincent!', 12, 0, 100, 0, 0, 0, 3, 'Arugal');
INSERT INTO creature_text VALUES (10000, 1, 0, 'You and your pathetic ilk will find no more success in routing my sons and I than those beggardly remnants of the Kirin Tor.', 12, 0, 100, 0, 0, 0, 3, 'Arugal');
INSERT INTO creature_text VALUES (10000, 2, 0, 'If you will not serve my Master with your sword and knowledge of his enemies...', 12, 0, 100, 0, 0, 0, 3, 'Arugal');
INSERT INTO creature_text VALUES (10000, 3, 0, 'Your moldering remains will serve ME as a testament to what happens when one is foolish enough to trespass in my domain!', 12, 0, 100, 0, 0, 0, 3, 'Arugal');
DELETE FROM creature WHERE id=10000;
INSERT INTO creature VALUES (247103, 10000, 33, 1, 1, 0, 1, -218.958, 2152.83, 81.10, 5.09, 86400, 0, 0, 0, 0, 0, 0, 0, 0);
UPDATE creature_template SET unit_flags=768, AIName='SmartAI', ScriptName='' WHERE entry=10000;
DELETE FROM smart_scripts WHERE entryorguid=10000 AND source_type=0;
INSERT INTO smart_scripts VALUES (10000, 0, 0, 0, 60, 0, 100, 1, 1000, 1000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Arugal - On Update - Say Line 0');
INSERT INTO smart_scripts VALUES (10000, 0, 1, 0, 60, 0, 100, 1, 12000, 12000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Arugal - On Update - Say Line 1');
INSERT INTO smart_scripts VALUES (10000, 0, 2, 0, 60, 0, 100, 1, 20000, 20000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Arugal - On Update - Say Line 2');
INSERT INTO smart_scripts VALUES (10000, 0, 3, 0, 60, 0, 100, 1, 28000, 28000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Arugal - On Update - Say Line 3');
INSERT INTO smart_scripts VALUES (10000, 0, 4, 0, 60, 0, 100, 1, 0, 0, 0, 0, 41, 35000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Arugal - On Update - Despawn');

-- Deathstalker Vincent (4444)
DELETE FROM creature_text WHERE entry=4444;
INSERT INTO creature_text VALUES (4444, 0, 0, 'Arrgh!', 12, 0, 100, 0, 0, 0, 0, 'Deathstalker Vincent');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10000;
DELETE FROM smart_scripts WHERE entryorguid=4444 AND source_type=0;
INSERT INTO smart_scripts VALUES (4444, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deathstalker Vincent - On Death - Say Line 0');
INSERT INTO smart_scripts VALUES (4444, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deathstalker Vincent - On Aggro - Remove Bytes1');

-- Pyrewood Village Event
DELETE FROM game_event WHERE eventEntry=25 AND (description='Pyrewood Village' OR description='Nights');
INSERT INTO game_event VALUES (25, '2015-07-29 21:00:00', '2020-12-31 06:00:00', 1440, 480, 0, 'Pyrewood Village', 0);

-- Moonrages
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(1892, 3531, 1893, 3533, 1896, 3529));
DELETE FROM creature WHERE id IN(1892, 3531, 1893, 3533, 1896, 3529);
DELETE FROM game_event_creature WHERE eventEntry=25 OR eventEntry=-25;
DELETE FROM game_event_model_equip WHERE eventEntry=25;
UPDATE creature_template SET faction=24 WHERE entry IN(1892, 3531, 1893, 3533, 1896, 3529);

-- Pyrewood Watcher (1891)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=1891;
DELETE FROM smart_scripts WHERE entryorguid=1891 AND source_type=0;
INSERT INTO smart_scripts VALUES (1891, 0, 0, 2, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 36, 1892, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Pyrewood Watcher - Out of Combat - Update Entry');
INSERT INTO smart_scripts VALUES (1891, 0, 1, 2, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 36, 1891, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Pyrewood Watcher - Out of Combat - Update Entry');
INSERT INTO smart_scripts VALUES (1891, 0, 2, 0, 61, 0, 100, 0, 1000, 1000, 0, 0, 11, 24085, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Pyrewood Watcher - Out of Combat - Cast Transform Visual');
INSERT INTO smart_scripts VALUES (1891, 0, 3, 0, 0, 0, 100, 0, 1000, 1000, 2000, 2000, 11, 6660, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Pyrewood Watcher - In Combat - Cast Shoot');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=1891;
INSERT INTO conditions VALUES(22, 1, 1891, 0, 0, 31, 1, 3, 1891, 0, 0, 0, 0, '', 'Requires Pyrewood Watcher entry');
INSERT INTO conditions VALUES(22, 1, 1891, 0, 0, 12, 1, 25, 0, 0, 0, 0, 0, '', 'Requires Active Pyrewood Village Event');
INSERT INTO conditions VALUES(22, 2, 1891, 0, 0, 31, 1, 3, 1891, 0, 1, 0, 0, '', 'Requires NO Pyrewood Watcher entry');
INSERT INTO conditions VALUES(22, 2, 1891, 0, 0, 12, 1, 25, 0, 0, 1, 0, 0, '', 'Requires NO Active Pyrewood Village Event');

-- Pyrewood Tailor (3530)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3530;
DELETE FROM smart_scripts WHERE entryorguid=3530 AND source_type=0;
INSERT INTO smart_scripts VALUES (3530, 0, 0, 2, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 36, 3531, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Pyrewood Tailor - Out of Combat - Update Entry');
INSERT INTO smart_scripts VALUES (3530, 0, 1, 2, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 36, 3530, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Pyrewood Tailor - Out of Combat - Update Entry');
INSERT INTO smart_scripts VALUES (3530, 0, 2, 0, 61, 0, 100, 0, 1000, 1000, 0, 0, 11, 24085, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Pyrewood Tailor - Out of Combat - Cast Transform Visual');
INSERT INTO smart_scripts VALUES (3530, 0, 3, 0, 67, 0, 100, 0, 7000, 7000, 0, 0, 11, 15657, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Pyrewood Tailor - Behind Target - Cast Backstab');
INSERT INTO smart_scripts VALUES (3530, 0, 4, 0, 0, 0, 100, 0, 5000, 15000, 10000, 17000, 11, 6713, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Pyrewood Tailor - In Combat - Cast Disarm');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=3530;
INSERT INTO conditions VALUES(22, 1, 3530, 0, 0, 31, 1, 3, 3530, 0, 0, 0, 0, '', 'Requires Pyrewood Tailor entry');
INSERT INTO conditions VALUES(22, 1, 3530, 0, 0, 12, 1, 25, 0, 0, 0, 0, 0, '', 'Requires Active Pyrewood Village Event');
INSERT INTO conditions VALUES(22, 2, 3530, 0, 0, 31, 1, 3, 3530, 0, 1, 0, 0, '', 'Requires NO Pyrewood Tailor entry');
INSERT INTO conditions VALUES(22, 2, 3530, 0, 0, 12, 1, 25, 0, 0, 1, 0, 0, '', 'Requires NO Active Pyrewood Village Event');

-- Pyrewood Sentry (1894)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=1894;
DELETE FROM smart_scripts WHERE entryorguid=1894 AND source_type=0;
INSERT INTO smart_scripts VALUES (1894, 0, 0, 2, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 36, 1893, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Pyrewood Sentry - Out of Combat - Update Entry');
INSERT INTO smart_scripts VALUES (1894, 0, 1, 2, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 36, 1894, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Pyrewood Sentry - Out of Combat - Update Entry');
INSERT INTO smart_scripts VALUES (1894, 0, 2, 0, 61, 0, 100, 0, 1000, 1000, 0, 0, 11, 24085, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Pyrewood Sentry - Out of Combat - Cast Transform Visual');
INSERT INTO smart_scripts VALUES (1894, 0, 3, 0, 0, 0, 100, 1, 1000, 1000, 0, 0, 11, 7164, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Pyrewood Sentry - In Combat - Cast Defensive Stance');
INSERT INTO smart_scripts VALUES (1894, 0, 4, 0, 0, 0, 100, 0, 2000, 8000, 10000, 16000, 11, 11972, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Pyrewood Sentry - In Combat - Cast Shield Bash');
INSERT INTO smart_scripts VALUES (1894, 0, 5, 0, 0, 0, 100, 0, 5000, 12000, 15000, 25000, 11, 12169, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Pyrewood Sentry - In Combat - Cast Shield Block');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=1894;
INSERT INTO conditions VALUES(22, 1, 1894, 0, 0, 31, 1, 3, 1894, 0, 0, 0, 0, '', 'Requires Pyrewood Sentry entry');
INSERT INTO conditions VALUES(22, 1, 1894, 0, 0, 12, 1, 25, 0, 0, 0, 0, 0, '', 'Requires Active Pyrewood Village Event');
INSERT INTO conditions VALUES(22, 2, 1894, 0, 0, 31, 1, 3, 1894, 0, 1, 0, 0, '', 'Requires NO Pyrewood Sentry entry');
INSERT INTO conditions VALUES(22, 2, 1894, 0, 0, 12, 1, 25, 0, 0, 1, 0, 0, '', 'Requires NO Active Pyrewood Village Event');

-- Pyrewood Leatherworker (3532)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3532;
DELETE FROM smart_scripts WHERE entryorguid=3532 AND source_type=0;
INSERT INTO smart_scripts VALUES (3532, 0, 0, 2, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 36, 3533, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Pyrewood Leatherworker - Out of Combat - Update Entry');
INSERT INTO smart_scripts VALUES (3532, 0, 1, 2, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 36, 3532, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Pyrewood Leatherworker - Out of Combat - Update Entry');
INSERT INTO smart_scripts VALUES (3532, 0, 2, 0, 61, 0, 100, 0, 1000, 1000, 0, 0, 11, 24085, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Pyrewood Leatherworker - Out of Combat - Cast Transform Visual');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=3532;
INSERT INTO conditions VALUES(22, 1, 3532, 0, 0, 31, 1, 3, 3532, 0, 0, 0, 0, '', 'Requires Pyrewood Leatherworker entry');
INSERT INTO conditions VALUES(22, 1, 3532, 0, 0, 12, 1, 25, 0, 0, 0, 0, 0, '', 'Requires Active Pyrewood Village Event');
INSERT INTO conditions VALUES(22, 2, 3532, 0, 0, 31, 1, 3, 3532, 0, 1, 0, 0, '', 'Requires NO Pyrewood Leatherworker entry');
INSERT INTO conditions VALUES(22, 2, 3532, 0, 0, 12, 1, 25, 0, 0, 1, 0, 0, '', 'Requires NO Active Pyrewood Village Event');

-- Pyrewood Elder (1895)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=1895;
DELETE FROM smart_scripts WHERE entryorguid=1895 AND source_type=0;
INSERT INTO smart_scripts VALUES (1895, 0, 0, 2, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 36, 1896, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Pyrewood Elder - Out of Combat - Update Entry');
INSERT INTO smart_scripts VALUES (1895, 0, 1, 2, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 36, 1895, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Pyrewood Elder - Out of Combat - Update Entry');
INSERT INTO smart_scripts VALUES (1895, 0, 2, 0, 61, 0, 100, 0, 1000, 1000, 0, 0, 11, 24085, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Pyrewood Elder - Out of Combat - Cast Transform Visual');
INSERT INTO smart_scripts VALUES (1895, 0, 3, 0, 14, 0, 100, 0, 100, 30, 4500, 7000, 11, 48894, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Pyrewood Elder - Friendly Missing Health - Cast Lesser Heal');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=1895;
INSERT INTO conditions VALUES(22, 1, 1895, 0, 0, 31, 1, 3, 1895, 0, 0, 0, 0, '', 'Requires Pyrewood Elder entry');
INSERT INTO conditions VALUES(22, 1, 1895, 0, 0, 12, 1, 25, 0, 0, 0, 0, 0, '', 'Requires Active Pyrewood Village Event');
INSERT INTO conditions VALUES(22, 2, 1895, 0, 0, 31, 1, 3, 1895, 0, 1, 0, 0, '', 'Requires NO Pyrewood Elder entry');
INSERT INTO conditions VALUES(22, 2, 1895, 0, 0, 12, 1, 25, 0, 0, 1, 0, 0, '', 'Requires NO Active Pyrewood Village Event');

-- Pyrewood Armorer (3528)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3528;
DELETE FROM smart_scripts WHERE entryorguid=3528 AND source_type=0;
INSERT INTO smart_scripts VALUES (3528, 0, 0, 2, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 36, 3529, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Pyrewood Armorer - Out of Combat - Update Entry');
INSERT INTO smart_scripts VALUES (3528, 0, 1, 2, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 36, 3528, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Pyrewood Armorer - Out of Combat - Update Entry');
INSERT INTO smart_scripts VALUES (3528, 0, 2, 0, 61, 0, 100, 0, 1000, 1000, 0, 0, 11, 24085, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Pyrewood Armorer - Out of Combat - Cast Transform Visual');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=3528;
INSERT INTO conditions VALUES(22, 1, 3528, 0, 0, 31, 1, 3, 3528, 0, 0, 0, 0, '', 'Requires Pyrewood Armorer entry');
INSERT INTO conditions VALUES(22, 1, 3528, 0, 0, 12, 1, 25, 0, 0, 0, 0, 0, '', 'Requires Active Pyrewood Village Event');
INSERT INTO conditions VALUES(22, 2, 3528, 0, 0, 31, 1, 3, 3528, 0, 1, 0, 0, '', 'Requires NO Pyrewood Armorer entry');
INSERT INTO conditions VALUES(22, 2, 3528, 0, 0, 12, 1, 25, 0, 0, 1, 0, 0, '', 'Requires NO Active Pyrewood Village Event');

-- Councilman Brunswick (2067)
UPDATE creature_template SET faction=123, AIName='SmartAI', ScriptName='' WHERE entry=2067;
DELETE FROM smart_scripts WHERE entryorguid=2067 AND source_type=0;
INSERT INTO smart_scripts VALUES (2067, 0, 0, 2, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 36, 1896, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Councilman Brunswick - Out of Combat - Update Entry');
INSERT INTO smart_scripts VALUES (2067, 0, 1, 2, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 36, 2067, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Councilman Brunswick - Out of Combat - Update Entry');
INSERT INTO smart_scripts VALUES (2067, 0, 2, 0, 61, 0, 100, 0, 1000, 1000, 0, 0, 11, 24085, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Councilman Brunswick - Out of Combat - Cast Transform Visual');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=2067;
INSERT INTO conditions VALUES(22, 1, 2067, 0, 0, 31, 1, 3, 2067, 0, 0, 0, 0, '', 'Requires Councilman Brunswick entry');
INSERT INTO conditions VALUES(22, 1, 2067, 0, 0, 12, 1, 25, 0, 0, 0, 0, 0, '', 'Requires Active Pyrewood Village Event');
INSERT INTO conditions VALUES(22, 2, 2067, 0, 0, 31, 1, 3, 2067, 0, 1, 0, 0, '', 'Requires NO Councilman Brunswick entry');
INSERT INTO conditions VALUES(22, 2, 2067, 0, 0, 12, 1, 25, 0, 0, 1, 0, 0, '', 'Requires NO Active Pyrewood Village Event');

-- Councilman Cooper (2065)
UPDATE creature_template SET faction=123, AIName='SmartAI', ScriptName='' WHERE entry=2065;
DELETE FROM smart_scripts WHERE entryorguid=2065 AND source_type=0;
INSERT INTO smart_scripts VALUES (2065, 0, 0, 2, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 36, 1893, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Councilman Cooper - Out of Combat - Update Entry');
INSERT INTO smart_scripts VALUES (2065, 0, 1, 2, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 36, 2065, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Councilman Cooper - Out of Combat - Update Entry');
INSERT INTO smart_scripts VALUES (2065, 0, 2, 0, 61, 0, 100, 0, 1000, 1000, 0, 0, 11, 24085, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Councilman Cooper - Out of Combat - Cast Transform Visual');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=2065;
INSERT INTO conditions VALUES(22, 1, 2065, 0, 0, 31, 1, 3, 2065, 0, 0, 0, 0, '', 'Requires Councilman Cooper entry');
INSERT INTO conditions VALUES(22, 1, 2065, 0, 0, 12, 1, 25, 0, 0, 0, 0, 0, '', 'Requires Active Pyrewood Village Event');
INSERT INTO conditions VALUES(22, 2, 2065, 0, 0, 31, 1, 3, 2065, 0, 1, 0, 0, '', 'Requires NO Councilman Cooper entry');
INSERT INTO conditions VALUES(22, 2, 2065, 0, 0, 12, 1, 25, 0, 0, 1, 0, 0, '', 'Requires NO Active Pyrewood Village Event');

-- Councilman Hartin (2064)
UPDATE creature_template SET faction=123, AIName='SmartAI', ScriptName='' WHERE entry=2064;
DELETE FROM smart_scripts WHERE entryorguid=2064 AND source_type=0;
INSERT INTO smart_scripts VALUES (2064, 0, 0, 2, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 36, 1896, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Councilman Hartin - Out of Combat - Update Entry');
INSERT INTO smart_scripts VALUES (2064, 0, 1, 2, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 36, 2064, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Councilman Hartin - Out of Combat - Update Entry');
INSERT INTO smart_scripts VALUES (2064, 0, 2, 0, 61, 0, 100, 0, 1000, 1000, 0, 0, 11, 24085, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Councilman Hartin - Out of Combat - Cast Transform Visual');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=2064;
INSERT INTO conditions VALUES(22, 1, 2064, 0, 0, 31, 1, 3, 2064, 0, 0, 0, 0, '', 'Requires Councilman Hartin entry');
INSERT INTO conditions VALUES(22, 1, 2064, 0, 0, 12, 1, 25, 0, 0, 0, 0, 0, '', 'Requires Active Pyrewood Village Event');
INSERT INTO conditions VALUES(22, 2, 2064, 0, 0, 31, 1, 3, 2064, 0, 1, 0, 0, '', 'Requires NO Councilman Hartin entry');
INSERT INTO conditions VALUES(22, 2, 2064, 0, 0, 12, 1, 25, 0, 0, 1, 0, 0, '', 'Requires NO Active Pyrewood Village Event');

-- Councilman Hendricks (2062)
UPDATE creature_template SET faction=123, AIName='SmartAI', ScriptName='' WHERE entry=2062;
DELETE FROM smart_scripts WHERE entryorguid=2062 AND source_type=0;
INSERT INTO smart_scripts VALUES (2062, 0, 0, 2, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 36, 1893, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Councilman Hendricks - Out of Combat - Update Entry');
INSERT INTO smart_scripts VALUES (2062, 0, 1, 2, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 36, 2062, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Councilman Hendricks - Out of Combat - Update Entry');
INSERT INTO smart_scripts VALUES (2062, 0, 2, 0, 61, 0, 100, 0, 1000, 1000, 0, 0, 11, 24085, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Councilman Hendricks - Out of Combat - Cast Transform Visual');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=2062;
INSERT INTO conditions VALUES(22, 1, 2062, 0, 0, 31, 1, 3, 2062, 0, 0, 0, 0, '', 'Requires Councilman Hendricks entry');
INSERT INTO conditions VALUES(22, 1, 2062, 0, 0, 12, 1, 25, 0, 0, 0, 0, 0, '', 'Requires Active Pyrewood Village Event');
INSERT INTO conditions VALUES(22, 2, 2062, 0, 0, 31, 1, 3, 2062, 0, 1, 0, 0, '', 'Requires NO Councilman Hendricks entry');
INSERT INTO conditions VALUES(22, 2, 2062, 0, 0, 12, 1, 25, 0, 0, 1, 0, 0, '', 'Requires NO Active Pyrewood Village Event');

-- Councilman Higarth (2066)
UPDATE creature_template SET faction=123, AIName='SmartAI', ScriptName='' WHERE entry=2066;
DELETE FROM smart_scripts WHERE entryorguid=2066 AND source_type=0;
INSERT INTO smart_scripts VALUES (2066, 0, 0, 2, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 36, 1896, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Councilman Higarth - Out of Combat - Update Entry');
INSERT INTO smart_scripts VALUES (2066, 0, 1, 2, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 36, 2066, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Councilman Higarth - Out of Combat - Update Entry');
INSERT INTO smart_scripts VALUES (2066, 0, 2, 0, 61, 0, 100, 0, 1000, 1000, 0, 0, 11, 24085, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Councilman Higarth - Out of Combat - Cast Transform Visual');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=2066;
INSERT INTO conditions VALUES(22, 1, 2066, 0, 0, 31, 1, 3, 2066, 0, 0, 0, 0, '', 'Requires Councilman Higarth entry');
INSERT INTO conditions VALUES(22, 1, 2066, 0, 0, 12, 1, 25, 0, 0, 0, 0, 0, '', 'Requires Active Pyrewood Village Event');
INSERT INTO conditions VALUES(22, 2, 2066, 0, 0, 31, 1, 3, 2066, 0, 1, 0, 0, '', 'Requires NO Councilman Higarth entry');
INSERT INTO conditions VALUES(22, 2, 2066, 0, 0, 12, 1, 25, 0, 0, 1, 0, 0, '', 'Requires NO Active Pyrewood Village Event');

-- Councilman Smithers (2060)
UPDATE creature_template SET faction=123, AIName='SmartAI', ScriptName='' WHERE entry=2060;
DELETE FROM smart_scripts WHERE entryorguid=2060 AND source_type=0;
INSERT INTO smart_scripts VALUES (2060, 0, 0, 2, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 36, 1893, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Councilman Smithers - Out of Combat - Update Entry');
INSERT INTO smart_scripts VALUES (2060, 0, 1, 2, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 36, 2060, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Councilman Smithers - Out of Combat - Update Entry');
INSERT INTO smart_scripts VALUES (2060, 0, 2, 0, 61, 0, 100, 0, 1000, 1000, 0, 0, 11, 24085, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Councilman Smithers - Out of Combat - Cast Transform Visual');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=2060;
INSERT INTO conditions VALUES(22, 1, 2060, 0, 0, 31, 1, 3, 2060, 0, 0, 0, 0, '', 'Requires Councilman Smithers entry');
INSERT INTO conditions VALUES(22, 1, 2060, 0, 0, 12, 1, 25, 0, 0, 0, 0, 0, '', 'Requires Active Pyrewood Village Event');
INSERT INTO conditions VALUES(22, 2, 2060, 0, 0, 31, 1, 3, 2060, 0, 1, 0, 0, '', 'Requires NO Councilman Smithers entry');
INSERT INTO conditions VALUES(22, 2, 2060, 0, 0, 12, 1, 25, 0, 0, 1, 0, 0, '', 'Requires NO Active Pyrewood Village Event');

-- Councilman Thatcher (2061)
UPDATE creature_template SET faction=123, AIName='SmartAI', ScriptName='' WHERE entry=2061;
DELETE FROM smart_scripts WHERE entryorguid=2061 AND source_type=0;
INSERT INTO smart_scripts VALUES (2061, 0, 0, 2, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 36, 1896, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Councilman Thatcher - Out of Combat - Update Entry');
INSERT INTO smart_scripts VALUES (2061, 0, 1, 2, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 36, 2061, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Councilman Thatcher - Out of Combat - Update Entry');
INSERT INTO smart_scripts VALUES (2061, 0, 2, 0, 61, 0, 100, 0, 1000, 1000, 0, 0, 11, 24085, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Councilman Thatcher - Out of Combat - Cast Transform Visual');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=2061;
INSERT INTO conditions VALUES(22, 1, 2061, 0, 0, 31, 1, 3, 2061, 0, 0, 0, 0, '', 'Requires Councilman Thatcher entry');
INSERT INTO conditions VALUES(22, 1, 2061, 0, 0, 12, 1, 25, 0, 0, 0, 0, 0, '', 'Requires Active Pyrewood Village Event');
INSERT INTO conditions VALUES(22, 2, 2061, 0, 0, 31, 1, 3, 2061, 0, 1, 0, 0, '', 'Requires NO Councilman Thatcher entry');
INSERT INTO conditions VALUES(22, 2, 2061, 0, 0, 12, 1, 25, 0, 0, 1, 0, 0, '', 'Requires NO Active Pyrewood Village Event');

-- Councilman Wilhelm (2063)
UPDATE creature_template SET faction=123, AIName='SmartAI', ScriptName='' WHERE entry=2063;
DELETE FROM smart_scripts WHERE entryorguid=2063 AND source_type=0;
INSERT INTO smart_scripts VALUES (2063, 0, 0, 2, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 36, 1893, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Councilman Wilhelm - Out of Combat - Update Entry');
INSERT INTO smart_scripts VALUES (2063, 0, 1, 2, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 36, 2063, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Councilman Wilhelm - Out of Combat - Update Entry');
INSERT INTO smart_scripts VALUES (2063, 0, 2, 0, 61, 0, 100, 0, 1000, 1000, 0, 0, 11, 24085, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Councilman Wilhelm - Out of Combat - Cast Transform Visual');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=2063;
INSERT INTO conditions VALUES(22, 1, 2063, 0, 0, 31, 1, 3, 2063, 0, 0, 0, 0, '', 'Requires Councilman Wilhelm entry');
INSERT INTO conditions VALUES(22, 1, 2063, 0, 0, 12, 1, 25, 0, 0, 0, 0, 0, '', 'Requires Active Pyrewood Village Event');
INSERT INTO conditions VALUES(22, 2, 2063, 0, 0, 31, 1, 3, 2063, 0, 1, 0, 0, '', 'Requires NO Councilman Wilhelm entry');
INSERT INTO conditions VALUES(22, 2, 2063, 0, 0, 12, 1, 25, 0, 0, 1, 0, 0, '', 'Requires NO Active Pyrewood Village Event');

-- Lord Mayor Morrison (2068)
UPDATE creature_template SET faction=123, AIName='SmartAI', ScriptName='' WHERE entry=2068;
DELETE FROM smart_scripts WHERE entryorguid=2068 AND source_type=0;
INSERT INTO smart_scripts VALUES (2068, 0, 0, 2, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 36, 1896, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lord Mayor Morrison - Out of Combat - Update Entry');
INSERT INTO smart_scripts VALUES (2068, 0, 1, 2, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 36, 2068, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lord Mayor Morrison - Out of Combat - Update Entry');
INSERT INTO smart_scripts VALUES (2068, 0, 2, 0, 61, 0, 100, 0, 1000, 1000, 0, 0, 11, 24085, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lord Mayor Morrison - Out of Combat - Cast Transform Visual');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=2068;
INSERT INTO conditions VALUES(22, 1, 2068, 0, 0, 31, 1, 3, 2068, 0, 0, 0, 0, '', 'Requires Lord Mayor Morrison entry');
INSERT INTO conditions VALUES(22, 1, 2068, 0, 0, 12, 1, 25, 0, 0, 0, 0, 0, '', 'Requires Active Pyrewood Village Event');
INSERT INTO conditions VALUES(22, 2, 2068, 0, 0, 31, 1, 3, 2068, 0, 1, 0, 0, '', 'Requires NO Lord Mayor Morrison entry');
INSERT INTO conditions VALUES(22, 2, 2068, 0, 0, 12, 1, 25, 0, 0, 1, 0, 0, '', 'Requires NO Active Pyrewood Village Event');
