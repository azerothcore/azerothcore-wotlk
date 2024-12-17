--
-- Eagle Trash Aggro Trigger
UPDATE `creature_template` SET `ScriptName` = '' WHERE (`entry` = 24223);
-- set spawntime to 30min Amani'shi Tempest
UPDATE `creature` SET `spawntimesecs` = 1800 WHERE (`id1` = 24549) AND (`guid` IN (89283));
