INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1611180684314340400');

DELETE FROM `spell_script_names` WHERE `spell_id` = 75731;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(75731, 'spell_item_instant_statue');
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 40246;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (74890, -75731);
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(74890, 75055, 0, 'Instant Statue'),
(-75731, -74890, 0, 'Instant Statue'),
(-75731, -75055, 0, 'Instant Statue');
