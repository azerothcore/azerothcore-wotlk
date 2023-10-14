DROP TABLE IF EXISTS `acore_world`.`forge_mythic_level_scale`;
CREATE TABLE `acore_world`.`forge_mythic_level_scale` (
  `challengeLevel` smallint unsigned NOT NULL AUTO_INCREMENT,
  `mod` float NOT NULL DEFAULT 1,
  PRIMARY KEY (`challengeLevel`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(1, 1.0);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(2, 1.1);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(3, 1.21);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(4, 1.331);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(5, 1.4641);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(6, 1.61051);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(7, 1.77156);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(8, 1.94872);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(9, 2.14359);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(10, 2.35795);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(11, 2.59374);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(12, 2.85312);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(13, 3.13843);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(14, 3.45227);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(15, 3.7975);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(16, 4.17725);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(17, 4.59497);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(18, 5.05447);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(19, 5.55992);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(20, 6.11591);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(21, 6.7275);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(22, 7.40025);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(23, 8.14028);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(24, 8.9543);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(25, 9.84973);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(26, 10.8347);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(27, 11.9182);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(28, 13.11);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(29, 14.421);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(30, 15.8631);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(31, 17.4494);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(32, 19.1943);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(33, 21.1138);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(34, 23.2252);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(35, 25.5477);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(36, 28.1024);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(37, 30.9127);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(38, 34.0039);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(39, 37.4043);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(40, 41.1448);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(41, 45.2593);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(42, 49.7852);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(43, 54.7637);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(44, 60.2401);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(45, 66.2641);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(46, 72.8905);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(47, 80.1795);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(48, 88.1975);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(49, 97.0172);
INSERT INTO acore_world.forge_mythic_level_scale (challengeLevel, `mod`) VALUES(50, 106.719);

DROP TABLE IF EXISTS `acore_world`.`forge_mythic_minion_value`;
CREATE TABLE `acore_world`.`forge_mythic_minion_value` (
  `instance` int unsigned NOT NULL,
  `unit` int unsigned NOT NULL,
  `value` float NOT NULL DEFAULT '0.1',
  PRIMARY KEY (`instance`,`unit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO acore_world.forge_mythic_minion_value (`instance`, unit, value) VALUES(389, 11320, 1.0);

DROP TABLE IF EXISTS `acore_world`.`forge_mythic_criteria`;
CREATE TABLE `acore_world`.`forge_mythic_criteria` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `instance` int unsigned NOT NULL DEFAULT '0',
  `type` smallint unsigned NOT NULL DEFAULT '0',
  `value` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO acore_world.forge_mythic_criteria (id, `instance`, `type`, value) VALUES(1, 389, 0, 11520);
INSERT INTO acore_world.forge_mythic_criteria (id, `instance`, `type`, value) VALUES(2, 389, 1, 5);

DELETE FROM acore_world.itemrandomsuffix_dbc where ID in (102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150)
INSERT INTO acore_world.itemrandomsuffix_dbc (ID, Name_Lang_enUS, Name_Lang_enGB, Name_Lang_koKR, Name_Lang_frFR, Name_Lang_deDE, Name_Lang_enCN, Name_Lang_zhCN, Name_Lang_enTW, Name_Lang_zhTW, Name_Lang_esES, Name_Lang_esMX, Name_Lang_ruRU, Name_Lang_ptPT, Name_Lang_ptBR, Name_Lang_itIT, Name_Lang_Unk, Name_Lang_Mask, InternalName, Enchantment_1, Enchantment_2, Enchantment_3, Enchantment_4, Enchantment_5, AllocationPct_1, AllocationPct_2, AllocationPct_3, AllocationPct_4, AllocationPct_5) 
VALUES 
(102, '+2' , NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+2' , 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(103, '+3' , NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+3' , 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(104, '+4' , NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+4' , 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(105, '+5' , NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+5' , 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(106, '+6' , NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+6' , 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(107, '+7' , NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+7' , 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(108, '+8' , NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+8' , 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(109, '+9' , NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+9' , 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(110, '+10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+10', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(111, '+11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+11', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(112, '+12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+12', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(113, '+13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+13', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(114, '+14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+14', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(115, '+15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+15', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(116, '+16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+16', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(117, '+17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+17', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(118, '+18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+18', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(119, '+19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+19', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(120, '+20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+20', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(121, '+21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+21', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(122, '+22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+22', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(123, '+23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+23', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(124, '+24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+24', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(125, '+25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+25', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(126, '+26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+26', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(127, '+27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+27', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(128, '+28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+28', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(129, '+29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+29', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(130, '+30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+30', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(131, '+31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+31', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(132, '+32', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+32', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(133, '+33', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+33', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(134, '+34', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+34', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(135, '+35', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+35', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(136, '+36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+36', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(137, '+37', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+37', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(138, '+38', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+38', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(139, '+39', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+39', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(140, '+40', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+40', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(141, '+41', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+41', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(142, '+42', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+42', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(143, '+43', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+43', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(144, '+44', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+44', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(145, '+45', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+45', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(146, '+46', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+46', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(147, '+47', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+47', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(148, '+48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+48', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(149, '+49', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+49', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(150, '+50', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, 'm+50', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

INSERT INTO acore_world.gameobject_template (entry, `type`, displayId, name, IconName, castBarCaption, unk1, `size`, Data0, Data1, Data2, Data3, Data4, Data5, Data6, Data7, Data8, Data9, Data10, Data11, Data12, Data13, Data14, Data15, Data16, Data17, Data18, Data19, Data20, Data21, Data22, Data23, AIName, ScriptName, VerifiedBuild) VALUES(1000001, 3, 259, 'Reward Chest', '', '', '', 1.0, 57, 2283, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 12340);
INSERT INTO acore_world.gameobject_template (entry, `type`, displayId, name, IconName, castBarCaption, unk1, `size`, Data0, Data1, Data2, Data3, Data4, Data5, Data6, Data7, Data8, Data9, Data10, Data11, Data12, Data13, Data14, Data15, Data16, Data17, Data18, Data19, Data20, Data21, Data22, Data23, AIName, ScriptName, VerifiedBuild) VALUES(1000000, 2, 475, 'Ancient Brazier', '', '', '', 1.0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 'go_mythic_init', 12340);

DROP TABLE IF EXISTS `acore_world`.`forge_mythic_affixes`;
CREATE TABLE `acore_world`.`forge_mythic_affixes` (
  `affix` bigint unsigned NOT NULL,
  `tier` int unsigned NOT NULL,
  `timer_increment` int NOT NULL,
  PRIMARY KEY (`affix`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO acore_world.forge_mythic_affixes (affix, tier, timer_increment) VALUES(1, 1, 300);
INSERT INTO acore_world.forge_mythic_affixes (affix, tier, timer_increment) VALUES(3, 2, 300);
INSERT INTO acore_world.forge_mythic_affixes (affix, tier, timer_increment) VALUES(5, 3, 300);

DROP TABLE IF EXISTS `acore_world`.`forge_mythic_instance_key`;
CREATE TABLE `acore_world`.`forge_mythic_instance_key` (
  `instance` bigint unsigned NOT NULL,
  `keyid` int unsigned NOT NULL,
  `base_timer` bigint unsigned NOT NULL,
  PRIMARY KEY (`instance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO acore_world.forge_mythic_instance_key (`instance`, keyid, base_timer) VALUES(34, 138028, 1800);
INSERT INTO acore_world.forge_mythic_instance_key (`instance`, keyid, base_timer) VALUES(70, 138023, 1800);
INSERT INTO acore_world.forge_mythic_instance_key (`instance`, keyid, base_timer) VALUES(209, 138024, 1800);
INSERT INTO acore_world.forge_mythic_instance_key (`instance`, keyid, base_timer) VALUES(389, 138019, 1800);

