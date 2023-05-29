-- DB update 2022_05_08_05 -> 2022_05_08_06
--
DELETE FROM `spell_dbc` WHERE `id` = 1206;
INSERT INTO `spell_dbc` (`Id`, `Targets`, `CastingTimeIndex`, `ProcChance`, `RangeIndex`, `EquippedItemClass`, `EquippedItemSubclass`, `Effect_1`, `ImplicitTargetA_1`, `EffectTriggerSpell_1`, `Name_Lang_enUS`, `EffectBonusMultiplier_1`, `EffectBonusMultiplier_2`, `EffectBonusMultiplier_3`) VALUES
(1206, 256, 1, 101, 1, -1, -1, 3, 1, 11, 'Dummy Proc', 1, 1, 1);
