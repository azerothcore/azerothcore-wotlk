-- Remove Orphan Matron Aria duplicate in dalaran
DELETE FROM `creature` WHERE `id1` = 34365 AND `guid` IN (245000);