ALTER TABLE `creature`
    CHANGE COLUMN `spawntimesecs` `SpawnTimeSecMin` int unsigned NOT NULL DEFAULT '120',
    ADD COLUMN `SpawnTimeSecMax` int unsigned NOT NULL DEFAULT '120' AFTER `SpawnTimeSecMin`;

UPDATE `creature` SET `SpawnTimeSecMax` = `SpawnTimeSecMin`;

ALTER TABLE `gameobject`
    CHANGE COLUMN `spawntimesecs` `SpawnTimeSecMin` int NOT NULL DEFAULT '0',
    ADD COLUMN `SpawnTimeSecMax` int NOT NULL DEFAULT '0' AFTER `SpawnTimeSecMin`;

UPDATE `gameobject` SET `SpawnTimeSecMax` = `SpawnTimeSecMin`;

UPDATE `acore_string` SET `content_default`='SpawnTime: {}s - {}s Remain:{}' WHERE `entry` = 582;
