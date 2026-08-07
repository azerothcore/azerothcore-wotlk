-- Quest "The Hunter and the Prince" (13400 / 13361): Matthias Lehner (32497) summons Illidan
-- into phase 4 but never phases the player, so Illidan stays invisible and the quest can't be
-- finished. Phase the player on accept and restore on reward, plus a gated out-of-combat pulse
-- for the abandon case, which has no SmartAI event of its own.
DELETE FROM `smart_scripts` WHERE `entryorguid` = 32497 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(32497, 0, 0, 2, 19, 0, 100, 512, 13361, 0, 0, 0, 0, 0, 44, 5, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Matthias Lehner - On Quest Accept (Horde 13361) - Set InGame Phase Mask 5 on Invoker'),
(32497, 0, 1, 2, 19, 0, 100, 512, 13400, 0, 0, 0, 0, 0, 44, 5, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Matthias Lehner - On Quest Accept (Alliance 13400) - Set InGame Phase Mask 5 on Invoker'),
(32497, 0, 2, 3, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 50, 194023, 50, 0, 0, 0, 0, 8, 0, 0, 0, 0, 6335.5, 2347.8, 477.23, 3.4, 'Matthias Lehner - Linked - Summon GO 194023'),
(32497, 0, 3, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 12, 31395, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 0, 6314.5, 2342.8, 479.4, 0.22, 'Matthias Lehner - Linked - Summon Creature Illidan Stormrage (31395) for 60s'),
(32497, 0, 4, 0, 20, 0, 100, 512, 13400, 0, 0, 0, 0, 0, 44, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Matthias Lehner - On Quest Reward (Alliance 13400) - Restore InGame Phase Mask 1 on Invoker'),
(32497, 0, 5, 0, 20, 0, 100, 512, 13361, 0, 0, 0, 0, 0, 44, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Matthias Lehner - On Quest Reward (Horde 13361) - Restore InGame Phase Mask 1 on Invoker'),
(32497, 0, 6, 0, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 0, 0, 44, 1, 0, 0, 0, 0, 0, 17, 50, 0, 0, 0, 0, 0, 0, 0, 'Matthias Lehner - OOC Pulse - Restore Phase Mask 1 for players who abandoned the quest');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceGroup` = 0 AND `SourceEntry` = 32497 AND `SourceId` = 6;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 0, 32497, 6, 0, 26, 1, 4, 0, 0, 0, 0, 0, '', 'Player currently has phase 4 (Illidan phase)'),
(22, 0, 32497, 6, 0, 9, 1, 13400, 0, 0, 1, 0, 0, '', 'Player does NOT have quest 13400 active'),
(22, 0, 32497, 6, 0, 9, 1, 13361, 0, 0, 1, 0, 0, '', 'Player does NOT have quest 13361 active');
