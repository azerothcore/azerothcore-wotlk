-- DB update 2022_05_23_01 -> 2022_05_23_02
--
UPDATE `spell_proc_event` SET `procFlags`=0x1|0x20000 WHERE `entry`=-34914;
