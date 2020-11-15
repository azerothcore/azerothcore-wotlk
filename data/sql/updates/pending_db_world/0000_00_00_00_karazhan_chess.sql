update creature_template set scriptname = "npc_chesspiece" where entry in (17469,17211,21748,21664,21750,21683,21747,21682,21726,21160,21752,21684);
update creature_template set scriptname = "npc_echo_of_medivh" where entry = 16816;
update creature_template set scriptname = "npc_chess_move_trigger",flags_extra=flags_extra|128,modelid2=1126 where entry = 22519;

DELETE FROM `spell_script_names` WHERE `spell_id`=30019;

DELETE FROM `creature` WHERE `id` IN (17469,17211,21748,21664,21750,21683,21747,21682,21726,21160,21752,21684);
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(1524110,17211,532,1,1,0,1,-11086.3,-1891.32,220.751,0.645772,7200,0,0,50000,0,0,0,0,0),
(1524111,17211,532,1,1,0,1,-11082.7,-1895.74,220.751,0.663225,7200,0,0,50000,0,0,0,0,0),
(1524112,17211,532,1,1,0,1,-11079.3,-1900.23,220.75,0.663225,7200,0,0,50000,0,0,0,0,0),
(1524113,17211,532,1,1,0,1,-11093.3,-1882.73,220.751,0.663225,7200,0,0,50000,0,0,0,0,0),
(1524114,17211,532,1,1,0,1,-11089.7,-1887.11,220.751,0.715585,7200,0,0,50000,0,0,0,0,0),
(1524115,17211,532,1,1,0,1,-11100.2,-1873.87,220.751,0.645772,7200,0,0,50000,0,0,0,0,0),
(1524116,17211,532,1,1,0,1,-11096.7,-1878.41,220.751,0.663225,7200,0,0,50000,0,0,0,0,0),
(1524117,17211,532,1,1,0,1,-11103.7,-1869.47,220.751,0.698132,7200,0,0,50000,0,0,0,0,0),
(1524118,17469,532,1,1,0,1,-11057.6,-1883.09,220.751,3.80482,7200,0,0,50000,0,0,0,0,0),
(1524119,17469,532,1,1,0,1,-11068.1,-1869.96,220.751,3.89208,7200,0,0,50000,0,0,0,0,0),
(1524120,17469,532,1,1,0,1,-11064.7,-1874.34,220.751,3.83972,7200,0,0,50000,0,0,0,0,0),
(1524121,17469,532,1,1,0,1,-11061.3,-1878.63,220.751,3.90954,7200,0,0,50000,0,0,0,0,0),
(1524122,17469,532,1,1,0,1,-11075,-1861.29,220.751,3.735,7200,0,0,50000,0,0,0,0,0),
(1524123,17469,532,1,1,0,1,-11071.7,-1865.53,220.751,3.82227,7200,0,0,50000,0,0,0,0,0),
(1524124,17469,532,1,1,0,1,-11082,-1852.19,220.751,3.80482,7200,0,0,50000,0,0,0,0,0),
(1524125,17469,532,1,1,0,1,-11078.5,-1856.99,220.751,3.89208,7200,0,0,50000,0,0,0,0,0),
(1524126,21160,532,1,1,0,0,-11083.2,-1903.35,220.75,0.663225,7200,0,0,80000,0,0,0,0,0),
(1524127,21160,532,1,1,0,0,-11107.9,-1873.03,220.751,0.715585,7200,0,0,80000,0,0,0,0,0),
(1524128,21664,532,1,1,0,0,-11086.9,-1899.18,220.751,0.733038,7200,0,0,65000,0,0,0,0,0),
(1524129,21664,532,1,1,0,0,-11104.6,-1877.51,220.751,0.680678,7200,0,0,65000,0,0,0,0,0),
(1524130,21682,532,1,1,0,1,-11090.6,-1894.99,220.751,0.628318,7200,0,0,60000,0,0,0,0,0),
(1524131,21682,532,1,1,0,1,-11101,-1881.93,220.751,0.663225,7200,0,0,60000,0,0,0,0,0),
(1524132,21683,532,1,1,0,1,-11097.5,-1886.2,220.751,0.785398,7200,0,0,80000,0,0,0,0,0),
(1524133,21684,532,1,1,0,1,-11093.8,-1890.47,220.751,0.698132,7200,0,0,150000,0,0,0,0,0),
(1524134,21726,532,1,1,0,1,-11053.5,-1879.72,220.751,4.01426,7200,0,0,80000,0,0,0,0,0),
(1524135,21726,532,1,1,0,1,-11077.7,-1848.79,220.751,3.90954,7200,0,0,80000,0,0,0,0,0),
(1524136,21747,532,1,1,0,1,-11060.3,-1870.9,220.751,3.80482,7200,0,0,60000,0,0,0,0,0),
(1524137,21747,532,1,1,0,1,-11070.9,-1857.75,220.751,3.83972,7200,0,0,60000,0,0,0,0,0),
(1524138,21748,532,1,1,0,1,-11056.9,-1875.29,220.751,3.66519,7200,0,0,65000,0,0,0,0,0),
(1524139,21748,532,1,1,0,1,-11074.3,-1853.26,220.751,3.735,7200,0,0,65000,0,0,0,0,0),
(1524140,21750,532,1,1,0,1,-11067.6,-1861.94,220.751,3.83972,7200,0,0,80000,0,0,0,0,0),
(1524141,21752,532,1,1,0,1,-11063.6,-1866.36,220.751,3.82227,7200,0,0,150000,0,0,0,0,0);

