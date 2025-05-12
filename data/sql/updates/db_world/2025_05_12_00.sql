-- DB update 2025_05_10_04 -> 2025_05_12_00

-- Add No_Taunt flag
UPDATE `creature_template` SET `flags_extra` = `flags_extra` |256 WHERE (`entry` = 25315);
