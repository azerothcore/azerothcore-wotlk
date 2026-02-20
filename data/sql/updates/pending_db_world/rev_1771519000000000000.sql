-- Fix spell_pal_illumination bound to wrong spell (-20234 = Improved Lay on Hands instead of -20210 = Illumination)
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_pal_illumination';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (-20210, 'spell_pal_illumination');
