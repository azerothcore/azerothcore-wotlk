UPDATE battleground_template SET MinPlayersPerTeam=0, MaxPlayersPerTeam=5, MinLvl=10, MaxLvl=80 WHERE id IN(4, 5, 6, 8, 10, 11); -- arenas
UPDATE battleground_template SET MinLvl=80, MaxLvl=80 WHERE id=32; -- random bg
UPDATE battleground_template SET Weight=1; -- not used anymore

-- Arena Ready Marker
DELETE FROM gameobject_template WHERE entry=301337 AND name='Ready Marker';
INSERT INTO gameobject_template VALUES(301337, 10, 327, 'Ready Marker', 'PVP', '', '', 0, 32, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 'go_arena_ready_marker', 1);
DELETE FROM gameobject WHERE id=301337;
-- INSERT INTO gameobject VALUES(NULL, 301337, 562, 1, 1, 6189.47, 235.54, 5.52, 0, 0, 0, 0, 0, 300, 0, 1); -- BE
-- INSERT INTO gameobject VALUES(NULL, 301337, 562, 1, 1, 6287.19, 288.25, 5.33, 0, 0, 0, 0, 0, 300, 0, 1); -- BE
-- INSERT INTO gameobject VALUES(NULL, 301337, 617, 1, 1, 1229.44, 759.35, 17.89, 0, 0, 0, 0, 0, 300, 0, 1); -- DA
-- INSERT INTO gameobject VALUES(NULL, 301337, 617, 1, 1, 1352.90, 822.77, 17.96, 0, 0, 0, 0, 0, 300, 0, 1); -- DA
-- INSERT INTO gameobject VALUES(NULL, 301337, 559, 1, 1, 4090.46, 2875.43, 12.16, 0, 0, 0, 0, 0, 300, 0, 1); -- NA
-- INSERT INTO gameobject VALUES(NULL, 301337, 559, 1, 1, 4022.82, 2966.61, 12.17, 0, 0, 0, 0, 0, 300, 0, 1); -- NA
-- INSERT INTO gameobject VALUES(NULL, 301337, 618, 1, 1, 769.93, -301.04, 2.80, 0, 0, 0, 0, 0, 300, 0, 1); -- RoV
-- INSERT INTO gameobject VALUES(NULL, 301337, 618, 1, 1, 757.02, -267.30, 2.80, 0, 0, 0, 0, 0, 300, 0, 1); -- RoV
-- INSERT INTO gameobject VALUES(NULL, 301337, 572, 1, 1, 1298.61, 1598.59, 31.62, 0, 0, 0, 0, 0, 300, 0, 1); -- RL
-- INSERT INTO gameobject VALUES(NULL, 301337, 572, 1, 1, 1273.71, 1734.05, 31.61, 0, 0, 0, 0, 0, 300, 0, 1); -- RL

-- shared BG bug, fix mechanic immune mask
UPDATE creature_template SET mechanic_immune_mask=344407930 WHERE mechanic_immune_mask=344276858; -- added banish immunity

-- ------------------------
-- Alterac Valley
-- ------------------------
UPDATE creature_template SET minlevel=63, maxlevel=63, exp=0, speed_walk=1.78, AIName='' WHERE entry IN(11946, 11948); -- Vanilla stats
UPDATE creature_template SET minlevel=73, maxlevel=73, exp=1 WHERE entry=22641; -- Drek'Thar
UPDATE creature_template SET minlevel=73, maxlevel=73, exp=1 WHERE entry=22644; -- Vanndar Stormpike
UPDATE creature_template SET minlevel=83, maxlevel=83, exp=2 WHERE entry=31819; -- Drek'Thar
UPDATE creature_template SET minlevel=83, maxlevel=83, exp=2 WHERE entry=31818; -- Vanndar Stormpike

-- Irondeep Skullthumper (11602, 22748, 32019, 37338)
UPDATE creature_template SET difficulty_entry_3=37338 WHERE entry=11602;
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=2, dmg_multiplier=1.2 WHERE entry=37338;

-- Whitewhisker Overseer (11605, 22780, 32141, 37471)
UPDATE creature_template SET difficulty_entry_3=37471 WHERE entry=11605;
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=2, dmg_multiplier=1.2 WHERE entry=37471;

-- Irondeep Raider (13081, 22746, 32017, 37336)
UPDATE creature_template SET difficulty_entry_3=37336 WHERE entry=13081;
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=2, dmg_multiplier=1.2 WHERE entry=37336;

-- Coldmine Invader (13087, 22731, 31948, 37266)
UPDATE creature_template SET difficulty_entry_3=37266 WHERE entry=13087;
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=2, dmg_multiplier=1.2 WHERE entry=37266;

