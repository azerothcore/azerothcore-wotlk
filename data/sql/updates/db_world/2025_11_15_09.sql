-- DB update 2025_11_15_08 -> 2025_11_15_09

UPDATE `creature_template` SET `flags_extra` = `flags_extra` |128 WHERE (`entry` = 25739);
