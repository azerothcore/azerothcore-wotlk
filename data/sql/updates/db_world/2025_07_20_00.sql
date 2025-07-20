-- DB update 2025_07_19_01 -> 2025_07_20_00
--
UPDATE `spell_dbc` SET `Attributes`=`Attributes`|64, `AttributesEx4`=34603008, `ProcChance`=101, `DurationIndex`=21,
`Effect_1`=6, `Effect_2`=6, `Effect_3`=6, `EffectBasePoints_1`=-1, `EffectBasePoints_2`=-1, `EffectBasePoints_3`=-1,
`ImplicitTargetA_1`=1, `ImplicitTargetA_2`=1, `ImplicitTargetA_3`=1,
`EffectAura_1`=29, `EffectAura_2`=29, `EffectAura_3`=189,
`EffectMultipleValue_1`=1.0, `EffectMultipleValue_2`=1.0, `EffectMultipleValue_3`=1.0,
`EffectMiscValue_1`=3, `EffectMiscValue_2`=4, `EffectMiscValue_3`=114688
WHERE `ID`=67557;
DELETE FROM `spell_script_names` WHERE `spell_id` = 67557;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(67557, 'spell_pet_intellect_spirit_resilience_scaling');
UPDATE `creature_template_addon` SET `auras` = '' WHERE (`entry` = 27829);