-- Coldmine Guard (13089, 22730, 31947, 37265)
UPDATE creature_template SET difficulty_entry_3=37265 WHERE entry=13089;
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=2, dmg_multiplier=1.2 WHERE entry=37265;

-- Irondeep Surveyor (13098, 22749, 32020, 37339)
UPDATE creature_template SET difficulty_entry_3=37339 WHERE entry=13098;
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=2, dmg_multiplier=1.2 WHERE entry=37339;

-- Herald (14848, 22557, 32003, 37322)
UPDATE creature_template SET difficulty_entry_2=32003, difficulty_entry_3=37322 WHERE entry=14848;
UPDATE creature_template SET minlevel=75, maxlevel=75, faction=1334, npcflag=3, mindmg=332, maxdmg=485, attackpower=411, unit_flags=33559296, flags_extra=2, exp=0, dmg_multiplier=1 WHERE entry=32003;
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=2, dmg_multiplier=1.2 WHERE entry=37322;

-- Aggi Rumblestomp (with faction 32, alliance players can attack him)
UPDATE creature_template SET faction=11 WHERE entry IN(13086, 22670, 31918, 37234);

-- Seasoned Defender (13326, 22714, 32062, 37383), some TC retard gave them hostile faction (AV npcs)
UPDATE creature_template SET faction=1216 WHERE entry IN(13326, 22714, 32062, 37383);

UPDATE creature_template tb LEFT JOIN creature_template td1 ON tb.difficulty_entry_1=td1.entry LEFT JOIN creature_template td2 ON tb.difficulty_entry_2=td2.entry LEFT JOIN creature_template td3 ON tb.difficulty_entry_3=td3.entry SET
td3.KillCredit1 = tb.KillCredit1,
td3.KillCredit2 = tb.KillCredit2,
td3.modelid1 = tb.modelid1,
td3.modelid2 = tb.modelid2,
td3.modelid3 = tb.modelid3,
td3.modelid4 = tb.modelid4,
td3.gossip_menu_id = tb.gossip_menu_id,
td3.faction = tb.faction,
td3.npcflag = tb.npcflag,
td3.speed_walk = td2.speed_walk,
td3.speed_run = td2.speed_run,
td3.scale = tb.scale,
td3.rank = tb.rank,
td3.mindmg = td1.mindmg,
td3.maxdmg = td1.maxdmg,
td3.dmgschool = td1.dmgschool,
td3.attackpower = td1.attackpower,
td3.baseattacktime = td2.baseattacktime,
td3.rangeattacktime = td2.rangeattacktime,
td3.unit_class = tb.unit_class,
td3.unit_flags = tb.unit_flags,
td3.unit_flags2 = tb.unit_flags2,
td3.dynamicflags = tb.dynamicflags,
td3.family = tb.family,
td3.trainer_type = tb.trainer_type,
td3.trainer_spell = tb.trainer_spell,
td3.trainer_class = tb.trainer_class,
td3.trainer_race = tb.trainer_race,
td3.minrangedmg = td1.minrangedmg,
td3.maxrangedmg = td1.maxrangedmg,
td3.rangedattackpower = tb.rangedattackpower,
td3.type = tb.type,
td3.type_flags = tb.type_flags,
td3.lootid = tb.lootid,
td3.pickpocketloot = tb.pickpocketloot,
td3.skinloot = tb.skinloot,
td3.resistance1 = tb.resistance1,
td3.resistance2 = tb.resistance2,
td3.resistance3 = tb.resistance3,
td3.resistance4 = tb.resistance4,
td3.resistance5 = tb.resistance5,
td3.resistance6 = tb.resistance6,
td3.spell1 = tb.spell1,
td3.spell2 = tb.spell2,
td3.spell3 = tb.spell3,
td3.spell4 = tb.spell4,
td3.spell5 = tb.spell5,
td3.spell6 = tb.spell6,
td3.spell7 = tb.spell7,
td3.spell8 = tb.spell8,
td3.PetSpellDataId = tb.PetSpellDataId,
td3.VehicleId = tb.VehicleId,
td3.MovementType = tb.MovementType,
td3.InhabitType = tb.InhabitType,
td3.HoverHeight = tb.HoverHeight,
td3.RacialLeader = tb.RacialLeader,
td3.questItem1 = tb.questItem1,
td3.questItem2 = tb.questItem2,
td3.questItem3 = tb.questItem3,
td3.questItem4 = tb.questItem4,
td3.questItem5 = tb.questItem5,
td3.questItem6 = tb.questItem6,
td3.movementId = tb.movementId,
td3.RegenHealth = tb.RegenHealth,
td3.mechanic_immune_mask = tb.mechanic_immune_mask,
td3.flags_extra = tb.flags_extra,

