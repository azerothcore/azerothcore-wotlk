-- DB update 2025_04_13_02 -> 2025_04_13_03
-- Set immune to taunt
UPDATE `creature_template` SET `flags_extra` = `flags_extra` |256 WHERE (`entry` = 25840);
