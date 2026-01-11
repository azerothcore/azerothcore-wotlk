-- DB update 2024_12_30_01 -> 2024_12_30_02
--
-- Eagle Trash Aggro Trigger
UPDATE `creature_template` SET `ScriptName` = '' WHERE (`entry` = 24223);
-- set spawntime to 30min Amani'shi Tempest
UPDATE `creature` SET `spawntimesecs` = 1800 WHERE (`id1` = 24549) AND (`guid` IN (89283));
-- delete Amani'shi Wind Walker #5 next to Tempest
DELETE FROM `creature` WHERE (`id1` = 24179) AND (`guid` IN (1107));
-- delete Amani'shi Protector #5 next to Tempest
DELETE FROM `creature` WHERE (`id1` = 24180) AND (`guid` IN (89311));
DELETE FROM `creature_addon` WHERE `guid` IN (1107, 89311);
DELETE FROM `linked_respawn` WHERE `guid` IN (1107, 89311);