td2.lootid = tb.lootid,
td2.pickpocketloot = tb.pickpocketloot,
td2.skinloot = tb.skinloot,

td1.lootid = tb.lootid,
td1.pickpocketloot = tb.pickpocketloot,
td1.skinloot = tb.skinloot

WHERE tb.entry IN(15103,12050,13326,13331,13422,13358,11949,11948,12053,13328,13332,13421,13359,11947,11946,14763,14762,14764,14765,14773,14776,14772,14777,10987,11600,11602,11657,13396,13080,13098,13078,13397,13099,13081
,13079,11603,11604,11605,11677,10982,13317,13096,13087,13086,13316,13097,13089,13088,14848,2225,3343,3625,4255,4257,5134,5135,5139,10364,10367,10981,10986,10990,11675,11678,11839,11947,11948,11949,11997,12051,12096
,12097,12127,13176,13179,13216,13218,13236,13257,13284,13438,13442,13443,13447,13577,13617,13797,13798,13816,14185,14186,14187,14188,14282,14283,14284,11946,11948,11947,11949);








-- ------------------------
-- Strand of the Ancients
-- ------------------------
-- Add missing texts
REPLACE INTO trinity_string VALUES(1225, "Alliance", "", "", "", "", "", "", "", "");
REPLACE INTO trinity_string VALUES(1226, "Horde", "", "", "", "", "", "", "", "");

-- Demolisher speed
UPDATE creature_template SET speed_walk=1, speed_run=1, RegenHealth=0 WHERE entry IN(28781, 32796);
-- immunities
UPDATE creature_template SET mechanic_immune_mask=344407930 WHERE entry IN(27894, 28781, 32795, 32796);

-- ------------------------
-- Isle of Conquest
-- ------------------------
DELETE FROM disables WHERE entry=30 AND sourceType=3;

-- transports
UPDATE gameobject_template SET flags=6553640 WHERE entry IN(195121, 195276); -- MAKE_PAIR(0x28, 0x64);

-- Remake templates...
-- High Commander Halford Wyrmbane (34924, 35403)
UPDATE creature_template SET difficulty_entry_1=35403, exp=0, rank=1, minlevel=73, maxlevel=73, baseattacktime=2000, AIName="", ScriptName="boss_isle_of_conquest", mechanic_immune_mask=344407930 WHERE entry=34924;
UPDATE creature_template SET minlevel=81, maxlevel=81, exp=0, rank=1, faction=84, mindmg=299, maxdmg=426, attackpower=308, dmg_multiplier=13, baseattacktime=2000, unit_flags=0, unit_class=1, dynamicflags=8, mechanic_immune_mask=344407930 WHERE entry=35403;

-- Overlord Agmar (34922, 35405)
UPDATE creature_template SET difficulty_entry_1=35405, exp=0, rank=1, minlevel=73, maxlevel=73, baseattacktime=2000, AIName="", ScriptName="boss_isle_of_conquest", mechanic_immune_mask=344407930 WHERE entry=34922;
UPDATE creature_template SET minlevel=81, maxlevel=81, exp=0, rank=1, faction=83, mindmg=299, maxdmg=426, attackpower=308, dmg_multiplier=13, baseattacktime=2000, unit_flags=0, unit_class=1, type_flags=4168, dynamicflags=8, mechanic_immune_mask=344407930 WHERE entry=35405;

-- Kor'kron Guard (34918, 35407)
UPDATE creature_template SET difficulty_entry_1=35407, exp=0, minlevel=71, maxlevel=71, mindmg=252, maxdmg=357, attackpower=304, baseattacktime=2000, AIName="", ScriptName="" WHERE entry=34918;
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=0, faction=83, mindmg=422, maxdmg=586, attackpower=642, dmg_multiplier=1, baseattacktime=2000, unit_flags=0, unit_class=1, type_flags=4096, dynamicflags=8 WHERE entry=35407;

-- 7th Legion Infantry (34919, 35401)
UPDATE creature_template SET difficulty_entry_1=35401, exp=0, minlevel=71, maxlevel=71, mindmg=252, maxdmg=357, attackpower=304, baseattacktime=2000, AIName="", ScriptName="" WHERE entry=34919;
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=0, faction=84, mindmg=422, maxdmg=586, attackpower=642, dmg_multiplier=1, baseattacktime=2000, unit_flags=0, unit_class=1, type_flags=4096, dynamicflags=8 WHERE entry=35401;

