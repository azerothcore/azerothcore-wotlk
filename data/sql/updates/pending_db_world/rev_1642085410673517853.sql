INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642085410673517853');

UPDATE `acore_string` SET `content_default`="Player selected NPC\nDB GUID: %u, current GUID: %u.\nCurrent Entry: %u of (%u, %u).\nChance of First Entry: %u percent.\nDisplayID: %u (Native: %u).\nFaction: %u.\nnpcFlags: %u." WHERE `entry`=539;
UPDATE `acore_string` SET `locale_frFR`='PNJ sélectionné par le joueur\nGUID en base: %u, GUID actuel: %u.\nEntry actuel: %u de (%u, %u).\nProbabilité de spawn de la première Entry: %u pour cent.\nDisplayID: %u (Natif: %u).\nFaction: %u.\nnpcFlags: %u.' WHERE  `entry`=539;
UPDATE `acore_string` SET `locale_deDE`='Vom Spieler gewählter NPC\nDB GUID: %u, aktuelle GUID: %u.\nAktueller Entry: %u von (%u, %u).\nChance auf ersten Entry: %u Prozent.\nDisplayID: %u (Ursprünglich: %u).\nFraktion: %u.\nnpcFlags: %u.' WHERE  `entry`=539;
UPDATE `acore_string` SET `locale_zhCN`='当前选择NPC属性\nDB GUID: %u,目前 GUID: %u.\n阵营: %u 的  (%u, %u).\n第一次进入的机会：%u 百分率.\n外观ID: %u (Native: %u).\n编号: %u.\nNPC标识: %u.' WHERE  `entry`=539;
