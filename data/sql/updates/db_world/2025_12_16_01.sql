-- DB update 2025_12_16_00 -> 2025_12_16_01
-- Raven's Wood Ent shouldn't exist in world, only spawnable via a spell.
DELETE FROM `creature` WHERE `id1` = 21853;
