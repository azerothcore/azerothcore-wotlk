INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632248054324754400');

UPDATE creature_template SET AIName='' WHERE entry IN (2338,2339);
UPDATE creature_template SET ScriptName='npc_twilight_discipline_thug' WHERE entry IN (2338,2339);

