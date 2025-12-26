-- DB update 2025_05_29_00 -> 2025_05_29_01
--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`&~(4), `flags_extra` = `flags_extra`|2147483648 WHERE (`entry` IN (29310,31465));
