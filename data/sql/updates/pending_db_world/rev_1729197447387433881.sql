--
-- Fel Reaver Sentinel
UPDATE `creature_template` SET `unit_flags` = `unit_flags`|32768|256 WHERE (`entry` = 21949);
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_fel_reaver_sentinel' WHERE (`entry` = 21949);

-- charm spells
UPDATE `spell_linked_spell` SET `spell_effect`=38121 WHERE `spell_trigger`=38120;
UPDATE `spell_linked_spell` SET `spell_effect`=38123 WHERE `spell_trigger`=38122;
UPDATE `spell_linked_spell` SET `spell_effect`=38126 WHERE `spell_trigger`=38125;
UPDATE `spell_linked_spell` SET `spell_effect`=38128 WHERE `spell_trigger`=38127;
UPDATE `spell_linked_spell` SET `spell_effect`=38130 WHERE `spell_trigger`=38129;

DELETE FROM `spell_script_names` WHERE `spell_id` = 38054 AND `ScriptName`='spell_random_rocket_missile';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES(38054, 'spell_random_rocket_missile');
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 38054);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 38054, 0, 0, 31, 0, 5, 184979, 0, 0, 0, 0, '', 'Random Rocket Missile only target Deathforged Infernal');
