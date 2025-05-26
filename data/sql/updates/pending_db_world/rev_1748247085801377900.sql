--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`&~(4), `flags_extra` = `flags_extra`|2147483648 WHERE (`entry` IN (29310,31465));
