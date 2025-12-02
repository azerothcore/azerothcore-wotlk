
-- Remove double spawn point
DELETE FROM `creature` WHERE (`id1` = 32250) AND (`guid` IN (125031));
