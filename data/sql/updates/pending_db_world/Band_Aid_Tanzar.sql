
DELETE FROM `creature` WHERE `id1` = 23790;
DELETE FROM `creature_addon` WHERE (`guid` IN (89157));
UPDATE `gameobject_template` SET `Data15` = `Data15`|1 WHERE (`entry` = 186648);