-- Keep Cannon (34944, 35429)
-- Broken Keep Cannon (35819)
UPDATE creature_template SET difficulty_entry_1=35429, exp=0, npcflag=16777216, unit_flags=16384|4, AIName="", ScriptName="npc_isle_of_conquest_turret" WHERE entry=34944;
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=0, npcflag=16777216, mindmg=252, maxdmg=357, attackpower=304, baseattacktime=2000, dmg_multiplier=13, unit_flags=16384|4, unit_class=1, dynamicflags=8, spell1=67452, spell2=68169, VehicleId=510, RegenHealth=0, mechanic_immune_mask=344407930 WHERE entry=35429;
UPDATE creature_template SET exp=0, npcflag=16777216, unit_flags=unit_flags|4, vehicleId=0, RegenHealth=0, mechanic_immune_mask=344407930, AIName="", ScriptName="npc_isle_of_conquest_turret" WHERE entry=35819;
DELETE FROM npc_spellclick_spells WHERE npc_entry IN(35819, 35429);
INSERT INTO npc_spellclick_spells VALUES(35819, 68077, 1, 1);
INSERT INTO npc_spellclick_spells VALUES(35429, 68458, 1, 0);
DELETE FROM spell_script_names WHERE spell_id=68077;
INSERT INTO spell_script_names VALUES(68077, "spell_ioc_repair_turret");

-- Alliance Gunship Cannon (34929, 35410)
UPDATE creature_template SET difficulty_entry_1=35410, exp=0, faction=1732, npcflag=16777216, unit_flags=16384|4, spell1=66518, AIName="", ScriptName="" WHERE entry=34929;
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=0, faction=1732, npcflag=16777216, mindmg=252, maxdmg=357, attackpower=304, baseattacktime=2000, dmg_multiplier=13, unit_flags=16384|4, unit_class=1, dynamicflags=8, spell1=66518, VehicleId=452, RegenHealth=0, mechanic_immune_mask=344407930 WHERE entry=35410;
DELETE FROM npc_spellclick_spells WHERE npc_entry=35410;
INSERT INTO npc_spellclick_spells VALUES (35410, 43671, 1, 0);

-- Horde Gunship Cannon (34935, 35427)
UPDATE creature_template SET difficulty_entry_1=35427, exp=0, faction=1735, npcflag=16777216, unit_flags=16384|4, AIName="", ScriptName="" WHERE entry=34935;
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=0, faction=1735, npcflag=16777216, mindmg=252, maxdmg=357, attackpower=304, baseattacktime=2000, dmg_multiplier=13, unit_flags=16384|4, unit_class=1, dynamicflags=8, spell1=68825, VehicleId=453, RegenHealth=0, mechanic_immune_mask=344407930 WHERE entry=35427;
DELETE FROM npc_spellclick_spells WHERE npc_entry=35427;
INSERT INTO npc_spellclick_spells VALUES (35427, 43671, 1, 0);

-- Demolisher (34775, 35415)
UPDATE creature_template SET difficulty_entry_1=35415, exp=0, npcflag=16777216, speed_walk=1.2, speed_run=0.98571, unit_flags=16384, AIName="", ScriptName="npc_four_car_garage" WHERE entry=34775;
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=0, npcflag=16777216, speed_walk=1.2, speed_run=0.98571, mindmg=252, maxdmg=357, attackpower=304, baseattacktime=2000, dmg_multiplier=1, unit_flags=16384, unit_class=1, dynamicflags=8, spell1=67442, spell2=68068, VehicleId=509, RegenHealth=0, mechanic_immune_mask=344407930 WHERE entry=35415;
DELETE FROM npc_spellclick_spells WHERE npc_entry=35415;
INSERT INTO npc_spellclick_spells VALUES (35415, 66245, 1, 0);

-- Catapult (34793, 35413)
UPDATE creature_template SET difficulty_entry_1=35413, exp=0, npcflag=16777216, speed_walk=2.8, speed_run=2.42857, unit_flags=16384, AIName="", ScriptName="npc_four_car_garage" WHERE entry=34793;
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=0, npcflag=16777216, speed_walk=2.8, speed_run=2.42857, mindmg=252, maxdmg=357, attackpower=304, baseattacktime=2000, dmg_multiplier=1, unit_flags=16384, unit_class=4, dynamicflags=8, spell1=66218, spell2=66296, spell8=68362, VehicleId=438, RegenHealth=0, mechanic_immune_mask=344407930 WHERE entry=35413;
DELETE FROM npc_spellclick_spells WHERE npc_entry=35413;
INSERT INTO npc_spellclick_spells VALUES (35413, 66245, 1, 0);

