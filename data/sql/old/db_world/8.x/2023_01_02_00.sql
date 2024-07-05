-- DB update 2023_01_01_07 -> 2023_01_02_00
--
UPDATE `smart_scripts` SET `target_type`=2, `comment`='Crypt Guard - In Combat - CastVictim Acid Spit' WHERE `entryorguid`=16573 AND `source_type`=0 AND `id` IN (1,2) AND `link`=0;

