-- DB update 2026_01_20_03 -> 2026_01_21_00
--
UPDATE `creature_loot_template` SET `Chance` = 100 WHERE  `Entry` IN (24664, 24857) AND `Item` = 35008 AND `Reference` = 35008;

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 10) AND (`SourceGroup` = 35008) AND (`ConditionTypeOrReference` = 7) AND (`ConditionValue2` = 1);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(10, 35008, 35304, 0, 0, 7, 0, 755, 1, 0, 0, 0, 0, '', 'Player must have Jewelcrafting to loot BoP version of this Design'),
(10, 35008, 35305, 0, 0, 7, 0, 755, 1, 0, 0, 0, 0, '', 'Player must have Jewelcrafting to loot BoP version of this Design'),
(10, 35008, 35306, 0, 0, 7, 0, 755, 1, 0, 0, 0, 0, '', 'Player must have Jewelcrafting to loot BoP version of this Design'),
(10, 35008, 35307, 0, 0, 7, 0, 755, 1, 0, 0, 0, 0, '', 'Player must have Jewelcrafting to loot BoP version of this Design'),
(10, 35008, 35297, 0, 0, 7, 0, 333, 1, 0, 0, 0, 0, '', 'Player must have Enchanting to loot BoP version of this Formula'),
(10, 35008, 35298, 0, 0, 7, 0, 333, 1, 0, 0, 0, 0, '', 'Player must have Enchanting to loot BoP version of this Formula'),
(10, 35008, 35299, 0, 0, 7, 0, 333, 1, 0, 0, 0, 0, '', 'Player must have Enchanting to loot BoP version of this Formula'),
(10, 35008, 35300, 0, 0, 7, 0, 165, 1, 0, 0, 0, 0, '', 'Player must have Leatherworking to loot BoP version of this Pattern'),
(10, 35008, 35301, 0, 0, 7, 0, 165, 1, 0, 0, 0, 0, '', 'Player must have Leatherworking to loot BoP version of this Pattern'),
(10, 35008, 35302, 0, 0, 7, 0, 165, 1, 0, 0, 0, 0, '', 'Player must have Leatherworking to loot BoP version of this Pattern'),
(10, 35008, 35303, 0, 0, 7, 0, 165, 1, 0, 0, 0, 0, '', 'Player must have Leatherworking to loot BoP version of this Pattern'),
(10, 35008, 35308, 0, 0, 7, 0, 197, 1, 0, 0, 0, 0, '', 'Player must have Tailoring to loot BoP version of this Pattern'),
(10, 35008, 35309, 0, 0, 7, 0, 197, 1, 0, 0, 0, 0, '', 'Player must have Tailoring to loot BoP version of this Pattern'),
(10, 35008, 35296, 0, 0, 7, 0, 164, 1, 0, 0, 0, 0, '', 'Player must have Blacksmithing to loot BoP version of these Plans'),
(10, 35008, 35294, 0, 0, 7, 0, 171, 1, 0, 0, 0, 0, '', 'Player must have Alchemy to loot BoP version of this Recipe'),
(10, 35008, 35295, 0, 0, 7, 0, 171, 1, 0, 0, 0, 0, '', 'Player must have Alchemy to loot BoP version of this Recipe'),
(10, 35008, 35310, 0, 0, 7, 0, 202, 1, 0, 0, 0, 0, '', 'Player must have Engineering to loot BoP version of this Schematic'),
(10, 35008, 35311, 0, 0, 7, 0, 202, 1, 0, 0, 0, 0, '', 'Player must have Engineering to loot BoP version of this Schematic');
