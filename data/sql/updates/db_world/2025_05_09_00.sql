-- DB update 2025_05_05_00 -> 2025_05_09_00
-- Wrath Enforcer
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|2097152 WHERE (`entry` = 25030);
