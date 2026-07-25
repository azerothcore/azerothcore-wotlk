-- DB update 2026_06_16_07 -> 2026_06_17_00
-- Garwal
UPDATE `creature_template` SET `faction` = 1971 WHERE (`entry` = 24277);

-- 43062 - Garwal's Invisibility
UPDATE `spell_dbc` SET `Effect_1` = 6, `EffectBasePoints_1` = 999, `EffectAura_1` = 18, `EffectMiscValue_1` = 8, `ImplicitTargetA_1` = 1
WHERE (`ID` = 43062);
