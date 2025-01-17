-- DB update 2024_11_07_02 -> 2024_11_07_03
-- Ephemeral Snowflake
UPDATE `spell_proc_event` SET `Cooldown` = 250 WHERE `entry` = 71567;
