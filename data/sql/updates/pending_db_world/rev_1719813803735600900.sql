-- Quest: Protecting Our Own
UPDATE `quest_template` SET `RequiredNpcOrGo1` = 21142 WHERE (`ID` = 10488);
UPDATE `creature_template_addon` SET `auras` = '37691' WHERE (`entry` = 20748);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20748);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20748, 0, 0, 0, 0, 0, 100, 0, 3000, 8000, 11000, 15000, 0, 0, 11, 5781, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Thunderlord Dire Wolf - In Combat - Cast \'Threatening Growl\''),
(20748, 0, 1, 2, 8, 0, 100, 0, 32578, 0, 0, 0, 0, 0, 33, 21142, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Thunderlord Dire Wolf - On Target Spellhit \'Gor`drek`s Ointment\' - Quest Credit \'Protecting Our Own\''),
(20748, 0, 2, 0, 61, 0, 50, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Thunderlord Dire Wolf - On Target Spellhit \'Gor`drek`s Ointment\' - Start Attacking (50%)');

DELETE FROM `spell_custom_attr` WHERE `spell_id`=32578;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (32578, 2048);

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = 32578);

UPDATE `item_template` SET `ScriptName` = '' WHERE (`entry` = 30175);

DELETE FROM `spell_script_names` WHERE `spell_id`=32578 AND `ScriptName`='spell_item_gor_dreks_ointment';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (32578, 'spell_item_gor_dreks_ointment');
