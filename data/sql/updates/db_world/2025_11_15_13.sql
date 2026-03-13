-- DB update 2025_11_15_12 -> 2025_11_15_13
--
DELETE FROM `spell_proc_event` WHERE `entry`= 45278;
INSERT INTO `spell_proc_event` (`entry`, `procFlags`) VALUES
(45278, 0x00004400|0x00010000);
