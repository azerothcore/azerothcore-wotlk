-- DB update 2023_10_17_07 -> 2023_10_18_00
-- midsummer creatureAI npc_midsummer_ribbon_pole_target
UPDATE `creature_template` SET `ScriptName` = 'npc_midsummer_ribbon_pole_target' WHERE `entry` = 17066;

-- midsummer NPC Big Dancing Flame - SmartAI - fire dance spell
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 26267;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 26267);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26267, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 45418, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Big Dancing Flames - On Just Summoned - Cast Spell \'Fire Dancing\'');

-- midsummer add spell script spell_midsummer_ribbon_pole_firework
DELETE FROM `spell_script_names` WHERE `spell_id` = 46847;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(46847, 'spell_midsummer_ribbon_pole_firework');
