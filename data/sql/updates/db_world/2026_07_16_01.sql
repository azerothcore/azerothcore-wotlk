-- DB update 2026_07_16_00 -> 2026_07_16_01
-- Aerial Command Unit: hover height and flags to match TDB (hover-based chase)
-- 256 = UNIT_FLAG_IMMUNE_TO_PC (cleared by script at phase start), 512 = CREATURE_FLAG_EXTRA_NO_MOVE_FLAGS_UPDATE
UPDATE `creature_template` SET `HoverHeight` = 15, `unit_flags` = `unit_flags`|256, `flags_extra` = `flags_extra`|512 WHERE `entry` IN (33670, 34109);

-- Values ported from TrinityCore (TrinityCore/TrinityCore@7c13b383); zeroed combat reach
-- made the hovering ACU unreachable for Magnetic Core's 15y check
UPDATE `creature_model_info` SET `BoundingRadius` = 0.31, `CombatReach` = 5 WHERE `DisplayID` = 28979;
