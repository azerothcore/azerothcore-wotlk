-- Eye of Grillok
UPDATE `spell_dbc` SET `Effect_1` = 164,`EffectTriggerSpell_1` = 38495 WHERE (`ID` = 38529);

DELETE FROM `spell_script_names` WHERE `spell_id`=38554;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(38554, 'spell_item_eye_of_grillok');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = 38554);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 22177);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22177, 0, 0, 1, 8, 0, 100, 512, 38530, 0, 0, 0, 0, 0, 33, 22177, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Grillok Quest Credit Bunny - On Spellhit \'Quest Credit for Eye of Grillok\' - Quest Credit 10813'),
(22177, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 38529, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Grillok Quest Credit Bunny - On Spellhit \'Quest Credit for Eye of Grillok\' - Cast \'Serverside - Cancel Eye of Grillok\'');
