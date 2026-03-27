--
-- School immunities are set by `creature_addon.auras` immunity auras
DELETE FROM `creature_immunities` WHERE `ID` = -368; -- only used by 8317
UPDATE `creature_template` SET `CreatureImmunitiesId` = '-367' WHERE (`entry` = 8317);
