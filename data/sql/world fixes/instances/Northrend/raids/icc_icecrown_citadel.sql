INSERT INTO disables VALUES(2, 631, 15, '', '', '');
DELETE FROM disables WHERE sourceType=2 AND entry IN(631);
REPLACE INTO access_requirement VALUES (631, 0, 80, 0, 0, 0, 0, 0, 0, 0, NULL, 'IceCrown Citadel (Entrance)');
REPLACE INTO access_requirement VALUES (631, 1, 80, 0, 0, 0, 0, 0, 0, 0, NULL, 'IceCrown Citadel (Entrance)');
REPLACE INTO access_requirement VALUES (631, 2, 80, 0, 0, 0, 0, 0, 0, 4530, NULL, 'IceCrown Citadel (Entrance)');
REPLACE INTO access_requirement VALUES (631, 3, 80, 0, 0, 0, 0, 0, 0, 4597, NULL, 'IceCrown Citadel (Entrance)');

-- select creature.id, creature.position_x, creature.position_y, creature.position_z, count(creature.id) as count,creature_template.* from creature left join creature_template on creature_template.entry=creature.id where creature.map=631 group by creature.id order by id desc;
-- select gameobject.id,count(gameobject.id) as count,gameobject_template.* from gameobject left join gameobject_template on gameobject_template.entry=gameobject.id where gameobject.map=631 group by gameobject.id order by id desc;

-- ###################
-- ### GAMEOBJECTS
-- ###################

-- Runeforge
DELETE FROM gameobject WHERE id=190557 AND map=631;
INSERT INTO gameobject VALUES (NULL, 190557, 631, 15, 1, -59.4583, 2157.47, 30.6542, 2.75761, 0, 0 ,0 ,1 ,6000, 100, 1, 0);

-- Spirit Alarm
UPDATE gameobject_template SET faction=14, data1=0, data4=0, data5=3600, data6=3600000, data11=1 WHERE entry IN(201814,201815,201816,201817);
UPDATE gameobject SET spawntimesecs=3600 WHERE id IN(201814,201815,201816,201817);

-- Geist Alarm
UPDATE gameobject_template SET faction=14, data1=0, data4=0, data5=3600, data6=3600000, data11=1 WHERE entry IN(201888,201889);
DELETE FROM gameobject WHERE id IN(201888,201889);
INSERT INTO gameobject VALUES (NULL, 201888, 631, 15, 1, 4335.63, 3026.42, 360.52, 3.03556, 0, 0, 0.998595, 0.052991, 3600, 0, 1, 0);
INSERT INTO gameobject VALUES (NULL, 201889, 631, 15, 1, 4374.28, 3027.07, 360.52, 0.00784683, 0, 0, 0.00392341, 0.999992, 3600, 0, 1, 0);
REPLACE INTO spell_script_names VALUES(70739, 'spell_icc_geist_alarm'),(70740, 'spell_icc_geist_alarm');

-- Gas Release Valve (201616)
UPDATE gameobject_template SET type=10, flags=0, data0=1690, data1=0, data2=23438, data3=3, data5=0 WHERE entry=201616;

-- Ooze Release Valve (201615)
UPDATE gameobject_template SET type=10, flags=0, data0=1690, data1=0, data2=23426, data3=3, data5=0 WHERE entry=201615;

-- Scourge Transporter
UPDATE spell_target_position SET target_orientation=(3.14+3.14/6) WHERE id=70781;
UPDATE spell_target_position SET target_orientation=(3.14+3.14/6) WHERE id=70856;
UPDATE spell_target_position SET target_orientation=(3.14/6) WHERE id=70857;
UPDATE spell_target_position SET target_orientation=(3.14/6) WHERE id=70858;
UPDATE spell_target_position SET target_orientation=(3.14/6) WHERE id=70859;
UPDATE spell_target_position SET target_orientation=(3.14*3/2+3.14/6) WHERE id=70861;
UPDATE gameobject_template SET flags = flags & (~0x10) WHERE entry IN(202242, 202243, 202244, 202245, 202235, 202246);
UPDATE gameobject_template SET flags = flags | 0x10 WHERE entry=202242;




-- ###################
-- ### NPCS
-- ###################

-- Garrosh Hellscream (39372)
UPDATE creature_template SET gossip_menu_id=11206, AIName='SmartAI', ScriptName='npc_icc_buff_switcher' WHERE entry=39372;
REPLACE INTO gossip_menu VALUES(11206, 15606);
REPLACE INTO gossip_menu VALUES(11207, 15607);
DELETE FROM gossip_menu_option WHERE menu_id IN(11206, 11207);
INSERT INTO gossip_menu_option VALUES (11206, 0, 0, 'We will cope with the Lich King and it\'s servants without your help.', 1, 1, 11207, 0, 0, 0, '');
REPLACE INTO `npc_text` VALUES (15606, 'With the Warsong Offensive here in Icecrown Citadel, victory is within our grasp! The death of the Lich King will bring glory to the Horde!', '', 0, 1, 0, 396, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 12340);
REPLACE INTO `npc_text` VALUES (15607, 'Your choice was bold! I respect your desire for glory and honor! Die well, $N!', '', 0, 1, 0, 113, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 11723);
DELETE FROM smart_scripts WHERE entryorguid IN(39372) AND source_type=0;
-- INSERT INTO `smart_scripts` VALUES (39372, 0, 0, 0, 62, 0, 100, 0, 11206, 0, 0, 0, 34, 251, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SetData in instance to disable Buff');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=11206;
INSERT INTO conditions VALUES(15, 11206, 0, 0, 0, 13, 0, 251, 1, 0, 0, 0, 0, '', '');

-- King Varian Wrynn (39371)
UPDATE creature_template SET gossip_menu_id=11203, AIName='SmartAI', ScriptName='npc_icc_buff_switcher' WHERE entry=39371;
REPLACE INTO gossip_menu VALUES(11203, 15602);
REPLACE INTO gossip_menu VALUES(11204, 15603);
REPLACE INTO gossip_menu VALUES(11205, 15604);
DELETE FROM gossip_menu_option WHERE menu_id IN(11203, 11204, 11205);
INSERT INTO gossip_menu_option VALUES (11203, 0, 0, 'With all due respect, your Highness, we can do this alone.', 1, 1, 11204, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (11204, 0, 0, 'We do wish for you to stand down, your Highness.', 1, 1, 11205, 0, 0, 0, '');
REPLACE INTO `npc_text` VALUES (15602, 'The continued sacrifice of the Ashen Verdict and heroes such as yourself bring us all closer to final victory. Now I have come to Icecrown Citadel to lend aid to those who fight against the Scourge. Together we will end the tyranny of the Lich King!', '', 0, 1, 0, 396, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 12340);
REPLACE INTO `npc_text` VALUES (15603, 'You can do this alone, you say? Is this simple foolishness or misplaced confidence I see before me?$B$BNo, I can see it in your eyes. You have to know. You have to prove to yourself that you can do this alone. Very well. I will retreat from the battlefield if you so wish it.', '', 0, 1, 0, 396, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 12340);
REPLACE INTO `npc_text` VALUES (15604, 'You will need more than bravery to defeat the Lich King. Good luck.', '', 0, 1, 0, 396, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(39371) AND source_type=0;
-- INSERT INTO `smart_scripts` VALUES (39371, 0, 0, 0, 62, 0, 100, 0, 11204, 0, 0, 0, 34, 251, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SetData in instance to disable Buff');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=11203;
INSERT INTO conditions VALUES(15, 11203, 0, 0, 0, 13, 0, 251, 1, 0, 0, 0, 0, '', '');

-- Deathbound Ward (37007, 38031)
UPDATE creature_template SET speed_walk=2, speed_run=1.42857, mindmg=2319, maxdmg=3161, attackpower=300, dmg_multiplier=7, baseattacktime=1000, AIName='SmartAI', flags_extra = flags_extra|256, ScriptName='' WHERE entry=37007;
UPDATE creature_template SET speed_walk=2, speed_run=1.42857, mindmg=1875, maxdmg=2557, attackpower=300, dmg_multiplier=13, baseattacktime=1000, AIName='', flags_extra = flags_extra|256, ScriptName='' WHERE entry=38031;
DELETE FROM smart_scripts WHERE entryorguid IN(37007, 38031) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (37007, 0, 0, 0, 0, 0, 100, 0, 15000, 20000, 30000, 35000, 11, 71022, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Disrupting Shout');
INSERT INTO `smart_scripts` VALUES (37007, 0, 1, 0, 0, 0, 100, 0, 9000, 12000, 9000, 12000, 11, 71021, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Saber Lash');
REPLACE INTO `creature_template_addon` VALUES (37007, 0, 0, 0, 0, 0, '70733');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(71022, -71022);
INSERT INTO `conditions` VALUES (13, 1, 71022, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'ICC trash - Disrupting Shout');

-- The Damned (37011, 38061)
DELETE FROM creature_template_addon WHERE entry IN(37011, 38061);
UPDATE creature_template SET mindmg=825, maxdmg=1125, attackpower=300, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=37011;
UPDATE creature_template SET mindmg=667, maxdmg=909, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38061;
DELETE FROM smart_scripts WHERE entryorguid IN(37011, 38061, -201066, -200966) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (37011, 0, 0, 0, 6, 0, 100, 1, 0, 0, 0, 0, 11, 70961, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shattered Bones');
INSERT INTO `smart_scripts` VALUES (37011, 0, 1, 0, 2, 0, 100, 0, 1, 30, 15000, 20000, 11, 70960, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bone Flurry');
INSERT INTO `smart_scripts` VALUES (37011, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On aggro - call for help');
INSERT INTO `smart_scripts` VALUES (37011, 0, 3, 0, 1, 0, 100, 0, 1000, 1000, 60000, 60000, 49, 0, 0, 0, 0, 0, 0, 25, 8, 0, 0, 0, 0, 0, 0, 'Out of combat - aggro');
INSERT INTO `smart_scripts` VALUES (-200966, 0, 0, 4, 6, 0, 100, 1, 0, 0, 0, 0, 11, 70961, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shattered Bones');
INSERT INTO `smart_scripts` VALUES (-200966, 0, 1, 0, 2, 0, 100, 0, 1, 30, 15000, 20000, 11, 70960, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bone Flurry');
INSERT INTO `smart_scripts` VALUES (-200966, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On aggro - call for help');
INSERT INTO `smart_scripts` VALUES (-200966, 0, 3, 0, 1, 0, 100, 0, 1000, 1000, 60000, 60000, 49, 0, 0, 0, 0, 0, 0, 25, 8, 0, 0, 0, 0, 0, 0, 'Out of combat - aggro');
INSERT INTO `smart_scripts` VALUES (-200966, 0, 4, 0, 61, 0, 100, 1, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 201466, 0, 0, 0, 0, 0, 0, 'On Death linked - SetData on Tirion Fordring');
INSERT INTO `smart_scripts` VALUES (-201066, 0, 0, 4, 6, 0, 100, 1, 0, 0, 0, 0, 11, 70961, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shattered Bones');
INSERT INTO `smart_scripts` VALUES (-201066, 0, 1, 0, 2, 0, 100, 0, 1, 30, 15000, 20000, 11, 70960, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bone Flurry');
INSERT INTO `smart_scripts` VALUES (-201066, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On aggro - call for help');
INSERT INTO `smart_scripts` VALUES (-201066, 0, 3, 0, 1, 0, 100, 0, 1000, 1000, 60000, 60000, 49, 0, 0, 0, 0, 0, 0, 25, 8, 0, 0, 0, 0, 0, 0, 'Out of combat - aggro');
INSERT INTO `smart_scripts` VALUES (-201066, 0, 4, 0, 61, 0, 100, 1, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 201466, 0, 0, 0, 0, 0, 0, 'On Death linked - SetData on Tirion Fordring');
-- group attacking the guards at the beginning:
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id=37011 AND (position_x > -110 OR position_x < -170.0 AND position_x > -180.0 AND position_y > 2190.0 AND position_y < 2240.0));
DELETE FROM creature_formations WHERE memberGUID IN( SELECT guid FROM creature WHERE id=37011 );
DELETE FROM creature WHERE id=37011 AND (position_x > -110 OR position_x < -170.0 AND position_x > -180.0 AND position_y > 2190.0 AND position_y < 2240.0);
INSERT INTO creature VALUES (247110, 37011, 631, 15, 1, 0, 0, -103.82, 2239.77, 30.6543, 1.81838, 86400, 0, 0, 478800, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (247111, 37011, 631, 15, 1, 0, 0, -100.629, 2180.84, 30.6543, 4.50444, 86400, 0, 0, 478800, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (247112, 37011, 631, 15, 1, 0, 0, -82.3484, 2214.98, 27.903, 0.0944354, 86400, 0, 0, 478800, 0, 0, 0, 0, 0);
-- patrolling group:
INSERT INTO creature VALUES (247113, 37011, 631, 15, 1, 0, 0, -175.0, 2215.0, 35.23, 0.0, 86400, 0, 0, 478800, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (247114, 37011, 631, 15, 1, 0, 0, -175.0, 2215.0, 35.23, 0.0, 86400, 0, 0, 478800, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (247115, 37011, 631, 15, 1, 0, 0, -175.0, 2215.0, 35.23, 0.0, 86400, 0, 0, 478800, 0, 0, 0, 0, 0);
SELECT @guid := MAX(guid)-2 FROM creature WHERE id=37011;
INSERT INTO creature_addon VALUES(@guid, 3701100, 0, 0, 1, 0, '');
INSERT INTO creature_formations VALUES(@guid, @guid, 0, 0, 1, 0, 0),(@guid, @guid+1, 4, 90, 1, 1, 2),(@guid, @guid+2, 4, 270, 1, 1, 2);
UPDATE creature SET MovementType=0 WHERE id IN(37011, 38061);
UPDATE creature SET MovementType=2 WHERE guid=@guid AND id IN(37011, 38061);
DELETE FROM waypoint_data WHERE id=3701100;
INSERT INTO `waypoint_data` VALUES (3701100, 1, -175.0, 2190.0, 35.5, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3701100, 2, -175.0, 2240.0, 35.5, 0, 0, 1, 0, 100, 0);

-- Servant of the Throne (36724, 38057);
UPDATE creature_template SET mindmg=828, maxdmg=1127, attackpower=300, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=36724;
UPDATE creature_template SET mindmg=710, maxdmg=967, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38057;
DELETE FROM smart_scripts WHERE entryorguid IN(36724, 38057) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (36724, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 3000, 4500, 11, 71029, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Glacial Blast');
INSERT INTO `smart_scripts` VALUES (36724, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On aggro - call for help');

-- Ancient Skeletal Soldier (37012, 38059)
UPDATE creature_template SET mindmg=1238, maxdmg=1688, attackpower=300, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=37012;
UPDATE creature_template SET mindmg=1049, maxdmg=1430, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38059;
DELETE FROM smart_scripts WHERE entryorguid IN(37012, 38059) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (37012, 0, 0, 0, 0, 0, 100, 0, 5000, 10000, 7000, 12000, 11, 70964, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shield Bash');
INSERT INTO `smart_scripts` VALUES (37012, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On aggro - call for help');

-- Nerub'ar Broodkeeper (36725, 38058)
UPDATE creature_template SET mindmg=828, maxdmg=1127, attackpower=300, dmg_multiplier=7, skinloot=70215, AIName='', ScriptName='npc_icc_nerubar_broodkeeper', InhabitType=5 WHERE entry=36725;
UPDATE creature_template SET mindmg=759, maxdmg=1029, attackpower=300, dmg_multiplier=13, skinloot=70215, AIName='', ScriptName='', InhabitType=5 WHERE entry=38058;
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36725, 38058) AND `map`=631 );
DELETE FROM creature_template_addon WHERE entry IN(36725, 38058);
DELETE FROM smart_scripts WHERE entryorguid IN(36725, 38058) AND source_type=0;
-- INSERT INTO `smart_scripts` VALUES (36725, 0, 0, 0, 0, 0, 100, 0, 3000, 10000, 20000, 30000, 11, 70965, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crypt Scarabs');
-- INSERT INTO `smart_scripts` VALUES (36725, 0, 1, 0, 0, 0, 100, 0, 15000, 25000, 20000, 30000, 11, 71020, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dark Mending');
-- INSERT INTO `smart_scripts` VALUES (36725, 0, 2, 0, 0, 0, 100, 0, 8000, 15000, 20000, 30000, 11, 70980, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Web Wrap');
-- INSERT INTO `smart_scripts` VALUES (36725, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On aggro - call for help');
-- move them to ground, fuck this shit ;d
-- update: move then into air, fixed ^^
UPDATE creature SET position_z = 80 WHERE id=36725;
UPDATE creature SET position_z = 80 WHERE position_x > -225.0 AND id=36725;
UPDATE creature SET position_z = 80 WHERE (position_y < 2185.0 OR position_y > 2230.0) AND id=36725;
DELETE FROM skinning_loot_template WHERE entry=70215;
INSERT INTO skinning_loot_template VALUES(70215, 33568, 0, 1, 1, 1, 7);
INSERT INTO skinning_loot_template VALUES(70215, 38558, 25, 1, 1, 1, 5);
INSERT INTO skinning_loot_template VALUES(70215, 44128, 1, 1, 1, 1, 2);

-- Web Wrap (38028)
UPDATE creature_template SET difficulty_entry_1=0, AIName='SmartAI', mechanic_immune_mask=652214271, ScriptName='' WHERE entry=38028;
DELETE FROM creature_template_addon WHERE entry IN(38028);
DELETE FROM smart_scripts WHERE entryorguid IN(38028) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (38028, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'REACT_PASSIVE on ai init');
INSERT INTO `smart_scripts` VALUES (38028, 0, 1, 0, 6, 0, 100, 1, 0, 0, 0, 0, 28, 71010, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'free victim on death');

-- Deathspeaker Servant (36805, 38075)
UPDATE creature_template SET faction=312, speed_walk=3.2, speed_run=1.71429, mindmg=843, maxdmg=1149, attackpower=300, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=36805;
UPDATE creature_template SET faction=312, speed_walk=3.2, speed_run=1.71429, mindmg=681, maxdmg=928, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38075;
REPLACE INTO creature_template_addon VALUES(36805, 0, 0, 8, 1, 0, ''),(38075, 0, 0, 8, 1, 0, '');
DELETE FROM smart_scripts WHERE entryorguid IN(36805, 38075) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (36805, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 3000, 5000, 11, 69576, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Chaos Bolt');
INSERT INTO `smart_scripts` VALUES (36805, 0, 1, 0, 0, 0, 100, 0, 3000, 10000, 15000, 25000, 11, 69405, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Consuming Shadows');

-- Risen Deathspeaker Servant (36844, 38077)
UPDATE creature_template SET faction=312, speed_walk=3.2, speed_run=1.71429, mindmg=843, maxdmg=1149, attackpower=300, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=36844;
UPDATE creature_template SET faction=312, speed_walk=3.2, speed_run=1.71429, mindmg=681, maxdmg=928, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38077;
DELETE FROM smart_scripts WHERE entryorguid IN(36844, 38077) AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(3684400) AND source_type=9;
INSERT INTO `smart_scripts` VALUES (36844, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 3000, 5000, 11, 69576, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Chaos Bolt');
INSERT INTO `smart_scripts` VALUES (36844, 0, 1, 0, 0, 0, 100, 0, 3000, 10000, 15000, 25000, 11, 69405, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Consuming Shadows');
INSERT INTO `smart_scripts` VALUES (36844, 0, 2, 0, 0, 0, 100, 0, 3000, 10000, 15000, 25000, 11, 69404, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Curse of Agony');
INSERT INTO `smart_scripts` VALUES (36844, 0, 3, 4, 37, 0, 100, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'AI Init - Set Visible - false');
INSERT INTO `smart_scripts` VALUES (36844, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 18, 512+256+4+2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'AI Init - Set unit flags');
INSERT INTO `smart_scripts` VALUES (36844, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 3684400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'AI Init - start timed list');
INSERT INTO `smart_scripts` VALUES (3684400, 9, 0, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Visible - true');
INSERT INTO `smart_scripts` VALUES (3684400, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 50142, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'cast emerge spell');
INSERT INTO `smart_scripts` VALUES (3684400, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 19, 512+256+4+2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'cast emerge spell');
INSERT INTO `smart_scripts` VALUES (3684400, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'attack start');

-- Deathspeaker Zealot (36808, 38076)
UPDATE creature_template SET faction=312, speed_walk=3.2, speed_run=1.71429, mindmg=2781, maxdmg=3791, attackpower=300, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=36808;
UPDATE creature_template SET faction=312, speed_walk=3.2, speed_run=1.71429, mindmg=2090, maxdmg=2850, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38076;
REPLACE INTO creature_template_addon VALUES(36808, 0, 0, 8, 1, 0, ''),(38076, 0, 0, 8, 1, 0, '');
DELETE FROM smart_scripts WHERE entryorguid IN(36808, 38076) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (36808, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 1500, 1500, 11, 69492, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadow Cleave');

-- Deathspeaker Attendant (36811, 38072)
UPDATE creature_template SET faction=312, speed_walk=3.2, speed_run=1.71429, mindmg=700, maxdmg=955, attackpower=300, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=36811;
UPDATE creature_template SET faction=312, speed_walk=3.2, speed_run=1.71429, mindmg=565, maxdmg=771, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38072;
REPLACE INTO creature_template_addon VALUES(36811, 0, 0, 8, 1, 0, ''),(38072, 0, 0, 8, 1, 0, '');
DELETE FROM smart_scripts WHERE entryorguid IN(36811, 38072) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (36811, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 3000, 5000, 11, 69387, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadow Bolt');
INSERT INTO `smart_scripts` VALUES (36811, 0, 1, 0, 0, 0, 100, 0, 5000, 15000, 10000, 20000, 11, 69355, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadow Nova');

-- Deathspeaker Disciple (36807, 38073)
UPDATE creature_template SET faction=312, speed_walk=3.2, speed_run=1.71429, mindmg=609, maxdmg=831, attackpower=300, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=36807;
UPDATE creature_template SET faction=312, speed_walk=3.2, speed_run=1.71429, mindmg=492, maxdmg=671, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38073;
REPLACE INTO creature_template_addon VALUES(36807, 0, 0, 0, 1, 468, ''),(38073, 0, 0, 0, 1, 468, '');
DELETE FROM smart_scripts WHERE entryorguid IN(36807, 38073) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (36807, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 3000, 5000, 11, 69387, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadow Bolt');
INSERT INTO `smart_scripts` VALUES (36807, 0, 1, 0, 0, 0, 100, 0, 3000, 10000, 10000, 20000, 11, 69391, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dark Blessing');
INSERT INTO `smart_scripts` VALUES (36807, 0, 2, 0, 0, 0, 100, 0, 15000, 20000, 15000, 30000, 11, 69389, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadow Mend');

-- Deathspeaker High Priest (36829, 38074)
UPDATE creature_template SET speed_walk=3.2, speed_run=1.71429, mindmg=3302, maxdmg=4508, attackpower=300, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=36829;
UPDATE creature_template SET speed_walk=3.2, speed_run=1.71429, mindmg=2614, maxdmg=3568, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38074;
DELETE FROM smart_scripts WHERE entryorguid IN(36829, 38074) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (36829, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 69491, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Aura of Darkness');
INSERT INTO `smart_scripts` VALUES (36829, 0, 1, 0, 7, 0, 100, 0, 0, 0, 0, 0, 28, 69491, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'remove Aura of Darkness on Evade');
INSERT INTO `smart_scripts` VALUES (36829, 0, 2, 0, 0, 0, 100, 0, 5000, 10000, 10000, 15000, 11, 69483, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Dark Reckoning');

-- formations and spawns of trash before Lady Deathwhisper (Deathspeaker ...)
DELETE FROM creature_formations WHERE leaderGUID IN ( SELECT guid FROM creature WHERE id IN(36805, 38075, 36808, 38076, 36811, 38072, 36807, 38073) AND `map`=631 );
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36805, 38075, 36808, 38076, 36811, 38072, 36807, 38073) AND `map`=631 );
DELETE FROM creature WHERE id IN(36805, 38075, 36808, 38076, 36811, 38072, 36807, 38073) AND `map`=631;
INSERT INTO `creature` VALUES (247130, 36805, 631, 5, 1, 0, 1, -586.007, 2195.24, 49.5599, 2.84489, 86400, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247131, 36811, 631, 5, 1, 0, 1, -603.898, 2190.53, 49.5599, 2.94961, 86400, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247132, 36807, 631, 5, 1, 0, 0, -601.689, 2202.71, 49.5599, 3.00197, 86400, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247133, 36808, 631, 5, 1, 0, 1, -587.632, 2189.23, 49.5599, 2.70526, 86400, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247134, 36808, 631, 5, 1, 0, 1, -602.313, 2196.07, 49.5599, 2.86234, 86400, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247135, 36805, 631, 5, 1, 0, 1, -584.639, 2227.7, 49.5599, 3.50811, 86400, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247136, 36808, 631, 5, 1, 0, 1, -599.837, 2226.17, 49.5599, 3.36849, 86400, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247137, 36808, 631, 5, 1, 0, 1, -588.281, 2234.63, 49.5599, 3.59538, 86400, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247138, 36811, 631, 5, 1, 0, 1, -602.946, 2232.54, 49.5599, 3.45575, 86400, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247139, 36807, 631, 5, 1, 0, 0, -597.285, 2218.56, 49.5599, 3.31613, 86400, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247140, 36805, 631, 10, 1, 0, 1, -585.323, 2195.45, 49.4765, 2.84315, 86400, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247141, 36805, 631, 10, 1, 0, 1, -584.135, 2227.3, 49.4765, 3.42827, 86400, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247142, 36807, 631, 10, 1, 0, 0, -602.636, 2188.35, 49.4773, 2.64679, 86400, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247143, 36807, 631, 10, 1, 0, 0, -597.752, 2219.24, 49.4773, 3.22799, 86400, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247144, 36807, 631, 10, 1, 0, 0, -599.562, 2203.02, 49.4773, 3.11803, 86400, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247145, 36807, 631, 10, 1, 0, 0, -602.285, 2233.38, 49.4773, 3.55785, 86400, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247146, 36808, 631, 10, 1, 0, 1, -587.394, 2189.35, 49.4765, 2.79602, 86400, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247147, 36808, 631, 10, 1, 0, 1, -600.638, 2197.71, 49.4765, 2.89419, 86400, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247148, 36808, 631, 10, 1, 0, 1, -598.693, 2224.66, 49.4765, 3.40471, 86400, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247149, 36808, 631, 10, 1, 0, 1, -586.554, 2233.34, 49.4765, 3.49895, 86400, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247150, 36811, 631, 10, 1, 0, 1, -601.172, 2193.04, 49.4767, 2.83136, 86400, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247151, 36811, 631, 10, 1, 0, 1, -568.841, 2226.69, 49.4765, 3.34187, 86400, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247152, 36811, 631, 10, 1, 0, 1, -583.485, 2201.45, 49.4767, 3.03164, 86400, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247153, 36811, 631, 10, 1, 0, 1, -582.587, 2221.2, 49.4767, 3.2437, 86400, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247154, 36811, 631, 10, 1, 0, 1, -600.416, 2229.5, 49.4767, 3.56178, 86400, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247155, 36811, 631, 10, 1, 0, 1, -569.411, 2196.92, 49.4765, 2.9963, 86400, 0, 0, 1, 0, 0, 0, 0, 0);
SET @frguid = 0;
INSERT INTO creature_formations SELECT @frguid := MIN(guid), MIN(guid), 0, 0, 5, 0, 0 FROM creature WHERE spawnmask=5 AND id IN(36805, 38075, 36808, 38076, 36811, 38072, 36807, 38073) AND position_y<2210.0 LIMIT 1;
INSERT INTO creature_formations SELECT @frguid, guid, 0, 0, 5, 0, 0 FROM creature WHERE guid<>@frguid AND spawnmask=5 AND id IN(36805, 38075, 36808, 38076, 36811, 38072, 36807, 38073) AND position_y<2210.0;
SET @frguid = 0;
INSERT INTO creature_formations SELECT @frguid := MIN(guid), MIN(guid), 0, 0, 5, 0, 0 FROM creature WHERE spawnmask=5 AND id IN(36805, 38075, 36808, 38076, 36811, 38072, 36807, 38073) AND position_y>2210.0 LIMIT 1;
INSERT INTO creature_formations SELECT @frguid, guid, 0, 0, 5, 0, 0 FROM creature WHERE guid<>@frguid AND spawnmask=5 AND id IN(36805, 38075, 36808, 38076, 36811, 38072, 36807, 38073) AND position_y>2210.0;
SET @frguid = 0;
INSERT INTO creature_formations SELECT @frguid := MIN(guid), MIN(guid), 0, 0, 5, 0, 0 FROM creature WHERE spawnmask=10 AND id IN(36805, 38075, 36808, 38076, 36811, 38072, 36807, 38073) AND position_y<2210.0 LIMIT 1;
INSERT INTO creature_formations SELECT @frguid, guid, 0, 0, 5, 0, 0 FROM creature WHERE guid<>@frguid AND spawnmask=10 AND id IN(36805, 38075, 36808, 38076, 36811, 38072, 36807, 38073) AND position_y<2210.0;
SET @frguid = 0;
INSERT INTO creature_formations SELECT @frguid := MIN(guid), MIN(guid), 0, 0, 5, 0, 0 FROM creature WHERE spawnmask=10 AND id IN(36805, 38075, 36808, 38076, 36811, 38072, 36807, 38073) AND position_y>2210.0 LIMIT 1;
INSERT INTO creature_formations SELECT @frguid, guid, 0, 0, 5, 0, 0 FROM creature WHERE guid<>@frguid AND spawnmask=10 AND id IN(36805, 38075, 36808, 38076, 36811, 38072, 36807, 38073) AND position_y>2210.0;


-- Skybreaker Dreadblade (37004, 38079)
REPLACE INTO creature_equip_template VALUES(37004, 1, 49708, 0, 0, 0);
UPDATE creature_template SET mindmg=2034, maxdmg=2774, attackpower=300, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=37004;
UPDATE creature_template SET mindmg=1641, maxdmg=2236, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38079;
DELETE FROM smart_scripts WHERE entryorguid IN(37004, 38079) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (37004, 0, 0, 0, 0, 0, 100, 0, 3000, 10000, 10000, 15000, 11, 69916, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Icy Touch');
INSERT INTO `smart_scripts` VALUES (37004, 0, 1, 0, 0, 0, 100, 0, 3000, 10000, 10000, 15000, 11, 69912, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Plague Strike');

-- Skybreaker Hierophant (37027, 38080)
UPDATE creature_template SET mindmg=1005, maxdmg=1370, attackpower=300, dmg_multiplier=7, AIName='', ScriptName='npc_icc_skybreaker_hierophant' WHERE entry=37027;
UPDATE creature_template SET mindmg=1005, maxdmg=1370, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38080;
DELETE FROM smart_scripts WHERE entryorguid IN(37027, 38080) AND source_type=0;

-- Skybreaker Protector (36998, 38082)
REPLACE INTO creature_equip_template VALUES(36998, 1, 49719, 49720, 0, 0);
UPDATE creature_template SET mindmg=1981, maxdmg=2701, attackpower=300, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=36998;
UPDATE creature_template SET mindmg=1354, maxdmg=1846, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38082;
DELETE FROM smart_scripts WHERE entryorguid IN(36998, 38082) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (36998, 0, 0, 0, 0, 0, 100, 0, 2000, 5000, 10000, 15000, 11, 69902, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Devastate');
INSERT INTO `smart_scripts` VALUES (36998, 0, 1, 0, 0, 0, 100, 0, 10000, 20000, 20000, 30000, 11, 69901, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spell Reflect');
INSERT INTO `smart_scripts` VALUES (36998, 0, 2, 0, 0, 0, 100, 0, 10000, 20000, 15000, 30000, 11, 69903, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shield Slam');
INSERT INTO `smart_scripts` VALUES (36998, 0, 3, 0, 0, 0, 100, 0, 10000, 20000, 15000, 30000, 11, 69965, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Thunderclap');

-- Skybreaker Marksman (37144, 38097)
REPLACE INTO creature_equip_template VALUES(37144, 1, 0, 0, 49761, 0);
UPDATE creature_template SET mindmg=1585, maxdmg=2164, attackpower=300, dmg_multiplier=7, minrangedmg=1585, maxrangedmg=2164, rangedattackpower=300, AIName='', ScriptName='npc_icc_skybreaker_marksman' WHERE entry=37144;
UPDATE creature_template SET mindmg=1284, maxdmg=1754, attackpower=300, dmg_multiplier=13, minrangedmg=1284, maxrangedmg=1754, rangedattackpower=300, AIName='', ScriptName='' WHERE entry=38097;
DELETE FROM smart_scripts WHERE entryorguid IN(37144, 38097) AND source_type=0;

-- Skybreaker Vicar (37021, 38085)
UPDATE creature_template SET mindmg=1563, maxdmg=2131, attackpower=300, dmg_multiplier=7, AIName='', ScriptName='npc_icc_skybreaker_vicar' WHERE entry=37021;
UPDATE creature_template SET mindmg=1264, maxdmg=1723, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38085;
DELETE FROM smart_scripts WHERE entryorguid IN(37021, 38085) AND source_type=0;

-- Skybreaker Luminary (37016, 38081)
UPDATE creature_template SET mindmg=1585, maxdmg=2164, attackpower=300, dmg_multiplier=7, AIName='', ScriptName='npc_icc_skybreaker_luminary' WHERE entry=37016;
UPDATE creature_template SET mindmg=1284, maxdmg=1754, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38081;
DELETE FROM smart_scripts WHERE entryorguid IN(37016, 38081) AND source_type=0;

-- Skybreaker Sorcerer (37026, 38083)
UPDATE creature_template SET mindmg=1589, maxdmg=2166, attackpower=300, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=37026;
UPDATE creature_template SET mindmg=1285, maxdmg=1752, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38083;
DELETE FROM smart_scripts WHERE entryorguid IN(37026, 38083) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (37026, 0, 0, 0, 0, 0, 100, 0, 2000, 5000, 3500, 4000, 11, 69869, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Frostfire Bolt');
INSERT INTO `smart_scripts` VALUES (37026, 0, 1, 0, 0, 0, 100, 0, 5000, 15000, 120000, 120000, 11, 69810, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Summon Skybreaker Battle Standard');

-- Skybreaker Battle Standard (37041)
UPDATE creature_template SET unit_flags=33554434, AIName='NullCreatureAI', ScriptName='' WHERE entry=37041;
REPLACE INTO creature_template_addon VALUES(37041, 0, 0, 0, 1, 0, "69808");

-- Skybreaker Summoner (37148, 38084)
UPDATE creature_template SET mindmg=752, maxdmg=1025, attackpower=300, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=37148;
UPDATE creature_template SET mindmg=527, maxdmg=719, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38084;
DELETE FROM smart_scripts WHERE entryorguid IN(37148, 38084) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (37148, 0, 0, 0, 0, 0, 100, 0, 3000, 10000, 10000, 20000, 11, 69969, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Curse of Doom');
INSERT INTO `smart_scripts` VALUES (37148, 0, 1, 0, 0, 0, 100, 0, 3000, 10000, 5000, 15000, 11, 69973, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Incinerate');
INSERT INTO `smart_scripts` VALUES (37148, 0, 2, 0, 0, 0, 100, 0, 1000, 3000, 3000, 3500, 11, 69972, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadow Bolt');

-- Skybreaker Vindicator (37003, 38086)
UPDATE creature_template SET mindmg=1791, maxdmg=2445, attackpower=300, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=37003;
UPDATE creature_template SET mindmg=1350, maxdmg=2000, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38086;
DELETE FROM smart_scripts WHERE entryorguid IN(37003, 38086) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (37003, 0, 0, 0, 0, 0, 100, 0, 3000, 10000, 10000, 20000, 11, 69927, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Avenger\'s Shield');
INSERT INTO `smart_scripts` VALUES (37003, 0, 1, 0, 0, 0, 100, 0, 6000, 15000, 10000, 20000, 11, 69930, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Consecration');
INSERT INTO `smart_scripts` VALUES (37003, 0, 2, 0, 0, 0, 100, 0, 6000, 15000, 10000, 20000, 11, 69934, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Holy Wrath');

-- Skybreaker Assassin (37017, 38078)
REPLACE INTO creature_equip_template VALUES(37017, 1, 49713, 49714, 0, 0);
UPDATE creature_template SET mindmg=2196, maxdmg=2997, attackpower=300, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=37017;
UPDATE creature_template SET mindmg=1424, maxdmg=1944, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38078;
DELETE FROM smart_scripts WHERE entryorguid IN(37017, 38078) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (37017, 0, 0, 0, 0, 0, 100, 0, 2000, 5000, 5000, 10000, 11, 69920, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sinister Strike');
INSERT INTO `smart_scripts` VALUES (37017, 0, 1, 0, 0, 0, 100, 0, 5000, 10000, 10000, 20000, 11, 69921, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fan of Knives');

-- Spire Gargoyle (37544, 38481)
UPDATE creature_template SET mindmg=1562, maxdmg=2131, attackpower=300, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=37544;
UPDATE creature_template SET mindmg=1262, maxdmg=1723, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38481;
DELETE FROM smart_scripts WHERE entryorguid IN(37544, 38481) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (37544, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 10000, 20000, 11, 70189, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Poison Spit');

-- Frenzied Abomination (37546, 38446)
UPDATE creature_template SET mindmg=4949, maxdmg=6747, attackpower=300, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=37546;
UPDATE creature_template SET mindmg=2923, maxdmg=3985, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38446;
DELETE FROM smart_scripts WHERE entryorguid IN(37546, 38446) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (37546, 0, 0, 0, 0, 0, 100, 0, 5000, 10000, 5000, 10000, 11, 70191, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cleave');
INSERT INTO `smart_scripts` VALUES (37546, 0, 1, 0, 0, 0, 100, 0, 30000, 45000, 60000, 60000, 11, 70371, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Enrage');

-- Spire Minion (37545, 38445)
UPDATE creature_template SET unit_flags=32832, mindmg=1544, maxdmg=2107, attackpower=300, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=37545;
UPDATE creature_template SET unit_flags=32832, mindmg=1249, maxdmg=1705, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38445;
DELETE FROM smart_scripts WHERE entryorguid IN(37545, 38445) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (37545, 0, 0, 0, 0, 0, 100, 0, 3000, 6000, 3000, 6000, 11, 70396, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ghoul Slash');

-- Kor'kron Vanquisher (37035, 38096)
UPDATE creature_template SET mindmg=1791, maxdmg=2445, attackpower=300, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=37035;
UPDATE creature_template SET mindmg=1350, maxdmg=2000, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38096;
DELETE FROM smart_scripts WHERE entryorguid IN(37035, 38096) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (37035, 0, 0, 0, 0, 0, 100, 0, 3000, 10000, 10000, 20000, 11, 69927, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Avenger\'s Shield');
INSERT INTO `smart_scripts` VALUES (37035, 0, 1, 0, 0, 0, 100, 0, 6000, 15000, 10000, 20000, 11, 69930, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Consecration');
INSERT INTO `smart_scripts` VALUES (37035, 0, 2, 0, 0, 0, 100, 0, 6000, 15000, 10000, 20000, 11, 69934, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Holy Wrath');

-- Kor'kron Primalist (37030, 38091)
UPDATE creature_template SET mindmg=1005, maxdmg=1370, attackpower=300, dmg_multiplier=7, AIName='', ScriptName='npc_icc_skybreaker_hierophant' WHERE entry=37030;
UPDATE creature_template SET mindmg=1005, maxdmg=1370, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38091;
DELETE FROM smart_scripts WHERE entryorguid IN(37030, 38091) AND source_type=0;

-- Kor'kron Invoker (37033, 38088)
UPDATE creature_template SET mindmg=1589, maxdmg=2166, attackpower=300, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=37033;
UPDATE creature_template SET mindmg=1285, maxdmg=1752, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38088;
DELETE FROM smart_scripts WHERE entryorguid IN(37033, 38088) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (37033, 0, 0, 0, 0, 0, 100, 0, 2000, 5000, 3500, 4000, 11, 69869, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Frostfire Bolt');
INSERT INTO `smart_scripts` VALUES (37033, 0, 1, 0, 0, 0, 100, 0, 5000, 15000, 120000, 120000, 11, 69811, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Summon Kor\'kron Battle Standard');

-- Kor'kron Battle Standard (37044)
UPDATE creature_template SET unit_flags=33554434, AIName='NullCreatureAI', ScriptName='' WHERE entry=37044;
REPLACE INTO creature_template_addon VALUES(37044, 0, 0, 0, 1, 0, "69809");

-- Kor'kron Oracle (37031, 38090)
UPDATE creature_template SET mindmg=1585, maxdmg=2164, attackpower=300, dmg_multiplier=7, AIName='', ScriptName='npc_icc_skybreaker_luminary' WHERE entry=37031;
UPDATE creature_template SET mindmg=1284, maxdmg=1754, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38090;
DELETE FROM smart_scripts WHERE entryorguid IN(37031, 38090) AND source_type=0;

-- Kor'kron Stalker (37028, 38094)
UPDATE creature_template SET difficulty_entry_1=38094, mindmg=2196, maxdmg=2997, attackpower=300, dmg_multiplier=7, AIName='SmartAI', ScriptName='', minlevel=82, maxlevel=82, `exp`=2, faction=83, unit_class=4, unit_flags=32832, dynamicflags=8 WHERE entry=37028;
REPLACE INTO creature_equip_template VALUES(38094, 1, 49734, 49735, 0, 0);
UPDATE creature_template SET mindmg=1424, maxdmg=1944, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='', minlevel=82, maxlevel=82, `exp`=2, faction=83, unit_class=4, unit_flags=32832, dynamicflags=8 WHERE entry=38094;
DELETE FROM smart_scripts WHERE entryorguid IN(37028, 38094) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (37028, 0, 0, 0, 0, 0, 100, 0, 2000, 5000, 5000, 10000, 11, 69920, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sinister Strike');
INSERT INTO `smart_scripts` VALUES (37028, 0, 1, 0, 0, 0, 100, 0, 5000, 10000, 10000, 20000, 11, 69921, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fan of Knives');

-- Kor'kron Defender (37032, 38087)
UPDATE creature_template SET mindmg=1981, maxdmg=2701, attackpower=300, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=37032;
UPDATE creature_template SET mindmg=1354, maxdmg=1846, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38087;
DELETE FROM smart_scripts WHERE entryorguid IN(37032, 38087) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (37032, 0, 0, 0, 0, 0, 100, 0, 2000, 5000, 10000, 15000, 11, 69902, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Devastate');
INSERT INTO `smart_scripts` VALUES (37032, 0, 1, 0, 0, 0, 100, 0, 10000, 20000, 20000, 30000, 11, 69901, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spell Reflect');
INSERT INTO `smart_scripts` VALUES (37032, 0, 2, 0, 0, 0, 100, 0, 10000, 20000, 15000, 30000, 11, 69903, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shield Slam');
INSERT INTO `smart_scripts` VALUES (37032, 0, 3, 0, 0, 0, 100, 0, 10000, 20000, 15000, 30000, 11, 69965, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Thunderclap');

-- Kor'kron Reaver (37029, 38092)
UPDATE creature_template SET mindmg=2034, maxdmg=2774, attackpower=300, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=37029;
UPDATE creature_template SET mindmg=1641, maxdmg=2236, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38092;
DELETE FROM smart_scripts WHERE entryorguid IN(37029, 38092) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (37029, 0, 0, 0, 0, 0, 100, 0, 3000, 10000, 10000, 15000, 11, 69916, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Icy Touch');
INSERT INTO `smart_scripts` VALUES (37029, 0, 1, 0, 0, 0, 100, 0, 3000, 10000, 10000, 15000, 11, 69912, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Plague Strike');

-- Kor'kron Sniper (37146, 38093)
UPDATE creature_template SET mindmg=1585, maxdmg=2164, attackpower=300, dmg_multiplier=7, minrangedmg=1585, maxrangedmg=2164, rangedattackpower=300, AIName='', ScriptName='npc_icc_skybreaker_marksman' WHERE entry=37146;
UPDATE creature_template SET mindmg=1284, maxdmg=1754, attackpower=300, dmg_multiplier=13, minrangedmg=1284, maxrangedmg=1754, rangedattackpower=300, AIName='', ScriptName='' WHERE entry=38093;
DELETE FROM smart_scripts WHERE entryorguid IN(37146, 38093) AND source_type=0;

-- Kor'kron Necrolyte (37149, 38089)
UPDATE creature_template SET mindmg=752, maxdmg=1025, attackpower=300, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=37149;
UPDATE creature_template SET mindmg=527, maxdmg=719, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38089;
DELETE FROM smart_scripts WHERE entryorguid IN(37149, 38089) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (37149, 0, 0, 0, 0, 0, 100, 0, 3000, 10000, 10000, 20000, 11, 69969, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Curse of Doom');
INSERT INTO `smart_scripts` VALUES (37149, 0, 1, 0, 0, 0, 100, 0, 3000, 10000, 5000, 15000, 11, 69973, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Incinerate');
INSERT INTO `smart_scripts` VALUES (37149, 0, 2, 0, 0, 0, 100, 0, 1000, 3000, 3000, 3500, 11, 69972, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadow Bolt');

-- Kor'kron Templar (37034, 38095)
UPDATE creature_template SET mindmg=1563, maxdmg=2131, attackpower=300, dmg_multiplier=7, AIName='', ScriptName='npc_icc_skybreaker_vicar' WHERE entry=37034;
UPDATE creature_template SET mindmg=1264, maxdmg=1723, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38095;
DELETE FROM smart_scripts WHERE entryorguid IN(37034, 38095) AND source_type=0;

-- Rotting Frost Giant (38490, 38494)
REPLACE INTO creature_onkill_reputation VALUES(38490, 1156, 0, 7, 0, 250, 0, 0, 0, 0);
REPLACE INTO creature_onkill_reputation VALUES(38494, 1156, 0, 7, 0, 250, 0, 0, 0, 0);
UPDATE creature_template SET mindmg=6211, maxdmg=8467, attackpower=300, dmg_multiplier=7, AIName='', mechanic_immune_mask=650854271, flags_extra=0+0x200000, ScriptName='npc_rotting_frost_giant' WHERE entry=38490;
UPDATE creature_template SET mindmg=3909, maxdmg=5329, attackpower=300, dmg_multiplier=13, AIName='', mechanic_immune_mask=650854271, flags_extra=0+0x200000, ScriptName='npc_rotting_frost_giant' WHERE entry=38494;
DELETE FROM smart_scripts WHERE entryorguid IN(37034, 38095) AND source_type=0;

-- Spire Frostwyrm (37230, 38444)
REPLACE INTO areatrigger_scripts VALUES(5628, 'at_icc_spire_frostwyrm'),(5629, 'at_icc_spire_frostwyrm'),(5630, 'at_icc_spire_frostwyrm'),(5631, 'at_icc_spire_frostwyrm');
UPDATE creature_template SET mindmg=4310, maxdmg=5883, attackpower=300, dmg_multiplier=8, AIName='', mingold=271134, maxgold=271134, InhabitType=1, HoverHeight=1, mechanic_immune_mask=650854271, flags_extra=0+0x200000, ScriptName='npc_icc_spire_frostwyrm' WHERE entry=37230;
UPDATE creature_template SET mindmg=3481, maxdmg=4752, attackpower=300, dmg_multiplier=15, AIName='', mingold=271134, maxgold=271134, InhabitType=1, HoverHeight=1,mechanic_immune_mask=650854271, flags_extra=0+0x200000, ScriptName='' WHERE entry=38444;
REPLACE INTO creature_template_addon VALUES(37230, 0, 0, 0, 1, 0, ''),(38444, 0, 0, 0, 1, 0, '');
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37230, 38444) AND `map`=631 );
DELETE FROM creature WHERE id IN(37230, 38444) AND `map`=631;
INSERT INTO `creature` VALUES (247156, 37230, 631, 15, 1, 0, 0, -436.632, 2079.14, 285.0, 2.72714, 604800, 0, 0, 5392400, 41690, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247157, 37230, 631, 15, 1, 0, 0, -436.92, 2344.80, 285.0, 2.72714, 604800, 0, 0, 5392400, 41690, 0, 0, 0, 0);
DELETE FROM creature_text WHERE entry=37230;
INSERT INTO creature_text VALUES(37230, 0, 0, 'A screeching cry pierces the air above!', 41, 0, 100, 0, 0, 0, 0, 'ICC Spire Frostwyrm START');
INSERT INTO creature_text VALUES(37230, 1, 0, 'A Spire Frostwyrm lands just before Orgrim\'s Hammer.', 16, 0, 100, 0, 0, 0, 0, 'Frostwyrm - SAY_FROSTWYRM_LAND_H_1');
INSERT INTO creature_text VALUES(37230, 2, 0, 'A Spire Frostwyrm lands just before The Skybreaker. ', 16, 0, 100, 0, 0, 0, 0, 'Frostwyrm - SAY_FROSTWYRM_LAND_A_1');
REPLACE INTO creature_onkill_reputation VALUES(37230, 1156, 0, 7, 0, 45, 0, 0, 0, 0),(38444, 1156, 0, 7, 0, 45, 0, 0, 0, 0);


-- Val'kyr Herald (37098, 38418)
UPDATE creature_template SET mindmg=3699, maxdmg=5043, attackpower=300, dmg_multiplier=7, AIName='', ScriptName='npc_icc_valkyr_herald', mechanic_immune_mask=650854271, flags_extra=1+0x200000 WHERE entry=37098;
UPDATE creature_template SET mindmg=2836, maxdmg=3867, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='', mechanic_immune_mask=650854271, flags_extra=1+0x200000 WHERE entry=38418;
DELETE FROM smart_scripts WHERE entryorguid IN(37098, 38418) AND source_type=0;

-- Severed Essence (38410, 38419)
UPDATE creature_template SET mindmg=414, maxdmg=563, attackpower=300, dmg_multiplier=7, AIName='', ScriptName='npc_icc_severed_essence' WHERE entry=38410;
UPDATE creature_template SET mindmg=470, maxdmg=641, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38419;
DELETE FROM smart_scripts WHERE entryorguid IN(38410, 38419) AND source_type=0;

-- Blighted Abomination (37022, 38108)
UPDATE creature_template SET mindmg=2295, maxdmg=3129, attackpower=300, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=37022;
UPDATE creature_template SET mindmg=1613, maxdmg=2200, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38108;
DELETE FROM smart_scripts WHERE entryorguid IN(37022, 38108) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (37022, 0, 0, 0, 0, 0, 100, 0, 2000, 3000, 2000, 3000, 11, 40504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cleave');
INSERT INTO `smart_scripts` VALUES (37022, 0, 1, 0, 0, 0, 100, 0, 10000, 20000, 20000, 30000, 11, 71150, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Plague Cloud');
INSERT INTO `smart_scripts` VALUES (37022, 0, 2, 0, 0, 0, 100, 0, 3000, 5000, 15000, 25000, 11, 71140, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Scourge Hook');
DELETE FROM creature_formations WHERE leaderGUID IN( SELECT guid FROM creature WHERE id IN(37022, 38108) AND `map`=631 );
SET @frguid = 0;
INSERT INTO creature_formations SELECT @frguid := MIN(guid), MIN(guid), 0, 0, 5, 0, 0 FROM creature WHERE id IN(37022, 38108) AND `map`=631 LIMIT 1;
INSERT INTO creature_formations SELECT @frguid, guid, 0, 0, 5, 0, 0 FROM creature WHERE guid<>@frguid AND id IN(37022, 38108) AND `map`=631;

-- Plague Scientist (37023, 38062)
UPDATE creature_template SET mindmg=1281, maxdmg=1744, attackpower=300, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=37023;
UPDATE creature_template SET mindmg=1020, maxdmg=1388, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38062;
DELETE FROM smart_scripts WHERE entryorguid IN(37023, 38062) AND source_type=0;
UPDATE creature SET spawndist=10, MovementType=1 WHERE id IN(37023, 38062);
INSERT INTO `smart_scripts` VALUES (37023, 0, 0, 0, 0, 0, 100, 0, 10000, 20000, 20000, 30000, 11, 71103, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Combobulating Spray');
INSERT INTO `smart_scripts` VALUES (37023, 0, 1, 0, 0, 0, 100, 0, 2000, 3000, 3000, 4000, 11, 73079, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Plague Blast');
INSERT INTO `smart_scripts` VALUES (37023, 0, 2, 0, 0, 0, 100, 0, 15000, 40000, 60000, 60000, 11, 69871, 0, 0, 0, 0, 0, 19, 0, 70, 0, 0, 0, 0, 0, 'Plague Stream');

-- Vengeful Fleshreaper (37038, 38063)
UPDATE creature_template SET speed_run=1.5, mindmg=698, maxdmg=950, attackpower=300, dmg_multiplier=7, AIName='', MovementType=0, ScriptName='npc_icc_vengeful_fleshreaper' WHERE entry=37038;
UPDATE creature_template SET speed_run=1.5, mindmg=665, maxdmg=905, attackpower=300, dmg_multiplier=13, AIName='', MovementType=0, ScriptName='' WHERE entry=38063;
DELETE FROM smart_scripts WHERE entryorguid IN(37038, 38063) AND source_type=0;
-- INSERT INTO `smart_scripts` VALUES (37038, 0, 0, 0, 0, 0, 100, 0, 2000, 20000, 30000, 45000, 11, 71164, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Leaping Face Maul');
DELETE FROM creature_formations WHERE leaderGUID IN( SELECT guid FROM creature WHERE id IN(37038, 38063) AND `map`=631 );
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37038, 38063) AND `map`=631 );
DELETE FROM creature WHERE id IN(37038, 38063) AND `map`=631;
INSERT INTO `creature` VALUES (247158, 37038, 631, 15, 1, 0, 0, 4432.21, 3041.5, 372.783, 0.017569, 86400, 0, 0, 157500, 3994, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247159, 37038, 631, 15, 1, 0, 0, 4370.50, 3042.00, 372.80, 6.28249, 86400, 0, 0, 157500, 3994, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247160, 37038, 631, 15, 1, 0, 0, 4362.38, 2973.65, 360.593, 1.78024, 86400, 0, 0, 157500, 3994, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247161, 37038, 631, 15, 1, 0, 0, 4360.74, 2982.07, 360.594, 1.79769, 86400, 0, 0, 157500, 3994, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247162, 37038, 631, 15, 1, 0, 0, 4354.11, 2978.2, 360.594, 1.43117, 86400, 0, 0, 157500, 3994, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247163, 37038, 631, 15, 1, 0, 0, 4367.48, 2981.01, 360.594, 2.09439, 86400, 0, 0, 157500, 3994, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247164, 37038, 631, 15, 1, 0, 0, 4349.42, 2975.74, 360.594, 1.25664, 86400, 0, 0, 157500, 3994, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247165, 37038, 631, 15, 1, 0, 0, 4351.86, 2968.19, 360.594, 1.41372, 86400, 0, 0, 157500, 3994, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247166, 37038, 631, 15, 1, 0, 0, 4350.48, 2981.3, 360.594, 1.22173, 86400, 0, 0, 157500, 3994, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247167, 37038, 631, 15, 1, 0, 0, 4367.34, 2975.84, 360.593, 1.98968, 86400, 0, 0, 157500, 3994, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247168, 37038, 631, 15, 1, 0, 0, 4360.16, 2968.68, 360.593, 1.67552, 86400, 0, 0, 157500, 3994, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247169, 37038, 631, 15, 1, 0, 0, 4359.92, 2977.67, 360.593, 1.71042, 86400, 0, 0, 157500, 3994, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247170, 37038, 631, 15, 1, 0, 0, 4365.53, 2969.55, 360.593, 1.85005, 86400, 0, 0, 157500, 3994, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247171, 37038, 631, 15, 1, 0, 0, 4355.23, 2972.15, 360.593, 1.51844, 86400, 0, 0, 157500, 3994, 0, 0, 0, 0);
INSERT INTO creature_addon SELECT MIN(guid), 3703800, 0, 0, 1, 0, '' FROM creature WHERE id=37038 AND position_z<361.0 LIMIT 1;
SET @frguid = 0;
SET @dist = 2;
SET @angle = 0;
INSERT INTO creature_formations SELECT @frguid := MIN(guid), MIN(guid), 0, 0, 1, 0, 0 FROM creature WHERE id=37038 AND position_z<361.0 LIMIT 1;
INSERT INTO creature_formations SELECT @frguid, guid, @dist := @dist+0.5, (@angle := @angle+95) mod 360, 1, 0, 0 FROM creature WHERE guid<>@frguid AND id=37038 AND position_z<361.0;
UPDATE creature SET MovementType=0 WHERE id IN(37038, 38063);
UPDATE creature SET MovementType=2 WHERE guid=@frguid AND id IN(37038, 38063);
DELETE FROM waypoint_data WHERE id=3703800;
INSERT INTO `waypoint_data` VALUES (3703800, 1, 4373.9, 2970.51, 360.51, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3703800, 2, 4385.58, 2960.29, 357.923, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3703800, 3, 4392.1, 2947.36, 355.422, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3703800, 4, 4393.52, 2934.85, 352.988, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3703800, 5, 4388.93, 2916.19, 351.085, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3703800, 6, 4372.42, 2903.83, 351.099, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3703800, 7, 4343.87, 2900.88, 351.099, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3703800, 8, 4327.31, 2912.05, 351.088, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3703800, 9, 4322.21, 2925.73, 351.117, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3703800, 10, 4320.42, 2942.64, 354.269, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3703800, 11, 4327.39, 2958.91, 357.721, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3703800, 12, 4339.94, 2969.67, 360.49, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3703800, 13, 4363.25, 2974.16, 360.511, 0, 0, 1, 0, 100, 0);
DELETE FROM creature_text WHERE entry=37038;
INSERT INTO `creature_text` VALUES (37038, 0, 0, 'Quickly! We''ll ambush them from behind!', 14, 0, 100, 0, 0, 16924, 0, 'Vengeful Fleshreaper - Geist Alarm activated');
INSERT INTO `creature_text` VALUES (37038, 0, 1, 'The living... here?!', 14, 0, 100, 0, 0, 16925, 0, 'Vengeful Fleshreaper - Geist Alarm activated');
INSERT INTO `creature_text` VALUES (37038, 0, 2, 'You... cannot escape us!', 14, 0, 100, 0, 0, 16923, 0, 'Vengeful Fleshreaper - Geist Alarm activated');

-- Pustulating Horror (10404, 38110)
UPDATE creature_template SET mindmg=698, maxdmg=950, attackpower=300, dmg_multiplier=7, AIName='SmartAI', ScriptName='', mechanic_immune_mask=650854271, flags_extra=0+0x200000 WHERE entry=10404;
UPDATE creature_template SET mindmg=665, maxdmg=905, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='', mechanic_immune_mask=650854271, flags_extra=0+0x200000 WHERE entry=38110;
DELETE FROM smart_scripts WHERE entryorguid IN(10404, 38110) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (10404, 0, 0, 0, 0, 0, 100, 0, 5000, 15000, 10000, 15000, 11, 71089, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Bubbling Pus');
INSERT INTO `smart_scripts` VALUES (10404, 0, 1, 0, 2, 0, 100, 1, 1, 15, 60000, 60000, 11, 71088, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blight Bomb');

-- Decaying Colossus (36880, 37655)
UPDATE creature_template SET speed_walk=1.65, mindmg=6432, maxdmg=8769, attackpower=300, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=36880;
UPDATE creature_template SET speed_walk=1.65, mindmg=5193, maxdmg=7079, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=37655;
DELETE FROM smart_scripts WHERE entryorguid IN(36880, 37655) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (36880, 0, 0, 0, 0, 0, 100, 0, 5000, 15000, 10000, 20000, 11, 71114, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Massive Stomp');
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36880, 37655) AND `map`=631 );
REPLACE INTO creature_template_addon VALUES(36880, 3688000, 0, 0, 1, 0, ''),(37655, 3688000, 0, 0, 1, 0, '');
UPDATE creature SET MovementType=2 WHERE id IN(36880, 37655);
DELETE FROM waypoint_data WHERE id=3688000 AND ( (point=1 AND position_x=4356.75) OR (point=2 AND position_x=4356.75) );
INSERT INTO waypoint_data VALUES(3688000, 1, 4356.75, 2978.96, 360.51, 4.75, 7000, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES(3688000, 2, 4356.75, 3061.83, 360.52, 4.75, 7000, 0, 0, 100, 0);

-- Darkfallen Tactician (37666, 38479)
UPDATE creature_template SET mindmg=1563, maxdmg=2132, attackpower=300, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=37666;
UPDATE creature_template SET mindmg=1263, maxdmg=1722, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38479;
DELETE FROM smart_scripts WHERE entryorguid IN(37666, 38479) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (37666, 0, 0, 0, 0, 0, 100, 0, 5000, 15000, 10000, 20000, 11, 70432, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 'Blood Sap');
INSERT INTO `smart_scripts` VALUES (37666, 0, 1, 0, 0, 0, 100, 0, 15000, 20000, 15000, 25000, 11, 70431, 0, 0, 0, 0, 0, 17, 11, 39, 1, 0, 0, 0, 0, 'Shadowstep');
INSERT INTO `smart_scripts` VALUES (37666, 0, 2, 0, 0, 0, 100, 0, 3000, 6000, 5000, 5000, 11, 70437, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Unholy Strike');
INSERT INTO `smart_scripts` VALUES (37666, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 19, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'call for help upon entering combat');

-- Darkfallen Lieutenant (37665, 38101)
UPDATE creature_template SET mindmg=1563, maxdmg=2132, attackpower=300, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=37665;
UPDATE creature_template SET mindmg=1263, maxdmg=1722, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38101;
DELETE FROM smart_scripts WHERE entryorguid IN(37665, 38101) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (37665, 0, 0, 0, 0, 0, 100, 0, 2000, 4000, 8000, 8000, 11, 70423, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Vampiric Curse');
INSERT INTO `smart_scripts` VALUES (37665, 0, 1, 0, 0, 0, 100, 0, 5000, 5000, 5000, 5000, 11, 70435, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rend Flesh');
INSERT INTO `smart_scripts` VALUES (37665, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 19, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'call for help upon entering combat');

-- Darkfallen Archmage (37664, 38099)
UPDATE creature_template SET mindmg=1563, maxdmg=2132, attackpower=300, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=37664;
UPDATE creature_template SET mindmg=1263, maxdmg=1722, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38099;
DELETE FROM smart_scripts WHERE entryorguid IN(37664, 38099, -201482) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (37664, 0, 0, 0, 0, 0, 100, 0, 8000, 10000, 15000, 20000, 11, 70408, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Amplify Magic');
INSERT INTO `smart_scripts` VALUES (37664, 0, 1, 0, 0, 0, 100, 0, 6000, 8000, 12000, 15000, 11, 70407, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Blast Wave');
INSERT INTO `smart_scripts` VALUES (37664, 0, 2, 0, 0, 0, 100, 0, 2000, 4000, 8000, 10000, 11, 70409, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fireball');
INSERT INTO `smart_scripts` VALUES (37664, 0, 3, 0, 0, 0, 100, 0, 6000, 10000, 16000, 20000, 11, 70410, 0, 0, 0, 0, 0, 17, 14, 29, 1, 0, 0, 0, 0, 'Polymorph');
INSERT INTO `smart_scripts` VALUES (37664, 0, 4, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 19, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'call for help upon entering combat');
INSERT INTO `smart_scripts` VALUES (37664, 0, 5, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 70299, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Archmage - On Aggro - Cast Siphon Essence');
INSERT INTO `smart_scripts` VALUES (37664, 0, 6, 0, 6, 0, 100, 0, 0, 0, 0, 0, 104, 0, 0, 0, 0, 0, 0, 20, 201741, 40, 0, 0, 0, 0, 0, 'Darkfallen Archmage - On Death - Set GO Flags');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND sourceEntry=37664;
INSERT INTO conditions VALUES(22, 6, 37664, 0, 0, 29, 0, 38463, 20, 0, 0, 0, 0, "", "Requires Empowering Orb Visual Stalker In Range");
INSERT INTO `smart_scripts` VALUES (-201482, 0, 0, 0, 0, 0, 100, 0, 8000, 10000, 15000, 20000, 11, 70408, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Amplify Magic');
INSERT INTO `smart_scripts` VALUES (-201482, 0, 1, 0, 0, 0, 100, 0, 6000, 8000, 12000, 15000, 11, 70407, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Blast Wave');
INSERT INTO `smart_scripts` VALUES (-201482, 0, 2, 0, 0, 0, 100, 0, 2000, 4000, 8000, 10000, 11, 70409, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fireball');
INSERT INTO `smart_scripts` VALUES (-201482, 0, 3, 0, 0, 0, 100, 0, 6000, 10000, 16000, 20000, 11, 70410, 0, 0, 0, 0, 0, 17, 14, 29, 1, 0, 0, 0, 0, 'Polymorph');
INSERT INTO `smart_scripts` VALUES (-201482, 0, 4, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 19, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'call for help upon entering combat');
INSERT INTO `smart_scripts` VALUES (-201482, 0, 5, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 70299, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Archmage - On Aggro - Cast Siphon Essence');
INSERT INTO `smart_scripts` VALUES (-201482, 0, 6, 7, 6, 0, 100, 0, 0, 0, 0, 0, 104, 0, 0, 0, 0, 0, 0, 20, 201741, 40, 0, 0, 0, 0, 0, 'Darkfallen Archmage - On Death - Set GO Flags');
INSERT INTO `smart_scripts` VALUES (-201482, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 34, 300, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Archmage - On Death - Set Instance Data 300 to 1');

-- SPELL Orb Controller - Activate (70293)
-- SPELL Siphon Essence (70299)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND sourceEntry IN(70293, 70299);
INSERT INTO conditions VALUES(13, 1, 70293, 0, 0, 31, 0, 3, 38463, 0, 0, 0, 0, "", "Target Empowering Orb Visual Stalker");
INSERT INTO conditions VALUES(13, 1, 70299, 0, 0, 31, 0, 3, 38463, 0, 0, 0, 0, "", "Target Empowering Orb Visual Stalker");

-- SPELL Empowered Blood (70227)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND sourceEntry=70227;
INSERT INTO conditions VALUES(13, 2, 70227, 0, 0, 31, 0, 3, 38463, 0, 0, 0, 0, "", "Target Empowering Orb Visual Stalker");
DELETE FROM spell_linked_spell WHERE spell_trigger=70227;
INSERT INTO spell_linked_spell VALUES (70227, 70232, 1, 'Empowered Blood Second Aura');

-- Empowering Orb Controller Stalker (36934)
UPDATE creature_template SET flags_extra=128, AIName='', ScriptName='' WHERE entry=36934;

-- Empowering Orb Visual Stalker (38463)
UPDATE creature SET spawntimesecs=14*86400 WHERE id=38463;
UPDATE creature_template SET flags_extra=128, AIName='SmartAI', ScriptName='' WHERE entry=38463;
DELETE FROM smart_scripts WHERE entryorguid=38463 AND source_type=0;
INSERT INTO smart_scripts VALUES (38463, 0, 0, 0, 8, 0, 100, 0, 70293, 0, 0, 0, 85, 70227, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Empowering Orb Visual Stalker - Spell Hit - Invoker Cast Empowered Blood');
INSERT INTO smart_scripts VALUES (38463, 0, 1, 2, 8, 0, 100, 0, 70227, 0, 0, 0, 41, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Empowering Orb Visual Stalker - Spell Hit - Despawn');
INSERT INTO smart_scripts VALUES (38463, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 20, 201741, 20, 0, 0, 0, 0, 0, 'Empowering Orb Visual Stalker - Spell Hit - Set GO Loot State Just Deactivated');
INSERT INTO smart_scripts VALUES (38463, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 20, 201741, 20, 0, 0, 0, 0, 0, 'Empowering Orb Visual Stalker - Spell Hit - Set GO Loot State Just Deactivated');

-- GO Empowering Blood Orb (201741)
UPDATE gameobject SET spawntimesecs=14*86400 WHERE id=201741;
UPDATE gameobject_template SET data3=60000, data5=1 WHERE entry=201741;

-- Darkfallen Noble (37663, 38480)
UPDATE creature_template SET mindmg=1563, maxdmg=2132, attackpower=300, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=37663;
UPDATE creature_template SET mindmg=1263, maxdmg=1722, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38480;
DELETE FROM smart_scripts WHERE entryorguid IN(37663, 38480, -201659) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (37663, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 5000, 5000, 11, 72960, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadow Bolt');
INSERT INTO `smart_scripts` VALUES (37663, 0, 1, 0, 0, 0, 100, 0, 10000, 15000, 15000, 15000, 11, 70645, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 'Chains of Shadow');
INSERT INTO `smart_scripts` VALUES (37663, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 19, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'call for help upon entering combat');
INSERT INTO `smart_scripts` VALUES (-201659, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 5000, 5000, 11, 72960, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadow Bolt');
INSERT INTO `smart_scripts` VALUES (-201659, 0, 1, 0, 0, 0, 100, 0, 10000, 15000, 15000, 15000, 11, 70645, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 'Chains of Shadow');
INSERT INTO `smart_scripts` VALUES (-201659, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 19, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'call for help upon entering combat');
INSERT INTO `smart_scripts` VALUES (-201659, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 34, 300, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Noble - On Death - Set Instance Data 300 to 1');

-- Darkfallen Commander (37662, 38102)
UPDATE creature_template SET mindmg=1563, maxdmg=2132, attackpower=300, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=37662;
UPDATE creature_template SET mindmg=1263, maxdmg=1722, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38102;
DELETE FROM smart_scripts WHERE entryorguid IN(37662, 38102) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (37662, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 12000, 12000, 11, 70750, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Battle Shout');
INSERT INTO `smart_scripts` VALUES (37662, 0, 1, 0, 0, 0, 100, 0, 4000, 4000, 20000, 20000, 11, 70449, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 'Vampire Rush');
INSERT INTO `smart_scripts` VALUES (37662, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 19, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'call for help upon entering combat');

-- Darkfallen Blood Knight (37595, 38100)
UPDATE creature_template SET mindmg=1563, maxdmg=2132, attackpower=300, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=37595;
UPDATE creature_template SET mindmg=1263, maxdmg=1722, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38100;
DELETE FROM smart_scripts WHERE entryorguid IN(37595, 38100, -201646) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (37595, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 5000, 5000, 11, 70437, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Unholy Strike');
INSERT INTO `smart_scripts` VALUES (37595, 0, 1, 0, 0, 0, 100, 0, 0, 0, 20000, 20000, 11, 71736, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vampiric Aura');
-- INSERT INTO `smart_scripts` VALUES (37595, 2, 0, 0, 0, 0, 100, 0, 1000, 1000, 12000, 12000, 11, 70450, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Blood Mirror');
INSERT INTO `smart_scripts` VALUES (37595, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 19, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'call for help upon entering combat');
INSERT INTO `smart_scripts` VALUES (-201646, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 5000, 5000, 11, 70437, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Unholy Strike');
INSERT INTO `smart_scripts` VALUES (-201646, 0, 1, 0, 0, 0, 100, 0, 0, 0, 20000, 20000, 11, 71736, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vampiric Aura');
-- INSERT INTO `smart_scripts` VALUES (-201646, 2, 0, 0, 0, 0, 100, 0, 1000, 1000, 12000, 12000, 11, 70450, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Blood Mirror');
INSERT INTO `smart_scripts` VALUES (-201646, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 19, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'call for help upon entering combat');
INSERT INTO `smart_scripts` VALUES (-201646, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 34, 300, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Blood Knight - On Death - Set Instance Data 300 to 1');

-- Darkfallen Advisor (37571, 38098)
UPDATE creature_template SET mindmg=1563, maxdmg=2132, attackpower=300, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=37571;
UPDATE creature_template SET mindmg=1263, maxdmg=1722, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38098;
DELETE FROM smart_scripts WHERE entryorguid IN(37571, 38098, -201479) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (37571, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 10000, 12000, 11, 72057, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lich Slap');
INSERT INTO `smart_scripts` VALUES (37571, 0, 1, 0, 14, 0, 100, 0, 200000, 39, 8000, 8000, 11, 72065, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Shroud of Protection');
INSERT INTO `smart_scripts` VALUES (37571, 0, 2, 0, 14, 0, 100, 0, 200000, 39, 8000, 8000, 11, 72066, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Shroud of Spell Warding');
INSERT INTO `smart_scripts` VALUES (37571, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 19, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'call for help upon entering combat');
INSERT INTO `smart_scripts` VALUES (-201479, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 10000, 12000, 11, 72057, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lich Slap');
INSERT INTO `smart_scripts` VALUES (-201479, 0, 1, 0, 14, 0, 100, 0, 200000, 39, 8000, 8000, 11, 72065, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Shroud of Protection');
INSERT INTO `smart_scripts` VALUES (-201479, 0, 2, 0, 14, 0, 100, 0, 200000, 39, 8000, 8000, 11, 72066, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Shroud of Spell Warding');
INSERT INTO `smart_scripts` VALUES (-201479, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 19, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'call for help upon entering combat');
INSERT INTO `smart_scripts` VALUES (-201479, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 34, 300, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Advisor - On Death - Set Instance Data 300 to 1');

-- Frost Freeze Trap (37744)
UPDATE creature SET modelid=11686 WHERE id=37744;
UPDATE creature_template SET faction=14, unit_flags=33554432, AIName='', flags_extra=128, ScriptName='npc_frost_freeze_trap' WHERE entry=37744;

-- Rope Beam Stalker (37231)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37231) AND `map`=631 );
DELETE FROM creature WHERE id IN(37231) AND `map`=631;

-- Muradin Bronzebeard (37200), Muradin Bronzebeard (38607)
DELETE FROM creature_text WHERE entry IN(37200, 38607);
INSERT INTO creature_text VALUES (37200, 0, 0, 'Let''s get a move on then! Move ou...', 14, 0, 0, 0, 0, 16974, 0, 'Muradin Bronzebeard - SAY_INTRO_ALLIANCE_1');
INSERT INTO creature_text VALUES (37200, 1, 0, 'A lone orc against the might of the Alliance???', 14, 0, 0, 0, 0, 16970, 0, 'Muradin Bronzebeard - SAY_INTRO_ALLIANCE_4');
INSERT INTO creature_text VALUES (37200, 2, 0, 'Charge!!!', 14, 0, 0, 0, 0, 16971, 0, 'Muradin Bronzebeard - SAY_INTRO_ALLIANCE_5');
INSERT INTO creature_text VALUES (37200, 3, 0, '%s gasps for air.', 16, 0, 0, 0, 0, 16975, 0, 'Muradin Bronzebeard - SAY_OUTRO_ALLIANCE_1');
INSERT INTO creature_text VALUES (37200, 4, 0, 'That was Saurfang''s boy - the Horde commander at the Wrath Gate. Such a tragic end...', 12, 0, 0, 0, 0, 16976, 0, 'Muradin Bronzebeard - SAY_OUTRO_ALLIANCE_2');
INSERT INTO creature_text VALUES (37200, 5, 0, 'What in the... There, in the distance!', 12, 0, 0, 0, 0, 16977, 0, 'Muradin Bronzebeard - SAY_OUTRO_ALLIANCE_3');
INSERT INTO creature_text VALUES (37200, 6, 0, 'A Horde Zeppelin flies up to the rise.', 16, 0, 0, 0, 0, 0, 0, 'Muradin Bronzebeard - SAY_OUTRO_ALLIANCE_4');
INSERT INTO creature_text VALUES (37200, 7, 0, 'Soldiers, fall in! Looks like the Horde are comin'' to take another shot!', 14, 0, 0, 0, 0, 16978, 0, 'Muradin Bronzebeard - SAY_OUTRO_ALLIANCE_5');
INSERT INTO creature_text VALUES (37200, 8, 0, 'The Zeppelin docks, and High Overlord Saurfang hops out, confronting the Alliance soldiers and Muradin', 16, 0, 0, 0, 0, 0, 0, 'Muradin Bronzebeard - SAY_OUTRO_ALLIANCE_6');
INSERT INTO creature_text VALUES (37200, 9, 0, 'Don''t force me hand, orc. We can''t let ye pass.', 12, 0, 0, 0, 0, 16972, 0, 'Muradin Bronzebeard - SAY_OUTRO_ALLIANCE_7');
INSERT INTO creature_text VALUES (37200, 10, 0, 'I... I can''t do it. Get back on yer ship and we''ll spare yer life.', 12, 0, 0, 0, 0, 16973, 0, 'Muradin Bronzebeard - SAY_OUTRO_ALLIANCE_9');
INSERT INTO creature_text VALUES (37200, 11, 0, 'A mage portal from Stormwind appears between the two and Varian Wrynn and Jaina Proudmoore emerge.', 16, 0, 0, 0, 0, 0, 0, 'Muradin Bronzebeard - SAY_OUTRO_ALLIANCE_10');
INSERT INTO creature_text VALUES (37200, 12, 0, 'Right away, yer majesty!', 12, 0, 0, 0, 0, 16979, 0, 'Muradin Bronzebeard - SAY_OUTRO_ALLIANCE_21');
INSERT INTO creature_text VALUES (38607, 0, 0, 'Oh, lad...', 12, 0, 100, 396, 0, 17421, 0, 'Muradin Bronzebeard');
INSERT INTO creature_text VALUES (38607, 1, 0, 'How I miss those endless days in Lordaeron...', 12, 0, 100, 396, 0, 17422, 0, 'Muradin Bronzebeard');
INSERT INTO creature_text VALUES (38607, 2, 0, '...sharpenin'' yer skill with this dull blade...', 12, 0, 100, 396, 0, 17423, 0, 'Muradin Bronzebeard');
INSERT INTO creature_text VALUES (38607, 3, 0, '...forgin'' ya into a weapon meant to withstand the demands of a great destiny.', 12, 0, 100, 396, 0, 17424, 0, 'Muradin Bronzebeard');
INSERT INTO creature_text VALUES (38607, 4, 0, 'Heh... Yeh sure put them skills ta use, didn''t yeh, lad?', 12, 0, 100, 6, 0, 17425, 0, 'Muradin Bronzebeard');
INSERT INTO creature_text VALUES (38607, 5, 0, 'If only I''da been able ta stop yeh that day, how different things mighta been.', 12, 0, 100, 396, 0, 17426, 0, 'Muradin Bronzebeard');
INSERT INTO creature_text VALUES (38607, 6, 0, 'If only I''da never discovered that accursed blade...', 12, 0, 100, 396, 0, 17427, 0, 'Muradin Bronzebeard');
INSERT INTO creature_text VALUES (38607, 7, 0, 'Farewell, Arthas... my brother.', 12, 0, 100, 396, 0, 17428, 0, 'Muradin Bronzebeard');
INSERT INTO creature_text VALUES (38607, 13, 0, 'Could it be, Lord Fordring? If Bolvar lives, mayhap there is hope fer peace between the Alliance and the Horde. We must reach the top o'' this cursed place and free the paladin!', 12, 0, 0, 6, 0, 16980, 0, 'Muradin Bronzebeard Dummy - SAY_SAURFANG_INTRO_2');
INSERT INTO creature_text VALUES (38607, 14, 0, 'Prepare the Skybreaker fer an aerial assault on the citadel!', 14, 0, 0, 5, 0, 16981, 0, 'Muradin Bronzebeard Dummy - SAY_SAURFANG_INTRO_3');
INSERT INTO creature_text VALUES (38607, 15, 0, 'Heroes, ye must fight yer way to a clear extraction point within Icecrown. We''ll try an'' rendezvous on the ramparts!', 14, 0, 0, 22, 0, 16982, 0, 'Muradin Bronzebeard Dummy - SAY_SAURFANG_INTRO_4');
DELETE FROM creature WHERE id IN(37200, 38607) AND map=631;
UPDATE creature_template SET minlevel=83, maxlevel=83, exp=2, faction=35, speed_run=1.714286, rank=3, npcflag=2, unit_flags=33600, type=7, type_flags=12, AIName='SmartAI', ScriptName='' WHERE entry=38607;
REPLACE INTO creature_equip_template VALUES(38607, 1, 49775, 49774, 0, 0);

-- High Overlord Saurfang (37187), High Overlord Saurfang (32315)
DELETE FROM creature_text WHERE entry IN(37187, 32315);
INSERT INTO creature_text VALUES (37187, 0, 0, 'Kor''kron, move out! Champions, watch your backs. The Scourge have been...', 14, 0, 0, 22, 0, 17103, 0, 'High Overlord Saurfang - SAY_INTRO_HORDE_1');
INSERT INTO creature_text VALUES (37187, 1, 0, 'My boy died at the Wrath Gate. I am here only to collect his body.', 12, 0, 0, 397, 0, 17097, 0, 'High Overlord Saurfang - SAY_INTRO_HORDE_3');
INSERT INTO creature_text VALUES (37187, 2, 0, 'We named him Dranosh. It means "Heart of Draenor" in orcish. I would not let the warlocks take him. My boy would be safe, hidden away by the elders of Garadar.', 12, 0, 0, 1, 0, 17098, 0, 'High Overlord Saurfang - SAY_INTRO_HORDE_5');
INSERT INTO creature_text VALUES (37187, 3, 0, 'I made a promise to his mother before she died; that I would cross the Dark Portal alone - whether I lived or died, my son would be safe. Untainted...', 12, 0, 0, 1, 0, 17099, 0, 'High Overlord Saurfang - SAY_INTRO_HORDE_6');
INSERT INTO creature_text VALUES (37187, 4, 0, 'Today, I fulfill that promise.', 12, 0, 0, 397, 0, 17100, 0, 'High Overlord Saurfang - SAY_INTRO_HORDE_7');
INSERT INTO creature_text VALUES (37187, 5, 0, 'High Overlord Saurfang charges!', 16, 0, 0, 53, 0, 17104, 0, 'High Overlord Saurfang - SAY_INTRO_HORDE_8');
INSERT INTO creature_text VALUES (37187, 6, 0, 'Behind you lies the body of my only son. Nothing will keep me from him.', 12, 0, 0, 0, 0, 17094, 0, 'High Overlord Saurfang - SAY_OUTRO_ALLIANCE_8');
INSERT INTO creature_text VALUES (37187, 7, 0, 'High Overlord Saurfang walks over to his son and kneels before his son''s body.', 16, 0, 0, 0, 0, 0, 0, 'High Overlord Saurfang - SAY_OUTRO_ALLIANCE_12');
INSERT INTO creature_text VALUES (37187, 8, 0, '[Orcish] No''ku kil zil''nok ha tar.', 12, 0, 0, 0, 0, 17096, 0, 'High Overlord Saurfang - SAY_OUTRO_ALLIANCE_13');
INSERT INTO creature_text VALUES (37187, 9, 0, 'Higher Overlord Saurfang picks up the body of his son and walks over towards Varian', 16, 0, 0, 0, 0, 0, 0, 'High Overlord Saurfang - SAY_OUTRO_ALLIANCE_14');
INSERT INTO creature_text VALUES (37187, 10, 0, 'I will not forget this... kindness. I thank you, Highness.', 12, 0, 0, 0, 0, 17095, 0, 'High Overlord Saurfang - SAY_OUTRO_ALLIANCE_15');
INSERT INTO creature_text VALUES (37187, 11, 0, '%s coughs.', 16, 0, 0, 0, 0, 17105, 0, 'High Overlord Saurfang - SAY_OUTRO_HORDE_1');
INSERT INTO creature_text VALUES (37187, 12, 0, '%s weeps over the corpse of his son.', 16, 0, 0, 15, 0, 17106, 0, 'High Overlord Saurfang - SAY_OUTRO_HORDE_2');
INSERT INTO creature_text VALUES (37187, 13, 0, 'You will have a proper ceremony in Nagrand next to the pyres of your mother and ancestors.', 12, 0, 0, 0, 0, 17101, 0, 'High Overlord Saurfang - SAY_OUTRO_HORDE_3');
INSERT INTO creature_text VALUES (37187, 14, 0, 'Honor, young heroes... no matter how dire the battle... Never forsake it!', 12, 0, 0, 0, 0, 17102, 0, 'High Overlord Saurfang - SAY_OUTRO_HORDE_4');
INSERT INTO creature_text VALUES (32315, 15, 0, 'The paladin still lives? Is it possible, Highlord? Could he have survived?', 12, 0, 0, 6, 0, 17107, 0, 'High Overlord Saurfang Dummy - SAY_SAURFANG_INTRO_1');
INSERT INTO creature_text VALUES (32315, 16, 0, 'Then we must save him! If we rescue Bolvar Fordragon, we may quell the unrest between the Alliance and the Horde.', 12, 0, 0, 5, 0, 17108, 0, 'High Overlord Saurfang Dummy - SAY_SAURFANG_INTRO_2');
INSERT INTO creature_text VALUES (32315, 17, 0, 'Our mission is now clear: The Lich King will answer for his crimes and we will save Highlord Bolvar Fordragon!', 12, 0, 0, 15, 0, 17109, 0, 'High Overlord Saurfang Dummy - SAY_SAURFANG_INTRO_3');
INSERT INTO creature_text VALUES (32315, 18, 0, 'Kor''kron, prepare Orgrim''s Hammer for its final voyage! Champions, our gunship will find a point to dock on the upper reaches of the citadel. Meet us there!', 14, 0, 0, 22, 0, 17110, 0, 'High Overlord Saurfang Dummy - SAY_SAURFANG_INTRO_4');
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id=37187 AND guid <> 200982 );
DELETE FROM creature WHERE id=37187 AND guid <> 200982;
DELETE FROM creature WHERE id=32315;
INSERT INTO creature VALUES(200984, 32315, 631, 15, 1, 0, 0, -49.2213, 2211.06, 27.9026, 3.0871, 86400, 0, 0, 4183500, 0, 0, 0, 0, 0);
UPDATE creature_template SET minlevel=83, maxlevel=83, exp=2, faction=1735, rank=3, npcflag=0, unit_flags=0, type=7, type_flags=12, AIName='', ScriptName='' WHERE entry=32315;

-- Invisible Stalker (Float, Uninteractible, LargeAOI) (30298) ZOMG!

-- DUMMY:
-- Aronen (39509)
-- Goodman the "Closer" (38858)
-- Torgo the Elder (38194)
-- Ebon Champion (37996)
-- Ebon Blade Commander (37967)
-- Argent Commander (37965)
-- Argent Champion (37928)
-- Commander Kunz (37689)
-- Alchemist Finklestein (37687)
-- Stefan Vadu (37589)
-- Fury (37586)
-- Spire Frostwyrm (Ambient) (37528)
-- Kor'kron General (37189)
-- Highlord Bolvar Fordragon (37183)
-- The Lich King (37181)
-- Steam Burst (26043)
-- Runeforge Bunny (37702)



-- ###################
-- ### QUESTS
-- ###################

-- Highlord Darion Mograine (37120), fix tc one time technique
DELETE FROM smart_scripts WHERE entryorguid=37120 AND source_type=0 AND id>=20;
INSERT INTO smart_scripts VALUES (37120, 0, 20, 21, 19, 0, 100, 0, 0, 0, 0, 0, 74, 30, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Highlord Darion Mograine - On Quest Accept - Remove Timed Event');
INSERT INTO smart_scripts VALUES (37120, 0, 21, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 30, 120000, 120000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Highlord Darion Mograine - On Quest Accept - Create Timed Event');
INSERT INTO smart_scripts VALUES (37120, 0, 22, 23, 20, 0, 100, 0, 0, 0, 0, 0, 74, 30, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Highlord Darion Mograine - On Quest Complete - Remove Timed Event');
INSERT INTO smart_scripts VALUES (37120, 0, 23, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 30, 120000, 120000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Highlord Darion Mograine - On Quest Complete - Create Timed Event');
INSERT INTO smart_scripts VALUES (37120, 0, 24, 0, 59, 0, 100, 0, 30, 0, 0, 0, 81, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Highlord Darion Mograine - Timed Event Triggered - Set NPC Flags');


DELETE FROM pool_pool WHERE pool_id IN( SELECT pool_entry FROM pool_quest WHERE entry IN(24869, 24875, 24874, 24879, 24873, 24878, 24871, 24870, 24876, 24877, 24872, 24880) );
DELETE FROM pool_quest WHERE entry IN(24869, 24875, 24874, 24879, 24873, 24878, 24871, 24870, 24876, 24877, 24872, 24880);
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(19,20) AND SourceEntry IN(24869, 24875, 24874, 24879, 24873, 24878, 24871, 24870, 24876, 24877, 24872, 24880);

-- Deprogramming (24869, 24875)
-- Infiltrator Minchar (38471)
INSERT INTO conditions VALUES(19, 0, 24869, 0, 0, 19, 0, 5, 0, 0, 0, 0, 0, '', 'ICC weekly 10');
INSERT INTO conditions VALUES(20, 0, 24869, 0, 0, 19, 0, 5, 0, 0, 0, 0, 0, '', 'ICC weekly 10');
INSERT INTO conditions VALUES(19, 0, 24875, 0, 0, 19, 0, 10, 0, 0, 0, 0, 0, '', 'ICC weekly 25');
INSERT INTO conditions VALUES(20, 0, 24875, 0, 0, 19, 0, 10, 0, 0, 0, 0, 0, '', 'ICC weekly 25');

-- Blood Quickening (24874, 24879)
-- Alrin the Agile (38551)
-- Infiltrator Minchar (38558)
-- Minchar Beam Stalker (38557)
INSERT INTO conditions VALUES(19, 0, 24874, 0, 0, 19, 0, 5, 0, 0, 0, 0, 0, '', 'ICC weekly 10');
INSERT INTO conditions VALUES(20, 0, 24874, 0, 0, 19, 0, 5, 0, 0, 0, 0, 0, '', 'ICC weekly 10');
INSERT INTO conditions VALUES(19, 0, 24879, 0, 0, 19, 0, 10, 0, 0, 0, 0, 0, '', 'ICC weekly 25');
INSERT INTO conditions VALUES(20, 0, 24879, 0, 0, 19, 0, 10, 0, 0, 0, 0, 0, '', 'ICC weekly 25');
REPLACE INTO areatrigger_scripts VALUES(5729, 'at_icc_start_blood_quickening');
UPDATE creature_template SET unit_flags=0, InhabitType=4, AIName='NullCreatureAI', ScriptName='' WHERE entry=38558;
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38558) AND `map`=631 );
DELETE FROM creature WHERE id IN(38558) AND `map`=631;
INSERT INTO `creature` VALUES (247116, 38558, 631, 15, 1, 0, 0, 4637.27, 2786.25, 424.639, 3.57357, 604800, 0, 0, 0, 0, 0, 0, 0, 0);
REPLACE INTO creature_template_addon VALUES(38558, 0, 0, 50331648, 1, 427, '');
UPDATE creature_template SET modelid1=16925, modelid2=0, unit_flags=33554432, InhabitType=4, AIName='NullCreatureAI', ScriptName='', flags_extra=0 WHERE entry=38557;
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38557) AND `map`=631 );
DELETE FROM smart_scripts WHERE entryorguid IN(-137788, -137787,- 137786,- 137785) AND source_type=0;
DELETE FROM creature WHERE id IN(38557) AND `map`=631;
DELETE FROM creature_template_addon WHERE entry=38557;
INSERT INTO `creature` VALUES (NULL, 38557, 631, 15, 1, 0, 0, 4645.42, 2771.67, 436.146, 0, 604800, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38557, 631, 15, 1, 0, 0, 4630.73, 2802.02, 437.672, 0, 604800, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38557, 631, 15, 1, 0, 0, 4630.34, 2799.74, 412.512, 0, 604800, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38557, 631, 15, 1, 0, 0, 4642.6, 2771.61, 412.227, 0, 604800, 0, 0, 0, 0, 0, 0, 0, 0);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(71322, -71322);
INSERT INTO `conditions` VALUES (13, 1, 71322, 0, 0, 31, 0, 3, 38558, 0, 0, 0, 0, '', 'Blood-Queen Lana''thel - Annihilate Minchar');
UPDATE quest_template SET OfferRewardText='Whew, I thought I was a goner! I heard talk of a resurrection ritual going on in these Halls and went in for a closer look, but one of those blasted vampires sniffed me out. They strung me up here, draining my life energy and hoping I''d break and divulge our plans of attack. As if I even know what Tirion has planned!$b$bPlease, take these spoils of war as a small token of gratitude for saving my life.' WHERE Id IN(24874, 24879);

-- Residue Rendezvous (24873, 24878)
-- Alchemist Adrianna (38501, 38717)
INSERT INTO conditions VALUES(19, 0, 24873, 0, 0, 19, 0, 5, 0, 0, 0, 0, 0, '', 'ICC weekly 10');
INSERT INTO conditions VALUES(20, 0, 24873, 0, 0, 19, 0, 5, 0, 0, 0, 0, 0, '', 'ICC weekly 10');
INSERT INTO conditions VALUES(19, 0, 24878, 0, 0, 19, 0, 10, 0, 0, 0, 0, 0, '', 'ICC weekly 25');
INSERT INTO conditions VALUES(20, 0, 24878, 0, 0, 19, 0, 10, 0, 0, 0, 0, 0, '', 'ICC weekly 25');
UPDATE creature_template SET AIName='', ScriptName='npc_alchemist_adrianna' WHERE entry=38501;
DELETE FROM spell_script_names WHERE spell_id IN(72155, -72155, 72162, -72162);
DELETE FROM spell_scripts WHERE id IN(72155, -72155, 72162, -72162);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(72155, -72155, 72162, -72162) OR spell_effect IN(72155, -72155, 72162, -72162);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(72155, -72155, 72162, -72162);
INSERT INTO `conditions` VALUES (13, 3, 72155, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Alchemist Adrianna, Residue Rendezvous, Harvest Blight Specimen');
INSERT INTO `conditions` VALUES (13, 3, 72162, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Alchemist Adrianna, Residue Rendezvous, Harvest Blight Specimen');
INSERT INTO spell_script_names VALUES(72155, 'spell_icc_harvest_blight_specimen');
INSERT INTO spell_script_names VALUES(72162, 'spell_icc_harvest_blight_specimen');
UPDATE quest_template SET OfferRewardText='At last, we have live specimens to study! You have helped to save countless lives this day, $N.$B$BPlease, take this as a token of thanks for this great deed.' WHERE Id IN(24873, 24878);

-- Securing the Ramparts - ([24871, 24870], [24876, 24877])
-- Kor'kron Lieutenant (38491)
-- Skybreaker Lieutenant (38492)
UPDATE quest_template SET OfferRewardText='The giant is dead? Praise the Light!$B$BThe way onward and upward is clear. Take some of these spoils of the battle as a token of our gratitude, and we will drink together in celebration once the Frozen Throne has been ground to dust!' WHERE Id IN(24871, 24876);
UPDATE quest_template SET OfferRewardText='The giant is dead? For the Horde!$B$BThe way onward and upward is clear. Take some of these spoils of the battle as a token of our gratitude, and we will drink together in celebration once the Frozen Throne has been ground to dust!' WHERE Id IN(24870, 24877);

INSERT INTO conditions VALUES(19, 0, 24871, 0, 0, 19, 0, 5, 0, 0, 0, 0, 0, '', 'ICC weekly 10');
INSERT INTO conditions VALUES(20, 0, 24871, 0, 0, 19, 0, 5, 0, 0, 0, 0, 0, '', 'ICC weekly 10');
INSERT INTO conditions VALUES(19, 0, 24876, 0, 0, 19, 0, 10, 0, 0, 0, 0, 0, '', 'ICC weekly 25');
INSERT INTO conditions VALUES(20, 0, 24876, 0, 0, 19, 0, 10, 0, 0, 0, 0, 0, '', 'ICC weekly 25');
INSERT INTO conditions VALUES(19, 0, 24870, 0, 0, 19, 0, 5, 0, 0, 0, 0, 0, '', 'ICC weekly 10');
INSERT INTO conditions VALUES(20, 0, 24870, 0, 0, 19, 0, 5, 0, 0, 0, 0, 0, '', 'ICC weekly 10');
INSERT INTO conditions VALUES(19, 0, 24877, 0, 0, 19, 0, 10, 0, 0, 0, 0, 0, '', 'ICC weekly 25');
INSERT INTO conditions VALUES(20, 0, 24877, 0, 0, 19, 0, 10, 0, 0, 0, 0, 0, '', 'ICC weekly 25');

-- Respite for a Tormented Soul (24872, 24880)
-- npc Valithria Dreamwalker (38589) -- questgiver, human form at the end
INSERT INTO conditions VALUES(19, 0, 24872, 0, 0, 19, 0, 5, 0, 0, 0, 0, 0, '', 'ICC weekly 10');
INSERT INTO conditions VALUES(20, 0, 24872, 0, 0, 19, 0, 5, 0, 0, 0, 0, 0, '', 'ICC weekly 10');
INSERT INTO conditions VALUES(19, 0, 24880, 0, 0, 19, 0, 10, 0, 0, 0, 0, 0, '', 'ICC weekly 25');
INSERT INTO conditions VALUES(20, 0, 24880, 0, 0, 19, 0, 10, 0, 0, 0, 0, 0, '', 'ICC weekly 25');
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38589) AND `map`=631 );
DELETE FROM creature WHERE id IN(38589) AND `map`=631;
INSERT INTO creature VALUES (247120, 38589, 631, 15, 5, 0, 0, 4210.313, 2484.527, 364.88, 0.0, 604800, 0, 0, 10000002, 0, 0, 0, 0, 0);
DELETE FROM spell_script_names WHERE spell_id IN(72424, 72465, 72466, -72424, -72465, -72466);
DELETE FROM spell_scripts WHERE id IN(72424, 72465, 72466, -72424, -72465, -72466);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(72424, 72465, 72466, -72424, -72465, -72466) OR spell_effect IN(72424, 72465, 72466, -72424, -72465, -72466);
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(13, 17) AND SourceEntry IN(72424, 72465, 72466, -72424, -72465, -72466);
INSERT INTO `conditions` VALUES (17, 0, 72424, 0, 0, 31, 1, 3, 36853, 0, 0, 0, 0, '', 'Pulsing Life Crystal - Sindragosa');
INSERT INTO spell_script_names VALUES(72465, 'spell_sindragosa_soul_preservation');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=1 AND SourceEntry IN(51026, 51027);
UPDATE creature_loot_template SET lootmode=2 WHERE item IN(51026, 51027);
DELETE FROM creature_questender WHERE quest IN(24872, 24880);
INSERT INTO creature_questender VALUES (38017, 24872),(38017, 24880);





-- ###################
-- ### SPELLS
-- ###################

-- Hellscream's Warsong
DELETE FROM spell_area WHERE spell IN(73816,73818,73819,73820,73821,73822);
-- INSERT INTO spell_area VALUES(73816, 4812, 0, 0, 0, 690, 2, 1, 64, 11);
INSERT INTO spell_area VALUES(73818, 4812, 0, 0, 0, 690, 2, 1, 64, 11);
-- INSERT INTO spell_area VALUES(73819, 4812, 0, 0, 0, 690, 2, 1, 64, 11);
-- INSERT INTO spell_area VALUES(73820, 4812, 0, 0, 0, 690, 2, 1, 64, 11);
-- INSERT INTO spell_area VALUES(73821, 4812, 0, 0, 0, 690, 2, 1, 64, 11);
-- INSERT INTO spell_area VALUES(73822, 4812, 0, 0, 0, 690, 2, 1, 64, 11);

-- Strength of Wrynn
DELETE FROM spell_area WHERE spell IN(73762,73824,73825,73826,73827,73828);
-- INSERT INTO spell_area VALUES(73762, 4812, 0, 0, 0, 1101, 2, 1, 64, 11);
INSERT INTO spell_area VALUES(73824, 4812, 0, 0, 0, 1101, 2, 1, 64, 11);
-- INSERT INTO spell_area VALUES(73825, 4812, 0, 0, 0, 1101, 2, 1, 64, 11);
-- INSERT INTO spell_area VALUES(73826, 4812, 0, 0, 0, 1101, 2, 1, 64, 11);
-- INSERT INTO spell_area VALUES(73827, 4812, 0, 0, 0, 1101, 2, 1, 64, 11);
-- INSERT INTO spell_area VALUES(73828, 4812, 0, 0, 0, 1101, 2, 1, 64, 11);

-- Web Wrap (70980) npc Nerub'ar Broodkeeper (36725, 38058)
-- additional ids: 71009, 71010
DELETE FROM spell_script_names WHERE spell_id IN(70980,-70980, 71009, -71009, 71010, -71010);
DELETE FROM spell_scripts WHERE id IN(70980,-70980, 71009, -71009, 71010, -71010);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70980,-70980, 71009, -71009, 71010, -71010) OR spell_effect IN(70980,-70980, 71009, -71009, 71010, -71010);
INSERT INTO spell_script_names VALUES(70980, 'spell_icc_web_wrap');

-- Dark Reckoning (69483) npc Deathspeaker High Priest (36829, 38074)
-- additional ids: 69482
DELETE FROM spell_script_names WHERE spell_id IN(69483, -69483, 69482, -69482);
DELETE FROM spell_scripts WHERE id IN(69483, -69483, 69482, -69482);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69483, -69483, 69482, -69482) OR spell_effect IN(69483, -69483, 69482, -69482);
INSERT INTO spell_script_names VALUES(69483, 'spell_icc_dark_reckoning');

-- Portal to Dalaran (71512)
REPLACE INTO spell_target_position VALUES(71512, 0, 571, 5807.81, 587.977, 660.939, 1.663);

-- Severed Essence (71906)
-- additional ids: 71942, 57537
DELETE FROM spell_script_names WHERE spell_id IN(71906, -71906, 71942, 57537, -71942, -57537);
DELETE FROM spell_scripts WHERE id IN(71906, -71906, 71942, 57537, -71942, -57537);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71906, -71906, 71942, 57537, -71942, -57537) OR spell_effect IN(71906, -71906, 71942, 57537, -71942, -57537);

-- Teleport Spells, correct effect index
UPDATE spell_target_position SET effIndex=1 WHERE id IN(70781, 70856, 70857, 70858, 70859, 70860, 70861);

-- Shattered Bones (70961), visual (70963)
DELETE FROM spell_script_names WHERE spell_id IN(70961, 70963, -70961, -70963);
DELETE FROM spell_scripts WHERE id IN(70961, 70963, -70961, -70963);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70961, 70963, -70961, -70963) OR spell_effect IN(70961, 70963, -70961, -70963);
INSERT INTO spell_script_names VALUES(70961, 'spell_icc_shattered_bones');



-- ###################
-- ### ACHIEVEMENTS
-- ###################

-- Storming the Citadel (10 player) (4531)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12770, 12773, 12771, 12772);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12770, 12773, 12771, 12772);
REPLACE INTO achievement_criteria_data VALUES(12770, 12, 0, 0, "");
REPLACE INTO achievement_criteria_data VALUES(12773, 12, 0, 0, "");
REPLACE INTO achievement_criteria_data VALUES(12771, 12, 0, 0, "");
REPLACE INTO achievement_criteria_data VALUES(12772, 12, 0, 0, "");

-- Storming the Citadel (25 player) (4604)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12945, 12948, 12947, 12946);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12945, 12948, 12947, 12946);
REPLACE INTO achievement_criteria_data VALUES(12945, 12, 1, 0, "");
REPLACE INTO achievement_criteria_data VALUES(12948, 12, 1, 0, "");
REPLACE INTO achievement_criteria_data VALUES(12947, 12, 1, 0, "");
REPLACE INTO achievement_criteria_data VALUES(12946, 12, 1, 0, "");

-- Heroic: Storming the Citadel (10 player) (4628)
DELETE FROM disables WHERE sourceType=4 AND entry IN(13039, 13040, 13041, 13042);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(13039, 13040, 13041, 13042);
REPLACE INTO achievement_criteria_data VALUES(13039, 12, 2, 0, "");
REPLACE INTO achievement_criteria_data VALUES(13040, 12, 2, 0, "");
REPLACE INTO achievement_criteria_data VALUES(13041, 12, 2, 0, "");
REPLACE INTO achievement_criteria_data VALUES(13042, 12, 2, 0, "");

-- Heroic: Storming the Citadel (25 player) (4632)
DELETE FROM disables WHERE sourceType=4 AND entry IN(13050, 13051, 13052, 13053);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(13050, 13051, 13052, 13053);
REPLACE INTO achievement_criteria_data VALUES(13050, 12, 3, 0, "");
REPLACE INTO achievement_criteria_data VALUES(13051, 12, 3, 0, "");
REPLACE INTO achievement_criteria_data VALUES(13052, 12, 3, 0, "");
REPLACE INTO achievement_criteria_data VALUES(13053, 12, 3, 0, "");

-- Boned (10 player) (4534)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12775, 13393);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12775, 13393);
REPLACE INTO achievement_criteria_data VALUES(12775, 12, 0, 0, "");
REPLACE INTO achievement_criteria_data VALUES(12775, 18, 0, 0, "");
REPLACE INTO achievement_criteria_data VALUES(13393, 12, 2, 0, "");
REPLACE INTO achievement_criteria_data VALUES(13393, 18, 0, 0, "");

-- Boned (25 player) (4610)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12962, 13394);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12962, 13394);
REPLACE INTO achievement_criteria_data VALUES(12962, 12, 1, 0, "");
REPLACE INTO achievement_criteria_data VALUES(12962, 18, 0, 0, "");
REPLACE INTO achievement_criteria_data VALUES(13394, 12, 3, 0, "");
REPLACE INTO achievement_criteria_data VALUES(13394, 18, 0, 0, "");

-- Full House (10 player) (4535)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12776, 12995);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12776, 12995);
REPLACE INTO achievement_criteria_data VALUES(12776, 12, 0, 0, "");
REPLACE INTO achievement_criteria_data VALUES(12995, 12, 2, 0, "");

-- Full House (25 player) (4611)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12997, 12998);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12997, 12998);
REPLACE INTO achievement_criteria_data VALUES(12997, 12, 1, 0, "");
REPLACE INTO achievement_criteria_data VALUES(12998, 12, 3, 0, "");

-- I'm on a Boat (10 player) (4536)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12777, 13079);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12777, 13079);
REPLACE INTO achievement_criteria_data VALUES(12777,12,0,0,'');
REPLACE INTO achievement_criteria_data VALUES(13079,12,2,0,'');
REPLACE INTO achievement_criteria_data VALUES(12777,11,0,0,'achievement_im_on_a_boat');
REPLACE INTO achievement_criteria_data VALUES(13079,11,0,0,'achievement_im_on_a_boat');

-- I'm on a Boat (25 player) (4612)
DELETE FROM disables WHERE sourceType=4 AND entry IN(13080, 13081);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(13080, 13081);
REPLACE INTO achievement_criteria_data VALUES(13080,12,1,0,'');
REPLACE INTO achievement_criteria_data VALUES(13081,12,3,0,'');
REPLACE INTO achievement_criteria_data VALUES(13080,11,0,0,'achievement_im_on_a_boat');
REPLACE INTO achievement_criteria_data VALUES(13081,11,0,0,'achievement_im_on_a_boat');

-- I've Gone and Made a Mess (10 player) (4537)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12778, 13035);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12778, 13035);
REPLACE INTO achievement_criteria_data VALUES(12778, 11, 0, 0, 'achievement_ive_gone_and_made_a_mess');
REPLACE INTO achievement_criteria_data VALUES(12778, 12, 0, 0, '');
REPLACE INTO achievement_criteria_data VALUES(13035, 11, 0, 0, 'achievement_ive_gone_and_made_a_mess');
REPLACE INTO achievement_criteria_data VALUES(13035, 12, 2, 0, '');

-- I've Gone and Made a Mess (25 player) (4613)
DELETE FROM disables WHERE sourceType=4 AND entry IN(13036, 13037);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(13036, 13037);
REPLACE INTO achievement_criteria_data VALUES(13036, 11, 0, 0, 'achievement_ive_gone_and_made_a_mess');
REPLACE INTO achievement_criteria_data VALUES(13036, 12, 1, 0, '');
REPLACE INTO achievement_criteria_data VALUES(13037, 11, 0, 0, 'achievement_ive_gone_and_made_a_mess');
REPLACE INTO achievement_criteria_data VALUES(13037, 12, 3, 0, '');


-- The Plagueworks (10 player) (4528)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12759, 12760, 12761);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12759, 12760, 12761);
REPLACE INTO achievement_criteria_data VALUES(12759, 12, 0, 0, '');
REPLACE INTO achievement_criteria_data VALUES(12760, 12, 0, 0, '');
REPLACE INTO achievement_criteria_data VALUES(12761, 12, 0, 0, '');
-- INSERT INTO disables VALUES(4,12759, 0, '', '', '');
-- INSERT INTO disables VALUES(4,12760, 0, '', '', '');
-- INSERT INTO disables VALUES(4,12761, 0, '', '', '');

-- Heroic: The Plagueworks (10 player) (4629)
DELETE FROM disables WHERE sourceType=4 AND entry IN(13043, 13044, 13045);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(13043, 13044, 13045);
REPLACE INTO achievement_criteria_data VALUES(13043, 12, 2, 0, '');
REPLACE INTO achievement_criteria_data VALUES(13044, 12, 2, 0, '');
REPLACE INTO achievement_criteria_data VALUES(13045, 12, 2, 0, '');
-- INSERT INTO disables VALUES(4,13043, 0, '', '', '');
-- INSERT INTO disables VALUES(4,13044, 0, '', '', '');
-- INSERT INTO disables VALUES(4,13045, 0, '', '', '');

-- The Plagueworks (25 player) (4605)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12949, 12950, 12951);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12949, 12950, 12951);
REPLACE INTO achievement_criteria_data VALUES(12949, 12, 1, 0, '');
REPLACE INTO achievement_criteria_data VALUES(12950, 12, 1, 0, '');
REPLACE INTO achievement_criteria_data VALUES(12951, 12, 1, 0, '');
-- INSERT INTO disables VALUES(4,12949, 0, '', '', '');
-- INSERT INTO disables VALUES(4,12950, 0, '', '', '');
-- INSERT INTO disables VALUES(4,12951, 0, '', '', '');

-- Heroic: The Plagueworks (25 player) (4633)
DELETE FROM disables WHERE sourceType=4 AND entry IN(13054, 13055, 13056);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(13054, 13055, 13056);
REPLACE INTO achievement_criteria_data VALUES(13054, 12, 3, 0, '');
REPLACE INTO achievement_criteria_data VALUES(13055, 12, 3, 0, '');
REPLACE INTO achievement_criteria_data VALUES(13056, 12, 3, 0, '');
-- INSERT INTO disables VALUES(4,13054, 0, '', '', '');
-- INSERT INTO disables VALUES(4,13055, 0, '', '', '');
-- INSERT INTO disables VALUES(4,13056, 0, '', '', '');

-- Flu Shot Shortage (10 player) (4577)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12977, 12986);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12977, 12986);
REPLACE INTO achievement_criteria_data VALUES(12977, 11, 0, 0, 'achievement_flu_shot_shortage');
REPLACE INTO achievement_criteria_data VALUES(12977, 12, 0, 0, '');
REPLACE INTO achievement_criteria_data VALUES(12986, 11, 0, 0, 'achievement_flu_shot_shortage');
REPLACE INTO achievement_criteria_data VALUES(12986, 12, 2, 0, '');
-- INSERT INTO disables VALUES(4,12977, 0, '', '', '');
-- INSERT INTO disables VALUES(4,12986, 0, '', '', '');

-- Flu Shot Shortage (25 player) (4615)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12967, 12982);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12967, 12982);
REPLACE INTO achievement_criteria_data VALUES(12967, 11, 0, 0, 'achievement_flu_shot_shortage');
REPLACE INTO achievement_criteria_data VALUES(12967, 12, 1, 0, '');
REPLACE INTO achievement_criteria_data VALUES(12982, 11, 0, 0, 'achievement_flu_shot_shortage');
REPLACE INTO achievement_criteria_data VALUES(12982, 12, 3, 0, '');
-- INSERT INTO disables VALUES(4,12967, 0, '', '', '');
-- INSERT INTO disables VALUES(4,12982, 0, '', '', '');

-- Dances with Oozes (10 player) (4538)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12984, 12985);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12984, 12985);
REPLACE INTO achievement_criteria_data VALUES(12984, 12, 0, 0, '');
REPLACE INTO achievement_criteria_data VALUES(12984, 18, 0, 0, '');
REPLACE INTO achievement_criteria_data VALUES(12985, 12, 2, 0, '');
REPLACE INTO achievement_criteria_data VALUES(12985, 18, 0, 0, '');
-- INSERT INTO disables VALUES(4,12984, 0, '', '', '');
-- INSERT INTO disables VALUES(4,12985, 0, '', '', '');

-- Dances with Oozes (25 player) (4614)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12966, 12983);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12966, 12983);
REPLACE INTO achievement_criteria_data VALUES(12966, 12, 1, 0, '');
REPLACE INTO achievement_criteria_data VALUES(12966, 18, 0, 0, '');
REPLACE INTO achievement_criteria_data VALUES(12983, 12, 3, 0, '');
REPLACE INTO achievement_criteria_data VALUES(12983, 18, 0, 0, '');
-- INSERT INTO disables VALUES(4,12966, 0, '', '', '');
-- INSERT INTO disables VALUES(4,12983, 0, '', '', '');

-- Nausea, Heartburn, Indigestion... (10 player) (4578)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12987, 12988);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12987, 12988);
REPLACE INTO achievement_criteria_data VALUES(12987, 12, 0, 0, '');
REPLACE INTO achievement_criteria_data VALUES(12987, 18, 0, 0, '');
REPLACE INTO achievement_criteria_data VALUES(12988, 12, 2, 0, '');
REPLACE INTO achievement_criteria_data VALUES(12988, 18, 0, 0, '');
-- INSERT INTO disables VALUES(4,12987, 0, '', '', '');
-- INSERT INTO disables VALUES(4,12988, 0, '', '', '');

-- Nausea, Heartburn, Indigestion... (25 player) (4616)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12968, 12981);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12968, 12981);
REPLACE INTO achievement_criteria_data VALUES(12968, 12, 1, 0, '');
REPLACE INTO achievement_criteria_data VALUES(12968, 18, 0, 0, '');
REPLACE INTO achievement_criteria_data VALUES(12981, 12, 3, 0, '');
REPLACE INTO achievement_criteria_data VALUES(12981, 18, 0, 0, '');
-- INSERT INTO disables VALUES(4,12968, 0, '', '', '');
-- INSERT INTO disables VALUES(4,12981, 0, '', '', '');

-- The Crimson Hall (10 player) (4529)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12762, 12763);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12762, 12763);
REPLACE INTO achievement_criteria_data VALUES(12762, 12, 0, 0, '');
REPLACE INTO achievement_criteria_data VALUES(12763, 12, 0, 0, '');
-- INSERT INTO disables VALUES(4,12762, 0, '', '', '');
-- INSERT INTO disables VALUES(4,12763, 0, '', '', '');

-- The Crimson Hall (25 player) (4606)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12952, 12953);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12952, 12953);
REPLACE INTO achievement_criteria_data VALUES(12952, 12, 1, 0, '');
REPLACE INTO achievement_criteria_data VALUES(12953, 12, 1, 0, '');
-- INSERT INTO disables VALUES(4,12952, 0, '', '', '');
-- INSERT INTO disables VALUES(4,12953, 0, '', '', '');

-- Heroic: The Crimson Hall (10 player) (4630)
DELETE FROM disables WHERE sourceType=4 AND entry IN(13046, 13047);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(13046, 13047);
REPLACE INTO achievement_criteria_data VALUES(13046, 12, 2, 0, '');
REPLACE INTO achievement_criteria_data VALUES(13047, 12, 2, 0, '');
-- INSERT INTO disables VALUES(4,13046, 0, '', '', '');
-- INSERT INTO disables VALUES(4,13047, 0, '', '', '');

-- Heroic: The Crimson Hall (25 player) (4634)
DELETE FROM disables WHERE sourceType=4 AND entry IN(13057, 13058);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(13057, 13058);
REPLACE INTO achievement_criteria_data VALUES(13057, 12, 3, 0, '');
REPLACE INTO achievement_criteria_data VALUES(13058, 12, 3, 0, '');
-- INSERT INTO disables VALUES(4,13057, 0, '', '', '');
-- INSERT INTO disables VALUES(4,13058, 0, '', '', '');

-- The Orb Whisperer (10 player) (4582)
DELETE FROM disables WHERE sourceType=4 AND entry IN(13033, 13034);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(13033, 13034);
REPLACE INTO achievement_criteria_data VALUES(13033, 12, 0, 0, '');
REPLACE INTO achievement_criteria_data VALUES(13033, 18, 0, 0, '');
REPLACE INTO achievement_criteria_data VALUES(13034, 12, 2, 0, '');
REPLACE INTO achievement_criteria_data VALUES(13034, 18, 0, 0, '');
-- INSERT INTO disables VALUES(4,13033, 0, '', '', '');
-- INSERT INTO disables VALUES(4,13034, 0, '', '', '');

-- The Orb Whisperer (25 player) (4617)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12969, 13032);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12969, 13032);
REPLACE INTO achievement_criteria_data VALUES(12969, 12, 1, 0, '');
REPLACE INTO achievement_criteria_data VALUES(12969, 18, 0, 0, '');
REPLACE INTO achievement_criteria_data VALUES(13032, 12, 3, 0, '');
REPLACE INTO achievement_criteria_data VALUES(13032, 18, 0, 0, '');
-- INSERT INTO disables VALUES(4,12969, 0, '', '', '');
-- INSERT INTO disables VALUES(4,13032, 0, '', '', '');

-- Once Bitten, Twice Shy (10 player) (4539)
DELETE FROM disables WHERE sourceType=4 AND entry IN(13011, 12780);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(13011, 12780);
INSERT INTO `achievement_criteria_data` VALUES (13011, 11, 0, 0, 'achievement_once_bitten_twice_shy_v_10');
INSERT INTO `achievement_criteria_data` VALUES (12780, 11, 0, 0, 'achievement_once_bitten_twice_shy_n_10');
-- INSERT INTO disables VALUES(4,13011, 0, '', '', '');
-- INSERT INTO disables VALUES(4,12780, 0, '', '', '');

-- Once Bitten, Twice Shy (25 player) (4618)
DELETE FROM disables WHERE sourceType=4 AND entry IN(13012, 13013);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(13012, 13013);
INSERT INTO `achievement_criteria_data` VALUES (13012, 11, 0, 0, 'achievement_once_bitten_twice_shy_n_25');
INSERT INTO `achievement_criteria_data` VALUES (13013, 11, 0, 0, 'achievement_once_bitten_twice_shy_v_25');
-- INSERT INTO disables VALUES(4,13012, 0, '', '', '');
-- INSERT INTO disables VALUES(4,13013, 0, '', '', '');

-- The Frostwing Halls (10 player) (4527)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12757, 12758);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12757, 12758);
REPLACE INTO achievement_criteria_data VALUES(12757, 12, 0, 0, '');
REPLACE INTO achievement_criteria_data VALUES(12758, 12, 0, 0, '');
-- INSERT INTO disables VALUES(4,12757, 0, '', '', '');
-- INSERT INTO disables VALUES(4,12758, 0, '', '', '');

-- The Frostwing Halls (25 player) (4607)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12954, 12955);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12954, 12955);
REPLACE INTO achievement_criteria_data VALUES(12954, 12, 1, 0, '');
REPLACE INTO achievement_criteria_data VALUES(12955, 12, 1, 0, '');
-- INSERT INTO disables VALUES(4,12954, 0, '', '', '');
-- INSERT INTO disables VALUES(4,12955, 0, '', '', '');

-- Heroic: The Frostwing Halls (10 player) (4631)
DELETE FROM disables WHERE sourceType=4 AND entry IN(13048, 13049);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(13048, 13049);
REPLACE INTO achievement_criteria_data VALUES(13048, 12, 2, 0, '');
REPLACE INTO achievement_criteria_data VALUES(13049, 12, 2, 0, '');
-- INSERT INTO disables VALUES(4,13048, 0, '', '', '');
-- INSERT INTO disables VALUES(4,13049, 0, '', '', '');

-- Heroic: The Frostwing Halls (25 player) (4635)
DELETE FROM disables WHERE sourceType=4 AND entry IN(13059, 13060);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(13059, 13060);
REPLACE INTO achievement_criteria_data VALUES(13059, 12, 3, 0, '');
REPLACE INTO achievement_criteria_data VALUES(13060, 12, 3, 0, '');
-- INSERT INTO disables VALUES(4,13059, 0, '', '', '');
-- INSERT INTO disables VALUES(4,13060, 0, '', '', '');

-- Portal Jockey (10 player) (4579)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12978, 12979);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12978, 12979);
INSERT INTO `achievement_criteria_data` VALUES (12978, 11, 0, 0, 'achievement_portal_jockey');
INSERT INTO `achievement_criteria_data` VALUES (12978, 12, 0, 0, '');
INSERT INTO `achievement_criteria_data` VALUES (12979, 11, 0, 0, 'achievement_portal_jockey');
INSERT INTO `achievement_criteria_data` VALUES (12979, 12, 2, 0, '');
-- INSERT INTO disables VALUES(4,12978, 0, '', '', '');
-- INSERT INTO disables VALUES(4,12979, 0, '', '', '');

-- Portal Jockey (25 player) (4619)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12971, 12980);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12971, 12980);
INSERT INTO `achievement_criteria_data` VALUES (12971, 11, 0, 0, 'achievement_portal_jockey');
INSERT INTO `achievement_criteria_data` VALUES (12971, 12, 1, 0, '');
INSERT INTO `achievement_criteria_data` VALUES (12980, 11, 0, 0, 'achievement_portal_jockey');
INSERT INTO `achievement_criteria_data` VALUES (12980, 12, 3, 0, '');
-- INSERT INTO disables VALUES(4,12971, 0, '', '', '');
-- INSERT INTO disables VALUES(4,12980, 0, '', '', '');

-- All You Can Eat (10 player) (4580)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12822, 12996);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12822, 12996);
INSERT INTO `achievement_criteria_data` VALUES (12822, 11, 0, 0, 'achievement_all_you_can_eat');
INSERT INTO `achievement_criteria_data` VALUES (12822, 12, 0, 0, '');
INSERT INTO `achievement_criteria_data` VALUES (12996, 11, 0, 0, 'achievement_all_you_can_eat');
INSERT INTO `achievement_criteria_data` VALUES (12996, 12, 2, 0, '');
-- INSERT INTO disables VALUES(4,12822, 0, '', '', '');
-- INSERT INTO disables VALUES(4,12996, 0, '', '', '');

-- All You Can Eat (25 player) (4620)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12972, 12989);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12972, 12989);
INSERT INTO `achievement_criteria_data` VALUES (12972, 11, 0, 0, 'achievement_all_you_can_eat');
INSERT INTO `achievement_criteria_data` VALUES (12972, 12, 1, 0, '');
INSERT INTO `achievement_criteria_data` VALUES (12989, 11, 0, 0, 'achievement_all_you_can_eat');
INSERT INTO `achievement_criteria_data` VALUES (12989, 12, 3, 0, '');
-- INSERT INTO disables VALUES(4,12972, 0, '', '', '');
-- INSERT INTO disables VALUES(4,12989, 0, '', '', '');

-- Fall of the Lich King (10 player) (4532)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12765, 12767, 12768, 12766, 12769);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12765, 12767, 12768, 12766, 12769);

-- Heroic: Fall of the Lich King (10 player) (4636)
DELETE FROM disables WHERE sourceType=4 AND entry IN(13061, 13062, 13063, 13064, 13065);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(13061, 13062, 13063, 13064, 13065);

-- Fall of the Lich King (25 player) (4608)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12956, 12959, 12960, 12958, 12957);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12956, 12959, 12960, 12958, 12957);

-- Heroic: Fall of the Lich King (25 player) (4637)
DELETE FROM disables WHERE sourceType=4 AND entry IN(13066, 13067, 13068, 13069, 13070);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(13066, 13067, 13068, 13069, 13070);

-- Been Waiting a Long Time for This (10 player) (4601)
DELETE FROM disables WHERE sourceType=4 AND entry IN(13246, 13247);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(13246, 13247);
INSERT INTO achievement_criteria_data VALUES (13246, 11, 0, 0, 'achievement_been_waiting_long_time');
INSERT INTO achievement_criteria_data VALUES (13246, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES (13247, 11, 0, 0, 'achievement_been_waiting_long_time');
INSERT INTO achievement_criteria_data VALUES (13247, 12, 2, 0, '');

-- Been Waiting a Long Time for This (25 player) (4621)
DELETE FROM disables WHERE sourceType=4 AND entry IN(13244, 13245);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(13244, 13245);
INSERT INTO achievement_criteria_data VALUES (13244, 11, 0, 0, 'achievement_been_waiting_long_time');
INSERT INTO achievement_criteria_data VALUES (13244, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES (13245, 11, 0, 0, 'achievement_been_waiting_long_time');
INSERT INTO achievement_criteria_data VALUES (13245, 12, 3, 0, '');

-- Neck-Deep in Vile (10 player) (4581)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12823, 13163);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12823, 13163);
INSERT INTO achievement_criteria_data VALUES (12823, 11, 0, 0, 'achievement_neck_deep_in_vile');
INSERT INTO achievement_criteria_data VALUES (12823, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES (13163, 11, 0, 0, 'achievement_neck_deep_in_vile');
INSERT INTO achievement_criteria_data VALUES (13163, 12, 2, 0, '');

-- Neck-Deep in Vile (25 player) (4622)
DELETE FROM disables WHERE sourceType=4 AND entry IN(13243, 13164);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(13243, 13164);
INSERT INTO achievement_criteria_data VALUES (13243, 11, 0, 0, 'achievement_neck_deep_in_vile');
INSERT INTO achievement_criteria_data VALUES (13243, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES (13164, 11, 0, 0, 'achievement_neck_deep_in_vile');
INSERT INTO achievement_criteria_data VALUES (13164, 12, 3, 0, '');

-- The Frozen Throne (10 player) (4530)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12764);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12764);
INSERT INTO achievement_criteria_data VALUES (12764, 12, 0, 0, '');

-- The Frozen Throne (25 player) (4597)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12909);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12909);
INSERT INTO achievement_criteria_data VALUES (12909, 12, 1, 0, '');

-- Bane of the Fallen King (4583)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12825);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12825);
INSERT INTO achievement_criteria_data VALUES (12825, 12, 2, 0, '');

-- The Light of Dawn (4584)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12826);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12826);
INSERT INTO achievement_criteria_data VALUES (12826, 12, 3, 0, '');

-- Realm First! Fall of the Lich King (4576)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12818);
-- INSERT INTO disables VALUES(4, 12818, 0, '', '', '');
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12818);
INSERT INTO achievement_criteria_data VALUES (12818, 12, 3, 0, '');



-- ###################
-- ### LORD MARROWGAR
-- ###################

-- Lord Marrowgar (36612, 37957, 37958, 37959)
UPDATE creature_template SET speed_run=1.21429, rank=3, mindmg=3643, maxdmg=4967, attackpower=300, dmg_multiplier=7, baseattacktime=1000, AIName='', mechanic_immune_mask=617299839, flags_extra=1+0x200000, ScriptName='boss_lord_marrowgar' WHERE entry IN(36612);
UPDATE creature_template SET speed_run=1.21429, rank=3, mindmg=3319, maxdmg=4525, attackpower=300, dmg_multiplier=13, baseattacktime=1000, AIName='', mechanic_immune_mask=617299839, flags_extra=1+0x200000, ScriptName='' WHERE entry IN(37957);
UPDATE creature_template SET speed_run=1.21429, rank=3, mindmg=5464, maxdmg=7450, attackpower=300, dmg_multiplier=7, baseattacktime=1000, AIName='', mechanic_immune_mask=617299839, flags_extra=1+0x200000, ScriptName='' WHERE entry IN(37958);
UPDATE creature_template SET speed_run=1.21429, rank=3, mindmg=3923, maxdmg=5349, attackpower=300, dmg_multiplier=13, baseattacktime=1000, AIName='', mechanic_immune_mask=617299839, flags_extra=1+0x200000, ScriptName='' WHERE entry IN(37959);
DELETE FROM creature_template_addon WHERE entry IN(36612, 37957, 37958, 37959);
UPDATE creature SET spawntimesecs=604800 WHERE id IN(36612, 37957, 37958, 37959);

-- Bone Spike (36619, 38233, 38459, 38460)
UPDATE creature_template SET AIName='', VehicleId=533, RegenHealth=0, mechanic_immune_mask=652214271 WHERE entry IN(36619, 38233, 38459, 38460);
UPDATE creature_template SET ScriptName='npc_bone_spike' WHERE entry=36619;
DELETE FROM creature_template_addon WHERE entry IN(36619, 38233, 38459, 38460);

-- Bone Spike (38711, 38970, 38971, 38972)
UPDATE creature_template SET AIName='', VehicleId=533, RegenHealth=0, mechanic_immune_mask=652214271 WHERE entry IN(38711, 38970, 38971, 38972);
UPDATE creature_template SET ScriptName='npc_bone_spike' WHERE entry=38711;
DELETE FROM creature_template_addon WHERE entry IN(38711, 38970, 38971, 38972);

-- Bone Spike (38712, 38973, 38974, 38975)
UPDATE creature_template SET AIName='', VehicleId=533, RegenHealth=0, mechanic_immune_mask=652214271 WHERE entry IN(38712, 38973, 38974, 38975);
UPDATE creature_template SET ScriptName='npc_bone_spike' WHERE entry=38712;
DELETE FROM creature_template_addon WHERE entry IN(38712, 38973, 38974, 38975);

-- Coldflame (36672)
UPDATE creature_template SET faction=21, modelid1=11686, modelid2=0, modelid3=0, modelid4=0, scale=0.1, AIName='', unit_flags=33554432, flags_extra=128, ScriptName='npc_coldflame' WHERE entry IN(36672);
DELETE FROM creature_template_addon WHERE entry IN(36672);

-- spell Coldflame (69140)
-- additional ids: 69138, 69147, 69146, 70823, 70824, 70825
DELETE FROM spell_script_names WHERE spell_id IN(69140, -69140, 69138, -69138, 69147, -69147, 69146, -69146, 70823, -70823, 70824, -70824, 70825, -70825);
DELETE FROM spell_scripts WHERE id IN(69140, -69140, 69138, -69138, 69147, -69147, 69146, -69146, 70823, -70823, 70824, -70824, 70825, -70825);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69140, -69140, 69138, -69138, 69147, -69147, 69146, -69146, 70823, -70823, 70824, -70824, 70825, -70825) OR spell_effect IN(69140, -69140, 69138, -69138, 69147, -69147, 69146, -69146, 70823, -70823, 70824, -70824, 70825, -70825);
INSERT INTO spell_script_names VALUES(69140, 'spell_marrowgar_coldflame');

-- spell Bone Spike Graveyard (69057)
-- additional ids: 70826, 72088, 72089
DELETE FROM spell_script_names WHERE spell_id IN(69057, -69057, 70826, -70826, 72088, -72088, 72089, -72089);
DELETE FROM spell_scripts WHERE id IN(69057, -69057, 70826, -70826, 72088, -72088, 72089, -72089);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69057, -69057, 70826, -70826, 72088, -72088, 72089, -72089) OR spell_effect IN(69057, -69057, 70826, -70826, 72088, -72088, 72089, -72089);
INSERT INTO spell_script_names VALUES(69057, 'spell_marrowgar_bone_spike_graveyard');
INSERT INTO spell_script_names VALUES(70826, 'spell_marrowgar_bone_spike_graveyard');
INSERT INTO spell_script_names VALUES(72088, 'spell_marrowgar_bone_spike_graveyard');
INSERT INTO spell_script_names VALUES(72089, 'spell_marrowgar_bone_spike_graveyard');
-- moar to ensure no shit 69065, 69062, 72669, 72670
DELETE FROM spell_script_names WHERE spell_id IN(69065, 69062, 72669, 72670, -69065, -69062, -72669, -72670);
DELETE FROM spell_scripts WHERE id IN(69065, 69062, 72669, 72670, -69065, -69062, -72669, -72670);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69065, 69062, 72669, 72670, -69065, -69062, -72669, -72670) OR spell_effect IN(69065, 69062, 72669, 72670, -69065, -69062, -72669, -72670);

-- spell Bone Storm (69076)
-- additional ids: 69075, 70834, 70835, 70836
DELETE FROM spell_script_names WHERE spell_id IN(69076, -69076, 69075, 70834, 70835, 70836, -69075, -70834, -70835, -70836);
DELETE FROM spell_scripts WHERE id IN(69076, -69076, 69075, 70834, 70835, 70836, -69075, -70834, -70835, -70836);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69076, -69076, 69075, 70834, 70835, 70836, -69075, -70834, -70835, -70836) OR spell_effect IN(69076, -69076, 69075, 70834, 70835, 70836, -69075, -70834, -70835, -70836);
INSERT INTO spell_script_names VALUES(69075, 'spell_marrowgar_bone_storm');
INSERT INTO spell_script_names VALUES(70834, 'spell_marrowgar_bone_storm');
INSERT INTO spell_script_names VALUES(70835, 'spell_marrowgar_bone_storm');
INSERT INTO spell_script_names VALUES(70836, 'spell_marrowgar_bone_storm');

-- spell Coldflame (72705) (Bone Storm)
-- additional ids: 72701, 72702, 72703, 72704
DELETE FROM spell_script_names WHERE spell_id IN(72705, -72705, 72701, 72702, 72703, 72704, -72701, -72702, -72703, -72704);
DELETE FROM spell_scripts WHERE id IN(72705, -72705, 72701, 72702, 72703, 72704, -72701, -72702, -72703, -72704);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(72705, -72705, 72701, 72702, 72703, 72704, -72701, -72702, -72703, -72704) OR spell_effect IN(72705, -72705, 72701, 72702, 72703, 72704, -72701, -72702, -72703, -72704);
INSERT INTO spell_script_names VALUES(72705, 'spell_marrowgar_coldflame_bonestorm');



-- ###################
-- ### LADY DEATHWHISPER
-- ###################

-- Lady Deathwhisper (36855, 38106, 38296, 38297)
UPDATE creature_template SET speed_run=1.14286, rank=3, mindmg=3290, maxdmg=4480, attackpower=300, dmg_multiplier=7, baseattacktime=2000, AIName='', mechanic_immune_mask=617299839, flags_extra=1+0x200000, ScriptName='boss_lady_deathwhisper' WHERE entry IN(36855);
UPDATE creature_template SET speed_run=1.14286, rank=3, mindmg=2603, maxdmg=3544, attackpower=300, dmg_multiplier=13, baseattacktime=2000, AIName='', mechanic_immune_mask=617299839, flags_extra=1+0x200000, ScriptName='' WHERE entry IN(38106);
UPDATE creature_template SET speed_run=1.14286, rank=3, mindmg=5908, maxdmg=8045, attackpower=300, dmg_multiplier=7, baseattacktime=2000, AIName='', mechanic_immune_mask=617299839, flags_extra=257+0x200000, ScriptName='' WHERE entry IN(38296);
UPDATE creature_template SET speed_run=1.14286, rank=3, mindmg=3796, maxdmg=5169, attackpower=300, dmg_multiplier=13, baseattacktime=2000, AIName='', mechanic_immune_mask=617299839, flags_extra=257+0x200000, ScriptName='' WHERE entry IN(38297);
UPDATE creature SET spawntimesecs=604800 WHERE id IN(36855, 38106, 38296, 38297);

-- Cult Fanatic (37890, 38393, 38628, 38629)
REPLACE INTO creature_equip_template VALUES(37890, 1, 40384, 0, 0, 0);
UPDATE creature_template SET minlevel=82, maxlevel=82, speed_walk=1, speed_run=1.14286, mindmg=2114, maxdmg=2883, attackpower=300, dmg_multiplier=7, AIName='', mechanic_immune_mask=550109775, ScriptName='npc_cult_fanatic' WHERE entry=37890;
UPDATE creature_template SET minlevel=82, maxlevel=82, speed_walk=1, speed_run=1.14286, mindmg=1708, maxdmg=2328, attackpower=300, dmg_multiplier=13, AIName='', mechanic_immune_mask=550109775, ScriptName='' WHERE entry=38393;
UPDATE creature_template SET minlevel=82, maxlevel=82, speed_walk=1, speed_run=1.14286, mindmg=3172, maxdmg=4324, attackpower=300, dmg_multiplier=7, AIName='', mechanic_immune_mask=550109775, ScriptName='' WHERE entry=38628;
UPDATE creature_template SET minlevel=82, maxlevel=82, speed_walk=1, speed_run=1.14286, mindmg=2277, maxdmg=3105, attackpower=300, dmg_multiplier=13, AIName='', mechanic_immune_mask=550109775, ScriptName='' WHERE entry=38629;
DELETE FROM creature_template_addon WHERE entry IN(37890, 38393, 38628, 38629);

-- Reanimated Fanatic (38009, 38398, 38630, 38631)
REPLACE INTO creature_equip_template VALUES(38009, 1, 40384, 0, 0, 0);
UPDATE creature_template SET minlevel=82, maxlevel=82, speed_walk=1, speed_run=1.14286, mindmg=2114, maxdmg=2883, attackpower=300, dmg_multiplier=7, AIName='', mechanic_immune_mask=550175327, ScriptName='npc_cult_fanatic' WHERE entry=38009;
UPDATE creature_template SET minlevel=82, maxlevel=82, speed_walk=1, speed_run=1.14286, mindmg=1708, maxdmg=2328, attackpower=300, dmg_multiplier=13, AIName='', mechanic_immune_mask=550175327, ScriptName='' WHERE entry=38398;
UPDATE creature_template SET minlevel=82, maxlevel=82, speed_walk=1, speed_run=1.14286, mindmg=3172, maxdmg=4324, attackpower=300, dmg_multiplier=7, AIName='', mechanic_immune_mask=550175327, ScriptName='' WHERE entry=38630;
UPDATE creature_template SET minlevel=82, maxlevel=82, speed_walk=1, speed_run=1.14286, mindmg=2277, maxdmg=3105, attackpower=300, dmg_multiplier=13, AIName='', mechanic_immune_mask=550175327, ScriptName='' WHERE entry=38631;
DELETE FROM creature_template_addon WHERE entry IN(38009, 38398, 38630, 38631);
REPLACE INTO creature_template_addon VALUES(38009, 0, 0, 0, 1, 0, "71235");
REPLACE INTO creature_template_addon VALUES(38398, 0, 0, 0, 1, 0, "71235");
REPLACE INTO creature_template_addon VALUES(38630, 0, 0, 0, 1, 0, "71235");
REPLACE INTO creature_template_addon VALUES(38631, 0, 0, 0, 1, 0, "71235");

-- Deformed Fanatic (38135, 38395, 38634, 38635)
REPLACE INTO creature_equip_template VALUES(38135, 1, 40384, 0, 0, 0);
UPDATE creature_template SET minlevel=82, maxlevel=82, speed_walk=0.5, speed_run=0.57143, mindmg=2114, maxdmg=2883, attackpower=300, dmg_multiplier=7, AIName='', mechanic_immune_mask=550175327, ScriptName='npc_cult_fanatic' WHERE entry=38135;
UPDATE creature_template SET minlevel=82, maxlevel=82, speed_walk=0.5, speed_run=0.57143, mindmg=1708, maxdmg=2328, attackpower=300, dmg_multiplier=13, AIName='', mechanic_immune_mask=550175327, ScriptName='' WHERE entry=38395;
UPDATE creature_template SET minlevel=82, maxlevel=82, speed_walk=0.5, speed_run=0.57143, mindmg=3172, maxdmg=4324, attackpower=300, dmg_multiplier=7, AIName='', mechanic_immune_mask=550175327, ScriptName='' WHERE entry=38634;
UPDATE creature_template SET minlevel=82, maxlevel=82, speed_walk=0.5, speed_run=0.57143, mindmg=2277, maxdmg=3105, attackpower=300, dmg_multiplier=13, AIName='', mechanic_immune_mask=550175327, ScriptName='' WHERE entry=38635;
DELETE FROM creature_template_addon WHERE entry IN(38135, 38395, 38634, 38635);

-- Cult Adherent (37949, 38394, 38625, 38626)
REPLACE INTO creature_equip_template VALUES(37949, 1, 22801, 0, 0, 0);
UPDATE creature_template SET minlevel=82, maxlevel=82, speed_walk=1, speed_run=1.14286, mindmg=1070, maxdmg=1459, attackpower=300, dmg_multiplier=7, AIName='', mechanic_immune_mask=550109775, ScriptName='npc_cult_adherent' WHERE entry=37949;
UPDATE creature_template SET minlevel=82, maxlevel=82, speed_walk=1, speed_run=1.14286, mindmg=862, maxdmg=1176, attackpower=300, dmg_multiplier=13, AIName='', mechanic_immune_mask=550109775, ScriptName='' WHERE entry=38394;
UPDATE creature_template SET minlevel=82, maxlevel=82, speed_walk=1, speed_run=1.14286, mindmg=1600, maxdmg=2184, attackpower=300, dmg_multiplier=7, AIName='', mechanic_immune_mask=550109775, ScriptName='' WHERE entry=38625;
UPDATE creature_template SET minlevel=82, maxlevel=82, speed_walk=1, speed_run=1.14286, mindmg=1152, maxdmg=1571, attackpower=300, dmg_multiplier=13, AIName='', mechanic_immune_mask=550109775, ScriptName='' WHERE entry=38626;
DELETE FROM creature_template_addon WHERE entry IN(37949, 38394, 38625, 38626);

-- Reanimated Adherent (38010, 38397, 39000, 39001)
REPLACE INTO creature_equip_template VALUES(38010, 1, 22801, 0, 0, 0);
UPDATE creature_template SET minlevel=82, maxlevel=82, speed_walk=1, speed_run=1.14286, mindmg=1070, maxdmg=1459, attackpower=300, dmg_multiplier=7, AIName='', mechanic_immune_mask=550175327, ScriptName='npc_cult_adherent' WHERE entry=38010;
UPDATE creature_template SET minlevel=82, maxlevel=82, speed_walk=1, speed_run=1.14286, mindmg=862, maxdmg=1176, attackpower=300, dmg_multiplier=13, AIName='', mechanic_immune_mask=550175327, ScriptName='' WHERE entry=38397;
UPDATE creature_template SET minlevel=82, maxlevel=82, speed_walk=1, speed_run=1.14286, mindmg=1600, maxdmg=2184, attackpower=300, dmg_multiplier=7, AIName='', mechanic_immune_mask=550175327, ScriptName='' WHERE entry=39000;
UPDATE creature_template SET minlevel=82, maxlevel=82, speed_walk=1, speed_run=1.14286, mindmg=1152, maxdmg=1571, attackpower=300, dmg_multiplier=13, AIName='', mechanic_immune_mask=550175327, ScriptName='' WHERE entry=39001;
DELETE FROM creature_template_addon WHERE entry IN(38010, 38397, 39000, 39001);
REPLACE INTO creature_template_addon VALUES(38010, 0, 0, 0, 1, 0, "71234");
REPLACE INTO creature_template_addon VALUES(38397, 0, 0, 0, 1, 0, "71234");
REPLACE INTO creature_template_addon VALUES(39000, 0, 0, 0, 1, 0, "71234");
REPLACE INTO creature_template_addon VALUES(39001, 0, 0, 0, 1, 0, "71234");

-- Empowered Adherent (38136, 38396, 38632, 38633)
REPLACE INTO creature_equip_template VALUES(38136, 1, 22801, 0, 0, 0);
UPDATE creature_template SET minlevel=82, maxlevel=82, speed_walk=1, speed_run=1.14286, mindmg=1070, maxdmg=1459, attackpower=300, dmg_multiplier=7, AIName='', mechanic_immune_mask=550175327, ScriptName='npc_cult_adherent' WHERE entry=38136;
UPDATE creature_template SET minlevel=82, maxlevel=82, speed_walk=1, speed_run=1.14286, mindmg=862, maxdmg=1176, attackpower=300, dmg_multiplier=13, AIName='', mechanic_immune_mask=550175327, ScriptName='' WHERE entry=38396;
UPDATE creature_template SET minlevel=82, maxlevel=82, speed_walk=1, speed_run=1.14286, mindmg=1600, maxdmg=2184, attackpower=300, dmg_multiplier=7, AIName='', mechanic_immune_mask=550175327, ScriptName='' WHERE entry=38632;
UPDATE creature_template SET minlevel=82, maxlevel=82, speed_walk=1, speed_run=1.14286, mindmg=1152, maxdmg=1571, attackpower=300, dmg_multiplier=13, AIName='', mechanic_immune_mask=550175327, ScriptName='' WHERE entry=38633;
DELETE FROM creature_template_addon WHERE entry IN(38136, 38396, 38632, 38633);

-- Vengeful Shade (38222)
UPDATE creature_template SET speed_walk=0.75, speed_run=0.75, unit_flags = 33554434, AIName='', ScriptName='npc_vengeful_shade' WHERE entry=38222;
DELETE FROM creature_template_addon WHERE entry=38222;

-- Darnavan (38472, 38485)
REPLACE INTO creature_equip_template VALUES(38472, 1, 49984, 0, 0, 0);
UPDATE creature_template SET speed_walk=1, speed_run=1.14286, mindmg=1500, maxdmg=2000, attackpower=300, dmg_multiplier=7, type_flags=0, AIName='', mechanic_immune_mask=550183455, ScriptName='npc_darnavan' WHERE entry=38472;
REPLACE INTO creature_equip_template VALUES(38485, 1, 49984, 0, 0, 0);
UPDATE creature_template SET speed_walk=1, speed_run=1.14286, mindmg=1100, maxdmg=1500, attackpower=300, dmg_multiplier=13, type_flags=0, AIName='', mechanic_immune_mask=550183455, ScriptName='npc_darnavan' WHERE entry=38485;
DELETE FROM creature_template_addon WHERE entry IN(38472, 38485);

-- Deathwhisper Spawn Stalker (37947)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37947) AND `map`=631 );
DELETE FROM creature WHERE id IN(37947) AND `map`=631;

-- Deathwhisper Controller (37948)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37948) AND `map`=631 );
DELETE FROM creature WHERE id IN(37948) AND `map`=631;

-- spell Dark Martyrdom (70897)
DELETE FROM spell_script_names WHERE spell_id IN(70897, -70897);
DELETE FROM spell_scripts WHERE id IN(70897, -70897);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70897, -70897) OR spell_effect IN(70897, -70897);

-- spell Dark Martyrdom (Fanatic) (71236)
-- additional ids: 72495, 72496, 72497
DELETE FROM spell_script_names WHERE spell_id IN(71236, -71236, 72495, 72496, 72497, -72495, -72496, -72497);
DELETE FROM spell_scripts WHERE id IN(71236, -71236, 72495, 72496, 72497, -72495, -72496, -72497);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71236, -71236, 72495, 72496, 72497, -72495, -72496, -72497) OR spell_effect IN(71236, -71236, 72495, 72496, 72497, -72495, -72496, -72497);
INSERT INTO spell_script_names VALUES(71236, 'spell_cultist_dark_martyrdom');
INSERT INTO spell_script_names VALUES(72495, 'spell_cultist_dark_martyrdom');
INSERT INTO spell_script_names VALUES(72496, 'spell_cultist_dark_martyrdom');
INSERT INTO spell_script_names VALUES(72497, 'spell_cultist_dark_martyrdom');

-- spell Dark Martyrdom (Adherent) (70903)
-- additional ids: 72498, 72499, 72500
DELETE FROM spell_script_names WHERE spell_id IN(70903, -70903, 72498, 72499, 72500, -72498, -72499, -72500);
DELETE FROM spell_scripts WHERE id IN(70903, -70903, 72498, 72499, 72500, -72498, -72499, -72500);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70903, -70903, 72498, 72499, 72500, -72498, -72499, -72500) OR spell_effect IN(70903, -70903, 72498, 72499, 72500, -72498, -72499, -72500);
INSERT INTO spell_script_names VALUES(70903, 'spell_cultist_dark_martyrdom');
INSERT INTO spell_script_names VALUES(72498, 'spell_cultist_dark_martyrdom');
INSERT INTO spell_script_names VALUES(72499, 'spell_cultist_dark_martyrdom');
INSERT INTO spell_script_names VALUES(72500, 'spell_cultist_dark_martyrdom');

-- spell Mana Barrier (70842)
DELETE FROM spell_script_names WHERE spell_id IN(70842, -70842);
DELETE FROM spell_scripts WHERE id IN(70842, -70842);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70842, -70842) OR spell_effect IN(70842, -70842);
INSERT INTO spell_script_names VALUES(70842, 'spell_deathwhisper_mana_barrier');

-- spell Vengeful Blast (71494)
REPLACE INTO spell_proc_event VALUES(71494, 0, 0, 0, 0, 0, 0, 16255, 0, 0, 0);

-- spell Dominate Mind (71289)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71289, -71289) OR spell_effect IN(71289, -71289);
REPLACE INTO spell_linked_spell VALUES(-71289, -73261, 0, 'Remove Scale Aura');



-- ###################
-- ### GUNSHIP BATTLE
-- ###################

-- clean spells
UPDATE `creature_template` SET `spell1`=0,`spell2`=0,`spell3`=0,`spell4`=0,`spell5`=0,`spell6`=0,`spell7`=0,`spell8`=0 WHERE `entry` IN 
(36838,36839,36970,36971,36948,38157,38639,38640,36939,38156,38638,38637,37540,38128,38699,38700,37215,38129,38701,38702,37116,38256,38693,38694,36969,38408,38689,38690,36978,38407,38687,38688,
36950,38406,38685,38686,36961,38261,38691,38692,37117,38257,38677,38678,36968,38403,38675,38676,36982,38405,38681,38682,36957,38404,38679,38680,36960,38262,38683,38684,37227,37488);

-- go Gunship Armory (202178, 202180, 202177, 202179), (201873, 201874, 201872, 201875)
UPDATE `gameobject_template` SET `faction`=94,`flags`=16 WHERE `entry` IN (202178,202180,202177,202179);
UPDATE `gameobject_template` SET `faction`=94,`flags`=16 WHERE `entry` IN (201873,201874,201872,201875);
SET @OGUID := 14732;
DELETE FROM `gameobject` WHERE `id`=202211;
DELETE FROM `gameobject` WHERE `guid` BETWEEN @OGUID AND @OGUID+7;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(@OGUID+0,202178,673,1,1,-19.87256,-14.17484,33.63771,4.71239,0,0,0,1,604800,255,1),
(@OGUID+1,202180,673,2,1,-19.87256,-14.17484,33.63771,4.71239,0,0,0,1,604800,255,1),
(@OGUID+2,202177,673,4,1,-19.87256,-14.17484,33.63771,4.71239,0,0,0,1,604800,255,1),
(@OGUID+3,202179,673,8,1,-19.87256,-14.17484,33.63771,4.71239,0,0,0,1,604800,255,1),
(@OGUID+4,201873,672,1,1,-45.44891,-0.062003,20.56404,0.2697698,0,0,0,1,604800,255,1),
(@OGUID+5,201874,672,2,1,-45.44891,-0.062003,20.56404,0.2697698,0,0,0,1,604800,255,1),
(@OGUID+6,201872,672,4,1,-45.44891,-0.062003,20.56404,0.2697698,0,0,0,1,604800,255,1),
(@OGUID+7,201875,672,8,1,-45.44891,-0.062003,20.56404,0.2697698,0,0,0,1,604800,255,1);
DELETE FROM `gameobject_loot_template` WHERE `entry` IN (28045,28072,28057,28090);
INSERT INTO `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
(28045,1,100,1,0,-12036,2),
(28045,49426,100,1,0,2,2), -- 10N, Emblem of Frost
(28072,1,100,1,0,-34251,3),
(28072,49426,100,1,0,2,2), -- 25N, Emblem of Frost
(28072,49908,38,1,0,1,1), -- 25N, Primordial Saronite
(28072,50274,-35,1,0,1,1), -- 25N, Shadowfrost Shard
(28057,1,100,1,0,-34263,2),
(28057,49426,100,1,0,2,2), -- 10H, Emblem of Frost
(28057,49908,38,1,0,1,1), -- 10H, Primordial Saronite
(28090,1,100,1,0,-34275,3),
(28090,49426,100,1,0,2,2), -- 25H, Emblem of Frost
(28090,49908,50,1,0,1,1), -- 25H, Primordial Saronite
(28090,50274,-75,1,0,1,1); -- 25H, Shadowfrost Shard

-- model info
UPDATE `creature_model_info` SET `bounding_radius`=0.520500,`combat_reach`=2.25000,`gender`=0 WHERE `modelid`=30508; -- Muradin Bronzebeard
UPDATE `creature_model_info` SET `bounding_radius`=0.558000,`combat_reach`=2.25000,`gender`=0 WHERE `modelid`=30416; -- High Overlord Saurfang
UPDATE `creature_model_info` SET `bounding_radius`=0.500000,`combat_reach`=1.00000,`gender`=2 WHERE `modelid`=31043; -- The Skybreaker
UPDATE `creature_model_info` SET `bounding_radius`=0.500000,`combat_reach`=1.00000,`gender`=2 WHERE `modelid`=31044; -- Orgrim's Hammer
UPDATE `creature_model_info` SET `bounding_radius`=1.250000,`combat_reach`=1.25000,`gender`=2 WHERE `modelid`=30615; -- Teleport Portal, Teleport Exit
UPDATE `creature_model_info` SET `bounding_radius`=0.364000,`combat_reach`=2.62500,`gender`=1 WHERE `modelid`=30609; -- Skybreaker Sorcerer
UPDATE `creature_model_info` SET `bounding_radius`=0.615825,`combat_reach`=3.01875,`gender`=1 WHERE `modelid`=30610; -- Skybreaker Sorcerer
UPDATE `creature_model_info` SET `bounding_radius`=0.615825,`combat_reach`=3.01875,`gender`=0 WHERE `modelid`=30611; -- Skybreaker Sorcerer
UPDATE `creature_model_info` SET `bounding_radius`=0.347000,`combat_reach`=1.50000,`gender`=0 WHERE `modelid`=30603; -- Skybreaker Rifleman
UPDATE `creature_model_info` SET `bounding_radius`=0.381700,`combat_reach`=1.65000,`gender`=0 WHERE `modelid`=30604; -- Skybreaker Rifleman
UPDATE `creature_model_info` SET `bounding_radius`=0.347000,`combat_reach`=1.50000,`gender`=1 WHERE `modelid`=30605; -- Skybreaker Rifleman
UPDATE `creature_model_info` SET `bounding_radius`=0.416400,`combat_reach`=1.80000,`gender`=0 WHERE `modelid`=30602; -- Skybreaker Mortar Soldier
UPDATE `creature_model_info` SET `bounding_radius`=0.306000,`combat_reach`=1.50000,`gender`=0 WHERE `modelid`=30598; -- Skybreaker Marine
UPDATE `creature_model_info` SET `bounding_radius`=0.306000,`combat_reach`=1.50000,`gender`=0 WHERE `modelid`=30599; -- Skybreaker Marine
UPDATE `creature_model_info` SET `bounding_radius`=1.000000,`combat_reach`=1.50000,`gender`=0 WHERE `modelid`=30600; -- Skybreaker Marine
UPDATE `creature_model_info` SET `bounding_radius`=0.208000,`combat_reach`=1.50000,`gender`=1 WHERE `modelid`=30601; -- Skybreaker Marine
UPDATE `creature_model_info` SET `bounding_radius`=0.397800,`combat_reach`=1.95000,`gender`=0 WHERE `modelid`=30606; -- Skybreaker Sergeant
UPDATE `creature_model_info` SET `bounding_radius`=0.367200,`combat_reach`=1.80000,`gender`=0 WHERE `modelid`=30607; -- Skybreaker Sergeant
UPDATE `creature_model_info` SET `bounding_radius`=0.382500,`combat_reach`=1.87500,`gender`=0 WHERE `modelid`=30608; -- Skybreaker Sergeant
UPDATE `creature_model_info` SET `bounding_radius`=0.670250,`combat_reach`=2.62500,`gender`=0 WHERE `modelid`=30741; -- Kor'kron Battle-Mage
UPDATE `creature_model_info` SET `bounding_radius`=0.670250,`combat_reach`=2.62500,`gender`=0 WHERE `modelid`=30742; -- Kor'kron Battle-Mage
UPDATE `creature_model_info` SET `bounding_radius`=0.670250,`combat_reach`=2.62500,`gender`=1 WHERE `modelid`=30743; -- Kor'kron Battle-Mage
UPDATE `creature_model_info` SET `bounding_radius`=0.670250,`combat_reach`=2.62500,`gender`=1 WHERE `modelid`=30744; -- Kor'kron Battle-Mage
UPDATE `creature_model_info` SET `bounding_radius`=0.306000,`combat_reach`=1.50000,`gender`=0 WHERE `modelid`=30739; -- Kor'kron Axethrower
UPDATE `creature_model_info` SET `bounding_radius`=0.306000,`combat_reach`=1.50000,`gender`=0 WHERE `modelid`=30740; -- Kor'kron Axethrower
UPDATE `creature_model_info` SET `bounding_radius`=0.459000,`combat_reach`=2.25000,`gender`=0 WHERE `modelid`=30748; -- Kor'kron Rocketeer
UPDATE `creature_model_info` SET `bounding_radius`=0.459000,`combat_reach`=2.25000,`gender`=1 WHERE `modelid`=30749; -- Kor'kron Rocketeer
UPDATE `creature_model_info` SET `bounding_radius`=0.372000,`combat_reach`=1.50000,`gender`=0 WHERE `modelid`=30750; -- Kor'kron Reaver
UPDATE `creature_model_info` SET `bounding_radius`=0.372000,`combat_reach`=1.50000,`gender`=0 WHERE `modelid`=30751; -- Kor'kron Reaver
UPDATE `creature_model_info` SET `bounding_radius`=0.236000,`combat_reach`=1.50000,`gender`=1 WHERE `modelid`=30752; -- Kor'kron Reaver
UPDATE `creature_model_info` SET `bounding_radius`=0.520833,`combat_reach`=2.25000,`gender`=0 WHERE `modelid`=30745; -- Kor'kron Sergeant
UPDATE `creature_model_info` SET `bounding_radius`=0.520833,`combat_reach`=2.25000,`gender`=0 WHERE `modelid`=30746; -- Kor'kron Sergeant
UPDATE `creature_model_info` SET `bounding_radius`=0.520833,`combat_reach`=2.25000,`gender`=0 WHERE `modelid`=30747; -- Kor'kron Sergeant

-- spawns
UPDATE `gameobject_template` SET `flags`=40 WHERE `entry` IN (201812,201811,201581,201580);
DELETE FROM `gameobject` WHERE `id`=201880;

DELETE FROM `creature` WHERE `guid` IN (201047,201030);
SET @CGUID := 133934;
DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID AND @CGUID+58;
INSERT INTO `creature` VALUES
(@CGUID+0,37540,672,15,1,31043,0,-13.1429,-0.36969,12.8909,0,604800,0,0,1,0,0,0,0,0),
(@CGUID+7,36948,672,15,1,0,0,1.34481,-0.077413,20.8492,3.15905,604800,0,0,1,0,0,0,0,0),
(@CGUID+22,36939,673,15,1,0,0,36.4055,0.184604,36.7153,3.10669,604800,0,0,1,0,0,0,0,0),
(@CGUID+39,37215,673,15,1,31044,0,3.8386,0.183334,24.1005,0,604800,0,0,1,0,0,0,0,0),
(@CGUID+52,36948,672,15,1,0,0,13.51547,-0.160213,20.87252,3.106686,604800,0,0,1,0,0,0,0,0),
(@CGUID+53,36838,672,15,1,0,0,-6.155821,-25.23873,21.70498,4.712389,604800,0,0,1,0,0,0,0,0),
(@CGUID+54,36838,672,15,1,0,0,-33.6443,-24.06576,21.68014,4.712389,604800,0,0,1,0,0,0,0,0),
(@CGUID+55,36838,672,10,1,0,0,-24.66251,-24.52669,21.64428,4.712389,604800,0,0,1,0,0,0,0,0),
(@CGUID+56,36838,672,10,1,0,0,-15.35026,-24.90373,21.62014,4.712389,604800,0,0,1,0,0,0,0,0),
(@CGUID+38,36839,673,15,1,0,0,-15.6908,31.1423,34.391,1.5708,604800,0,0,1,0,0,0,0,0),
(@CGUID+40,36839,673,15,1,0,0,18.1923,29.8694,36.3265,1.55334,604800,0,0,1,0,0,0,0,0),
(@CGUID+57,36839,673,10,1,0,0,11.17875,30.73435,35.95937,1.553343,604800,0,0,1,0,0,0,0,0),
(@CGUID+58,36839,673,10,1,0,0,-8.200627,31.49327,34.52401,1.553343,604800,0,0,1,0,0,0,0,0),
(@CGUID+4,37519,672,15,1,0,0,-28.275,15.5946,20.5379,0,604800,0,0,1,0,0,0,0,0),
(@CGUID+14,37519,672,15,1,0,0,39.4475,0.136515,25.2321,0,604800,0,0,1,0,0,0,0,0),
(@CGUID+28,37519,673,15,1,0,0,-19.9011,-11.1976,33.4849,0,604800,0,0,1,0,0,0,0,0),
(@CGUID+29,37519,673,15,1,0,0,22.1763,-11.4125,34.9973,0,604800,0,0,1,0,0,0,0,0),
(@CGUID+43,37182,672,15,1,0,0,42.78902,-0.010491,25.24052,3.124139,604800,0,0,1,0,0,0,0,0),
(@CGUID+24,37833,673,15,1,0,0,60.4547,0.021568,38.7034,3.12414,604800,0,0,1,0,0,0,0,0),
(@CGUID+23,37184,673,15,1,0,0,38.5985,18.0196,36.6939,3.94444,604800,0,0,1,0,0,0,0,0),
(@CGUID+42,37184,672,15,1,0,0,18.8226,9.700101,20.41841,3.106686,604800,0,0,1,0,0,0,0,0),
(@CGUID+1,37547,672,15,1,0,0,-50.1652,9.71624,23.5871,0,604800,0,0,1,0,0,0,0,0),
(@CGUID+2,37547,672,15,1,0,0,-34.2702,-26.1897,21.3748,0,604800,0,0,1,0,0,0,0,0),
(@CGUID+3,37547,672,15,1,0,0,-41.4456,-7.6475,20.4975,0,604800,0,0,1,0,0,0,0,0),
(@CGUID+5,37547,672,15,1,0,0,-11.6446,-19.8518,20.8843,0,604800,0,0,1,0,0,0,0,0),
(@CGUID+6,37547,672,15,1,0,0,-19.8822,-6.57876,20.5744,0,604800,0,0,1,0,0,0,0,0),
(@CGUID+9,37547,672,15,1,0,0,0.554884,-1.2329,20.5371,0,604800,0,0,1,0,0,0,0,0),
(@CGUID+10,37547,672,15,1,0,0,19.7229,-2.19379,33.0698,0,604800,0,0,1,0,0,0,0,0),
(@CGUID+11,37547,672,15,1,0,0,8.5994,-28.5585,24.7992,0,604800,0,0,1,0,0,0,0,0),
(@CGUID+12,37547,672,15,1,0,0,11.4584,16.3662,20.5419,0,604800,0,0,1,0,0,0,0,0),
(@CGUID+13,37547,672,15,1,0,0,38.9434,-33.808,25.3962,0,604800,0,0,1,0,0,0,0,0),
(@CGUID+15,37547,673,15,1,0,0,53.1563,29.0877,44.7302,0,604800,0,0,1,0,0,0,0,0),
(@CGUID+16,37547,673,15,1,0,0,-58.1547,0.748094,41.8766,0,604800,0,0,1,0,0,0,0,0),
(@CGUID+17,37547,673,15,1,0,0,-39.4953,16.6872,34.3943,0,604800,0,0,1,0,0,0,0,0),
(@CGUID+18,37547,673,15,1,0,0,-27.097,27.9929,34.3631,0,604800,0,0,1,0,0,0,0,0),
(@CGUID+19,37547,673,15,1,0,0,-15.0316,12.0216,33.8629,0,604800,0,0,1,0,0,0,0,0),
(@CGUID+20,37547,673,15,1,0,0,9.46182,16.1523,35.1091,0,604800,0,0,1,0,0,0,0,0),
(@CGUID+21,37547,673,15,1,0,0,27.6276,27.103,36.8003,0,604800,0,0,1,0,0,0,0,0),
(@CGUID+25,37547,673,15,1,0,0,4.7803,-29.0523,35.0963,0,604800,0,0,1,0,0,0,0,0),
(@CGUID+26,37547,673,15,1,0,0,23.4778,-7.53715,35.8162,0,604800,0,0,1,0,0,0,0,0),
(@CGUID+27,37547,673,15,1,0,0,-5.60755,-6.35065,34.0036,0,604800,0,0,1,0,0,0,0,0),
(@CGUID+44,36970,672,15,1,0,0,42.80151,25.06216,31.84073,4.756748,604800,0,0,1,0,0,0,0,0),
(@CGUID+45,36970,672,15,1,0,0,35.651,20.29211,25.11613,1.58825,604800,0,0,1,0,0,0,0,0),
(@CGUID+46,36970,672,15,1,0,0,29.25061,-6.920386,23.37144,3.455752,604800,0,0,1,0,0,0,0,0),
(@CGUID+47,36970,672,15,1,0,0,35.57132,-20.18365,25.1162,4.712389,604800,0,0,1,0,0,0,0,0),
(@CGUID+48,36970,672,15,1,0,0,9.26111,-22.73216,21.84549,5.864306,604800,0,0,1,0,0,0,0,0),
(@CGUID+49,36970,672,15,1,0,0,-36.38065,2.928953,20.5322,1.570796,604800,0,0,1,0,0,0,0,0),
(@CGUID+50,36970,672,15,1,0,0,-36.22218,-2.960294,20.53312,4.694936,604800,0,0,1,0,0,0,0,0),
(@CGUID+51,36970,672,15,1,0,0,-64.70975,4.575944,23.52326,2.094395,604800,0,0,1,0,0,0,0,0),
(@CGUID+30,36971,673,15,1,0,0,-56.4357,12.2929,34.6332,2.51327,604800,0,0,1,0,0,0,0,0),
(@CGUID+31,36971,673,15,1,0,0,30.8803,22.7656,36.3547,1.69297,604800,0,0,1,0,0,0,0,0),
(@CGUID+32,36971,673,15,1,0,0,-26.8348,13.4803,34.6954,5.3058,604800,0,0,1,0,0,0,0,0),
(@CGUID+33,36971,673,15,1,0,0,-29.3313,-23.2348,33.9633,2.80988,604800,0,0,1,0,0,0,0,0),
(@CGUID+34,36971,673,15,1,0,0,-26.1657,-13.3904,34.679,0.890118,604800,0,0,1,0,0,0,0,0),
(@CGUID+35,36971,673,15,1,0,0,60.0911,-6.35005,38.9569,2.54818,604800,0,0,1,0,0,0,0,0),
(@CGUID+36,36971,673,15,1,0,0,59.6708,6.21392,39.0067,3.735,604800,0,0,1,0,0,0,0,0),
(@CGUID+37,36971,673,15,1,0,0,30.9602,-22.9078,36.363,4.46804,604800,0,0,1,0,0,0,0,0),
(@CGUID+41,36971,673,15,1,0,0,-54.3389,-14.5897,34.4998,3.9619,604800,0,0,1,0,0,0,0,0);

-- npc Orgrim's Hammer (37215, 38129, 38701, 38702) -- dummy transport npc for health
UPDATE creature_template SET `difficulty_entry_1`=38129,`difficulty_entry_2`=38701,`difficulty_entry_3`=38702, `ScriptName`='npc_gunship' WHERE entry=37215;
UPDATE creature_template SET `minlevel`=83,`maxlevel`=83,`exp`=2,`faction`=35,`speed_walk`=1,`speed_run`=1.42857,`unit_flags`=0,`unit_flags2`=0,`dynamicflags`=0,`baseattacktime`=2000, AIName='', `InhabitType`=4,RegenHealth=1,`flags_extra`=0+0x200000,`mechanic_immune_mask`=650854271 WHERE `entry` IN (37215,38129,38701,38702);

-- npc The Skybreaker (37540, 38128, 38699, 38700) -- dummy transport npc for health
UPDATE `creature_template` SET `difficulty_entry_1`=38128,`difficulty_entry_2`=38699,`difficulty_entry_3`=38700, `ScriptName`='npc_gunship' WHERE `entry`=37540;
UPDATE `creature_template` SET `minlevel`=83,`maxlevel`=83,`exp`=2,`faction`=35,`speed_walk`=1,`speed_run`=1.42857,`unit_flags`=0,`unit_flags2`=0,`dynamicflags`=0,`baseattacktime`=2000, AIName='', `InhabitType`=4,RegenHealth=1,`flags_extra`=0+0x200000,`mechanic_immune_mask`=650854271 WHERE `entry` IN (37540,38128,38699,38700);

-- npc High Overlord Saurfang (36939, 38156, 38637, 38638)
UPDATE creature SET equipment_id=1 WHERE id=36939;
UPDATE `creature_template` SET `difficulty_entry_1`=38156,`difficulty_entry_2`=38637,`difficulty_entry_3`=38638, `ScriptName`='npc_high_overlord_saurfang_igb' WHERE `entry`=36939;
UPDATE `creature_template` SET `gossip_menu_id`=10954,`minlevel`=83,`maxlevel`=83,`exp`=2,`faction`=83,`npcflag`=0x1,`speed_walk`=1,`speed_run`=1.71429,`unit_flags`=0x8000,`unit_flags2`=0,`dynamicflags`=0,`baseattacktime`=1500, AIName='', `InhabitType`=1,RegenHealth=1,`flags_extra`=0+0x200000,`mechanic_immune_mask`=650854271 WHERE `entry` IN (36939,38156,38637,38638);
UPDATE creature_template SET rank=3, mindmg=4333, maxdmg=5923, attackpower=300, dmg_multiplier=3 WHERE entry=36939;
UPDATE creature_template SET rank=3, mindmg=3503, maxdmg=4783, attackpower=300, dmg_multiplier=5 WHERE entry=38156;
UPDATE creature_template SET rank=3, mindmg=6507, maxdmg=8883, attackpower=300, dmg_multiplier=3 WHERE entry=38637;
UPDATE creature_template SET rank=3, mindmg=4670, maxdmg=6375, attackpower=300, dmg_multiplier=5 WHERE entry=38638;
DELETE FROM `creature_equip_template` WHERE `entry` IN (36939, 38156, 38637, 38638);
INSERT INTO `creature_equip_template` (`entry`,`id`,`itemEntry1`,`itemEntry2`,`itemEntry3`) VALUES(36939,1,49773,0,0),(38156,1,49773,0,0),(38637,1,49773,0,0),(38638,1,49773,0,0);
DELETE FROM `creature_text` WHERE `entry`=36939 AND `groupid` BETWEEN 0 AND 13;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(36939, 0,0,'Rise up, sons and daughters of the Horde! Today we battle a hated enemy of the Horde! LOK''TAR OGAR!',14,0,100,0,0,17087,'High Overlord Saurfang - SAY_SAURFANG_INTRO_1'),
(36939, 1,0,'Kor''kron, take us out!',14,0,100,0,0,17088,'High Overlord Saurfang - SAY_SAURFANG_INTRO_2'),
(36939, 2,0,'What is that? Something approaching in the distance.',14,0,100,0,0,17089,'High Overlord Saurfang - SAY_SAURFANG_INTRO_3'),
(36939, 3,0,'ALLIANCE GUNSHIP! ALL HANDS ON DECK!',14,0,100,0,0,17090,'High Overlord Saurfang - SAY_SAURFANG_INTRO_4'),
(36939, 4,0,'You answer to Saurfang now!',14,0,100,0,0,17091,'High Overlord Saurfang - SAY_SAURFANG_INTRO_5'),
(36939, 5,0,'You will know our business soon. Kor''kron, ANNIHILATE THEM!',14,0,100,0,0,17092,'High Overlord Saurfang - SAY_SAURFANG_INTRO_6'),
(36939, 6,0,'This is not your battle, dwarf. Back down or we will be forced to destroy your ship.',14,0,100,0,0,17093,'High Overlord Saurfang - SAY_SAURFANG_INTRO_A'),
(36939, 7,0,'You DARE board my ship? Your death will come swiftly.',14,0,100,0,0,17083,'High Overlord Saurfang - SAY_SAURFANG_BOARD'),
(36939, 8,0,'Reavers, Sergeants, attack!',14,0,100,0,0,17081,'High Overlord Saurfang - SAY_SAURFANG_ENTER_SKYBREAKER'),
(36939, 9,0,'Axethrowers, hurl faster!',14,0,100,0,0,17079,'High Overlord Saurfang - SAY_SAURFANG_AXETHROWERS'),
(36939,10,0,'Rocketeers, reload!',14,0,100,0,0,17080,'High Overlord Saurfang - SAY_SAURFANG_ROCKETEERS'),
(36939,11,0,'We''re taking hull damage, get a battle-mage out here to shut down those cannons!',14,0,100,0,0,17082,'High Overlord Saurfang - SAY_SAURFANG_MAGES'),
(36939,12,0,'The Alliance falter. Onward to the Lich King!',14,0,100,0,0,17084,'High Overlord Saurfang - SAY_SAURFANG_VICTORY'),
(36939,13,0,'Damage control! Put those fires out. You haven''t seen the last of the Horde!',14,0,100,0,0,17085,'High Overlord Saurfang - SAY_SAURFANG_WIPE');
DELETE FROM `gossip_menu` WHERE `entry` IN (10954);
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES(10954,15219);
DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (10954);
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES(10954,0,0,'My companions are all accounted for, Saurfang. Let''s go!',1,1,0,0,0,0,'');

-- npc Muradin Bronzebeard (36948, 38157, 38639, 38640)
UPDATE creature SET equipment_id=1 WHERE id=36948;
UPDATE `creature_template` SET `difficulty_entry_1`=38157,`difficulty_entry_2`=38639,`difficulty_entry_3`=38640, `ScriptName`='npc_muradin_bronzebeard_igb' WHERE `entry`=36948;
UPDATE `creature_template` SET `gossip_menu_id`=10875,`minlevel`=83,`maxlevel`=83,`exp`=2,`faction`=84,`npcflag`=0x1,`speed_walk`=1,`speed_run`=1.71429,`unit_flags`=0x8000,`unit_flags2`=0,`dynamicflags`=0,`baseattacktime`=1500, AIName='', `InhabitType`=1,RegenHealth=1,`flags_extra`=0+0x200000,`mechanic_immune_mask`=650854271 WHERE `entry` IN (36948,38157,38639,38640);
UPDATE creature_template SET rank=3, mindmg=4333, maxdmg=5923, attackpower=300, dmg_multiplier=3 WHERE entry=36948;
UPDATE creature_template SET rank=3, mindmg=3503, maxdmg=4783, attackpower=300, dmg_multiplier=5 WHERE entry=38157;
UPDATE creature_template SET rank=3, mindmg=6507, maxdmg=8883, attackpower=300, dmg_multiplier=3 WHERE entry=38639;
UPDATE creature_template SET rank=3, mindmg=4670, maxdmg=6375, attackpower=300, dmg_multiplier=5 WHERE entry=38640;
DELETE FROM `creature_equip_template` WHERE `entry` IN (36948, 38157, 38639, 38640);
INSERT INTO `creature_equip_template` (`entry`,`id`,`itemEntry1`,`itemEntry2`,`itemEntry3`) VALUES(36948,1,49775,49774,0),(38157,1,49775,49774,0),(38639,1,49775,49774,0),(38640,1,49775,49774,0);
DELETE FROM `creature_text` WHERE `entry`=36948 AND `groupid` BETWEEN 0 AND 14;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(36948, 0,0,'Fire up the engines! We got a meetin'' with destiny, lads!',14,0,100,0,0,16962,'Muradin Bronzebeard - SAY_MURADIN_INTRO_1'),
(36948, 1,0,'Hold on to yer hats!',14,0,100,0,0,16963,'Muradin Bronzebeard - SAY_MURADIN_INTRO_2'),
(36948, 2,0,'What in the world is that? Grab me spyglass, crewman!',14,0,100,0,0,16964,'Muradin Bronzebeard - SAY_MURADIN_INTRO_3'),
(36948, 3,0,'By me own beard! HORDE SAILIN'' IN FAST ''N HOT!',14,0,100,0,0,16965,'Muradin Bronzebeard - SAY_MURADIN_INTRO_4'),
(36948, 4,0,'EVASIVE ACTION! MAN THE GUNS!',14,0,100,0,0,16966,'Muradin Bronzebeard - SAY_MURADIN_INTRO_5'),
(36948, 5,0,'Cowardly dogs! Ye blindsided us!',14,0,100,0,0,16967,'Muradin Bronzebeard - SAY_MURADIN_INTRO_6'),
(36948, 6,0,'Not me battle? I dunnae who ye think ye are, mister, but I got a score to settle with Arthas and yer not gettin'' in me way! FIRE ALL GUNS! FIRE! FIRE!',14,0,100,0,0,16968,'Muradin Bronzebeard - SAY_MURADIN_INTRO_7'),
(36948, 7,0,'Move yer jalopy or we''ll blow it out of the sky, orc! The Horde''s got no business here.',14,0,100,0,0,16969,'Muradin Bronzebeard - SAY_MURADIN_INTRO_H'),
(36948, 8,0,'What''s this then?! Ye won''t be takin'' this son o'' Ironforge''s vessel without a fight!',14,0,100,0,0,16958,'Muradin Bronzebeard - SAY_MURADIN_BOARD'),
(36948, 9,0,'Marines, Sergeants, attack!',14,0,100,0,0,16956,'Muradin Bronzebeard - SAY_MURADIN_ENTER_ORGRIMMS_HAMMER'),
(36948,10,0,'Riflemen, shoot faster!',14,0,100,0,0,16954,'Muradin Bronzebeard - SAY_MURADIN_RIFLEMAN'),
(36948,11,0,'Mortar team, reload!',14,0,100,0,0,16955,'Muradin Bronzebeard - SAY_MURADIN_MORTAR'),
(36948,12,0,'We''re taking hull damage, get a sorcerer out here to shut down those cannons!',14,0,100,0,0,16957,'Muradin Bronzebeard - SAY_MURADIN_SORCERERS'),
(36948,13,0,'Don''t say I didn''t warn ya, scoundrels! Onward, brothers and sisters!',14,0,100,0,0,16959,'Muradin Bronzebeard - SAY_MURADIN_VICTORY'),
(36948,14,0,'Captain Bartlett, get us out of here! We''re taken too much damage to stay afloat!',14,0,100,0,0,16960,'Muradin Bronzebeard - SAY_MURADIN_WIPE');
DELETE FROM `gossip_menu` WHERE `entry` IN (10875);
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES(10875,15101);
DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (10875);
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES(10875,0,0,'My companions are all accounted for, Muradin. Let''s go!',1,1,0,0,0,0,'');

-- npc Alliance Gunship Cannon (36838)
UPDATE `creature_template` SET `difficulty_entry_1`=0,`difficulty_entry_2`=0,`difficulty_entry_3`=0, AIName='', `ScriptName`='' WHERE `entry`=36838;
UPDATE `creature_template` SET `minlevel`=80,`maxlevel`=80,`exp`=0,`faction`=1665,`npcflag`=0x1000000,`speed_walk`=1,`speed_run`=1,`unit_class`=4,`unit_flags`=4+0x4000,`unit_flags2`=0,`dynamicflags`=0,`baseattacktime`=2000,`spell1`=69399,`spell2`=70174,`VehicleId`=554,`InhabitType`=1,RegenHealth=1,`flags_extra`=0+0x200000,`mechanic_immune_mask`=650854271 WHERE `entry`=36838;
DELETE FROM `creature_text` WHERE `entry` IN (36838);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES(36838,0,0,'|TInterface\\Icons\\Spell_Fire_Flameshock.blp:20|t|cFFBC0000 OVERHEAT  |r|TInterface\\Icons\\Spell_Fire_Flameshock.blp:20|t',42,0,100,0,0,0,'Alliance Gunship Cannon - SAY_OVERHEAT');
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` IN (36838);
INSERT INTO `npc_spellclick_spells` (`npc_entry`,`spell_id`,`cast_flags`,`user_type`) VALUES(36838,70510,1,0);
REPLACE INTO `creature_template_addon` VALUES(36838,0,0,0,1,0,'69470');

-- npc Horde Gunship Cannon (36839)
UPDATE `creature_template` SET `difficulty_entry_1`=0,`difficulty_entry_2`=0,`difficulty_entry_3`=0, AIName='', `ScriptName`='' WHERE `entry`=36839;
UPDATE `creature_template` SET `minlevel`=80,`maxlevel`=80,`exp`=0,`faction`=1665,`npcflag`=0x1000000,`speed_walk`=1,`speed_run`=1,`unit_class`=4,`unit_flags`=4+0x4000,`unit_flags2`=0,`dynamicflags`=0,`baseattacktime`=2000,`spell1`=70172,`spell2`=69401,`VehicleId`=555,`InhabitType`=1,RegenHealth=1,`flags_extra`=0+0x200000,`mechanic_immune_mask`=650854271 WHERE `entry`=36839;
DELETE FROM `creature_text` WHERE `entry` IN (36839);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES(36839,0,0,'|TInterface\\Icons\\Spell_Fire_Flameshock.blp:20|t|cFFBC0000 OVERHEAT  |r|TInterface\\Icons\\Spell_Fire_Flameshock.blp:20|t',42,0,100,0,0,0,'Horde Gunship Cannon - SAY_OVERHEAT');
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` IN (36839);
INSERT INTO `npc_spellclick_spells` (`npc_entry`,`spell_id`,`cast_flags`,`user_type`) VALUES(36839,70510,1,0);
DELETE FROM `creature_template_addon` WHERE `entry` IN (36839);
REPLACE INTO `creature_template_addon` VALUES(36839,0,0,0,1,0,'69470');

-- npc Safe Area (IGB) (37519)
UPDATE creature_template SET modelid1=15435, modelid2=0, modelid3=0, modelid4=0 WHERE entry=37519;
DELETE FROM `creature_addon` WHERE `guid` IN (@CGUID+04,@CGUID+14,@CGUID+28,@CGUID+29);
INSERT INTO `creature_addon` (`guid`,`mount`,`bytes1`,`bytes2`,`auras`) VALUES(@CGUID+04,0,0x3000000,0x1,'70120'),(@CGUID+14,0,0x3000000,0x1,'70120'),(@CGUID+28,0,0x3000000,0x1,'70121'),(@CGUID+29,0,0x3000000,0x1,'70121');

-- npc High Captain Justin Bartlett (37182)
UPDATE `creature_template` SET `minlevel`=80,`maxlevel`=80,`exp`=2,`faction`=84,`speed_walk`=1,`speed_run`=1.14286,`unit_class`=1,`unit_flags`=0x300,`unit_flags2`=0,`dynamicflags`=0,`baseattacktime`=2000,`InhabitType`=1,`flags_extra`=0+0x200000,`mechanic_immune_mask`=650854271 WHERE `entry`=37182;
DELETE FROM `creature_equip_template` WHERE `entry` IN (37182);
INSERT INTO `creature_equip_template` (`entry`,`id`,`itemEntry1`,`itemEntry2`,`itemEntry3`) VALUES(37182,1,42757,0,2552);

-- npc Sky-Reaver Korm Blackscar (37833)
UPDATE `creature_template` SET `minlevel`=80,`maxlevel`=80,`exp`=2,`faction`=83,`speed_walk`=1,`speed_run`=1.14286,`unit_class`=1,`unit_flags`=0x300,`unit_flags2`=0,`dynamicflags`=0,`baseattacktime`=2000,`InhabitType`=1,`flags_extra`=0+0x200000,`mechanic_immune_mask`=650854271 WHERE `entry`=37833;
DELETE FROM `creature_equip_template` WHERE `entry` IN (37833);
INSERT INTO `creature_equip_template` (`entry`,`id`,`itemEntry1`,`itemEntry2`,`itemEntry3`) VALUES(37833,1,43175,0,21554);

-- npc Zafod Boombox (37184)
UPDATE `creature_template` SET faction=35, `npcflag`=1,`gossip_menu_id`=10885,`mechanic_immune_mask`=650854271, AIName='', RegenHealth=1, flags_extra=0+0x200000, `ScriptName`='npc_zafod_boombox' WHERE `entry`=37184;
DELETE FROM `creature_text` WHERE `entry` IN (37184);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(37184,0,0,'Rocket Pack Active!',15,0,100,0,0,0,'Zafod Boombox - SAY_ZAFOD_ROCKET_PACK_ACTIVE'),
(37184,1,0,'Rocket Pack Disabled. Move closer to Zafod Boombox to re-activate.',15,0,100,0,0,0,'Zafod Boombox - SAY_ZAFOD_ROCKET_PACK_DISABLED');
DELETE FROM `gossip_menu` WHERE `entry` IN (10885);
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES(10885,15134),(10885,15123);
DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (10885);
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES(10885,0,0,'Yeah, I''m sure safety is your top priority. Give me a rocket pack.',1,1,0,0,0,0,'');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=10885;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=10885;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`Comment`) VALUES
(15,10885,0,0,2,49278,1,0,1,'Gossip Option - Show Option if player does not have item 49278'),
(14,10885,15134,0,2,49278,1,0,1,'Gossip Option - Show text 15134 if player does not have item 49278'),
(14,10885,15123,0,2,49278,1,0,0,'Gossip Option - Show text 15123 if player has item 49278');
REPLACE INTO `creature_template_addon` VALUES(37184,0,0,0,1,0,'69188 70348');

-- spell Rocket Pack (68645, 68721, 73077, 69188), Rocket Pack Useable (70348)
DELETE FROM spell_script_names WHERE spell_id IN(68645, 68721, 73077, 69188, 70348, -68645, -68721, -73077, -69188, -70348);
DELETE FROM spell_scripts WHERE id IN(68645, 68721, 73077, 69188, 70348, -68645, -68721, -73077, -69188, -70348);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(68645, 68721, 73077, 69188, 70348, -68645, -68721, -73077, -69188, -70348) OR spell_effect IN(68645, 68721, 73077, 69188, 70348, -68645, -68721, -73077, -69188, -70348);
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(13,17) AND SourceEntry IN(68645, 68721, 73077, 69188, 70348, -68645, -68721, -73077, -69188, -70348);
INSERT INTO spell_script_names VALUES(68721,'spell_igb_rocket_pack');
INSERT INTO spell_script_names VALUES(70348,'spell_igb_rocket_pack_useable');
INSERT INTO `conditions` VALUES(17,0,68645,0,0,1,0,70348,0,0,0,173,0,'','Rocket Pack - require Rocket Pack Useable');
INSERT INTO `spell_linked_spell` VALUES(68645,68721,1,'Rocket Pack - additional aura');
INSERT INTO `spell_linked_spell` VALUES(73077,69188,2,'Rocket Pack - linked aura');
INSERT INTO `spell_linked_spell` VALUES(-73077,-69188,0,'Rocket Pack - linked aura');

-- spell Teleport to Enemy Ship (70104)
DELETE FROM spell_script_names WHERE spell_id IN(70104, -70104);
DELETE FROM spell_scripts WHERE id IN(70104, -70104);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70104, -70104) OR spell_effect IN(70104, -70104);
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(13,17) AND SourceEntry IN(70104, -70104);
INSERT INTO `spell_script_names` VALUES(70104,'spell_igb_teleport_to_enemy_ship');
INSERT INTO `conditions` VALUES(13,1,70104,0,0,31,0,3,37488,0,0,0,0,'','Teleport to Enemy Ship - target Teleport Exit');

-- npc Teleport Portal (37227), Teleport Exit (37488)
UPDATE `creature_template` SET `minlevel`=81,`maxlevel`=81,`exp`=0,`faction`=35,`npcflag`=0x1000000,`speed_walk`=1,`speed_run`=1,`unit_class`=1,`unit_flags`=0,`unit_flags2`=0x800,`dynamicflags`=0,`baseattacktime`=2000,`InhabitType`=1,`flags_extra`=0,`mechanic_immune_mask`=650854271 WHERE `entry`=37227;
UPDATE `creature_template` SET `minlevel`=81,`maxlevel`=81,`exp`=0,`faction`=35,`npcflag`=0,`speed_walk`=1,`speed_run`=1,`unit_class`=1,`unit_flags`=0x2000000,`unit_flags2`=0x800,`dynamicflags`=0,`baseattacktime`=2000,`InhabitType`=1,`flags_extra`=0,`mechanic_immune_mask`=650854271 WHERE `entry`=37488;
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` IN (37227);
INSERT INTO `npc_spellclick_spells` VALUES(37227,70104,3,0);
DELETE FROM `creature_template_addon` WHERE `entry` IN (37488);
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`auras`) VALUES(37488,0,0x2000000,0x1,'');

-- spell Check for Players (70332, 70331)
DELETE FROM spell_script_names WHERE spell_id IN(70332, 70331, -70332, -70331);
DELETE FROM spell_scripts WHERE id IN(70332, 70331, -70332, -70331);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70332, 70331, -70332, -70331) OR spell_effect IN(70332, 70331, -70332, -70331);
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(13,17) AND SourceEntry IN(70332, 70331, -70332, -70331);
INSERT INTO `spell_script_names` VALUES(70331,'spell_igb_check_for_players');

-- spell Gunship Fall Teleport (67335)
DELETE FROM spell_script_names WHERE spell_id IN(67335, -67335);
DELETE FROM spell_scripts WHERE id IN(67335, -67335);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(67335, -67335) OR spell_effect IN(67335, -67335);
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(13,17) AND SourceEntry IN(67335, -67335);
INSERT INTO `spell_script_names` VALUES(67335,'spell_igb_gunship_fall_teleport');
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`Comment`) VALUES
(13,1,67335,0,31,3,37540,0,0,'Gunship Fall Teleport - target The Skybreaker'),
(13,1,67335,1,31,3,37215,0,0,'Gunship Fall Teleport - target Orgrim''s Hammer');

-- spell Lock Players and Tap Chest (72347)
DELETE FROM spell_script_names WHERE spell_id IN(72347, -72347);
DELETE FROM spell_scripts WHERE id IN(72347, -72347);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(72347, -72347) OR spell_effect IN(72347, -72347);
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(13,17) AND SourceEntry IN(72347, -72347);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`Comment`) 
VALUES(13,1,72347,0,31,3,38569,0,0,'Lock Players and Tap Chest - target Martyr Stalker (IGB/Saurfang)');

-- spell Explosion (72134, 70443), Explosion (72137, 70444)
DELETE FROM spell_script_names WHERE spell_id IN(72134, 70443, -72134, -70443, 72137, 70444, -72137, -70444);
DELETE FROM spell_scripts WHERE id IN(72134, 70443, -72134, -70443, 72137, 70444, -72137, -70444);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(72134, 70443, -72134, -70443, 72137, 70444, -72137, -70444) OR spell_effect IN(72134, 70443, -72134, -70443, 72137, 70444, -72137, -70444);
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(13,17) AND SourceEntry IN(72134, 70443, -72134, -70443, 72137, 70444, -72137, -70444);
INSERT INTO spell_script_names VALUES(72134, 'spell_igb_explosion_main');
INSERT INTO spell_script_names VALUES(72137, 'spell_igb_explosion_main');
INSERT INTO spell_script_names VALUES(70443, 'spell_igb_explosion');
INSERT INTO spell_script_names VALUES(70444, 'spell_igb_explosion');
INSERT INTO `conditions` VALUES
(13,1,70443,0,0,31,0,4,0,0,0,0,0,'','Explosion - target players'),
(13,1,70444,0,0,31,0,3,37116,0,0,0,0,'','Explosion - target Skybreaker Sorcerer'),
(13,1,70444,0,1,31,0,3,36969,0,0,0,0,'','Explosion - target Skybreaker Rifleman'),
(13,1,70444,0,2,31,0,3,36978,0,0,0,0,'','Explosion - target Skybreaker Mortar Soldier'),
(13,1,70444,0,3,31,0,3,37117,0,0,0,0,'','Explosion - target Kor''kron Battle-Mage'),
(13,1,70444,0,4,31,0,3,36968,0,0,0,0,'','Explosion - target Kor''kron Axethrower'),
(13,1,70444,0,5,31,0,3,36982,0,0,0,0,'','Explosion - target Kor''kron Rocketeer');

-- npc Gunship Hull (37547)
UPDATE creature_template SET modelid1=11686, modelid2=0, modelid3=0, modelid4=0, faction=35, AIName='NullCreatureAI', ScriptName='', flags_extra=128 WHERE entry=37547;

-- spell Teleport Players on Reset (A) (70446), Teleport Players On Reset (H) (71284), Teleport Players On Victory (72340)
DELETE FROM spell_script_names WHERE spell_id IN(70446, 71284, 72340, -70446, -71284, -72340);
DELETE FROM spell_scripts WHERE id IN(70446, 71284, 72340, -70446, -71284, -72340);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70446, 71284, 72340, -70446, -71284, -72340) OR spell_effect IN(70446, 71284, 72340, -70446, -71284, -72340);
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(13,17) AND SourceEntry IN(70446, 71284, 72340, -70446, -71284, -72340);
INSERT INTO `spell_script_names` VALUES(72340,'spell_igb_teleport_players_on_victory');
INSERT INTO `conditions` VALUES(13,2,70446,0,0,31,0,4,0,0,0,0,0,'','Teleport Players on Reset - target players');
INSERT INTO `conditions` VALUES(13,2,71284,0,0,31,0,4,0,0,0,0,0,'','Teleport Players on Reset - target players');
INSERT INTO `conditions` VALUES(13,2,72340,0,0,31,0,4,0,0,0,0,0,'','Teleport Players on Reset - target players');
DELETE FROM `spell_target_position` WHERE `id` IN (70446,71284,72340);
INSERT INTO `spell_target_position` VALUES
(70446,1,631,-437.078,2390.10,191.233,1.57080),
(71284,1,631,-437.447,2032.51,191.234,4.73831),
(72340,1,631,-548.983,2211.24,539.290,0.00576);

-- spell Achievement (72959), Award Reputation - Boss Kill (73843, 73844, 73845, 73846)
DELETE FROM spell_script_names WHERE spell_id IN(72959, 73843, 73844, 73845, 73846, -72959, -73843, -73844, -73845, -73846);
DELETE FROM spell_scripts WHERE id IN(72959, 73843, 73844, 73845, 73846, -72959, -73843, -73844, -73845, -73846);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(72959, 73843, 73844, 73845, 73846, -72959, -73843, -73844, -73845, -73846) OR spell_effect IN(72959, 73843, 73844, 73845, 73846, -72959, -73843, -73844, -73845, -73846);
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(13,17) AND SourceEntry IN(72959, 73843, 73844, 73845, 73846, -72959, -73843, -73844, -73845, -73846);
INSERT INTO `conditions` VALUES(13,1,72959,0,0,31,0,4,0,0,0,0,0,'','Achievement - target players');
INSERT INTO `conditions` VALUES(13,1,73843,0,0,31,0,4,0,0,0,0,0,'','Award Reputation - Boss Kill - target players');
INSERT INTO `conditions` VALUES(13,1,73844,0,0,31,0,4,0,0,0,0,0,'','Award Reputation - Boss Kill - target players');
INSERT INTO `conditions` VALUES(13,1,73845,0,0,31,0,4,0,0,0,0,0,'','Award Reputation - Boss Kill - target players');
INSERT INTO `conditions` VALUES(13,1,73846,0,0,31,0,4,0,0,0,0,0,'','Award Reputation - Boss Kill - target players');

-- npc Skybreaker Deckhand (36970)
UPDATE `creature_template` SET `difficulty_entry_1`=0,`difficulty_entry_2`=0,`difficulty_entry_3`=0 WHERE `entry`=36970;
UPDATE `creature_template` SET `minlevel`=80,`maxlevel`=80,`exp`=0,`faction`=84,`speed_walk`=1,`speed_run`=1.14286,`unit_flags`=0x300,`unit_flags2`=0x800,`dynamicflags`=0,`baseattacktime`=2000,`InhabitType`=1,flags_extra=0+0x200000,`mechanic_immune_mask`=650854271,AIName='',ScriptName='npc_igb_ship_crew' WHERE `entry`=36970;
DELETE FROM `creature_equip_template` WHERE `entry` IN (36970);
INSERT INTO `creature_equip_template` (`entry`,`id`,`itemEntry1`,`itemEntry2`,`itemEntry3`) VALUES(36970,1,1493,0,0);

-- npc Orgrim's Hammer Crew (36971)
UPDATE `creature_template` SET `difficulty_entry_1`=0,`difficulty_entry_2`=0,`difficulty_entry_3`=0 WHERE `entry`=36971;
UPDATE `creature_template` SET `minlevel`=80,`maxlevel`=80,`exp`=0,`faction`=83,`speed_walk`=1,`speed_run`=1.14286,`unit_flags`=0x300,`unit_flags2`=0x800,`dynamicflags`=0,`baseattacktime`=2000,`InhabitType`=1,flags_extra=0+0x200000,`mechanic_immune_mask`=650854271,AIName='',ScriptName='npc_igb_ship_crew' WHERE `entry`=36971;
DELETE FROM `creature_equip_template` WHERE `entry` IN (36971);
INSERT INTO `creature_equip_template` (`entry`,`id`,`itemEntry1`,`itemEntry2`,`itemEntry3`) VALUES(36971,1,11019,0,0);

-- spell Heat Drain (69470, 69471), Overheat (69487, 69488), Cannon Blast (69399, 69400), Cannon Blast (70172, 70173), Incinerating Blast (69401, 69402), Incinerating Blast (70174, 70175)
DELETE FROM spell_script_names WHERE spell_id IN(69470, 69471, 69487, 69488, 69399, 69400, 70172, 70173, 69401, 69402, 70174, 70175, -69470, -69471, -69487, -69488, -69399, -69400, -70172, -70173, -69401, -69402, -70174, -70175);
DELETE FROM spell_scripts WHERE id IN(69470, 69471, 69487, 69488, 69399, 69400, 70172, 70173, 69401, 69402, 70174, 70175, -69470, -69471, -69487, -69488, -69399, -69400, -70172, -70173, -69401, -69402, -70174, -70175);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69470, 69471, 69487, 69488, 69399, 69400, 70172, 70173, 69401, 69402, 70174, 70175, -69470, -69471, -69487, -69488, -69399, -69400, -70172, -70173, -69401, -69402, -70174, -70175) OR spell_effect IN(69470, 69471, 69487, 69488, 69399, 69400, 70172, 70173, 69401, 69402, 70174, 70175, -69470, -69471, -69487, -69488, -69399, -69400, -70172, -70173, -69401, -69402, -70174, -70175);
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(13,17) AND SourceEntry IN(69470, 69471, 69487, 69488, 69399, 69400, 70172, 70173, 69401, 69402, 70174, 70175, -69470, -69471, -69487, -69488, -69399, -69400, -70172, -70173, -69401, -69402, -70174, -70175);
INSERT INTO `spell_script_names` VALUES(69470,'spell_igb_periodic_trigger_with_power_cost');
INSERT INTO `spell_script_names` VALUES(69487,'spell_igb_periodic_trigger_with_power_cost');
INSERT INTO `spell_script_names` VALUES(69399,'spell_igb_cannon_blast');
INSERT INTO `spell_script_names` VALUES(70172,'spell_igb_cannon_blast');
INSERT INTO `spell_script_names` VALUES(69401,'spell_igb_incinerating_blast');
INSERT INTO `spell_script_names` VALUES(70174,'spell_igb_incinerating_blast');
INSERT INTO `spell_script_names` VALUES(69487,'spell_igb_overheat');
INSERT INTO `conditions` VALUES(13,2,70173,0,0,31,0,3,37540,0,0,0,0,'','Cannon Blast - target The Skybreaker');
INSERT INTO `conditions` VALUES(13,2,69400,0,0,31,0,3,37215,0,0,0,0,'','Cannon Blast - target Orgrim''s Hammer');
INSERT INTO `conditions` VALUES(13,2,69402,0,0,31,0,3,37540,0,0,0,0,'','Incinerating Blast - target The Skybreaker');
INSERT INTO `conditions` VALUES(13,2,70175,0,0,31,0,3,37215,0,0,0,0,'','Incinerating Blast - target Orgrim''s Hammer');

-- npc Skybreaker Sergeant (36961, 38261, 38691, 38692)
-- npc Kor'kron Sergeant (36960, 38262, 38683, 38684)
UPDATE `creature_template` SET `difficulty_entry_1`=38261,`difficulty_entry_2`=38691,`difficulty_entry_3`=38692 WHERE `entry`=36961;
UPDATE `creature_template` SET `difficulty_entry_1`=38262,`difficulty_entry_2`=38683,`difficulty_entry_3`=38684 WHERE `entry`=36960;
UPDATE `creature_template` SET `ScriptName`='npc_gunship_boarding_leader' WHERE `entry` IN (36961,36960);
UPDATE `creature_template` SET `minlevel`=82,`maxlevel`=82,`exp`=2,`faction`=84,`speed_walk`=1,`speed_run`=1.42857,`unit_class`=1,`unit_flags`=0x8040,`unit_flags2`=0,`dynamicflags`=0,`baseattacktime`=2000,`InhabitType`=1,`flags_extra`=0+0x200000,`mechanic_immune_mask`=650854271 WHERE `entry` IN (36961,38261,38691,38692);
UPDATE `creature_template` SET `minlevel`=82,`maxlevel`=82,`exp`=2,`faction`=83,`speed_walk`=1,`speed_run`=1.42857,`unit_class`=1,`unit_flags`=0x8040,`unit_flags2`=0,`dynamicflags`=0,`baseattacktime`=2000,`InhabitType`=1,`flags_extra`=0+0x200000,`mechanic_immune_mask`=650854271 WHERE `entry` IN (36960,38262,38683,38684);
UPDATE creature_template SET mindmg=4333, maxdmg=5923, attackpower=300, dmg_multiplier=1.5 WHERE entry=36961;
UPDATE creature_template SET mindmg=3503, maxdmg=4783, attackpower=300, dmg_multiplier=2.5 WHERE entry=38261;
UPDATE creature_template SET mindmg=6507, maxdmg=8883, attackpower=300, dmg_multiplier=1.5 WHERE entry=38691;
UPDATE creature_template SET mindmg=4670, maxdmg=6375, attackpower=300, dmg_multiplier=2.5 WHERE entry=38692;
UPDATE creature_template SET mindmg=4333, maxdmg=5923, attackpower=300, dmg_multiplier=1.5 WHERE entry=36960;
UPDATE creature_template SET mindmg=3503, maxdmg=4783, attackpower=300, dmg_multiplier=2.5 WHERE entry=38262;
UPDATE creature_template SET mindmg=6507, maxdmg=8883, attackpower=300, dmg_multiplier=1.5 WHERE entry=38683;
UPDATE creature_template SET mindmg=4670, maxdmg=6375, attackpower=300, dmg_multiplier=2.5 WHERE entry=38684;
DELETE FROM `creature_equip_template` WHERE `entry` IN (36961, 38261, 38691, 38692, 36960, 38262, 38683, 38684);
INSERT INTO `creature_equip_template` (`entry`,`id`,`itemEntry1`,`itemEntry2`,`itemEntry3`) VALUES
(36961,1,49637,0,0),(38261,1,49637,0,0),(38691,1,49637,0,0),(38692,1,49637,0,0),
(36960,1,34638,0,0),(38262,1,34638,0,0),(38683,1,34638,0,0),(38684,1,34638,0,0);

-- npc Skybreaker Marine (36950, 38406, 38685, 38686)
-- npc Kor'kron Reaver (36957, 38404, 38679, 38680)
UPDATE `creature_template` SET `difficulty_entry_1`=38406,`difficulty_entry_2`=38685,`difficulty_entry_3`=38686 WHERE `entry`=36950;
UPDATE `creature_template` SET `difficulty_entry_1`=38404,`difficulty_entry_2`=38679,`difficulty_entry_3`=38680 WHERE `entry`=36957;
UPDATE `creature_template` SET `ScriptName`='npc_gunship_boarding_add' WHERE `entry` IN (36950,36957);
UPDATE `creature_template` SET `minlevel`=82,`maxlevel`=82,`exp`=2,`faction`=84,`speed_walk`=1,`speed_run`=1.42857,`unit_class`=1,`unit_flags`=0x8040,`unit_flags2`=0,`dynamicflags`=0,`baseattacktime`=2000,`InhabitType`=1,`flags_extra`=0+0x200000,`mechanic_immune_mask`=650854271 WHERE `entry` IN (36950,38406,38685,38686);
UPDATE `creature_template` SET `minlevel`=82,`maxlevel`=82,`exp`=2,`faction`=83,`speed_walk`=1,`speed_run`=1.42857,`unit_class`=1,`unit_flags`=0x8040,`unit_flags2`=0,`dynamicflags`=0,`baseattacktime`=2000,`InhabitType`=1,`flags_extra`=0+0x200000,`mechanic_immune_mask`=650854271 WHERE `entry` IN (36957,38404,38679,38680);
UPDATE creature_template SET mindmg=4333, maxdmg=5923, attackpower=300, dmg_multiplier=0.75 WHERE entry=36950;
UPDATE creature_template SET mindmg=3503, maxdmg=4783, attackpower=300, dmg_multiplier=1.25 WHERE entry=38406;
UPDATE creature_template SET mindmg=6507, maxdmg=8883, attackpower=300, dmg_multiplier=0.75 WHERE entry=38685;
UPDATE creature_template SET mindmg=4670, maxdmg=6375, attackpower=300, dmg_multiplier=1.25 WHERE entry=38686;
UPDATE creature_template SET mindmg=4333, maxdmg=5923, attackpower=300, dmg_multiplier=0.75 WHERE entry=36957;
UPDATE creature_template SET mindmg=3503, maxdmg=4783, attackpower=300, dmg_multiplier=1.25 WHERE entry=38404;
UPDATE creature_template SET mindmg=6507, maxdmg=8883, attackpower=300, dmg_multiplier=0.75 WHERE entry=38679;
UPDATE creature_template SET mindmg=4670, maxdmg=6375, attackpower=300, dmg_multiplier=1.25 WHERE entry=38680;
DELETE FROM `creature_equip_template` WHERE `entry` IN (36950, 38406, 38685, 38686, 36957, 38404, 38679, 38680);
INSERT INTO `creature_equip_template` (`entry`,`id`,`itemEntry1`,`itemEntry2`,`itemEntry3`) VALUES
(36950,1,49687,0,0),(38406,1,49687,0,0),(38685,1,49687,0,0),(38686,1,49687,0,0),
(36957,1,49689,0,0),(38404,1,49689,0,0),(38679,1,49689,0,0),(38680,1,49689,0,0);

-- npc Skybreaker Sorcerer (37116, 38256, 38693, 38694)
-- npc Kor'kron Battle-Mage (37117, 38257, 38677, 38678)
UPDATE `creature_template` SET `difficulty_entry_1`=38256,`difficulty_entry_2`=38693,`difficulty_entry_3`=38694 WHERE `entry`=37116;
UPDATE `creature_template` SET `difficulty_entry_1`=38257,`difficulty_entry_2`=38677,`difficulty_entry_3`=38678 WHERE `entry`=37117;
UPDATE `creature_template` SET `ScriptName`='npc_gunship_mage' WHERE `entry` IN (37116,37117);
UPDATE `creature_template` SET `minlevel`=82,`maxlevel`=82,`exp`=2,`faction`=84,`speed_walk`=1,`speed_run`=1.71429,`unit_class`=2,`unit_flags`=0x8040,`unit_flags2`=0,`dynamicflags`=0,`baseattacktime`=2000,`InhabitType`=1,`flags_extra`=0+0x200000,`mechanic_immune_mask`=650854271 WHERE `entry` IN (37116,38256,38693,38694);
UPDATE `creature_template` SET `minlevel`=82,`maxlevel`=82,`exp`=2,`faction`=83,`speed_walk`=1,`speed_run`=1.42857,`unit_class`=2,`unit_flags`=0x8040,`unit_flags2`=0,`dynamicflags`=0,`baseattacktime`=2000,`InhabitType`=1,`flags_extra`=0+0x200000,`mechanic_immune_mask`=650854271 WHERE `entry` IN (37117,38257,38677,38678);
DELETE FROM `creature_equip_template` WHERE `entry` IN (37116, 38256, 38693, 38694, 37117, 38257, 38677, 38678);
INSERT INTO `creature_equip_template` (`entry`,`id`,`itemEntry1`,`itemEntry2`,`itemEntry3`) VALUES
(37116,1,39746,0,0),(38256,1,39746,0,0),(38693,1,39746,0,0),(38694,1,39746,0,0),
(37117,1,39746,0,0),(38257,1,39746,0,0),(38677,1,39746,0,0),(38678,1,39746,0,0);

-- npc Skybreaker Rifleman (36969, 38408, 38689, 38690)
-- npc Kor'kron Axethrower (36968, 38403, 38675, 38676)
UPDATE `creature_template` SET `difficulty_entry_1`=38408,`difficulty_entry_2`=38689,`difficulty_entry_3`=38690 WHERE `entry`=36969;
UPDATE `creature_template` SET `difficulty_entry_1`=38403,`difficulty_entry_2`=38675,`difficulty_entry_3`=38676 WHERE `entry`=36968;
UPDATE `creature_template` SET `ScriptName`='npc_gunship_gunner' WHERE `entry` IN (36969,36968);
UPDATE `creature_template` SET `minlevel`=82,`maxlevel`=82,`exp`=2,`faction`=84,`speed_walk`=1,`speed_run`=1.42857,`unit_class`=1,`unit_flags`=0x8040,`unit_flags2`=0,`dynamicflags`=0,`baseattacktime`=2000,`InhabitType`=1,`flags_extra`=0+0x200000,`mechanic_immune_mask`=650854271 WHERE `entry` IN (36969,38408,38689,38690);
UPDATE `creature_template` SET `minlevel`=82,`maxlevel`=82,`exp`=2,`faction`=83,`speed_walk`=1,`speed_run`=1.42857,`unit_class`=1,`unit_flags`=0x8040,`unit_flags2`=0,`dynamicflags`=0,`baseattacktime`=2000,`InhabitType`=1,`flags_extra`=0+0x200000,`mechanic_immune_mask`=650854271 WHERE `entry` IN (36968,38403,38675,38676);
DELETE FROM `creature_equip_template` WHERE `entry` IN (36969, 38408, 38689, 38690, 36968, 38403, 38675, 38676);
INSERT INTO `creature_equip_template` (`entry`,`id`,`itemEntry1`,`itemEntry2`,`itemEntry3`) VALUES
(36969,1,0,0,12523),(38408,1,0,0,12523),(38689,1,0,0,12523),(38690,1,0,0,12523),
(36968,1,49691,0,49873),(38403,1,49691,0,49873),(38675,1,49691,0,49873),(38676,1,49691,0,49873);

-- npc Skybreaker Mortar Soldier (36978, 38407, 38687, 38688)
-- npc Kor'kron Rocketeer (36982, 38405, 38681, 38682)
UPDATE `creature_template` SET `difficulty_entry_1`=38407,`difficulty_entry_2`=38687,`difficulty_entry_3`=38688 WHERE `entry`=36978;
UPDATE `creature_template` SET `difficulty_entry_1`=38405,`difficulty_entry_2`=38681,`difficulty_entry_3`=38682 WHERE `entry`=36982;
UPDATE `creature_template` SET `ScriptName`='npc_gunship_rocketeer' WHERE `entry` IN (36978,36982);
UPDATE `creature_template` SET `minlevel`=82,`maxlevel`=82,`exp`=2,`faction`=84,`speed_walk`=1,`speed_run`=1.42857,`unit_class`=1,`unit_flags`=0x8040,`unit_flags2`=0,`dynamicflags`=0,`baseattacktime`=2000,`InhabitType`=1,`flags_extra`=0+0x200000,`mechanic_immune_mask`=650854271 WHERE `entry` IN (36978,38407,38687,38688);
UPDATE `creature_template` SET `minlevel`=82,`maxlevel`=82,`exp`=2,`faction`=83,`speed_walk`=1,`speed_run`=1.42857,`unit_class`=1,`unit_flags`=0x8040,`unit_flags2`=0,`dynamicflags`=0,`baseattacktime`=2000,`InhabitType`=1,`flags_extra`=0+0x200000,`mechanic_immune_mask`=650854271 WHERE `entry` IN (36982,38405,38681,38682);

-- spell Burning Pitch (70403, 70397), (71335, 71339), (69660), (70383, 70374)
DELETE FROM spell_script_names WHERE spell_id IN(70403, 70397, 71335, 71339, 69660, 70383, 70374, -70403, -70397, -71335, -71339, -69660, -70383, -70374);
DELETE FROM spell_scripts WHERE id IN(70403, 70397, 71335, 71339, 69660, 70383, 70374, -70403, -70397, -71335, -71339, -69660, -70383, -70374);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70403, 70397, 71335, 71339, 69660, 70383, 70374, -70403, -70397, -71335, -71339, -69660, -70383, -70374) OR spell_effect IN(70403, 70397, 71335, 71339, 69660, 70383, 70374, -70403, -70397, -71335, -71339, -69660, -70383, -70374);
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(13,17) AND SourceEntry IN(70403, 70397, 71335, 71339, 69660, 70383, 70374, -70403, -70397, -71335, -71339, -69660, -70383, -70374);
INSERT INTO `spell_script_names` VALUES(70403,'spell_igb_burning_pitch_selector');
INSERT INTO `spell_script_names` VALUES(70397,'spell_igb_burning_pitch_selector');
INSERT INTO `spell_script_names` VALUES(71335,'spell_igb_burning_pitch');
INSERT INTO `spell_script_names` VALUES(71339,'spell_igb_burning_pitch');
INSERT INTO `conditions` VALUES(13,1,70403,0,0,31,0,3,37547,0,0,0,0,'','Burning Pitch - target Gunship Hull');
INSERT INTO `conditions` VALUES(13,1,70397,0,0,31,0,3,37547,0,0,0,0,'','Burning Pitch - target Gunship Hull');
INSERT INTO `conditions` VALUES(13,1,70383,0,0,31,0,3,37215,0,0,0,0,'','Burning Pitch - target Orgrim''s Hammer');
INSERT INTO `conditions` VALUES(13,1,70374,0,0,31,0,3,37540,0,0,0,0,'','Burning Pitch - target The Skybreaker');
INSERT INTO `conditions` VALUES(13,1,69660,0,0,31,0,3,37547,0,0,0,0,'','Burning Pitch - target Gunship Hull');

-- spell Rocket Artillery (70609, 69678), (69679), (71371), Explosion (69680, 69687, 69688, 69689)
DELETE FROM spell_script_names WHERE spell_id IN(70609, 69678, 69679, 71371, 69680, 69687, 69688, 69689, -70609, -69678, -69679, -71371, -69680, -69687, -69688, -69689);
DELETE FROM spell_scripts WHERE id IN(70609, 69678, 69679, 71371, 69680, 69687, 69688, 69689, -70609, -69678, -69679, -71371, -69680, -69687, -69688, -69689);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70609, 69678, 69679, 71371, 69680, 69687, 69688, 69689, -70609, -69678, -69679, -71371, -69680, -69687, -69688, -69689) OR spell_effect IN(70609, 69678, 69679, 71371, 69680, 69687, 69688, 69689, -70609, -69678, -69679, -71371, -69680, -69687, -69688, -69689);
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(13,17) AND SourceEntry IN(70609, 69678, 69679, 71371, 69680, 69687, 69688, 69689, -70609, -69678, -69679, -71371, -69680, -69687, -69688, -69689);
INSERT INTO `spell_script_names` VALUES(69678,'spell_igb_rocket_artillery');
INSERT INTO `spell_script_names` VALUES(70609,'spell_igb_rocket_artillery');
INSERT INTO `spell_script_names` VALUES(69679,'spell_igb_rocket_artillery_explosion');

-- spell Below Zero (69705)
DELETE FROM spell_script_names WHERE spell_id IN(69705, -69705);
DELETE FROM spell_scripts WHERE id IN(69705, -69705);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69705, -69705) OR spell_effect IN(69705, -69705);
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(13,17) AND SourceEntry IN(69705, -69705);
INSERT INTO `spell_script_names` VALUES(69705,'spell_igb_below_zero');
INSERT INTO `conditions` VALUES(13,1,69705,0,0,31,0,3,36839,0,0,0,0,'','Below Zero - target Horde Gunship Cannon');
INSERT INTO `conditions` VALUES(13,1,69705,0,1,31,0,3,36838,0,0,0,0,'','Below Zero - target Alliance Gunship Cannon');

-- spell On Skybreaker Deck, On Orgrim's Hammer Deck (70120, 70121)
DELETE FROM spell_script_names WHERE spell_id IN(70120, 70121, -70120, -70121);
DELETE FROM spell_scripts WHERE id IN(70120, 70121, -70120, -70121);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70120, 70121, -70120, -70121) OR spell_effect IN(70120, 70121, -70120, -70121);
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(13,17) AND SourceEntry IN(70120, 70121, -70120, -70121);
INSERT INTO `spell_script_names` VALUES(70120,'spell_igb_on_gunship_deck');
INSERT INTO `spell_script_names` VALUES(70121,'spell_igb_on_gunship_deck');



-- ###################
-- ### DEATHBRINGER SAURFANG
-- ###################

-- Deathbringer Saurfang (37813, 38402, 38582, 38583)
UPDATE creature_template SET faction=974, speed_walk=1.6, speed_run=1.42857, rank=3, mindmg=4333, maxdmg=5923, attackpower=300, dmg_multiplier=5, unit_flags=33588032, baseattacktime=1000, AIName='', mechanic_immune_mask=617299839, flags_extra=1+0x200000, ScriptName='boss_deathbringer_saurfang' WHERE entry=37813;
UPDATE creature_template SET faction=974, speed_walk=1.6, speed_run=1.42857, rank=3, mindmg=3503, maxdmg=4783, attackpower=300, dmg_multiplier=9.5, unit_flags=33588032, baseattacktime=1000, AIName='', mechanic_immune_mask=617299839, flags_extra=1+0x200000, ScriptName='' WHERE entry=38402;
UPDATE creature_template SET faction=974, speed_walk=1.6, speed_run=1.42857, rank=3, mindmg=6507, maxdmg=8883, attackpower=300, dmg_multiplier=5, unit_flags=33588032, baseattacktime=1000, AIName='', mechanic_immune_mask=617299839, flags_extra=1+0x200000, ScriptName='' WHERE entry=38582;
UPDATE creature_template SET faction=974, speed_walk=1.6, speed_run=1.42857, rank=3, mindmg=4670, maxdmg=6375, attackpower=300, dmg_multiplier=9.5, unit_flags=33588032, baseattacktime=1000, AIName='', mechanic_immune_mask=617299839, flags_extra=1+0x200000, ScriptName='' WHERE entry=38583;
DELETE FROM creature_template_addon WHERE entry IN(37813, 38402, 38582, 38583);
UPDATE creature SET spawntimesecs=604800 WHERE id IN(37813, 38402, 38582, 38583);

-- Blood Beast (38508, 38596, 38597, 38598)
UPDATE creature_template SET mindmg=1226, maxdmg=1671, attackpower=300, dmg_multiplier=5, baseattacktime=1000, AIName='', ScriptName='npc_icc_blood_beast', mechanic_immune_mask=550179615 WHERE entry=38508;
UPDATE creature_template SET mindmg=990, maxdmg=1350, attackpower=300, dmg_multiplier=9.5, baseattacktime=1000, AIName='', ScriptName='', mechanic_immune_mask=550179615 WHERE entry=38596;
UPDATE creature_template SET mindmg=1839, maxdmg=2507, attackpower=300, dmg_multiplier=5, baseattacktime=1000, AIName='', ScriptName='', mechanic_immune_mask=550179615 WHERE entry=38597;
UPDATE creature_template SET mindmg=1320, maxdmg=1800, attackpower=300, dmg_multiplier=9.5, baseattacktime=1000, AIName='', ScriptName='', mechanic_immune_mask=550179615 WHERE entry=38598;
DELETE FROM creature_template_addon WHERE entry IN(38508, 38596, 38597, 38598);

-- Xinef: spell Blood Link (72176)
DELETE FROM spell_script_names WHERE spell_id IN(72176, -72176);
DELETE FROM spell_scripts WHERE id IN(72176, -72176);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(72176, -72176) OR spell_effect IN(72176, -72176);
INSERT INTO spell_script_names VALUES(72176, 'spell_deathbringer_blood_link_blood_beast_aura');
REPLACE INTO spell_proc_event VALUES(72176, 0, 0, 0, 0, 0, 0, 65536, 0, 0, 0);

-- spell Blood Link (72178)
-- additional ids: 72202, 72195
DELETE FROM spell_script_names WHERE spell_id IN(72178, -72178, 72202, 72195, -72202, -72195);
DELETE FROM spell_scripts WHERE id IN(72178, -72178, 72202, 72195, -72202, -72195);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(72178, -72178, 72202, 72195, -72202, -72195) OR spell_effect IN(72178, -72178, 72202, 72195, -72202, -72195);
INSERT INTO spell_script_names VALUES(72178, 'spell_deathbringer_blood_link_aura');
INSERT INTO spell_script_names VALUES(72202, 'spell_deathbringer_blood_link');
REPLACE INTO spell_proc_event VALUES(72178, 0, 0, 0, 0, 0, 0, 65536, 0, 0, 0);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(72202);
INSERT INTO `conditions` VALUES (13, 1, 72202, 0, 0, 31, 0, 3, 37813, 0, 0, 0, 0, '', 'Deathbringer Saurfang - Blood Link');

-- spell Rune of Blood (72408)
-- additional ids: 72409, 72447, 72448, 72449
DELETE FROM spell_script_names WHERE spell_id IN(72408, -72408, 72409, 72447, 72448, 72449, -72409, -72447, -72448, -72449);
DELETE FROM spell_scripts WHERE id IN(72408, -72408, 72409, 72447, 72448, 72449, -72409, -72447, -72448, -72449);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(72408, -72408, 72409, 72447, 72448, 72449, -72409, -72447, -72448, -72449) OR spell_effect IN(72408, -72408, 72409, 72447, 72448, 72449, -72409, -72447, -72448, -72449);

-- spell Blood Nova (72378)
-- additional ids: 73058, 72380, 72438, 72439, 72440
DELETE FROM spell_script_names WHERE spell_id IN(72378, -72378, 73058, 72380, 72438, 72439, 72440, -73058, -72380, -72438, -72439, -72440);
DELETE FROM spell_scripts WHERE id IN(72378, -72378, 73058, 72380, 72438, 72439, 72440, -73058, -72380, -72438, -72439, -72440);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(72378, -72378, 73058, 72380, 72438, 72439, 72440, -73058, -72380, -72438, -72439, -72440) OR spell_effect IN(72378, -72378, 73058, 72380, 72438, 72439, 72440, -73058, -72380, -72438, -72439, -72440);
INSERT INTO spell_script_names VALUES(72378, 'spell_deathbringer_blood_nova_targeting');
INSERT INTO spell_script_names VALUES(73058, 'spell_deathbringer_blood_nova_targeting');

-- spell Blood Power (72371)
DELETE FROM spell_script_names WHERE spell_id IN(72371, -72371);
DELETE FROM spell_scripts WHERE id IN(72371, -72371);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(72371, -72371) OR spell_effect IN(72371, -72371);
INSERT INTO spell_script_names VALUES(72371, 'spell_deathbringer_blood_power');

-- spell Boiling Blood (72385)
-- additional ids: 72441, 72442, 72443
DELETE FROM spell_script_names WHERE spell_id IN(72385, -72385, 72441, 72442, 72443, -72441, -72442, -72443);
DELETE FROM spell_scripts WHERE id IN(72385, -72385, 72441, 72442, 72443, -72441, -72442, -72443);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(72385, -72385, 72441, 72442, 72443, -72441, -72442, -72443) OR spell_effect IN(72385, -72385, 72441, 72442, 72443, -72441, -72442, -72443);
INSERT INTO spell_script_names VALUES(72385, 'spell_deathbringer_boiling_blood');
INSERT INTO spell_script_names VALUES(72441, 'spell_deathbringer_boiling_blood');
INSERT INTO spell_script_names VALUES(72442, 'spell_deathbringer_boiling_blood');
INSERT INTO spell_script_names VALUES(72443, 'spell_deathbringer_boiling_blood');

-- spell Remove Marks of the Fallen Champion (72257)
DELETE FROM spell_script_names WHERE ScriptName='spell_deathbringer_remove_marks' AND spell_id=72257;

-- spell Mark of the Fallen Champion (72256)
-- .debug setval 59 164676
-- additional ids: 72255, 72444, 72445, 72446, 72293, 72254
DELETE FROM spell_script_names WHERE spell_id IN(72256, -72256, 72255, 72444, 72445, 72446, 72293, 72254, -72255, -72444, -72445, -72446, -72293, -72254);
DELETE FROM spell_scripts WHERE id IN(72256, -72256, 72255, 72444, 72445, 72446, 72293, 72254, -72255, -72444, -72445, -72446, -72293, -72254);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(72256, -72256, 72255, 72444, 72445, 72446, 72293, 72254, -72255, -72444, -72445, -72446, -72293, -72254) OR spell_effect IN(72256, -72256, 72255, 72444, 72445, 72446, 72293, 72254, -72255, -72444, -72445, -72446, -72293, -72254);
-- heal
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(72260, 72278, 72279, 72280);
INSERT INTO `conditions` VALUES (13, 1, 72260, 0, 0, 31, 0, 3, 37813, 0, 0, 0, 0, '', 'Deathbringer Saurfang - Mark of the Fallen Champion heal');
INSERT INTO `conditions` VALUES (13, 1, 72278, 0, 0, 31, 0, 3, 37813, 0, 0, 0, 0, '', 'Deathbringer Saurfang - Mark of the Fallen Champion heal');
INSERT INTO `conditions` VALUES (13, 1, 72279, 0, 0, 31, 0, 3, 37813, 0, 0, 0, 0, '', 'Deathbringer Saurfang - Mark of the Fallen Champion heal');
INSERT INTO `conditions` VALUES (13, 1, 72280, 0, 0, 31, 0, 3, 37813, 0, 0, 0, 0, '', 'Deathbringer Saurfang - Mark of the Fallen Champion heal');
-- proc from any outcome, not just hit/crit ("when Saurfant performs a melee attack")
REPLACE INTO spell_proc_event VALUES(72256, 0, 0, 0, 0, 0, 4, 65536, 0, 0, 0);

-- Martyr Stalker (Reputation) (39010)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(39010));
DELETE FROM creature WHERE id IN(39010);

-- Martyr Stalker (IGB/Saurfang) (38569)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(38569));
DELETE FROM creature WHERE id IN(38569);

-- Invisible Stalker (All Phases) (32780)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(32780) AND `map`=631 );
DELETE FROM creature WHERE id IN(32780) AND `map`=631;

-- Kor'kron Reaver (37920) - dummy for scene



-- ###################
-- ### FESTERGUT
-- ###################

-- Festergut (36626, 37504, 37505, 37506)
UPDATE creature_template SET speed_walk=1, speed_run=1.5873, rank=3, unit_flags=0, baseattacktime=0, mindmg=5455, maxdmg=7437, attackpower=300, dmg_multiplier=7, AIName='', mechanic_immune_mask=650854271, flags_extra=1+0x200000, ScriptName='boss_festergut' WHERE entry=36626;
UPDATE creature_template SET speed_walk=1, speed_run=1.5873, rank=3, unit_flags=0, baseattacktime=0, mindmg=4404, maxdmg=6004, attackpower=300, dmg_multiplier=13, AIName='', mechanic_immune_mask=650854271, flags_extra=1+0x200000, ScriptName='' WHERE entry=37504;
UPDATE creature_template SET speed_walk=1, speed_run=1.5873, rank=3, unit_flags=0, baseattacktime=0, mindmg=8178, maxdmg=11150, attackpower=300, dmg_multiplier=7, AIName='', mechanic_immune_mask=650854271, flags_extra=1+0x200000, ScriptName='' WHERE entry=37505;
UPDATE creature_template SET speed_walk=1, speed_run=1.5873, rank=3, unit_flags=0, baseattacktime=0, mindmg=5875, maxdmg=8010, attackpower=300, dmg_multiplier=13, AIName='', mechanic_immune_mask=650854271, flags_extra=1+0x200000, ScriptName='' WHERE entry=37506;
UPDATE creature SET spawntimesecs=604800 WHERE id IN(36626, 37504, 37505, 37506);

-- Puddle Stalker (37013)
UPDATE creature_template SET difficulty_entry_1=0, modelid1=11686, modelid2=0, modelid3=0, modelid4=0, minlevel=83, maxlevel=83, faction=14, unit_flags=33554432, InhabitType=4, AIName='NullCreatureAI', flags_extra=128 WHERE entry=37013;
REPLACE INTO creature_template_addon VALUES(37013, 0, 0, 50331648, 1, 0, '');
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37013) AND `map`=631 );
DELETE FROM creature WHERE id IN(37013) AND `map`=631;
INSERT INTO `creature` VALUES (NULL, 37013, 631, 15, 1, 0, 0, 4428.15, 3101.17, 360.55, 1.11701, 86400, 0, 0, 25200, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37013, 631, 15, 1, 0, 0, 4463.88, 3172.66, 360.55, 4.24115, 86400, 0, 0, 25200, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37013, 631, 15, 1, 0, 0, 4480.85, 3118.98, 360.55, 2.67035, 86400, 0, 0, 25200, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37013, 631, 15, 1, 0, 0, 4419.03, 3109.9, 360.55, 0.767945, 86400, 0, 0, 25200, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37013, 631, 15, 1, 0, 0, 4471.93, 3163.9, 360.55, 3.92699, 86400, 0, 0, 25200, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37013, 631, 15, 1, 0, 0, 4419.42, 3164.15, 360.55, 5.46288, 86400, 0, 0, 25200, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37013, 631, 15, 1, 0, 0, 4409.69, 3119.34, 360.55, 0.471239, 86400, 0, 0, 25200, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37013, 631, 15, 1, 0, 0, 4481.93, 3153.87, 360.55, 3.57792, 86400, 0, 0, 25200, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37013, 631, 15, 1, 0, 0, 4411.07, 3154.75, 360.55, 5.81195, 86400, 0, 0, 25200, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37013, 631, 15, 1, 0, 0, 4472.55, 3110.78, 360.55, 2.35619, 86400, 0, 0, 25200, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37013, 631, 15, 1, 0, 0, 4428.96, 3173.66, 360.55, 5.13127, 86400, 0, 0, 25200, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37013, 631, 15, 1, 0, 0, 4463.86, 3101.57, 360.55, 2.04204, 86400, 0, 0, 25200, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37013, 631, 15, 1, 0, 0, 4421.79, 3181.76, 372.29, 5.46288, 86400, 0, 0, 25200, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37013, 631, 15, 1, 0, 0, 4469.67, 3181.77, 372.311, 4.11898, 86400, 0, 0, 25200, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37013, 631, 15, 1, 0, 0, 4490.13, 3160.97, 372.312, 3.82227, 86400, 0, 0, 25200, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37013, 631, 15, 1, 0, 0, 4401.32, 3160.83, 372.316, 5.55015, 86400, 0, 0, 25200, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37013, 631, 15, 1, 0, 0, 4469.68, 3092.91, 372.325, 2.35619, 86400, 0, 0, 25200, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37013, 631, 15, 1, 0, 0, 4490.33, 3113.29, 372.411, 2.53073, 86400, 0, 0, 25200, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37013, 631, 15, 1, 0, 0, 4401.28, 3112.96, 372.431, 0.785398, 86400, 0, 0, 25200, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37013, 631, 15, 1, 0, 0, 4421.9, 3092.42, 372.456, 0.994838, 86400, 0, 0, 25200, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37013, 631, 15, 1, 0, 0, 4223.47, 3113.58, 372.97, 0.767945, 86400, 0, 0, 25200, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37013, 631, 15, 1, 0, 0, 4222.44, 3161.69, 372.97, 5.53269, 86400, 0, 0, 25200, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37013, 631, 15, 1, 0, 0, 4243.89, 3181.74, 372.97, 5.44543, 86400, 0, 0, 25200, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37013, 631, 15, 1, 0, 0, 4291.18, 3092.92, 372.97, 2.33874, 86400, 0, 0, 25200, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37013, 631, 15, 1, 0, 0, 4312.36, 3160.84, 372.97, 3.80482, 86400, 0, 0, 25200, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37013, 631, 15, 1, 0, 0, 4291.45, 3181.25, 372.97, 4.10152, 86400, 0, 0, 25200, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37013, 631, 15, 1, 0, 0, 4244.04, 3092.66, 372.97, 0.977384, 86400, 0, 0, 25200, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37013, 631, 15, 1, 0, 0, 4312.14, 3112.98, 372.97, 2.51327, 86400, 0, 0, 25200, 0, 0, 0, 0, 0);

-- Abomination Wing Orange Gas Stalker (36659)
UPDATE creature_template SET difficulty_entry_1=0, modelid1=11686, modelid2=0, modelid3=0, modelid4=0, minlevel=83, maxlevel=83, faction=14, unit_flags=33554432, AIName='NullCreatureAI', flags_extra=128 WHERE entry=36659;
DELETE FROM creature_template_addon WHERE entry IN(36659);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36659) AND `map`=631 );
DELETE FROM creature WHERE id IN(36659) AND `map`=631;
INSERT INTO `creature` VALUES (NULL, 36659, 631, 15, 1, 0, 0, 4267.87, 3137.33, 360.50, 0, 86400, 0, 0, 84, 0, 0, 0, 0, 0);

-- Stinky (37025, 38064)
UPDATE creature_template SET speed_walk=1, speed_run=1.71429, mindmg=1907, maxdmg=2600, attackpower=300, dmg_multiplier=7, AIName='', mechanic_immune_mask=650854271, flags_extra=1+0x200000, ScriptName='npc_stinky_icc' WHERE entry=37025;
UPDATE creature_template SET speed_walk=1, speed_run=1.71429, mindmg=1538, maxdmg=2097, attackpower=300, dmg_multiplier=13, AIName='', mechanic_immune_mask=650854271, flags_extra=1+0x200000, ScriptName='' WHERE entry=38064;
DELETE FROM smart_scripts WHERE entryorguid IN(37025, 38064) AND source_type=0;

-- spell Gaseous Blight (69157, 69162, 69164) -- na bossie
DELETE FROM spell_script_names WHERE spell_id IN(69157, 69162, 69164, -69157, -69162, -69164);
DELETE FROM spell_scripts WHERE id IN(69157, 69162, 69164, -69157, -69162, -69164);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69157, 69162, 69164, -69157, -69162, -69164) OR spell_effect IN(69157, 69162, 69164, -69157, -69162, -69164);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(69157, 69162, 69164, -69157, -69162, -69164);
INSERT INTO `conditions` VALUES (13, 4, 69164, 0, 0, 31, 0, 3, 36659, 0, 0, 0, 0, '', 'Festergut - Gaseous Blight');
INSERT INTO `conditions` VALUES (13, 4, 69162, 0, 0, 31, 0, 3, 36659, 0, 0, 0, 0, '', 'Festergut - Gaseous Blight');
INSERT INTO `conditions` VALUES (13, 2, 69157, 0, 0, 31, 0, 3, 36659, 0, 0, 0, 0, '', 'Festergut - Gaseous Blight');

-- spell Gaseous Blight (69126, 69152, 69154) -- visual, triggerowany przez ten od bossa
DELETE FROM spell_script_names WHERE spell_id IN(69126, 69152, 69154, -69126, -69152, -69154);
DELETE FROM spell_scripts WHERE id IN(69126, 69152, 69154, -69126, -69152, -69154);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69126, 69152, 69154, -69126, -69152, -69154) OR spell_effect IN(69126, 69152, 69154, -69126, -69152, -69154);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(69126, 69152, 69154, -69126, -69152, -69154);

-- spell Gaseous Blight (69159, 70135, 70136, 70137) -- dmg dla 69157
-- spell Gaseous Blight (69161, 70138, 70139, 70140) -- dmg dla 69162
-- spell Gaseous Blight (69163, 70468, 70469, 70470) -- dmg dla 69164
DELETE FROM spell_script_names WHERE spell_id IN(69159, 70135, 70136, 70137, 69161, 70138, 70139, 70140, 69163, 70468, 70469, 70470, -69159, -70135, -70136, -70137, -69161, -70138, -70139, -70140, -69163, -70468, -70469, -70470);
DELETE FROM spell_scripts WHERE id IN(69159, 70135, 70136, 70137, 69161, 70138, 70139, 70140, 69163, 70468, 70469, 70470, -69159, -70135, -70136, -70137, -69161, -70138, -70139, -70140, -69163, -70468, -70469, -70470);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69159, 70135, 70136, 70137, 69161, 70138, 70139, 70140, 69163, 70468, 70469, 70470, -69159, -70135, -70136, -70137, -69161, -70138, -70139, -70140, -69163, -70468, -70469, -70470) OR spell_effect IN(69159, 70135, 70136, 70137, 69161, 70138, 70139, 70140, 69163, 70468, 70469, 70470, -69159, -70135, -70136, -70137, -69161, -70138, -70139, -70140, -69163, -70468, -70469, -70470);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(69159, 70135, 70136, 70137, 69161, 70138, 70139, 70140, 69163, 70468, 70469, 70470, -69159, -70135, -70136, -70137, -69161, -70138, -70139, -70140, -69163, -70468, -70469, -70470);

-- spell Gaseous Blight (69125) -- visual rozlewania rzucany przez putricide, ktory trafia triggery
-- additional ids: 71379 -- rzucane przez triggery
DELETE FROM spell_script_names WHERE spell_id IN(69125, 71379, -69125, -71379);
DELETE FROM spell_scripts WHERE id IN(69125, 71379, -69125, -71379);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69125, 71379, -69125, -71379) OR spell_effect IN(69125, 71379, -69125, -71379);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(69125, 71379, -69125, -71379);
INSERT INTO `conditions` VALUES (13, 1, 69125, 0, 0, 31, 0, 3, 37013, 0, 0, 0, 0, '', 'Festergut - Gaseous Blight Initial cast');

-- spell Inhale Blight (69165)
-- additional ids: Inhaled Blight (69166, 71912)
DELETE FROM spell_script_names WHERE spell_id IN(69165, 69166, 71912, -69165, -69166, -71912);
DELETE FROM spell_scripts WHERE id IN(69165, 69166, 71912, -69165, -69166, -71912);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69165, 69166, 71912, -69165, -69166, -71912) OR spell_effect IN(69165, 69166, 71912, -69165, -69166, -71912);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(69165, 69166, 71912, -69165, -69166, -71912);

-- spell Pungent Blight (69195, 71219, 73031, 73032)
DELETE FROM spell_script_names WHERE spell_id IN(69195, 71219, 73031, 73032, -69195, -71219, -73031, -73032);
DELETE FROM spell_scripts WHERE id IN(69195, 71219, 73031, 73032, -69195, -71219, -73031, -73032);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69195, 71219, 73031, 73032, -69195, -71219, -73031, -73032) OR spell_effect IN(69195, 71219, 73031, 73032, -69195, -71219, -73031, -73032);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(69195, 71219, 73031, 73032, -69195, -71219, -73031, -73032);
INSERT INTO spell_script_names VALUES(69195, 'spell_festergut_pungent_blight'),(71219, 'spell_festergut_pungent_blight'),(73031, 'spell_festergut_pungent_blight'),(73032, 'spell_festergut_pungent_blight');

-- spell Gas Spore (69278, 71221)
-- additional ids: 69279
DELETE FROM spell_script_names WHERE spell_id IN(69278, 71221, 69279, -69278, -71221, -69279);
DELETE FROM spell_scripts WHERE id IN(69278, 71221, 69279, -69278, -71221, -69279);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69278, 71221, 69279, -69278, -71221, -69279) OR spell_effect IN(69278, 71221, 69279, -69278, -71221, -69279);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(69278, 71221, 69279, -69278, -71221, -69279);

-- spell Blighted Spores (69290, 71222, 73033, 73034)
DELETE FROM spell_script_names WHERE spell_id IN(69290, 71222, 73033, 73034, -69290, -71222, -73033, -73034);
DELETE FROM spell_scripts WHERE id IN(69290, 71222, 73033, 73034, -69290, -71222, -73033, -73034);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69290, 71222, 73033, 73034, -69290, -71222, -73033, -73034) OR spell_effect IN(69290, 71222, 73033, 73034, -69290, -71222, -73033, -73034);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(69290, 71222, 73033, 73034, -69290, -71222, -73033, -73034);
INSERT INTO spell_script_names VALUES(69290, 'spell_festergut_blighted_spores'),(71222, 'spell_festergut_blighted_spores'),(73033, 'spell_festergut_blighted_spores'),(73034, 'spell_festergut_blighted_spores');

-- spell Inoculated (69291, 72101, 72102, 72103)
DELETE FROM spell_script_names WHERE spell_id IN(69291, 72101, 72102, 72103, -69291, -72101, -72102, -72103);
DELETE FROM spell_scripts WHERE id IN(69291, 72101, 72102, 72103, -69291, -72101, -72102, -72103);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69291, 72101, 72102, 72103, -69291, -72101, -72102, -72103) OR spell_effect IN(69291, 72101, 72102, 72103, -69291, -72101, -72102, -72103);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(69291, 72101, 72102, 72103, -69291, -72101, -72102, -72103);

-- spell Vile Gas (69240, 71218, 73019, 73020)
-- additional ids: disorient (69248), vomit others (69244, 71288, 73173, 73174)
DELETE FROM spell_script_names WHERE spell_id IN(69240, 71218, 73019, 73020, 69248, 69244, 71288, 73173, 73174, -69240, -71218, -73019, -73020, -69248, -69244, -71288, -73173, -73174);
DELETE FROM spell_scripts WHERE id IN(69240, 71218, 73019, 73020, 69248, 69244, 71288, 73173, 73174, -69240, -71218, -73019, -73020, -69248, -69244, -71288, -73173, -73174);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69240, 71218, 73019, 73020, 69248, 69244, 71288, 73173, 73174, -69240, -71218, -73019, -73020, -69248, -69244, -71288, -73173, -73174) OR spell_effect IN(69240, 71218, 73019, 73020, 69248, 69244, 71288, 73173, 73174, -69240, -71218, -73019, -73020, -69248, -69244, -71288, -73173, -73174);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(69240, 71218, 73019, 73020, 69248, 69244, 71288, 73173, 73174, -69240, -71218, -73019, -73020, -69248, -69244, -71288, -73173, -73174);
REPLACE INTO disables VALUES(0, 69240, 64, '', '', 'Vile Gas LOS (Putricide uses it during Rotface fight)'),(0, 71218, 64, '', '', 'Vile Gas LOS (Putricide uses it during Rotface fight)'),(0, 73019, 64, '', '', 'Vile Gas LOS (Putricide uses it during Rotface fight)'),(0, 73020, 64, '', '', 'Vile Gas LOS (Putricide uses it during Rotface fight)'),(0, 69248, 64, '', '', 'Vile Gas LOS (Putricide uses it during Rotface fight)'),(0, 69244, 64, '', '', 'Vile Gas LOS (Putricide uses it during Rotface fight)'),(0, 71288, 64, '', '', 'Vile Gas LOS (Putricide uses it during Rotface fight)'),(0, 73173, 64, '', '', 'Vile Gas LOS (Putricide uses it during Rotface fight)'),(0, 73174, 64, '', '', 'Vile Gas LOS (Putricide uses it during Rotface fight)');

-- TC
DELETE FROM spell_script_names WHERE ScriptName='spell_rotface_vile_gas_trigger' AND spell_id=72285;
DELETE FROM spell_script_names WHERE ScriptName='spell_rotface_vile_gas_trigger' AND spell_id=72288;


-- spell Gastric Bloat (72219, 72551, 72552, 72553)
-- additional ids: Gastric Explosion (72227, 72228, 72229, 72230)
DELETE FROM spell_script_names WHERE spell_id IN(72219, 72551, 72552, 72553, 72227, 72228, 72229, 72230, -72219, -72551, -72552, -72553, -72227, -72228, -72229, -72230);
DELETE FROM spell_scripts WHERE id IN(72219, 72551, 72552, 72553, 72227, 72228, 72229, 72230, -72219, -72551, -72552, -72553, -72227, -72228, -72229, -72230);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(72219, 72551, 72552, 72553, 72227, 72228, 72229, 72230, -72219, -72551, -72552, -72553, -72227, -72228, -72229, -72230) OR spell_effect IN(72219, 72551, 72552, 72553, 72227, 72228, 72229, 72230, -72219, -72551, -72552, -72553, -72227, -72228, -72229, -72230);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(72219, 72551, 72552, 72553, 72227, 72228, 72229, 72230, -72219, -72551, -72552, -72553, -72227, -72228, -72229, -72230);
INSERT INTO spell_script_names VALUES(72219, 'spell_festergut_gastric_bloat'),(72551, 'spell_festergut_gastric_bloat'),(72552, 'spell_festergut_gastric_bloat'),(72553, 'spell_festergut_gastric_bloat');

-- spell Malleable Goo (70852)
-- additional ids: dmg (70853, 72458, 72873, 72874), balcony goo (72296), balcony goo dmg (72297, 72548, 72549, 72550)
REPLACE INTO disables VALUES(0, 70852, 64, '', '', 'Festergut Malleable Goo LOS'),(0, 70853, 64, '', '', 'Festergut Malleable Goo LOS'),(0, 72458, 64, '', '', 'Festergut Malleable Goo LOS'),(0, 72873, 64, '', '', 'Festergut Malleable Goo LOS'),(0, 72874, 64, '', '', 'Festergut Malleable Goo LOS');
REPLACE INTO disables VALUES(0, 72296, 64, '', '', 'Festergut Malleable Goo LOS'),(0, 72297, 64, '', '', 'Festergut Malleable Goo LOS'),(0, 72548, 64, '', '', 'Festergut Malleable Goo LOS'),(0, 72549, 64, '', '', 'Festergut Malleable Goo LOS'),(0, 72550, 64, '', '', 'Festergut Malleable Goo LOS');



-- ###################
-- ### ROTFACE
-- ###################

-- Rotface (36627, 38390, 38549, 38550)
UPDATE creature_template SET speed_walk=1, speed_run=1.5873, rank=3, unit_flags=0, baseattacktime=0, mindmg=4885, maxdmg=6374, attackpower=300, dmg_multiplier=7, AIName='', mechanic_immune_mask=650854271, flags_extra=1+0x200000, ScriptName='boss_rotface' WHERE entry=36627;
UPDATE creature_template SET speed_walk=1, speed_run=1.5873, rank=3, unit_flags=0, baseattacktime=0, mindmg=3948, maxdmg=5382, attackpower=300, dmg_multiplier=13, AIName='', mechanic_immune_mask=650854271, flags_extra=1+0x200000, ScriptName='' WHERE entry=38390;
UPDATE creature_template SET speed_walk=1, speed_run=1.5873, rank=3, unit_flags=0, baseattacktime=0, mindmg=7332, maxdmg=9996, attackpower=300, dmg_multiplier=7, AIName='', mechanic_immune_mask=650854271, flags_extra=1+0x200000, ScriptName='' WHERE entry=38549;
UPDATE creature_template SET speed_walk=1, speed_run=1.5873, rank=3, unit_flags=0, baseattacktime=0, mindmg=5261, maxdmg=7172, attackpower=300, dmg_multiplier=13, AIName='', mechanic_immune_mask=650854271, flags_extra=1+0x200000, ScriptName='' WHERE entry=38550;
UPDATE creature SET spawntimesecs=604800 WHERE id IN(36627, 38390, 38549, 38550);

-- Puddle Stalker (37013) -- done in festergut section

-- Precious (37217, 38103)
REPLACE INTO creature_addon VALUES (201247, 2012470, 0, 0, 1, 0, '70404');
UPDATE creature_template SET speed_walk=1, speed_run=1.71429, mindmg=1734, maxdmg=2364, attackpower=300, dmg_multiplier=7, AIName='', mechanic_immune_mask=650854271, flags_extra=1+0x200000, ScriptName='npc_precious_icc' WHERE entry=37217;
UPDATE creature_template SET speed_walk=1, speed_run=1.71429, mindmg=1400, maxdmg=1909, attackpower=300, dmg_multiplier=13, AIName='', mechanic_immune_mask=650854271, flags_extra=1+0x200000, ScriptName='' WHERE entry=38103;
DELETE FROM smart_scripts WHERE entryorguid IN(37217, 38103) AND source_type=0;

-- Plagued Zombie (38104, 38105)
UPDATE creature_template SET speed_walk=1, speed_run=1.14286, mindmg=300, maxdmg=400, attackpower=300, dmg_multiplier=7, unit_flags=0, AIName='', ScriptName='' WHERE entry=38104;
UPDATE creature_template SET speed_walk=1, speed_run=1.14286, mindmg=250, maxdmg=350, attackpower=300, dmg_multiplier=13, unit_flags=0, AIName='', ScriptName='' WHERE entry=38105;
REPLACE INTO creature_template_addon VALUES(38104, 0, 0, 0, 1, 0, '71158');
REPLACE INTO creature_template_addon VALUES(38105, 0, 0, 0, 1, 0, '71158');

-- Ooze Spray Stalker (37986)
UPDATE creature_template SET difficulty_entry_1=0, modelid1=11686, modelid2=0, modelid3=0, modelid4=0, minlevel=80, maxlevel=80, faction=35, unit_flags=33554432, AIName='NullCreatureAI', flags_extra=128 WHERE entry=37986;
DELETE FROM creature_template_addon WHERE entry IN(37986);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37986) AND `map`=631 );
DELETE FROM creature WHERE id IN(37986) AND `map`=631;

-- Little Ooze (36897, 38138)
UPDATE creature_template SET minlevel=82, maxlevel=82, faction=2068, speed_walk=1, speed_run=1.14286, mindmg=300, maxdmg=400, attackpower=300, dmg_multiplier=7, unit_flags=0, AIName='', ScriptName='npc_little_ooze', mechanic_immune_mask=650854271, flags_extra=256+0x200000 WHERE entry=36897;
UPDATE creature_template SET minlevel=82, maxlevel=82, faction=2068, speed_walk=1, speed_run=1.14286, mindmg=300, maxdmg=400, attackpower=300, dmg_multiplier=13, unit_flags=0, AIName='', ScriptName='', mechanic_immune_mask=650854271, flags_extra=256+0x200000 WHERE entry=38138;
DELETE FROM creature_template_addon WHERE entry IN(36897, 38138);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36897, 38138) AND `map`=631 );
DELETE FROM creature WHERE id IN(36897, 38138) AND `map`=631;

-- Large Ooze (36899, 38123)
UPDATE creature_template SET minlevel=82, maxlevel=82, faction=14, speed_walk=1, speed_run=0.57143, mindmg=1563, maxdmg=2132, attackpower=300, dmg_multiplier=10, unit_flags=0, AIName='', ScriptName='npc_big_ooze', mechanic_immune_mask=650854271, flags_extra=0+0x200000 WHERE entry=36899;
UPDATE creature_template SET minlevel=82, maxlevel=82, faction=14, speed_walk=1, speed_run=0.57143, mindmg=1263, maxdmg=1722, attackpower=300, dmg_multiplier=18, unit_flags=0, AIName='', ScriptName='', mechanic_immune_mask=650854271, flags_extra=0+0x200000 WHERE entry=38123;
DELETE FROM creature_template_addon WHERE entry IN(36899, 38123);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36899, 38123) AND `map`=631 );
DELETE FROM creature WHERE id IN(36899, 38123) AND `map`=631;
REPLACE INTO `creature_text` VALUES (36899, 4, 0, '|TInterface\\Icons\\spell_shadow_unstableaffliction_2.blp:16|t%s begins to cast |cFFFF0000Unstable Ooze Explosion!|r', 41, 0, 0, 0, 0, 0, 0, 'Rotface - EMOTE_UNSTABLE_EXPLOSION');

-- Sticky Ooze (37006)
UPDATE creature_template SET difficulty_entry_1=0, modelid1=11686, modelid2=0, modelid3=0, modelid4=0, minlevel=83, maxlevel=83, faction=14, unit_flags=33554432, AIName='NullCreatureAI', flags_extra=128 WHERE entry=37006;
REPLACE INTO creature_template_addon VALUES(37006, 0, 0, 0, 1, 0, '69776');
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37006) AND `map`=631 );
DELETE FROM creature WHERE id IN(37006) AND `map`=631;

-- Unstable Ooze Explosion Stalker (38107)
UPDATE creature_template SET difficulty_entry_1=0, modelid1=11686, modelid2=0, modelid3=0, modelid4=0, minlevel=83, maxlevel=83, faction=35, unit_flags=33554432, AIName='NullCreatureAI', flags_extra=128 WHERE entry=38107;
DELETE FROM creature_template_addon WHERE entry IN(38107);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38107) AND `map`=631 );
DELETE FROM creature WHERE id IN(38107) AND `map`=631;

-- spell Slime Spray (69508)
-- additional ids: triggered dmg (69507, 71213, 73189, 73190)
DELETE FROM spell_script_names WHERE spell_id IN(69508, 69507, 71213, 73189, 73190, -69508, -69507, -71213, -73189, -73190);
DELETE FROM spell_scripts WHERE id IN(69508, 69507, 71213, 73189, 73190, -69508, -69507, -71213, -73189, -73190);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69508, 69507, 71213, 73189, 73190, -69508, -69507, -71213, -73189, -73190) OR spell_effect IN(69508, 69507, 71213, 73189, 73190, -69508, -69507, -71213, -73189, -73190);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(69508, 69507, 71213, 73189, 73190, -69508, -69507, -71213, -73189, -73190);
INSERT INTO `conditions` VALUES (13, 1, 69508, 0, 0, 31, 0, 3, 37986, 0, 0, 0, 0, '', 'Rotface - Slime Spray');

-- spell Mutated Infection (69674, 71224, 73022, 73023)
DELETE FROM spell_script_names WHERE spell_id IN(69674, 71224, 73022, 73023, -69674, -71224, -73022, -73023);
DELETE FROM spell_scripts WHERE id IN(69674, 71224, 73022, 73023, -69674, -71224, -73022, -73023);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69674, 71224, 73022, 73023, -69674, -71224, -73022, -73023) OR spell_effect IN(69674, 71224, 73022, 73023, -69674, -71224, -73022, -73023);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(69674, 71224, 73022, 73023, -69674, -71224, -73022, -73023);
INSERT INTO spell_script_names VALUES(69674, 'spell_rotface_mutated_infection'),(71224, 'spell_rotface_mutated_infection'),(73022, 'spell_rotface_mutated_infection'),(73023, 'spell_rotface_mutated_infection');
-- INSERT INTO spell_linked_spell VALUES(-69674, 69706, 0, 'Rotface: Mutated Infection Summon'),(-71224, 69706, 0, 'Rotface: Mutated Infection Summon'),(-73022, 69706, 0, 'Rotface: Mutated Infection Summon'),(-73023, 69706, 0, 'Rotface: Mutated Infection Summon');

-- spell Ooze Flood (69782, 69796, 69798, 69801) -- cast by putricide
DELETE FROM spell_script_names WHERE spell_id IN(69782, 69796, 69798, 69801, -69782, -69796, -69798, -69801);
DELETE FROM spell_scripts WHERE id IN(69782, 69796, 69798, 69801, -69782, -69796, -69798, -69801);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69782, 69796, 69798, 69801, -69782, -69796, -69798, -69801) OR spell_effect IN(69782, 69796, 69798, 69801, -69782, -69796, -69798, -69801);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(69782, 69796, 69798, 69801, -69782, -69796, -69798, -69801);
INSERT INTO `conditions` VALUES (13, 1, 69782, 0, 0, 31, 0, 3, 37013, 0, 0, 0, 0, '', 'Rotface - Ooze Flood');
INSERT INTO `conditions` VALUES (13, 1, 69796, 0, 0, 31, 0, 3, 37013, 0, 0, 0, 0, '', 'Rotface - Ooze Flood');
INSERT INTO `conditions` VALUES (13, 1, 69798, 0, 0, 31, 0, 3, 37013, 0, 0, 0, 0, '', 'Rotface - Ooze Flood');
INSERT INTO `conditions` VALUES (13, 1, 69801, 0, 0, 31, 0, 3, 37013, 0, 0, 0, 0, '', 'Rotface - Ooze Flood');
REPLACE INTO disables VALUES(0, 69782, 64, '', '', 'Rotface Ooze Flood LOS'),(0, 69796, 64, '', '', 'Rotface Ooze Flood LOS'),(0, 69798, 64, '', '', 'Rotface Ooze Flood LOS'),(0, 69801, 64, '', '', 'Rotface Ooze Flood LOS');

-- spell Ooze Flood (69783, 69797, 69799, 69802) -- rzucane przez kurek
DELETE FROM spell_script_names WHERE spell_id IN(69783, 69797, 69799, 69802, -69783, -69797, -69799, -69802);
DELETE FROM spell_scripts WHERE id IN(69783, 69797, 69799, 69802, -69783, -69797, -69799, -69802);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69783, 69797, 69799, 69802, -69783, -69797, -69799, -69802) OR spell_effect IN(69783, 69797, 69799, 69802, -69783, -69797, -69799, -69802);
INSERT INTO spell_linked_spell VALUES (69783, -69785, 1, 'Remove Triggered Aura');
INSERT INTO spell_linked_spell VALUES (69783, -69788, 1, 'Remove Triggered Aura');
INSERT INTO spell_linked_spell VALUES (69797, -69785, 1, 'Remove Triggered Aura');
INSERT INTO spell_linked_spell VALUES (69797, -69788, 1, 'Remove Triggered Aura');
INSERT INTO spell_linked_spell VALUES (69799, -69785, 1, 'Remove Triggered Aura');
INSERT INTO spell_linked_spell VALUES (69799, -69788, 1, 'Remove Triggered Aura');
INSERT INTO spell_linked_spell VALUES (69802, -69785, 1, 'Remove Triggered Aura');
INSERT INTO spell_linked_spell VALUES (69802, -69788, 1, 'Remove Triggered Aura');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(69783, 69797, 69799, 69802, -69783, -69797, -69799, -69802);
INSERT INTO `conditions` VALUES (13, 1, 69783, 0, 0, 31, 0, 3, 37013, 0, 0, 0, 0, '', 'Rotface - Ooze Flood');
INSERT INTO `conditions` VALUES (13, 1, 69797, 0, 0, 31, 0, 3, 37013, 0, 0, 0, 0, '', 'Rotface - Ooze Flood');
INSERT INTO `conditions` VALUES (13, 1, 69799, 0, 0, 31, 0, 3, 37013, 0, 0, 0, 0, '', 'Rotface - Ooze Flood');
INSERT INTO `conditions` VALUES (13, 1, 69802, 0, 0, 31, 0, 3, 37013, 0, 0, 0, 0, '', 'Rotface - Ooze Flood');
REPLACE INTO disables VALUES(0, 69783, 64, '', '', 'Rotface Ooze Flood LOS'),(0, 69797, 64, '', '', 'Rotface Ooze Flood LOS'),(0, 69799, 64, '', '', 'Rotface Ooze Flood LOS'),(0, 69802, 64, '', '', 'Rotface Ooze Flood LOS');

-- spell Ooze Flood (69785, 69788) -- trafia w trigger na ziemi
-- additional ids: dmg (69789, 71215, 71587, 71588)
DELETE FROM spell_script_names WHERE spell_id IN(69785, 69788, 69789, 71215, 71587, 71588, -69785, -69788, -69789, -71215, -71587, -71588);
DELETE FROM spell_scripts WHERE id IN(69785, 69788, 69789, 71215, 71587, 71588, -69785, -69788, -69789, -71215, -71587, -71588);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69785, 69788, 69789, 71215, 71587, 71588, -69785, -69788, -69789, -71215, -71587, -71588) OR spell_effect IN(69785, 69788, 69789, 71215, 71587, 71588, -69785, -69788, -69789, -71215, -71587, -71588);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(69785, 69788, 69789, 71215, 71587, 71588, -69785, -69788, -69789, -71215, -71587, -71588);
REPLACE INTO disables VALUES(0, 69785, 64, '', '', 'Rotface Ooze Flood LOS'),(0, 69788, 64, '', '', 'Rotface Ooze Flood LOS');

-- spell Small Ooze Combine (69538) -- periodically triggered 0.5s on small oozes
DELETE FROM spell_script_names WHERE spell_id IN(69538, -69538);
DELETE FROM spell_scripts WHERE id IN(69538, -69538);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69538, -69538) OR spell_effect IN(69538, -69538);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(69538, -69538);
INSERT INTO `conditions` VALUES (13, 1, 69538, 0, 0, 31, 0, 3, 36897, 0, 0, 0, 0, '', 'Rotface - Small Ooze Combine');
INSERT INTO `conditions` VALUES (13, 1, 69538, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Rotface - Small Ooze Combine');
INSERT INTO spell_script_names VALUES(69538, 'spell_rotface_little_ooze_combine');

-- spell Summon Large Ooze (69540)
DELETE FROM spell_script_names WHERE spell_id IN(69540, -69540);
DELETE FROM spell_scripts WHERE id IN(69540, -69540);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69540, -69540) OR spell_effect IN(69540, -69540);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(69540, -69540);
INSERT INTO `conditions` VALUES (13, 7, 69540, 0, 0, 31, 0, 3, 36897, 0, 0, 0, 0, '', 'Rotface - Summon Big Ooze');
INSERT INTO `conditions` VALUES (13, 7, 69540, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Rotface - Summon Big Ooze');

-- spell Large Ooze Combine (69553)
DELETE FROM spell_script_names WHERE spell_id IN(69553, -69553);
DELETE FROM spell_scripts WHERE id IN(69553, -69553);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69553, -69553) OR spell_effect IN(69553, -69553);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(69553, -69553);
INSERT INTO `conditions` VALUES (13, 1, 69553, 0, 0, 31, 0, 3, 36899, 0, 0, 0, 0, '', 'Rotface - Large Ooze Combine');
INSERT INTO `conditions` VALUES (13, 1, 69553, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Rotface - Summon Big Ooze');
INSERT INTO spell_script_names VALUES(69553, 'spell_rotface_large_ooze_combine');

-- spell Large Ooze Buff Combine (69610)
DELETE FROM spell_script_names WHERE spell_id IN(69610, -69610);
DELETE FROM spell_scripts WHERE id IN(69610, -69610);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69610, -69610) OR spell_effect IN(69610, -69610);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(69610, -69610);
INSERT INTO `conditions` VALUES (13, 1, 69610, 0, 0, 31, 0, 3, 36897, 0, 0, 0, 0, '', 'Rotface - Large Ooze Buff Combine');
INSERT INTO `conditions` VALUES (13, 1, 69610, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Rotface - Summon Big Ooze');
INSERT INTO spell_script_names VALUES(69610, 'spell_rotface_large_ooze_buff_combine');

-- Unstable Ooze Explosion (69839)
-- additional ids: triggered on players summon (69840), trigger explosion dest (69832), explosion dmg (69833, 71209, 73029, 73030)
DELETE FROM spell_script_names WHERE spell_id IN(69839, 69840, 69832, 69833, 71209, 73029, 73030, -69839, -69840, -69832, -69833, -71209, -73029, -73030);
DELETE FROM spell_scripts WHERE id IN(69839, 69840, 69832, 69833, 71209, 73029, 73030, -69839, -69840, -69832, -69833, -71209, -73029, -73030);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69839, 69840, 69832, 69833, 71209, 73029, 73030, -69839, -69840, -69832, -69833, -71209, -73029, -73030) OR spell_effect IN(69839, 69840, 69832, 69833, 71209, 73029, 73030, -69839, -69840, -69832, -69833, -71209, -73029, -73030);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(69839, 69840, 69832, 69833, 71209, 73029, 73030, -69839, -69840, -69832, -69833, -71209, -73029, -73030);
INSERT INTO spell_script_names VALUES(69839, 'spell_rotface_unstable_ooze_explosion_init');
INSERT INTO spell_script_names VALUES(69832, 'spell_rotface_unstable_ooze_explosion');

-- Unstable Ooze Explosion Suicide Trigger (71441)
DELETE FROM spell_script_names WHERE spell_id IN(71441, -71441);
DELETE FROM spell_scripts WHERE id IN(71441, -71441);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71441, -71441) OR spell_effect IN(71441, -71441);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(71441, -71441);
INSERT INTO spell_script_names VALUES(71441, 'spell_rotface_unstable_ooze_explosion_suicide');



-- ###################
-- ### PROFESSOR PUTRICIDE
-- ###################

-- Professor Putricide (36678, 38431, 38585, 38586)
UPDATE creature_template SET speed_walk=1.2, speed_run=1.71429, rank=3, unit_flags=33554432, baseattacktime=1500, mindmg=4340, maxdmg=5921, attackpower=300, dmg_multiplier=7, VehicleId=587, AIName='', mechanic_immune_mask=650854271, flags_extra=1+0x200000, ScriptName='boss_professor_putricide' WHERE entry=36678;
UPDATE creature_template SET speed_walk=1.2, speed_run=1.71429, rank=3, unit_flags=33554432, baseattacktime=1500, mindmg=3507, maxdmg=4785, attackpower=300, dmg_multiplier=13, VehicleId=587, AIName='', mechanic_immune_mask=650854271, flags_extra=1+0x200000, ScriptName='' WHERE entry=38431;
UPDATE creature_template SET speed_walk=1.2, speed_run=1.71429, rank=3, unit_flags=33554432, baseattacktime=1500, mindmg=6513, maxdmg=8887, attackpower=300, dmg_multiplier=7, VehicleId=587, AIName='', mechanic_immune_mask=650854271, flags_extra=1+0x200000, ScriptName='' WHERE entry=38585;
UPDATE creature_template SET speed_walk=1.2, speed_run=1.71429, rank=3, unit_flags=33554432, baseattacktime=1500, mindmg=4673, maxdmg=6377, attackpower=300, dmg_multiplier=13, VehicleId=587, AIName='', mechanic_immune_mask=650854271, flags_extra=1+0x200000, ScriptName='' WHERE entry=38586;
REPLACE INTO creature_template_addon VALUES(36678, 0, 0, 0, 1, 69, ''),(38431, 0, 0, 0, 1, 69, ''),(38585, 0, 0, 0, 1, 69, ''),(38586, 0, 0, 0, 1, 69, '');
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36678, 38431, 38585, 38586) AND `map`=631 );
DELETE FROM vehicle_template_accessory WHERE entry IN(36678, 38431, 38585, 38586);
DELETE FROM vehicle_accessory WHERE guid IN( SELECT guid FROM creature WHERE id IN(36678, 38431, 38585, 38586) AND `map`=631 );
INSERT INTO vehicle_template_accessory VALUES(36678, 38309, 0, 1, 'Professor Putricide - trigger', 6, 30000);
INSERT INTO vehicle_template_accessory VALUES(36678, 38308, 1, 1, 'Professor Putricide - trigger', 6, 30000);
INSERT INTO vehicle_template_accessory VALUES(38431, 38309, 0, 1, 'Professor Putricide - trigger', 6, 30000);
INSERT INTO vehicle_template_accessory VALUES(38431, 38308, 1, 1, 'Professor Putricide - trigger', 6, 30000);
INSERT INTO vehicle_template_accessory VALUES(38585, 38309, 0, 1, 'Professor Putricide - trigger', 6, 30000);
INSERT INTO vehicle_template_accessory VALUES(38585, 38308, 1, 1, 'Professor Putricide - trigger', 6, 30000);
INSERT INTO vehicle_template_accessory VALUES(38586, 38309, 0, 1, 'Professor Putricide - trigger', 6, 30000);
INSERT INTO vehicle_template_accessory VALUES(38586, 38308, 1, 1, 'Professor Putricide - trigger', 6, 30000);
DELETE FROM npc_spellclick_spells WHERE npc_entry IN(36678, 38431, 38585, 38586);
INSERT INTO npc_spellclick_spells VALUES(36678, 46598, 1, 0),(38431, 46598, 1, 0),(38585, 46598, 1, 0),(38586, 46598, 1, 0);
UPDATE creature SET spawntimesecs=604800 WHERE id IN(36678, 38431, 38585, 38586);
REPLACE INTO creature_model_info VALUES(30881, 1.209, 7.8, 0, 0);
REPLACE INTO creature_model_info VALUES(30993, 1.209, 7.8, 0, 0);

-- Tear Gas Target Stalker (38317)
UPDATE creature_template SET difficulty_entry_1=0, modelid1=27823, modelid2=0, modelid3=0, modelid4=0, minlevel=83, maxlevel=83, faction=14, unit_flags=33554432, InhabitType=4, AIName='NullCreatureAI', flags_extra=128 WHERE entry=38317;
DELETE FROM creature_template_addon WHERE entry IN(38317);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38317) AND `map`=631 );
DELETE FROM creature WHERE id IN(38317) AND `map`=631;
INSERT INTO `creature` VALUES (NULL, 38317, 631, 15, 1, 0, 0, 4356.64, 3211.78, 389.483, 0, 86400, 0, 0, 25200, 0, 0, 0, 0, 0);

-- Abomination Wing Mad Scientist Stalker (37824)
UPDATE creature_template SET difficulty_entry_1=0, modelid1=11686, modelid2=0, modelid3=0, modelid4=0, minlevel=83, maxlevel=83, faction=14, unit_flags=33554432, InhabitType=4, AIName='NullCreatureAI', flags_extra=128 WHERE entry=37824;
DELETE FROM creature_template_addon WHERE entry IN(37824);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37824) AND `map`=631 );
DELETE FROM creature WHERE id IN(37824) AND `map`=631;
INSERT INTO `creature` VALUES (NULL, 37824, 631, 15, 1, 0, 0, 4324.28, 3215.04, 408.705, 5.58505, 86400, 0, 0, 25200, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37824, 631, 15, 1, 0, 0, 4388.1, 3213.29, 408.74, 3.83972, 86400, 0, 0, 25200, 0, 0, 0, 0, 0);

-- Volatile Ooze (37697, 38604, 38758, 38759)
UPDATE creature_template SET minlevel=82, maxlevel=82, faction=14, speed_walk=2, speed_run=1.28571, mindmg=200, maxdmg=300, attackpower=300, dmg_multiplier=7, unit_flags=0, AIName='', ScriptName='npc_volatile_ooze', mechanic_immune_mask=650854271, flags_extra=256+0x200000 WHERE entry=37697;
UPDATE creature_template SET minlevel=82, maxlevel=82, faction=14, speed_walk=2, speed_run=1.28571, mindmg=200, maxdmg=300, attackpower=300, dmg_multiplier=13, unit_flags=0, AIName='', ScriptName='', mechanic_immune_mask=650854271, flags_extra=256+0x200000 WHERE entry=38604;
UPDATE creature_template SET minlevel=82, maxlevel=82, faction=14, speed_walk=2, speed_run=1.28571, mindmg=400, maxdmg=600, attackpower=300, dmg_multiplier=7, unit_flags=0, AIName='', ScriptName='', mechanic_immune_mask=650854271, flags_extra=256+0x200000 WHERE entry=38758;
UPDATE creature_template SET minlevel=82, maxlevel=82, faction=14, speed_walk=2, speed_run=1.28571, mindmg=400, maxdmg=600, attackpower=300, dmg_multiplier=13, unit_flags=0, AIName='', ScriptName='', mechanic_immune_mask=650854271, flags_extra=256+0x200000 WHERE entry=38759;
DELETE FROM creature_template_addon WHERE entry IN(37697, 38604, 38758, 38759);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37697, 38604, 38758, 38759) AND `map`=631 );
DELETE FROM creature WHERE id IN(37697, 38604, 38758, 38759) AND `map`=631;

-- Gas Cloud (37562, 38602, 38760, 38761)
UPDATE creature_template SET minlevel=82, maxlevel=82, faction=14, speed_walk=1, speed_run=1.15, mindmg=200, maxdmg=300, attackpower=300, dmg_multiplier=7, unit_flags=0, AIName='', ScriptName='npc_gas_cloud', mechanic_immune_mask=650854271, flags_extra=256+0x200000 WHERE entry=37562;
UPDATE creature_template SET minlevel=82, maxlevel=82, faction=14, speed_walk=1, speed_run=1.15, mindmg=200, maxdmg=300, attackpower=300, dmg_multiplier=13, unit_flags=0, AIName='', ScriptName='', mechanic_immune_mask=650854271, flags_extra=256+0x200000 WHERE entry=38602;
UPDATE creature_template SET minlevel=82, maxlevel=82, faction=14, speed_walk=1, speed_run=1.15, mindmg=400, maxdmg=600, attackpower=300, dmg_multiplier=7, unit_flags=0, AIName='', ScriptName='', mechanic_immune_mask=650854271, flags_extra=256+0x200000 WHERE entry=38760;
UPDATE creature_template SET minlevel=82, maxlevel=82, faction=14, speed_walk=1, speed_run=1.15, mindmg=400, maxdmg=600, attackpower=300, dmg_multiplier=13, unit_flags=0, AIName='', ScriptName='', mechanic_immune_mask=650854271, flags_extra=256+0x200000 WHERE entry=38761;
DELETE FROM creature_template_addon WHERE entry IN(37562, 38602, 38760, 38761);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37562, 38602, 38760, 38761) AND `map`=631 );
DELETE FROM creature WHERE id IN(37562, 38602, 38760, 38761) AND `map`=631;

-- Ooze Covered Tentacle Stalker (38308)
UPDATE creature_template SET difficulty_entry_1=0, modelid1=22769, modelid2=0, modelid3=0, modelid4=0, minlevel=83, maxlevel=83, faction=14, unit_flags=33554432, AIName='NullCreatureAI', flags_extra=0 WHERE entry=38308;
DELETE FROM creature_template_addon WHERE entry IN(38308);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38308) AND `map`=631 );
DELETE FROM creature WHERE id IN(38308) AND `map`=631;

-- Slimy Tentacle Stalker (38309)
UPDATE creature_template SET difficulty_entry_1=0, modelid1=22769, modelid2=0, modelid3=0, modelid4=0, minlevel=83, maxlevel=83, faction=14, unit_flags=33554432, AIName='NullCreatureAI', flags_extra=0 WHERE entry=38309;
DELETE FROM creature_template_addon WHERE entry IN(38309);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38309) AND `map`=631 );
DELETE FROM creature WHERE id IN(38309) AND `map`=631;

-- Slimy Tentacle (37530) (green)
UPDATE creature_template SET difficulty_entry_1=0, modelid1=30641, modelid2=0, modelid3=0, modelid4=0, AIName='NullCreatureAI', ScriptName='' WHERE entry=37530;

-- Ooze Covered Tentacle (37535) (orange)
UPDATE creature_template SET difficulty_entry_1=0, modelid1=30641, modelid2=0, modelid3=0, modelid4=0, AIName='NullCreatureAI', ScriptName='' WHERE entry=37535;

-- Mutated Professor Putricide (38216)
UPDATE creature_template SET difficulty_entry_1=0, modelid1=30993, modelid2=0, modelid3=0, modelid4=0, AIName='NullCreatureAI', ScriptName='' WHERE entry=38216;

-- Mutated Abomination (37672, 38605, 38786, 38787) -- 10 man version
UPDATE creature_template SET speed_walk=2, speed_run=2.28, minlevel=80, maxlevel=80, faction=35, mindmg=400, maxdmg=500, attackpower=1, dmg_multiplier=5, unit_flags=0, unit_flags2=0, spell1=70360, spell2=70539, spell3=70542, spell4=0, spell5=0, spell6=0, spell7=0, spell8=0, VehicleId=591, AIName='', ScriptName='', flags_extra=0, mechanic_immune_mask=0 WHERE entry=37672;
UPDATE creature_template SET speed_walk=2, speed_run=2.28, minlevel=80, maxlevel=80, faction=35, mindmg=400, maxdmg=500, attackpower=1, dmg_multiplier=8, unit_flags=0, unit_flags2=0, spell1=70360, spell2=70539, spell3=70542, spell4=0, spell5=0, spell6=0, spell7=0, spell8=0, VehicleId=591, AIName='', ScriptName='', flags_extra=0, mechanic_immune_mask=0 WHERE entry=38605;
UPDATE creature_template SET speed_walk=2, speed_run=2.28, minlevel=80, maxlevel=80, faction=35, mindmg=400, maxdmg=500, attackpower=1, dmg_multiplier=5, unit_flags=0, unit_flags2=0, spell1=70360, spell2=70539, spell3=70542, spell4=0, spell5=0, spell6=0, spell7=0, spell8=0, VehicleId=591, AIName='', ScriptName='', flags_extra=0, mechanic_immune_mask=0 WHERE entry=38786;
UPDATE creature_template SET speed_walk=2, speed_run=2.28, minlevel=80, maxlevel=80, faction=35, mindmg=400, maxdmg=500, attackpower=1, dmg_multiplier=8, unit_flags=0, unit_flags2=0, spell1=70360, spell2=70539, spell3=70542, spell4=0, spell5=0, spell6=0, spell7=0, spell8=0, VehicleId=591, AIName='', ScriptName='', flags_extra=0, mechanic_immune_mask=0 WHERE entry=38787;
DELETE FROM creature_template_addon WHERE entry IN(37672, 38605, 38786, 38787);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37672, 38605, 38786, 38787) AND `map`=631 );
DELETE FROM creature WHERE id IN(37672, 38605, 38786, 38787) AND `map`=631;
DELETE FROM vehicle_template_accessory WHERE entry IN(37672, 38605, 38786, 38787);

-- Mutated Abomination (38285, 38788, 38789, 38790) -- 25 man version
UPDATE creature_template SET speed_walk=2, speed_run=2.28, minlevel=80, maxlevel=80, faction=35, mindmg=400, maxdmg=500, attackpower=1, dmg_multiplier=5, unit_flags=0, unit_flags2=0, spell1=72527, spell2=70539, spell3=70542, spell4=0, spell5=0, spell6=71516, spell7=0, spell8=0, VehicleId=591, AIName='', ScriptName='', flags_extra=0, mechanic_immune_mask=0 WHERE entry=38285;
UPDATE creature_template SET speed_walk=2, speed_run=2.28, minlevel=80, maxlevel=80, faction=35, mindmg=400, maxdmg=500, attackpower=1, dmg_multiplier=8, unit_flags=0, unit_flags2=0, spell1=72527, spell2=70539, spell3=70542, spell4=0, spell5=0, spell6=71516, spell7=0, spell8=0, VehicleId=591, AIName='', ScriptName='', flags_extra=0, mechanic_immune_mask=0 WHERE entry=38788;
UPDATE creature_template SET speed_walk=2, speed_run=2.28, minlevel=80, maxlevel=80, faction=35, mindmg=400, maxdmg=500, attackpower=1, dmg_multiplier=5, unit_flags=0, unit_flags2=0, spell1=72527, spell2=70539, spell3=70542, spell4=0, spell5=0, spell6=71516, spell7=0, spell8=0, VehicleId=591, AIName='', ScriptName='', flags_extra=0, mechanic_immune_mask=0 WHERE entry=38789;
UPDATE creature_template SET speed_walk=2, speed_run=2.28, minlevel=80, maxlevel=80, faction=35, mindmg=400, maxdmg=500, attackpower=1, dmg_multiplier=8, unit_flags=0, unit_flags2=0, spell1=72527, spell2=70539, spell3=70542, spell4=0, spell5=0, spell6=71516, spell7=0, spell8=0, VehicleId=591, AIName='', ScriptName='', flags_extra=0, mechanic_immune_mask=0 WHERE entry=38790;
DELETE FROM creature_template_addon WHERE entry IN(38285, 38788, 38789, 38790);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38285, 38788, 38789, 38790) AND `map`=631 );
DELETE FROM creature WHERE id IN(38285, 38788, 38789, 38790) AND `map`=631;
DELETE FROM vehicle_template_accessory WHERE entry IN(38285, 38788, 38789, 38790);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=21 AND SourceEntry=71516;
INSERT INTO `conditions` VALUES (21, 38285, 71516, 0, 0, 3, 0, 49888, 0, 0, 0, 0, 0, '', 'Mutated Abomination - Unholy Infusion');
INSERT INTO `conditions` VALUES (21, 38788, 71516, 0, 0, 3, 0, 49888, 0, 0, 0, 0, 0, '', 'Mutated Abomination - Unholy Infusion');
INSERT INTO `conditions` VALUES (21, 38789, 71516, 0, 0, 3, 0, 49888, 0, 0, 0, 0, 0, '', 'Mutated Abomination - Unholy Infusion');
INSERT INTO `conditions` VALUES (21, 38790, 71516, 0, 0, 3, 0, 49888, 0, 0, 0, 0, 0, '', 'Mutated Abomination - Unholy Infusion');

-- Growing Ooze Puddle (37690)
UPDATE creature_template SET difficulty_entry_1=0, modelid1=24719, modelid2=0, modelid3=0, modelid4=0, minlevel=83, maxlevel=83, faction=14, unit_flags=33554432, AIName='NullCreatureAI', flags_extra=0 WHERE entry=37690;
REPLACE INTO creature_template_addon VALUES(37690, 0, 0, 0, 1, 0, '70345 70343');
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37690) AND `map`=631 );
DELETE FROM creature WHERE id IN(37690) AND `map`=631;

-- Choking Gas Bomb (38159)
UPDATE creature_template SET difficulty_entry_1=0, modelid1=27823, modelid2=0, modelid3=0, modelid4=0, minlevel=83, maxlevel=83, faction=14, unit_flags=33554432, AIName='NullCreatureAI', flags_extra=0 WHERE entry=38159;
DELETE FROM creature_template_addon WHERE entry IN(38159);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38159) AND `map`=631 );
DELETE FROM creature WHERE id IN(38159) AND `map`=631;

-- spell Slime Puddle (70341, 70342)
DELETE FROM spell_script_names WHERE spell_id IN(70341, 70342, -70341, -70342);
DELETE FROM spell_scripts WHERE id IN(70341, 70342, -70341, -70342);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70341, 70342, -70341, -70342) OR spell_effect IN(70341, 70342, -70341, -70342);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70341, 70342, -70341, -70342);
INSERT INTO spell_script_names VALUES(70342, 'spell_putricide_slime_puddle_spawn');

-- spell Grow Stacker (70345, 70347)
DELETE FROM spell_script_names WHERE spell_id IN(70345, 70347, -70345, -70347);
DELETE FROM spell_scripts WHERE id IN(70345, 70347, -70345, -70347);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70345, 70347, -70345, -70347) OR spell_effect IN(70345, 70347, -70345, -70347);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70345, 70347, -70345, -70347);
INSERT INTO spell_script_names VALUES(70345, 'spell_putricide_grow_stacker');

-- spell Slime Puddle (70343)
-- additional ids: dmg (70346, 72456, 72868, 72869)
DELETE FROM spell_script_names WHERE spell_id IN(70343, 70346, 72456, 72868, 72869, -70343, -70346, -72456, -72868, -72869);
DELETE FROM spell_scripts WHERE id IN(70343, 70346, 72456, 72868, 72869, -70343, -70346, -72456, -72868, -72869);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70343, 70346, 72456, 72868, 72869, -70343, -70346, -72456, -72868, -72869) OR spell_effect IN(70343, 70346, 72456, 72868, 72869, -70343, -70346, -72456, -72868, -72869);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70343, 70346, 72456, 72868, 72869, -70343, -70346, -72456, -72868, -72869);
INSERT INTO `conditions` VALUES (13, 2, 70346, 0, 0, 31, 0, 3, 37672, 0, 0, 0, 0, '', 'Slime Puddle - target Mutated Abomination');
INSERT INTO `conditions` VALUES (13, 2, 72456, 0, 0, 31, 0, 3, 38285, 0, 0, 0, 0, '', 'Slime Puddle - target Mutated Abomination');
INSERT INTO `conditions` VALUES (13, 2, 72868, 0, 0, 31, 0, 3, 37672, 0, 0, 0, 0, '', 'Slime Puddle - target Mutated Abomination');
INSERT INTO `conditions` VALUES (13, 2, 72869, 0, 0, 31, 0, 3, 38285, 0, 0, 0, 0, '', 'Slime Puddle - target Mutated Abomination');
INSERT INTO spell_script_names VALUES(70346, 'spell_putricide_slime_puddle'),(72456, 'spell_putricide_slime_puddle'),(72868, 'spell_putricide_slime_puddle'),(72869, 'spell_putricide_slime_puddle');

-- spell Ooze Spell Tank Protection (71770)
-- additional ids: Volatile Ooze Beam Protection (70530), Gaseous Bloat Protection (70812)
DELETE FROM spell_script_names WHERE spell_id IN(71770, 70530, 70812, -71770, -70530, -70812);
DELETE FROM spell_scripts WHERE id IN(71770, 70530, 70812, -71770, -70530, -70812);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71770, 70530, 70812, -71770, -70530, -70812) OR spell_effect IN(71770, 70530, 70812, -71770, -70530, -70812);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(71770, 70530, 70812, -71770, -70530, -70812);
REPLACE INTO spell_proc_event VALUES(71770, 0, 0, 0, 0, 0, 0, 65536, 0, 0, 0);

-- spell Unstable Experiment (70351, 71966, 71967, 71968)
-- additional ids: Green Ooze Summon (71412, 71413), Orange Ooze Summon (71415, 71414)
DELETE FROM spell_script_names WHERE spell_id IN(70351, 71966, 71967, 71968, 71412, 71413, 71415, 71414, -70351, -71966, -71967, -71968, -71412, -71413, -71415, -71414);
DELETE FROM spell_scripts WHERE id IN(70351, 71966, 71967, 71968, 71412, 71413, 71415, 71414, -70351, -71966, -71967, -71968, -71412, -71413, -71415, -71414);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70351, 71966, 71967, 71968, 71412, 71413, 71415, 71414, -70351, -71966, -71967, -71968, -71412, -71413, -71415, -71414) OR spell_effect IN(70351, 71966, 71967, 71968, 71412, 71413, 71415, 71414, -70351, -71966, -71967, -71968, -71412, -71413, -71415, -71414);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70351, 71966, 71967, 71968, 71412, 71413, 71415, 71414, -70351, -71966, -71967, -71968, -71412, -71413, -71415, -71414);
INSERT INTO spell_script_names VALUES(70351, 'spell_putricide_unstable_experiment');
INSERT INTO spell_script_names VALUES(71966, 'spell_putricide_unstable_experiment');
INSERT INTO spell_script_names VALUES(71967, 'spell_putricide_unstable_experiment');
INSERT INTO spell_script_names VALUES(71968, 'spell_putricide_unstable_experiment');
DELETE FROM spell_target_position WHERE id IN(71413, 71414);
INSERT INTO spell_target_position VALUES(71413, 0, 631, 4380.43, 3206.55, 389.398, 0);
INSERT INTO spell_target_position VALUES(71414, 0, 631, 4335, 3206.75, 389.399, 0);

-- spell Gaseous Bloat (70215, 72858, 72859, 72860)
-- additional ids: (70672, 72455, 72832, 72833)
DELETE FROM spell_script_names WHERE spell_id IN(70215, 72858, 72859, 72860, 70672, 72455, 72832, 72833, -70215, -72858, -72859, -72860, -70672, -72455, -72832, -72833);
DELETE FROM spell_scripts WHERE id IN(70215, 72858, 72859, 72860, 70672, 72455, 72832, 72833, -70215, -72858, -72859, -72860, -70672, -72455, -72832, -72833);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70215, 72858, 72859, 72860, 70672, 72455, 72832, 72833, -70215, -72858, -72859, -72860, -70672, -72455, -72832, -72833) OR spell_effect IN(70215, 72858, 72859, 72860, 70672, 72455, 72832, 72833, -70215, -72858, -72859, -72860, -70672, -72455, -72832, -72833);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70215, 72858, 72859, 72860, 70672, 72455, 72832, 72833, -70215, -72858, -72859, -72860, -70672, -72455, -72832, -72833);
INSERT INTO spell_script_names VALUES(70672, 'spell_putricide_gaseous_bloat');
INSERT INTO spell_script_names VALUES(70672, 'spell_putricide_ooze_channel');
INSERT INTO spell_script_names VALUES(72455, 'spell_putricide_gaseous_bloat');
INSERT INTO spell_script_names VALUES(72455, 'spell_putricide_ooze_channel');
INSERT INTO spell_script_names VALUES(72832, 'spell_putricide_gaseous_bloat');
INSERT INTO spell_script_names VALUES(72832, 'spell_putricide_ooze_channel');
INSERT INTO spell_script_names VALUES(72833, 'spell_putricide_gaseous_bloat');
INSERT INTO spell_script_names VALUES(72833, 'spell_putricide_ooze_channel');
REPLACE INTO spell_proc_event VALUES(70672, 0, 0, 0, 0, 0, 0, 65536, 0, 0, 0),(72455, 0, 0, 0, 0, 0, 0, 65536, 0, 0, 0),(72832, 0, 0, 0, 0, 0, 0, 65536, 0, 0, 0),(72833, 0, 0, 0, 0, 0, 0, 65536, 0, 0, 0);

-- spell Expunged Gas (70701)
DELETE FROM spell_script_names WHERE spell_id IN(70701, -70701);
DELETE FROM spell_scripts WHERE id IN(70701, -70701);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70701, -70701) OR spell_effect IN(70701, -70701);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70701, -70701);

-- spell Volatile Ooze Adhesive (70447, 72836, 72837, 72838) -- rootuje target i idzie do niego, gdy dojdzie robi splited dmg
DELETE FROM spell_script_names WHERE spell_id IN(70447, 72836, 72837, 72838, -70447, -72836, -72837, -72838);
DELETE FROM spell_scripts WHERE id IN(70447, 72836, 72837, 72838, -70447, -72836, -72837, -72838);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70447, 72836, 72837, 72838, -70447, -72836, -72837, -72838) OR spell_effect IN(70447, 72836, 72837, 72838, -70447, -72836, -72837, -72838);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70447, 72836, 72837, 72838, -70447, -72836, -72837, -72838);
INSERT INTO spell_script_names VALUES(70447, 'spell_putricide_ooze_channel');
INSERT INTO spell_script_names VALUES(72836, 'spell_putricide_ooze_channel');
INSERT INTO spell_script_names VALUES(72837, 'spell_putricide_ooze_channel');
INSERT INTO spell_script_names VALUES(72838, 'spell_putricide_ooze_channel');

-- spell Ooze Eruption Search Periodic (70457)
-- additional ids: effect (70459)
DELETE FROM spell_script_names WHERE spell_id IN(70457, 70459, -70457, -70459);
DELETE FROM spell_scripts WHERE id IN(70457, 70459, -70457, -70459);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70457, 70459, -70457, -70459) OR spell_effect IN(70457, 70459, -70457, -70459);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70457, 70459, -70457, -70459);
INSERT INTO spell_script_names VALUES(70459, 'spell_putricide_ooze_eruption_searcher');

-- spell Ooze Eruption (70492, 72505, 72624, 72625)
DELETE FROM spell_script_names WHERE spell_id IN(70492, 72505, 72624, 72625, -70492, -72505, -72624, -72625);
DELETE FROM spell_scripts WHERE id IN(70492, 72505, 72624, 72625, -70492, -72505, -72624, -72625);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70492, 72505, 72624, 72625, -70492, -72505, -72624, -72625) OR spell_effect IN(70492, 72505, 72624, 72625, -70492, -72505, -72624, -72625);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70492, 72505, 72624, 72625, -70492, -72505, -72624, -72625);

-- spell Tear Gas (71617, 71615, 71618, 73170, 71620)
DELETE FROM spell_script_names WHERE spell_id IN(71617, 71615, 71618, -71617, -71615, -71618, 73170, -73170, 71620, -71620);
DELETE FROM spell_scripts WHERE id IN(71617, 71615, 71618, -71617, -71615, -71618, 73170, -73170, 71620, -71620);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71617, 71615, 71618, -71617, -71615, -71618, 73170, -73170, 71620, -71620) OR spell_effect IN(71617, 71615, 71618, -71617, -71615, -71618, 73170, -73170, 71620, -71620);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(71617, 71615, 71618, -71617, -71615, -71618, 73170, -73170, 71620, -71620);
INSERT INTO `conditions` VALUES (13, 1, 71617, 0, 0, 31, 0, 3, 38317, 0, 0, 0, 0, '', 'Putricide - Tear Gas');
INSERT INTO `conditions` VALUES (13, 4, 71615, 0, 0, 31, 0, 3, 37690, 0, 0, 0, 0, '', 'Putricide - Tear Gas on Slime Puddle');
INSERT INTO `conditions` VALUES (13, 1, 71618, 0, 0, 31, 0, 3, 37562, 0, 0, 0, 0, '', 'Putricide - Tear Gas on Gas Cloud');
INSERT INTO `conditions` VALUES (13, 2, 71618, 0, 0, 31, 0, 3, 37697, 0, 0, 0, 0, '', 'Putricide - Tear Gas on Volatile Ooze');
INSERT INTO `conditions` VALUES (13, 4, 71618, 0, 0, 31, 0, 3, 37690, 0, 0, 0, 0, '', 'Putricide - Tear Gas on Slime Puddle');
INSERT INTO `conditions` VALUES (13, 1, 71620, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Putricide - Tear Gas Cancel');
INSERT INTO `conditions` VALUES (13, 1, 71620, 0, 1, 31, 0, 3, 37690, 0, 0, 0, 0, '', 'Putricide - Tear Gas Cancel');
INSERT INTO `conditions` VALUES (13, 1, 71620, 0, 2, 31, 0, 3, 37562, 0, 0, 0, 0, '', 'Putricide - Tear Gas Cancel');
INSERT INTO `conditions` VALUES (13, 1, 71620, 0, 3, 31, 0, 3, 37697, 0, 0, 0, 0, '', 'Putricide - Tear Gas Cancel');
INSERT INTO `conditions` VALUES (13, 1, 71620, 0, 4, 31, 0, 3, 38159, 0, 0, 0, 0, '', 'Putricide - Tear Gas Cancel');
INSERT INTO `conditions` VALUES (13, 1, 71620, 0, 5, 31, 0, 3, 37672, 0, 0, 0, 0, '', 'Putricide - Tear Gas Cancel');
INSERT INTO `conditions` VALUES (13, 1, 71620, 0, 6, 31, 0, 3, 38285, 0, 0, 0, 0, '', 'Putricide - Tear Gas Cancel');
INSERT INTO spell_linked_spell VALUES(71620, -71615, 1, 'Putricide - Tear Gas Cancel'),(71620, -71618, 1, 'Putricide - Tear Gas Cancel');
REPLACE INTO spell_script_names VALUES(71615, 'spell_putricide_tear_gas_effect');

-- Ooze Variable (70352, 74118)
-- Gas Variable (70353, 74119)
DELETE FROM spell_script_names WHERE spell_id IN(70352, 74118, 70353, 74119, -70352, -74118, -70353, -74119);
DELETE FROM spell_scripts WHERE id IN(70352, 74118, 70353, 74119, -70352, -74118, -70353, -74119);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70352, 74118, 70353, 74119, -70352, -74118, -70353, -74119) OR spell_effect IN(70352, 74118, 70353, 74119, -70352, -74118, -70353, -74119);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70352, 74118, 70353, 74119, -70352, -74118, -70353, -74119);

-- spell Create Concoction (71621, 72850, 72851, 72852)
-- additional ids: 71826 (triggers 70158), 71827 (triggers 70160)
DELETE FROM spell_script_names WHERE spell_id IN(71621, 72850, 72851, 72852, 71826, 70158, 71827, 70160, -71621, -72850, -72851, -72852, -71826, -70158, -71827, -70160);
DELETE FROM spell_scripts WHERE id IN(71621, 72850, 72851, 72852, 71826, 70158, 71827, 70160, -71621, -72850, -72851, -72852, -71826, -70158, -71827, -70160);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71621, 72850, 72851, 72852, 71826, 70158, 71827, 70160, -71621, -72850, -72851, -72852, -71826, -70158, -71827, -70160) OR spell_effect IN(71621, 72850, 72851, 72852, 71826, 70158, 71827, 70160, -71621, -72850, -72851, -72852, -71826, -70158, -71827, -70160);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(71621, 72850, 72851, 72852, 71826, 70158, 71827, 70160, -71621, -72850, -72851, -72852, -71826, -70158, -71827, -70160);
INSERT INTO `conditions` VALUES (13, 1, 71621, 0, 0, 31, 0, 3, 38309, 0, 0, 0, 0, '', 'Putricide - Green Bottle');
INSERT INTO `conditions` VALUES (13, 2, 71621, 0, 0, 31, 0, 3, 38308, 0, 0, 0, 0, '', 'Putricide - Orange Bottle');
INSERT INTO `conditions` VALUES (13, 1, 72850, 0, 0, 31, 0, 3, 38309, 0, 0, 0, 0, '', 'Putricide - Green Bottle');
INSERT INTO `conditions` VALUES (13, 2, 72850, 0, 0, 31, 0, 3, 38308, 0, 0, 0, 0, '', 'Putricide - Orange Bottle');
INSERT INTO `conditions` VALUES (13, 1, 72851, 0, 0, 31, 0, 3, 38309, 0, 0, 0, 0, '', 'Putricide - Green Bottle');
INSERT INTO `conditions` VALUES (13, 2, 72851, 0, 0, 31, 0, 3, 38308, 0, 0, 0, 0, '', 'Putricide - Orange Bottle');
INSERT INTO `conditions` VALUES (13, 1, 72852, 0, 0, 31, 0, 3, 38309, 0, 0, 0, 0, '', 'Putricide - Green Bottle');
INSERT INTO `conditions` VALUES (13, 2, 72852, 0, 0, 31, 0, 3, 38308, 0, 0, 0, 0, '', 'Putricide - Orange Bottle');

-- spell Guzzle Potions (71893, 73120, 73121, 73122)
-- additional ids: Create Concoction (71704), Mutated Strength (71603, 72461), Mutated Strength linked (71604, 72673, 72674, 72675), 
-- additional ids: Mutated Plague (72451, 72463, 72671, 72672), Mutated Plague dmg (72454, 72464, 72506, 72507), Mutated Plague heal (72745, 72746, 72747, 72748)
DELETE FROM spell_script_names WHERE spell_id IN(71893, 73120, 73121, 73122, -71893, -73120, -73121, -73122, 71704, -71704, 71603, 72461, -71603, -72461);
DELETE FROM spell_scripts WHERE id IN(71893, 73120, 73121, 73122, -71893, -73120, -73121, -73122, 71704, -71704, 71603, 72461, -71603, -72461);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71893, 73120, 73121, 73122, -71893, -73120, -73121, -73122, 71704, -71704, 71603, 72461, -71603, -72461) OR spell_effect IN(71893, 73120, 73121, 73122, -71893, -73120, -73121, -73122, 71704, -71704, 71603, 72461, -71603, -72461);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(71893, 73120, 73121, 73122, -71893, -73120, -73121, -73122, 71704, -71704, 71603, 72461, -71603, -72461);
INSERT INTO `conditions` VALUES (13, 1, 71704, 0, 0, 31, 0, 3, 38309, 0, 0, 0, 0, '', 'Putricide - Green Bottle');
INSERT INTO `conditions` VALUES (13, 2, 71704, 0, 0, 31, 0, 3, 38308, 0, 0, 0, 0, '', 'Putricide - Orange Bottle');

DELETE FROM spell_script_names WHERE spell_id IN(71604, 72673, 72674, 72675, -71604, -72673, -72674, -72675, 72451, 72463, 72671, 72672, -72451, -72463, -72671, -72672);
DELETE FROM spell_scripts WHERE id IN(71604, 72673, 72674, 72675, -71604, -72673, -72674, -72675, 72451, 72463, 72671, 72672, -72451, -72463, -72671, -72672);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71604, 72673, 72674, 72675, -71604, -72673, -72674, -72675, 72451, 72463, 72671, 72672, -72451, -72463, -72671, -72672) OR spell_effect IN(71604, 72673, 72674, 72675, -71604, -72673, -72674, -72675, 72451, 72463, 72671, 72672, -72451, -72463, -72671, -72672);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(71604, 72673, 72674, 72675, -71604, -72673, -72674, -72675, 72451, 72463, 72671, 72672, -72451, -72463, -72671, -72672);
INSERT INTO spell_script_names VALUES(72451, 'spell_putricide_mutated_plague'),(72463, 'spell_putricide_mutated_plague'),(72671, 'spell_putricide_mutated_plague'),(72672, 'spell_putricide_mutated_plague');
REPLACE INTO spell_proc_event VALUES(71604, 0, 0, 0, 0, 0, 0, 65536, 0, 100, 10000),(72673, 0, 0, 0, 0, 0, 0, 65536, 0, 100, 10000),(72674, 0, 0, 0, 0, 0, 0, 65536, 0, 100, 10000),(72675, 0, 0, 0, 0, 0, 0, 65536, 0, 100, 10000);

DELETE FROM spell_script_names WHERE spell_id IN(72454, 72464, 72506, 72507, -72454, -72464, -72506, -72507, 72745, 72746, 72747, 72748, -72745, -72746, -72747, -72748);
DELETE FROM spell_scripts WHERE id IN(72454, 72464, 72506, 72507, -72454, -72464, -72506, -72507, 72745, 72746, 72747, 72748, -72745, -72746, -72747, -72748);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(72454, 72464, 72506, 72507, -72454, -72464, -72506, -72507, 72745, 72746, 72747, 72748, -72745, -72746, -72747, -72748) OR spell_effect IN(72454, 72464, 72506, 72507, -72454, -72464, -72506, -72507, 72745, 72746, 72747, 72748, -72745, -72746, -72747, -72748);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(72454, 72464, 72506, 72507, -72454, -72464, -72506, -72507, 72745, 72746, 72747, 72748, -72745, -72746, -72747, -72748);
INSERT INTO `conditions` VALUES (13, 1, 72745, 0, 0, 31, 0, 3, 36678, 0, 0, 0, 0, '', 'Putricide - Mutated Plague');
INSERT INTO `conditions` VALUES (13, 1, 72745, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Putricide - Mutated Plague');
INSERT INTO `conditions` VALUES (13, 1, 72746, 0, 0, 31, 0, 3, 36678, 0, 0, 0, 0, '', 'Putricide - Mutated Plague');
INSERT INTO `conditions` VALUES (13, 1, 72746, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Putricide - Mutated Plague');
INSERT INTO `conditions` VALUES (13, 1, 72747, 0, 0, 31, 0, 3, 36678, 0, 0, 0, 0, '', 'Putricide - Mutated Plague');
INSERT INTO `conditions` VALUES (13, 1, 72747, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Putricide - Mutated Plague');
INSERT INTO `conditions` VALUES (13, 1, 72748, 0, 0, 31, 0, 3, 36678, 0, 0, 0, 0, '', 'Putricide - Mutated Plague');
INSERT INTO `conditions` VALUES (13, 1, 72748, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Putricide - Mutated Plague');

-- spell Unbound Plague (70911, 72854, 72855, 72856)
-- additional ids: Unbound Plague Search Periodic (70917), Unbound Plague Search Effect (70920), Plague Sickness (70953, 73117), Unbound Plague Bounce Protection (70955)
DELETE FROM spell_script_names WHERE spell_id IN(70911, 72854, 72855, 72856, 70917, 70920, -70911, -72854, -72855, -72856, -70917, -70920, 70955, -70955, 70953, 73117, -70953, -73117);
DELETE FROM spell_scripts WHERE id IN(70911, 72854, 72855, 72856, 70917, 70920, -70911, -72854, -72855, -72856, -70917, -70920, 70955, -70955, 70953, 73117, -70953, -73117);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70911, 72854, 72855, 72856, 70917, 70920, -70911, -72854, -72855, -72856, -70917, -70920, 70955, -70955, 70953, 73117, -70953, -73117) OR spell_effect IN(70911, 72854, 72855, 72856, 70917, 70920, -70911, -72854, -72855, -72856, -70917, -70920, 70955, -70955, 70953, 73117, -70953, -73117);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70911, 72854, 72855, 72856, 70917, 70920, -70911, -72854, -72855, -72856, -70917, -70920, 70955, -70955, 70953, 73117, -70953, -73117);
INSERT INTO spell_script_names VALUES(70920, 'spell_putricide_unbound_plague');
INSERT INTO spell_script_names VALUES(70911, 'spell_putricide_unbound_plague_dmg'),(72854, 'spell_putricide_unbound_plague_dmg'),(72855, 'spell_putricide_unbound_plague_dmg'),(72856, 'spell_putricide_unbound_plague_dmg');

-- spell Choking Gas Bomb (71255)
-- additional ids: summon (71273, 71275, 71276), periodic (71259), effect (71278, 72460, 72619, 72620), explosion trigger (71280), explosion (71279, 72459, 72621, 72622)
DELETE FROM spell_script_names WHERE spell_id IN(71255, 71273, 71275, 71276, 71259, 71278, 72460, 72619, 72620, 71280, 71279, 72459, 72621, 72622, -71255, -71273, -71275, -71276, -71259, -71278, -72460, -72619, -72620, -71280, -71279, -72459, -72621, -72622);
DELETE FROM spell_scripts WHERE id IN(71255, 71273, 71275, 71276, 71259, 71278, 72460, 72619, 72620, 71280, 71279, 72459, 72621, 72622, -71255, -71273, -71275, -71276, -71259, -71278, -72460, -72619, -72620, -71280, -71279, -72459, -72621, -72622);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71255, 71273, 71275, 71276, 71259, 71278, 72460, 72619, 72620, 71280, 71279, 72459, 72621, 72622, -71255, -71273, -71275, -71276, -71259, -71278, -72460, -72619, -72620, -71280, -71279, -72459, -72621, -72622) OR spell_effect IN(71255, 71273, 71275, 71276, 71259, 71278, 72460, 72619, 72620, 71280, 71279, 72459, 72621, 72622, -71255, -71273, -71275, -71276, -71259, -71278, -72460, -72619, -72620, -71280, -71279, -72459, -72621, -72622);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(71255, 71273, 71275, 71276, 71259, 71278, 72460, 72619, 72620, 71280, 71279, 72459, 72621, 72622, -71255, -71273, -71275, -71276, -71259, -71278, -72460, -72619, -72620, -71280, -71279, -72459, -72621, -72622);
INSERT INTO `conditions` VALUES (13, 3, 71278, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Choking Gas Bomb');
INSERT INTO `conditions` VALUES (13, 3, 71278, 0, 0, 1, 0, 46598, 1, 0, 1, 0, 0, '', 'Choking Gas Bomb');
INSERT INTO `conditions` VALUES (13, 3, 71278, 0, 1, 31, 0, 3, 37672, 0, 0, 0, 0, '', 'Choking Gas Bomb');
INSERT INTO `conditions` VALUES (13, 3, 71278, 0, 2, 31, 0, 3, 38285, 0, 0, 0, 0, '', 'Choking Gas Bomb');
INSERT INTO `conditions` VALUES (13, 3, 72460, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Choking Gas Bomb');
INSERT INTO `conditions` VALUES (13, 3, 72460, 0, 0, 1, 0, 46598, 1, 0, 1, 0, 0, '', 'Choking Gas Bomb');
INSERT INTO `conditions` VALUES (13, 3, 72460, 0, 1, 31, 0, 3, 37672, 0, 0, 0, 0, '', 'Choking Gas Bomb');
INSERT INTO `conditions` VALUES (13, 3, 72460, 0, 2, 31, 0, 3, 38285, 0, 0, 0, 0, '', 'Choking Gas Bomb');
INSERT INTO `conditions` VALUES (13, 3, 72619, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Choking Gas Bomb');
INSERT INTO `conditions` VALUES (13, 3, 72619, 0, 0, 1, 0, 46598, 1, 0, 1, 0, 0, '', 'Choking Gas Bomb');
INSERT INTO `conditions` VALUES (13, 3, 72619, 0, 1, 31, 0, 3, 37672, 0, 0, 0, 0, '', 'Choking Gas Bomb');
INSERT INTO `conditions` VALUES (13, 3, 72619, 0, 2, 31, 0, 3, 38285, 0, 0, 0, 0, '', 'Choking Gas Bomb');
INSERT INTO `conditions` VALUES (13, 3, 72620, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Choking Gas Bomb');
INSERT INTO `conditions` VALUES (13, 3, 72620, 0, 0, 1, 0, 46598, 1, 0, 1, 0, 0, '', 'Choking Gas Bomb');
INSERT INTO `conditions` VALUES (13, 3, 72620, 0, 1, 31, 0, 3, 37672, 0, 0, 0, 0, '', 'Choking Gas Bomb');
INSERT INTO `conditions` VALUES (13, 3, 72620, 0, 2, 31, 0, 3, 38285, 0, 0, 0, 0, '', 'Choking Gas Bomb');
INSERT INTO `conditions` VALUES (13, 7, 71279, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Choking Gas Bomb');
INSERT INTO `conditions` VALUES (13, 7, 71279, 0, 0, 1, 0, 46598, 1, 0, 1, 0, 0, '', 'Choking Gas Bomb');
INSERT INTO `conditions` VALUES (13, 7, 71279, 0, 1, 31, 0, 3, 37672, 0, 0, 0, 0, '', 'Choking Gas Bomb');
INSERT INTO `conditions` VALUES (13, 7, 71279, 0, 2, 31, 0, 3, 38285, 0, 0, 0, 0, '', 'Choking Gas Bomb');
INSERT INTO `conditions` VALUES (13, 7, 72459, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Choking Gas Bomb');
INSERT INTO `conditions` VALUES (13, 7, 72459, 0, 0, 1, 0, 46598, 1, 0, 1, 0, 0, '', 'Choking Gas Bomb');
INSERT INTO `conditions` VALUES (13, 7, 72459, 0, 1, 31, 0, 3, 37672, 0, 0, 0, 0, '', 'Choking Gas Bomb');
INSERT INTO `conditions` VALUES (13, 7, 72459, 0, 2, 31, 0, 3, 38285, 0, 0, 0, 0, '', 'Choking Gas Bomb');
INSERT INTO `conditions` VALUES (13, 7, 72621, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Choking Gas Bomb');
INSERT INTO `conditions` VALUES (13, 7, 72621, 0, 0, 1, 0, 46598, 1, 0, 1, 0, 0, '', 'Choking Gas Bomb');
INSERT INTO `conditions` VALUES (13, 7, 72621, 0, 1, 31, 0, 3, 37672, 0, 0, 0, 0, '', 'Choking Gas Bomb');
INSERT INTO `conditions` VALUES (13, 7, 72621, 0, 2, 31, 0, 3, 38285, 0, 0, 0, 0, '', 'Choking Gas Bomb');
INSERT INTO `conditions` VALUES (13, 7, 72622, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Choking Gas Bomb');
INSERT INTO `conditions` VALUES (13, 7, 72622, 0, 0, 1, 0, 46598, 1, 0, 1, 0, 0, '', 'Choking Gas Bomb');
INSERT INTO `conditions` VALUES (13, 7, 72622, 0, 1, 31, 0, 3, 37672, 0, 0, 0, 0, '', 'Choking Gas Bomb');
INSERT INTO `conditions` VALUES (13, 7, 72622, 0, 2, 31, 0, 3, 38285, 0, 0, 0, 0, '', 'Choking Gas Bomb');
INSERT INTO spell_script_names VALUES(71255, 'spell_putricide_choking_gas_bomb');

-- spell Mutated Plague Clear (72618)
DELETE FROM spell_script_names WHERE spell_id IN(72618, -72618);
DELETE FROM spell_scripts WHERE id IN(72618, -72618);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(72618, -72618) OR spell_effect IN(72618, -72618);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(72618, -72618);
INSERT INTO spell_script_names VALUES(72618, 'spell_putricide_clear_aura_effect_value');
INSERT INTO `conditions` VALUES (13, 1, 72618, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Mutated Plague Clear - target players');

-- spell Mutated Transformation (70308)
-- additional ids: summon (70311, 71503), no power regen (70385), periodic trigger damage (70405, 72508, 72509, 72510), triggered (70402, 72511, 72512, 72513), copy name (72401), eat ooze (70360, 72527), Regurgitated Ooze (70539, 72457, 72875, 72876)
DELETE FROM spell_script_names WHERE spell_id IN(70308, 70311, 71503, 70385, 70405, 72508, 72509, 72510, 70402, 72511, 72512, 72513, 72401, 70360, 72527, 70539, 72457, 72875, 72876, -70308, -70311, -71503, -70385, -70405, -72508, -72509, -72510, -70402, -72511, -72512, -72513, -72401, -70360, -72527, -70539, -72457, -72875, -72876);
DELETE FROM spell_scripts WHERE id IN(70308, 70311, 71503, 70385, 70405, 72508, 72509, 72510, 70402, 72511, 72512, 72513, 72401, 70360, 72527, 70539, 72457, 72875, 72876, -70308, -70311, -71503, -70385, -70405, -72508, -72509, -72510, -70402, -72511, -72512, -72513, -72401, -70360, -72527, -70539, -72457, -72875, -72876);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70308, 70311, 71503, 70385, 70405, 72508, 72509, 72510, 70402, 72511, 72512, 72513, 72401, 70360, 72527, 70539, 72457, 72875, 72876, -70308, -70311, -71503, -70385, -70405, -72508, -72509, -72510, -70402, -72511, -72512, -72513, -72401, -70360, -72527, -70539, -72457, -72875, -72876) OR spell_effect IN(70308, 70311, 71503, 70385, 70405, 72508, 72509, 72510, 70402, 72511, 72512, 72513, 72401, 70360, 72527, 70539, 72457, 72875, 72876, -70308, -70311, -71503, -70385, -70405, -72508, -72509, -72510, -70402, -72511, -72512, -72513, -72401, -70360, -72527, -70539, -72457, -72875, -72876);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70308, 70311, 71503, 70385, 70405, 72508, 72509, 72510, 70402, 72511, 72512, 72513, 72401, 70360, 72527, 70539, 72457, 72875, 72876, -70308, -70311, -71503, -70385, -70405, -72508, -72509, -72510, -70402, -72511, -72512, -72513, -72401, -70360, -72527, -70539, -72457, -72875, -72876);
INSERT INTO spell_script_names VALUES(70308, 'spell_putricide_mutation_init');
INSERT INTO spell_script_names VALUES(70311, 'spell_putricide_mutated_transformation');
INSERT INTO spell_script_names VALUES(71503, 'spell_putricide_mutated_transformation');
INSERT INTO spell_script_names VALUES(70405, 'spell_putricide_mutated_transformation_dismiss');
INSERT INTO spell_script_names VALUES(72508, 'spell_putricide_mutated_transformation_dismiss');
INSERT INTO spell_script_names VALUES(72509, 'spell_putricide_mutated_transformation_dismiss');
INSERT INTO spell_script_names VALUES(72510, 'spell_putricide_mutated_transformation_dismiss');
INSERT INTO spell_script_names VALUES(70402, 'spell_putricide_mutated_transformation_dmg');
INSERT INTO spell_script_names VALUES(72511, 'spell_putricide_mutated_transformation_dmg');
INSERT INTO spell_script_names VALUES(72512, 'spell_putricide_mutated_transformation_dmg');
INSERT INTO spell_script_names VALUES(72513, 'spell_putricide_mutated_transformation_dmg');
INSERT INTO spell_script_names VALUES(70360, 'spell_putricide_eat_ooze');
INSERT INTO spell_script_names VALUES(72527, 'spell_putricide_eat_ooze');
INSERT INTO spell_script_names VALUES(70539, 'spell_putricide_regurgitated_ooze');
INSERT INTO spell_script_names VALUES(72457, 'spell_putricide_regurgitated_ooze');
INSERT INTO spell_script_names VALUES(72875, 'spell_putricide_regurgitated_ooze');
INSERT INTO spell_script_names VALUES(72876, 'spell_putricide_regurgitated_ooze');
INSERT INTO `conditions` VALUES (13, 1, 70360, 0, 0, 31, 0, 3, 37690, 0, 0, 0, 0, '', 'Mutated Abomination - Eat Ooze target');
INSERT INTO `conditions` VALUES (13, 1, 72527, 0, 0, 31, 0, 3, 37690, 0, 0, 0, 0, '', 'Mutated Abomination - Eat Ooze target');
INSERT INTO `conditions` VALUES (13, 1, 72401, 0, 0, 31, 0, 3, 37672, 0, 0, 0, 0, '', 'Putricide - Mutated Abomination');
INSERT INTO `conditions` VALUES (13, 1, 72401, 0, 1, 31, 0, 3, 38285, 0, 0, 0, 0, '', 'Putricide - Mutated Abomination');

-- ############# PUTRICIDE TRAP EVENT ##############

-- Area Trigger
REPLACE INTO areatrigger_scripts VALUES(5647, 'at_icc_putricide_trap');

-- Putricide's Trap (38879)
UPDATE creature_template SET faction=2102, unit_flags=33554432, InhabitType=4, flags_extra=130, AIName='', ScriptName='npc_icc_putricades_trap' WHERE entry=38879;

-- Flesh-eating Insect (37782, 38312)
UPDATE creature_template SET speed_walk=1, speed_run=1.14286, minlevel=75, maxlevel=75, exp=2, faction=16, rank=0, mindmg=828, maxdmg=1127, attackpower=300, dmg_multiplier=1, baseattacktime=2000, unit_class=1, unit_flags=0, lootid=0, InhabitType=3, flags_extra=0, mechanic_immune_mask=0, AIName='SmartAI', ScriptName='' WHERE entry=37782;
UPDATE creature_template SET speed_walk=1, speed_run=1.14286, minlevel=75, maxlevel=75, exp=2, faction=16, rank=0, mindmg=710, maxdmg=967, attackpower=300, dmg_multiplier=2, baseattacktime=2000, unit_class=1, unit_flags=0, lootid=0, InhabitType=3, flags_extra=0, mechanic_immune_mask=0, AIName='', ScriptName='' WHERE entry=38312;
DELETE FROM smart_scripts WHERE entryorguid=37782 AND source_type=0;

-- SPELL Leap to a Random Location (70485)
DELETE FROM conditions WHERE SourceEntry IN(70485) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 1, 70485, 0, 0, 31, 0, 3, 38879, 0, 0, 0, 0, '', 'Target Putricide''s Trap');


-- ###################
-- ### SISTER SVALNA
-- ###################

-- Crok Scourgebane (37129, 38000)
UPDATE creature_template SET faction=2214, speed_walk=1, speed_run=1.14286, unit_flags=0, baseattacktime=2000, mindmg=509, maxdmg=683, attackpower=300, dmg_multiplier=7, AIName='', ScriptName='npc_crok_scourgebane' WHERE entry=37129;
UPDATE creature_template SET faction=2214, speed_walk=1, speed_run=1.14286, unit_flags=0, baseattacktime=2000, mindmg=509, maxdmg=683, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38000;
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37129, 38000) AND `map`=631 );
DELETE FROM creature_template_addon WHERE entry IN(37129, 38000);
DELETE FROM script_waypoint WHERE entry=37129;
INSERT INTO `script_waypoint` VALUES (37129, 0, 4357.02, 2662.51, 352.07, 0, 'Crok Scourgebane - at first trash pack');
INSERT INTO `script_waypoint` VALUES (37129, 1, 4357, 2617, 351.101, 0, 'Crok Scourgebane - at second trash pack');
INSERT INTO `script_waypoint` VALUES (37129, 2, 4357.21, 2569.5, 351.15, 0, NULL);
INSERT INTO `script_waypoint` VALUES (37129, 3, 4357.09, 2540, 358.5, 0, NULL);
INSERT INTO `script_waypoint` VALUES (37129, 4, 4356.88, 2521.8, 358.5, 0, 'Crok Scourgebane - at Sister Svalna');

-- Captain Rupert (37125, 38304)
UPDATE creature_template SET faction=2131, speed_walk=1, speed_run=1.14286, unit_flags=0, baseattacktime=1500, mindmg=464, maxdmg=604, attackpower=300, dmg_multiplier=7, AIName='', ScriptName='npc_captain_rupert' WHERE entry=37125;
UPDATE creature_template SET faction=2131, speed_walk=1, speed_run=1.14286, unit_flags=0, baseattacktime=1500, mindmg=464, maxdmg=604, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38304;
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37125, 38304) AND `map`=631 );
DELETE FROM creature_template_addon WHERE entry IN(37125, 38304);

-- Captain Grondel (37124, 38303)
UPDATE creature_template SET faction=2131, speed_walk=1, speed_run=1.14286, unit_flags=0, baseattacktime=1500, mindmg=464, maxdmg=604, attackpower=300, dmg_multiplier=7, AIName='', ScriptName='npc_captain_grondel' WHERE entry=37124;
UPDATE creature_template SET faction=2131, speed_walk=1, speed_run=1.14286, unit_flags=0, baseattacktime=1500, mindmg=464, maxdmg=604, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38303;
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37124, 38303) AND `map`=631 );
DELETE FROM creature_template_addon WHERE entry IN(37124, 38303);

-- Captain Brandon (37123, 38299)
UPDATE creature_template SET faction=2131, speed_walk=1, speed_run=1.14286, unit_flags=0, baseattacktime=1500, mindmg=464, maxdmg=604, attackpower=300, dmg_multiplier=7, AIName='', ScriptName='npc_captain_brandon' WHERE entry=37123;
UPDATE creature_template SET faction=2131, speed_walk=1, speed_run=1.14286, unit_flags=0, baseattacktime=1500, mindmg=464, maxdmg=604, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38299;
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37123, 38299) AND `map`=631 );
DELETE FROM creature_template_addon WHERE entry IN(37123, 38299);

-- Captain Arnath (37122, 38298)
UPDATE creature_template SET faction=2131, speed_walk=1, speed_run=1.14286, unit_flags=0, baseattacktime=1500, mindmg=464, maxdmg=604, attackpower=300, dmg_multiplier=7, AIName='', ScriptName='npc_captain_arnath' WHERE entry=37122;
UPDATE creature_template SET faction=2131, speed_walk=1, speed_run=1.14286, unit_flags=0, baseattacktime=1500, mindmg=464, maxdmg=604, attackpower=300, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=38298;
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37122, 38298) AND `map`=631 );
DELETE FROM creature_template_addon WHERE entry IN(37122, 38298);

-- Sister Svalna (37126, 38258)
UPDATE creature_template SET faction=2209, speed_walk=1.6, speed_run=2.28571, mindmg=3333, maxdmg=3923, attackpower=300, dmg_multiplier=7, unit_flags=64, InhabitType=4, HoverHeight=5, AIName='', ScriptName='boss_sister_svalna', mechanic_immune_mask=650854271, flags_extra=0+0x200000 WHERE entry=37126;
UPDATE creature_template SET faction=2209, speed_walk=1.6, speed_run=2.28571, mindmg=3000, maxdmg=3500, attackpower=300, dmg_multiplier=13, unit_flags=64, InhabitType=4, HoverHeight=5, AIName='', ScriptName='', mechanic_immune_mask=650854271, flags_extra=0+0x200000 WHERE entry=38258;
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37126, 38258) AND `map`=631 );
REPLACE INTO creature_addon VALUES(137753, 0, 0, 50331648, 1, 0, '70203 71465');
DELETE FROM creature_template_addon WHERE entry=137753;
UPDATE creature SET spawntimesecs=604800 WHERE id IN(37126, 38258);

-- Impaling Spear (38248)
UPDATE creature_template SET faction=2209, npcflag=16777216, unit_flags=2, AIName='', mechanic_immune_mask=8388624, flags_extra=0+0x200000, ScriptName='npc_impaling_spear' WHERE entry=38248;
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37126, 38258) AND `map`=631 );
REPLACE INTO creature_template_addon VALUES(38248, 0, 0, 16777216, 1, 0, '');
DELETE FROM npc_spellclick_spells WHERE npc_entry=38248;
INSERT INTO npc_spellclick_spells VALUES(38248, 71462, 1, 2);

-- Ymirjar Huntress (37134, 38131)
UPDATE creature_template SET faction=2209, speed_walk=1, speed_run=1.28571, mindmg=767, maxdmg=1044, attackpower=300, dmg_multiplier=7, minrangedmg=767, maxrangedmg=1044, rangedattackpower=300, unit_flags=32832, InhabitType=3, AIName='', ScriptName='npc_frostwing_vrykul', flags_extra=0+0x200000 WHERE entry=37134;
UPDATE creature_template SET faction=2209, speed_walk=1, speed_run=1.28571, mindmg=615, maxdmg=837, attackpower=300, dmg_multiplier=13, minrangedmg=615, maxrangedmg=837, rangedattackpower=300, unit_flags=32832, InhabitType=3, AIName='', ScriptName='', flags_extra=0+0x200000 WHERE entry=38131;
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37134, 38131) AND `map`=631 );
DELETE FROM creature_template_addon WHERE entry IN(37134, 38131);

-- Warhawk (38154)
UPDATE creature_template SET difficulty_entry_1=0, faction=2209, speed_walk=1, speed_run=1.14286, mindmg=215, maxdmg=257, attackpower=300, dmg_multiplier=7, unit_flags=0, InhabitType=3, AIName='', ScriptName='' WHERE entry=38154;
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38154) AND `map`=631 );
DELETE FROM creature_template_addon WHERE entry IN(38154);

-- Ymirjar Warlord (37133, 38133)
UPDATE creature_template SET faction=2209, speed_walk=1, speed_run=1.42857, mindmg=825, maxdmg=1125, attackpower=300, dmg_multiplier=7, unit_flags=32832, InhabitType=3, AIName='', ScriptName='npc_frostwing_vrykul', flags_extra=0+0x200000 WHERE entry=37133;
UPDATE creature_template SET faction=2209, speed_walk=1, speed_run=1.42857, mindmg=666, maxdmg=909, attackpower=300, dmg_multiplier=13, unit_flags=32832, InhabitType=3, AIName='', ScriptName='', flags_extra=0+0x200000 WHERE entry=38133;
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37133, 38133) AND `map`=631 );
REPLACE INTO creature_template_addon VALUES(37133, 0, 0, 0, 1, 0, '71244'),(38133, 0, 0, 0, 1, 0, '71244');

-- Ymirjar Battle-Maiden (37132, 38132)
UPDATE creature_template SET faction=2209, speed_walk=1.2, speed_run=1.14286, mindmg=825, maxdmg=1125, attackpower=300, dmg_multiplier=7, unit_flags=32832, InhabitType=3, AIName='', ScriptName='npc_frostwing_vrykul', flags_extra=0+0x200000 WHERE entry=37132;
UPDATE creature_template SET faction=2209, speed_walk=1.2, speed_run=1.14286, mindmg=666, maxdmg=909, attackpower=300, dmg_multiplier=13, unit_flags=32832, InhabitType=3, AIName='', ScriptName='', flags_extra=0+0x200000 WHERE entry=38132;
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37132, 38132) AND `map`=631 );
DELETE FROM creature_template_addon WHERE entry IN(37132, 38132);

-- Ymirjar Frostbinder (37127, 38126)
UPDATE creature_template SET faction=2209, speed_walk=1, speed_run=1.14286, mindmg=825, maxdmg=1125, attackpower=300, dmg_multiplier=7, unit_flags=32832, InhabitType=3, mechanic_immune_mask=mechanic_immune_mask|32, AIName='', ScriptName='npc_frostwing_vrykul', flags_extra=0+0x200000 WHERE entry=37127;
UPDATE creature_template SET faction=2209, speed_walk=1, speed_run=1.14286, mindmg=666, maxdmg=909, attackpower=300, dmg_multiplier=13, unit_flags=32832, InhabitType=3, mechanic_immune_mask=mechanic_immune_mask|32, AIName='', ScriptName='', flags_extra=0+0x200000 WHERE entry=38126;
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37127, 38126) AND `map`=631 );
DELETE FROM creature_template_addon WHERE entry IN(37127, 38126);

-- Ymirjar Deathbringer (38125, 38130)
UPDATE creature_template SET faction=2209, speed_walk=1, speed_run=1.14286, mindmg=825, maxdmg=1125, attackpower=300, dmg_multiplier=7, unit_flags=32832, InhabitType=3, Mana_mod=30, AIName='', ScriptName='npc_frostwing_vrykul', flags_extra=0+0x200000 WHERE entry=38125;
UPDATE creature_template SET faction=2209, speed_walk=1, speed_run=1.14286, mindmg=666, maxdmg=909, attackpower=300, dmg_multiplier=13, unit_flags=32832, InhabitType=3, Mana_mod=30, AIName='', ScriptName='', flags_extra=0+0x200000 WHERE entry=38130;
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38125, 38130) AND `map`=631 );
DELETE FROM creature_template_addon WHERE entry IN(38125, 38130);

-- Corrupted Ymirjar (38184, 38185)
UPDATE creature_template SET faction=2209, speed_walk=1, speed_run=1.14286, mindmg=215, maxdmg=257, attackpower=300, dmg_multiplier=7, unit_flags=0, InhabitType=3, AIName='SmartAI', ScriptName='' WHERE entry=38184;
UPDATE creature_template SET faction=2209, speed_walk=1, speed_run=1.14286, mindmg=215, maxdmg=257, attackpower=300, dmg_multiplier=13, unit_flags=0, InhabitType=3, AIName='', ScriptName='' WHERE entry=38185;
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38184, 38185) AND `map`=631 );
DELETE FROM creature_template_addon WHERE entry IN(38184, 38185);
DELETE FROM smart_scripts WHERE entryorguid=38184 AND source_type=0;
INSERT INTO smart_scripts VALUES (38184, 0, 0, 0, 60, 0, 100, 257, 0, 0, 0, 0, 11, 50142, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Corrupted Ymirjar - On Update - Cast Emerge");
INSERT INTO smart_scripts VALUES (38184, 0, 1, 0, 37, 0, 100, 257, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Corrupted Ymirjar - On AI Init - Set React State Passive");
INSERT INTO smart_scripts VALUES (38184, 0, 2, 3, 60, 0, 100, 257, 3500, 3500, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Corrupted Ymirjar - On Update - Set React State Aggressive");
INSERT INTO smart_scripts VALUES (38184, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, "Corrupted Ymirjar - On Update - Attack Start");

-- Invisible Stalker (Float,Uninteractible,LargeAOI) (3.00) (38310), Maybe wrong...
UPDATE creature_template SET InhabitType=4, AIName='NullCreatureAI', ScriptName='' WHERE entry=38310;
DELETE FROM creature WHERE id=38310 AND map=631;
INSERT INTO creature VALUES (NULL, 38310, 631, 15, 1, 0, 0, 4327.3485, 2606.955, 368.74, 0.0, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 38310, 631, 15, 1, 0, 0, 4386.3485, 2606.955, 368.74, 0.0, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 38310, 631, 15, 1, 0, 0, 4386.3485, 2571.555, 368.74, 0.0, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 38310, 631, 15, 1, 0, 0, 4327.3485, 2571.555, 368.74, 0.0, 300, 0, 0, 42, 0, 0, 0, 0, 0);

-- spell Divine Surge (71464, 71465)
DELETE FROM spell_script_names WHERE spell_id IN(71464, 71465, -71464, -71465);
DELETE FROM spell_scripts WHERE id IN(71464, 71465, -71464, -71465);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71464, 71465, -71464, -71465) OR spell_effect IN(71464, 71465, -71464, -71465);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(71464, 71465);
INSERT INTO `conditions` VALUES (13, 1, 71464, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Sister Svalna - Divine Surge');

-- spell Caress of Death (70078)
-- additional ids: 70196
DELETE FROM spell_script_names WHERE spell_id IN(70078, 70196, -70078, -70196);
DELETE FROM spell_scripts WHERE id IN(70078, 70196, -70078, -70196);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70078, 70196, -70078, -70196) OR spell_effect IN(70078, 70196, -70078, -70196);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70078, 70196);
INSERT INTO spell_script_names VALUES(70078, 'spell_svalna_caress_of_death');
INSERT INTO `conditions` VALUES (13, 1, 70078, 0, 0, 31, 0, 3, 37122, 0, 0, 0, 0, '', 'Sister Svalna - Caress of Death');
INSERT INTO `conditions` VALUES (13, 1, 70078, 0, 1, 31, 0, 3, 37123, 0, 0, 0, 0, '', 'Sister Svalna - Caress of Death');
INSERT INTO `conditions` VALUES (13, 1, 70078, 0, 2, 31, 0, 3, 37124, 0, 0, 0, 0, '', 'Sister Svalna - Caress of Death');
INSERT INTO `conditions` VALUES (13, 1, 70078, 0, 3, 31, 0, 3, 37125, 0, 0, 0, 0, '', 'Sister Svalna - Caress of Death');

-- spell Revive Champion (70053)
DELETE FROM spell_script_names WHERE spell_id IN(70053, -70053);
DELETE FROM spell_scripts WHERE id IN(70053, -70053);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70053, -70053) OR spell_effect IN(70053, -70053);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70053);
INSERT INTO spell_script_names VALUES(70053, 'spell_svalna_revive_champion');
INSERT INTO `conditions` VALUES (13, 1, 70053, 0, 0, 31, 0, 3, 37122, 0, 0, 0, 0, '', 'Sister Svalna - Revive Champion');
INSERT INTO `conditions` VALUES (13, 1, 70053, 0, 1, 31, 0, 3, 37123, 0, 0, 0, 0, '', 'Sister Svalna - Revive Champion');
INSERT INTO `conditions` VALUES (13, 1, 70053, 0, 2, 31, 0, 3, 37124, 0, 0, 0, 0, '', 'Sister Svalna - Revive Champion');
INSERT INTO `conditions` VALUES (13, 1, 70053, 0, 3, 31, 0, 3, 37125, 0, 0, 0, 0, '', 'Sister Svalna - Revive Champion');

-- spell Remove Spear (71462)
DELETE FROM spell_script_names WHERE spell_id IN(71462, -71462);
DELETE FROM spell_scripts WHERE id IN(71462, -71462);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71462, -71462) OR spell_effect IN(71462, -71462);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=18 AND SourceEntry IN(71462);
INSERT INTO spell_script_names VALUES(71462, 'spell_svalna_remove_spear');
INSERT INTO conditions VALUES (18, 38248, 71462, 0, 0, 1, 0, 71443, 0, 0, 1, 0, 0, '', 'Forbidden aura for spellclick');

-- spell Hurl Spear (71466)
-- Aether Shield (71463)
DELETE FROM spell_script_names WHERE spell_id IN(71466, -71466);
DELETE FROM spell_scripts WHERE id IN(71466, -71466);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71466, -71466) OR spell_effect IN(71466, -71466);
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(13, 17) AND SourceEntry IN(71466);

-- spell Frozen Orb (71274, 71285, 71286, 71292)
DELETE FROM spell_script_names WHERE spell_id IN(71274, 71285, 71286, 71292, -71274, -71285, -71286, -71292);
DELETE FROM spell_scripts WHERE id IN(71274, 71285, 71286, 71292, -71274, -71285, -71286, -71292);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71274, 71285, 71286, 71292, -71274, -71285, -71286, -71292) OR spell_effect IN(71274, 71285, 71286, 71292, -71274, -71285, -71286, -71292);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(71274, 71285, 71286, 71292);
INSERT INTO spell_script_names VALUES(71274, 'spell_icc_yf_frozen_orb');

-- spell Twisted Winds (71306)
DELETE FROM spell_script_names WHERE spell_id IN(71306, -71306);
DELETE FROM spell_scripts WHERE id IN(71306, -71306);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71306, -71306) OR spell_effect IN(71306, -71306);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(71306);
INSERT INTO `conditions` VALUES (13, 1, 71306, 0, 0, 31, 0, 3, 37134, 0, 0, 0, 0, '', 'Ymirjar Frostbinder - Twisted Winds');
INSERT INTO `conditions` VALUES (13, 1, 71306, 0, 0, 38, 0, 99, 4, 0, 0, 0, 0, '', 'Ymirjar Frostbinder - Twisted Winds');
INSERT INTO `conditions` VALUES (13, 1, 71306, 0, 1, 31, 0, 3, 37133, 0, 0, 0, 0, '', 'Ymirjar Frostbinder - Twisted Winds');
INSERT INTO `conditions` VALUES (13, 1, 71306, 0, 1, 38, 0, 99, 4, 0, 0, 0, 0, '', 'Ymirjar Frostbinder - Twisted Winds');
INSERT INTO `conditions` VALUES (13, 1, 71306, 0, 2, 31, 0, 3, 37132, 0, 0, 0, 0, '', 'Ymirjar Frostbinder - Twisted Winds');
INSERT INTO `conditions` VALUES (13, 1, 71306, 0, 2, 38, 0, 99, 4, 0, 0, 0, 0, '', 'Ymirjar Frostbinder - Twisted Winds');
INSERT INTO `conditions` VALUES (13, 1, 71306, 0, 3, 31, 0, 3, 38125, 0, 0, 0, 0, '', 'Ymirjar Frostbinder - Twisted Winds');
INSERT INTO `conditions` VALUES (13, 1, 71306, 0, 3, 38, 0, 99, 4, 0, 0, 0, 0, '', 'Ymirjar Frostbinder - Twisted Winds');

-- spell Summon Undead (69516)
-- additional ids: 71302
DELETE FROM spell_script_names WHERE spell_id IN(69516, 71302, -69516, -71302);
DELETE FROM spell_scripts WHERE id IN(69516, 71302, -69516, -71302);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69516, 71302, -69516, -71302) OR spell_effect IN(69516, 71302, -69516, -71302);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(69516, 71302);
INSERT INTO spell_script_names VALUES(69516, 'spell_icc_yd_summon_undead');

-- spell Volley
REPLACE INTO spell_script_names VALUES(71252, 'spell_icc_yh_volley');



-- ###################
-- ### BLOOD PRINCE COUNCIL
-- ###################

-- Missing Pack
DELETE FROM creature_formations WHERE leaderGUID IN(247175, 247176, 247177);
INSERT INTO creature_formations VALUES (247175, 247175, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES (247175, 247176, 4, 135, 0, 0, 0);
INSERT INTO creature_formations VALUES (247175, 247177, 4, 225, 0, 0, 0);
REPLACE INTO creature_addon VALUES (247175, 2471750, 0, 0, 4097, 0, '');
DELETE FROM creature WHERE guid IN(247175, 247176, 247177) AND id IN(37662, 37665, 37666);
INSERT INTO creature VALUES (247175, 37662, 631, 15, 1, 0, 1, 4648.3, 2803.05, 361.173, 4.81448, 86400*14, 0, 0, 647040, 91600, 2, 0, 0, 0);
INSERT INTO creature VALUES (247176, 37665, 631, 15, 1, 0, 1, 4650.41, 2805.88, 361.173, 4.85767, 86400*14, 0, 0, 647040, 91600, 0, 0, 0, 0);
INSERT INTO creature VALUES (247177, 37666, 631, 15, 1, 0, 1, 4645.06, 2805.76, 361.169, 4.78306, 86400*14, 0, 0, 808860, 0, 0, 0, 0, 0);
DELETE FROM waypoint_data WHERE id=2471750;
INSERT INTO waypoint_data VALUES (2471750, 1, 4648.95, 2795.75, 361.181, 0, 0, 0, 0, 100, 0),(2471750, 2, 4650.25, 2778.3, 361.184, 0, 0, 0, 0, 100, 0),(2471750, 3, 4651.65, 2759.66, 361.185, 0, 0, 0, 0, 100, 0),(2471750, 4, 4653.04, 2741.1, 361.183, 0, 0, 0, 0, 100, 0),(2471750, 5, 4654.08, 2727.14, 361.174, 0, 0, 0, 0, 100, 0),(2471750, 6, 4653.25, 2738.8, 361.178, 0, 0, 0, 0, 100, 0),(2471750, 7, 4652.1, 2755.05, 361.185, 0, 0, 0, 0, 100, 0),(2471750, 8, 4651.2, 2767.83, 361.185, 0, 0, 0, 0, 100, 0),(2471750, 9, 4649.96, 2785.29, 361.185, 0, 0, 0, 0, 100, 0),(2471750, 10, 4649.14, 2796.88, 361.182, 0, 0, 0, 0, 100, 0),(2471750, 11, 4648.32, 2808.54, 361.169, 0, 0, 0, 0, 100, 0);

-- Blood Orb Controller (38008, 38641, 38773, 38774)
UPDATE creature_template SET ScriptName='' WHERE entry=38008;
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38008, 38641, 38773, 38774) AND `map`=631 );
DELETE FROM linked_respawn WHERE guid IN( SELECT guid FROM creature WHERE id IN(38008, 38641, 38773, 38774) AND `map`=631 );
DELETE FROM creature WHERE id IN(38008, 38641, 38773, 38774) AND `map`=631;
DELETE FROM creature_formations WHERE leaderGUID IN( SELECT guid FROM creature WHERE id IN(38008, 38641, 38773, 38774) AND `map`=631 );

-- Blood-Queen Lana'thel (38004)
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, rank=3, unit_flags=33088, InhabitType=3, AIName='', ScriptName='npc_blood_queen_lana_thel' WHERE entry=38004;
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38004) AND `map`=631 );
REPLACE INTO creature_template_addon VALUES(38004, 0, 0, 50331648, 0, 0, '');

-- Prince Taldaram (37973, 38400, 38771, 38772)
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, rank=3, unit_flags=536870912+32768+64, dynamicflags=8, baseattacktime=0, mindmg=4581, maxdmg=6246, attackpower=300, dmg_multiplier=7, AIName='', Health_mod=405, RegenHealth=0, mechanic_immune_mask=650854271, flags_extra=1+0x200000, ScriptName='boss_prince_taldaram_icc' WHERE entry=37973;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, rank=3, unit_flags=536870912+32768+64, dynamicflags=8, baseattacktime=0, mindmg=3700, maxdmg=5045, attackpower=300, dmg_multiplier=13, AIName='', Health_mod=1620, RegenHealth=0, mechanic_immune_mask=650854271, flags_extra=1+0x200000, ScriptName='' WHERE entry=38400;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, rank=3, unit_flags=536870912+32768+64, dynamicflags=8, baseattacktime=0, mindmg=6872, maxdmg=9369, attackpower=300, dmg_multiplier=7, AIName='', Health_mod=546.75, RegenHealth=0, mechanic_immune_mask=650854271, flags_extra=1+0x200000, ScriptName='' WHERE entry=38771;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, rank=3, unit_flags=536870912+32768+64, dynamicflags=8, baseattacktime=0, mindmg=4934, maxdmg=6724, attackpower=300, dmg_multiplier=13, AIName='', Health_mod=2187, RegenHealth=0, mechanic_immune_mask=650854271, flags_extra=1+0x200000, ScriptName='' WHERE entry=38772;
DELETE FROM creature_template_addon WHERE entry IN(37973, 38400, 38771, 38772);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37973, 38400, 38771, 38772) AND `map`=631 );
DELETE FROM linked_respawn WHERE guid IN( SELECT guid FROM creature WHERE id IN(37973, 38400, 38771, 38772) AND `map`=631 );
UPDATE creature SET spawntimesecs=604800 WHERE id IN(37973, 38400, 38771, 38772);
DELETE FROM creature_formations WHERE leaderGUID IN( SELECT guid FROM creature WHERE id IN(37973, 38400, 38771, 38772) AND `map`=631 );

-- Prince Keleseth (37972, 38399, 38769, 38770)
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, rank=3, unit_flags=536870912+32768+64, dynamicflags=8, baseattacktime=0, mindmg=4581, maxdmg=6246, attackpower=300, dmg_multiplier=7, AIName='', Health_mod=405, RegenHealth=0, mechanic_immune_mask=650854271, flags_extra=1+0x200000, ScriptName='boss_prince_keleseth_icc' WHERE entry=37972;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, rank=3, unit_flags=536870912+32768+64, dynamicflags=8, baseattacktime=0, mindmg=3700, maxdmg=5045, attackpower=300, dmg_multiplier=13, AIName='', Health_mod=1620, RegenHealth=0, mechanic_immune_mask=650854271, flags_extra=1+0x200000, ScriptName='' WHERE entry=38399;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, rank=3, unit_flags=536870912+32768+64, dynamicflags=8, baseattacktime=0, mindmg=6872, maxdmg=9369, attackpower=300, dmg_multiplier=7, AIName='', Health_mod=546.75, RegenHealth=0, mechanic_immune_mask=650854271, flags_extra=1+0x200000, ScriptName='' WHERE entry=38769;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, rank=3, unit_flags=536870912+32768+64, dynamicflags=8, baseattacktime=0, mindmg=4934, maxdmg=6724, attackpower=300, dmg_multiplier=13, AIName='', Health_mod=2187, RegenHealth=0, mechanic_immune_mask=650854271, flags_extra=1+0x200000, ScriptName='' WHERE entry=38770;
DELETE FROM creature_template_addon WHERE entry IN(37972, 38399, 38769, 38770);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37972, 38399, 38769, 38770) AND `map`=631 );
DELETE FROM linked_respawn WHERE guid IN( SELECT guid FROM creature WHERE id IN(37972, 38399, 38769, 38770) AND `map`=631 );
UPDATE creature SET spawntimesecs=604800 WHERE id IN(37972, 38399, 38769, 38770);
DELETE FROM creature_formations WHERE leaderGUID IN( SELECT guid FROM creature WHERE id IN(37972, 38399, 38769, 38770) AND `map`=631 );

-- Prince Valanar (37970, 38401, 38784, 38785)
DELETE FROM creature_text WHERE entry=37970;
INSERT INTO creature_text VALUES (37970, 0, 0, 'Naxxanar was merely a setback! With the power of the orb, Valanar will have his vengeance!', 14, 0, 0, 0, 0, 16685, 0, 'Prince Valanar - SAY_VALANAR_INVOCATION');
INSERT INTO creature_text VALUES (37970, 1, 0, 'Invocation of Blood jumps to Prince Valanar!', 41, 0, 0, 0, 0, 0, 0, 'Prince Valanar - EMOTE_VALANAR_INVOCATION');
INSERT INTO creature_text VALUES (37970, 2, 0, 'My cup runneth over.', 14, 0, 0, 0, 0, 16686, 0, 'Prince Valanar - SAY_VALANAR_SPECIAL');
INSERT INTO creature_text VALUES (37970, 3, 0, '%s begins casting Empowered Shock Vortex!', 41, 0, 0, 0, 0, 0, 0, 'Prince Valanar - EMOTE_VALANAR_SHOCK_VORTEX');
INSERT INTO creature_text VALUES (37970, 4, 0, 'Dinner... is served.', 14, 0, 0, 0, 0, 16681, 0, 'Prince Valanar - SAY_VALANAR_KILL_1');
INSERT INTO creature_text VALUES (37970, 4, 1, 'Do you see NOW the power of the Darkfallen?', 14, 0, 0, 0, 0, 16682, 0, 'Prince Valanar - SAY_VALANAR_KILL_2');
INSERT INTO creature_text VALUES (37970, 5, 0, 'BOW DOWN BEFORE THE SAN''LAYN!', 14, 0, 0, 0, 0, 16684, 0, 'Prince Valanar - SAY_VALANAR_BERSERK');
INSERT INTO creature_text VALUES (37970, 6, 0, '...why...?', 14, 0, 0, 0, 0, 16683, 0, 'Prince Valanar - SAY_VALANAR_DEATH');
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, rank=3, unit_flags=536870912+32768+64, dynamicflags=8, baseattacktime=0, mindmg=4581, maxdmg=6246, attackpower=300, dmg_multiplier=7, AIName='', Health_mod=405, RegenHealth=0, mechanic_immune_mask=650854271, flags_extra=1+0x200000, ScriptName='boss_prince_valanar_icc' WHERE entry=37970;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, rank=3, unit_flags=536870912+32768+64, dynamicflags=8, baseattacktime=0, mindmg=3700, maxdmg=5045, attackpower=300, dmg_multiplier=13, AIName='', Health_mod=1620, RegenHealth=0, mechanic_immune_mask=650854271, flags_extra=1+0x200000, ScriptName='' WHERE entry=38401;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, rank=3, unit_flags=536870912+32768+64, dynamicflags=8, baseattacktime=0, mindmg=6872, maxdmg=9369, attackpower=300, dmg_multiplier=7, AIName='', Health_mod=546.75, RegenHealth=0, mechanic_immune_mask=650854271, flags_extra=1+0x200000, ScriptName='' WHERE entry=38784;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, rank=3, unit_flags=536870912+32768+64, dynamicflags=8, baseattacktime=0, mindmg=4934, maxdmg=6724, attackpower=300, dmg_multiplier=13, AIName='', Health_mod=2187, RegenHealth=0, mechanic_immune_mask=650854271, flags_extra=1+0x200000, ScriptName='' WHERE entry=38785;
DELETE FROM creature_template_addon WHERE entry IN(37970, 38401, 38784, 38785);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37970, 38401, 38784, 38785) AND `map`=631 );
DELETE FROM linked_respawn WHERE guid IN( SELECT guid FROM creature WHERE id IN(37970, 38401, 38784, 38785) AND `map`=631 );
UPDATE creature SET spawntimesecs=604800 WHERE id IN(37970, 38401, 38784, 38785);
DELETE FROM creature_formations WHERE leaderGUID IN( SELECT guid FROM creature WHERE id IN(37970, 38401, 38784, 38785) AND `map`=631 );
UPDATE creature_loot_template SET maxcount=2 WHERE entry IN(37970, 38784) AND item=1;

-- Dark Nucleus (38369)
UPDATE creature_template SET difficulty_entry_1=0, difficulty_entry_2=0, difficulty_entry_3=0, minlevel=82, maxlevel=82, faction=16, speed_walk=4, speed_run=1.42857, unit_flags=0, AIName='', InhabitType=3, HoverHeight=1, mechanic_immune_mask=650854271, flags_extra=0+0x600000, ScriptName='npc_dark_nucleus' WHERE entry=38369;
DELETE FROM creature_template_addon WHERE entry IN(38369);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38369) AND `map`=631 );
DELETE FROM creature WHERE id IN(38369) AND `map`=631;
REPLACE INTO creature_model_info VALUES(31196, 0, 6.5, 2, 0);

-- Ball of Flame (38332)
UPDATE creature_template SET difficulty_entry_1=0, difficulty_entry_2=0, difficulty_entry_3=0, modelid1=26767, modelid2=0, minlevel=82, maxlevel=82, faction=14, speed_walk=4.4, speed_run=1.57143, unit_flags=33554432+131072, AIName='', InhabitType=4, mechanic_immune_mask=0, flags_extra=0, ScriptName='npc_ball_of_flame' WHERE entry=38332;
REPLACE INTO creature_template_addon VALUES(38332, 0, 0, 50331648, 0, 0, '55891 71706');
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38332) AND `map`=631 );
DELETE FROM creature WHERE id IN(38332) AND `map`=631;

-- Ball of Inferno Flame (38451)
UPDATE creature_template SET difficulty_entry_1=0, difficulty_entry_2=0, difficulty_entry_3=0, modelid1=26767, modelid2=0, minlevel=82, maxlevel=82, faction=14, speed_walk=4.4, speed_run=1.57143, unit_flags=33554432+131072, AIName='', InhabitType=4, mechanic_immune_mask=0, flags_extra=0, ScriptName='npc_ball_of_flame' WHERE entry=38451;
REPLACE INTO creature_template_addon VALUES(38451, 0, 0, 50331648, 0, 0, '55891 71706');
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38451) AND `map`=631 );
DELETE FROM creature WHERE id IN(38451) AND `map`=631;

-- Kinetic Bomb Target (38458)
UPDATE creature_template SET difficulty_entry_1=0, difficulty_entry_2=0, difficulty_entry_3=0, modelid1=21342, modelid2=0, minlevel=82, maxlevel=82, faction=35, unit_flags=33554432, AIName='NullCreatureAI', InhabitType=4, flags_extra=0, ScriptName='' WHERE entry=38458;
DELETE FROM creature_template_addon WHERE entry IN(38458);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38458) AND `map`=631 );
DELETE FROM creature WHERE id IN(38458) AND `map`=631;

-- Kinetic Bomb (38454, 38775, 38776, 38777)
UPDATE creature_template SET modelid1=31095, modelid2=0, minlevel=82, maxlevel=82, faction=14, speed_walk=0.8, speed_run=0.28571, unit_flags=0, AIName='', InhabitType=4, Health_mod=0.074179, mechanic_immune_mask=650854271, flags_extra=0+0x200000, ScriptName='npc_kinetic_bomb' WHERE entry=38454;
UPDATE creature_template SET modelid1=31095, modelid2=0, minlevel=82, maxlevel=82, faction=14, speed_walk=0.8, speed_run=0.28571, unit_flags=0, AIName='', InhabitType=4, Health_mod=0.074179, mechanic_immune_mask=650854271, flags_extra=0+0x200000, ScriptName='' WHERE entry=38775;
UPDATE creature_template SET modelid1=31095, modelid2=0, minlevel=82, maxlevel=82, faction=14, speed_walk=1.2, speed_run=0.28571, unit_flags=0, AIName='', InhabitType=4, Health_mod=0.074179, mechanic_immune_mask=650854271, flags_extra=0+0x200000, ScriptName='' WHERE entry=38776;
UPDATE creature_template SET modelid1=31095, modelid2=0, minlevel=82, maxlevel=82, faction=14, speed_walk=1.2, speed_run=0.28571, unit_flags=0, AIName='', InhabitType=4, Health_mod=0.074179, mechanic_immune_mask=650854271, flags_extra=0+0x200000, ScriptName='' WHERE entry=38777;
REPLACE INTO creature_template_addon VALUES(38454, 0, 0, 50331648, 1, 0, '72054 72059'),(38775, 0, 0, 50331648, 1, 0, '72054 72059'),(38776, 0, 0, 50331648, 1, 0, '72054 72059'),(38777, 0, 0, 50331648, 1, 0, '72054 72059');
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38454, 38775, 38776, 38777) AND `map`=631 );
DELETE FROM creature WHERE id IN(38454, 38775, 38776, 38777) AND `map`=631;

-- Shock Vortex (38422)
UPDATE creature_template SET difficulty_entry_1=0, modelid1=23258, modelid2=0, modelid3=0, modelid4=0, minlevel=83, maxlevel=83, faction=16, unit_flags=33554432, AIName='NullCreatureAI', flags_extra=0 WHERE entry=38422;
REPLACE INTO creature_template_addon VALUES(38422, 0, 0, 0, 1, 0, '72633');
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38422) AND `map`=631 );
DELETE FROM creature WHERE id IN(38422) AND `map`=631;

-- spell Invocation of Blood (70981, 71080, 70982, 71081, 70952, 71070)
-- additional ids: periodic beam to other princes (70983)
DELETE FROM spell_script_names WHERE spell_id IN(70981, 71080, 70982, 71081, 70952, 71070, 70983, -70981, -71080, -70982, -71081, -70952, -71070, -70983);
DELETE FROM spell_scripts WHERE id IN(70981, 71080, 70982, 71081, 70952, 71070, 70983, -70981, -71080, -70982, -71081, -70952, -71070, -70983);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70981, 71080, 70982, 71081, 70952, 71070, 70983, -70981, -71080, -70982, -71081, -70952, -71070, -70983) OR spell_effect IN(70981, 71080, 70982, 71081, 70952, 71070, 70983, -70981, -71080, -70982, -71081, -70952, -71070, -70983);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70981, 71080, 70982, 71081, 70952, 71070, 70983, -70981, -71080, -70982, -71081, -70952, -71070, -70983);
INSERT INTO `conditions` VALUES (13, 7, 70981, 0, 0, 31, 0, 3, 37972, 0, 0, 0, 0, '', 'Keleseth - Invocation of Blood');
INSERT INTO `conditions` VALUES (13, 1, 71080, 0, 0, 31, 0, 3, 37972, 0, 0, 0, 0, '', 'Keleseth - Invocation of Blood visual');
INSERT INTO `conditions` VALUES (13, 7, 70982, 0, 0, 31, 0, 3, 37973, 0, 0, 0, 0, '', 'Taldaram - Invocation of Blood');
INSERT INTO `conditions` VALUES (13, 1, 71081, 0, 0, 31, 0, 3, 37973, 0, 0, 0, 0, '', 'Taldaram - Invocation of Blood visual');
INSERT INTO `conditions` VALUES (13, 7, 70952, 0, 0, 31, 0, 3, 37970, 0, 0, 0, 0, '', 'Valanar - Invocation of Blood');
INSERT INTO `conditions` VALUES (13, 1, 71070, 0, 0, 31, 0, 3, 37970, 0, 0, 0, 0, '', 'Valanar - Invocation of Blood visual');
INSERT INTO `conditions` VALUES (13, 1, 70983, 0, 0, 31, 0, 3, 37970, 0, 0, 0, 0, '', 'Valanar - Invocation of Blood beam');
INSERT INTO `conditions` VALUES (13, 1, 70983, 0, 2, 31, 0, 3, 37973, 0, 0, 0, 0, '', 'Taldaram - Invocation of Blood beam');
INSERT INTO `conditions` VALUES (13, 1, 70983, 0, 1, 31, 0, 3, 37972, 0, 0, 0, 0, '', 'Keleseth - Invocation of Blood beam');

-- spell Shadow Resonance (71943)
-- additional ids: summon self periodic dmg (72980), resist (71822)
DELETE FROM spell_script_names WHERE spell_id IN(71943, -71943, 72980, 71822, -72980, -71822);
DELETE FROM spell_scripts WHERE id IN(71943, -71943, 72980, 71822, -72980, -71822);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71943, -71943, 72980, 71822, -72980, -71822) OR spell_effect IN(71943, -71943, 72980, 71822, -72980, -71822);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(71943, -71943, 72980, 71822, -72980, -71822);
INSERT INTO spell_script_names VALUES(71943, 'spell_blood_council_summon_shadow_resonance');

-- spell Shadow Prison (72998, 73001, 72999)
DELETE FROM spell_script_names WHERE spell_id IN(72998, 73001, 72999, -72998, -73001, -72999);
DELETE FROM spell_scripts WHERE id IN(72998, 73001, 72999, -72998, -73001, -72999);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(72998, 73001, 72999, -72998, -73001, -72999) OR spell_effect IN(72998, 73001, 72999, -72998, -73001, -72999);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(72998, 73001, 72999, -72998, -73001, -72999);
INSERT INTO spell_script_names VALUES(73001, 'spell_blood_council_shadow_prison');
INSERT INTO spell_script_names VALUES(72999, 'spell_blood_council_shadow_prison_damage');

-- spell Glittering Sparks (71806)
-- additional ids: triggered dmg (71807, 72796, 72797, 72798)
DELETE FROM spell_script_names WHERE spell_id IN(71806, 71807, 72796, 72797, 72798, -71806, -71807, -72796, -72797, -72798);
DELETE FROM spell_scripts WHERE id IN(71806, 71807, 72796, 72797, 72798, -71806, -71807, -72796, -72797, -72798);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71806, 71807, 72796, 72797, 72798, -71806, -71807, -72796, -72797, -72798) OR spell_effect IN(71806, 71807, 72796, 72797, 72798, -71806, -71807, -72796, -72797, -72798);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(71806, 71807, 72796, 72797, 72798, -71806, -71807, -72796, -72797, -72798);
INSERT INTO spell_script_names VALUES(71806, 'spell_taldaram_glittering_sparks');

-- spell Conjure Flame (71718)
-- spell Conjure Empowered Flame (72040)
-- additional ids: summon (71719), summon empowered (72041), visuals (55891, 55947, 71706), (71714)
DELETE FROM spell_script_names WHERE spell_id IN(71718, 72040, 71719, 72041, 55891, 55947, 71706, 71714, -71718, -72040, -71719, -72041, -55891, -55947, -71706, -71714);
DELETE FROM spell_scripts WHERE id IN(71718, 72040, 71719, 72041, 55891, 55947, 71706, 71714, -71718, -72040, -71719, -72041, -55891, -55947, -71706, -71714);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71718, 72040, 71719, 72041, 55891, 55947, 71706, 71714, -71718, -72040, -71719, -72041, -55891, -55947, -71706, -71714) OR spell_effect IN(71718, 72040, 71719, 72041, 55891, 55947, 71706, 71714, -71718, -72040, -71719, -72041, -55891, -55947, -71706, -71714);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(71718, 72040, 71719, 72041, 55891, 55947, 71706, 71714, -71718, -72040, -71719, -72041, -55891, -55947, -71706, -71714);
INSERT INTO spell_script_names VALUES(71718, 'spell_taldaram_summon_flame_ball');
INSERT INTO spell_script_names VALUES(72040, 'spell_taldaram_summon_flame_ball');

-- spell Ball of Flames Proc (71756, 72782, 72783, 72784)
-- additional ids: periodic trigger spell (71709), periodic effect (71708, 72785, 72786, 72787)
DELETE FROM spell_script_names WHERE spell_id IN(71756, 72782, 72783, 72784, 71709, 71708, 72785, 72786, 72787, -71756, -72782, -72783, -72784, -71709, -71708, -72785, -72786, -72787);
DELETE FROM spell_scripts WHERE id IN(71756, 72782, 72783, 72784, 71709, 71708, 72785, 72786, 72787, -71756, -72782, -72783, -72784, -71709, -71708, -72785, -72786, -72787);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71756, 72782, 72783, 72784, 71709, 71708, 72785, 72786, 72787, -71756, -72782, -72783, -72784, -71709, -71708, -72785, -72786, -72787) OR spell_effect IN(71756, 72782, 72783, 72784, 71709, 71708, 72785, 72786, 72787, -71756, -72782, -72783, -72784, -71709, -71708, -72785, -72786, -72787);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(71756, 72782, 72783, 72784, 71709, 71708, 72785, 72786, 72787, -71756, -72782, -72783, -72784, -71709, -71708, -72785, -72786, -72787);
INSERT INTO spell_script_names VALUES(71756, 'spell_taldaram_ball_of_inferno_flame');
INSERT INTO spell_script_names VALUES(72782, 'spell_taldaram_ball_of_inferno_flame');
INSERT INTO spell_script_names VALUES(72783, 'spell_taldaram_ball_of_inferno_flame');
INSERT INTO spell_script_names VALUES(72784, 'spell_taldaram_ball_of_inferno_flame');

-- spell Flames (71393, 72789, 72790, 72791) -- ball explosion dmg
DELETE FROM spell_script_names WHERE spell_id IN(71393, 72789, 72790, 72791, -71393, -72789, -72790, -72791);
DELETE FROM spell_scripts WHERE id IN(71393, 72789, 72790, 72791, -71393, -72789, -72790, -72791);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71393, 72789, 72790, 72791, -71393, -72789, -72790, -72791) OR spell_effect IN(71393, 72789, 72790, 72791, -71393, -72789, -72790, -72791);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(71393, 72789, 72790, 72791, -71393, -72789, -72790, -72791);

-- spell Kinetic Bomb (72053)
-- additional ids: summon proper (72080), explosion (72052, 72800, 72801, 72802), bomb model visual and absorb (72054), unstable (72059), knockback (72087)
DELETE FROM spell_script_names WHERE spell_id IN(72053, 72080, 72052, 72800, 72801, 72802, 72054, 72059, 72087, -72053, -72080, -72052, -72800, -72801, -72802, -72054, -72059, -72087);
DELETE FROM spell_scripts WHERE id IN(72053, 72080, 72052, 72800, 72801, 72802, 72054, 72059, 72087, -72053, -72080, -72052, -72800, -72801, -72802, -72054, -72059, -72087);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(72053, 72080, 72052, 72800, 72801, 72802, 72054, 72059, 72087, -72053, -72080, -72052, -72800, -72801, -72802, -72054, -72059, -72087) OR spell_effect IN(72053, 72080, 72052, 72800, 72801, 72802, 72054, 72059, 72087, -72053, -72080, -72052, -72800, -72801, -72802, -72054, -72059, -72087);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(72053, 72080, 72052, 72800, 72801, 72802, 72054, 72059, 72087, -72053, -72080, -72052, -72800, -72801, -72802, -72054, -72059, -72087);
INSERT INTO spell_script_names VALUES(72053, 'spell_valanar_kinetic_bomb_summon');
INSERT INTO spell_script_names VALUES(72080, 'spell_valanar_kinetic_bomb');
INSERT INTO spell_script_names VALUES(72054, 'spell_valanar_kinetic_bomb_absorb');
INSERT INTO spell_script_names VALUES(72087, 'spell_valanar_kinetic_bomb_knockback');
REPLACE INTO spell_proc_event VALUES(72059, 0, 0, 0, 0, 0, 0, 1024, 0, 0, 0);
REPLACE INTO disables VALUES(0, 72052, 64, '', '', 'Kinetic Bomb LOS (Blood Prince Council)'),(0, 72800, 64, '', '', 'Kinetic Bomb LOS (Blood Prince Council)'),(0, 72801, 64, '', '', 'Kinetic Bomb LOS (Blood Prince Council)'),(0, 72802, 64, '', '', 'Kinetic Bomb LOS (Blood Prince Council)');

-- spell Shock Vortex (72037)
-- spell Empowered Shock Vortex (72039, 73037, 73038, 73039)
-- additional ids: visual (72633), periodic (71945), effect (71944, 72812, 72813, 72814), effect of empowered (72038, 72815, 72816, 72817)
DELETE FROM spell_script_names WHERE spell_id IN(72037, 72039, 73037, 73038, 73039, 72633, 71945, 71944, 72812, 72813, 72814, 72038, 72815, 72816, 72817, -72037, -72039, -73037, -73038, -73039, -72633, -71945, -71944, -72812, -72813, -72814, -72038, -72815, -72816, -72817);
DELETE FROM spell_scripts WHERE id IN(72037, 72039, 73037, 73038, 73039, 72633, 71945, 71944, 72812, 72813, 72814, 72038, 72815, 72816, 72817, -72037, -72039, -73037, -73038, -73039, -72633, -71945, -71944, -72812, -72813, -72814, -72038, -72815, -72816, -72817);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(72037, 72039, 73037, 73038, 73039, 72633, 71945, 71944, 72812, 72813, 72814, 72038, 72815, 72816, 72817, -72037, -72039, -73037, -73038, -73039, -72633, -71945, -71944, -72812, -72813, -72814, -72038, -72815, -72816, -72817) OR spell_effect IN(72037, 72039, 73037, 73038, 73039, 72633, 71945, 71944, 72812, 72813, 72814, 72038, 72815, 72816, 72817, -72037, -72039, -73037, -73038, -73039, -72633, -71945, -71944, -72812, -72813, -72814, -72038, -72815, -72816, -72817);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(72037, 72039, 73037, 73038, 73039, 72633, 71945, 71944, 72812, 72813, 72814, 72038, 72815, 72816, 72817, -72037, -72039, -73037, -73038, -73039, -72633, -71945, -71944, -72812, -72813, -72814, -72038, -72815, -72816, -72817);

-- spell Feign Death (71598)
DELETE FROM spell_script_names WHERE spell_id IN(71598);



-- ###################
-- ### BLOOD-QUEEN LANA'THEL
-- ###################

-- Blood-Queen Lana'thel (37955, 38434, 38435, 38436)
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, rank=3, unit_flags=32832, baseattacktime=0, mindmg=8000, maxdmg=9714, attackpower=300, dmg_multiplier=7, AIName='', mechanic_immune_mask=650854271, flags_extra=1+0x200000, ScriptName='boss_blood_queen_lana_thel' WHERE entry=37955;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, rank=3, unit_flags=32832, baseattacktime=0, mindmg=5538, maxdmg=6460, attackpower=300, dmg_multiplier=13, AIName='', mechanic_immune_mask=650854271, flags_extra=1+0x200000, ScriptName='' WHERE entry=38434;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, rank=3, unit_flags=32832, baseattacktime=0, mindmg=8000, maxdmg=9714, attackpower=300, dmg_multiplier=9, AIName='', mechanic_immune_mask=650854271, flags_extra=1+0x200000, ScriptName='' WHERE entry=38435;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, rank=3, unit_flags=32832, baseattacktime=0, mindmg=5538, maxdmg=6460, attackpower=300, dmg_multiplier=16, AIName='', mechanic_immune_mask=650854271, flags_extra=1+0x200000, ScriptName='' WHERE entry=38436;
DELETE FROM creature_template_addon WHERE entry IN(37955, 38434, 38435, 38436);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37955, 38434, 38435, 38436) AND `map`=631 );
UPDATE creature SET spawntimesecs=604800 WHERE id IN(37955, 38434, 38435, 38436);

-- Blood Queen Door (38319)
UPDATE creature_template SET difficulty_entry_1=0, modelid1=23257, modelid2=0, modelid3=0, modelid4=0, minlevel=82, maxlevel=82, faction=35, unit_flags=33554432, AIName='NullCreatureAI', flags_extra=0 WHERE entry=38319;
DELETE FROM creature_template_addon WHERE entry IN(38319);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38319) AND `map`=631 );
DELETE FROM creature WHERE id IN(38319) AND `map`=631;
INSERT INTO `creature` VALUES (NULL, 38319, 631, 15, 1, 0, 0, 4536.55, 2769.65, 404.067, 6.21337, 86400, 0, 0, 42, 0, 0, 0, 0, 0);

-- Swarming Shadows (38163)
UPDATE creature_template SET difficulty_entry_1=0, modelid1=11686, modelid2=0, modelid3=0, modelid4=0, minlevel=82, maxlevel=82, faction=14, unit_flags=33554432, AIName='NullCreatureAI', flags_extra=0 WHERE entry=38163;
REPLACE INTO creature_template_addon VALUES(38163, 0, 0, 0, 1, 0, '71267');
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38163) AND `map`=631 );
DELETE FROM creature WHERE id IN(38163) AND `map`=631;

-- spell Shroud of Sorrow (70986, 72981, 72982, 72983)
-- additional ids: triggered damage (70985, 71698, 71699, 71700)
DELETE FROM spell_script_names WHERE spell_id IN(70986, 72981, 72982, 72983, 70985, 71698, 71699, 71700, -70986, -72981, -72982, -72983, -70985, -71698, -71699, -71700);
DELETE FROM spell_scripts WHERE id IN(70986, 72981, 72982, 72983, 70985, 71698, 71699, 71700, -70986, -72981, -72982, -72983, -70985, -71698, -71699, -71700);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70986, 72981, 72982, 72983, 70985, 71698, 71699, 71700, -70986, -72981, -72982, -72983, -70985, -71698, -71699, -71700) OR spell_effect IN(70986, 72981, 72982, 72983, 70985, 71698, 71699, 71700, -70986, -72981, -72982, -72983, -70985, -71698, -71699, -71700);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70986, 72981, 72982, 72983, 70985, 71698, 71699, 71700, -70986, -72981, -72982, -72983, -70985, -71698, -71699, -71700);

-- spell Frenzied Bloodthirst Visual (71949)
DELETE FROM spell_script_names WHERE spell_id IN(71949, -71949);
DELETE FROM spell_scripts WHERE id IN(71949, -71949);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71949, -71949) OR spell_effect IN(71949, -71949);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(71949, -71949);
INSERT INTO `conditions` VALUES (13, 1, 71949, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Blood Queen Lana\'thel - Frenzied Bloodthirst Visual');

-- spell Blood Mirror (70821)
-- additional ids: dummy for tooltip (70838), dummy to tank (71510)
DELETE FROM spell_script_names WHERE spell_id IN(70821, 70838, 71510, -70821, -70838, -71510);
DELETE FROM spell_scripts WHERE id IN(70821, 70838, 71510, -70821, -70838, -71510);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70821, 70838, 71510, -70821, -70838, -71510) OR spell_effect IN(70821, 70838, 71510, -70821, -70838, -71510);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70821, 70838, 71510, -70821, -70838, -71510);

-- spell Delirious Slash (71623, 71624, 71625, 71626)
DELETE FROM spell_script_names WHERE spell_id IN(71623, 71624, 71625, 71626, -71623, -71624, -71625, -71626);
DELETE FROM spell_scripts WHERE id IN(71623, 71624, 71625, 71626, -71623, -71624, -71625, -71626);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71623, 71624, 71625, 71626, -71623, -71624, -71625, -71626) OR spell_effect IN(71623, 71624, 71625, 71626, -71623, -71624, -71625, -71626);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(71623, 71624, 71625, 71626, -71623, -71624, -71625, -71626);

-- spell Pact of the Darkfallen (71340)
-- additional ids: periodically triggered (71390), damage (71341)
DELETE FROM spell_script_names WHERE spell_id IN(71340, 71390, 71341, -71340, -71390, -71341);
DELETE FROM spell_scripts WHERE id IN(71340, 71390, 71341, -71340, -71390, -71341);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71340, 71390, 71341, -71340, -71390, -71341) OR spell_effect IN(71340, 71390, 71341, -71340, -71390, -71341);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(71340, 71390, 71341, -71340, -71390, -71341);
INSERT INTO spell_script_names VALUES(71340, 'spell_blood_queen_pact_of_the_darkfallen_dmg');
INSERT INTO spell_script_names VALUES(71390, 'spell_blood_queen_pact_of_the_darkfallen');
INSERT INTO spell_script_names VALUES(71341, 'spell_blood_queen_pact_of_the_darkfallen_dmg_target');

-- spell Swarming Shadows (71264)
-- additional ids: periodic trigger (71265), player dot (71277, 72638, 72639, 72640), summon (71266, 72890), screen effect (72985), npc periodic (71267), floor dmg (71268, 72635, 72636, 72637)
DELETE FROM spell_script_names WHERE spell_id IN(71264, 71265, 71277, 72638, 72639, 72640, 71266, 72890, 72985, 71267, 71268, 72635, 72636, 72637, -71264, -71265, -71277, -72638, -72639, -72640, -71266, -72890, -72985, -71267, -71268, -72635, -72636, -72637);
DELETE FROM spell_scripts WHERE id IN(71264, 71265, 71277, 72638, 72639, 72640, 71266, 72890, 72985, 71267, 71268, 72635, 72636, 72637, -71264, -71265, -71277, -72638, -72639, -72640, -71266, -72890, -72985, -71267, -71268, -72635, -72636, -72637);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71264, 71265, 71277, 72638, 72639, 72640, 71266, 72890, 72985, 71267, 71268, 72635, 72636, 72637, -71264, -71265, -71277, -72638, -72639, -72640, -71266, -72890, -72985, -71267, -71268, -72635, -72636, -72637) OR spell_effect IN(71264, 71265, 71277, 72638, 72639, 72640, 71266, 72890, 72985, 71267, 71268, 72635, 72636, 72637, -71264, -71265, -71277, -72638, -72639, -72640, -71266, -72890, -72985, -71267, -71268, -72635, -72636, -72637);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(71264, 71265, 71277, 72638, 72639, 72640, 71266, 72890, 72985, 71267, 71268, 72635, 72636, 72637, -71264, -71265, -71277, -72638, -72639, -72640, -71266, -72890, -72985, -71267, -71268, -72635, -72636, -72637);
INSERT INTO spell_linked_spell VALUES(71265, 71277, 2, 'Blood Queen Lana\'thel - Swarming Shadows');
INSERT INTO spell_script_names VALUES(71268, 'spell_blood_queen_swarming_shadows_floor_dmg');
INSERT INTO spell_script_names VALUES(72635, 'spell_blood_queen_swarming_shadows_floor_dmg');
INSERT INTO spell_script_names VALUES(72636, 'spell_blood_queen_swarming_shadows_floor_dmg');
INSERT INTO spell_script_names VALUES(72637, 'spell_blood_queen_swarming_shadows_floor_dmg');

-- spell Twilight Bloodbolt (71445)
-- additional ids: effect (71446, 71478, 71479, 71480), effect for Bloodbolt (71818, 71819, 71820, 71821), splash (71447, 71481, 71482, 71483)
DELETE FROM spell_script_names WHERE spell_id IN(71445, 71446, 71478, 71479, 71480, 71818, 71819, 71820, 71821, 71447, 71481, 71482, 71483, -71445, -71446, -71478, -71479, -71480, -71818, -71819, -71820, -71821, -71447, -71481, -71482, -71483);
DELETE FROM spell_scripts WHERE id IN(71445, 71446, 71478, 71479, 71480, 71818, 71819, 71820, 71821, 71447, 71481, 71482, 71483, -71445, -71446, -71478, -71479, -71480, -71818, -71819, -71820, -71821, -71447, -71481, -71482, -71483);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71445, 71446, 71478, 71479, 71480, 71818, 71819, 71820, 71821, 71447, 71481, 71482, 71483, -71445, -71446, -71478, -71479, -71480, -71818, -71819, -71820, -71821, -71447, -71481, -71482, -71483) OR spell_effect IN(71445, 71446, 71478, 71479, 71480, 71818, 71819, 71820, 71821, 71447, 71481, 71482, 71483, -71445, -71446, -71478, -71479, -71480, -71818, -71819, -71820, -71821, -71447, -71481, -71482, -71483);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(71445, 71446, 71478, 71479, 71480, 71818, 71819, 71820, 71821, 71447, 71481, 71482, 71483, -71445, -71446, -71478, -71479, -71480, -71818, -71819, -71820, -71821, -71447, -71481, -71482, -71483);
INSERT INTO spell_linked_spell VALUES(71446, 71447, 1, 'Blood-Queen: Bloodbolt Splash');
INSERT INTO spell_linked_spell VALUES(71478, 71481, 1, 'Blood-Queen: Bloodbolt Splash');
INSERT INTO spell_linked_spell VALUES(71479, 71482, 1, 'Blood-Queen: Bloodbolt Splash');
INSERT INTO spell_linked_spell VALUES(71480, 71483, 1, 'Blood-Queen: Bloodbolt Splash');
INSERT INTO spell_linked_spell VALUES(71818, 71447, 1, 'Blood-Queen: Bloodbolt Splash');
INSERT INTO spell_linked_spell VALUES(71819, 71481, 1, 'Blood-Queen: Bloodbolt Splash');
INSERT INTO spell_linked_spell VALUES(71820, 71482, 1, 'Blood-Queen: Bloodbolt Splash');
INSERT INTO spell_linked_spell VALUES(71821, 71483, 1, 'Blood-Queen: Bloodbolt Splash');

-- spell Bloodbolt Whirl (71772)
-- additional ids: effect (71899, 71900, 71901, 71902)
DELETE FROM spell_script_names WHERE spell_id IN(71772, 71899, 71900, 71901, 71902, -71772, -71899, -71900, -71901, -71902);
DELETE FROM spell_scripts WHERE id IN(71772, 71899, 71900, 71901, 71902, -71772, -71899, -71900, -71901, -71902);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71772, 71899, 71900, 71901, 71902, -71772, -71899, -71900, -71901, -71902) OR spell_effect IN(71772, 71899, 71900, 71901, 71902, -71772, -71899, -71900, -71901, -71902);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(71772, 71899, 71900, 71901, 71902, -71772, -71899, -71900, -71901, -71902);
INSERT INTO spell_script_names VALUES(71899, 'spell_blood_queen_bloodbolt');
INSERT INTO spell_script_names VALUES(71900, 'spell_blood_queen_bloodbolt');
INSERT INTO spell_script_names VALUES(71901, 'spell_blood_queen_bloodbolt');
INSERT INTO spell_script_names VALUES(71902, 'spell_blood_queen_bloodbolt');

-- spell Vampiric Bite (71726, 71727, 71728, 71729)
-- additional ids: periodic trigger frenzied bloodthirst and +dmg (70867, 71473, 71532, 71533), cast by player on biting (70879, 71525, 71530, 71531)
DELETE FROM spell_script_names WHERE spell_id IN(71726, 71727, 71728, 71729, 70867, 71473, 71532, 71533, -71726, -71727, -71728, -71729, -70867, -71473, -71532, -71533, 70879, 71525, 71530, 71531, -70879, -71525, -71530, -71531);
DELETE FROM spell_scripts WHERE id IN(71726, 71727, 71728, 71729, 70867, 71473, 71532, 71533, -71726, -71727, -71728, -71729, -70867, -71473, -71532, -71533, 70879, 71525, 71530, 71531, -70879, -71525, -71530, -71531);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71726, 71727, 71728, 71729, 70867, 71473, 71532, 71533, -71726, -71727, -71728, -71729, -70867, -71473, -71532, -71533, 70879, 71525, 71530, 71531, -70879, -71525, -71530, -71531) OR spell_effect IN(71726, 71727, 71728, 71729, 70867, 71473, 71532, 71533, -71726, -71727, -71728, -71729, -70867, -71473, -71532, -71533, 70879, 71525, 71530, 71531, -70879, -71525, -71530, -71531);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(71726, 71727, 71728, 71729, 70867, 71473, 71532, 71533, -71726, -71727, -71728, -71729, -70867, -71473, -71532, -71533, 70879, 71525, 71530, 71531, -70879, -71525, -71530, -71531);
INSERT INTO spell_linked_spell VALUES(70867, 70871, 2, 'Blood-Queen: Essence of the Blood Queen'),(71473, 70871, 2, 'Blood-Queen: Essence of the Blood Queen'),(71532, 70871, 2, 'Blood-Queen: Essence of the Blood Queen'),(71533, 70871, 2, 'Blood-Queen: Essence of the Blood Queen');
INSERT INTO spell_linked_spell VALUES(-70867, -70871, 0, 'Blood-Queen: Essence of the Blood Queen'),(-71473, -70871, 0, 'Blood-Queen: Essence of the Blood Queen'),(-71532, -70871, 0, 'Blood-Queen: Essence of the Blood Queen'),(-71533, -70871, 0, 'Blood-Queen: Essence of the Blood Queen');
INSERT INTO spell_linked_spell VALUES(70879, 70871, 2, 'Blood-Queen: Essence of the Blood Queen'),(71525, 70871, 2, 'Blood-Queen: Essence of the Blood Queen'),(71530, 70871, 2, 'Blood-Queen: Essence of the Blood Queen'),(71531, 70871, 2, 'Blood-Queen: Essence of the Blood Queen');
INSERT INTO spell_linked_spell VALUES(-70879, -70871, 0, 'Blood-Queen: Essence of the Blood Queen'),(-71525, -70871, 0, 'Blood-Queen: Essence of the Blood Queen'),(-71530, -70871, 0, 'Blood-Queen: Essence of the Blood Queen'),(-71531, -70871, 0, 'Blood-Queen: Essence of the Blood Queen');

-- spell Presence of the Darkfallen (70995)
-- additional ids: dummy (70994, 71962, 71963, 71964), script effect (71952)
DELETE FROM spell_script_names WHERE spell_id IN(70995, 70994, 71952, -70995, -70994, -71952, 71962, 71963, 71964, -71962, -71963, -71964);
DELETE FROM spell_scripts WHERE id IN(70995, 70994, 71952, -70995, -70994, -71952, 71962, 71963, 71964, -71962, -71963, -71964);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70995, 70994, 71952, -70995, -70994, -71952, 71962, 71963, 71964, -71962, -71963, -71964) OR spell_effect IN(70995, 70994, 71952, -70995, -70994, -71952, 71962, 71963, 71964, -71962, -71963, -71964);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70995, 70994, 71952, -70995, -70994, -71952, 71962, 71963, 71964, -71962, -71963, -71964);
INSERT INTO `conditions` VALUES (13, 1, 71952, 0, 0, 31, 0, 3, 37955, 0, 0, 0, 0, '', 'Blood Queen Lana\'thel - Presence of the Darkfallen');
INSERT INTO `conditions` VALUES (13, 1, 70995, 0, 0, 31, 0, 3, 37955, 0, 0, 0, 0, '', 'Blood Queen Lana\'thel - Presence of the Darkfallen');
INSERT INTO spell_script_names VALUES(71963, 'spell_blood_queen_presence_of_the_darkfallen');
INSERT INTO spell_script_names VALUES(71964, 'spell_blood_queen_presence_of_the_darkfallen');

-- spell Frenzied Bloodthirst (70877, 71474)
-- additional ids: linked visual (72151, 72648), linked pacify & silence (72649, 72650)
DELETE FROM spell_script_names WHERE spell_id IN(70877, 71474, -70877, -71474, 72151, 72648, 72649, 72650, -72151, -72648, -72649, -72650);
DELETE FROM spell_scripts WHERE id IN(70877, 71474, -70877, -71474, 72151, 72648, 72649, 72650, -72151, -72648, -72649, -72650);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70877, 71474, -70877, -71474, 72151, 72648, 72649, 72650, -72151, -72648, -72649, -72650) OR spell_effect IN(70877, 71474, -70877, -71474, 72151, 72648, 72649, 72650, -72151, -72648, -72649, -72650);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70877, 71474, -70877, -71474, 72151, 72648, 72649, 72650, -72151, -72648, -72649, -72650);
INSERT INTO spell_linked_spell VALUES(70877, 72151, 2, 'Blood-Queen: Frenzied Bloodthirst 10man');
INSERT INTO spell_linked_spell VALUES(70877, 72649, 2, 'Blood-Queen: Frenzied Bloodthirst 10man');
INSERT INTO spell_linked_spell VALUES(-70877, -72151, 0, 'Blood-Queen: Frenzied Bloodthirst 10man');
INSERT INTO spell_linked_spell VALUES(-70877, -72649, 0, 'Blood-Queen: Frenzied Bloodthirst 10man');
INSERT INTO spell_linked_spell VALUES(71474, 72648, 2, 'Blood-Queen: Frenzied Bloodthirst 25man');
INSERT INTO spell_linked_spell VALUES(71474, 72650, 2, 'Blood-Queen: Frenzied Bloodthirst 25man');
INSERT INTO spell_linked_spell VALUES(-71474, -72648, 0, 'Blood-Queen: Frenzied Bloodthirst 25man');
INSERT INTO spell_linked_spell VALUES(-71474, -72650, 0, 'Blood-Queen: Frenzied Bloodthirst 25man');
INSERT INTO spell_script_names VALUES(70877, 'spell_blood_queen_frenzied_bloodthirst');
INSERT INTO spell_script_names VALUES(71474, 'spell_blood_queen_frenzied_bloodthirst');

-- spell Essence of the Blood Queen (70871)
DELETE FROM spell_script_names WHERE spell_id IN(70871, -70871);
DELETE FROM spell_scripts WHERE id IN(70871, -70871);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70871, -70871);
INSERT INTO spell_script_names VALUES(70871, 'spell_blood_queen_essence_of_the_blood_queen');
REPLACE INTO spell_proc_event VALUES(70871, 0, 0, 0, 0, 0, 69972, 3, 0, 100, 0);

-- spell Uncontrollable Frenzy (70923)
-- additional ids: linked aura with more effects (70924, 73015)
DELETE FROM spell_script_names WHERE spell_id IN(70923, 70924, 73015, -70923, -70924, -73015);
DELETE FROM spell_scripts WHERE id IN(70923, 70924, 73015, -70923, -70924, -73015);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70923, 70924, 73015, -70923, -70924, -73015) OR spell_effect IN(70923, 70924, 73015, -70923, -70924, -73015);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70923, 70924, 73015, -70923, -70924, -73015);
INSERT INTO spell_linked_spell VALUES(70923, 70924, 1, 'Blood-Queen: Uncontrollable Frenzy damage buff');
INSERT INTO spell_linked_spell VALUES(-70923, -73015, 0, 'Blood-Queen: Uncontrollable Frenzy remove 25man');
INSERT INTO spell_linked_spell VALUES(-70923, -70924, 0, 'Blood-Queen: Uncontrollable Frenzy remove 10man');

-- Vampiric Bite (70946, 71475, 71476, 71477) -- player ability
-- additional ids: triggered, also triggered by lana'thel charge (70867)
DELETE FROM spell_script_names WHERE spell_id IN(70946, 71475, 71476, 71477, -70946, -71475, -71476, -71477);
DELETE FROM spell_scripts WHERE id IN(70946, 71475, 71476, 71477, -70946, -71475, -71476, -71477);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70946, 71475, 71476, 71477, -70946, -71475, -71476, -71477) OR spell_effect IN(70946, 71475, 71476, 71477, -70946, -71475, -71476, -71477);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70946, 71475, 71476, 71477, -70946, -71475, -71476, -71477);
INSERT INTO spell_script_names VALUES(70946, 'spell_blood_queen_vampiric_bite');
INSERT INTO spell_script_names VALUES(71475, 'spell_blood_queen_vampiric_bite');
INSERT INTO spell_script_names VALUES(71476, 'spell_blood_queen_vampiric_bite');
INSERT INTO spell_script_names VALUES(71477, 'spell_blood_queen_vampiric_bite');



-- ###################
-- ### VALITHRIA DREAMWALKER
-- ###################

-- Valithria Dreamwalker (36789, 38174)
UPDATE creature_template SET faction=1665, speed_walk=1, speed_run=1.14286, unit_flags=536870912, dynamicflags=8, Health_mod=860.524, flags_extra=1+0x200000, AIName='', ScriptName='boss_valithria_dreamwalker', mechanic_immune_mask=650854271 WHERE entry=36789;
UPDATE creature_template SET faction=1665, speed_walk=1, speed_run=1.14286, unit_flags=536870912, dynamicflags=8, Health_mod=2581.57, flags_extra=1+0x200000, AIName='', ScriptName='', mechanic_immune_mask=650854271 WHERE entry=38174;
REPLACE INTO creature_template_addon VALUES(36789, 0, 0, 0, 1, 0, '72724 70904'),(38174, 0, 0, 0, 1, 0, '72724 70904');
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36789, 38174) AND `map`=631 );
UPDATE creature SET spawntimesecs=604800 WHERE id IN(36789, 38174);

-- The Lich King (38153)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38153) );
DELETE FROM creature_template_addon WHERE entry IN(38153);
DELETE FROM creature WHERE id IN(38153);
UPDATE creature_template SET difficulty_entry_1=0, modelid1=11686, modelid2=0, modelid3=0, modelid4=0, faction=114, unit_flags=33555200, AIName="", flags_extra=2+0x200000, ScriptName="npc_the_lich_king_controller" WHERE entry=38153;
INSERT INTO `creature` VALUES (247117, 38153, 631, 15, 17, 0, 0, 4203.7, 2484.83, 364.956, 3.14159, 604800, 0, 0, 0, 0, 0, 0, 0, 0);
REPLACE INTO creature_text VALUES(38153, 0, 0, 'Intruders have breached the inner sanctum. Hasten the destruction of the green dragon! Leave only bones and sinew for the reanimation!', 14, 0, 100, 0, 0, 17251, 0, 'Lich King for Valithria Dreamwalker - AGGRO');
UPDATE creature SET spawntimesecs=604800 WHERE id IN(38153);

-- Green Dragon Combat Trigger (38752)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38752) );
DELETE FROM creature_template_addon WHERE entry IN(38752);
DELETE FROM creature WHERE id IN(38752);
UPDATE creature_template SET difficulty_entry_1=0, modelid1=11686, modelid2=0, modelid3=0, modelid4=0, faction=14, unit_flags=33554432, AIName="", flags_extra=129+0x200000, ScriptName="npc_green_dragon_combat_trigger" WHERE entry=38752;
INSERT INTO `creature` VALUES (247118, 38752, 631, 15, 17, 0, 0, 4203.89, 2484.23, 364.956, 0, 604800, 0, 0, 0, 0, 0, 0, 0, 0);
UPDATE creature SET spawntimesecs=604800 WHERE id IN(38752);
DELETE FROM linked_respawn WHERE linkedGuid=137752;

-- Valithria Dreamwalker (37950) -- flying, hidden npc
UPDATE creature_template SET difficulty_entry_1=0, faction=1665, unit_flags=33554432, AIName="", InhabitType=4, flags_extra=128+0x200000, ScriptName="" WHERE entry=37950;
REPLACE INTO creature_template_addon VALUES(37950, 0, 0, 50331648, 1, 0, '');
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37950) AND `map`=631 );
DELETE FROM creature WHERE id IN(37950) AND `map`=631;
INSERT INTO `creature` VALUES (247119, 37950, 631, 15, 20, 0, 0, 4202.85, 2484.92, 383.837, 0, 604800, 0, 0, 0, 0, 0, 0, 0, 0);

-- Risen Archmage (37868, 38167, 38725, 38735)
UPDATE creature_template SET minlevel=83, maxlevel=83, faction=16, speed_walk=1, speed_run=1.14286, mindmg=1710, maxdmg=2337, attackpower=300, dmg_multiplier=8, unit_flags=0, AIName='', ScriptName='npc_risen_archmage', mechanic_immune_mask=550189887, flags_extra=0 WHERE entry=37868;
UPDATE creature_template SET minlevel=83, maxlevel=83, faction=16, speed_walk=1, speed_run=1.14286, mindmg=1379, maxdmg=1884, attackpower=300, dmg_multiplier=14, unit_flags=0, AIName='', ScriptName='', mechanic_immune_mask=550189887, flags_extra=0 WHERE entry=38167;
UPDATE creature_template SET minlevel=83, maxlevel=83, faction=16, speed_walk=1, speed_run=1.14286, mindmg=2562, maxdmg=3500, attackpower=300, dmg_multiplier=8, unit_flags=0, AIName='', ScriptName='', mechanic_immune_mask=550189887, flags_extra=0 WHERE entry=38725;
UPDATE creature_template SET minlevel=83, maxlevel=83, faction=16, speed_walk=1, speed_run=1.14286, mindmg=1842, maxdmg=2517, attackpower=300, dmg_multiplier=14, unit_flags=0, AIName='', ScriptName='', mechanic_immune_mask=550189887, flags_extra=0 WHERE entry=38735;
DELETE FROM creature_template_addon WHERE entry IN(37868, 38167, 38725, 38735);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37868, 38167, 38725, 38735) AND `map`=631 );
DELETE FROM creature WHERE id IN(37868, 38167, 38725, 38735) AND `map`=631;
INSERT INTO `creature` VALUES (247121, 37868, 631, 5, 1, 0, 0, 4230.53, 2490.22, 364.957, 3.36849, 604800, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247122, 37868, 631, 5, 1, 0, 0, 4230.44, 2478.56, 364.953, 2.93215, 604800, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247123, 37868, 631, 15, 1, 0, 0, 4223.4, 2465.11, 364.952, 2.3911, 604800, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247124, 37868, 631, 15, 1, 0, 0, 4222.86, 2504.58, 364.96, 3.90954, 604800, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247125, 37868, 631, 10, 1, 0, 0, 4182.16, 2466.71, 364.90, 0.7, 604800, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (247126, 37868, 631, 10, 1, 0, 0, 4184.17, 2504.24, 364.9, 5.51, 604800, 0, 0, 0, 0, 0, 0, 0, 0);

-- Gluttonous Abomination (37886, 38166, 38724, 38734)
UPDATE creature_template SET minlevel=83, maxlevel=83, faction=16, speed_walk=1, speed_run=1.14286, mindmg=4342, maxdmg=5920, attackpower=300, dmg_multiplier=6, unit_flags=0, AIName='', ScriptName='npc_gluttonous_abomination', mechanic_immune_mask=550189887, flags_extra=0 WHERE entry=37886;
UPDATE creature_template SET minlevel=83, maxlevel=83, faction=16, speed_walk=1, speed_run=1.14286, mindmg=3507, maxdmg=4781, attackpower=300, dmg_multiplier=11, unit_flags=0, AIName='', ScriptName='', mechanic_immune_mask=550189887, flags_extra=0 WHERE entry=38166;
UPDATE creature_template SET minlevel=83, maxlevel=83, faction=16, speed_walk=1, speed_run=1.14286, mindmg=6513, maxdmg=8880, attackpower=300, dmg_multiplier=6, unit_flags=0, AIName='', ScriptName='', mechanic_immune_mask=550189887, flags_extra=0 WHERE entry=38724;
UPDATE creature_template SET minlevel=83, maxlevel=83, faction=16, speed_walk=1, speed_run=1.14286, mindmg=4676, maxdmg=6375, attackpower=300, dmg_multiplier=11, unit_flags=0, AIName='', ScriptName='', mechanic_immune_mask=550189887, flags_extra=0 WHERE entry=38734;
DELETE FROM creature_template_addon WHERE entry IN(37886, 38166, 38724, 38734);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37886, 38166, 38724, 38734) AND `map`=631 );
DELETE FROM creature WHERE id IN(37886, 38166, 38724, 38734) AND `map`=631;

-- Blazing Skeleton (36791, 38169, 38721, 38722)
UPDATE creature_template SET difficulty_entry_2=38721, difficulty_entry_3=38722, minlevel=83, maxlevel=83, faction=16, speed_walk=1, speed_run=1.14286, mindmg=4342, maxdmg=5920, attackpower=300, dmg_multiplier=4, unit_flags=0, AIName='', ScriptName='npc_blazing_skeleton', mechanic_immune_mask=550189887, flags_extra=0 WHERE entry=36791;
UPDATE creature_template SET minlevel=83, maxlevel=83, faction=16, speed_walk=1, speed_run=1.14286, mindmg=3507, maxdmg=4781, attackpower=300, dmg_multiplier=7, unit_flags=0, AIName='', ScriptName='', mechanic_immune_mask=550189887, flags_extra=0 WHERE entry=38169;
UPDATE creature_template SET minlevel=83, maxlevel=83, faction=16, speed_walk=1, speed_run=1.14286, mindmg=6513, maxdmg=8880, attackpower=300, dmg_multiplier=4, unit_flags=0, AIName='', ScriptName='', mechanic_immune_mask=550189887, flags_extra=0 WHERE entry=38721;
UPDATE creature_template SET minlevel=83, maxlevel=83, faction=16, speed_walk=1, speed_run=1.14286, mindmg=4676, maxdmg=6375, attackpower=300, dmg_multiplier=7, unit_flags=0, AIName='', ScriptName='', mechanic_immune_mask=550189887, flags_extra=0 WHERE entry=38722;
DELETE FROM creature_template_addon WHERE entry IN(36791, 38169, 38722, 38721);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36791, 38169, 38722, 38721) AND `map`=631 );
DELETE FROM creature WHERE id IN(36791, 38169, 38722, 38721) AND `map`=631;

-- Blistering Zombie (37934, 38170, 38723, 38733)
UPDATE creature_template SET minlevel=83, maxlevel=83, faction=16, speed_walk=1, speed_run=0.714286, mindmg=4342, maxdmg=5920, attackpower=300, dmg_multiplier=4, unit_flags=0, AIName='', ScriptName='npc_blistering_zombie', mechanic_immune_mask=550189887, flags_extra=0 WHERE entry=37934;
UPDATE creature_template SET minlevel=83, maxlevel=83, faction=16, speed_walk=1, speed_run=0.714286, mindmg=3507, maxdmg=4781, attackpower=300, dmg_multiplier=7, unit_flags=0, AIName='', ScriptName='', mechanic_immune_mask=550189887, flags_extra=0 WHERE entry=38170;
UPDATE creature_template SET minlevel=83, maxlevel=83, faction=16, speed_walk=1, speed_run=1.14286, mindmg=6513, maxdmg=8880, attackpower=300, dmg_multiplier=4, unit_flags=0, AIName='', ScriptName='', mechanic_immune_mask=550189887, flags_extra=0 WHERE entry=38723;
UPDATE creature_template SET minlevel=83, maxlevel=83, faction=16, speed_walk=1, speed_run=1.14286, mindmg=4676, maxdmg=6375, attackpower=300, dmg_multiplier=7, unit_flags=0, AIName='', ScriptName='', mechanic_immune_mask=550189887, flags_extra=0 WHERE entry=38733;
DELETE FROM creature_template_addon WHERE entry IN(37934, 38170, 38723, 38733);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37934, 38170, 38723, 38733) AND `map`=631 );
DELETE FROM creature WHERE id IN(37934, 38170, 38723, 38733) AND `map`=631;

-- Suppresser (37863, 38171, 38727, 38737)
UPDATE creature_template SET minlevel=83, maxlevel=83, faction=16, speed_walk=1, speed_run=0.992063, mindmg=4342, maxdmg=5920, attackpower=300, dmg_multiplier=1, unit_flags=0, AIName='', ScriptName='npc_suppresser', mechanic_immune_mask=550189855, flags_extra=0 WHERE entry=37863;
UPDATE creature_template SET minlevel=83, maxlevel=83, faction=16, speed_walk=1, speed_run=0.992063, mindmg=3507, maxdmg=4781, attackpower=300, dmg_multiplier=2, unit_flags=0, AIName='', ScriptName='', mechanic_immune_mask=550189855, flags_extra=0 WHERE entry=38171;
UPDATE creature_template SET minlevel=83, maxlevel=83, faction=16, speed_walk=1, speed_run=0.992063, mindmg=6513, maxdmg=8880, attackpower=300, dmg_multiplier=1, unit_flags=0, AIName='', ScriptName='', mechanic_immune_mask=550189855, flags_extra=0 WHERE entry=38727;
UPDATE creature_template SET minlevel=83, maxlevel=83, faction=16, speed_walk=1, speed_run=0.992063, mindmg=4676, maxdmg=6375, attackpower=300, dmg_multiplier=2, unit_flags=0, AIName='', ScriptName='', mechanic_immune_mask=550189855, flags_extra=0 WHERE entry=38737;
DELETE FROM creature_template_addon WHERE entry IN(37863, 38171, 38727, 38737);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37863, 38171, 38727, 38737) AND `map`=631 );
DELETE FROM creature WHERE id IN(37863, 38171, 38727, 38737) AND `map`=631;

-- Rot Worm (37907, 38168, 38726, 38736)
UPDATE creature_template SET minlevel=83, maxlevel=83, faction=16, speed_walk=1, speed_run=1.14286, mindmg=500, maxdmg=700, attackpower=0, dmg_multiplier=1, unit_flags=0, AIName='', ScriptName='', flags_extra=0 WHERE entry=37907;
UPDATE creature_template SET minlevel=83, maxlevel=83, faction=16, speed_walk=1, speed_run=1.14286, mindmg=500, maxdmg=700, attackpower=0, dmg_multiplier=2, unit_flags=0, AIName='', ScriptName='', flags_extra=0 WHERE entry=38168;
UPDATE creature_template SET minlevel=83, maxlevel=83, faction=16, speed_walk=1, speed_run=1.14286, mindmg=500, maxdmg=700, attackpower=0, dmg_multiplier=1.5, unit_flags=0, AIName='', ScriptName='', flags_extra=0 WHERE entry=38726;
UPDATE creature_template SET minlevel=83, maxlevel=83, faction=16, speed_walk=1, speed_run=1.14286, mindmg=500, maxdmg=700, attackpower=0, dmg_multiplier=3, unit_flags=0, AIName='', ScriptName='', flags_extra=0 WHERE entry=38736;
REPLACE INTO creature_template_addon VALUES(37907, 0, 0, 0, 1, 0, '72962'),(38168, 0, 0, 0, 1, 0, '72962'),(38726, 0, 0, 0, 1, 0, '72962'),(38736, 0, 0, 0, 1, 0, '72962');
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37907, 38168, 38726, 38736) AND `map`=631 );
DELETE FROM creature WHERE id IN(37907, 38168, 38726, 38736) AND `map`=631;

-- Dream Portal (Pre-effect) (38186)
UPDATE creature_template SET difficulty_entry_1=0, modelid1=30844, modelid2=0, modelid3=0, modelid4=0, IconName='', minlevel=80, maxlevel=80, faction=35, npcflag=0, unit_flags=33554432, AIName='NullCreatureAI', flags_extra=0 WHERE entry=38186;
REPLACE INTO creature_template_addon VALUES(38186, 0, 0, 0, 1, 0, '71304');
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38186) AND `map`=631 );
DELETE FROM creature WHERE id IN(38186) AND `map`=631;
DELETE FROM npc_spellclick_spells WHERE npc_entry=38186;

-- Nightmare Portal (Pre-effect) (38429)
UPDATE creature_template SET difficulty_entry_1=0, modelid1=30844, modelid2=0, modelid3=0, modelid4=0, IconName='', minlevel=80, maxlevel=80, faction=35, npcflag=0, unit_flags=33554432, AIName='NullCreatureAI', flags_extra=0 WHERE entry=38429;
REPLACE INTO creature_template_addon VALUES(38429, 0, 0, 0, 1, 0, '71986');
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38429) AND `map`=631 );
DELETE FROM creature WHERE id IN(38429) AND `map`=631;
DELETE FROM npc_spellclick_spells WHERE npc_entry=38429;

-- Dream Portal (37945)
UPDATE creature_template SET difficulty_entry_1=0, modelid1=30844, modelid2=0, modelid3=0, modelid4=0, IconName='vehichleCursor', minlevel=80, maxlevel=80, faction=35, npcflag=16777216, unit_flags=0, AIName='', ScriptName='npc_valithria_portal', flags_extra=0 WHERE entry=37945;
REPLACE INTO creature_template_addon VALUES(37945, 0, 0, 0, 1, 0, '70763');
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37945) AND `map`=631 );
DELETE FROM creature WHERE id IN(37945) AND `map`=631;
DELETE FROM npc_spellclick_spells WHERE npc_entry=37945;
INSERT INTO npc_spellclick_spells VALUES(37945, 70766, 3, 0);

-- Nightmare Portal (38430)
UPDATE creature_template SET difficulty_entry_1=0, modelid1=30844, modelid2=0, modelid3=0, modelid4=0, IconName='vehichleCursor', minlevel=80, maxlevel=80, faction=35, npcflag=16777216, unit_flags=0, AIName='', ScriptName='npc_valithria_portal', flags_extra=0 WHERE entry=38430;
REPLACE INTO creature_template_addon VALUES(38430, 0, 0, 0, 1, 0, '71994');
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38430) AND `map`=631 );
DELETE FROM creature WHERE id IN(38430) AND `map`=631;
DELETE FROM npc_spellclick_spells WHERE npc_entry=38430;
INSERT INTO npc_spellclick_spells VALUES(38430, 70766, 3, 0);

-- Dream Cloud (37985)
UPDATE creature_template SET difficulty_entry_1=0, modelid1=30877, modelid2=0, modelid3=0, modelid4=0, minlevel=80, maxlevel=80, faction=2022, speed_walk=1, speed_run=0.5, unit_flags=33554432, InhabitType=4, AIName='', ScriptName='npc_valithria_cloud', flags_extra=0 WHERE entry=37985;
REPLACE INTO creature_template_addon VALUES(37985, 0, 0, 50331648, 1, 0, '70876');
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37985) AND `map`=631 );
DELETE FROM creature WHERE id IN(37985) AND `map`=631;
INSERT INTO `creature` VALUES (NULL, 37985, 631, 3, 16, 0, 0, 4202.23, 2508, 383.985, 2.09137, 10, 10, 0, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37985, 631, 3, 16, 0, 0, 4200.96, 2456, 387.128, 3.58291, 10, 10, 0, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37985, 631, 3, 16, 0, 0, 4186.72, 2450.97, 388.373, 4.95968, 10, 10, 0, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37985, 631, 3, 16, 0, 0, 4181.62, 2514.91, 386.374, 2.65209, 10, 10, 0, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37985, 631, 3, 16, 0, 0, 4173.67, 2504.13, 386.174, 2.67313, 10, 10, 0, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37985, 631, 3, 16, 0, 0, 4172.57, 2464.47, 385.368, 3.72021, 10, 10, 0, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37985, 631, 3, 16, 0, 0, 4158.75, 2494.08, 384.334, 2.31129, 10, 10, 0, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37985, 631, 3, 16, 0, 0, 4155.51, 2478.76, 382.494, 4.97053, 10, 10, 0, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37985, 631, 3, 16, 0, 0, 4220.35, 2515.16, 388.649, 2.34469, 10, 10, 0, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37985, 631, 3, 16, 0, 0, 4222.26, 2455.2, 385.568, 0, 10, 10, 0, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37985, 631, 3, 16, 0, 0, 4231.61, 2464.44, 389.011, 0, 10, 10, 0, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37985, 631, 3, 16, 0, 0, 4236.75, 2500.62, 383.373, 5.97527, 10, 10, 0, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37985, 631, 3, 16, 0, 0, 4243.29, 2476.89, 386.076, 0, 10, 10, 0, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37985, 631, 3, 16, 0, 0, 4244.83, 2493.18, 387.677, 4.29139, 10, 10, 0, 0, 0, 1, 0, 0, 0);

-- Nightmare Cloud (38421)
UPDATE creature_template SET difficulty_entry_1=0, modelid1=31088, modelid2=0, modelid3=0, modelid4=0, minlevel=80, maxlevel=80, faction=2022, speed_walk=1, speed_run=0.5, unit_flags=33554432, InhabitType=4, AIName='', ScriptName='npc_valithria_cloud', flags_extra=0 WHERE entry=38421;
REPLACE INTO creature_template_addon VALUES(38421, 0, 0, 50331648, 1, 0, '71939 71970');
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38421) AND `map`=631 );
DELETE FROM creature WHERE id IN(38421) AND `map`=631;
INSERT INTO `creature` VALUES (NULL, 38421, 631, 12, 20, 0, 0, 4155.51, 2478.76, 382.494, 4.97053, 25, 10, 0, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38421, 631, 12, 20, 0, 0, 4158.75, 2494.08, 384.334, 2.31129, 25, 10, 0, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38421, 631, 12, 20, 0, 0, 4172.57, 2464.47, 385.368, 3.72021, 25, 10, 0, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38421, 631, 12, 20, 0, 0, 4181.62, 2514.91, 386.374, 2.65209, 25, 10, 0, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38421, 631, 12, 20, 0, 0, 4200.96, 2456, 387.128, 3.58291, 25, 10, 0, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38421, 631, 12, 20, 0, 0, 4202.23, 2508, 383.985, 2.09137, 25, 10, 0, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38421, 631, 12, 20, 0, 0, 4220.35, 2515.16, 388.649, 2.34469, 25, 10, 0, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38421, 631, 12, 20, 0, 0, 4222.26, 2455.2, 385.568, 0, 25, 10, 0, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38421, 631, 12, 20, 0, 0, 4236.75, 2500.62, 383.373, 5.97527, 25, 10, 0, 0, 0, 1, 0, 0, 0);

-- Mana Void (38068)
UPDATE creature_template SET difficulty_entry_1=0, modelid1=11686, modelid2=0, modelid3=0, modelid4=0, IconName='', minlevel=82, maxlevel=82, faction=14, unit_flags=33554432, AIName='NullCreatureAI', flags_extra=0 WHERE entry=38068;
REPLACE INTO creature_template_addon VALUES(38068, 0, 0, 0, 1, 0, '71085');
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38068) AND `map`=631 );
DELETE FROM creature WHERE id IN(38068) AND `map`=631;

-- Column of Frost (37918)
UPDATE creature_template SET difficulty_entry_1=0, modelid1=11686, modelid2=0, modelid3=0, modelid4=0, IconName='', minlevel=82, maxlevel=82, faction=14, unit_flags=33554432, AIName='NullCreatureAI', flags_extra=0 WHERE entry=37918;
REPLACE INTO creature_template_addon VALUES(37918, 0, 0, 0, 1, 0, '70715');
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37918) AND `map`=631 );
DELETE FROM creature WHERE id IN(37918) AND `map`=631;

-- World Trigger (22515)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(22515) AND `map`=631 AND position_x>4000 AND position_x<4300 AND position_y>2400 AND position_y<2600 AND position_z>350 );
DELETE FROM creature WHERE id IN(22515) AND `map`=631 AND position_x>4000 AND position_x<4300 AND position_y>2400 AND position_y<2600 AND position_z>350;
INSERT INTO `creature` VALUES (NULL, 22515, 631, 10, 1, 0, 0, 4166.17, 2411.52, 364.952, 0, 120, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 22515, 631, 15, 1, 0, 0, 4241.34, 2411.52, 364.952, 0, 120, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 22515, 631, 10, 1, 0, 0, 4166.02, 2557.49, 364.952, 0, 120, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 22515, 631, 15, 1, 0, 0, 4241.19, 2557.49, 364.952, 0, 120, 0, 0, 0, 0, 0, 0, 0, 0);

-- spell Achievement Check (72706)
DELETE FROM spell_script_names WHERE spell_id IN(72706, -72706);
DELETE FROM spell_scripts WHERE id IN(72706, -72706);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(72706, -72706) OR spell_effect IN(72706, -72706);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(72706, -72706);
INSERT INTO `conditions` VALUES (13, 1, 72706, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Valithria Dreamwalker - Achievement Check');

-- spell Dreamwalker's Rage (71189)
DELETE FROM spell_script_names WHERE spell_id IN(71189, -71189);
DELETE FROM spell_scripts WHERE id IN(71189, -71189);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71189, -71189) OR spell_effect IN(71189, -71189);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(71189, -71189);
INSERT INTO `conditions` VALUES (13, 1, 71189, 0, 2, 31, 0, 3, 37868, 0, 0, 0, 0, '', 'Dreamwalker\'s Rage - target Risen Archmage');
INSERT INTO `conditions` VALUES (13, 1, 71189, 0, 0, 31, 0, 3, 36791, 0, 0, 0, 0, '', 'Dreamwalker\'s Rage - target Blazing Skeleton');
INSERT INTO `conditions` VALUES (13, 1, 71189, 0, 1, 31, 0, 3, 37863, 0, 0, 0, 0, '', 'Dreamwalker\'s Rage - target Suppresser');
INSERT INTO `conditions` VALUES (13, 1, 71189, 0, 5, 31, 0, 3, 37934, 0, 0, 0, 0, '', 'Dreamwalker\'s Rage - target Blistering Zombie');
INSERT INTO `conditions` VALUES (13, 1, 71189, 0, 3, 31, 0, 3, 37886, 0, 0, 0, 0, '', 'Dreamwalker\'s Rage - target Gluttonous Abomination');
INSERT INTO `conditions` VALUES (13, 1, 71189, 0, 7, 31, 0, 3, 38186, 0, 0, 0, 0, '', 'Dreamwalker\'s Rage - target Dream Portal (Pre-effect)');
INSERT INTO `conditions` VALUES (13, 1, 71189, 0, 6, 31, 0, 3, 37945, 0, 0, 0, 0, '', 'Dreamwalker\'s Rage - target Dream Portal');
INSERT INTO `conditions` VALUES (13, 1, 71189, 0, 8, 31, 0, 3, 38429, 0, 0, 0, 0, '', 'Dreamwalker\'s Rage - target Nightmare Portal (Pre-effect)');
INSERT INTO `conditions` VALUES (13, 1, 71189, 0, 9, 31, 0, 3, 38430, 0, 0, 0, 0, '', 'Dreamwalker\'s Rage - target Nightmare Portal');
INSERT INTO `conditions` VALUES (13, 1, 71189, 0, 4, 31, 0, 3, 37907, 0, 0, 0, 0, '', 'Dreamwalker\'s Rage - target Rot Worm');

-- spell Award Reputation - Boss Kill (73843)
DELETE FROM spell_script_names WHERE spell_id IN(73843, -73843);
DELETE FROM spell_scripts WHERE id IN(73843, -73843);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(73843, -73843) OR spell_effect IN(73843, -73843);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(73843, -73843);
INSERT INTO `conditions` VALUES (13, 1, 73843, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Valithria Dreamwalker - Award Reputation');

-- spell Dream Portal Visual (71304), Nightmare Portal Visual (71986), Summon Dream Portal (71305), Summon Nightmare Portal (71987)
DELETE FROM spell_script_names WHERE spell_id IN(71304, 71986, 71305, 71987, -71304, -71986, -71305, -71987);
DELETE FROM spell_scripts WHERE id IN(71304, 71986, 71305, 71987, -71304, -71986, -71305, -71987);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71304, 71986, 71305, 71987, -71304, -71986, -71305, -71987) OR spell_effect IN(71304, 71986, 71305, 71987, -71304, -71986, -71305, -71987);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(71304, 71986, 71305, 71987, -71304, -71986, -71305, -71987);

-- spell Summon Dream Portal (72224), spell Summon Nightmare Portal (72480) -- Valithria summon spell
DELETE FROM spell_script_names WHERE spell_id IN(72224, 72480, -72224, -72480);
DELETE FROM spell_scripts WHERE id IN(72224, 72480, -72224, -72480);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(72224, 72480, -72224, -72480) OR spell_effect IN(72224, 72480, -72224, -72480);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(72224, 72480, -72224, -72480);
INSERT INTO spell_script_names VALUES(72224, 'spell_dreamwalker_summon_portal');
INSERT INTO spell_script_names VALUES(72480, 'spell_dreamwalker_summon_portal');

-- spell Summon Dream Portal (71301, 72220, 72223, 72225), Summon Nightmare Portal (71977, 72481, 72482, 72483) -- effect of valithria's spell
DELETE FROM spell_script_names WHERE spell_id IN(71301, 72220, 72223, 72225, 71977, 72481, 72482, 72483, -71301, -72220, -72223, -72225, -71977, -72481, -72482, -72483);
DELETE FROM spell_scripts WHERE id IN(71301, 72220, 72223, 72225, 71977, 72481, 72482, 72483, -71301, -72220, -72223, -72225, -71977, -72481, -72482, -72483);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71301, 72220, 72223, 72225, 71977, 72481, 72482, 72483, -71301, -72220, -72223, -72225, -71977, -72481, -72482, -72483) OR spell_effect IN(71301, 72220, 72223, 72225, 71977, 72481, 72482, 72483, -71301, -72220, -72223, -72225, -71977, -72481, -72482, -72483);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(71301, 72220, 72223, 72225, 71977, 72481, 72482, 72483, -71301, -72220, -72223, -72225, -71977, -72481, -72482, -72483);

-- spell Dream State (70766)
DELETE FROM spell_script_names WHERE spell_id IN(70766, -70766);
DELETE FROM spell_scripts WHERE id IN(70766, -70766);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70766, -70766) OR spell_effect IN(70766, -70766);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70766, -70766);

-- spell Nightmare Cloud (71939), Dream Cloud (70876) -- visuals
-- additional ids: periodic trigger damage (71970), damage (71946, 72031, 72032, 72033)
DELETE FROM spell_script_names WHERE spell_id IN(71939, 70876, 71970, 71946, 72031, 72032, 72033, -71939, -70876, -71970, -71946, -72031, -72032, -72033);
DELETE FROM spell_scripts WHERE id IN(71939, 70876, 71970, 71946, 72031, 72032, 72033, -71939, -70876, -71970, -71946, -72031, -72032, -72033);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71939, 70876, 71970, 71946, 72031, 72032, 72033, -71939, -70876, -71970, -71946, -72031, -72032, -72033) OR spell_effect IN(71939, 70876, 71970, 71946, 72031, 72032, 72033, -71939, -70876, -71970, -71946, -72031, -72032, -72033);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(71939, 70876, 71970, 71946, 72031, 72032, 72033, -71939, -70876, -71970, -71946, -72031, -72032, -72033);
INSERT INTO `conditions` VALUES (13, 1, 71946, 0, 0, 31, 0, 3, 36789, 0, 0, 0, 0, '', 'Valithria Dreamwalker - Nightmare Cloud');
INSERT INTO `conditions` VALUES (13, 1, 72031, 0, 0, 31, 0, 3, 36789, 0, 0, 0, 0, '', 'Valithria Dreamwalker - Nightmare Cloud');
INSERT INTO `conditions` VALUES (13, 1, 72032, 0, 0, 31, 0, 3, 36789, 0, 0, 0, 0, '', 'Valithria Dreamwalker - Nightmare Cloud');
INSERT INTO `conditions` VALUES (13, 1, 72033, 0, 0, 31, 0, 3, 36789, 0, 0, 0, 0, '', 'Valithria Dreamwalker - Nightmare Cloud');
INSERT INTO spell_script_names VALUES(71970, 'spell_dreamwalker_nightmare_cloud');

-- spell Emerald Vigor (70873), Twisted Nightmares (71941)
-- additional ids: triggered by Twisted Nightmares (71940)
DELETE FROM spell_script_names WHERE spell_id IN(70873, 71941, 71940, -70873, -71941, -71940);
DELETE FROM spell_scripts WHERE id IN(70873, 71941, 71940, -70873, -71941, -71940);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70873, 71941, 71940, -70873, -71941, -71940) OR spell_effect IN(70873, 71941, 71940, -70873, -71941, -71940);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70873, 71941, 71940, -70873, -71941, -71940);
INSERT INTO spell_script_names VALUES(71941, 'spell_dreamwalker_twisted_nightmares');

-- spell Mana Void (71179, 71741)
-- additional ids: 71085, 71086
DELETE FROM spell_script_names WHERE spell_id IN(71179, 71741, 71085, 71086, -71179, -71741, -71085, -71086);
DELETE FROM spell_scripts WHERE id IN(71179, 71741, 71085, 71086, -71179, -71741, -71085, -71086);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71179, 71741, 71085, 71086, -71179, -71741, -71085, -71086) OR spell_effect IN(71179, 71741, 71085, 71086, -71179, -71741, -71085, -71086);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(71179, 71741, 71085, 71086, -71179, -71741, -71085, -71086);
INSERT INTO spell_script_names VALUES(71085, 'spell_dreamwalker_mana_void');

-- spell Column of Frost (70704, 71747)
-- additional ids: 70715, (70702, 71746, 72019, 72020)
DELETE FROM spell_script_names WHERE spell_id IN(70704, 71747, 70715, 70702, 71746, 72019, 72020, -70704, -71747, -70715, -70702, -71746, -72019, -72020);
DELETE FROM spell_scripts WHERE id IN(70704, 71747, 70715, 70702, 71746, 72019, 72020, -70704, -71747, -70715, -70702, -71746, -72019, -72020);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70704, 71747, 70715, 70702, 71746, 72019, 72020, -70704, -71747, -70715, -70702, -71746, -72019, -72020) OR spell_effect IN(70704, 71747, 70715, 70702, 71746, 72019, 72020, -70704, -71747, -70715, -70702, -71746, -72019, -72020);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70704, 71747, 70715, 70702, 71746, 72019, 72020, -70704, -71747, -70715, -70702, -71746, -72019, -72020);

-- spell Recently Spawned (72954)
DELETE FROM spell_script_names WHERE spell_id IN(72954, -72954);
DELETE FROM spell_scripts WHERE id IN(72954, -72954);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(72954, -72954) OR spell_effect IN(72954, -72954);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(72954, -72954);

-- spell Summon Timer: Gluttonous Abomination (70915), (70921), (70922)
DELETE FROM spell_script_names WHERE spell_id IN(70915, 70921, 70922, -70915, -70921, -70922);
DELETE FROM spell_scripts WHERE id IN(70915, 70921, 70922, -70915, -70921, -70922);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70915, 70921, 70922, -70915, -70921, -70922) OR spell_effect IN(70915, 70921, 70922, -70915, -70921, -70922);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70915, 70921, 70922, -70915, -70921, -70922);
INSERT INTO `conditions` VALUES (13, 1, 70921, 0, 0, 31, 0, 3, 22515, 0, 0, 0, 0, '', 'The Lich King - Summon Gluttonous Abomination');
INSERT INTO spell_script_names VALUES(70915, 'spell_dreamwalker_decay_periodic_timer');
INSERT INTO spell_script_names VALUES(70921, 'spell_dreamwalker_summoner');

-- spell Summon Timer: Blazing Skeleton (70913), (70933), (70932)
DELETE FROM spell_script_names WHERE spell_id IN(70913, 70933, 70932, -70913, -70933, -70932);
DELETE FROM spell_scripts WHERE id IN(70913, 70933, 70932, -70913, -70933, -70932);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70913, 70933, 70932, -70913, -70933, -70932) OR spell_effect IN(70913, 70933, 70932, -70913, -70933, -70932);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70913, 70933, 70932, -70913, -70933, -70932);
INSERT INTO `conditions` VALUES (13, 1, 70933, 0, 0, 31, 0, 3, 22515, 0, 0, 0, 0, '', 'The Lich King - Summon Blazing Skeleton');
INSERT INTO spell_script_names VALUES(70913, 'spell_dreamwalker_decay_periodic_timer');
INSERT INTO spell_script_names VALUES(70933, 'spell_dreamwalker_summoner');

-- spell Summon Timer: Risen Archmage (70916), (71078), (71076)
DELETE FROM spell_script_names WHERE spell_id IN(70916, 71078, 71076, -70916, -71078, -71076);
DELETE FROM spell_scripts WHERE id IN(70916, 71078, 71076, -70916, -71078, -71076);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70916, 71078, 71076, -70916, -71078, -71076) OR spell_effect IN(70916, 71078, 71076, -70916, -71078, -71076);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70916, 71078, 71076, -70916, -71078, -71076);
INSERT INTO `conditions` VALUES (13, 1, 71078, 0, 0, 31, 0, 3, 22515, 0, 0, 0, 0, '', 'The Lich King - Summon Risen Archmage');
INSERT INTO spell_script_names VALUES(70916, 'spell_dreamwalker_decay_periodic_timer');
INSERT INTO spell_script_names VALUES(71078, 'spell_dreamwalker_summoner');

-- spell Summon Timer: Blistering Zombie (70914), (71032), (71031)
DELETE FROM spell_script_names WHERE spell_id IN(70914, 71032, 71031, -70914, -71032, -71031);
DELETE FROM spell_scripts WHERE id IN(70914, 71032, 71031, -70914, -71032, -71031);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70914, 71032, 71031, -70914, -71032, -71031) OR spell_effect IN(70914, 71032, 71031, -70914, -71032, -71031);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70914, 71032, 71031, -70914, -71032, -71031);
INSERT INTO `conditions` VALUES (13, 1, 71032, 0, 0, 31, 0, 3, 22515, 0, 0, 0, 0, '', 'The Lich King - Summon Blistering Zombie');
INSERT INTO spell_script_names VALUES(71032, 'spell_dreamwalker_summoner');

-- spell Summon Timer: Suppresser (70912), (70936), (70935)
DELETE FROM spell_script_names WHERE spell_id IN(70912, 70936, 70935, -70912, -70936, -70935);
DELETE FROM spell_scripts WHERE id IN(70912, 70936, 70935, -70912, -70936, -70935);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70912, 70936, 70935, -70912, -70936, -70935) OR spell_effect IN(70912, 70936, 70935, -70912, -70936, -70935);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70912, 70936, 70935, -70912, -70936, -70935);
INSERT INTO spell_script_names VALUES(70912, 'spell_dreamwalker_decay_periodic_timer');
INSERT INTO spell_script_names VALUES(70912, 'spell_dreamwalker_summon_suppresser');
INSERT INTO spell_script_names VALUES(70936, 'spell_dreamwalker_summon_suppresser_effect');

-- spell Suppression (70588)
DELETE FROM spell_script_names WHERE spell_id IN(70588, -70588);
DELETE FROM spell_scripts WHERE id IN(70588, -70588);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70588, -70588) OR spell_effect IN(70588, -70588);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70588, -70588);
INSERT INTO `conditions` VALUES (13, 1, 70588, 0, 0, 31, 0, 3, 36789, 0, 0, 0, 0, '', 'Suppresser - Suppression target Valithria');
INSERT INTO spell_script_names VALUES(70588, 'spell_valithria_suppression');

-- spell Acid Burst (70744, 71733, 72017, 72018)
DELETE FROM spell_script_names WHERE spell_id IN(70744, 71733, 72017, 72018, -70744, -71733, -72017, -72018);
DELETE FROM spell_scripts WHERE id IN(70744, 71733, 72017, 72018, -70744, -71733, -72017, -72018);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70744, 71733, 72017, 72018, -70744, -71733, -72017, -72018) OR spell_effect IN(70744, 71733, 72017, 72018, -70744, -71733, -72017, -72018);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70744, 71733, 72017, 72018, -70744, -71733, -72017, -72018);

-- spell Rot Worm Spawner (70675, 70676)
-- additional ids: Flesh Rot (72963, 72964, 72965, 72966)
DELETE FROM spell_script_names WHERE spell_id IN(70675, 70676, -70675, -70676, 72963, 72964, 72965, 72966, -72963, -72964, -72965, -72966);
DELETE FROM spell_scripts WHERE id IN(70675, 70676, -70675, -70676, 72963, 72964, 72965, 72966, -72963, -72964, -72965, -72966);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70675, 70676, -70675, -70676, 72963, 72964, 72965, 72966, -72963, -72964, -72965, -72966) OR spell_effect IN(70675, 70676, -70675, -70676, 72963, 72964, 72965, 72966, -72963, -72964, -72965, -72966);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70675, 70676, -70675, -70676, 72963, 72964, 72965, 72966, -72963, -72964, -72965, -72966);



-- ###################
-- ### GAUNTLET EVENT
-- ###################

-- Area Trigger
REPLACE INTO areatrigger_scripts VALUES(5623, 'at_icc_gauntlet_event');

-- Sindragosa's Ward (37503)
DELETE FROM creature WHERE id=37503;
INSERT INTO creature VALUES (247100, 37503, 631, 15, 1, 0, 0, 4181.5, 2483.99, 211.033, 2.18341, 1209600, 0, 0, 0, 0, 0, 0, 0, 0);
DELETE FROM creature_text WHERE entry=37503;
INSERT INTO creature_text VALUES (37503, 0, 0, 'You must not approach the Frost Queen! Quickly, stop them!', 14, 0, 100, 0, 0, 17167, 1, 'Sindragosa''s Ward SAY_INIT');
UPDATE creature_template SET faction=35, unit_flags=33555200, flags_extra=130, AIName='', ScriptName='npc_icc_gauntlet_controller' WHERE entry=37503;

-- Frostwarden Warrior (37228, 38134)
UPDATE creature_template SET speed_walk=1, speed_run=1.14286, minlevel=80, maxlevel=80, exp=2, faction=2209, rank=1, mindmg=828, maxdmg=1127, attackpower=300, dmg_multiplier=7, baseattacktime=2000, unit_class=1, unit_flags=0, lootid=37228, InhabitType=3, flags_extra=0, mechanic_immune_mask=8388624, AIName='SmartAI', ScriptName='' WHERE entry=37228;
UPDATE creature_template SET speed_walk=1, speed_run=1.14286, minlevel=80, maxlevel=80, exp=2, faction=2209, rank=1, mindmg=710, maxdmg=967, attackpower=300, dmg_multiplier=13, baseattacktime=2000, unit_class=1, unit_flags=0, lootid=37228, InhabitType=3, flags_extra=0, mechanic_immune_mask=8388624, AIName='', ScriptName='' WHERE entry=38134;
DELETE FROM smart_scripts WHERE entryorguid=37228 AND source_type=0;
INSERT INTO smart_scripts VALUES (37228, 0, 0, 0, 0, 0, 100, 0, 6000, 9000, 12000, 15000, 11, 71316, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Frostwarden Warrior - In Combat - Cast Glacial Strike');
INSERT INTO smart_scripts VALUES (37228, 0, 1, 0, 0, 0, 100, 0, 9000, 15000, 30000, 45000, 11, 71325, 0, 0, 0, 0, 0, 5, 50, 0, 0, 0, 0, 0, 0, 'Frostwarden Warrior - In Combat - Cast Frostblade');
INSERT INTO smart_scripts VALUES (37228, 0, 2, 0, 25, 0, 100, 0, 1, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Frostwarden Warrior - On Reset - Set In Combat With Zone');

-- Glacial Strike (71316)
DELETE FROM spell_script_names WHERE spell_id IN(71316, 71317);
INSERT INTO spell_script_names VALUES(71316, "spell_pos_glacial_strike");
INSERT INTO spell_script_names VALUES(71317, "spell_pos_glacial_strike");

-- Frostwarden Sorceress (37229, 38137)
UPDATE creature_template SET modelid1=27548, modelid2=0, speed_walk=1, speed_run=1.14286, minlevel=80, maxlevel=80, exp=2, faction=2209, rank=1, mindmg=828, maxdmg=1127, attackpower=300, dmg_multiplier=7, baseattacktime=2000, unit_class=8, unit_flags=0, lootid=37229, InhabitType=3, flags_extra=0, mechanic_immune_mask=8388624, AIName='SmartAI', ScriptName='' WHERE entry=37229;
UPDATE creature_template SET modelid1=27548, modelid2=0, speed_walk=1, speed_run=1.14286, minlevel=80, maxlevel=80, exp=2, faction=2209, rank=1, mindmg=710, maxdmg=967, attackpower=300, dmg_multiplier=13, baseattacktime=2000, unit_class=8, unit_flags=0, lootid=37229, InhabitType=3, flags_extra=0, mechanic_immune_mask=8388624, AIName='', ScriptName='' WHERE entry=38137;
DELETE FROM smart_scripts WHERE entryorguid=37229 AND source_type=0;
INSERT INTO smart_scripts VALUES (37229, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2000, 2500, 11, 71318, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Frostwarden Sorceress - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (37229, 0, 1, 0, 0, 0, 100, 0, 9000, 15000, 15000, 22000, 11, 71320, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Frostwarden Sorceress - In Combat - Cast Frost Nova');
INSERT INTO smart_scripts VALUES (37229, 0, 2, 0, 0, 0, 100, 20, 9000, 15000, 22000, 35000, 11, 71330, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Frostwarden Sorceress - In Combat - Cast Ice Tomb');
INSERT INTO smart_scripts VALUES (37229, 0, 3, 0, 25, 0, 100, 0, 1, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Frostwarden Sorceress - On Reset - Set In Combat With Zone');

-- Frostblade (38199)
UPDATE creature_template SET modelid1=1126, modelid2=16946, speed_walk=1, speed_run=1.14286, minlevel=80, maxlevel=80, exp=2, faction=2209, rank=0, mindmg=828, maxdmg=1127, attackpower=300, dmg_multiplier=7, baseattacktime=2000, unit_class=1, unit_flags=0, lootid=0, InhabitType=3, flags_extra=128, mechanic_immune_mask=0, AIName='SmartAI', ScriptName='' WHERE entry=38199;
DELETE FROM smart_scripts WHERE entryorguid=38199 AND source_type=0;
INSERT INTO smart_scripts VALUES (38199, 0, 0, 0, 60, 0, 100, 0, 0, 0, 9000, 9000, 11, 71323, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Frostblade - On Update - Cast Frostblade');

-- Nerub'ar Broodling (37232, 38362)
UPDATE creature_template SET speed_walk=1.85, speed_run=1.14286, minlevel=80, maxlevel=80, exp=2, faction=21, rank=0, mindmg=828, maxdmg=1127, attackpower=300, dmg_multiplier=1, baseattacktime=2000, unit_class=1, unit_flags=33555200, lootid=0, InhabitType=5, flags_extra=0, mechanic_immune_mask=8388624, AIName='SmartAI', ScriptName='' WHERE entry=37232;
UPDATE creature_template SET speed_walk=1.85, speed_run=1.14286, minlevel=80, maxlevel=80, exp=2, faction=21, rank=0, mindmg=828, maxdmg=1127, attackpower=300, dmg_multiplier=2, baseattacktime=2000, unit_class=1, unit_flags=33555200, lootid=0, InhabitType=5, flags_extra=0, mechanic_immune_mask=8388624, AIName='', ScriptName='' WHERE entry=38362;
DELETE FROM smart_scripts WHERE entryorguid=37232 AND source_type=0;
INSERT INTO smart_scripts VALUES (37232, 0, 0, 1, 34, 0, 100, 0, 8, 1, 0, 0, 19, 33555200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nerub''ar Broodling - Movement Inform - Remove Unit Flags');
INSERT INTO smart_scripts VALUES (37232, 0, 1, 2, 61, 0, 100, 0, 8, 1, 0, 0, 60, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nerub''ar Broodling - Movement Inform - Set Can Fly false');
INSERT INTO smart_scripts VALUES (37232, 0, 2, 3, 61, 0, 100, 0, 8, 1, 0, 0, 141, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nerub''ar Broodling - Movement Inform - Set Hover false');
INSERT INTO smart_scripts VALUES (37232, 0, 3, 0, 61, 0, 100, 0, 8, 1, 0, 0, 67, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nerub''ar Broodling - Movement Inform - Create Timed Event');
INSERT INTO smart_scripts VALUES (37232, 0, 4, 0, 59, 0, 100, 0, 1, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nerub''ar Broodling - Timed Event - Set In Combat With Zone');

-- Nerub'ar Champion (37501, 38362)
UPDATE creature_template SET speed_walk=2, speed_run=1.14286, minlevel=80, maxlevel=80, exp=2, faction=21, rank=1, mindmg=828, maxdmg=1127, attackpower=300, dmg_multiplier=7, baseattacktime=2000, unit_class=1, unit_flags=33555200, lootid=37501, InhabitType=5, flags_extra=0, mechanic_immune_mask=8388624, AIName='SmartAI', ScriptName='' WHERE entry=37501;
UPDATE creature_template SET speed_walk=2, speed_run=1.14286, minlevel=80, maxlevel=80, exp=2, faction=21, rank=1, mindmg=710, maxdmg=967, attackpower=300, dmg_multiplier=13, baseattacktime=2000, unit_class=1, unit_flags=33555200, lootid=38197, InhabitType=5, flags_extra=0, mechanic_immune_mask=8388624, AIName='', ScriptName='' WHERE entry=38197;
DELETE FROM smart_scripts WHERE entryorguid=37501 AND source_type=0;
INSERT INTO smart_scripts VALUES (37501, 0, 0, 0, 9, 0, 100, 0, 8, 25, 10000, 10000, 11, 71801, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Nerub''ar Champion - Within Range 8-25yd - Cast Rush');
INSERT INTO smart_scripts VALUES (37501, 0, 1, 2, 34, 0, 100, 0, 8, 1, 0, 0, 19, 33555200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nerub''ar Champion - Movement Inform - Remove Unit Flags');
INSERT INTO smart_scripts VALUES (37501, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 60, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nerub''ar Champion - Movement Inform - Set Can Fly false');
INSERT INTO smart_scripts VALUES (37501, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 141, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nerub''ar Champion - Movement Inform - Set Hover false');
INSERT INTO smart_scripts VALUES (37501, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nerub''ar Champion - Movement Inform - Create Timed Event');
INSERT INTO smart_scripts VALUES (37501, 0, 5, 0, 59, 0, 100, 0, 1, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nerub''ar Champion - Timed Event - Set In Combat With Zone');

-- Nerub'ar Webweaver (37502, 38198)
UPDATE creature_template SET speed_walk=2, speed_run=1.14286, minlevel=80, maxlevel=80, exp=2, faction=21, rank=1, mindmg=828, maxdmg=1127, attackpower=300, dmg_multiplier=7, baseattacktime=2000, unit_class=2, unit_flags=33555200, lootid=37502, InhabitType=5, flags_extra=0, mechanic_immune_mask=8388624, AIName='SmartAI', ScriptName='' WHERE entry=37502;
UPDATE creature_template SET speed_walk=2, speed_run=1.14286, minlevel=80, maxlevel=80, exp=2, faction=21, rank=1, mindmg=710, maxdmg=967, attackpower=300, dmg_multiplier=13, baseattacktime=2000, unit_class=2, unit_flags=33555200, lootid=38198, InhabitType=5, flags_extra=0, mechanic_immune_mask=8388624, AIName='', ScriptName='' WHERE entry=38198;
DELETE FROM smart_scripts WHERE entryorguid=37502 AND source_type=0;
INSERT INTO smart_scripts VALUES (37502, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 2000, 2500, 11, 71326, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Nerub''ar Webweaver - In Combat - Cast Crypt Scarabs');
INSERT INTO smart_scripts VALUES (37502, 0, 1, 0, 0, 0, 100, 0, 4000, 9000, 11000, 25000, 11, 71327, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Nerub''ar Webweaver - In Combat - Cast Web');
INSERT INTO smart_scripts VALUES (37502, 0, 2, 3, 34, 0, 100, 0, 8, 1, 0, 0, 19, 33555200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nerub''ar Webweaver - Movement Inform - Remove Unit Flags');
INSERT INTO smart_scripts VALUES (37502, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 60, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nerub''ar Webweaver - Movement Inform - Set Can Fly false');
INSERT INTO smart_scripts VALUES (37502, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 141, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nerub''ar Webweaver - Movement Inform - Set Hover false');
INSERT INTO smart_scripts VALUES (37502, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nerub''ar Webweaver - Movement Inform - Create Timed Event');
INSERT INTO smart_scripts VALUES (37502, 0, 6, 0, 59, 0, 100, 0, 1, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nerub''ar Webweaver - Timed Event - Set In Combat With Zone');



-- ###################
-- ### SINDRAGOSA
-- ###################

-- Sindragosa (36853, 38265, 38266, 38267)
UPDATE creature_template SET faction=2068, speed_walk=3.5, rank=3, speed_run=2.28571, mindmg=4340, maxdmg=5921, attackpower=300, dmg_multiplier=7, unit_flags=0, InhabitType=5, AIName='', ScriptName='boss_sindragosa', mechanic_immune_mask=650854271, flags_extra=1+0x200000 WHERE entry=36853;
UPDATE creature_template SET faction=2068, speed_walk=3.5, rank=3, speed_run=2.28571, mindmg=3503, maxdmg=4780, attackpower=300, dmg_multiplier=13, unit_flags=0, InhabitType=5, AIName='', ScriptName='', mechanic_immune_mask=650854271, flags_extra=1+0x200000 WHERE entry=38265;
UPDATE creature_template SET faction=2068, speed_walk=3.5, rank=3, speed_run=2.28571, mindmg=6506, maxdmg=8877, attackpower=300, dmg_multiplier=7, unit_flags=0, InhabitType=5, AIName='', ScriptName='', mechanic_immune_mask=650854271, flags_extra=1+0x200000 WHERE entry=38266;
UPDATE creature_template SET faction=2068, speed_walk=3.5, rank=3, speed_run=2.28571, mindmg=4673, maxdmg=6377, attackpower=300, dmg_multiplier=13, unit_flags=0, InhabitType=5, AIName='', ScriptName='', mechanic_immune_mask=650854271, flags_extra=1+0x200000 WHERE entry=38267;
REPLACE INTO creature_template_addon VALUES(36853, 0, 0, 0, 1, 0, ''),(38265, 0, 0, 0, 1, 0, ''),(38266, 0, 0, 0, 1, 0, ''),(38267, 0, 0, 0, 1, 0, '');
-- REPLACE INTO creature_template_addon VALUES(36853, 0, 0, 50331648, 1, 0, ''),(38265, 0, 0, 50331648, 1, 0, ''),(38266, 0, 0, 50331648, 1, 0, ''),(38267, 0, 0, 50331648, 1, 0, '');
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36853, 38265, 38266, 38267) AND `map`=631 );
DELETE FROM creature WHERE id IN(36853, 38265, 38266, 38267) AND `map`=631;
REPLACE INTO creature_text VALUES(36853, 101, 0, '%s appears to be weakening!', 41, 0, 100, 0, 0, 0, 0, 'emote for weekly quest');

-- Ice Tomb (36980, 38320, 38321, 38322)
UPDATE creature_template SET modelid1=30890, modelid2=0, modelid3=0, modelid4=0, IconName='', minlevel=80, maxlevel=80, faction=14, unit_flags=0, AIName='', ScriptName='npc_ice_tomb', mechanic_immune_mask=650870655, flags_extra=0+0x200000+0x4+0x10+0x800000, RegenHealth=0 WHERE entry=36980;
UPDATE creature_template SET modelid1=30890, modelid2=0, modelid3=0, modelid4=0, IconName='', minlevel=80, maxlevel=80, faction=14, unit_flags=0, AIName='', ScriptName='', mechanic_immune_mask=650870655, flags_extra=0+0x200000+0x4+0x10+0x800000, RegenHealth=0 WHERE entry=38320;
UPDATE creature_template SET modelid1=30890, modelid2=0, modelid3=0, modelid4=0, IconName='', minlevel=80, maxlevel=80, faction=14, unit_flags=0, AIName='', ScriptName='', mechanic_immune_mask=650870655, flags_extra=0+0x200000+0x4+0x10+0x800000, RegenHealth=0 WHERE entry=38321;
UPDATE creature_template SET modelid1=30890, modelid2=0, modelid3=0, modelid4=0, IconName='', minlevel=80, maxlevel=80, faction=14, unit_flags=0, AIName='', ScriptName='', mechanic_immune_mask=650870655, flags_extra=0+0x200000+0x4+0x10+0x800000, RegenHealth=0 WHERE entry=38322;
DELETE FROM creature_template_addon WHERE entry IN(36980, 38320, 38321, 38322);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36980, 38320, 38321, 38322) AND `map`=631 );
DELETE FROM creature WHERE id IN(36980, 38320, 38321, 38322) AND `map`=631;
REPLACE INTO creature_model_info VALUES(30890, 0, 7, 2, 0);

-- Frost Bomb (37186)
UPDATE creature_template SET difficulty_entry_1=0, modelid1=15880, modelid2=0, modelid3=0, modelid4=0, IconName='', minlevel=80, maxlevel=80, faction=14, unit_flags=33554432+512, AIName='NullCreatureAI', ScriptName='', flags_extra=0 WHERE entry=37186;
REPLACE INTO creature_template_addon VALUES(37186, 0, 0, 0, 1, 0, '40031 70022');
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37186) AND `map`=631 );
DELETE FROM creature WHERE id IN(37186) AND `map`=631;

-- go Ice Block (201722)
REPLACE INTO `gameobject_template` VALUES (201722, 0, 9244, 'Ice Block', '', '', '', 114, 32, 1.5, 0, 0, 0, 0, 0, 0, 0, 0, 3000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 12340);
DELETE FROM gameobject WHERE id IN(201722) AND `map`=631;

-- spell Sindragosa's Fury (70608)
-- additional ids: triggered damage (70598)
DELETE FROM spell_script_names WHERE spell_id IN(70608, 70598, -70608, -70598);
DELETE FROM spell_scripts WHERE id IN(70608, 70598, -70608, -70598);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70608, 70598, -70608, -70598) OR spell_effect IN(70608, 70598, -70608, -70598);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70608, 70598, -70608, -70598);
INSERT INTO spell_script_names VALUES(70598, 'spell_sindragosa_s_fury');

-- spell Tank Marker (71039)
-- additional ids: procced aura (71038)
DELETE FROM spell_script_names WHERE spell_id IN(71039, 71038, -71039, -71038);
DELETE FROM spell_scripts WHERE id IN(71039, 71038, -71039, -71038);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71039, 71038, -71039, -71038) OR spell_effect IN(71039, 71038, -71039, -71038);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(71039, 71038, -71039, -71038);
REPLACE INTO spell_proc_event VALUES(71039, 0, 0, 0, 0, 0, 0, 65536, 0, 0, 0);

-- spell Frost Aura (70084, 71050, 71051, 71052)
DELETE FROM spell_script_names WHERE spell_id IN(70084, 71050, 71051, 71052, -70084, -71050, -71051, -71052);
DELETE FROM spell_scripts WHERE id IN(70084, 71050, 71051, 71052, -70084, -71050, -71051, -71052);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70084, 71050, 71051, 71052, -70084, -71050, -71051, -71052) OR spell_effect IN(70084, 71050, 71051, 71052, -70084, -71050, -71051, -71052);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70084, 71050, 71051, 71052, -70084, -71050, -71051, -71052);

-- spell Permeating Chill (70109)
-- additional ids: triggered 22,15 with proc (70107), procced (70106)
DELETE FROM spell_script_names WHERE spell_id IN(70109, 70107, 70106, -70109, -70107, -70106);
DELETE FROM spell_scripts WHERE id IN(70109, 70107, 70106, -70109, -70107, -70106);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70109, 70107, 70106, -70109, -70107, -70106) OR spell_effect IN(70109, 70107, 70106, -70109, -70107, -70106);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70109, 70107, 70106, -70109, -70107, -70106);
DELETE FROM spell_proc_event WHERE entry=70107;
INSERT INTO spell_script_names VALUES(70107, 'spell_sindragosa_permeating_chill');

-- spell Unchained Magic (69762)
-- additional ids: Instability (69766), Backlash (69770, 71044, 71045, 71046)
DELETE FROM spell_script_names WHERE spell_id IN(69762, 69766, -69762, -69766, 69770, 71044, 71045, 71046, -69770, -71044, -71045, -71046);
DELETE FROM spell_scripts WHERE id IN(69762, 69766, -69762, -69766, 69770, 71044, 71045, 71046, -69770, -71044, -71045, -71046);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69762, 69766, -69762, -69766, 69770, 71044, 71045, 71046, -69770, -71044, -71045, -71046) OR spell_effect IN(69762, 69766, -69762, -69766, 69770, 71044, 71045, 71046, -69770, -71044, -71045, -71046);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(69762, 69766, -69762, -69766, 69770, 71044, 71045, 71046, -69770, -71044, -71045, -71046);
INSERT INTO spell_script_names VALUES(69762, 'spell_sindragosa_unchained_magic');
INSERT INTO spell_script_names VALUES(69762, 'spell_gen_allow_proc_from_spells_with_cost');
INSERT INTO spell_script_names VALUES(69766, 'spell_sindragosa_instability');
REPLACE INTO spell_proc_event VALUES(69762, 0, 0, 0, 0, 0, 87040, 3, 0, 100, 0);

-- spell Icy Grip (70117)
-- additional ids: jump (70122)
DELETE FROM spell_script_names WHERE spell_id IN(70117, 70122, -70117, -70122);
DELETE FROM spell_scripts WHERE id IN(70117, 70122, -70117, -70122);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70117, 70122, -70117, -70122) OR spell_effect IN(70117, 70122, -70117, -70122);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70117, 70122, -70117, -70122);
INSERT INTO spell_script_names VALUES(70117, 'spell_sindragosa_icy_grip');
INSERT INTO spell_script_names VALUES(70122, 'spell_sindragosa_icy_grip_jump');

-- spell Tail Smash (71077)
DELETE FROM spell_script_names WHERE spell_id IN(71077, -71077);
DELETE FROM spell_scripts WHERE id IN(71077, -71077);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71077, -71077) OR spell_effect IN(71077, -71077);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(71077, -71077);

-- spell Ice Tomb (69712)
-- additional ids: triggered dummy (69675), Frost Beacon (70126), damage to nearby + trap (70157)
DELETE FROM spell_script_names WHERE spell_id IN(69712, 69675, 70126, 70157, -69712, -69675, -70126, -70157);
DELETE FROM spell_scripts WHERE id IN(69712, 69675, 70126, 70157, -69712, -69675, -70126, -70157);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69712, 69675, 70126, 70157, -69712, -69675, -70126, -70157) OR spell_effect IN(69712, 69675, 70126, 70157, -69712, -69675, -70126, -70157);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(69712, 69675, 70126, 70157, -69712, -69675, -70126, -70157);
INSERT INTO spell_script_names VALUES(69712, 'spell_sindragosa_ice_tomb_filter');
INSERT INTO spell_script_names VALUES(69712, 'spell_sindragosa_ice_tomb');
INSERT INTO spell_script_names VALUES(69712, 'spell_sindragosa_ice_tomb_dummy');
INSERT INTO spell_script_names VALUES(70126, 'spell_sindragosa_frost_beacon');
INSERT INTO spell_script_names VALUES(70157, 'spell_sindragosa_ice_tomb_trap');

-- spell Frost Bomb (69846)
-- additional ids: visual (70022), damage (69845, 71053, 71054, 71055)
DELETE FROM spell_script_names WHERE spell_id IN(69846, 70022, 69845, 71053, 71054, 71055, -69846, -70022, -69845, -71053, -71054, -71055);
DELETE FROM spell_scripts WHERE id IN(69846, 70022, 69845, 71053, 71054, 71055, -69846, -70022, -69845, -71053, -71054, -71055);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69846, 70022, 69845, 71053, 71054, 71055, -69846, -70022, -69845, -71053, -71054, -71055) OR spell_effect IN(69846, 70022, 69845, 71053, 71054, 71055, -69846, -70022, -69845, -71053, -71054, -71055);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(69846, 70022, 69845, 71053, 71054, 71055, -69846, -70022, -69845, -71053, -71054, -71055);

-- spell Mystic Buffet (70128)
-- additional ids: triggered aura (70127, 72528, 72529, 72530)
DELETE FROM disables WHERE entry IN(70127, 72528, 72529, 72530) AND sourceType=0 AND flags=64;
INSERT INTO disables VALUES(0, 70127, 64, '', '', 'Disable LOS for Mystic Buffet (Sindragosa, Icecrown Citadel)');
INSERT INTO disables VALUES(0, 72528, 64, '', '', 'Disable LOS for Mystic Buffet (Sindragosa, Icecrown Citadel)');
INSERT INTO disables VALUES(0, 72529, 64, '', '', 'Disable LOS for Mystic Buffet (Sindragosa, Icecrown Citadel)');
INSERT INTO disables VALUES(0, 72530, 64, '', '', 'Disable LOS for Mystic Buffet (Sindragosa, Icecrown Citadel)');
DELETE FROM spell_script_names WHERE spell_id IN(70128, 70127, 72528, 72529, 72530, -70128, -70127, -72528, -72529, -72530);
DELETE FROM spell_scripts WHERE id IN(70128, 70127, 72528, 72529, 72530, -70128, -70127, -72528, -72529, -72530);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70128, 70127, 72528, 72529, 72530, -70128, -70127, -72528, -72529, -72530) OR spell_effect IN(70128, 70127, 72528, 72529, 72530, -70128, -70127, -72528, -72529, -72530);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70128, 70127, 72528, 72529, 72530, -70128, -70127, -72528, -72529, -72530);
INSERT INTO spell_script_names VALUES(70127, 'spell_sindragosa_mystic_buffet');
INSERT INTO spell_script_names VALUES(72528, 'spell_sindragosa_mystic_buffet');
INSERT INTO spell_script_names VALUES(72529, 'spell_sindragosa_mystic_buffet');
INSERT INTO spell_script_names VALUES(72530, 'spell_sindragosa_mystic_buffet');


-- Spinestalker (37534, 38219)
UPDATE creature_template SET faction=21, speed_walk=2, speed_run=2, mindmg=2549, maxdmg=3674, attackpower=300, dmg_multiplier=10, unit_flags=64, InhabitType=5, AIName='', ScriptName='npc_spinestalker', mechanic_immune_mask=650854271, flags_extra=0+0x200000 WHERE entry=37534;
UPDATE creature_template SET faction=21, speed_walk=2, speed_run=2, mindmg=2174, maxdmg=2967, attackpower=300, dmg_multiplier=18, unit_flags=64, InhabitType=5, AIName='', ScriptName='', mechanic_immune_mask=650854271, flags_extra=0+0x200000 WHERE entry=38219;
REPLACE INTO creature_template_addon VALUES(37534, 2072110, 0, 0, 1, 0, ''),(38219, 2072110, 0, 0, 1, 0, '');
-- REPLACE INTO creature_template_addon VALUES(37534, 2072110, 0, 50331648, 1, 0, ''),(38219, 2072110, 0, 50331648, 1, 0, '');
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37534, 38219) AND `map`=631 );
UPDATE creature SET spawntimesecs=604800 WHERE id IN(37534, 38219);

-- Rimefang (37533, 38220)
UPDATE creature_template SET faction=21, speed_walk=2, speed_run=2, mindmg=2549, maxdmg=3674, attackpower=300, dmg_multiplier=10, unit_flags=64, InhabitType=5, AIName='', ScriptName='npc_rimefang_icc', mechanic_immune_mask=650854271, flags_extra=0+0x200000 WHERE entry=37533;
UPDATE creature_template SET faction=21, speed_walk=2, speed_run=2, mindmg=2174, maxdmg=2967, attackpower=300, dmg_multiplier=18, unit_flags=64, InhabitType=5, AIName='', ScriptName='', mechanic_immune_mask=650854271, flags_extra=0+0x200000 WHERE entry=38220;
DELETE FROM creature_template_addon WHERE entry IN(37533, 38220);
REPLACE INTO creature_template_addon VALUES(37533, 2072100, 0, 0, 1, 0, ''),(38220, 2072100, 0, 0, 1, 0, '');
-- REPLACE INTO creature_template_addon VALUES(37533, 2072100, 0, 50331648, 1, 0, ''),(38220, 2072100, 0, 50331648, 1, 0, '');
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37533, 38220) AND `map`=631 );
UPDATE creature SET spawntimesecs=604800 WHERE id IN(37533, 38220);

-- Icy Blast (38223)
UPDATE creature_template SET difficulty_entry_1=0, modelid1=16946, modelid2=0, modelid3=0, modelid4=0, faction=14, unit_flags=33554432, AIName='NullCreatureAI', flags_extra=128, ScriptName='' WHERE entry=38223;
DELETE FROM creature_template_addon WHERE entry IN(38223);

-- Frostwing Whelp (37532, 38151)
UPDATE creature_template SET faction=16, speed_walk=1, speed_run=1.14286, mindmg=828, maxdmg=1127, attackpower=300, dmg_multiplier=7, unit_flags=0, AIName='', ScriptName='npc_sindragosa_trash' WHERE entry=37532;
UPDATE creature_template SET faction=16, speed_walk=1, speed_run=1.14286, mindmg=1235, maxdmg=1681, attackpower=300, dmg_multiplier=7, unit_flags=0, AIName='', ScriptName='' WHERE entry=38151;
DELETE FROM creature_template_addon WHERE entry IN(37532, 38151);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37532, 38151) AND `map`=631 );

-- Frostwarden Handler (37531, 38139)
UPDATE creature_template SET faction=2209, speed_walk=1, speed_run=1.42857, mindmg=828, maxdmg=1127, attackpower=300, dmg_multiplier=14, unit_flags=0, AIName='', ScriptName='npc_sindragosa_trash', mechanic_immune_mask=650854271, flags_extra=0+0x200000 WHERE entry=37531;
UPDATE creature_template SET faction=2209, speed_walk=1, speed_run=1.42857, mindmg=1235, maxdmg=1681, attackpower=300, dmg_multiplier=14, unit_flags=0, AIName='', ScriptName='', mechanic_immune_mask=650854271, flags_extra=0+0x200000 WHERE entry=38139;
DELETE FROM creature_template_addon WHERE entry IN(37531, 38139);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37531, 38139) AND `map`=631 );



-- ###################
-- ### THE LICH KING
-- ###################

REPLACE INTO areatrigger_scripts VALUES(5718, 'at_frozen_throne_teleport');

-- npc The Lich King (36597, 39166, 39167, 39168)
UPDATE creature_template SET KillCredit1=38153, KillCredit2=0, minlevel=83, maxlevel=83, exp=2, faction=974, speed_walk=2, speed_run=1.71429, rank=3, mindmg=9000, maxdmg=10000, attackpower=300, dmg_multiplier=7.5, baseattacktime=1500, unit_flags=512, rangeattacktime=0, type_flags=268435564, AIName='', mechanic_immune_mask=650854271, flags_extra=1+0x200000, ScriptName='boss_the_lich_king' WHERE entry=36597;
UPDATE creature_template SET KillCredit1=38153, KillCredit2=0, minlevel=83, maxlevel=83, exp=2, faction=974, speed_walk=2, speed_run=1.71429, rank=3, mindmg=9000, maxdmg=10000, attackpower=300, dmg_multiplier=13, baseattacktime=1500, unit_flags=512, rangeattacktime=0, type_flags=268435564, AIName='', mechanic_immune_mask=650854271, flags_extra=1+0x200000, ScriptName='' WHERE entry=39166;
UPDATE creature_template SET KillCredit1=38153, KillCredit2=0, minlevel=83, maxlevel=83, exp=2, faction=974, speed_walk=2, speed_run=1.71429, rank=3, mindmg=9000, maxdmg=10000, attackpower=300, dmg_multiplier=10, baseattacktime=1500, unit_flags=512, rangeattacktime=0, type_flags=268435564, AIName='', mechanic_immune_mask=650854271, flags_extra=1+0x200000, ScriptName='' WHERE entry=39167;
UPDATE creature_template SET KillCredit1=38153, KillCredit2=0, minlevel=83, maxlevel=83, exp=2, faction=974, speed_walk=2, speed_run=1.71429, rank=3, mindmg=9000, maxdmg=10000, attackpower=300, dmg_multiplier=18, baseattacktime=1500, unit_flags=512, rangeattacktime=0, type_flags=268435564, AIName='', mechanic_immune_mask=650854271, flags_extra=1+0x200000, ScriptName='' WHERE entry=39168;
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36597, 39166, 39167, 39168) AND `map`=631 );
REPLACE INTO creature_template_addon VALUES(36597, 0, 0, 0, 0, 0, '72846 73878'),(39166, 0, 0, 0, 0, 0, '72846 73878'),(39167, 0, 0, 0, 0, 0, '72846 73878'),(39168, 0, 0, 0, 0, 0, '72846 73878');
UPDATE creature_template SET lootid=entry WHERE entry IN(36597, 39166, 39167, 39168);

-- npc Highlord Tirion Fordring (38995)
UPDATE creature_template SET difficulty_entry_1=0, difficulty_entry_2=0, difficulty_entry_3=0, npcflag=1, minlevel=83, maxlevel=83, exp=2, rank=3, faction=2073, speed_walk=1, speed_run=1.14286, mindmg=900, maxdmg=1000, attackpower=300, dmg_multiplier=7, baseattacktime=2000, unit_flags=32832, AIName='', mechanic_immune_mask=0, flags_extra=0, ScriptName='npc_tirion_fordring_tft' WHERE entry=38995;
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36597, 39166, 39167, 39168) AND `map`=631 );
DELETE FROM creature_template_addon WHERE entry IN(38995);

-- npc Terenas Menethil (38579) -- outro
UPDATE creature_template SET difficulty_entry_1=0, difficulty_entry_2=0, difficulty_entry_3=0, minlevel=80, maxlevel=80, exp=2, faction=1665, unit_flags=32832, AIName='NullCreatureAI', mechanic_immune_mask=0, flags_extra=0, ScriptName='' WHERE entry=38579;
REPLACE INTO creature_template_addon VALUES(38579, 0, 0, 0, 0, 0, '72372');

-- npc Frostmourne Trigger (38584)
UPDATE creature_template SET difficulty_entry_1=0, difficulty_entry_2=0, difficulty_entry_3=0, modelid1=11686, modelid2=0, modelid3=0, modelid4=0, minlevel=80, maxlevel=80, exp=2, faction=14, speed_walk=1.2, speed_run=0.428571, unit_flags=33554944, AIName='NullCreatureAI', mechanic_immune_mask=0, flags_extra=0, ScriptName='' WHERE entry=38584;
DELETE FROM creature_template_addon WHERE entry IN(38584);

-- npc World Trigger (22515)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(22515) AND `map`=631 AND position_x<600 );
DELETE FROM creature WHERE id IN(22515) AND `map`=631 AND position_x<600;
INSERT INTO `creature` VALUES (NULL, 22515, 631, 15, 1, 0, 0, 466.25, -2071.3, 845.878, 0, 120, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 22515, 631, 15, 1, 0, 0, 470.72, -2183.84, 845.878, 0, 120, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 22515, 631, 15, 1, 0, 0, 477.042, -2164.19, 840.94, 0, 120, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 22515, 631, 15, 1, 0, 0, 482.924, -2078.25, 840.94, 0, 120, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 22515, 631, 15, 1, 0, 0, 486.092, -2061.76, 845.878, 0, 120, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 22515, 631, 15, 1, 0, 0, 494.024, -2172.17, 840.94, 0, 120, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 22515, 631, 15, 1, 0, 0, 500.323, -2188.93, 845.878, 0, 120, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 22515, 631, 15, 1, 0, 0, 503.969, -2075.85, 840.94, 0, 120, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 22515, 631, 15, 1, 0, 0, 512.806, -2172.62, 840.94, 0, 120, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 22515, 631, 15, 1, 0, 0, 515.104, -2058.46, 845.878, 0, 120, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 22515, 631, 15, 1, 0, 0, 521.602, -2079.36, 840.94, 0, 120, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 22515, 631, 15, 1, 0, 0, 530.625, -2166.15, 840.94, 0, 120, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 22515, 631, 15, 1, 0, 0, 530.698, -2182.86, 845.878, 0, 120, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 22515, 631, 15, 1, 0, 0, 539.628, -2089.51, 840.94, 0, 120, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 22515, 631, 15, 1, 0, 0, 542.559, -2151.41, 840.94, 0, 120, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 22515, 631, 15, 1, 0, 0, 542.776, -2071.84, 845.878, 0, 120, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 22515, 631, 15, 1, 0, 0, 548.729, -2110.41, 840.94, 0, 120, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 22515, 631, 15, 1, 0, 0, 550.62, -2132.89, 840.94, 0, 120, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 22515, 631, 15, 1, 0, 0, 554.196, -2166.77, 845.878, 0, 120, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 22515, 631, 15, 1, 0, 0, 567.837, -2144.41, 845.878, 0, 120, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 22515, 631, 15, 1, 0, 0, 568.533, -2106.96, 845.878, 0, 120, 0, 0, 0, 0, 0, 0, 0, 0);

-- World Trigger (Infinite AOI) (36171)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36171) AND `map`=631 );
DELETE FROM creature WHERE id IN(36171) AND `map`=631;
INSERT INTO `creature` VALUES (NULL, 36171, 631, 15, 1, 0, 0, 495.708, -2523.76, 1049.95, 0, 120, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 36171, 631, 15, 1, 0, 0, 514.554, -2523.16, 1049.95, 0, 120, 0, 0, 0, 0, 0, 0, 0, 0);

-- spell Plague Avoidance (72846), Emote - Sit (73220), Emote - Shout (73213)
DELETE FROM spell_script_names WHERE spell_id IN(72846, 73220, 73213, -72846, -73220, -73213);
DELETE FROM spell_scripts WHERE id IN(72846, 73220, 73213, -72846, -73220, -73213);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(72846, 73220, 73213, -72846, -73220, -73213) OR spell_effect IN(72846, 73220, 73213, -72846, -73220, -73213);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(72846, 73220, 73213, -72846, -73220, -73213);

-- spell Ice Lock (71614)
DELETE FROM spell_script_names WHERE spell_id IN(71614, -71614);
DELETE FROM spell_scripts WHERE id IN(71614, -71614);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71614, -71614) OR spell_effect IN(71614, -71614);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(71614, -71614);
INSERT INTO `conditions` VALUES (13, 7, 71614, 0, 0, 31, 0, 3, 38995, 0, 0, 0, 0, '', 'Ice Lock - target Highlord Tirion Fordring');

-- spell Boss Hittin' Ya (73878, 73879)
DELETE FROM spell_script_names WHERE spell_id IN(73878, 73879, -73878, -73879);
DELETE FROM spell_scripts WHERE id IN(73878, 73879, -73878, -73879);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(73878, 73879, -73878, -73879) OR spell_effect IN(73878, 73879, -73878, -73879);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(73878, 73879, -73878, -73879);
REPLACE INTO spell_proc_event VALUES(73878, 0, 0, 0, 0, 0, 0, 65536, 0, 0, 0);

-- spell Remorseless Winter (68981, 74270, 74271, 74272), second (72259, 74273, 74274, 74275), dmg (68983, 73791, 73792, 73793)
DELETE FROM spell_script_names WHERE spell_id IN(68981, 74270, 74271, 74272, -68981, -74270, -74271, -74272, 72259, 74273, 74274, 74275, -72259, -74273, -74274, -74275, 68983, 73791, 73792, 73793, -68983, -73791, -73792, -73793);
DELETE FROM spell_scripts WHERE id IN(68981, 74270, 74271, 74272, -68981, -74270, -74271, -74272, 72259, 74273, 74274, 74275, -72259, -74273, -74274, -74275, 68983, 73791, 73792, 73793, -68983, -73791, -73792, -73793);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(68981, 74270, 74271, 74272, -68981, -74270, -74271, -74272, 72259, 74273, 74274, 74275, -72259, -74273, -74274, -74275, 68983, 73791, 73792, 73793, -68983, -73791, -73792, -73793) OR spell_effect IN(68981, 74270, 74271, 74272, -68981, -74270, -74271, -74272, 72259, 74273, 74274, 74275, -72259, -74273, -74274, -74275, 68983, 73791, 73792, 73793, -68983, -73791, -73792, -73793);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(68981, 74270, 74271, 74272, -68981, -74270, -74271, -74272, 72259, 74273, 74274, 74275, -72259, -74273, -74274, -74275, 68983, 73791, 73792, 73793, -68983, -73791, -73792, -73793);
INSERT INTO `conditions` VALUES (13, 4, 68981, 0, 0, 31, 0, 5, 202141, 0, 0, 0, 0, '', 'Remorseless Winter - target Doodad_IceShard_standing02');
INSERT INTO `conditions` VALUES (13, 4, 68981, 0, 1, 31, 0, 5, 202142, 0, 0, 0, 0, '', 'Remorseless Winter - target Doodad_IceShard_standing01');
INSERT INTO `conditions` VALUES (13, 4, 68981, 0, 2, 31, 0, 5, 202143, 0, 0, 0, 0, '', 'Remorseless Winter - target Doodad_IceShard_standing03');
INSERT INTO `conditions` VALUES (13, 4, 68981, 0, 3, 31, 0, 5, 202144, 0, 0, 0, 0, '', 'Remorseless Winter - target Doodad_IceShard_standing04');
INSERT INTO `conditions` VALUES (13, 4, 74270, 0, 0, 31, 0, 5, 202141, 0, 0, 0, 0, '', 'Remorseless Winter - target Doodad_IceShard_standing02');
INSERT INTO `conditions` VALUES (13, 4, 74270, 0, 1, 31, 0, 5, 202142, 0, 0, 0, 0, '', 'Remorseless Winter - target Doodad_IceShard_standing01');
INSERT INTO `conditions` VALUES (13, 4, 74270, 0, 2, 31, 0, 5, 202143, 0, 0, 0, 0, '', 'Remorseless Winter - target Doodad_IceShard_standing03');
INSERT INTO `conditions` VALUES (13, 4, 74270, 0, 3, 31, 0, 5, 202144, 0, 0, 0, 0, '', 'Remorseless Winter - target Doodad_IceShard_standing04');
INSERT INTO `conditions` VALUES (13, 4, 74271, 0, 0, 31, 0, 5, 202141, 0, 0, 0, 0, '', 'Remorseless Winter - target Doodad_IceShard_standing02');
INSERT INTO `conditions` VALUES (13, 4, 74271, 0, 1, 31, 0, 5, 202142, 0, 0, 0, 0, '', 'Remorseless Winter - target Doodad_IceShard_standing01');
INSERT INTO `conditions` VALUES (13, 4, 74271, 0, 2, 31, 0, 5, 202143, 0, 0, 0, 0, '', 'Remorseless Winter - target Doodad_IceShard_standing03');
INSERT INTO `conditions` VALUES (13, 4, 74271, 0, 3, 31, 0, 5, 202144, 0, 0, 0, 0, '', 'Remorseless Winter - target Doodad_IceShard_standing04');
INSERT INTO `conditions` VALUES (13, 4, 74272, 0, 0, 31, 0, 5, 202141, 0, 0, 0, 0, '', 'Remorseless Winter - target Doodad_IceShard_standing02');
INSERT INTO `conditions` VALUES (13, 4, 74272, 0, 1, 31, 0, 5, 202142, 0, 0, 0, 0, '', 'Remorseless Winter - target Doodad_IceShard_standing01');
INSERT INTO `conditions` VALUES (13, 4, 74272, 0, 2, 31, 0, 5, 202143, 0, 0, 0, 0, '', 'Remorseless Winter - target Doodad_IceShard_standing03');
INSERT INTO `conditions` VALUES (13, 4, 74272, 0, 3, 31, 0, 5, 202144, 0, 0, 0, 0, '', 'Remorseless Winter - target Doodad_IceShard_standing04');
DELETE FROM event_scripts WHERE id=23507;

-- spell Quake (72262)
DELETE FROM spell_script_names WHERE spell_id IN(72262, -72262);
DELETE FROM spell_scripts WHERE id IN(72262, -72262);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(72262, -72262) OR spell_effect IN(72262, -72262);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(72262, -72262);
INSERT INTO spell_script_names VALUES(72262, 'spell_the_lich_king_quake');
INSERT INTO `conditions` VALUES (13, 1, 72262, 0, 0, 31, 0, 3, 22515, 0, 0, 0, 0, '', 'Quake - target World Trigger');
DELETE FROM event_scripts WHERE id=23437;

-- spell Fury of Frostmourne (72350), no ress (72351)
DELETE FROM spell_script_names WHERE spell_id IN(72350, -72350, 72351, -72351);
DELETE FROM spell_scripts WHERE id IN(72350, -72350, 72351, -72351);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(72350, -72350, 72351, -72351) OR spell_effect IN(72350, -72350, 72351, -72351);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(72350, -72350, 72351, -72351);

-- spell Raise Dead (71769, 72376)
DELETE FROM spell_script_names WHERE spell_id IN(71769, 72376, -71769, -72376);
DELETE FROM spell_scripts WHERE id IN(71769, 72376, -71769, -72376);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71769, 72376, -71769, -72376) OR spell_effect IN(71769, 72376, -71769, -72376);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(71769, 72376, -71769, -72376);

-- spell Light's Blessing (71797, 71773)
DELETE FROM spell_script_names WHERE spell_id IN(71797, 71773, -71797, -71773);
DELETE FROM spell_scripts WHERE id IN(71797, 71773, -71797, -71773);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71797, 71773, -71797, -71773) OR spell_effect IN(71797, 71773, -71797, -71773);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(71797, 71773, -71797, -71773);
DELETE FROM event_scripts WHERE id=23498;

-- spell Jump (71809), triggered (71811), clear no ress (72431)
DELETE FROM spell_script_names WHERE spell_id IN(71809, 71811, 72431, -71809, -71811, -72431);
DELETE FROM spell_scripts WHERE id IN(71809, 71811, 72431, -71809, -71811, -72431);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71809, 71811, 72431, -71809, -71811, -72431) OR spell_effect IN(71809, 71811, 72431, -71809, -71811, -72431);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(71809, 71811, 72431, -71809, -71811, -72431);
INSERT INTO spell_script_names VALUES (71811, 'spell_the_lich_king_jump');
INSERT INTO spell_script_names VALUES (72431, 'spell_the_lich_king_jump_remove_aura');
INSERT INTO conditions VALUES (13, 1, 71809, 0, 0, 31, 0, 3, 36597, 0, 0, 0, 0, '', 'Jump - target The Lich King');
INSERT INTO conditions VALUES (13, 1, 71811, 0, 0, 31, 0, 3, 36597, 0, 0, 0, 0, '', 'Jump - target The Lich King');

-- Summon Broken Frostmourne (74081, 72406, 73021, 73017, 72407, 72398)
DELETE FROM spell_script_names WHERE spell_id IN(74081, 72406, 73021, -74081, -72406, -73021, 73017, 72407, -73017, -72407, 72398, -72398);
DELETE FROM spell_scripts WHERE id IN(74081, 72406, 73021, -74081, -72406, -73021, 73017, 72407, -73017, -72407, 72398, -72398);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(74081, 72406, 73021, -74081, -72406, -73021, 73017, 72407, -73017, -72407, 72398, -72398) OR spell_effect IN(74081, 72406, 73021, -74081, -72406, -73021, 73017, 72407, -73017, -72407, 72398, -72398);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(74081, 72406, 73021, -74081, -72406, -73021, 73017, 72407, -73017, -72407, 72398, -72398);

-- spell Broken Frostmourne (72405, 72399)
DELETE FROM spell_script_names WHERE spell_id IN(72405, 72399, -72405, -72399);
DELETE FROM spell_scripts WHERE id IN(72405, 72399, -72405, -72399);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(72405, 72399, -72405, -72399) OR spell_effect IN(72405, 72399, -72405, -72399);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(72405, 72399, -72405, -72399);
INSERT INTO conditions VALUES (13, 2, 72405, 0, 0, 31, 0, 3, 38995, 0, 0, 0, 0, '', 'Broken Frostmourne - target Highlord Tirion Fordring');

-- spell Soul Barrage (72305), Summon Terenas (72420), Mass Resurrection (72429, 72423)
DELETE FROM spell_script_names WHERE spell_id IN(72305, 72420, 72429, 72423, -72305, -72420, -72429, -72423);
DELETE FROM spell_scripts WHERE id IN(72305, 72420, 72429, 72423, -72305, -72420, -72429, -72423);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(72305, 72420, 72429, 72423, -72305, -72420, -72429, -72423) OR spell_effect IN(72305, 72420, 72429, 72423, -72305, -72420, -72429, -72423);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(72305, 72420, 72429, 72423, -72305, -72420, -72429, -72423);
INSERT INTO spell_script_names VALUES(72429, 'spell_the_lich_king_mass_resurrection');
INSERT INTO conditions VALUES (13, 1, 72429, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Mass Resurrection - target players');

-- spell Play Movie (73159)
DELETE FROM spell_script_names WHERE spell_id IN(73159, -73159);
DELETE FROM spell_scripts WHERE id IN(73159, -73159);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(73159, -73159) OR spell_effect IN(73159, -73159);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(73159, -73159);
INSERT INTO spell_script_names VALUES(73159, 'spell_the_lich_king_play_movie');
INSERT INTO conditions VALUES (13, 1, 73159, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Mass Resurrection - target players');

-- --------------------------------------------------------------------
-- ------------------------ FIGHTING STUFF ----------------------------
-- --------------------------------------------------------------------

-- npc Shambling Horror (37698, 39299, 39300, 39301)
UPDATE creature_template SET minlevel=83, maxlevel=83, exp=2, faction=21, speed_walk=1.4, speed_run=1.14286, rank=1, mindmg=3500, maxdmg=4000, attackpower=300, dmg_multiplier=9, baseattacktime=2000, unit_flags=32832, AIName='', mechanic_immune_mask=650852191, flags_extra=0+0x200000, ScriptName='npc_shambling_horror_icc' WHERE entry=37698;
UPDATE creature_template SET minlevel=83, maxlevel=83, exp=2, faction=21, speed_walk=1.4, speed_run=1.14286, rank=1, mindmg=3500, maxdmg=4000, attackpower=300, dmg_multiplier=16, baseattacktime=2000, unit_flags=32832, AIName='', mechanic_immune_mask=650852191, flags_extra=0+0x200000, ScriptName='' WHERE entry=39299;
UPDATE creature_template SET minlevel=83, maxlevel=83, exp=2, faction=21, speed_walk=1.4, speed_run=1.14286, rank=1, mindmg=3500, maxdmg=4000, attackpower=300, dmg_multiplier=12, baseattacktime=2000, unit_flags=32832, AIName='', mechanic_immune_mask=650852191, flags_extra=0+0x200000, ScriptName='' WHERE entry=39300;
UPDATE creature_template SET minlevel=83, maxlevel=83, exp=2, faction=21, speed_walk=1.4, speed_run=1.14286, rank=1, mindmg=3500, maxdmg=4000, attackpower=300, dmg_multiplier=20, baseattacktime=2000, unit_flags=32832, AIName='', mechanic_immune_mask=650852191, flags_extra=0+0x200000, ScriptName='' WHERE entry=39301;
DELETE FROM creature_template_addon WHERE entry IN(37698, 39299, 39300, 39301);

-- Drudge Ghoul (37695, 39309, 39310, 39311)
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=2, faction=21, speed_walk=0.8, speed_run=1, rank=1, mindmg=450, maxdmg=500, attackpower=300, dmg_multiplier=9, baseattacktime=2000, unit_flags=32832, AIName='', mechanic_immune_mask=8388625, flags_extra=0, ScriptName='npc_icc_lk_checktarget' WHERE entry=37695;
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=2, faction=21, speed_walk=0.8, speed_run=1, rank=1, mindmg=450, maxdmg=500, attackpower=300, dmg_multiplier=16, baseattacktime=2000, unit_flags=32832, AIName='', mechanic_immune_mask=8388625, flags_extra=0, ScriptName='' WHERE entry=39309;
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=2, faction=21, speed_walk=0.8, speed_run=1, rank=1, mindmg=450, maxdmg=500, attackpower=300, dmg_multiplier=12, baseattacktime=2000, unit_flags=32832, AIName='', mechanic_immune_mask=8388625, flags_extra=0, ScriptName='' WHERE entry=39310;
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=2, faction=21, speed_walk=0.8, speed_run=1, rank=1, mindmg=450, maxdmg=500, attackpower=300, dmg_multiplier=20, baseattacktime=2000, unit_flags=32832, AIName='', mechanic_immune_mask=8388625, flags_extra=0, ScriptName='' WHERE entry=39311;
DELETE FROM creature_template_addon WHERE entry IN(37695, 39309, 39310, 39311);

-- spell Infest (70541, 73779, 73780, 73781)
DELETE FROM spell_script_names WHERE spell_id IN(70541, 73779, 73780, 73781, -70541, -73779, -73780, -73781);
DELETE FROM spell_scripts WHERE id IN(70541, 73779, 73780, 73781, -70541, -73779, -73780, -73781);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70541, 73779, 73780, 73781, -70541, -73779, -73780, -73781) OR spell_effect IN(70541, 73779, 73780, 73781, -70541, -73779, -73780, -73781);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70541, 73779, 73780, 73781, -70541, -73779, -73780, -73781);
INSERT INTO spell_script_names VALUES(70541, 'spell_the_lich_king_infest'),(73779, 'spell_the_lich_king_infest'),(73780, 'spell_the_lich_king_infest'),(73781, 'spell_the_lich_king_infest');

-- spell Necrotic Plague (70337, 73912, 73913, 73914), jump (70338, 73785, 73786, 73787)
DELETE FROM spell_script_names WHERE spell_id IN(70337, 73912, 73913, 73914, -70337, -73912, -73913, -73914, 70338, 73785, 73786, 73787, -70338, -73785, -73786, -73787);
DELETE FROM spell_scripts WHERE id IN(70337, 73912, 73913, 73914, -70337, -73912, -73913, -73914, 70338, 73785, 73786, 73787, -70338, -73785, -73786, -73787);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70337, 73912, 73913, 73914, -70337, -73912, -73913, -73914, 70338, 73785, 73786, 73787, -70338, -73785, -73786, -73787) OR spell_effect IN(70337, 73912, 73913, 73914, -70337, -73912, -73913, -73914, 70338, 73785, 73786, 73787, -70338, -73785, -73786, -73787);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70337, 73912, 73913, 73914, -70337, -73912, -73913, -73914, 70338, 73785, 73786, 73787, -70338, -73785, -73786, -73787);
INSERT INTO spell_script_names VALUES(70337, 'spell_the_lich_king_necrotic_plague'),(73912, 'spell_the_lich_king_necrotic_plague'),(73913, 'spell_the_lich_king_necrotic_plague'),(73914, 'spell_the_lich_king_necrotic_plague');
INSERT INTO spell_script_names VALUES (70338, 'spell_the_lich_king_necrotic_plague_jump'),(73785, 'spell_the_lich_king_necrotic_plague_jump'),(73786, 'spell_the_lich_king_necrotic_plague_jump'),(73787, 'spell_the_lich_king_necrotic_plague_jump');
INSERT INTO conditions VALUES (13, 1, 70338, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Necrotic Plague - target player');
INSERT INTO conditions VALUES (13, 1, 70338, 0, 1, 31, 0, 3, 37695, 0, 0, 0, 0, '', 'Necrotic Plague - target Drudge Ghoul');
INSERT INTO conditions VALUES (13, 1, 70338, 0, 2, 31, 0, 3, 37698, 0, 0, 0, 0, '', 'Necrotic Plague - target Shambling Horror');
INSERT INTO conditions VALUES (13, 1, 73785, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Necrotic Plague - target player');
INSERT INTO conditions VALUES (13, 1, 73785, 0, 1, 31, 0, 3, 37695, 0, 0, 0, 0, '', 'Necrotic Plague - target Drudge Ghoul');
INSERT INTO conditions VALUES (13, 1, 73785, 0, 2, 31, 0, 3, 37698, 0, 0, 0, 0, '', 'Necrotic Plague - target Shambling Horror');
INSERT INTO conditions VALUES (13, 1, 73786, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Necrotic Plague - target player');
INSERT INTO conditions VALUES (13, 1, 73786, 0, 1, 31, 0, 3, 37695, 0, 0, 0, 0, '', 'Necrotic Plague - target Drudge Ghoul');
INSERT INTO conditions VALUES (13, 1, 73786, 0, 2, 31, 0, 3, 37698, 0, 0, 0, 0, '', 'Necrotic Plague - target Shambling Horror');
INSERT INTO conditions VALUES (13, 1, 73787, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Necrotic Plague - target player');
INSERT INTO conditions VALUES (13, 1, 73787, 0, 1, 31, 0, 3, 37695, 0, 0, 0, 0, '', 'Necrotic Plague - target Drudge Ghoul');
INSERT INTO conditions VALUES (13, 1, 73787, 0, 2, 31, 0, 3, 37698, 0, 0, 0, 0, '', 'Necrotic Plague - target Shambling Horror');

-- spell Shadow Trap (73539, 73540, 73530, 73525, 74282, 73529)
DELETE FROM spell_script_names WHERE spell_id IN(73539, 73540, 73530, -73539, -73540, -73530, 73525, -73525, 74282, -74282, 73529, -73529);
DELETE FROM spell_scripts WHERE id IN(73539, 73540, 73530, -73539, -73540, -73530, 73525, -73525, 74282, -74282, 73529, -73529);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(73539, 73540, 73530, -73539, -73540, -73530, 73525, -73525, 74282, -74282, 73529, -73529) OR spell_effect IN(73539, 73540, 73530, -73539, -73540, -73530, 73525, -73525, 74282, -74282, 73529, -73529);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(73539, 73540, 73530, -73539, -73540, -73530, 73525, -73525, 74282, -74282, 73529, -73529);
INSERT INTO spell_script_names VALUES(73530, 'spell_the_lich_king_shadow_trap_visual');
INSERT INTO spell_script_names VALUES(74282, 'spell_the_lich_king_shadow_trap_periodic');

-- npc Shadow Trap (39137)
UPDATE creature_template SET difficulty_entry_1=0, difficulty_entry_2=0, difficulty_entry_3=0, modelid1=11686, modelid2=0, modelid3=0, modelid4=0, minlevel=83, maxlevel=83, exp=2, faction=14, speed_walk=1, speed_run=1.14286, unit_flags=33554432, AIName='NullCreatureAI', mechanic_immune_mask=0, flags_extra=0, ScriptName='' WHERE entry=39137;
REPLACE INTO creature_template_addon VALUES(39137, 0, 0, 0, 0, 0, '73530');

-- spell Summon Ice Sphere (69104, 69103), visual (69090), target search (69109, 69110), ice pulse (69091, 69092), ice pulse dmg (69099, 73776, 73777, 73778), ice burst (69108, 73773, 73774, 73775)
DELETE FROM spell_script_names WHERE spell_id IN(69104, 69103, 69090, 69109, 69110, 69091, 69092, 69099, 73776, 73777, 73778, 69108, 73773, 73774, 73775, -69104, -69103, -69090, -69109, -69110, -69091, -69092, -69099, -73776, -73777, -73778, -69108, -73773, -73774, -73775);
DELETE FROM spell_scripts WHERE id IN(69104, 69103, 69090, 69109, 69110, 69091, 69092, 69099, 73776, 73777, 73778, 69108, 73773, 73774, 73775, -69104, -69103, -69090, -69109, -69110, -69091, -69092, -69099, -73776, -73777, -73778, -69108, -73773, -73774, -73775);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69104, 69103, 69090, 69109, 69110, 69091, 69092, 69099, 73776, 73777, 73778, 69108, 73773, 73774, 73775, -69104, -69103, -69090, -69109, -69110, -69091, -69092, -69099, -73776, -73777, -73778, -69108, -73773, -73774, -73775) OR spell_effect IN(69104, 69103, 69090, 69109, 69110, 69091, 69092, 69099, 73776, 73777, 73778, 69108, 73773, 73774, 73775, -69104, -69103, -69090, -69109, -69110, -69091, -69092, -69099, -73776, -73777, -73778, -69108, -73773, -73774, -73775);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(69104, 69103, 69090, 69109, 69110, 69091, 69092, 69099, 73776, 73777, 73778, 69108, 73773, 73774, 73775, -69104, -69103, -69090, -69109, -69110, -69091, -69092, -69099, -73776, -73777, -73778, -69108, -73773, -73774, -73775);
-- INSERT INTO spell_script_names VALUES(69104, 'spell_icc_lk_summon_ice_sphere');
INSERT INTO spell_script_names VALUES(69110, 'spell_the_lich_king_ice_burst_target_search');

-- npc Ice Sphere (36633, 39305, 39306, 39307)
UPDATE creature_template SET modelid1=30243, modelid2=0, modelid3=0, modelid4=0, minlevel=80, maxlevel=80, exp=2, rank=3, faction=14, speed_walk=1.2, speed_run=0.428571, unit_flags=0, InhabitType=3, AIName='', mechanic_immune_mask=650854271, flags_extra=256+0x200000, ScriptName='npc_icc_ice_sphere' WHERE entry=36633;
UPDATE creature_template SET modelid1=30243, modelid2=0, modelid3=0, modelid4=0, minlevel=80, maxlevel=80, exp=2, rank=3, faction=14, speed_walk=1.2, speed_run=0.428571, unit_flags=0, InhabitType=3, AIName='', mechanic_immune_mask=650854271, flags_extra=256+0x200000, ScriptName='' WHERE entry=39305;
UPDATE creature_template SET modelid1=30243, modelid2=0, modelid3=0, modelid4=0, minlevel=80, maxlevel=80, exp=2, rank=3, faction=14, speed_walk=1.2, speed_run=0.428571, unit_flags=0, InhabitType=3, AIName='', mechanic_immune_mask=650854271, flags_extra=256+0x200000, ScriptName='' WHERE entry=39306;
UPDATE creature_template SET modelid1=30243, modelid2=0, modelid3=0, modelid4=0, minlevel=80, maxlevel=80, exp=2, rank=3, faction=14, speed_walk=1.2, speed_run=0.428571, unit_flags=0, InhabitType=3, AIName='', mechanic_immune_mask=650854271, flags_extra=256+0x200000, ScriptName='' WHERE entry=39307;
REPLACE INTO creature_template_addon VALUES(36633, 0, 0, 0, 0, 0, '69109'),(39305, 0, 0, 0, 0, 0, '69109'),(39306, 0, 0, 0, 0, 0, '69109'),(39307, 0, 0, 0, 0, 0, '69109');

-- spell Raging Spirit (69200), summon (69201), visual (69197), clone (69198)
DELETE FROM spell_script_names WHERE spell_id IN(69200, 69201, 69197, 69198, -69200, -69201, -69197, -69198);
DELETE FROM spell_scripts WHERE id IN(69200, 69201, 69197, 69198, -69200, -69201, -69197, -69198);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69200, 69201, 69197, 69198, -69200, -69201, -69197, -69198) OR spell_effect IN(69200, 69201, 69197, 69198, -69200, -69201, -69197, -69198);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(69200, 69201, 69197, 69198, -69200, -69201, -69197, -69198);
INSERT INTO spell_script_names VALUES(69200, 'spell_the_lich_king_raging_spirit');

-- npc Raging Spirit (36701, 39302, 39303, 39304)
UPDATE creature_template SET minlevel=83, maxlevel=83, exp=2, faction=14, speed_walk=2, speed_run=1.42857, rank=3, mindmg=3500, maxdmg=4000, attackpower=300, dmg_multiplier=9, baseattacktime=2000, unit_flags=0, AIName='', mechanic_immune_mask=650854271, flags_extra=0+0x200000, ScriptName='npc_raging_spirit' WHERE entry=36701;
UPDATE creature_template SET minlevel=83, maxlevel=83, exp=2, faction=14, speed_walk=2, speed_run=1.42857, rank=3, mindmg=3500, maxdmg=4000, attackpower=300, dmg_multiplier=16, baseattacktime=2000, unit_flags=0, AIName='', mechanic_immune_mask=650854271, flags_extra=0+0x200000, ScriptName='' WHERE entry=39302;
UPDATE creature_template SET minlevel=83, maxlevel=83, exp=2, faction=14, speed_walk=2, speed_run=1.42857, rank=3, mindmg=3500, maxdmg=4000, attackpower=300, dmg_multiplier=12, baseattacktime=2000, unit_flags=0, AIName='', mechanic_immune_mask=650854271, flags_extra=0+0x200000, ScriptName='' WHERE entry=39303;
UPDATE creature_template SET minlevel=83, maxlevel=83, exp=2, faction=14, speed_walk=2, speed_run=1.42857, rank=3, mindmg=3500, maxdmg=4000, attackpower=300, dmg_multiplier=20, baseattacktime=2000, unit_flags=0, AIName='', mechanic_immune_mask=650854271, flags_extra=0+0x200000, ScriptName='' WHERE entry=39304;
REPLACE INTO creature_template_addon VALUES(36701, 0, 0, 0, 1, 0, '72846 73878'),(39302, 0, 0, 0, 1, 0, '72846 73878'),(39303, 0, 0, 0, 1, 0, '72846 73878'),(39304, 0, 0, 0, 1, 0, '72846 73878');

-- spell Defile: summon (72762), aura (72743), dmg (72754, 73708, 73709, 73710), grow (72756, 74162, 74163, 74164)
DELETE FROM spell_script_names WHERE spell_id IN(72762, 72743, 72754, 73708, 73709, 73710, 72756, 74162, 74163, 74164, -72762, -72743, -72754, -73708, -73709, -73710, -72756, -74162, -74163, -74164);
DELETE FROM spell_scripts WHERE id IN(72762, 72743, 72754, 73708, 73709, 73710, 72756, 74162, 74163, 74164, -72762, -72743, -72754, -73708, -73709, -73710, -72756, -74162, -74163, -74164);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(72762, 72743, 72754, 73708, 73709, 73710, 72756, 74162, 74163, 74164, -72762, -72743, -72754, -73708, -73709, -73710, -72756, -74162, -74163, -74164) OR spell_effect IN(72762, 72743, 72754, 73708, 73709, 73710, 72756, 74162, 74163, 74164, -72762, -72743, -72754, -73708, -73709, -73710, -72756, -74162, -74163, -74164);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(72762, 72743, 72754, 73708, 73709, 73710, 72756, 74162, 74163, 74164, -72762, -72743, -72754, -73708, -73709, -73710, -72756, -74162, -74163, -74164);
INSERT INTO spell_script_names VALUES(72754, 'spell_the_lich_king_defile'),(73708, 'spell_the_lich_king_defile'),(73709, 'spell_the_lich_king_defile'),(73710, 'spell_the_lich_king_defile');

-- npc Defile (38757)
UPDATE creature_template SET difficulty_entry_1=0, difficulty_entry_2=0, difficulty_entry_3=0, modelid1=11686, modelid2=0, modelid3=0, modelid4=0, minlevel=83, maxlevel=83, exp=2, rank=3, faction=14, speed_walk=1.2, speed_run=0.428571, unit_flags=33554944, AIName='NullCreatureAI', mechanic_immune_mask=0, flags_extra=0, ScriptName='' WHERE entry=38757;
REPLACE INTO creature_template_addon VALUES(38757, 0, 0, 0, 0, 0, '72743');

-- spell Soul Reaper (69409, 73797, 73798, 73799), buff (69410)
DELETE FROM spell_script_names WHERE spell_id IN(69409, 73797, 73798, 73799, 69410, -69409, -73797, -73798, -73799, -69410);
DELETE FROM spell_scripts WHERE id IN(69409, 73797, 73798, 73799, 69410, -69409, -73797, -73798, -73799, -69410);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69409, 73797, 73798, 73799, 69410, -69409, -73797, -73798, -73799, -69410) OR spell_effect IN(69409, 73797, 73798, 73799, 69410, -69409, -73797, -73798, -73799, -69410);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(69409, 73797, 73798, 73799, 69410, -69409, -73797, -73798, -73799, -69410);
INSERT INTO spell_script_names VALUES(69409, 'spell_the_lich_king_soul_reaper'),(73797, 'spell_the_lich_king_soul_reaper'),(73798, 'spell_the_lich_king_soul_reaper'),(73799, 'spell_the_lich_king_soul_reaper');

-- spell Summon Val'kyr (69037), periodic (74361)
DELETE FROM spell_script_names WHERE spell_id IN(69037, 74361, -69037, -74361);
DELETE FROM spell_scripts WHERE id IN(69037, 74361, -69037, -74361);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69037, 74361, -69037, -74361) OR spell_effect IN(69037, 74361, -69037, -74361);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(69037, 74361, -69037, -74361);
INSERT INTO spell_script_names VALUES(69037, 'spell_the_lich_king_summon_into_air');

-- npc Val'kyr Shadowguard (36609, 39120, 39121, 39122)
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=2, rank=3, faction=14, speed_walk=1, speed_run=0.7, unit_flags=514, InhabitType=4, VehicleId=532, AIName='', mechanic_immune_mask=583742335, flags_extra=0x200000, ScriptName='npc_valkyr_shadowguard' WHERE entry=36609;
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=2, rank=3, faction=14, speed_walk=1, speed_run=0.7, unit_flags=514, InhabitType=4, VehicleId=532, AIName='', mechanic_immune_mask=583742335, flags_extra=0x200000, ScriptName='' WHERE entry=39120;
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=2, rank=3, faction=14, speed_walk=1, speed_run=0.8, unit_flags=514, InhabitType=4, VehicleId=532, AIName='', mechanic_immune_mask=583742335, flags_extra=0x200000, ScriptName='' WHERE entry=39121;
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=2, rank=3, faction=14, speed_walk=1, speed_run=0.8, unit_flags=514, InhabitType=4, VehicleId=532, AIName='', mechanic_immune_mask=583742335, flags_extra=0x200000, ScriptName='' WHERE entry=39122;
REPLACE INTO creature_template_addon VALUES(36609, 0, 0, 50331648, 0, 0, '74352'),(39120, 0, 0, 50331648, 0, 0, '74352'),(39121, 0, 0, 50331648, 0, 0, '74352'),(39122, 0, 0, 50331648, 0, 0, '74352');

-- spell Val'kyr Target Search (69030), charge (74399), carry (74445), eject (68576)
DELETE FROM spell_script_names WHERE spell_id IN(69030, 74399, 74445, -69030, -74399, -74445, 68576, -68576);
DELETE FROM spell_scripts WHERE id IN(69030, 74399, 74445, -69030, -74399, -74445, 68576, -68576);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69030, 74399, 74445, -69030, -74399, -74445, 68576, -68576) OR spell_effect IN(69030, 74399, 74445, -69030, -74399, -74445, 68576, -68576);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(69030, 74399, 74445, -69030, -74399, -74445, 68576, -68576);
INSERT INTO spell_script_names VALUES(69030, 'spell_the_lich_king_valkyr_target_search');
INSERT INTO spell_script_names VALUES(74445, 'spell_the_lich_king_cast_back_to_caster');
INSERT INTO spell_script_names VALUES(68576, 'spell_gen_eject_all_passengers');

-- spell Life Siphon (73488, 73782, 73783, 73784), heal (73489)
DELETE FROM spell_script_names WHERE spell_id IN(73488, 73782, 73783, 73784, 73489, -73488, -73782, -73783, -73784, -73489);
DELETE FROM spell_scripts WHERE id IN(73488, 73782, 73783, 73784, 73489, -73488, -73782, -73783, -73784, -73489);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(73488, 73782, 73783, 73784, 73489, -73488, -73782, -73783, -73784, -73489) OR spell_effect IN(73488, 73782, 73783, 73784, 73489, -73488, -73782, -73783, -73784, -73489);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(73488, 73782, 73783, 73784, 73489, -73488, -73782, -73783, -73784, -73489);
INSERT INTO spell_script_names VALUES(73488, 'spell_the_lich_king_life_siphon'),(73782, 'spell_the_lich_king_life_siphon'),(73783, 'spell_the_lich_king_life_siphon'),(73784, 'spell_the_lich_king_life_siphon');

-- spell Vile Spirits (70498), summon (70497), visual (70500, 70499)
DELETE FROM spell_script_names WHERE spell_id IN(70498, 70497, 70500, 70499, -70498, -70497, -70500, -70499);
DELETE FROM spell_scripts WHERE id IN(70498, 70497, 70500, 70499, -70498, -70497, -70500, -70499);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70498, 70497, 70500, 70499, -70498, -70497, -70500, -70499) OR spell_effect IN(70498, 70497, 70500, 70499, -70498, -70497, -70500, -70499);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70498, 70497, 70500, 70499, -70498, -70497, -70500, -70499);
INSERT INTO spell_script_names VALUES(70497, 'spell_the_lich_king_summon_into_air');
INSERT INTO spell_script_names VALUES(70498, 'spell_the_lich_king_vile_spirits');
INSERT INTO spell_script_names VALUES(70499, 'spell_the_lich_king_vile_spirits_visual');

-- spell Vile Spirits Move Target Search (70501), periodic trigger (70502), triggered (70534), burst (70503, 73806, 73807, 73808)
DELETE FROM spell_script_names WHERE spell_id IN(70501, 70502, 70534, 70503, 73806, 73807, 73808, -70501, -70502, -70534, -70503, -73806, -73807, -73808);
DELETE FROM spell_scripts WHERE id IN(70501, 70502, 70534, 70503, 73806, 73807, 73808, -70501, -70502, -70534, -70503, -73806, -73807, -73808);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70501, 70502, 70534, 70503, 73806, 73807, 73808, -70501, -70502, -70534, -70503, -73806, -73807, -73808) OR spell_effect IN(70501, 70502, 70534, 70503, 73806, 73807, 73808, -70501, -70502, -70534, -70503, -73806, -73807, -73808);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70501, 70502, 70534, 70503, 73806, 73807, 73808, -70501, -70502, -70534, -70503, -73806, -73807, -73808);
INSERT INTO spell_script_names VALUES(70501, 'spell_the_lich_king_vile_spirit_move_target_search');
INSERT INTO spell_script_names VALUES(70534, 'spell_the_lich_king_vile_spirit_damage_target_search');

-- npc Vile Spirit (37799, 39284, 39285, 39286)
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=2, rank=1, faction=14, speed_walk=2.8, speed_run=1, unit_flags=163904, InhabitType=5, AIName='', mechanic_immune_mask=583742335, flags_extra=0, ScriptName='npc_icc_lk_checktarget' WHERE entry=37799;
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=2, rank=1, faction=14, speed_walk=2.8, speed_run=1, unit_flags=163904, InhabitType=5, AIName='', mechanic_immune_mask=583742335, flags_extra=0, ScriptName='' WHERE entry=39284;
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=2, rank=1, faction=14, speed_walk=2.8, speed_run=1, unit_flags=163904, InhabitType=5, AIName='', mechanic_immune_mask=583742335, flags_extra=0, ScriptName='' WHERE entry=39285;
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=2, rank=1, faction=14, speed_walk=2.8, speed_run=1, unit_flags=163904, InhabitType=5, AIName='', mechanic_immune_mask=583742335, flags_extra=0, ScriptName='' WHERE entry=39286;
REPLACE INTO creature_template_addon VALUES(37799, 0, 0, 50331648, 0, 0, ''),(39284, 0, 0, 50331648, 0, 0, ''),(39285, 0, 0, 50331648, 0, 0, ''),(39286, 0, 0, 50331648, 0, 0, '');

-- spell Harvest Soul (68980, 74325, 74326, 74327), summon vehicle (68986)
DELETE FROM spell_script_names WHERE spell_id IN(68980, 74325, 74326, 74327, 68986, -68980, -74325, -74326, -74327, -68986);
DELETE FROM spell_scripts WHERE id IN(68980, 74325, 74326, 74327, 68986, -68980, -74325, -74326, -74327, -68986);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(68980, 74325, 74326, 74327, 68986, -68980, -74325, -74326, -74327, -68986) OR spell_effect IN(68980, 74325, 74326, 74327, 68986, -68980, -74325, -74326, -74327, -68986);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(68980, 74325, 74326, 74327, 68986, -68980, -74325, -74326, -74327, -68986);
INSERT INTO spell_script_names VALUES(68980, 'spell_the_lich_king_harvest_soul');
INSERT INTO spell_script_names VALUES(74325, 'spell_the_lich_king_harvest_soul');

-- npc Strangulate Vehicle (36598)
UPDATE creature_template SET difficulty_entry_1=0, difficulty_entry_2=0, difficulty_entry_3=0, modelid1=11686, modelid2=0, modelid3=0, modelid4=0, minlevel=83, maxlevel=83, exp=2, faction=35, speed_walk=1, speed_run=0.7, unit_flags=33554944, VehicleId=531, AIName='', InhabitType=4, mechanic_immune_mask=0, flags_extra=0, ScriptName='npc_strangulate_vehicle' WHERE entry=36598;
REPLACE INTO creature_template_addon VALUES(36598, 0, 0, 50331648, 0, 0, '');

-- spell Harvested Soul (72679, 74318, 74319, 74320)
DELETE FROM spell_script_names WHERE spell_id IN(72679, 74318, 74319, 74320, -72679, -74318, -74319, -74320);
DELETE FROM spell_scripts WHERE id IN(72679, 74318, 74319, 74320, -72679, -74318, -74319, -74320);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(72679, 74318, 74319, 74320, -72679, -74318, -74319, -74320) OR spell_effect IN(72679, 74318, 74319, 74320, -72679, -74318, -74319, -74320);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(72679, 74318, 74319, 74320, -72679, -74318, -74319, -74320);
INSERT INTO conditions VALUES (13, 3, 72679, 0, 0, 31, 0, 3, 36597, 0, 0, 0, 0, '', 'Harvested Soul - target The Lich King');
INSERT INTO conditions VALUES (13, 3, 74318, 0, 0, 31, 0, 3, 36597, 0, 0, 0, 0, '', 'Harvested Soul - target The Lich King');
INSERT INTO conditions VALUES (13, 3, 74319, 0, 0, 31, 0, 3, 36597, 0, 0, 0, 0, '', 'Harvested Soul - target The Lich King');
INSERT INTO conditions VALUES (13, 3, 74320, 0, 0, 31, 0, 3, 36597, 0, 0, 0, 0, '', 'Harvested Soul - target The Lich King');

-- spell Harvest Soul: trigger ride vehicle (68984), clone (71372, 76706), visual (71440, 76379), teleport (72546)
DELETE FROM spell_script_names WHERE spell_id IN(68984, 71372, 76706, 71440, 76379, -68984, -71372, -76706, -71440, -76379, 72546, -72546);
DELETE FROM spell_scripts WHERE id IN(68984, 71372, 76706, 71440, 76379, -68984, -71372, -76706, -71440, -76379, 72546, -72546);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(68984, 71372, 76706, 71440, 76379, -68984, -71372, -76706, -71440, -76379, 72546, -72546) OR spell_effect IN(68984, 71372, 76706, 71440, 76379, -68984, -71372, -76706, -71440, -76379, 72546, -72546);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(68984, 71372, 76706, 71440, 76379, -68984, -71372, -76706, -71440, -76379, 72546, -72546);
INSERT INTO spell_script_names VALUES (68984, 'spell_the_lich_king_cast_back_to_caster');
INSERT INTO conditions VALUES (13, 1, 71440, 0, 0, 31, 0, 3, 36597, 0, 0, 0, 0, '', 'Harvest Soul - target The Lich King');
INSERT INTO conditions VALUES (13, 1, 76379, 0, 0, 31, 0, 3, 36597, 0, 0, 0, 0, '', 'Harvest Soul - target The Lich King');
REPLACE INTO spell_target_position VALUES(72546, 1, 631, 514, -2523, 1050.99, 3.1765);

-- npc Terenas Menethil (36823) -- normal
UPDATE creature_template SET difficulty_entry_1=0, difficulty_entry_2=0, difficulty_entry_3=0, minlevel=80, maxlevel=80, exp=2, faction=1665, speed_walk=1, speed_run=1, rank=1, mindmg=3500, maxdmg=4000, attackpower=300, dmg_multiplier=4.5, baseattacktime=2000, unit_flags=32832, AIName='', mechanic_immune_mask=0, flags_extra=0, RegenHealth=0, ScriptName='npc_terenas_menethil' WHERE entry=36823;
REPLACE INTO creature_template_addon VALUES(36823, 0, 0, 0, 0, 0, '72372 69382');

-- npc Spirit Warden (36824, 39296)
UPDATE creature_template SET minlevel=83, maxlevel=83, exp=2, faction=14, speed_walk=1, speed_run=1, rank=1, mindmg=3500, maxdmg=4000, attackpower=300, dmg_multiplier=3, baseattacktime=2000, unit_flags=0, AIName='', mechanic_immune_mask=8388624, flags_extra=256, RegenHealth=0, ScriptName='npc_spirit_warden' WHERE entry=36824;
UPDATE creature_template SET minlevel=83, maxlevel=83, exp=2, faction=14, speed_walk=1, speed_run=1, rank=1, mindmg=3500, maxdmg=4000, attackpower=300, dmg_multiplier=3, baseattacktime=2000, unit_flags=0, AIName='', mechanic_immune_mask=8388624, flags_extra=256, RegenHealth=0, ScriptName='' WHERE entry=39296;
REPLACE INTO creature_template_addon VALUES(36824, 0, 0, 0, 0, 0, '69383'),(39296, 0, 0, 0, 0, 0, '69383');
REPLACE INTO creature_model_info VALUES(31471, 2, 3, 2, 0);

-- spell Light's Favor (69382), Restore Soul (72595), Destroy Soul (74086), tele back (72597)
DELETE FROM spell_script_names WHERE spell_id IN(69382, -69382, 72595, -72595, 74086, -74086, 72597, -72597);
DELETE FROM spell_scripts WHERE id IN(69382, -69382, 72595, -72595, 74086, -74086, 72597, -72597);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69382, -69382, 72595, -72595, 74086, -74086, 72597, -72597) OR spell_effect IN(69382, -69382, 72595, -72595, 74086, -74086, 72597, -72597);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(69382, -69382, 72595, -72595, 74086, -74086, 72597, -72597);
INSERT INTO spell_script_names VALUES(69382, 'spell_the_lich_king_lights_favor');
INSERT INTO spell_script_names VALUES(72595, 'spell_the_lich_king_restore_soul');
INSERT INTO conditions VALUES (13, 1, 72595, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Restore Soul - target player');
INSERT INTO conditions VALUES (13, 1, 74086, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Destroy Soul - target player');

-- spell Dark Hunger (69383), heal (69384)
-- spell Soul Rip (69397), dmg (69398)
DELETE FROM spell_script_names WHERE spell_id IN(69383, 69384, -69383, -69384, 69397, -69397, 69398, -69398);
DELETE FROM spell_scripts WHERE id IN(69383, 69384, -69383, -69384, 69397, -69397, 69398, -69398);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69383, 69384, -69383, -69384, 69397, -69397, 69398, -69398) OR spell_effect IN(69383, 69384, -69383, -69384, 69397, -69397, 69398, -69398);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(69383, 69384, -69383, -69384, 69397, -69397, 69398, -69398);
INSERT INTO spell_script_names VALUES(69383, 'spell_the_lich_king_dark_hunger');
INSERT INTO spell_script_names VALUES(69397, 'spell_the_lich_king_soul_rip');

-- spell Harvest Souls (73654, 74295, 74296, 74297)
-- spell Restore Souls (73650)
DELETE FROM spell_script_names WHERE spell_id IN(73654, 74295, 74296, 74297, -73654, -74295, -74296, -74297, 73650, -73650);
DELETE FROM spell_scripts WHERE id IN(73654, 74295, 74296, 74297, -73654, -74295, -74296, -74297, 73650, -73650);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(73654, 74295, 74296, 74297, -73654, -74295, -74296, -74297, 73650, -73650) OR spell_effect IN(73654, 74295, 74296, 74297, -73654, -74295, -74296, -74297, 73650, -73650);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(73654, 74295, 74296, 74297, -73654, -74295, -74296, -74297, 73650, -73650);
INSERT INTO spell_script_names VALUES(73650, 'spell_the_lich_king_restore_soul');
INSERT INTO spell_script_names VALUES(74296, 'spell_the_lich_king_harvest_soul');
INSERT INTO spell_script_names VALUES(74297, 'spell_the_lich_king_harvest_soul');
INSERT INTO conditions VALUES (13, 1, 73650, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Restore Souls - target players');

-- spell Harvest Souls (73655) -- teleport and damage aura
DELETE FROM spell_script_names WHERE spell_id IN(73655, -73655);
DELETE FROM spell_scripts WHERE id IN(73655, -73655);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(73655, -73655) OR spell_effect IN(73655, -73655);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(73655, -73655);
REPLACE INTO spell_target_position VALUES(73655, 1, 631, 495.708, -2523.76, 1050.99, 3.1765);
INSERT INTO spell_script_names VALUES(73655, 'spell_the_lich_king_teleport_to_frostmourne_hc');

-- npc Terenas Menethil (39217) -- heroic
UPDATE creature_template SET difficulty_entry_1=0, difficulty_entry_2=0, difficulty_entry_3=0, minlevel=80, maxlevel=80, exp=2, faction=1665, speed_walk=1, speed_run=1, rank=1, mindmg=3500, maxdmg=4000, attackpower=300, dmg_multiplier=3, baseattacktime=2000, unit_flags=32836, AIName='', mechanic_immune_mask=0, flags_extra=0, RegenHealth=0, ScriptName='npc_terenas_menethil' WHERE entry=39217;
REPLACE INTO creature_template_addon VALUES(39217, 0, 0, 0, 0, 0, '72372 69382');

-- Wicked Spirit (39190, 39287, 39288, 39289)
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=2, rank=1, faction=14, speed_walk=1.55, speed_run=0.55, unit_flags=163904, InhabitType=4, AIName='', mechanic_immune_mask=650854271, flags_extra=256+0x200000, ScriptName='npc_lk_wicked_spirit' WHERE entry=39190;
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=2, rank=1, faction=14, speed_walk=1.55, speed_run=0.55, unit_flags=163904, InhabitType=4, AIName='', mechanic_immune_mask=650854271, flags_extra=256+0x200000, ScriptName='' WHERE entry IN(39287, 39288, 39289);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(39190, 39287, 39288, 39289) AND `map`=631 );
DELETE FROM creature WHERE id IN(39190, 39287, 39288, 39289) AND `map`=631;
INSERT INTO `creature` VALUES (NULL, 39190, 631, 12, 1, 0, 0, 491.717, -2532.49, 1069.6, 0, 10, 10, 0, 1, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 39190, 631, 12, 1, 0, 0, 494.29, -2511.38, 1069.6, 0, 10, 10, 0, 1, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 39190, 631, 12, 1, 0, 0, 485.03, -2527.72, 1069.6, 0, 10, 10, 0, 1, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 39190, 631, 12, 1, 0, 0, 490.413, -2504.32, 1069.6, 0, 10, 10, 0, 1, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 39190, 631, 12, 1, 0, 0, 484.793, -2533.59, 1069.6, 0, 10, 10, 0, 1, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 39190, 631, 12, 1, 0, 0, 500.898, -2527.2, 1069.6, 0, 10, 10, 0, 1, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 39190, 631, 12, 1, 0, 0, 511.632, -2522.37, 1069.6, 0, 10, 10, 0, 1, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 39190, 631, 12, 1, 0, 0, 489.01, -2538.53, 1069.6, 0, 10, 10, 0, 1, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 39190, 631, 12, 1, 0, 0, 478.977, -2517.45, 1069.6, 0, 10, 10, 0, 1, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 39190, 631, 12, 1, 0, 0, 518.748, -2521.24, 1069.6, 0, 10, 10, 0, 1, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 39190, 631, 12, 1, 0, 0, 502.681, -2522.54, 1069.6, 0, 10, 10, 0, 1, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 39190, 631, 12, 1, 0, 0, 513.71, -2530.93, 1069.6, 0, 10, 10, 0, 1, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 39190, 631, 12, 1, 0, 0, 499.641, -2500.78, 1069.66, 0, 10, 10, 0, 1, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 39190, 631, 12, 1, 0, 0, 513.88, -2511.79, 1069.6, 0, 10, 10, 0, 1, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 39190, 631, 12, 1, 0, 0, 486.663, -2517.75, 1069.6, 0, 10, 10, 0, 1, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 39190, 631, 12, 1, 0, 0, 500.081, -2523.29, 1069.6, 0, 10, 10, 0, 1, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 39190, 631, 12, 1, 0, 0, 481.538, -2527.33, 1069.6, 0, 10, 10, 0, 1, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 39190, 631, 12, 1, 0, 0, 481.302, -2509.22, 1069.6, 0, 10, 10, 0, 1, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 39190, 631, 12, 1, 0, 0, 506.871, -2515.55, 1069.6, 0, 10, 10, 0, 1, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 39190, 631, 12, 1, 0, 0, 495.363, -2538.22, 1069.6, 0, 10, 10, 0, 1, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 39190, 631, 12, 1, 0, 0, 503.825, -2508.14, 1069.6, 0, 10, 10, 0, 1, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 39190, 631, 12, 1, 0, 0, 502.649, -2531.33, 1069.6, 0, 10, 10, 0, 1, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 39190, 631, 12, 1, 0, 0, 505.156, -2536.86, 1069.6, 0, 10, 10, 0, 1, 0, 1, 0, 0, 0);
REPLACE INTO creature_template_addon VALUES(39190, 0, 0, 50331648, 0, 0, ''),(39287, 0, 0, 50331648, 0, 0, ''),(39288, 0, 0, 50331648, 0, 0, ''),(39289, 0, 0, 50331648, 0, 0, '');

-- spell Summon Spirit Bomb (73581, tr 73579), Summon Spirit Bomb (74299), tr (74302, 74341, 74342, 74343), 74300
DELETE FROM spell_script_names WHERE spell_id IN(73581, 73579, 74299, 74302, 74341, 74342, 74343, 74300, -73581, -73579, -74299, -74302, -74341, -74342, -74343, -74300);
DELETE FROM spell_scripts WHERE id IN(73581, 73579, 74299, 74302, 74341, 74342, 74343, 74300, -73581, -73579, -74299, -74302, -74341, -74342, -74343, -74300);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(73581, 73579, 74299, 74302, 74341, 74342, 74343, 74300, -73581, -73579, -74299, -74302, -74341, -74342, -74343, -74300) OR spell_effect IN(73581, 73579, 74299, 74302, 74341, 74342, 74343, 74300, -73581, -73579, -74299, -74302, -74341, -74342, -74343, -74300);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(73581, 73579, 74299, 74302, 74341, 74342, 74343, 74300, -73581, -73579, -74299, -74302, -74341, -74342, -74343, -74300);
INSERT INTO spell_script_names VALUES(73579, 'spell_the_lich_king_summon_into_air');
INSERT INTO spell_script_names VALUES(74300, 'spell_the_lich_king_summon_into_air');
INSERT INTO spell_script_names VALUES(74302, 'spell_the_lich_king_summon_spirit_bomb');
INSERT INTO spell_script_names VALUES(74341, 'spell_the_lich_king_summon_spirit_bomb');
INSERT INTO spell_script_names VALUES(74342, 'spell_the_lich_king_summon_spirit_bomb');
INSERT INTO spell_script_names VALUES(74343, 'spell_the_lich_king_summon_spirit_bomb');

-- npc Spirit Bomb (39189)
UPDATE creature_template SET difficulty_entry_1=0, difficulty_entry_2=0, difficulty_entry_3=0, modelid1=11686, modelid2=0, modelid3=0, modelid4=0, minlevel=82, maxlevel=82, exp=2, faction=14, speed_walk=1.4, speed_run=0.5, rank=3, unit_flags=33554432, AIName='', InhabitType=4, mechanic_immune_mask=0, flags_extra=0, ScriptName='npc_lk_spirit_bomb' WHERE entry=39189;
REPLACE INTO creature_template_addon VALUES(39189, 0, 0, 50331648, 0, 0, '73572');

-- spell Trigger Vile Spirit (Inside, Heroic) (73582), explosion (73576, 73803, 73804, 73805), spirit bomb visual (73572)
DELETE FROM spell_script_names WHERE spell_id IN(73582, 73576, 73803, 73804, 73805, 73572, -73582, -73576, -73803, -73804, -73805, -73572);
DELETE FROM spell_scripts WHERE id IN(73582, 73576, 73803, 73804, 73805, 73572, -73582, -73576, -73803, -73804, -73805, -73572);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(73582, 73576, 73803, 73804, 73805, 73572, -73582, -73576, -73803, -73804, -73805, -73572) OR spell_effect IN(73582, 73576, 73803, 73804, 73805, 73572, -73582, -73576, -73803, -73804, -73805, -73572);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(73582, 73576, 73803, 73804, 73805, 73572, -73582, -73576, -73803, -73804, -73805, -73572);
INSERT INTO spell_script_names VALUES (73582, 'spell_the_lich_king_trigger_vile_spirit');
INSERT INTO conditions VALUES (13, 1, 73582, 0, 0, 31, 0, 3, 39190, 0, 0, 0, 0, '', 'Trigger Vile Spirit (Inside, Heroic) - target Wicked Spirit');

-- spell Kill Frostmourne Players (75127), In Frostmourne Room (74276)
DELETE FROM spell_script_names WHERE ScriptName='spell_the_lich_king_in_frostmourne_room' AND spell_id=74276;
-- not needed

-- ###################
-- ### MISC FIXES
-- ###################

-- Highlord Tirion Fordring (37119)
UPDATE creature_template SET unit_flags=unit_flags|0x300 WHERE entry=37119;

-- Alana Moonstrike <Druid Armor> (37999)
-- Tortunok <Druid Armor> (37992)
DELETE FROM gossip_menu WHERE entry=11095;
INSERT INTO gossip_menu VALUES (11095, 15445);
DELETE FROM gossip_menu_option WHERE menu_id=11095;
INSERT INTO gossip_menu_option VALUES (11095, 0, 1, 'I want to browse your goods', 3, 128, 0, 0, 0, 0, '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=11095;
INSERT INTO conditions VALUES (15, 11095, 0, 0, 0, 15, 0, 1024, 0, 0, 0, 0, 0, '', 'Require Druid To Show Gossip');
UPDATE creature_template SET unit_flags=unit_flags|0x300, gossip_menu_id=11095, npcflag=4225 WHERE entry IN(37999, 37992);

-- Malfus Grimfrost <Mage Armor> (38283)
-- Uvlus Banefire <Mage Armor> (38284)
DELETE FROM gossip_menu WHERE entry=11103;
INSERT INTO gossip_menu VALUES (11103, 15453);
DELETE FROM gossip_menu_option WHERE menu_id=11103;
INSERT INTO gossip_menu_option VALUES (11103, 0, 1, 'I want to browse your goods', 3, 128, 0, 0, 0, 0, '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=11103;
INSERT INTO conditions VALUES (15, 11103, 0, 0, 0, 15, 0, 128, 0, 0, 0, 0, 0, '', 'Require Mage To Show Gossip');
UPDATE creature_template SET unit_flags=unit_flags|0x300, gossip_menu_id=11103, npcflag=4225 WHERE entry IN(38283, 38284);

-- Crusader Grimtong <Warrior Armor> (37688)
DELETE FROM gossip_menu WHERE entry=11100;
INSERT INTO gossip_menu VALUES (11100, 15450);
DELETE FROM gossip_menu_option WHERE menu_id=11100;
INSERT INTO gossip_menu_option VALUES (11100, 0, 1, 'I want to browse your goods', 3, 128, 0, 0, 0, 0, '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=11100;
INSERT INTO conditions VALUES (15, 11100, 0, 0, 0, 15, 0, 1, 0, 0, 0, 0, 0, '', 'Require Warrior To Show Gossip');
UPDATE creature_template SET unit_flags=unit_flags|0x300, gossip_menu_id=11100, npcflag=4225 WHERE entry=37688;

-- Ormus the Penitent <Death Knight Armor> (38316)
REPLACE INTO creature_template_addon VALUES (38316, 0, 0, 0, 4097, 233, '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=10996;
INSERT INTO conditions VALUES (15, 10996, 5, 0, 0, 15, 0, 32, 0, 0, 0, 0, 0, '', 'Require Death Knight To Show Gossip');

-- Niby the Almighty <Warlock Armor> (38182)
-- Haragg the Unseen <Warlock Armor> (38181)
DELETE FROM gossip_menu WHERE entry=11104;
INSERT INTO gossip_menu VALUES (11104, 15454);
DELETE FROM gossip_menu_option WHERE menu_id=11104;
INSERT INTO gossip_menu_option VALUES (11104, 0, 1, 'I want to browse your goods', 3, 128, 0, 0, 0, 0, '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=11104;
INSERT INTO conditions VALUES (15, 11104, 0, 0, 0, 15, 0, 256, 0, 0, 0, 0, 0, '', 'Require Warlock To Show Gossip');
UPDATE creature_template SET unit_flags=unit_flags|0x300, gossip_menu_id=11104, npcflag=4225 WHERE entry IN(38182, 38181);

-- Yili <Rogue Armor> (37997)
-- Ikfirus the Vile <Rogue Armor> (37991)
DELETE FROM gossip_menu WHERE entry=11098;
INSERT INTO gossip_menu VALUES (11098, 15447);
DELETE FROM gossip_menu_option WHERE menu_id=11098;
INSERT INTO gossip_menu_option VALUES (11098, 0, 1, 'I want to browse your goods', 3, 128, 0, 0, 0, 0, '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=11098;
INSERT INTO conditions VALUES (15, 11098, 0, 0, 0, 15, 0, 8, 0, 0, 0, 0, 0, '', 'Require Rogue To Show Gossip');
UPDATE creature_template SET unit_flags=unit_flags|0x300, gossip_menu_id=11098, npcflag=4225 WHERE entry IN(37997, 37991);

-- Scott the Merciful <Priest Armor> (38054)
DELETE FROM gossip_menu WHERE entry=11102;
INSERT INTO gossip_menu VALUES (11102, 15452);
DELETE FROM gossip_menu_option WHERE menu_id=11102;
INSERT INTO gossip_menu_option VALUES (11102, 0, 1, 'I want to browse your goods', 3, 128, 0, 0, 0, 0, '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=11102;
INSERT INTO conditions VALUES (15, 11102, 0, 0, 0, 15, 0, 16, 0, 0, 0, 0, 0, '', 'Require Priest To Show Gossip');
UPDATE creature_template SET unit_flags=unit_flags|0x300, gossip_menu_id=11102, npcflag=4225 WHERE entry=38054;

-- Talan Moonstrike <Hunter Armor> (37998)
-- Gerardo the Suave <Hunter Armor> (37993)
REPLACE INTO creature_template_addon VALUES (37998, 0, 0, 0, 4098, 0, '');
REPLACE INTO creature_template_addon VALUES (37993, 0, 0, 0, 4098, 0, '');
DELETE FROM gossip_menu WHERE entry=11099;
INSERT INTO gossip_menu VALUES (11099, 15449);
DELETE FROM gossip_menu_option WHERE menu_id=11099;
INSERT INTO gossip_menu_option VALUES (11099, 0, 1, 'I want to browse your goods', 3, 128, 0, 0, 0, 0, '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=11099;
INSERT INTO conditions VALUES (15, 11099, 0, 0, 0, 15, 0, 4, 0, 0, 0, 0, 0, '', 'Require Hunter To Show Gossip');
UPDATE creature_template SET unit_flags=unit_flags|0x300, gossip_menu_id=11099, npcflag=4225 WHERE entry IN(37998, 37993);

-- Jedebia <Shaman Armor> (38840)
-- Vol'guk <Shaman Armor> (38841)
DELETE FROM gossip_menu WHERE entry=11097;
INSERT INTO gossip_menu VALUES (11097, 15446);
DELETE FROM gossip_menu_option WHERE menu_id=11097;
INSERT INTO gossip_menu_option VALUES (11097, 0, 1, 'I want to browse your goods', 3, 128, 0, 0, 0, 0, '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=11097;
INSERT INTO conditions VALUES (15, 11097, 0, 0, 0, 15, 0, 64, 0, 0, 0, 0, 0, '', 'Require Shaman To Show Gossip');
UPDATE creature_template SET unit_flags=unit_flags|0x300, gossip_menu_id=11097, npcflag=4225 WHERE entry IN(38840, 38841);

-- Crusader Halford <Paladin Armor> (37696)
DELETE FROM gossip_menu WHERE entry=11101;
INSERT INTO gossip_menu VALUES (11101, 15451);
DELETE FROM gossip_menu_option WHERE menu_id=11101;
INSERT INTO gossip_menu_option VALUES (11101, 0, 1, 'I want to browse your goods', 3, 2, 0, 0, 0, 0, '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=11101;
INSERT INTO conditions VALUES (15, 11101, 0, 0, 0, 15, 0, 2, 0, 0, 0, 0, 0, '', 'Require Paladin To Show Gossip');
REPLACE INTO creature_equip_template VALUES (37696, 2, 39371, 0, 0, 0);
UPDATE creature_template SET unit_flags=unit_flags|0x300, gossip_menu_id=11101, npcflag=4225, AIName='SmartAI', ScriptName='' WHERE entry=37696;
DELETE FROM smart_scripts WHERE entryorguid=37696 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=37696*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (37696, 0, 0, 0, 60, 0, 100, 0, 0, 0, 120000, 120000, 80, 37696*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Halford - On Update - Run Script');
INSERT INTO smart_scripts VALUES (37696, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Halford - On Reset - Set Walk');
INSERT INTO smart_scripts VALUES (37696*100, 9, 0, 0, 60, 0, 100, 0, 0, 0, 0, 0, 139, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Halford - Script9 - Load Equipment');
INSERT INTO smart_scripts VALUES (37696*100, 9, 1, 0, 60, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 1, 0, 0, 0, 8, 0, 0, 0, -63.32, 2227.71, 27.903, 0, 'Crusader Halford - Script9 - Move to Point');
INSERT INTO smart_scripts VALUES (37696*100, 9, 2, 0, 60, 0, 100, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Halford - Script9 - Set Emote State');
INSERT INTO smart_scripts VALUES (37696*100, 9, 3, 0, 60, 0, 100, 0, 2500, 2500, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 5.57, 'Crusader Halford - Script9 - Set Orientation');
INSERT INTO smart_scripts VALUES (37696*100, 9, 4, 0, 60, 0, 100, 0, 0, 0, 0, 0, 17, 379, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Halford - Script9 - Set Emote State');
INSERT INTO smart_scripts VALUES (37696*100, 9, 5, 0, 60, 0, 100, 0, 20000, 20000, 0, 0, 69, 1, 0, 1, 0, 0, 0, 8, 0, 0, 0, -61.33, 2231.44, 27.99, 0, 'Crusader Halford - Script9 - Move to Point');
INSERT INTO smart_scripts VALUES (37696*100, 9, 6, 0, 60, 0, 100, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Halford - Script9 - Set Emote State');
INSERT INTO smart_scripts VALUES (37696*100, 9, 7, 0, 60, 0, 100, 0, 2500, 2500, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 5.93, 'Crusader Halford - Script9 - Set Orientation');
INSERT INTO smart_scripts VALUES (37696*100, 9, 8, 0, 60, 0, 100, 0, 0, 0, 0, 0, 17, 233, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Halford - Script9 - Set Emote State');
INSERT INTO smart_scripts VALUES (37696*100, 9, 9, 0, 60, 0, 100, 0, 0, 0, 0, 0, 139, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Halford - Script9 - Load Equipment');
INSERT INTO smart_scripts VALUES (37696*100, 9, 10, 0, 60, 0, 100, 0, 45000, 45000, 0, 0, 69, 1, 0, 1, 0, 0, 0, 8, 0, 0, 0, -59.76, 2234.12, 27.903, 0, 'Crusader Halford - Script9 - Move to Point');
INSERT INTO smart_scripts VALUES (37696*100, 9, 11, 0, 60, 0, 100, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Halford - Script9 - Set Emote State');
INSERT INTO smart_scripts VALUES (37696*100, 9, 12, 0, 60, 0, 100, 0, 0, 0, 0, 0, 139, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Halford - Script9 - Load Equipment');
INSERT INTO smart_scripts VALUES (37696*100, 9, 13, 0, 60, 0, 100, 0, 1600, 1600, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 2.917, 'Crusader Halford - Script9 - Set Orientation');
INSERT INTO smart_scripts VALUES (37696*100, 9, 14, 0, 60, 0, 100, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Halford - Script9 - Set Emote State');
INSERT INTO smart_scripts VALUES (37696*100, 9, 15, 0, 60, 0, 100, 0, 1500, 1500, 0, 0, 11, 46400, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Halford - Script9 - Cast Steam Weapon');
INSERT INTO smart_scripts VALUES (37696*100, 9, 16, 0, 60, 0, 100, 0, 4000, 4000, 0, 0, 69, 1, 0, 1, 0, 0, 0, 8, 0, 0, 0, -61.33, 2231.44, 27.99, 0, 'Crusader Halford - Script9 - Move to Point');
INSERT INTO smart_scripts VALUES (37696*100, 9, 17, 0, 60, 0, 100, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Halford - Script9 - Set Emote State');
INSERT INTO smart_scripts VALUES (37696*100, 9, 18, 0, 60, 0, 100, 0, 1600, 1600, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 5.93, 'Crusader Halford - Script9 - Set Orientation');
INSERT INTO smart_scripts VALUES (37696*100, 9, 19, 0, 60, 0, 100, 0, 0, 0, 0, 0, 17, 233, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Halford - Script9 - Set Emote State');
INSERT INTO smart_scripts VALUES (37696*100, 9, 20, 0, 60, 0, 100, 0, 0, 0, 0, 0, 139, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Halford - Script9 - Load Equipment');

-- SPELL Steam Weapon (46400)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=46400;
INSERT INTO conditions VALUES (13, 1, 46400, 0, 0, 31, 0, 3, 26043, 0, 0, 0, 0, '', 'Target Steam Burst');

-- ###################
-- ### SHADOWMOURNE, QUESTS
-- ###################

DELETE FROM spell_script_names WHERE ScriptName='spell_sindragosa_frost_breath';
DELETE FROM spell_script_names WHERE spell_id IN(71168, 71169, 71516, 71518, 72132, 72154, 72934, 72289, 72290, 72292, -71168, -71169, -71516, -71518, -72132, -72154, -72934, -72289, -72290, -72292);
DELETE FROM spell_scripts WHERE id IN(71168, 71169, 71516, 71518, 72132, 72154, 72934, 72289, 72290, 72292, -71168, -71169, -71516, -71518, -72132, -72154, -72934, -72289, -72290, -72292);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71168, 71169, 71516, 71518, 72132, 72154, 72934, 72289, 72290, 72292, -71168, -71169, -71516, -71518, -72132, -72154, -72934, -72289, -72290, -72292) OR spell_effect IN(71168, 71169, 71516, 71518, 72132, 72154, 72934, 72289, 72290, 72292, -71168, -71169, -71516, -71518, -72132, -72154, -72934, -72289, -72290, -72292);
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(13, 17) AND SourceEntry IN(71168, 71169, 71516, 71518, 72132, 72154, 72934, 72289, 72290, 72292, -71168, -71169, -71516, -71518, -72132, -72154, -72934, -72289, -72290, -72292);
INSERT INTO spell_script_names VALUES (71168, 'spell_item_unsated_craving');
INSERT INTO spell_script_names VALUES (71169, 'spell_item_shadows_fate');
INSERT INTO spell_script_names VALUES (69649, 'spell_sindragosa_frost_breath'),(71056,'spell_sindragosa_frost_breath'),(71057,'spell_sindragosa_frost_breath'),(71058,'spell_sindragosa_frost_breath'),(73061,'spell_sindragosa_frost_breath'),(73062,'spell_sindragosa_frost_breath'),(73063,'spell_sindragosa_frost_breath'),(73064,'spell_sindragosa_frost_breath');

DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=71952;

DELETE FROM conditions WHERE SourceTypeOrReferenceId=1 AND SourceEntry=51315;
INSERT INTO conditions VALUES (1, 36597, 51315, 0, 1, 2, 0, 51315, 1, 1, 1, 0, 0, '', "Sealed Chest will drop only if the player doesn't have it already");
INSERT INTO conditions VALUES (1, 36597, 51315, 0, 1, 3, 0, 49623, 0, 0, 0, 0, 0, '', "Sealed Chest will drop only if the player is wielding Shadowmourne");
INSERT INTO conditions VALUES (1, 36597, 51315, 0, 1, 8, 0, 24748, 0, 0, 1, 0, 0, '', "Sealed Chest will drop only if the player has The Lich King's Last Stand in their quest log");
INSERT INTO conditions VALUES (1, 36597, 51315, 0, 1, 14, 0, 24748, 0, 0, 1, 0, 0, '', "Sealed Chest will drop only if the player has The Lich King's Last Stand in their quest log");
INSERT INTO conditions VALUES (1, 36597, 51315, 0, 1, 14, 0, 24914, 0, 0, 0, 0, 0, '', "Sealed Chest will drop only if the player has not completed the quest Personal Property");

INSERT INTO conditions VALUES (1, 39167, 51315, 0, 1, 2, 0, 51315, 1, 1, 1, 0, 0, '', "Sealed Chest will drop only if the player doesn't have it already");
INSERT INTO conditions VALUES (1, 39167, 51315, 0, 1, 3, 0, 49623, 0, 0, 0, 0, 0, '', "Sealed Chest will drop only if the player is wielding Shadowmourne");
INSERT INTO conditions VALUES (1, 39167, 51315, 0, 1, 8, 0, 24748, 0, 0, 1, 0, 0, '', "Sealed Chest will drop only if the player has The Lich King's Last Stand in their quest log");
INSERT INTO conditions VALUES (1, 39167, 51315, 0, 1, 14, 0, 24748, 0, 0, 1, 0, 0, '', "Sealed Chest will drop only if the player has The Lich King's Last Stand in their quest log");
INSERT INTO conditions VALUES (1, 39167, 51315, 0, 1, 14, 0, 24914, 0, 0, 0, 0, 0, '', "Sealed Chest will drop only if the player has not completed the quest Personal Property");

INSERT INTO conditions VALUES (1, 39168, 51315, 0, 1, 2, 0, 51315, 1, 1, 1, 0, 0, '', "Sealed Chest will drop only if the player doesn't have it already");
INSERT INTO conditions VALUES (1, 39168, 51315, 0, 1, 3, 0, 49623, 0, 0, 0, 0, 0, '', "Sealed Chest will drop only if the player is wielding Shadowmourne");
INSERT INTO conditions VALUES (1, 39168, 51315, 0, 1, 8, 0, 24748, 0, 0, 1, 0, 0, '', "Sealed Chest will drop only if the player has The Lich King's Last Stand in their quest log");
INSERT INTO conditions VALUES (1, 39168, 51315, 0, 1, 14, 0, 24748, 0, 0, 1, 0, 0, '', "Sealed Chest will drop only if the player has The Lich King's Last Stand in their quest log");
INSERT INTO conditions VALUES (1, 39168, 51315, 0, 1, 14, 0, 24914, 0, 0, 0, 0, 0, '', "Sealed Chest will drop only if the player has not completed the quest Personal Property");

INSERT INTO conditions VALUES (1, 39166, 51315, 0, 1, 2, 0, 51315, 1, 1, 1, 0, 0, '', "Sealed Chest will drop only if the player doesn't have it already");
INSERT INTO conditions VALUES (1, 39166, 51315, 0, 1, 3, 0, 49623, 0, 0, 0, 0, 0, '', "Sealed Chest will drop only if the player is wielding Shadowmourne");
INSERT INTO conditions VALUES (1, 39166, 51315, 0, 1, 8, 0, 24748, 0, 0, 1, 0, 0, '', "Sealed Chest will drop only if the player has The Lich King's Last Stand in their quest log");
INSERT INTO conditions VALUES (1, 39166, 51315, 0, 1, 14, 0, 24748, 0, 0, 1, 0, 0, '', "Sealed Chest will drop only if the player has The Lich King's Last Stand in their quest log");
INSERT INTO conditions VALUES (1, 39166, 51315, 0, 1, 14, 0, 24914, 0, 0, 0, 0, 0, '', "Sealed Chest will drop only if the player has not completed the quest Personal Property");


-- ###################
-- ### LOOT FIXUPS
-- ###################

-- Vanquisher's Mark of Sanctification (52025) -- normal
-- Vanquisher's Mark of Sanctification (52028) -- heroic
-- Protector's Mark of Sanctification (52026) -- normal
-- Protector's Mark of Sanctification (52029) -- heroic
-- Conqueror's Mark of Sanctification (52027) -- normal
-- Conqueror's Mark of Sanctification (52030) -- heroic

DELETE FROM creature_loot_template WHERE minCountOrRef IN(-34278, -34279);
DELETE FROM gameobject_loot_template WHERE  minCountOrRef IN(-34278, -34279);
DELETE FROM reference_loot_template WHERE entry IN(34278, 34279);
INSERT INTO reference_loot_template VALUES (34278, 52025, 0, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (34278, 52026, 0, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (34278, 52027, 0, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (34279, 52028, 0, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (34279, 52029, 0, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (34279, 52030, 0, 1, 1, 1, 1);
SET @itemid = 0;

-- Blood-Queen Lana'thel (37955, 38434, 38435, 38436)
SELECT @itemid := IFNULL(MAX(item), 0) FROM creature_loot_template WHERE entry=38434 AND item<10;
INSERT INTO creature_loot_template VALUES(38434, @itemid+1, 100, 1, 0, -34278, 2);
SELECT @itemid := IFNULL(MAX(item), 0) FROM creature_loot_template WHERE entry=38435 AND item<10;
INSERT INTO creature_loot_template VALUES(38435, @itemid+1, 100, 1, 0, -34278, 1);
SELECT @itemid := IFNULL(MAX(item), 0) FROM creature_loot_template WHERE entry=38436 AND item<10;
INSERT INTO creature_loot_template VALUES(38436, @itemid+1, 100, 1, 0, -34278, 2);
INSERT INTO creature_loot_template VALUES(38436, @itemid+2, 100, 1, 0, -34279, 1);

-- Professor Putricide (36678, 38431, 38585, 38586)
SELECT @itemid := IFNULL(MAX(item), 0) FROM creature_loot_template WHERE entry=38431 AND item<10;
INSERT INTO creature_loot_template VALUES(38431, @itemid+1, 100, 1, 0, -34278, 2);
SELECT @itemid := IFNULL(MAX(item), 0) FROM creature_loot_template WHERE entry=38585 AND item<10;
INSERT INTO creature_loot_template VALUES(38585, @itemid+1, 100, 1, 0, -34278, 1);
SELECT @itemid := IFNULL(MAX(item), 0) FROM creature_loot_template WHERE entry=38586 AND item<10;
INSERT INTO creature_loot_template VALUES(38586, @itemid+1, 100, 1, 0, -34278, 2);
INSERT INTO creature_loot_template VALUES(38586, @itemid+2, 100, 1, 0, -34279, 1);

-- Sindragosa (36853, 38265, 38266, 38267)
SELECT @itemid := IFNULL(MAX(item), 0) FROM creature_loot_template WHERE entry=38265 AND item<10;
INSERT INTO creature_loot_template VALUES(38265, @itemid+1, 100, 1, 0, -34278, 2);
SELECT @itemid := IFNULL(MAX(item), 0) FROM creature_loot_template WHERE entry=38266 AND item<10;
INSERT INTO creature_loot_template VALUES(38266, @itemid+1, 100, 1, 0, -34278, 1);
SELECT @itemid := IFNULL(MAX(item), 0) FROM creature_loot_template WHERE entry=38267 AND item<10;
INSERT INTO creature_loot_template VALUES(38267, @itemid+1, 100, 1, 0, -34278, 2);
INSERT INTO creature_loot_template VALUES(38267, @itemid+2, 100, 1, 0, -34279, 1);

-- The Lich King (36597, 39166, 39167, 39168)
SELECT @itemid := IFNULL(MAX(item), 0) FROM creature_loot_template WHERE entry=39166 AND item<10;
INSERT INTO creature_loot_template VALUES(39166, @itemid+1, 100, 1, 0, -34278, 2);
SELECT @itemid := IFNULL(MAX(item), 0) FROM creature_loot_template WHERE entry=39167 AND item<10;
INSERT INTO creature_loot_template VALUES(39167, @itemid+1, 100, 1, 0, -34278, 1);
SELECT @itemid := IFNULL(MAX(item), 0) FROM creature_loot_template WHERE entry=39168 AND item<10;
INSERT INTO creature_loot_template VALUES(39168, @itemid+1, 100, 1, 0, -34278, 2);
INSERT INTO creature_loot_template VALUES(39168, @itemid+2, 100, 1, 0, -34279, 1);
-- lk25hc drops 2 weapons:
UPDATE creature_loot_template SET maxcount=2 WHERE entry=39168 AND item=1 AND mincountOrRef=-34274;

-- Deathbringer Saurfang Cache
SET @dbsloot25n = 0;
SET @dbsloot10h = 0;
SET @dbsloot25h = 0;
SELECT @dbsloot25n := data1 FROM gameobject_template WHERE entry=202240;
SELECT @dbsloot10h := data1 FROM gameobject_template WHERE entry=202238;
SELECT @dbsloot25h := data1 FROM gameobject_template WHERE entry=202241;
SELECT @itemid := IFNULL(MAX(item), 0) FROM gameobject_loot_template WHERE entry=@dbsloot25n AND item<10;
INSERT INTO gameobject_loot_template VALUES(@dbsloot25n, @itemid+1, 100, 1, 0, -34278, 2);
SELECT @itemid := IFNULL(MAX(item), 0) FROM gameobject_loot_template WHERE entry=@dbsloot10h AND item<10;
INSERT INTO gameobject_loot_template VALUES(@dbsloot10h, @itemid+1, 100, 1, 0, -34278, 1);
SELECT @itemid := IFNULL(MAX(item), 0) FROM gameobject_loot_template WHERE entry=@dbsloot25h AND item<10;
INSERT INTO gameobject_loot_template VALUES(@dbsloot25h, @itemid+1, 100, 1, 0, -34278, 2);
INSERT INTO gameobject_loot_template VALUES(@dbsloot25h, @itemid+2, 100, 1, 0, -34279, 1);
-- only 1 item drops on 25man normal & heroic modes (as from every last boss of a quarter)
UPDATE gameobject_loot_template SET maxcount=1 WHERE entry=28074 AND item=1 AND mincountOrRef=-34252;
UPDATE gameobject_loot_template SET maxcount=1 WHERE entry=28088 AND item=1 AND mincountOrRef=-34276;

-- Valithria Dreamwalker - Cache of the Dreamwalker (201959, 202339, 202338, 202340)
UPDATE gameobject_loot_template SET maxcount=2 WHERE entry=28052 AND minCountOrRef=-34241;
UPDATE gameobject_loot_template SET maxcount=3 WHERE entry=28082 AND minCountOrRef=-34253;
UPDATE gameobject_loot_template SET maxcount=2 WHERE entry=28064 AND minCountOrRef=-34265;
UPDATE gameobject_loot_template SET maxcount=3 WHERE entry=28096 AND minCountOrRef=-34277;
