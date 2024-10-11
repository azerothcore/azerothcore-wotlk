-- DB update 2022_11_02_01 -> 2022_11_03_00
--
UPDATE `gameobject` SET `spawntimesecs`=0 WHERE `id` IN (184466, 185302) AND `guid` IN (25331, 28524);