-- Glaive Thrower A (34802, 35419)
UPDATE creature_template SET difficulty_entry_1=35419, exp=0, faction=1732, npcflag=16777216, speed_walk=3.2, speed_run=1.14286, unit_flags=16384, AIName="", ScriptName="npc_four_car_garage" WHERE entry=34802;
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=0, faction=1732, npcflag=16777216, speed_walk=3.2, speed_run=1.14286, mindmg=252, maxdmg=357, attackpower=304, baseattacktime=2000, dmg_multiplier=1, unit_flags=16384, unit_class=1, dynamicflags=8, spell1=68827, spell2=69515, VehicleId=447, RegenHealth=0, mechanic_immune_mask=344407930 WHERE entry=35419;
DELETE FROM npc_spellclick_spells WHERE npc_entry=35419;
INSERT INTO npc_spellclick_spells VALUES (35419, 68503, 1, 0);

-- Glaive Thrower H (35273, 35421)
UPDATE creature_template SET difficulty_entry_1=35421, exp=0, faction=1735, npcflag=16777216, speed_walk=3.2, speed_run=1.14286, unit_flags=16384, AIName="", ScriptName="npc_four_car_garage" WHERE entry=35273;
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=0, faction=1735, npcflag=16777216, speed_walk=3.2, speed_run=1.14286, mindmg=252, maxdmg=357, attackpower=304, baseattacktime=2000, dmg_multiplier=1, unit_flags=16384, unit_class=1, dynamicflags=8, spell1=68827, spell2=69515, VehicleId=447, RegenHealth=0, mechanic_immune_mask=344407930 WHERE entry=35421;
DELETE FROM npc_spellclick_spells WHERE npc_entry=35421;
INSERT INTO npc_spellclick_spells VALUES (35421, 68503, 1, 0);

