INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1612520952274785900');

-- Lower respawns to improve quests Find the Gems and Power Source & Find the Gems

UPDATE `gameobject` SET `spawntimesecs`=2 WHERE `guid` IN
(
40694, -- Shadowforge Cache
40695  -- Conspicuous Urn
);
