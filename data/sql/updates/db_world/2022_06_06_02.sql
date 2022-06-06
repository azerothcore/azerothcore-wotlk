-- DB update 2022_06_06_01 -> 2022_06_06_02
-- Flame Leviathan add mising Boss Emote (15 and above)
DELETE FROM `creature_text` WHERE `CreatureID` = 33113;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(33113, 0, 0, 'Hostile entities detected. Threat assessment protocol active. Primary target engaged. Time minus 30 seconds to re-evaluation.', 14, 0, 100, 0, 0, 15506, 33487, 0, 'Flame Leviathan SAY_AGGRO'),
(33113, 1, 0, 'Threat assessment routine modified. Current target threat level: 0. Acquiring new target.', 14, 0, 100, 0, 0, 15521, 33507, 0, 'Flame Leviathan SAY_SLAY'),
(33113, 2, 0, 'Total systems failure. Defense protocols breached. Leviathan unit shutting down.', 14, 0, 100, 0, 0, 15520, 33506, 0, 'Flame Leviathan SAY_DEATH'),
(33113, 3, 0, 'Threat re-evaluated. Target assessment complete. Changing course.', 14, 0, 100, 0, 0, 15507, 33488, 0, 'Flame Leviathan SAY_TARGET_1'),
(33113, 3, 1, 'Pursuit objective modified. Changing course.', 14, 0, 100, 0, 0, 15508, 33489, 0, 'Flame Leviathan SAY_TARGET_2'),
(33113, 3, 2, 'Hostile entity\'s stratagem predicted. Re-routing battle function. Changing course.', 14, 0, 100, 0, 0, 15509, 33490, 0, 'Flame Leviathan SAY_TARGET_3'),
(33113, 4, 0, 'Orbital countermeasures enabled.', 14, 0, 100, 0, 0, 15510, 33491, 0, 'Flame Leviathan SAY_HARDMODE'),
(33113, 5, 0, '*ALERT* Static defense system failure. Orbital countermeasures disabled.', 14, 0, 100, 0, 0, 15511, 33492, 0, 'Flame Leviathan SAY_TOWER_NONE'),
(33113, 6, 0, 'Hodir\'s Fury online. Acquiring target.', 14, 0, 100, 0, 0, 15512, 33493, 0, 'Flame Leviathan SAY_TOWER_FROST'),
(33113, 7, 0, 'Mimiron\'s Inferno online. Acquiring target.', 14, 0, 100, 0, 0, 15513, 33495, 0, 'Flame Leviathan SAY_TOWER_FLAME'),
(33113, 8, 0, 'Freya\'s Ward online. Acquiring target.', 14, 0, 100, 0, 0, 15514, 33497, 0, 'Flame Leviathan SAY_TOWER_NATURE'),
(33113, 9, 0, 'Thorim\'s Hammer online. Acquiring target.', 14, 0, 100, 0, 0, 15515, 33499, 0, 'Flame Leviathan SAY_TOWER_STORM'),
(33113, 10, 0, 'Unauthorized entity attempting circuit overload. Activating anti-personnel countermeasures.', 14, 0, 100, 0, 0, 15516, 33501, 0, 'Flame Leviathan SAY_PLAYER_RIDING'),
(33113, 11, 0, 'System malfunction. Diverting power to support systems.', 14, 0, 100, 0, 0, 15517, 33503, 0, 'Flame Leviathan SAY_OVERLOAD_1'),
(33113, 11, 1, 'Combat matrix overload. Powering doooow...', 14, 0, 100, 0, 0, 15518, 33504, 0, 'Flame Leviathan SAY_OVERLOAD_2'),
(33113, 11, 2, 'System restart required. Deactivating weapons systems.', 14, 0, 100, 0, 0, 15519, 33505, 0, 'Flame Leviathan SAY_OVERLOAD_3'),
(33113, 12, 0, '%s pursues $n.', 41, 0, 100, 0, 0, 0, 33502, 0, 'Flame Leviathan EMOTE_PURSUE'),
(33113, 13, 0, '%s\'s circuits overloaded.', 41, 0, 100, 0, 0, 0, 33304, 0, 'Flame Leviathan EMOTE_OVERLOAD'),
(33113, 14, 0, 'Automatic repair sequence initiated.', 41, 0, 100, 0, 0, 0, 33538, 0, 'Flame Leviathan EMOTE_REPAIR'),
(33113, 15, 0, '%s activates Hodir\'s Fury.', 41, 0, 100, 0, 0, 0, 33494, 0, 'Flame Leviathan EMOTE_FROST'),
(33113, 16, 0, '%s activates Mimiron\'s Inferno.', 41, 0, 100, 0, 0, 0, 33496, 0, 'Flame Leviathan EMOTE_FLAME'),
(33113, 17, 0, '%s activates Freya\'s Ward.', 41, 0, 100, 0, 0, 0, 33498, 0, 'Flame Leviathan EMOTE_NATURE'),
(33113, 18, 0, '%s activates Thorim\'s Hammer.', 41, 0, 100, 0, 0, 0, 33500, 0, 'Flame Leviathan EMOTE_STORM'),
(33113, 19, 0, '%s reactivated. Resuming combat functions.', 41, 0, 100, 0, 0, 0, 33305, 0, 'Flame Leviathan EMOTE_REACTIVATE');

