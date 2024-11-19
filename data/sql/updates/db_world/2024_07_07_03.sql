-- DB update 2024_07_07_02 -> 2024_07_07_03
-- Talon King Ikiss - interrupt immunity
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|33554432 WHERE (`entry` IN (18473,20706));
