-- Remove Orphan Matron Aria duplicate in dalaran
DELETE FROM `creature` WHERE `id1` = 34365 AND `guid` = 245000;
