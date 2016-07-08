
UPDATE creature SET spawntimesecs=14*86400 WHERE map=724 AND spawntimesecs>0;
DELETE FROM disables WHERE sourceType=2 AND entry IN(724);


-- -------------------------------------------
--                TRASH
-- -------------------------------------------

-- Charscale Assaulter (40419, 40420)
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, baseattacktime=2000, dmg_multiplier=35, unit_flags=32832, lootid=40419, skinloot=70210, mechanic_immune_mask=549530129, AIName='SmartAI', ScriptName='' WHERE entry=40419;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, baseattacktime=2000, dmg_multiplier=60, unit_flags=32832, lootid=40419, skinloot=70210, mechanic_immune_mask=549530129, AIName='', ScriptName='' WHERE entry=40420;
DELETE FROM smart_scripts WHERE entryorguid=40419 AND source_type=0;
INSERT INTO smart_scripts VALUES (40419, 0, 0, 0, 0, 0, 100, 0, 2000, 6000, 8000, 12000, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Charscale Assaulter - In Combat - Cast Clave');
INSERT INTO smart_scripts VALUES (40419, 0, 1, 0, 0, 0, 100, 10, 9000, 12000, 13000, 16000, 11, 75417, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Charscale Assaulter - In Combat - Cast Shockwave');
INSERT INTO smart_scripts VALUES (40419, 0, 2, 0, 0, 0, 100, 20, 9000, 12000, 13000, 16000, 11, 75418, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Charscale Assaulter - In Combat - Cast Shockwave');

-- Charscale Invoker (40417, 40418)
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, baseattacktime=2000, dmg_multiplier=30, unit_flags=32832, lootid=40419, skinloot=70210, mechanic_immune_mask=549530129, AIName='SmartAI', ScriptName='' WHERE entry=40417;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, baseattacktime=2000, dmg_multiplier=50, unit_flags=32832, lootid=40419, skinloot=70210, mechanic_immune_mask=549530129, AIName='', ScriptName='' WHERE entry=40418;
DELETE FROM smart_scripts WHERE entryorguid=40417 AND source_type=0;
INSERT INTO smart_scripts VALUES (40417, 0, 0, 0, 0, 0, 100, 10, 2000, 6000, 8000, 12000, 11, 75412, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Charscale Invoker - In Combat - Cast Scorch');
INSERT INTO smart_scripts VALUES (40417, 0, 1, 0, 0, 0, 100, 20, 2000, 6000, 8000, 12000, 11, 75419, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Charscale Invoker - In Combat - Cast Scorch');
INSERT INTO smart_scripts VALUES (40417, 0, 2, 0, 9, 0, 100, 0, 0, 10, 9000, 14000, 11, 75413, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Charscale Invoker - Within Range 0-10yd - Cast Flame Wave');

-- Charscale Commander (40423, 40424)
DELETE FROM creature_text WHERE entry=40423;
INSERT INTO creature_text VALUES (40423, 0, 0, '%s rallies the other combatants with a battle roar!', 41, 0, 100, 0, 0, 0, 0, 'Charscale Commander');
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, baseattacktime=2000, dmg_multiplier=45, unit_flags=32832, lootid=40419, skinloot=70210, mechanic_immune_mask=549530129, AIName='SmartAI', ScriptName='' WHERE entry=40423;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, baseattacktime=2000, dmg_multiplier=80, unit_flags=32832, lootid=40419, skinloot=70210, mechanic_immune_mask=549530129, AIName='', ScriptName='' WHERE entry=40424;
DELETE FROM smart_scripts WHERE entryorguid=40423 AND source_type=0;
INSERT INTO smart_scripts VALUES (40423, 0, 0, 1, 0, 0, 100, 0, 5000, 8000, 50000, 50000, 11, 75414, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Charscale Commander - In Combat - Cast Rallying Shout');
INSERT INTO smart_scripts VALUES (40423, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Charscale Commander - In Combat - Talk');
INSERT INTO smart_scripts VALUES (40423, 0, 2, 0, 0, 0, 100, 0, 2000, 6000, 8000, 12000, 11, 13737, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Charscale Commander - In Combat - Cast Mortal Strike');

-- SPELL Rallying Shout (75415)
DELETE FROM disables WHERE entry IN(75414) AND sourceType=0 AND flags=64;
INSERT INTO disables VALUES(0, 75414, 64, '', '', 'Disable LOS for Rallying Shout');
DELETE FROM spell_script_names WHERE spell_id=75415;
INSERT INTO spell_script_names VALUES(75415, 'spell_ruby_sanctum_rallying_shout');

-- Charscale Elite (40421, 40422)
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, baseattacktime=1250, dmg_multiplier=30, unit_flags=32832, lootid=40419, skinloot=70210, mechanic_immune_mask=549530129, AIName='SmartAI', ScriptName='' WHERE entry=40421;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, baseattacktime=1250, dmg_multiplier=50, unit_flags=32832, lootid=40419, skinloot=70210, mechanic_immune_mask=549530129, AIName='', ScriptName='' WHERE entry=40422;
DELETE FROM smart_scripts WHERE entryorguid=40421 AND source_type=0;
INSERT INTO smart_scripts VALUES (40421, 0, 1, 0, 0, 0, 100, 0, 2000, 6000, 8000, 12000, 11, 15621, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Charscale Commander - In Combat - Cast Skull Crack');


-- -------------------------------------------
--                BOSSES
-- -------------------------------------------

-- Baltharus the Warborn (39751, 39920)
DELETE FROM creature_text WHERE entry=39751;
INSERT INTO creature_text VALUES (39751, 0, 0, 'Your power wanes, ancient one.... Soon you will join your friends.', 14, 0, 100, 0, 0, 17525, 0, 'Baltharus the Warborn');
INSERT INTO creature_text VALUES (39751, 1, 0, 'Ah, the entertainment has arrived.', 14, 0, 100, 0, 0, 17520, 0, 'Baltharus the Warborn');
INSERT INTO creature_text VALUES (39751, 2, 0, 'Baltharus leaves no survivors!', 14, 0, 100, 0, 0, 17521, 0, 'Baltharus the Warborn');
INSERT INTO creature_text VALUES (39751, 2, 1, 'This world has enough heroes.', 14, 0, 100, 0, 0, 17522, 0, 'Baltharus the Warborn');
INSERT INTO creature_text VALUES (39751, 3, 0, 'Twice the pain and half the fun.', 14, 0, 100, 0, 0, 17524, 0, 'Baltharus the Warborn');
INSERT INTO creature_text VALUES (39751, 4, 1, 'I... didn''t see that coming....', 14, 0, 100, 0, 0, 17523, 0, 'Baltharus the Warborn');
UPDATE creature_template SET rank=3, speed_walk=2.8, speed_run=1.71429, scale=1.5, mindmg=9000, maxdmg=10000, attackpower=400, dmg_multiplier=6, lootid=39947, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='boss_baltharus_the_warborn' WHERE entry=39751;
UPDATE creature_template SET rank=3, speed_walk=2.8, speed_run=1.71429, scale=1.5, mindmg=9000, maxdmg=10000, attackpower=400, dmg_multiplier=11, lootid=39947, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='' WHERE entry=39920;

-- Baltharus the Warborn (39899, 39922)
DELETE FROM creature_text WHERE entry=39899;
UPDATE creature_template SET rank=3, speed_walk=2.8, speed_run=1.71429, scale=1.5, mindmg=9000, maxdmg=10000, attackpower=400, dmg_multiplier=6, lootid=0, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='npc_baltharus_the_warborn_clone' WHERE entry=39899;
UPDATE creature_template SET rank=3, speed_walk=2.8, speed_run=1.71429, scale=1.5, mindmg=9000, maxdmg=10000, attackpower=400, dmg_multiplier=11, lootid=0, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='' WHERE entry=39922;

-- Sanctum Guardian Xerestrasza (40429)
DELETE FROM creature_text WHERE entry=40429;
INSERT INTO creature_text VALUES (40429, 0, 0, 'Thank you! I could not have held out for much longer.... A terrible thing has happened here.', 14, 0, 100, 5, 0, 17491, 0, 'Sanctum Guardian Xerestrasza');
INSERT INTO creature_text VALUES (40429, 1, 0, 'We believed the Sanctum was well-fortified, but we were not prepared for the nature of this assault.', 12, 0, 100, 1, 0, 17492, 0, 'Sanctum Guardian Xerestrasza');
INSERT INTO creature_text VALUES (40429, 2, 0, 'The Black dragonkin materialized from thin air, and set upon us before we could react.', 12, 0, 100, 1, 0, 17493, 0, 'Sanctum Guardian Xerestrasza');
INSERT INTO creature_text VALUES (40429, 3, 0, 'We did not stand a chance. As my brethren perished around me, I managed to retreat here and bar the entrance.', 12, 0, 100, 1, 0, 17494, 0, 'Sanctum Guardian Xerestrasza');
INSERT INTO creature_text VALUES (40429, 4, 0, 'They slaughtered us with cold efficiency, but the true focus of their interest seemed to be the eggs kept here in the Sanctum.', 12, 0, 100, 1, 0, 17495, 0, 'Sanctum Guardian Xerestrasza');
INSERT INTO creature_text VALUES (40429, 5, 0, 'The commander of the forces on the ground here is a cruel brute named Zarithrian, but I fear there are greater powers at work.', 12, 0, 100, 1, 0, 17496, 0, 'Sanctum Guardian Xerestrasza');
INSERT INTO creature_text VALUES (40429, 6, 0, 'In their initial assault, I caught a glimpse of their true leader, a fearsome full-grown twilight dragon.', 12, 0, 100, 1, 0, 17497, 0, 'Sanctum Guardian Xerestrasza');
INSERT INTO creature_text VALUES (40429, 7, 0, 'I know not the extent of their plans, heroes, but I know this:  They cannot be allowed to succeed!', 12, 0, 100, 5, 0, 17498, 0, 'Sanctum Guardian Xerestrasza');
INSERT INTO creature_text VALUES (40429, 8, 0, 'Help! I am trapped within this tree!  I require aid!', 14, 0, 100, 5, 0, 17490, 0, 'Sanctum Guardian Xerestrasza');
UPDATE creature_template SET AIName='', ScriptName='npc_xerestrasza' WHERE entry=40429;

-- AreaTrigger (5867)
DELETE FROM areatrigger_scripts WHERE entry=5867;
INSERT INTO areatrigger_scripts VALUES (5867, 'at_baltharus_plateau');

-- SPELL Barrier Channel (76221)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=76221;
INSERT INTO conditions VALUES(13, 1, 76221, 0, 0, 31, 0, 3, 26712, 0, 0, 0, 0, '', 'Target Crystal Channel Target');

-- SPELL Enervating Brand (74505)
DELETE FROM spell_script_names WHERE spell_id=74505;
INSERT INTO spell_script_names VALUES(74505, 'spell_baltharus_enervating_brand_trigger');

-- Saviana Ragefire (39747, 39823)
DELETE FROM creature_text WHERE entry=39747;
INSERT INTO creature_text VALUES (39747, 0, 0, 'You will sssuffer for this intrusion!', 14, 0, 100, 0, 0, 17528, 0, 'Saviana Ragefire');
INSERT INTO creature_text VALUES (39747, 1, 0, 'Burn in the master''s flame!', 14, 0, 100, 0, 0, 17532, 0, 'Saviana Ragefire');
INSERT INTO creature_text VALUES (39747, 2, 0, '%s becomes enraged!', 16, 0, 100, 0, 0, 0, 0, 'Saviana Ragefire');
INSERT INTO creature_text VALUES (39747, 3, 0, 'Halion will be pleased.', 14, 0, 100, 0, 0, 17530, 0, 'Saviana Ragefire');
INSERT INTO creature_text VALUES (39747, 3, 1, 'As it should be....', 14, 0, 100, 0, 0, 17529, 0, 'Saviana Ragefire');
UPDATE creature_template SET rank=3, speed_walk=2, speed_run=2.14286, scale=1.2, mindmg=9000, maxdmg=10000, attackpower=400, dmg_multiplier=6, lootid=39948, mechanic_immune_mask=650854271, InhabitType=5, flags_extra=1|0x200000, AIName='', ScriptName='boss_saviana_ragefire' WHERE entry=39747;
UPDATE creature_template SET rank=3, speed_walk=2, speed_run=2.14286, scale=1.2, mindmg=9000, maxdmg=10000, attackpower=400, dmg_multiplier=11, lootid=39948, mechanic_immune_mask=650854271, InhabitType=5, flags_extra=1|0x200000, AIName='', ScriptName='' WHERE entry=39823;

-- SPELL Conflagration (74452)
DELETE FROM spell_script_names WHERE spell_id=74452;
INSERT INTO spell_script_names VALUES(74452, 'spell_saviana_conflagration_init');

-- SPELL Conflagration (74455)
DELETE FROM spell_script_names WHERE spell_id=74455;
INSERT INTO spell_script_names VALUES(74455, 'spell_saviana_conflagration_throwback');

-- General Zarithrian (39746, 39805)
DELETE FROM creature_text WHERE entry=39746;
INSERT INTO creature_text VALUES (39746, 0, 0, 'Alexstrasza has chosen capable allies.... A pity that I must END YOU!', 14, 0, 100, 0, 0, 17512, 0, 'General Zarithrian');
INSERT INTO creature_text VALUES (39746, 1, 0, 'You thought you stood a chance?', 14, 0, 50, 0, 0, 17513, 0, 'General Zarithrian');
INSERT INTO creature_text VALUES (39746, 1, 1, 'It''s for the best.', 14, 0, 50, 0, 0, 17514, 0, 'General Zarithrian');
INSERT INTO creature_text VALUES (39746, 2, 0, 'Turn them to ash, minions!', 14, 0, 100, 0, 0, 17516, 0, 'General Zarithrian');
INSERT INTO creature_text VALUES (39746, 3, 0, 'HALION! I...', 14, 0, 100, 0, 0, 17515, 0, 'General Zarithrian');
UPDATE creature_template SET rank=3, speed_walk=1, speed_run=1.42857, scale=1, mindmg=9000, maxdmg=10000, attackpower=400, dmg_multiplier=6, baseattacktime=1500, unit_flags=33554752, lootid=39946, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='boss_general_zarithrian' WHERE entry=39746;
UPDATE creature_template SET rank=3, speed_walk=1, speed_run=1.42857, scale=1, mindmg=9000, maxdmg=10000, attackpower=400, dmg_multiplier=11, baseattacktime=1500, unit_flags=33554752, lootid=39946, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='' WHERE entry=39805;

-- Onyx Flamecaller (39814, 39815)
DELETE FROM creature_text WHERE entry=39814;
UPDATE creature_template SET speed_walk=1, speed_run=1.42857, mindmg=497, maxdmg=676, attackpower=795, dmg_multiplier=25, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='npc_onyx_flamecaller' WHERE entry=39814;
UPDATE creature_template SET speed_walk=1, speed_run=1.42857, mindmg=497, maxdmg=676, attackpower=795, dmg_multiplier=40, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='' WHERE entry=39815;

-- Zarithrian Spawn Stalker (39794)
UPDATE creature_template SET flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=39794;

-- Halion <The Twilight Destroyer> (39863, 39864, 39944, 39945)
DELETE FROM creature_text WHERE entry=39863;
INSERT INTO creature_text VALUES (39863, 0, 0, 'Without pressure in both realms, %s begins to regenerate.', 41, 0, 100, 0, 0, 0, 0, 'Halion');
INSERT INTO creature_text VALUES (39863, 1, 0, 'Meddlesome insects! You are too late. The Ruby Sanctum is lost!', 14, 0, 100, 1, 0, 17499, 0, 'Halion');
INSERT INTO creature_text VALUES (39863, 2, 0, 'Your world teeters on the brink of annihilation. You will ALL bear witness to the coming of a new age of DESTRUCTION!', 14, 0, 100, 0, 0, 17500, 0, 'Halion');
INSERT INTO creature_text VALUES (39863, 3, 0, 'The heavens burn!', 14, 0, 100, 0, 0, 17505, 0, 'Halion');
INSERT INTO creature_text VALUES (39863, 4, 0, 'You will find only suffering within the realm of twilight! Enter if you dare!', 14, 0, 100, 0, 0, 17507, 0, 'Halion');
INSERT INTO creature_text VALUES (39863, 5, 0, 'Relish this victory, mortals, for it will be your last! This world will burn with the master''s return!', 14, 0, 100, 0, 0, 17503, 0, 'Halion');
INSERT INTO creature_text VALUES (39863, 6, 0, 'Another "hero" falls.', 14, 0, 100, 0, 0, 17501, 0, 'Halion');
INSERT INTO creature_text VALUES (39863, 7, 0, 'Not good enough.', 14, 0, 100, 0, 0, 17504, 0, 'Halion');
INSERT INTO creature_text VALUES (39863, 8, 0, 'Your efforts force %s further out of the physical realm!', 41, 0, 100, 0, 0, 0, 0, 'Halion');
INSERT INTO creature_text VALUES (39863, 9, 0, 'Your companions'' efforts force %s further into the physical realm!', 41, 0, 100, 0, 0, 0, 0, 'Halion');
UPDATE creature_template SET rank=3, speed_walk=1.6, speed_run=1.42857, scale=1, mindmg=9000, maxdmg=10000, attackpower=400, dmg_multiplier=8, baseattacktime=1500, unit_flags=32832, dynamicflags=0, lootid=39863, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='boss_halion' WHERE entry=39863;
UPDATE creature_template SET rank=3, speed_walk=1.6, speed_run=1.42857, scale=1, mindmg=9000, maxdmg=10000, attackpower=400, dmg_multiplier=13.5, baseattacktime=1500, unit_flags=32832, dynamicflags=0, lootid=39864, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='' WHERE entry=39864;
UPDATE creature_template SET rank=3, speed_walk=1.6, speed_run=1.42857, scale=1, mindmg=9000, maxdmg=10000, attackpower=400, dmg_multiplier=10.5, baseattacktime=1500, unit_flags=32832, dynamicflags=0, lootid=39944, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='' WHERE entry=39944;
UPDATE creature_template SET rank=3, speed_walk=1.6, speed_run=1.42857, scale=1, mindmg=9000, maxdmg=10000, attackpower=400, dmg_multiplier=19, baseattacktime=1500, unit_flags=32832, dynamicflags=0, lootid=39945, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='' WHERE entry=39945;
DELETE FROM creature WHERE id=39863;
INSERT INTO creature VALUES (247101, 39863, 724, 15, 1, 0, 0, 3156.0, 533.8108, 72.98822, 3.159046, 1209600, 0, 0, 15339500, 0, 0, 0, 0, 0);
REPLACE INTO creature_template_addon VALUES (39863, 0, 0, 0, 4097, 0, '78243');
REPLACE INTO creature_template_addon VALUES (39864, 0, 0, 0, 4097, 0, '78243');
REPLACE INTO creature_template_addon VALUES (39944, 0, 0, 0, 4097, 0, '78243');
REPLACE INTO creature_template_addon VALUES (39945, 0, 0, 0, 4097, 0, '78243');

DELETE FROM creature_loot_template WHERE entry IN(39864, 39945);
INSERT INTO creature_loot_template VALUES (39864, 1, 100, 1, 0, -34282, 2);
INSERT INTO creature_loot_template VALUES (39864, 2, 100, 1, 0, -45100, 1);
INSERT INTO creature_loot_template VALUES (39864, 49426, 100, 1, 0, 3, 3);
INSERT INTO creature_loot_template VALUES (39945, 1, 100, 1, 0, -34283, 2);
INSERT INTO creature_loot_template VALUES (39945, 2, 100, 1, 0, -45101, 1);
INSERT INTO creature_loot_template VALUES (39945, 49426, 100, 1, 0, 3, 3);
DELETE FROM reference_loot_template WHERE entry IN(34282, 34283, 45100, 45101);
INSERT INTO reference_loot_template VALUES (34282, 53125, 0, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (34282, 53126, 0, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (34282, 53127, 0, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (34282, 53129, 0, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (34282, 53132, 0, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (34282, 53133, 0, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (34282, 53134, 0, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (34282, 53486, 0, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (34282, 53487, 0, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (34282, 53488, 0, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (34282, 53489, 0, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (34282, 53490, 0, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (45100, 54569, 0, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (45100, 54571, 0, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (45100, 54572, 0, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (45100, 54573, 0, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (34283, 54576, 0, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (34283, 54587, 0, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (34283, 54586, 0, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (34283, 54585, 0, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (34283, 54584, 0, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (34283, 54583, 0, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (34283, 54582, 0, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (34283, 54581, 0, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (34283, 54580, 0, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (34283, 54579, 0, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (34283, 54578, 0, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (34283, 54577, 0, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (45101, 54591, 0, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (45101, 54590, 0, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (45101, 54589, 0, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (45101, 54588, 0, 1, 1, 1, 1);

-- Halion (40142, 40143, 40144, 40145)
DELETE FROM creature_text WHERE entry=40142;
INSERT INTO creature_text VALUES (40142, 0, 0, 'Without pressure in both realms, %s begins to regenerate.', 41, 0, 100, 0, 0, 0, 0, 'Halion');
INSERT INTO creature_text VALUES (40142, 1, 0, 'Beware the shadow!', 14, 0, 100, 0, 0, 17506, 0, 'Halion');
INSERT INTO creature_text VALUES (40142, 2, 0, 'I am the light and the darkness! Cower, mortals, before the herald of Deathwing!', 14, 0, 100, 0, 0, 17508, 0, 'Halion');
INSERT INTO creature_text VALUES (40142, 3, 0, 'Your companions'' efforts force %s further into the twilight realm!', 41, 0, 100, 0, 0, 0, 0, 'Halion');
INSERT INTO creature_text VALUES (40142, 4, 0, 'Your efforts force %s further out of the twilight realm!', 41, 0, 100, 0, 0, 0, 0, 'Halion');
INSERT INTO creature_text VALUES (40142, 5, 0, 'The orbiting spheres pulse with dark energy!', 41, 0, 100, 0, 0, 0, 0, 'Halion');
INSERT INTO creature_text VALUES (40142, 6, 0, 'Another "hero" falls.', 14, 0, 100, 0, 0, 17501, 0, 'Halion');
UPDATE creature_template SET rank=3, speed_walk=1.6, speed_run=1.42857, scale=1, mindmg=9000, maxdmg=10000, attackpower=400, dmg_multiplier=8, baseattacktime=1500, unit_flags=32832, dynamicflags=0, lootid=0, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='boss_twilight_halion' WHERE entry=40142;
UPDATE creature_template SET rank=3, speed_walk=1.6, speed_run=1.42857, scale=1, mindmg=9000, maxdmg=10000, attackpower=400, dmg_multiplier=13.5, baseattacktime=1500, unit_flags=32832, dynamicflags=0, lootid=0, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='' WHERE entry=40143;
UPDATE creature_template SET rank=3, speed_walk=1.6, speed_run=1.42857, scale=1, mindmg=9000, maxdmg=10000, attackpower=400, dmg_multiplier=10.5, baseattacktime=1500, unit_flags=32832, dynamicflags=0, lootid=0, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='' WHERE entry=40144;
UPDATE creature_template SET rank=3, speed_walk=1.6, speed_run=1.42857, scale=1, mindmg=9000, maxdmg=10000, attackpower=400, dmg_multiplier=19, baseattacktime=1500, unit_flags=32832, dynamicflags=0, lootid=0, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='' WHERE entry=40145;
REPLACE INTO creature_template_addon VALUES (40142, 0, 0, 0, 4097, 0, '78243');
REPLACE INTO creature_template_addon VALUES (40143, 0, 0, 0, 4097, 0, '78243');
REPLACE INTO creature_template_addon VALUES (40144, 0, 0, 0, 4097, 0, '78243');
REPLACE INTO creature_template_addon VALUES (40145, 0, 0, 0, 4097, 0, '78243');

-- Halion Controller (40146)
UPDATE creature_template SET unit_flags=33554432, flags_extra=130, AIName='', ScriptName='npc_halion_controller' WHERE entry=40146;
DELETE FROM creature WHERE id=40146;
INSERT INTO creature VALUES (247102, 40146, 724, 15, 33, 0, 0, 3156.037, 533.2656, 72.97205, 0.0, 1209600, 0, 0, 0, 0, 0, 0, 0, 0);

-- Meteor Strike (40029, 40041, 40042, 40043, 40044, 40055)
UPDATE creature_template SET flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry IN(40029, 40041, 40042, 40043, 40044, 40055);

-- Living Inferno (40681, 40682)
REPLACE INTO creature_template_addon VALUES(40681, 0, 0, 0, 4097, 0, '75885');
REPLACE INTO creature_template_addon VALUES(40682, 0, 0, 0, 4097, 0, '75885');
UPDATE creature_template SET speed_walk=3.2, speed_run=1.71429, mindmg=497, maxdmg=676, attackpower=795, baseattacktime=2000, dmg_multiplier=45, unit_flags=64, mechanic_immune_mask=549521937, flags_extra=256, AIName='SmartAI', ScriptName='' WHERE entry=40681;
UPDATE creature_template SET speed_walk=3.2, speed_run=1.71429, mindmg=497, maxdmg=676, attackpower=795, baseattacktime=2000, dmg_multiplier=80, unit_flags=64, mechanic_immune_mask=549521937, flags_extra=256, AIName='', ScriptName='' WHERE entry=40682;
DELETE FROM smart_scripts WHERE entryorguid=40681 AND source_type=0;
INSERT INTO smart_scripts VALUES (40681, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Living Inferno - On AI Init - Set React Passive');
INSERT INTO smart_scripts VALUES (40681, 0, 1, 2, 60, 0, 100, 257, 3000, 3000, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Living Inferno - On Update - Set React Aggressive');
INSERT INTO smart_scripts VALUES (40681, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Living Inferno - On Update - Set In Combat With Zone');

-- Living Ember (40683, 40684)
UPDATE creature_template SET speed_walk=3.2, speed_run=1.71429, mindmg=497, maxdmg=676, attackpower=795, baseattacktime=2000, dmg_multiplier=20, unit_flags=64, mechanic_immune_mask=549521937, AIName='SmartAI', ScriptName='' WHERE entry=40683;
UPDATE creature_template SET speed_walk=3.2, speed_run=1.71429, mindmg=497, maxdmg=676, attackpower=795, baseattacktime=2000, dmg_multiplier=35, unit_flags=64, mechanic_immune_mask=549521937, AIName='', ScriptName='' WHERE entry=40684;
DELETE FROM smart_scripts WHERE entryorguid=40683 AND source_type=0;
INSERT INTO smart_scripts VALUES (40683, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Living Ember - On AI Init - Set React Passive');
INSERT INTO smart_scripts VALUES (40683, 0, 1, 0, 60, 0, 100, 257, 2000, 2000, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Living Ember - On Update - Set Visible');
INSERT INTO smart_scripts VALUES (40683, 0, 2, 3, 60, 0, 100, 257, 4000, 4000, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Living Ember - On Update - Set React Aggressive');
INSERT INTO smart_scripts VALUES (40683, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Living Ember - On Update - Set In Combat With Zone');
INSERT INTO smart_scripts VALUES (40683, 0, 4, 0, 60, 0, 100, 257, 120000, 120000, 0, 0, 11, 26662, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Living Ember - On Update - Cast Berserk');

-- Combustion (40001)
REPLACE INTO creature_template_addon VALUES (40001, 0, 0, 0, 0, 0, '');
UPDATE creature_template SET flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=40001;

-- Consumption (40135)
REPLACE INTO creature_template_addon VALUES (40135, 0, 0, 0, 0, 0, '');
UPDATE creature_template SET flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=40135;

-- Orb Carrier (40081, 40470, 40471, 40472)
REPLACE INTO creature_template_addon VALUES (40081, 0, 0, 0, 0, 0, '');
REPLACE INTO creature_template_addon VALUES (40470, 0, 0, 0, 0, 0, '');
REPLACE INTO creature_template_addon VALUES (40471, 0, 0, 0, 0, 0, '');
REPLACE INTO creature_template_addon VALUES (40472, 0, 0, 0, 0, 0, '');
UPDATE creature_template SET modelid1=169, modelid2=11686, speed_walk=1.2, speed_run=0.428571, VehicleId=718, InhabitType=4, flags_extra=130, AIName='', ScriptName='npc_orb_carrier' WHERE entry=40081;
UPDATE creature_template SET modelid1=169, modelid2=11686, speed_walk=1.2, speed_run=0.428571, VehicleId=718, InhabitType=4, flags_extra=130, AIName='', ScriptName='' WHERE entry=40470;
UPDATE creature_template SET modelid1=169, modelid2=11686, speed_walk=1.2, speed_run=0.428571, VehicleId=746, InhabitType=4, flags_extra=130, AIName='', ScriptName='' WHERE entry=40471;
UPDATE creature_template SET modelid1=169, modelid2=11686, speed_walk=1.2, speed_run=0.428571, VehicleId=746, InhabitType=4, flags_extra=130, AIName='', ScriptName='' WHERE entry=40472;
DELETE FROM vehicle_template_accessory WHERE entry IN(40081, 40470, 40471, 40472);
INSERT INTO vehicle_template_accessory VALUES (40081, 40083, 0, 1, 'Orb Carrier', 6, 30000);
INSERT INTO vehicle_template_accessory VALUES (40081, 40100, 1, 1, 'Orb Carrier', 6, 30000);
INSERT INTO vehicle_template_accessory VALUES (40470, 40083, 0, 1, 'Orb Carrier', 6, 30000);
INSERT INTO vehicle_template_accessory VALUES (40470, 40100, 1, 1, 'Orb Carrier', 6, 30000);
INSERT INTO vehicle_template_accessory VALUES (40471, 40083, 0, 1, 'Orb Carrier', 6, 30000);
INSERT INTO vehicle_template_accessory VALUES (40471, 40100, 1, 1, 'Orb Carrier', 6, 30000);
INSERT INTO vehicle_template_accessory VALUES (40471, 40468, 2, 1, 'Orb Carrier', 6, 30000);
INSERT INTO vehicle_template_accessory VALUES (40471, 40469, 3, 1, 'Orb Carrier', 6, 30000);
INSERT INTO vehicle_template_accessory VALUES (40472, 40083, 0, 1, 'Orb Carrier', 6, 30000);
INSERT INTO vehicle_template_accessory VALUES (40472, 40100, 1, 1, 'Orb Carrier', 6, 30000);
INSERT INTO vehicle_template_accessory VALUES (40472, 40468, 2, 1, 'Orb Carrier', 6, 30000);
INSERT INTO vehicle_template_accessory VALUES (40472, 40469, 3, 1, 'Orb Carrier', 6, 30000);

-- Orb Rotation Focus (40091, 43280, 43281, 43282)
UPDATE creature_template SET flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=40091;
UPDATE creature_template SET flags_extra=130, AIName='', ScriptName='' WHERE entry IN(43280, 43281, 43282);

-- Shadow Orb (40083)
-- Shadow Orb (40100)
-- Shadow Orb (40468)
-- Shadow Orb (40469)
DELETE FROM creature_text WHERE entry IN(40083, 40100, 40468, 40469);
REPLACE INTO creature_template_addon VALUES (40083, 0, 0, 33554432, 1, 0, '');
REPLACE INTO creature_template_addon VALUES (40100, 0, 0, 33554432, 1, 0, '');
REPLACE INTO creature_template_addon VALUES (40468, 0, 0, 33554432, 1, 0, '');
REPLACE INTO creature_template_addon VALUES (40469, 0, 0, 33554432, 1, 0, '');
UPDATE creature_template SET unit_flags=33554432, type=10, flags_extra=2, AIName='NullCreatureAI', ScriptName='' WHERE entry IN(40083, 40100, 40468, 40469);

-- GO Twilight Portal (202794)
UPDATE gameobject_template SET faction=35, flags=32, size=5, data10=74807, AIName='SmartGameObjectAI', ScriptName='' WHERE entry=202794;
DELETE FROM smart_scripts WHERE entryorguid=202794 AND source_type=1;
INSERT INTO smart_scripts VALUES(202794, 1, 0, 0, 60, 0, 100, 257, 0, 0, 0, 0, 44, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Twilight Portal - On Update - Set Phase Mask");
INSERT INTO smart_scripts VALUES(202794, 1, 1, 0, 60, 0, 100, 0, 1000, 1000, 1000, 1000, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Twilight Portal - On Update - Despawn Self");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=202794;
INSERT INTO conditions VALUES(22, 2, 202794, 1, 0, 13, 1, 6, 1, 2, 1, 0, 0, '', 'Run Action if BossState != IN_PROGRESS');

-- GO Twilight Portal (202795)
UPDATE gameobject_template SET faction=35, flags=32, size=2, data10=74807, AIName='SmartGameObjectAI', ScriptName='' WHERE entry=202795;
DELETE FROM smart_scripts WHERE entryorguid=202795 AND source_type=1;
INSERT INTO smart_scripts VALUES(202795, 1, 0, 0, 60, 0, 100, 257, 0, 0, 0, 0, 44, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Twilight Portal - On Update - Set Phase Mask");
INSERT INTO smart_scripts VALUES(202795, 1, 1, 0, 60, 0, 100, 0, 1000, 1000, 500, 500, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Twilight Portal - On Update - Despawn Self");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=202795;
INSERT INTO conditions VALUES(22, 2, 202795, 1, 0, 13, 1, 6, 1, 2, 1, 0, 0, '', 'Run Action if BossState != IN_PROGRESS');

-- GO Twilight Portal (202796)
UPDATE gameobject_template SET faction=35, flags=32, size=2, data10=74812, AIName='SmartGameObjectAI', ScriptName='' WHERE entry=202796;
DELETE FROM smart_scripts WHERE entryorguid=202796 AND source_type=1;
INSERT INTO smart_scripts VALUES(202796, 1, 0, 0, 60, 0, 100, 257, 0, 0, 0, 0, 44, 32, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Twilight Portal - On Update - Set Phase Mask");
INSERT INTO smart_scripts VALUES(202796, 1, 1, 0, 60, 0, 100, 0, 1000, 1000, 500, 500, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Twilight Portal - On Update - Despawn Self");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=202796;
INSERT INTO conditions VALUES(22, 2, 202796, 1, 0, 13, 1, 6, 1, 2, 1, 0, 0, '', 'Run Action if BossState != IN_PROGRESS');

-- SPELL Meteor Strike Targeting (74638)
DELETE FROM spell_script_names WHERE spell_id=74638;
INSERT INTO spell_script_names VALUES(74638, 'spell_halion_meteor_strike_targeting');

-- SPELL Meteor Strike Targeting (74641)
DELETE FROM spell_script_names WHERE spell_id=74641;
INSERT INTO spell_script_names VALUES(74641, 'spell_halion_meteor_strike_marker');

-- SPELL Spread Meteor Strike (74696)
DELETE FROM spell_script_names WHERE spell_id=74696;
INSERT INTO spell_script_names VALUES(74696, 'spell_halion_meteor_strike_spread');

-- SPELL Blazing Aura (75886, 75887)
DELETE FROM spell_script_names WHERE spell_id IN(75886, 75887);
INSERT INTO spell_script_names VALUES(75886, 'spell_halion_blazing_aura');
INSERT INTO spell_script_names VALUES(75887, 'spell_halion_blazing_aura');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(75886, 75887);
INSERT INTO conditions VALUES(13, 2, 75886, 0, 0, 31, 0, 3, 40683, 0, 0, 0, 0, '', 'Target Living Ember');
INSERT INTO conditions VALUES(13, 2, 75886, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Target Living Ember Alive');
INSERT INTO conditions VALUES(13, 2, 75887, 0, 0, 31, 0, 3, 40683, 0, 0, 0, 0, '', 'Target Living Ember');
INSERT INTO conditions VALUES(13, 2, 75887, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Target Living Ember Alive');

-- SPELL Fiery Combustion (74562, 74567, 74610)
DELETE FROM spell_script_names WHERE spell_id IN(74562, 74567, 74610);
INSERT INTO spell_script_names VALUES(74562, 'spell_halion_fiery_combustion');
INSERT INTO spell_script_names VALUES(74567, 'spell_halion_mark_of_combustion');
INSERT INTO spell_script_names VALUES(74610, 'spell_halion_combustion_summon');

-- SPELL Soul Consumption (74792, 74795, 74800)
DELETE FROM spell_script_names WHERE spell_id IN(74792, 74795, 74800);
INSERT INTO spell_script_names VALUES(74792, 'spell_halion_soul_consumption');
INSERT INTO spell_script_names VALUES(74795, 'spell_halion_mark_of_consumption');
INSERT INTO spell_script_names VALUES(74800, 'spell_halion_consumption_summon');

-- SPELL Combustion (74630, 75882, 75883, 75884);
-- SPELL Consumption (74802, 75874, 75875, 75876);
DELETE FROM spell_script_names WHERE spell_id IN(74630, 75882, 75883, 75884, 74802, 75874, 75875, 75876);
INSERT INTO spell_script_names VALUES(74630, 'spell_gen_mod_radius_by_caster_scale');
INSERT INTO spell_script_names VALUES(75882, 'spell_gen_mod_radius_by_caster_scale');
INSERT INTO spell_script_names VALUES(75883, 'spell_gen_mod_radius_by_caster_scale');
INSERT INTO spell_script_names VALUES(75884, 'spell_gen_mod_radius_by_caster_scale');
INSERT INTO spell_script_names VALUES(74802, 'spell_gen_mod_radius_by_caster_scale');
INSERT INTO spell_script_names VALUES(75874, 'spell_gen_mod_radius_by_caster_scale');
INSERT INTO spell_script_names VALUES(75875, 'spell_gen_mod_radius_by_caster_scale');
INSERT INTO spell_script_names VALUES(75876, 'spell_gen_mod_radius_by_caster_scale');

-- SPELL Clear Debuffs (75396)
DELETE FROM spell_script_names WHERE spell_id=75396;
INSERT INTO spell_script_names VALUES(75396, 'spell_halion_clear_debuffs');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=75396;
INSERT INTO conditions VALUES(13, 1, 75396, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Target Players');

-- SPELL Twilight Phasing (74808)
DELETE FROM spell_script_names WHERE spell_id=74808;
INSERT INTO spell_script_names VALUES(74808, 'spell_halion_twilight_phasing');

-- SPELL Twilight Realm (74807)
DELETE FROM spell_script_names WHERE spell_id=74807;
INSERT INTO spell_script_names VALUES(74807, 'spell_halion_twilight_realm');

-- SPELL Twilight Realm (74812)
DELETE FROM spell_script_names WHERE spell_id=74812;
INSERT INTO spell_script_names VALUES(74812, 'spell_halion_leave_twilight_realm');

-- SPELL Track Rotation (74758)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=74758;
INSERT INTO conditions VALUES(13, 1, 74758, 0, 0, 31, 0, 3, 40091, 0, 0, 0, 0, '', 'Track Rotation can only target Orb Rotation Focus');

-- SPELL Twilight Cutter (74768)
DELETE FROM spell_script_names WHERE spell_id=74768;
INSERT INTO spell_script_names VALUES(74768, 'spell_halion_twilight_cutter_periodic');

-- SPELL Twilight Cutter (74769, 77844, 77845, 77846);
DELETE FROM spell_script_names WHERE spell_id IN(74769, 77844, 77845, 77846);
INSERT INTO spell_script_names VALUES(74769, 'spell_halion_twilight_cutter');
INSERT INTO spell_script_names VALUES(77844, 'spell_halion_twilight_cutter');
INSERT INTO spell_script_names VALUES(77845, 'spell_halion_twilight_cutter');
INSERT INTO spell_script_names VALUES(77846, 'spell_halion_twilight_cutter');

-- SPELL Halion - Summon Twilight Portals (74804)
-- SPELL Halion - Summon Twilight Portals (74805)
DELETE FROM spell_script_names WHERE spell_id IN(74804, 74805);
INSERT INTO spell_script_names VALUES(74804, 'spell_halion_summon_exit_portals');
INSERT INTO spell_script_names VALUES(74805, 'spell_halion_summon_exit_portals');
	
-- SPELL Twilight Division (75063)
DELETE FROM spell_script_names WHERE spell_id=75063;
INSERT INTO spell_script_names VALUES(75063, 'spell_halion_twilight_division');

-- SPELL Twilight Mending (75509)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=75509;
INSERT INTO conditions VALUES(13, 1, 75509, 0, 0, 31, 0, 3, 40142, 0, 0, 0, 0, '', 'Twilight Mending can only target Halion');
INSERT INTO conditions VALUES(13, 2, 75509, 0, 0, 31, 0, 3, 39863, 0, 0, 0, 0, '', 'Twilight Mending can only target Halion');
DELETE FROM spell_script_names WHERE spell_id=75509;
INSERT INTO spell_script_names VALUES(75509, 'spell_halion_twilight_mending');




-- -------------------------------------------
--                MISC
-- -------------------------------------------

-- Ruby Drakonid (40626)
-- Ruby Drake (40627)
-- Ruby Scalebane (40628)
-- Ruby Dragon (40870)
UPDATE creature_template SET unit_flags=570688258, dynamicflags=32, flags_extra=2, AIName='NullCreatureAI', ScriptName='' WHERE entry IN(40626, 40627, 40628, 40870);

-- -------------------------------------------
--             ACHIEVEMENTS
-- -------------------------------------------

-- The Twilight Destroyer (10 player) (4817)
DELETE FROM disables WHERE sourceType=4 AND entry IN(13453);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(13453);
REPLACE INTO achievement_criteria_data VALUES(13453, 12, 0, 0, "");

-- The Twilight Destroyer (25 player) (4815)
DELETE FROM disables WHERE sourceType=4 AND entry IN(13451);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(13451);
REPLACE INTO achievement_criteria_data VALUES(13451, 12, 1, 0, "");

-- Heroic: The Twilight Destroyer (10 player) (4818)
DELETE FROM disables WHERE sourceType=4 AND entry IN(13454);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(13454);
REPLACE INTO achievement_criteria_data VALUES(13454, 12, 2, 0, "");

-- Heroic: The Twilight Destroyer (25 player) (4816)
DELETE FROM disables WHERE sourceType=4 AND entry IN(13452);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(13452);
REPLACE INTO achievement_criteria_data VALUES(13452, 12, 3, 0, "");

-- Halion kills (Heroic Ruby Sanctum 25 player) (4823)
DELETE FROM disables WHERE sourceType=4 AND entry IN(13467);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(13467);
REPLACE INTO achievement_criteria_data VALUES(13467, 12, 3, 0, "");

-- Halion kills (Heroic Ruby Sanctum 10 player) (4822)
DELETE FROM disables WHERE sourceType=4 AND entry IN(13468);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(13468);
REPLACE INTO achievement_criteria_data VALUES(13468, 12, 2, 0, "");

-- Halion kills (Heroic Ruby Sanctum 25 player) (4820)
DELETE FROM disables WHERE sourceType=4 AND entry IN(13465);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(13465);
REPLACE INTO achievement_criteria_data VALUES(13465, 12, 1, 0, "");

-- Halion kills (Heroic Ruby Sanctum 10 player) (4821)
DELETE FROM disables WHERE sourceType=4 AND entry IN(13466);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(13466);
REPLACE INTO achievement_criteria_data VALUES(13466, 12, 0, 0, "");
