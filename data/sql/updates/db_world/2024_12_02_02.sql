-- DB update 2024_12_02_01 -> 2024_12_02_02
-- Critter: 883, 890, 2098, 2620, 1933, 4166, 721, 2442, 10780, 12298, 5951, 17467, 12296, 17467
-- Human Royal Guard... : 1756 loot probably incorrect as well, I assume it came from the transformed guards for the Onyxia quest

UPDATE `creature_template` SET `skinloot` = 0 WHERE `entry` IN (883, 890, 2098, 2620, 1933, 4166, 721, 2442, 10780, 12298, 5951, 17467, 12296, 17467, 1756);

DELETE FROM `skinning_loot_template` WHERE `entry` IN (883, 890, 2098, 2620, 1933, 4166, 721, 2442, 10780, 12298, 5951, 17467, 12296, 17467, 1756);
