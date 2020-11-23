INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1606102990713316100');

-- Imported from TrinityCore by Voxstrasza

-- The Lich King Timed Actionlist
DELETE FROM `smart_scripts` WHERE (source_type = 9 AND entryorguid = 25462 * 100);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25462 * 100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 4, 14734, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'In Service of the Lich King - Quest Accept - Play Sound 14734'),
(25462 * 100, 9, 1, 0, 0, 0, 100, 0, 21000, 21000, 0, 0, 4, 14735, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'In Service of the Lich King - Quest Accept - Play Sound 14735'),
(25462 * 100, 9, 2, 0, 0, 0, 100, 0, 26000, 26000, 0, 0, 4, 14736, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'In Service of the Lich King - Quest Accept - Play Sound 14736');

-- The Lich King Timed Actionlist Trigger
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 25462);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25462, 0, 0, 0, 19, 0, 100, 0, 12593, 0, 0, 0, 80, 2546200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'In Service of the Lich King - Quest Accept - Play Sound');

-- 'In Service of The Lich King' quest details
DELETE FROM `quest_details` WHERE `ID` = 12593;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `EmoteDelay1`, `VerifiedBuild`) VALUES
(12593, 396, 397, 396, 396, 500, 1000, 1000, 1000, 20886);

