-- DB update 2023_07_19_03 -> 2023_07_19_04
--
UPDATE `spell_proc_event` SET `Cooldown` = 50000 WHERE `entry` = 37655;
UPDATE `spell_proc_event` SET `Cooldown` = 40000 WHERE `entry` = 37247;
UPDATE `spell_proc_event` SET `Cooldown` = 50000 WHERE `entry` = 60066;
UPDATE `spell_proc_event` SET `Cooldown` = 2000  WHERE `entry` = 15600;

UPDATE `spell_proc_event` SET `procEx` = 262144 WHERE `entry` = 37655;
UPDATE `item_template` SET `spellcooldown_2` = -1 WHERE (`entry` = 28823);
