-- DB update 2024_12_28_00 -> 2024_12_28_01
--
UPDATE `spell_dbc`
SET `Attributes`=`Attributes`|64, `AttributesEx4`=34603008, `ProcChance`=101, `DurationIndex`=21,
`Effect_1`=6, `Effect_2`=6, `Effect_3`=6, `EffectBasePoints_1`=-1, `EffectBasePoints_2`=-1, `EffectBasePoints_3`=-1,
`ImplicitTargetA_1`=1, `ImplicitTargetA_2`=1, `ImplicitTargetA_3`=1,
`EffectAura_1`=55, `EffectAura_2`=240, `EffectAura_3`=123,
`EffectMultipleValue_1`=1.0, `EffectMultipleValue_2`=1.0, `EffectMultipleValue_3`=1.0,
`EffectMiscValue_3`=124
WHERE `ID`=67561;
DELETE FROM `spell_script_names` WHERE `spell_id` IN (49040, 67561);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(49040, 'spell_dk_army_of_the_dead_passive'),
(67561, 'spell_pet_spellhit_expertise_spellpen_scaling');