-- Siege Engine A (34776, 35431)
UPDATE creature_template SET difficulty_entry_1=35431, exp=0, faction=1732, npcflag=16777216, speed_walk=1.2, speed_run=1, unit_flags=16384, AIName="", ScriptName="npc_four_car_garage" WHERE entry=34776;
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=0, faction=1732, npcflag=16777216, speed_walk=1.2, speed_run=1, mindmg=252, maxdmg=357, attackpower=304, baseattacktime=2000, dmg_multiplier=1, unit_flags=16384, unit_class=4, dynamicflags=8, spell1=67816, spell2=69502, VehicleId=435, RegenHealth=0, mechanic_immune_mask=344407930 WHERE entry=35431;
DELETE FROM vehicle_template_accessory WHERE entry=34776;
INSERT INTO vehicle_template_accessory VALUES (34776, 34777, 7, 1, 'Isle of Conquest Siege Engine  - main turret (ally)', 6, 30000);
INSERT INTO vehicle_template_accessory VALUES (34776, 34778, 1, 1, 'Isle of Conquest Siege Engine  - flame turret 1 (ally)', 6, 30000);
INSERT INTO vehicle_template_accessory VALUES (34776, 34778, 2, 1, 'Isle of Conquest Siege Engine  - flame turret 2 (ally)', 6, 30000);
DELETE FROM npc_spellclick_spells WHERE npc_entry IN(34776, 35431);
INSERT INTO npc_spellclick_spells VALUES (34776, 66245, 1, 0);
INSERT INTO npc_spellclick_spells VALUES (34776, 46598, 1, 0); -- accessorys
INSERT INTO npc_spellclick_spells VALUES (35431, 66245, 1, 0);
INSERT INTO npc_spellclick_spells VALUES (35431, 46598, 1, 0); -- accessorys
DELETE FROM conditions WHERE SourceTypeOrReferenceId=18 AND SourceGroup IN (34776, 35431);
INSERT INTO conditions VALUES (18, 34776, 66245, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Require player for spellclick');
INSERT INTO conditions VALUES (18, 34776, 46598, 0, 0, 31, 0, 3, 0, 0, 0, 0, 0, '', 'Require unit for spellclick');
INSERT INTO conditions VALUES (18, 35431, 66245, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Require player for spellclick');
INSERT INTO conditions VALUES (18, 35431, 46598, 0, 0, 31, 0, 3, 0, 0, 0, 0, 0, '', 'Require unit for spellclick');

-- Siege Engine H (35069, 35433)
UPDATE creature_template SET difficulty_entry_1=35433, exp=0, faction=1735, npcflag=16777216, speed_walk=1.2, speed_run=1, unit_flags=16384, AIName="", ScriptName="npc_four_car_garage" WHERE entry=35069;
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=0, faction=1735, npcflag=16777216, speed_walk=1.2, speed_run=1, mindmg=252, maxdmg=357, attackpower=304, baseattacktime=2000, dmg_multiplier=1, unit_flags=16384, unit_class=4, dynamicflags=8, spell1=67816, spell2=69502, VehicleId=435, RegenHealth=0, mechanic_immune_mask=344407930 WHERE entry=35433;
DELETE FROM vehicle_template_accessory WHERE entry=35069;
INSERT INTO vehicle_template_accessory VALUES (35069, 36355, 7, 1, 'Isle of Conquest Siege Engine  - main turret (horde)', 6, 30000);
INSERT INTO vehicle_template_accessory VALUES (35069, 36356, 1, 1, 'Isle of Conquest Siege Engine - flame turret 1 (horde)', 6, 30000);
INSERT INTO vehicle_template_accessory VALUES (35069, 36356, 2, 1, 'Isle of Conquest Siege Engine - flame turret 2 (horde)', 6, 30000);
DELETE FROM npc_spellclick_spells WHERE npc_entry IN(35069, 35433);
INSERT INTO npc_spellclick_spells VALUES (35069, 66245, 1, 0);
INSERT INTO npc_spellclick_spells VALUES (35069, 46598, 1, 0); -- accessorys
INSERT INTO npc_spellclick_spells VALUES (35433, 66245, 1, 0);
INSERT INTO npc_spellclick_spells VALUES (35433, 46598, 1, 0); -- accessorys
DELETE FROM conditions WHERE SourceTypeOrReferenceId=18 AND SourceGroup IN (35069, 35433);
INSERT INTO conditions VALUES (18, 35069, 66245, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Require player for spellclick');
INSERT INTO conditions VALUES (18, 35069, 46598, 0, 0, 31, 0, 3, 0, 0, 0, 0, 0, '', 'Require unit for spellclick');
INSERT INTO conditions VALUES (18, 35433, 66245, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Require player for spellclick');
INSERT INTO conditions VALUES (18, 35433, 46598, 0, 0, 31, 0, 3, 0, 0, 0, 0, 0, '', 'Require unit for spellclick');

-- Flame Turret A (34778, 35417)
UPDATE creature_template SET difficulty_entry_1=35417, exp=0, faction=1732, minlevel=70, maxlevel=70, npcflag=16777216, unit_flags=2, unit_class=1, spell1=66183, spell2=66186, VehicleId=436, RegenHealth=0, mechanic_immune_mask=344407930 WHERE entry=34778;
UPDATE creature_template SET exp=0, faction=1732, npcflag=16777216, minlevel=80, maxlevel=80, mindmg=252, maxdmg=357, attackpower=304, baseattacktime=2000, dmg_multiplier=1, unit_flags=2, unit_class=1, spell1=66183, spell2=68832, VehicleId=436, RegenHealth=0, mechanic_immune_mask=344407930 WHERE entry=35417;
DELETE FROM npc_spellclick_spells WHERE npc_entry IN(34778, 35417);
INSERT INTO npc_spellclick_spells VALUES (34778, 67830, 1, 0);
INSERT INTO npc_spellclick_spells VALUES (35417, 67830, 1, 0);

-- Flame Turret H (36356, 36358)
UPDATE creature_template SET difficulty_entry_1=36358, exp=0, faction=1735, minlevel=70, maxlevel=70, npcflag=16777216, unit_flags=2, unit_class=1, spell1=66183, spell2=66186, VehicleId=436, RegenHealth=0, mechanic_immune_mask=344407930 WHERE entry=36356;
UPDATE creature_template SET exp=0, faction=1735, npcflag=16777216, minlevel=80, maxlevel=80, mindmg=252, maxdmg=357, attackpower=304, baseattacktime=2000, dmg_multiplier=1, unit_flags=2, unit_class=1, spell1=66183, spell2=68832, VehicleId=436, RegenHealth=0, mechanic_immune_mask=344407930 WHERE entry=36358;
DELETE FROM npc_spellclick_spells WHERE npc_entry IN(36356, 36358);
INSERT INTO npc_spellclick_spells VALUES (36356, 67830, 1, 0);
INSERT INTO npc_spellclick_spells VALUES (36358, 67830, 1, 0);

-- Siege Turret A (34777, 35436)
UPDATE creature_template SET difficulty_entry_1=35436, exp=0, faction=1732, minlevel=70, maxlevel=70, npcflag=16777216, unit_flags=2, unit_class=1, spell1=67461, spell2=67462, VehicleId=436, RegenHealth=0, mechanic_immune_mask=344407930 WHERE entry=34777;
UPDATE creature_template SET exp=0, faction=1732, npcflag=16777216, minlevel=80, maxlevel=80, mindmg=252, maxdmg=357, attackpower=304, baseattacktime=2000, dmg_multiplier=1, unit_flags=2, unit_class=1, spell1=67461, spell2=67462, VehicleId=436, RegenHealth=0, mechanic_immune_mask=344407930 WHERE entry=35436;
DELETE FROM npc_spellclick_spells WHERE npc_entry IN(34777, 35436);
INSERT INTO npc_spellclick_spells VALUES (34777, 67830, 1, 0);
INSERT INTO npc_spellclick_spells VALUES (35436, 67830, 1, 0);

-- Siege Turret H (36355, 36357)
UPDATE creature_template SET difficulty_entry_1=36357, exp=0, faction=1735, minlevel=70, maxlevel=70, npcflag=16777216, unit_flags=2, unit_class=1, spell1=67461, spell2=67462, VehicleId=436, RegenHealth=0, mechanic_immune_mask=344407930 WHERE entry=36355;
UPDATE creature_template SET exp=0, faction=1735, npcflag=16777216, minlevel=80, maxlevel=80, mindmg=252, maxdmg=357, attackpower=304, baseattacktime=2000, dmg_multiplier=1, unit_flags=2, unit_class=1, spell1=67461, spell2=67462, VehicleId=436, RegenHealth=0, mechanic_immune_mask=344407930 WHERE entry=36357;
DELETE FROM npc_spellclick_spells WHERE npc_entry IN(36355, 36357);
INSERT INTO npc_spellclick_spells VALUES (36355, 67830, 1, 0);
INSERT INTO npc_spellclick_spells VALUES (36357, 67830, 1, 0);

-- Fix Teleports
DELETE FROM spell_linked_spell WHERE spell_trigger IN (66548,66549,66550,66551);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN (66550, 66551);
INSERT INTO conditions VALUES (13, 1, 66550, 0, 0, 31, 0, 3, 22515, 0, 0, 0, 0, '', 'Isle of Conquest - Teleport Fortress Out');
INSERT INTO conditions VALUES (13, 1, 66550, 0, 0, 35, 0, 1, 10, 1, 0, 0, 0, '', 'Isle of Conquest - Teleport Fortress Out');
INSERT INTO conditions VALUES (13, 1, 66551, 0, 0, 31, 0, 3, 22515, 0, 0, 0, 0, '', 'Isle of Conquest - Teleport Fortress In');
INSERT INTO conditions VALUES (13, 1, 66551, 0, 0, 35, 0, 1, 10, 1, 0, 0, 0, '', 'Isle of Conquest - Teleport Fortress In');

SET @CGUID := 90179;
DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+13;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `MovementType`) VALUES
(@CGUID+0, 22515, 628, 3, 1, 392.4965, -859.4583, 48.99871, 3.036873, 7200, 0, 0), -- A IN
(@CGUID+1, 22515, 628, 3, 1, 313.2344, -918.0452, 48.85597, 4.869469, 7200, 0, 0), -- A OUT
(@CGUID+2, 22515, 628, 3, 1, 279.8698, -832.8073, 51.55094, 0, 7200, 0, 0), -- A CENTER
(@CGUID+3, 22515, 628, 3, 1, 323.4965, -883.8021, 48.99959, 1.466077, 7200, 0, 0), -- A IN
(@CGUID+4, 22515, 628, 3, 1, 430.6007, -857.0052, 48.31177, 0.1396263, 7200, 0, 0), -- A OUT
(@CGUID+5, 22515, 628, 3, 1, 325.9167, -781.8993, 49.00521, 4.590216, 7200, 0, 0), -- A IN
(@CGUID+6, 22515, 628, 3, 1, 326.2135, -744.0243, 49.43576, 1.308997, 7200, 0, 0), -- A OUT
(@CGUID+7, 22515, 628, 3, 1, 1139.498, -779.4739, 48.73496, 3.001966, 7200, 0, 0), -- H OUT
(@CGUID+8, 22515, 628, 3, 1, 1162.913, -745.908, 48.71506, 0.1396263, 7200, 0, 0), -- H IN
(@CGUID+9, 22515, 628, 3, 1, 1234.304, -688.2986, 49.22296, 4.677482, 7200, 0, 0), -- H IN
(@CGUID+10, 22515, 628, 3, 1, 1232.524, -666.3246, 48.13402, 2.303835, 7200, 0, 0), -- H OUT
(@CGUID+11, 22515, 628, 3, 1, 1233.106, -838.316, 48.99958, 1.466077, 7200, 0, 0), -- H IN
(@CGUID+12, 22515, 628, 3, 1, 1232.387, -861.0243, 48.99959, 3.560472, 7200, 0, 0), -- H OUT
(@CGUID+13, 22515, 628, 3, 1, 1296.526, -766.1823, 50.70293, 3.089233, 7200, 0, 0); -- H CENTER

-- Fix Transport Vehicles
UPDATE creature SET spawnMask=3, curhealth=50000 WHERE map IN(641, 642); -- Transport NPCs

-- Huge Seaforium Bomb (195332)
-- Huge Seaforium Bomb (195333)
UPDATE gameobject_template SET data3=1 WHERE entry IN(195332, 195333);


-- -------------
-- ACHIEVEMENTS
-- -------------
-- A-bomb-inable (3848)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12066);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12066);
INSERT INTO achievement_criteria_data VALUES(12066, 0, 0, 0, "");
DELETE FROM spell_script_names WHERE spell_id=66676;
INSERT INTO spell_script_names VALUES(66676, "spell_ioc_bomb_blast_criteria");

-- A-bomb-ination (3849)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12067);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12067);
INSERT INTO achievement_criteria_data VALUES(12067, 0, 0, 0, "");
DELETE FROM spell_script_names WHERE spell_id=66672;
INSERT INTO spell_script_names VALUES(66672, "spell_ioc_bomb_blast_criteria");

