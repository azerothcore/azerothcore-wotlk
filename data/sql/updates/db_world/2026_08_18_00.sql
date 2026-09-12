-- DB update 2026_08_17_01 -> 2026_08_18_00
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|64 WHERE (`entry` IN (26570, 26852, 26583));