DELETE FROM creature WHERE id=22519;

DELETE FROM `creature_template_addon` WHERE `entry`=22521;
INSERT INTO `creature_template_addon` (`entry`,`auras`) VALUES
(22521,"39383 0");

UPDATE creature_template SET flags_extra = 130 WHERE entry = 22521;

/*
37465 - Rain of Fire
37469 - Poison Cloud
*/

UPDATE `creature_template` SET spell1=37146,spell2=30284,spell3=37471,spell4=37474 WHERE entry=21684; -- King Llane
UPDATE `creature_template` SET spell1=37148,spell2=30284,spell3=37462,spell4=37465 WHERE entry=21683; -- Human Conjurer
UPDATE `creature_template` SET spell1=37146,spell2=30284,spell3=37455,spell4=37459 WHERE entry=21682; -- Human Cleric
UPDATE `creature_template` SET spell1=37144,spell2=30284,spell3=37453,spell4=37498 WHERE entry=21664; -- Human Charger
UPDATE `creature_template` SET spell1=37146,spell2=30284,spell3=37427,spell4=37432 WHERE entry=21160; -- Conjured Water Elemental
UPDATE `creature_template` SET spell1=37146,spell2=30284,spell3=37406,spell4=37414 WHERE entry=17211; -- Human Footman

UPDATE `creature_template` SET spell1=37146,spell2=30284,spell3=37472,spell4=37476 WHERE entry=21752; -- Warchief Blackhand
UPDATE `creature_template` SET spell1=37148,spell2=30284,spell3=37463,spell4=37461 WHERE entry=21750; -- Orc Warlock
UPDATE `creature_template` SET spell1=37146,spell2=30284,spell3=37456,spell4=37461 WHERE entry=21747; -- Orc Necrolyte
UPDATE `creature_template` SET spell1=37144,spell2=30284,spell3=37454,spell4=37502 WHERE entry=21748; -- Orc Wolf
UPDATE `creature_template` SET spell1=37146,spell2=30284,spell3=37428,spell4=37434 WHERE entry=21726; -- Summoned Daemon
UPDATE `creature_template` SET spell1=37146,spell2=30284,spell3=37413,spell4=37416 WHERE entry=17469; -- Orc Grunt

