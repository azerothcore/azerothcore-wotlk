-- DB update 2026_06_18_02 -> 2026_06_18_03
--
-- Hodir: Flash Freeze should not be Bleed-immune (let Warriors apply Rend).
-- Move to preset -361 (identical to -369 but without the BLEED mechanic).
UPDATE `creature_template` SET `CreatureImmunitiesId` = -361 WHERE `entry` IN (32926, 32938, 33352, 33353);
