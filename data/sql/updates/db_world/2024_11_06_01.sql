-- DB update 2024_11_06_00 -> 2024_11_06_01
UPDATE `spell_dbc` SET `Effect_1` = 6, `EffectAura_1` = 56 WHERE `ID` IN (44918, 44919, 44920, 44921, 44922, 44923, 44924, 44925, 44926, 44927, 44928, 44929, 44930, 44931, 44932, 44962, 45155, 45156, 45157, 45158, 45159, 45160, 45161, 45162, 45163, 45164, 45165, 45166, 45167, 45168, 45169, 45170);

-- All below ordered as follows:
-- Blood Elf ♀
-- Blood Elf ♂
-- Draenei ♀
-- Draenei ♂

-- Phase/Tier 1
--    Marksman
UPDATE `spell_dbc` SET `EffectMiscValue_1` = 24942 WHERE `ID` = 44921;
UPDATE `spell_dbc` SET `EffectMiscValue_1` = 24963 WHERE `ID` = 44962;
UPDATE `spell_dbc` SET `EffectMiscValue_1` = 24950 WHERE `ID` = 44929;
UPDATE `spell_dbc` SET `EffectMiscValue_1` = 24946 WHERE `ID` = 44925;
--    Warrior
UPDATE `spell_dbc` SET `EffectMiscValue_1` = 25116 WHERE `ID` = 45155;
UPDATE `spell_dbc` SET `EffectMiscValue_1` = 25120 WHERE `ID` = 45159;
UPDATE `spell_dbc` SET `EffectMiscValue_1` = 25124 WHERE `ID` = 45163;
UPDATE `spell_dbc` SET `EffectMiscValue_1` = 25128 WHERE `ID` = 45167;
-- Phase/Tier 2
--    Marksman
UPDATE `spell_dbc` SET `EffectMiscValue_1` = 24943 WHERE `ID` = 44922;
UPDATE `spell_dbc` SET `EffectMiscValue_1` = 24939 WHERE `ID` = 44918;
UPDATE `spell_dbc` SET `EffectMiscValue_1` = 24951 WHERE `ID` = 44930;
UPDATE `spell_dbc` SET `EffectMiscValue_1` = 24947 WHERE `ID` = 44926;
--    Warrior
UPDATE `spell_dbc` SET `EffectMiscValue_1` = 25117 WHERE `ID` = 45156;
UPDATE `spell_dbc` SET `EffectMiscValue_1` = 25121 WHERE `ID` = 45160;
UPDATE `spell_dbc` SET `EffectMiscValue_1` = 25125 WHERE `ID` = 45164;
UPDATE `spell_dbc` SET `EffectMiscValue_1` = 25129 WHERE `ID` = 45168;
-- Phase/Tier 3
--    Marksman
UPDATE `spell_dbc` SET `EffectMiscValue_1` = 24944 WHERE `ID` = 44923;
UPDATE `spell_dbc` SET `EffectMiscValue_1` = 24940 WHERE `ID` = 44919;
UPDATE `spell_dbc` SET `EffectMiscValue_1` = 24952 WHERE `ID` = 44931;
UPDATE `spell_dbc` SET `EffectMiscValue_1` = 24948 WHERE `ID` = 44927;
--    Warrior
UPDATE `spell_dbc` SET `EffectMiscValue_1` = 25118 WHERE `ID` = 45157;
UPDATE `spell_dbc` SET `EffectMiscValue_1` = 25122 WHERE `ID` = 45161;
UPDATE `spell_dbc` SET `EffectMiscValue_1` = 25126 WHERE `ID` = 45165;
UPDATE `spell_dbc` SET `EffectMiscValue_1` = 25130 WHERE `ID` = 45169;
-- Phase/Tier 4 (Final)
--    Marksman
UPDATE `spell_dbc` SET `EffectMiscValue_1` = 24945 WHERE `ID` = 44924;
UPDATE `spell_dbc` SET `EffectMiscValue_1` = 24941 WHERE `ID` = 44920;
UPDATE `spell_dbc` SET `EffectMiscValue_1` = 24953 WHERE `ID` = 44932;
UPDATE `spell_dbc` SET `EffectMiscValue_1` = 24949 WHERE `ID` = 44928;
--    Warrior
UPDATE `spell_dbc` SET `EffectMiscValue_1` = 25119 WHERE `ID` = 45158;
UPDATE `spell_dbc` SET `EffectMiscValue_1` = 25123 WHERE `ID` = 45162;
UPDATE `spell_dbc` SET `EffectMiscValue_1` = 25127 WHERE `ID` = 45166;
UPDATE `spell_dbc` SET `EffectMiscValue_1` = 25131 WHERE `ID` = 45170;