UPDATE creature_template SET regenhealth=0,BaseAttackTime=3000 WHERE entry IN (21726,21748,21747,21750,21752,17469,21160,21664,21682,21684,21683,17211);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` IN (37476,37472,37461,37454,37502,37428,37413,37471,37474,37459,37453,37498,37427,37406,39384,37462,37455,37463,37456,37144,37146,37148,30284);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ScriptName`,`Comment`) VALUES
(13,0,37144,0,18,1,22519,0,'',"Move - Target Chess Piece: Karazhan Invisible Stalker"),
(13,0,37146,0,18,1,22519,0,'',"Move - Target Chess Piece: Karazhan Invisible Stalker"),
(13,0,37148,0,18,1,22519,0,'',"Move - Target Chess Piece: Karazhan Invisible Stalker"),

(13,0,30284,0,18,1,22519,0,'',"Change Facing - Target Chess Piece: Karazhan Invisible Stalker"),

(13,0,37406,0,18,1,21752,0,'',"Alliance Chess Spell - Heroic Blow - Target Horde Pieces"),
(13,0,37406,1,18,1,21750,0,'',"Alliance Chess Spell - Heroic Blow - Target Horde Pieces"),
(13,0,37406,2,18,1,21747,0,'',"Alliance Chess Spell - Heroic Blow - Target Horde Pieces"),
(13,0,37406,3,18,1,21748,0,'',"Alliance Chess Spell - Heroic Blow - Target Horde Pieces"),
(13,0,37406,4,18,1,21726,0,'',"Alliance Chess Spell - Heroic Blow - Target Horde Pieces"),
(13,0,37406,5,18,1,17469,0,'',"Alliance Chess Spell - Heroic Blow - Target Horde Pieces"),

(13,0,37474,0,18,1,21752,0,'',"Alliance Chess Spell - Sweep - Target Horde Pieces"),
(13,0,37474,1,18,1,21750,0,'',"Alliance Chess Spell - Sweep - Target Horde Pieces"),
(13,0,37474,2,18,1,21747,0,'',"Alliance Chess Spell - Sweep - Target Horde Pieces"),
(13,0,37474,3,18,1,21748,0,'',"Alliance Chess Spell - Sweep - Target Horde Pieces"),
(13,0,37474,4,18,1,21726,0,'',"Alliance Chess Spell - Sweep - Target Horde Pieces"),
(13,0,37474,5,18,1,17469,0,'',"Alliance Chess Spell - Sweep - Target Horde Pieces"),

(13,0,37459,0,18,1,21752,0,'',"Alliance Chess Spell - Holy Lance - Target Horde Pieces"),
(13,0,37459,1,18,1,21750,0,'',"Alliance Chess Spell - Holy Lance - Target Horde Pieces"),
(13,0,37459,2,18,1,21747,0,'',"Alliance Chess Spell - Holy Lance - Target Horde Pieces"),
(13,0,37459,3,18,1,21748,0,'',"Alliance Chess Spell - Holy Lance - Target Horde Pieces"),
(13,0,37459,4,18,1,21726,0,'',"Alliance Chess Spell - Holy Lance - Target Horde Pieces"),
(13,0,37459,5,18,1,17469,0,'',"Alliance Chess Spell - Holy Lance - Target Horde Pieces"),

(13,0,37453,0,18,1,21752,0,'',"Alliance Chess Spell - Smash - Target Horde Pieces"),
(13,0,37453,1,18,1,21750,0,'',"Alliance Chess Spell - Smash - Target Horde Pieces"),
(13,0,37453,2,18,1,21747,0,'',"Alliance Chess Spell - Smash - Target Horde Pieces"),
(13,0,37453,3,18,1,21748,0,'',"Alliance Chess Spell - Smash - Target Horde Pieces"),
(13,0,37453,4,18,1,21726,0,'',"Alliance Chess Spell - Smash - Target Horde Pieces"),
(13,0,37453,5,18,1,17469,0,'',"Alliance Chess Spell - Smash - Target Horde Pieces"),

(13,0,37498,0,18,1,21752,0,'',"Alliance Chess Spell - Stomp - Target Horde Pieces"),
(13,0,37498,1,18,1,21750,0,'',"Alliance Chess Spell - Stomp - Target Horde Pieces"),
(13,0,37498,2,18,1,21747,0,'',"Alliance Chess Spell - Stomp - Target Horde Pieces"),
(13,0,37498,3,18,1,21748,0,'',"Alliance Chess Spell - Stomp - Target Horde Pieces"),
(13,0,37498,4,18,1,21726,0,'',"Alliance Chess Spell - Stomp - Target Horde Pieces"),
(13,0,37498,5,18,1,17469,0,'',"Alliance Chess Spell - Stomp - Target Horde Pieces"),

