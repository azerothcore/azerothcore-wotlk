CREATE TABLE `guildhouses` (
  `id` int(16) unsigned NOT NULL AUTO_INCREMENT,
  `guildId` bigint(20) NOT NULL DEFAULT '0',
  `x` double NOT NULL,
  `y` double NOT NULL,
  `z` double NOT NULL,
  `map` int(16) NOT NULL,
  `comment` varchar(255) NOT NULL DEFAULT '',
  `price` bigint(20) NOT NULL DEFAULT '0',
  `faction` int(8) unsigned NOT NULL DEFAULT '3',
  `minguildsize` int(16) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

CREATE TABLE `guildhouses_add` (
  `guid` int(32) unsigned NOT NULL,
  `type` int(16) unsigned NOT NULL,
  `id` int(16) unsigned NOT NULL,
  `add_type` int(16) unsigned NOT NULL,
  `comment` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`guid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

CREATE TABLE `guildhouses_addtype` (
  `add_type` int(16) unsigned NOT NULL,
  `comment` varchar(255) NOT NULL DEFAULT '',
  `price` bigint(20) NOT NULL DEFAULT '1000',
  `minguildsize` int(16) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`add_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;


TRUNCATE table guildhouses;
TRUNCATE table guildhouses_addtype;


INSERT INTO `guildhouses_addtype` (`add_type`,`comment`,`price`,`minguildsize`) VALUES (2,'Guardia',8000,30);
INSERT INTO `guildhouses_addtype` (`add_type`,`comment`,`price`,`minguildsize`) VALUES (3,'oggetti lavori',1500,30);
INSERT INTO `guildhouses_addtype` (`add_type`,`comment`,`price`,`minguildsize`) VALUES (4,'pvp',1000,30);
INSERT INTO `guildhouses_addtype` (`add_type`,`comment`,`price`,`minguildsize`) VALUES (5,'manichini',1500,30);
INSERT INTO `guildhouses_addtype` (`add_type`,`comment`,`price`,`minguildsize`) VALUES (6,'vendor',2500,30);
INSERT INTO `guildhouses_addtype` (`add_type`,`comment`,`price`,`minguildsize`) VALUES (7,'vendor speciali',4000,30);
INSERT INTO `guildhouses_addtype` (`add_type`,`comment`,`price`,`minguildsize`) VALUES (8,'extra',6500,30);
INSERT INTO `guildhouses_addtype` (`add_type`,`comment`,`price`,`minguildsize`) VALUES (9,'Custom NPC',8500,30);


CREATE TABLE `custom_npc_tele_association` (
  `cat_id` double DEFAULT NULL,
  `dest_id` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `custom_npc_tele_category` (
  `id` double DEFAULT NULL,
  `name` varchar(2295) DEFAULT NULL,
  `flag` tinyint(3) DEFAULT NULL,
  `data0` double DEFAULT NULL,
  `data1` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `custom_npc_tele_destination` (
  `id` double DEFAULT NULL,
  `name` varchar(900) DEFAULT NULL,
  `pos_X` float DEFAULT NULL,
  `pos_Y` float DEFAULT NULL,
  `pos_Z` float DEFAULT NULL,
  `map` double DEFAULT NULL,
  `orientation` float DEFAULT NULL,
  `level` tinyint(3) DEFAULT NULL,
  `cost` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

TRUNCATE table `custom_npc_tele_association` ;
TRUNCATE table `custom_npc_tele_category` ;
TRUNCATE table `custom_npc_tele_destination` ;

INSERT INTO `custom_npc_tele_category` (`id`,`name`,`flag`,`data0`,`data1`) VALUES (1,'[Instances Lvl 1-60]',0,0,0);
INSERT INTO `custom_npc_tele_category` (`id`,`name`,`flag`,`data0`,`data1`) VALUES (2,'[Instances Lvl 70+]',5,70,0);

INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,1);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,2);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,3);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,4);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,5);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,6);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,7);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,8);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,9);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,10);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,11);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,12);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,13);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,14);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,15);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,16);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,17);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,18);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,19);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,20);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,21);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (2,22);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (2,23);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (2,24);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (2,25);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (2,26);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (2,27);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (2,28);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (2,53);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (2,29);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,30);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,31);
INSERT INTO `custom_npc_tele_association` (`cat_id`,`dest_id`) VALUES (1,32);

INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (1,'Blackfathom Deeps',4254.58,664.74,-29.04,1,1.97,20,2);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (2,'Blackrock Depths',-7301.03,-913.19,165.37,0,0.08,55,5);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (3,'Blackrock Spire',-7535.43,-1212.04,285.45,0,5.29,58,5);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (4,'Blackwing Lair',-7665.55,-1102.49,400.679,469,0,60,5);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (5,'Maraudon',-1433.33,2955.34,96.21,1,4.82,43,5);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (6,'Molten Core',1121.45,-454.317,-101.33,230,3.5,60,5);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (7,'Naxxramas',3125.18,-3748.02,136.049,0,0,80,15);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (8,'Onyxia\'s Lair',-4707.44,-3726.82,54.6723,1,3.8,80,15);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (9,'Razorfen Downs',-4645.08,-2470.85,85.53,1,4.39,33,2);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (10,'Razorfen Kraul',-4484.04,-1739.4,86.47,1,1.23,25,2);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (11,'Ruins of Ahn\'Qiraj',-8409.03,1498.83,27.3615,1,2.49757,60,5);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (12,'Scholomance',1219.01,-2604.66,85.61,0,0.5,58,5);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (13,'Shadowfang Keep',-254.47,1524.68,76.89,0,1.56,18,2);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (14,'Stratholme',3263.54,-3379.46,143.59,0,0,58,5);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (15,'Temple of Ahn\'Qiraj',-8245.84,1983.74,129.072,1,0.936195,60,5);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (16,'The Deadmines',-11212,1658.58,25.67,0,1.45,15,2);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (17,'The Scarlet Monastery',2843.89,-693.74,139.32,0,5.11,34,2);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (18,'The Sunken Temple',-10346.9,-3851.9,-43.41,0,6.09,49,5);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (19,'The Wailing Caverns',-722.53,-2226.3,16.94,1,2.71,15,2);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (20,'Zul\'Farrak',-6839.39,-2911.03,8.87,1,0.41,43,5);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (21,'Zul\'Gurub',-11916.7,-1212.82,92.2868,0,4.6095,60,5);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (22,'Black Temple',-3610.72,324.988,37.4,530,3.28298,70,10);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (23,'Coilfang Reservoir',517.288,6976.28,32.0072,530,0,62,10);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (24,'Gruul\'s Lair',3539.01,5082.36,1.69107,530,0,70,10);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (25,'Hellfire Citadel',-305.816,3056.4,-2.47318,530,2.01,60,5);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (26,'Isle Of Quel\'Danas',12947.4,-6893.31,5.68398,530,3.09154,70,10);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (27,'Karazhan',-11118.8,-2010.84,47.0807,0,0,70,10);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (28,'Tempest Keep',3089.58,1399.05,187.653,530,4.79407,70,10);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (29,'Zul\'Aman',6846.95,-7954.5,170.028,530,4.61501,70,10);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (30,'Dire Maul',-3960.9,1129.01,162,1,0,55,5);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (31,'Gnomeregan',-5165.83,910.62,258,0,0,24,2);
INSERT INTO `custom_npc_tele_destination` (`id`,`name`,`pos_X`,`pos_Y`,`pos_Z`,`map`,`orientation`,`level`,`cost`) VALUES (32,'Uldaman',-6156.02,-2952.88,211,0,0,36,2);


