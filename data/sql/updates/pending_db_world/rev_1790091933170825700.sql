-- XT-002 Deconstructor: keep toy pile adds out of the scrap heaps
DELETE FROM `spell_script_names` WHERE `spell_id` IN (62828, 62831, 62835) AND `ScriptName` = 'spell_xt002_recharge_robot';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(62828, 'spell_xt002_recharge_robot'),
(62831, 'spell_xt002_recharge_robot'),
(62835, 'spell_xt002_recharge_robot');