(13,0,37427,0,18,1,21752,0,'',"Alliance Chess Spell - Geyser - Target Horde Pieces"),
(13,0,37427,1,18,1,21750,0,'',"Alliance Chess Spell - Geyser - Target Horde Pieces"),
(13,0,37427,2,18,1,21747,0,'',"Alliance Chess Spell - Geyser - Target Horde Pieces"),
(13,0,37427,3,18,1,21748,0,'',"Alliance Chess Spell - Geyser - Target Horde Pieces"),
(13,0,37427,4,18,1,21726,0,'',"Alliance Chess Spell - Geyser - Target Horde Pieces"),
(13,0,37427,5,18,1,17469,0,'',"Alliance Chess Spell - Geyser - Target Horde Pieces"),

(13,0,37462,0,18,1,21752,0,'',"Alliance Chess Spell - Elemental Blast - Target Horde Pieces"),
(13,0,37462,1,18,1,21750,0,'',"Alliance Chess Spell - Elemental Blast - Target Horde Pieces"),
(13,0,37462,2,18,1,21747,0,'',"Alliance Chess Spell - Elemental Blast - Target Horde Pieces"),
(13,0,37462,3,18,1,21748,0,'',"Alliance Chess Spell - Elemental Blast - Target Horde Pieces"),
(13,0,37462,4,18,1,21726,0,'',"Alliance Chess Spell - Elemental Blast - Target Horde Pieces"),
(13,0,37462,5,18,1,17469,0,'',"Alliance Chess Spell - Elemental Blast - Target Horde Pieces"),

(13,0,37456,0,18,1,21752,0,'',"Horde Chess Spell - Shadow Mend - Target Horde Pieces"),
(13,0,37456,1,18,1,21750,0,'',"Horde Chess Spell - Shadow Mend - Target Horde Pieces"),
(13,0,37456,2,18,1,21747,0,'',"Horde Chess Spell - Shadow Mend - Target Horde Pieces"),
(13,0,37456,3,18,1,21748,0,'',"Horde Chess Spell - Shadow Mend - Target Horde Pieces"),
(13,0,37456,4,18,1,21726,0,'',"Horde Chess Spell - Shadow Mend - Target Horde Pieces"),
(13,0,37456,5,18,1,17469,0,'',"Horde Chess Spell - Shadow Mend - Target Horde Pieces"),

(13,0,37471,0,18,1,21683,0,'',"Alliance Chess Spell - Heroism - Target Alliance Pieces"),
(13,0,37471,1,18,1,21684,0,'',"Alliance Chess Spell - Heroism - Target Alliance Pieces"),
(13,0,37471,2,18,1,21682,0,'',"Alliance Chess Spell - Heroism - Target Alliance Pieces"),
(13,0,37471,3,18,1,21664,0,'',"Alliance Chess Spell - Heroism - Target Alliance Pieces"),
(13,0,37471,4,18,1,21160,0,'',"Alliance Chess Spell - Heroism - Target Alliance Pieces"),
(13,0,37471,5,18,1,17211,0,'',"Alliance Chess Spell - Heroism - Target Alliance Pieces"),

(13,0,37455,0,18,1,21683,0,'',"Alliance Chess Spell - Healing - Target Alliance Pieces"),
(13,0,37455,1,18,1,21684,0,'',"Alliance Chess Spell - Healing - Target Alliance Pieces"),
(13,0,37455,2,18,1,21682,0,'',"Alliance Chess Spell - Healing - Target Alliance Pieces"),
(13,0,37455,3,18,1,21664,0,'',"Alliance Chess Spell - Healing - Target Alliance Pieces"),
(13,0,37455,4,18,1,21160,0,'',"Alliance Chess Spell - Healing - Target Alliance Pieces"),
(13,0,37455,5,18,1,17211,0,'',"Alliance Chess Spell - Healing - Target Alliance Pieces"),

