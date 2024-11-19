-- DB update 2023_12_12_16 -> 2023_12_24_00
-- Spell Bomb
UPDATE `spell_proc_event` SET `Cooldown`=1000 WHERE `entry`=40303;
