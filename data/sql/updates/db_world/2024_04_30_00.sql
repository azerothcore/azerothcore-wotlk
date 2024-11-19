-- DB update 2024_04_29_00 -> 2024_04_30_00
UPDATE `creature` SET `spawntimesecs`=2700 WHERE `guid` IN (3154, 134483, 134484) AND `id1`=1132;
