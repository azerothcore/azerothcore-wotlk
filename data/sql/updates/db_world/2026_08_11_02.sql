-- DB update 2026_08_11_01 -> 2026_08_11_02
-- No spell has these as credit, so the flag is likely correct here
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|2097152 WHERE (`entry` IN (29978, 29984));
