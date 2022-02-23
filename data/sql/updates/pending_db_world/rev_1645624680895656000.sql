INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1645624680895656000');

-- Add gossip flag to Expedition Commander, previously was 0
UPDATE creature_template SET npcflag = 1 WHERE entry IN (33210,34254);