
-- Timber creature ID
SET @ENTRY := 1132;

-- Updating all spawnpoint
UPDATE `creature` SET `spawntimesecs` = 2700 WHERE `guid` IN (3154, 134483, 134484) AND `id1` = @ENTRY;
