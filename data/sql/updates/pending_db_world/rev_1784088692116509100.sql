-- Aerial Command Unit: hover height and flags to match TDB (hover-based chase)
-- 256 = UNIT_FLAG_IMMUNE_TO_PC (cleared by script at phase start), 512 = CREATURE_FLAG_EXTRA_NO_MOVE_FLAGS_UPDATE
UPDATE `creature_template` SET `HoverHeight` = 15, `unit_flags` = `unit_flags`|256, `flags_extra` = `flags_extra`|512 WHERE `entry` IN (33670, 34109);
