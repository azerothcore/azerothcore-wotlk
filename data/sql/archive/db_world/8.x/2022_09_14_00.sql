-- DB update 2022_09_13_03 -> 2022_09_14_00
--
UPDATE `spell_proc_event` SET `Cooldown`=0 WHERE `entry`=-16256;
UPDATE `spell_proc_event` SET `Cooldown`=500 WHERE `entry`=-16257;

