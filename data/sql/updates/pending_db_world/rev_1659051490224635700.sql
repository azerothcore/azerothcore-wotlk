--
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_item_freeze_rookery_egg';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(15748, 'spell_item_freeze_rookery_egg'), -- item
(16028, 'spell_item_freeze_rookery_egg'); -- quest

UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 175124;

DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 175124);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(175124, 1, 0, 1, 8, 0, 100, 256, 0, 0, 0, 0, 0, 202, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rookery Egg - On Spellhit \'null\' - Set GO state to 0 (GO_STATE_ACTIVE)'), -- effect open lock
(175124, 1, 1, 0, 61, 0, 100, 256, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rookery Egg - On Spellhit \'null\' - Despawn In 1000 ms');