-- Cut the Blue Wire... No the Red Wire! (3852)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12132);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12132);
INSERT INTO achievement_criteria_data VALUES(12132, 20, 628, 0, "");

-- Back Door Job (3854)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12163);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12163);
INSERT INTO achievement_criteria_data VALUES(12163, 0, 0, 0, "");

-- Isle of Conquest All-Star (3845)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12059, 11487, 11488, 11491);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12059, 11487, 11488, 11491);
INSERT INTO achievement_criteria_data VALUES(12059, 0, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(11487, 0, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(11488, 0, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(11491, 0, 0, 0, "");


-- ------------------------
-- Dalaran Sewers
-- ------------------------
DELETE FROM disables WHERE entry = 10 AND sourceType=3;
-- Water sprout trigger
UPDATE creature_template SET modelid1=11686, modelid2=0 WHERE entry=28567;

-- ------------------------
-- Outdoor PVP
-- ------------------------
-- Eastern Plaguelands
UPDATE gameobject_template SET AIName="SmartGameObjectAI" WHERE entry=181682;
DELETE FROM smart_scripts WHERE entryorguid=181682 AND source_type=1;
INSERT INTO smart_scripts VALUES (181682, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 85, 30238, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Cast spell on click');

-- Zangarmarsh
DELETE FROM gossip_menu_option WHERE menu_id IN(7722, 7724) AND option_id=19;
INSERT INTO gossip_menu_option VALUES(7722, 2, 0, 'Give me the flag!', 19, 1, 0, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES(7724, 2, 0, 'Give me the flag!', 19, 1, 0, 0, 0, 0, '');
DELETE FROM gameobject WHERE id IN(182527, 182528, 182529);

-- -------------------------------------
-- Venture Bay
-- -------------------------------------
REPLACE INTO outdoorpvp_template VALUES(7, 'outdoorpvp_gh', 'Grizzly Hills');
DELETE FROM gameobject WHERE id=189310;
DELETE FROM game_event WHERE eventEntry IN (65, 66);
INSERT INTO game_event VALUES (65, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 5184000, 2592000, 0, 'Venture Bay Alliance Defence', 5); 
INSERT INTO game_event VALUES (66, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 5184000, 2592000, 0, 'Venture Bay Horde Defence', 5);
-- Add Game event spawns for Venture Bay
DELETE FROM game_event_creature WHERE eventEntry IN (65, 66);
DELETE FROM game_event_gameobject WHERE eventEntry IN (65, 66);
INSERT INTO game_event_creature VALUES
-- Alliance
(65, 106209),  -- Commander Howser
(65, 106275),  -- "Grizzly" D. Adams
(65, 102110),  -- Tim Street <Stable Master>
(65, 102293),  -- Jason Riggins <Blacksmithing Supplies>
(65, 106139), (65, 106140), (65, 106141), (65, 106142), (65, 106168), (65, 106169), (65, 106170), (65, 106171), (65, 106172), (65, 106173), (65, 106174), (65, 106175), (65, 106176),  -- Westfall Brigade Defender
(65, 107711), (65, 107712), (65, 107713), (65, 107714),  -- Horse
-- Horde
(66, 85483),   -- General Gorlok
(66, 107018),  -- Purkom
(66, 85484),   -- Kor <Stable Master>
(66, 102366),  -- Koloth <Blacksmithing Supplies>
(66, 86565), (66, 86566), (66, 86567), (66, 86568), (66, 86569), (66, 86570), (66, 86571), (66, 86572), (66, 86573), (66, 86574), (66, 86575), (66, 86651), (66, 86652), (66, 86654),   -- Conquest Hold Defender
(66, 108972), (66, 108973), (66, 108974), (66, 108975); -- Riding Wolf
INSERT INTO game_event_gameobject VALUES
-- Alliance
(65, 59043),  -- Forge
(65, 59616),  -- Blacksmith's Anvil
-- Horde
(66, 59624),  -- Forge
(66, 59029); -- Blacksmith's Anvil
-- -------------------------------------


-- ------------------------
-- Ring of Valor
-- ------------------------

DELETE FROM disables WHERE sourceType=3 AND entry=11;