-- Bronzebeard Radio remove equipment (floating pickaxe)
DELETE FROM `creature_equip_template` WHERE `CreatureID` = 34054;

-- Bronzebeard Radio move hardcode to DB (previously empty)
DELETE FROM `creature_text` WHERE `CreatureID` = 34054;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(34054, 0, 0, 'You\'ve done it! You\'ve broken the defenses of Ulduar. In a few moments, we will be dropping in to...', 12, 0, 100, 0, 0, 15804, 34154, 3, 'Bronzebeard Radio SAY_FL_START_0'),
(34054, 1, 0, 'What is that? Be careful! Something\'s headed your way!', 12, 0, 100, 0, 0, 15805, 34155, 3, 'Bronzebeard Radio SAY_FL_START_1'),
(34054, 2, 0, 'Quicly! Evasive action! Evasive act--', 12, 0, 100, 0, 0, 15806, 34156, 3, 'Bronzebeard Radio SAY_FL_START_2'),
(34054, 3, 0, 'There are four generators powering the defense structures. If you sabotage the generators, the missile attacks will stop!', 12, 0, 100, 0, 0, 15796, 34147, 3, 'Bronzebeard Radio SAY_FL_GENERATORS'),
(34054, 4, 0, 'It appears you are near a repair station! Drive your vehicle onto the platform, and it should be automatically repaired.', 12, 0, 100, 0, 0, 15803, 34153, 3, 'Bronzebeard Radio SAY_STATIONS'),
(34054, 5, 0, 'Ah, the tower of Krolmir. It is said that the power of Thorim has been used only once... and that it turned an entire continent to dust.', 12, 0, 100, 0, 0, 15801, 34151, 3, 'Bronzebeard Radio SAY_TOWER_THORIM'),
(34054, 6, 0, 'This tower powers the Hammer of Hodir. It is said to have the power to turn entire armies to ice!', 12, 0, 100, 0, 0, 15797, 34148, 3, 'Bronzebeard Radio SAY_TOWER_HODIR'),
(34054, 7, 0, 'You\'re approaching the tower of Freya. It contains the power to turn barren wastelands into jungles teeming with life overnight.', 12, 0, 100, 0, 0, 15798, 34149, 3, 'Bronzebeard Radio SAY_TOWER_FREYA'),
(34054, 8, 0, 'This generator powers Mimiron\'s Gaze. In moments, it can turn earth to ash, stone to magma--we cannot let it reach full power!', 12, 0, 100, 0, 0, 15799, 34150, 3, 'Bronzebeard Radio SAY_TOWER_MIMIRON');
