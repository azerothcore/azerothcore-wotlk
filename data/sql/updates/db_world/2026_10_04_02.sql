-- DB update 2026_10_04_01 -> 2026_10_04_02
--
-- Isle of Conquest: Horde Siege Engine turrets in the level 80 bracket (the vehicle kit uses the difficulty entry)
DELETE FROM `vehicle_template_accessory` WHERE `entry` = 35433;
INSERT INTO `vehicle_template_accessory` (`entry`, `accessory_entry`, `seat_id`, `minion`, `description`, `summontype`, `summontimer`) VALUES
(35433, 36356, 1, 1, 'Isle of Conquest Siege Engine - flame turret 1 (horde, level 80)', 6, 30000),
(35433, 36356, 2, 1, 'Isle of Conquest Siege Engine - flame turret 2 (horde, level 80)', 6, 30000),
(35433, 36355, 7, 1, 'Isle of Conquest Siege Engine - main turret (horde, level 80)', 6, 30000);

-- Isle of Conquest: Siege Engines lost the seat 1 flame turret when a player took the driver seat
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 18 AND `SourceGroup` IN (34776, 35069, 35431, 35433) AND `SourceEntry` = 46598;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(18, 34776, 46598, 0, 0, 31, 0, 3, 0, 0, 0, 0, 0, '', 'Only npc for spellclick'),
(18, 35069, 46598, 0, 0, 31, 0, 3, 0, 0, 0, 0, 0, '', 'Only npc for spellclick'),
(18, 35431, 46598, 0, 0, 31, 0, 3, 0, 0, 0, 0, 0, '', 'Only npc for spellclick'),
(18, 35433, 46598, 0, 0, 31, 0, 3, 0, 0, 0, 0, 0, '', 'Only npc for spellclick');