INSERT IGNORE INTO `creature_template` (`entry`,`difficulty_entry_1`,`difficulty_entry_2`,`difficulty_entry_3`,`KillCredit1`,`KillCredit2`,`modelid1`,`modelid2`,`modelid3`,`modelid4`,`name`,`subname`,`IconName`,`gossip_menu_id`,`minlevel`,`maxlevel`,`exp`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`rank`,`mindmg`,`maxdmg`,`dmgschool`,`attackpower`,`dmg_multiplier`,`baseattacktime`,`rangeattacktime`,`unit_class`,`unit_flags`,`unit_flags2`,`dynamicflags`,`family`,`trainer_type`,`trainer_spell`,`trainer_class`,`trainer_race`,`minrangedmg`,`maxrangedmg`,`rangedattackpower`,`type`,`type_flags`,`lootid`,`pickpocketloot`,`skinloot`,`resistance1`,`resistance2`,`resistance3`,`resistance4`,`resistance5`,`resistance6`,`spell1`,`spell2`,`spell3`,`spell4`,`spell5`,`spell6`,`spell7`,`spell8`,`PetSpellDataId`,`VehicleId`,`mingold`,`maxgold`,`AIName`,`MovementType`,`InhabitType`,`HoverHeight`,`Health_mod`,`Mana_mod`,`Armor_mod`,`RacialLeader`,`questItem1`,`questItem2`,`questItem3`,`questItem4`,`questItem5`,`questItem6`,`movementId`,`RegenHealth`,`mechanic_immune_mask`,`flags_extra`,`ScriptName`,`VerifiedBuild`) VALUES (60005,0,0,0,0,0,7112,0,0,0,'Goblin Guildbuilder','From the lands of Trilogy...',NULL,0,80,80,2,35,1,1.44,1.14286,1.5,1,0,0,0,0,0,0,0,1,64,0,8,0,0,0,0,0,20,30,4,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,'NullAI',1,3,1,3,1,1,0,0,0,0,0,0,0,0,1,0,0,'guildmaster',11403);
INSERT IGNORE INTO `creature_template` (`entry`,`difficulty_entry_1`,`difficulty_entry_2`,`difficulty_entry_3`,`KillCredit1`,`KillCredit2`,`modelid1`,`modelid2`,`modelid3`,`modelid4`,`name`,`subname`,`IconName`,`gossip_menu_id`,`minlevel`,`maxlevel`,`exp`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`rank`,`mindmg`,`maxdmg`,`dmgschool`,`attackpower`,`dmg_multiplier`,`baseattacktime`,`rangeattacktime`,`unit_class`,`unit_flags`,`unit_flags2`,`dynamicflags`,`family`,`trainer_type`,`trainer_spell`,`trainer_class`,`trainer_race`,`minrangedmg`,`maxrangedmg`,`rangedattackpower`,`type`,`type_flags`,`lootid`,`pickpocketloot`,`skinloot`,`resistance1`,`resistance2`,`resistance3`,`resistance4`,`resistance5`,`resistance6`,`spell1`,`spell2`,`spell3`,`spell4`,`spell5`,`spell6`,`spell7`,`spell8`,`PetSpellDataId`,`VehicleId`,`mingold`,`maxgold`,`AIName`,`MovementType`,`InhabitType`,`HoverHeight`,`Health_mod`,`Mana_mod`,`Armor_mod`,`RacialLeader`,`questItem1`,`questItem2`,`questItem3`,`questItem4`,`questItem5`,`questItem6`,`movementId`,`RegenHealth`,`mechanic_immune_mask`,`flags_extra`,`ScriptName`,`VerifiedBuild`) VALUES (60006,0,0,0,0,0,30226,0,0,0,'Buff Man','God of Buff','',0,80,80,2,35,1,1,1.14286,1.1,1,463,640,0,726,7.5,0,0,1,0,0,0,0,0,0,0,0,360,520,91,7,104,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'',0,3,1,40,40,1,0,0,0,0,0,0,0,151,1,617299803,0,'buffnpc',11723);
INSERT IGNORE INTO `creature_template` (`entry`,`difficulty_entry_1`,`difficulty_entry_2`,`difficulty_entry_3`,`KillCredit1`,`KillCredit2`,`modelid1`,`modelid2`,`modelid3`,`modelid4`,`name`,`subname`,`IconName`,`gossip_menu_id`,`minlevel`,`maxlevel`,`exp`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`rank`,`mindmg`,`maxdmg`,`dmgschool`,`attackpower`,`dmg_multiplier`,`baseattacktime`,`rangeattacktime`,`unit_class`,`unit_flags`,`unit_flags2`,`dynamicflags`,`family`,`trainer_type`,`trainer_spell`,`trainer_class`,`trainer_race`,`minrangedmg`,`maxrangedmg`,`rangedattackpower`,`type`,`type_flags`,`lootid`,`pickpocketloot`,`skinloot`,`resistance1`,`resistance2`,`resistance3`,`resistance4`,`resistance5`,`resistance6`,`spell1`,`spell2`,`spell3`,`spell4`,`spell5`,`spell6`,`spell7`,`spell8`,`PetSpellDataId`,`VehicleId`,`mingold`,`maxgold`,`AIName`,`MovementType`,`InhabitType`,`HoverHeight`,`Health_mod`,`Mana_mod`,`Armor_mod`,`RacialLeader`,`questItem1`,`questItem2`,`questItem3`,`questItem4`,`questItem5`,`questItem6`,`movementId`,`RegenHealth`,`mechanic_immune_mask`,`flags_extra`,`ScriptName`,`VerifiedBuild`) VALUES (60007,0,0,0,0,0,10921,0,0,0,'Portal Seeker','He Finds It',NULL,0,80,80,0,35,1,1.63,1.14286,1.35,0,89,119,0,218,1,1420,1562,1,0,0,8,0,0,0,0,0,62,91,22,7,0,5981,5981,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,89,121,'',1,3,1,1.3,1,1,0,0,0,0,0,0,0,0,1,0,0,'portal_npc',1);
INSERT IGNORE INTO `creature_template` (`entry`,`difficulty_entry_1`,`difficulty_entry_2`,`difficulty_entry_3`,`KillCredit1`,`KillCredit2`,`modelid1`,`modelid2`,`modelid3`,`modelid4`,`name`,`subname`,`IconName`,`gossip_menu_id`,`minlevel`,`maxlevel`,`exp`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`rank`,`mindmg`,`maxdmg`,`dmgschool`,`attackpower`,`dmg_multiplier`,`baseattacktime`,`rangeattacktime`,`unit_class`,`unit_flags`,`unit_flags2`,`dynamicflags`,`family`,`trainer_type`,`trainer_spell`,`trainer_class`,`trainer_race`,`minrangedmg`,`maxrangedmg`,`rangedattackpower`,`type`,`type_flags`,`lootid`,`pickpocketloot`,`skinloot`,`resistance1`,`resistance2`,`resistance3`,`resistance4`,`resistance5`,`resistance6`,`spell1`,`spell2`,`spell3`,`spell4`,`spell5`,`spell6`,`spell7`,`spell8`,`PetSpellDataId`,`VehicleId`,`mingold`,`maxgold`,`AIName`,`MovementType`,`InhabitType`,`HoverHeight`,`Health_mod`,`Mana_mod`,`Armor_mod`,`RacialLeader`,`questItem1`,`questItem2`,`questItem3`,`questItem4`,`questItem5`,`questItem6`,`movementId`,`RegenHealth`,`mechanic_immune_mask`,`flags_extra`,`ScriptName`,`VerifiedBuild`) VALUES (5000000,0,0,0,0,0,16042,0,0,0,'TeleGuy','Teleport Service','',0,70,70,2,35,1,1,1.14286,1,0,252,357,0,304,1,2000,0,1,32768,0,0,0,0,0,0,0,215,320,44,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'',0,3,1,1,1,1,0,0,0,0,0,0,0,0,1,0,0,'npc_teleport',0);
INSERT IGNORE INTO `creature_template` (`entry`,`difficulty_entry_1`,`difficulty_entry_2`,`difficulty_entry_3`,`KillCredit1`,`KillCredit2`,`modelid1`,`modelid2`,`modelid3`,`modelid4`,`name`,`subname`,`IconName`,`gossip_menu_id`,`minlevel`,`maxlevel`,`exp`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`rank`,`mindmg`,`maxdmg`,`dmgschool`,`attackpower`,`dmg_multiplier`,`baseattacktime`,`rangeattacktime`,`unit_class`,`unit_flags`,`unit_flags2`,`dynamicflags`,`family`,`trainer_type`,`trainer_spell`,`trainer_class`,`trainer_race`,`minrangedmg`,`maxrangedmg`,`rangedattackpower`,`type`,`type_flags`,`lootid`,`pickpocketloot`,`skinloot`,`resistance1`,`resistance2`,`resistance3`,`resistance4`,`resistance5`,`resistance6`,`spell1`,`spell2`,`spell3`,`spell4`,`spell5`,`spell6`,`spell7`,`spell8`,`PetSpellDataId`,`VehicleId`,`mingold`,`maxgold`,`AIName`,`MovementType`,`InhabitType`,`HoverHeight`,`Health_mod`,`Mana_mod`,`Armor_mod`,`RacialLeader`,`questItem1`,`questItem2`,`questItem3`,`questItem4`,`questItem5`,`questItem6`,`movementId`,`RegenHealth`,`mechanic_immune_mask`,`flags_extra`,`ScriptName`,`VerifiedBuild`) VALUES (5000003,0,0,0,0,0,18966,18967,18968,18969,'Guild Agent','BodyGuard','',0,70,70,2,35,1,1,1.14286,1.2,0,252,357,0,304,1,2000,0,1,32768,0,0,0,0,0,0,0,215,320,44,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'',0,3,1,1,1,1,0,0,0,0,0,0,0,0,1,650854235,0,'guild_guard',0);
INSERT IGNORE INTO `creature_template` (`entry`,`difficulty_entry_1`,`difficulty_entry_2`,`difficulty_entry_3`,`KillCredit1`,`KillCredit2`,`modelid1`,`modelid2`,`modelid3`,`modelid4`,`name`,`subname`,`IconName`,`gossip_menu_id`,`minlevel`,`maxlevel`,`exp`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`rank`,`mindmg`,`maxdmg`,`dmgschool`,`attackpower`,`dmg_multiplier`,`baseattacktime`,`rangeattacktime`,`unit_class`,`unit_flags`,`unit_flags2`,`dynamicflags`,`family`,`trainer_type`,`trainer_spell`,`trainer_class`,`trainer_race`,`minrangedmg`,`maxrangedmg`,`rangedattackpower`,`type`,`type_flags`,`lootid`,`pickpocketloot`,`skinloot`,`resistance1`,`resistance2`,`resistance3`,`resistance4`,`resistance5`,`resistance6`,`spell1`,`spell2`,`spell3`,`spell4`,`spell5`,`spell6`,`spell7`,`spell8`,`PetSpellDataId`,`VehicleId`,`mingold`,`maxgold`,`AIName`,`MovementType`,`InhabitType`,`HoverHeight`,`Health_mod`,`Mana_mod`,`Armor_mod`,`RacialLeader`,`questItem1`,`questItem2`,`questItem3`,`questItem4`,`questItem5`,`questItem6`,`movementId`,`RegenHealth`,`mechanic_immune_mask`,`flags_extra`,`ScriptName`,`VerifiedBuild`) VALUES (5000004,0,0,0,0,0,18966,18967,18968,18969,'Guild Agent','BodyGuard','',0,70,70,2,35,1,1,1.14286,1.2,0,252,357,0,304,1,2000,0,1,32768,0,0,0,0,0,0,0,215,320,44,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'',0,3,1,1,1,1,0,0,0,0,0,0,0,0,1,0,0,'guild_guard',0);