(13,0,37476,0,18,1,21683,0,'',"Horde Chess Spell - Cleave - Target Alliance Pieces"),
(13,0,37476,1,18,1,21684,0,'',"Horde Chess Spell - Cleave - Target Alliance Pieces"),
(13,0,37476,2,18,1,21682,0,'',"Horde Chess Spell - Cleave - Target Alliance Pieces"),
(13,0,37476,3,18,1,21664,0,'',"Horde Chess Spell - Cleave - Target Alliance Pieces"),
(13,0,37476,4,18,1,21160,0,'',"Horde Chess Spell - Cleave - Target Alliance Pieces"),
(13,0,37476,5,18,1,17211,0,'',"Horde Chess Spell - Cleave - Target Alliance Pieces"),

(13,0,37472,0,18,1,21752,0,'',"Horde Chess Spell - Bloodlust - Target Horde Pieces"),
(13,0,37472,1,18,1,21750,0,'',"Horde Chess Spell - Bloodlust - Target Horde Pieces"),
(13,0,37472,2,18,1,21747,0,'',"Horde Chess Spell - Bloodlust - Target Horde Pieces"),
(13,0,37472,3,18,1,21748,0,'',"Horde Chess Spell - Bloodlust - Target Horde Pieces"),
(13,0,37472,4,18,1,21726,0,'',"Horde Chess Spell - Bloodlust - Target Horde Pieces"),
(13,0,37472,5,18,1,17469,0,'',"Horde Chess Spell - Bloodlust - Target Horde Pieces"),

(13,0,37461,0,18,1,21683,0,'',"Horde Chess Spell - Shadow Spear - Target Alliance Pieces"),
(13,0,37461,1,18,1,21684,0,'',"Horde Chess Spell - Shadow Spear - Target Alliance Pieces"),
(13,0,37461,2,18,1,21682,0,'',"Horde Chess Spell - Shadow Spear - Target Alliance Pieces"),
(13,0,37461,3,18,1,21664,0,'',"Horde Chess Spell - Shadow Spear - Target Alliance Pieces"),
(13,0,37461,4,18,1,21160,0,'',"Horde Chess Spell - Shadow Spear - Target Alliance Pieces"),
(13,0,37461,5,18,1,17211,0,'',"Horde Chess Spell - Shadow Spear - Target Alliance Pieces"),

(13,0,37454,0,18,1,21683,0,'',"Horde Chess Spell - Bite - Target Alliance Pieces"),
(13,0,37454,1,18,1,21684,0,'',"Horde Chess Spell - Bite - Target Alliance Pieces"),
(13,0,37454,2,18,1,21682,0,'',"Horde Chess Spell - Bite - Target Alliance Pieces"),
(13,0,37454,3,18,1,21664,0,'',"Horde Chess Spell - Bite - Target Alliance Pieces"),
(13,0,37454,4,18,1,21160,0,'',"Horde Chess Spell - Bite - Target Alliance Pieces"),
(13,0,37454,5,18,1,17211,0,'',"Horde Chess Spell - Bite - Target Alliance Pieces"),

(13,0,37502,0,18,1,21683,0,'',"Horde Chess Spell - Howl - Target Alliance Pieces"),
(13,0,37502,1,18,1,21684,0,'',"Horde Chess Spell - Howl - Target Alliance Pieces"),
(13,0,37502,2,18,1,21682,0,'',"Horde Chess Spell - Howl - Target Alliance Pieces"),
(13,0,37502,3,18,1,21664,0,'',"Horde Chess Spell - Howl - Target Alliance Pieces"),
(13,0,37502,4,18,1,21160,0,'',"Horde Chess Spell - Howl - Target Alliance Pieces"),
(13,0,37502,5,18,1,17211,0,'',"Horde Chess Spell - Howl - Target Alliance Pieces"),

