SET @SAY_APPROACH = 0,
@SAY_AGGRO = 1,
@SAY_SUMMON = 2;

DELETE FROM `areatrigger_scripts` WHERE `entry` IN (5014, 5015);
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES
(5014, 'at_karazhan_mirkblood_approach'),
(5015, 'at_karazhan_mirkblood_entrance');

UPDATE `creature_template` SET `ScriptName` = 'boss_tenris_mirkblood' WHERE `entry` = 28194;

DELETE FROM `creature_text` WHERE `CreatureID` = 28194;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(28194, @SAY_APPROACH, 0, 'I smell... $r.  Delicious!', 14, 0, 100, 0, 0, 0, 27780, 0, 'Prince Tenris Mirkblood - SAY_APPROACH'), -- Nothing sniffed, types need verification
(28194, @SAY_AGGRO, 0, 'I shall consume you!', 14, 0, 100, 0, 0, 0, 27781, 0, 'Prince Tenris Mirkblood - SAY_AGGRO'),
(28194, @SAY_SUMMON, 0, 'Drink, mortals!  Taste my blood!  Taste your death!', 12, 0, 100, 0, 0, 0, 27712, 0, 'Prince Tenris Mirkblood - SAY_SUMMON');

DELETE FROM `spell_script_names` WHERE `spell_id` IN (50845, 50883, 50925, 50996);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(50845, 'spell_mirkblood_blood_mirror'),
(50883, 'spell_mirkblood_blood_mirror_target_picker'),
(50925, 'spell_mirkblood_dash_gash_return_to_tank_pre_spell'),
(50996, 'spell_mirkblood_summon_sanguine_spirit');

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = -50845 AND `spell_effect` = -50844;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(-50845, -50844, 0, 'Tenris Mirkblood Blood Mirror');