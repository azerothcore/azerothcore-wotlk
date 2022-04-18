INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1644537932629642900');

UPDATE `creature_template` SET `AIName` = "SmartAI" WHERE `entry` = 23569;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 23569 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23569, 0, 0, 1, 62, 0, 100, 0, 8837, 0, 0, 0, 11, 42670, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Renn McGill - On Gossip Option Select - Cast Replace Repaired Diving Gear'),
(23569, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Renn McGill - On Gossip Option Select - Close Gossip');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup` = 8837;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15, 8837, 0, 0, 0, 9, 0, 11140, 0, 0, 0, 0, '', 'Requires Quest Taken'),
(15, 8837, 0, 0, 0, 2, 0, 33040, 1, 0, 1, 0, '', 'Requires Missing Item');
