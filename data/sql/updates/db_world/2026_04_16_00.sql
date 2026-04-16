-- DB update 2026_04_15_01 -> 2026_04_16_00
--
-- Ball of Flames Proc (ICC Prince Valanar):
-- ensure the spell script is registered so the new AuraScript
-- decrements a stack each time the ball hits a player.
DELETE FROM `spell_script_names` WHERE `spell_id` IN (71756, 72782, 72783, 72784) AND `ScriptName`='spell_taldaram_ball_of_inferno_flame';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(71756, 'spell_taldaram_ball_of_inferno_flame'),
(72782, 'spell_taldaram_ball_of_inferno_flame'),
(72783, 'spell_taldaram_ball_of_inferno_flame'),
(72784, 'spell_taldaram_ball_of_inferno_flame');
