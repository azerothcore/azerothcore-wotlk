-- DB update 2023_10_21_00 -> 2023_10_21_01
-- Duplicated gossip option
DELETE FROM `gossip_menu_option` WHERE (`MenuID` = 10316) AND (`OptionID` = 1);

DELETE FROM `spell_script_names` WHERE `spell_id`=62536 AND `ScriptName`='spell_frog_kiss';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(62536, 'spell_frog_kiss');