(13,0,37428,0,18,1,21683,0,'',"Horde Chess Spell - Hellfire - Target Alliance Pieces"),
(13,0,37428,1,18,1,21684,0,'',"Horde Chess Spell - Hellfire - Target Alliance Pieces"),
(13,0,37428,2,18,1,21682,0,'',"Horde Chess Spell - Hellfire - Target Alliance Pieces"),
(13,0,37428,3,18,1,21664,0,'',"Horde Chess Spell - Hellfire - Target Alliance Pieces"),
(13,0,37428,4,18,1,21160,0,'',"Horde Chess Spell - Hellfire - Target Alliance Pieces"),
(13,0,37428,5,18,1,17211,0,'',"Horde Chess Spell - Hellfire - Target Alliance Pieces"),

(13,0,37413,0,18,1,21683,0,'',"Horde Chess Spell - Vicious Strike - Target Alliance Pieces"),
(13,0,37413,1,18,1,21684,0,'',"Horde Chess Spell - Vicious Strike - Target Alliance Pieces"),
(13,0,37413,2,18,1,21682,0,'',"Horde Chess Spell - Vicious Strike - Target Alliance Pieces"),
(13,0,37413,3,18,1,21664,0,'',"Horde Chess Spell - Vicious Strike - Target Alliance Pieces"),
(13,0,37413,4,18,1,21160,0,'',"Horde Chess Spell - Vicious Strike - Target Alliance Pieces"),
(13,0,37413,5,18,1,17211,0,'',"Horde Chess Spell - Vicious Strike - Target Alliance Pieces"),

(13,0,37463,0,18,1,21683,0,'',"Horde Chess Spell - Fireball - Target Alliance Pieces"),
(13,0,37463,1,18,1,21684,0,'',"Horde Chess Spell - Fireball - Target Alliance Pieces"),
(13,0,37463,2,18,1,21682,0,'',"Horde Chess Spell - Fireball - Target Alliance Pieces"),
(13,0,37463,3,18,1,21664,0,'',"Horde Chess Spell - Fireball - Target Alliance Pieces"),
(13,0,37463,4,18,1,21160,0,'',"Horde Chess Spell - Fireball - Target Alliance Pieces"),
(13,0,37463,5,18,1,17211,0,'',"Horde Chess Spell - Fireball - Target Alliance Pieces"),

(13,0,39384,0,18,1,21752,0,'',"Alliance and Horde Chess Spell - Burning Flames - Target Alliance and Horde Pieces"),
(13,0,39384,1,18,1,21750,0,'',"Alliance and Horde Chess Spell - Burning Flames - Target Alliance and Horde Pieces"),
(13,0,39384,2,18,1,21747,0,'',"Alliance and Horde Chess Spell - Burning Flames - Target Alliance and Horde Pieces"),
(13,0,39384,3,18,1,21748,0,'',"Alliance and Horde Chess Spell - Burning Flames - Target Alliance and Horde Pieces"),
(13,0,39384,4,18,1,21726,0,'',"Alliance and Horde Chess Spell - Burning Flames - Target Alliance and Horde Pieces"),
(13,0,39384,5,18,1,17469,0,'',"Alliance and Horde Chess Spell - Burning Flames - Target Alliance and Horde Pieces"),
(13,0,39384,6,18,1,21683,0,'',"Alliance and Horde Chess Spell - Burning Flames - Target Alliance and Horde Pieces"),
(13,0,39384,7,18,1,21684,0,'',"Alliance and Horde Chess Spell - Burning Flames - Target Alliance and Horde Pieces"),
(13,0,39384,8,18,1,21682,0,'',"Alliance and Horde Chess Spell - Burning Flames - Target Alliance and Horde Pieces"),
(13,0,39384,9,18,1,21664,0,'',"Alliance and Horde Chess Spell - Burning Flames - Target Alliance and Horde Pieces"),
(13,0,39384,10,18,1,21160,0,'',"Alliance and Horde Chess Spell - Burning Flames - Target Alliance and Horde Pieces"),
(13,0,39384,11,18,1,17211,0,'',"Alliance and Horde Chess Spell - Burning Flames - Target Alliance and Horde Pieces");