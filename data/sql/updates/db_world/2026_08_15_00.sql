-- DB update 2026_08_13_02 -> 2026_08_15_00
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|2097152 WHERE (`entry` IN (29375, 29503, 28793));
