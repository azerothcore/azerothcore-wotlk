-- DB update 2026_03_27_03 -> 2026_03_27_04
--
-- School immunities are set by `creature_addon.auras` immunity auras
UPDATE `creature_template` SET `CreatureImmunitiesId` = -367 WHERE (`entry` = 8317);
