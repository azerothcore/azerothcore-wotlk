INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640360229533606283');

-- Strashaz Myrmidon never had loot for quest 8970
-- this via sniff. creature_questitem is not WDB
-- stop trusting wowhead, loot table is dialuted
DELETE FROM `creature_questitem` WHERE  `CreatureEntry`=4368 AND `Idx`=0;
