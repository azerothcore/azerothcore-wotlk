INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642085410673517853');

UPDATE `acore_string` SET `content_default`="Player selected NPC\nDB GUID: %u, current GUID: %u.\nCurrent Entry: %u of (%u, %u).\nChance of First Entry: %u percent.\nDisplayID: %u (Native: %u).\nFaction: %u.\nnpcFlags: %u." WHERE `entry`=539;
UPDATE `acore_string` SET `locale_zhCN`='当前选择NPC属性\nDB GUID: %u,目前 GUID: %u.\n阵营: %u 的  (%u, %u).\n第一次进入的机会：%u 百分率.\n外观ID: %u (Native: %u).\n编号: %u.\nNPC标识: %u.\n' WHERE  `entry`=539;
