-- DB update 2026_10_27_03 -> 2026_10_27_04
-- 66319 Summon Fire Bomb (serverside): summon at the triggering Fire Bomb's impact point
UPDATE `spell_dbc` SET `ImplicitTargetA_1` = 87, `ImplicitTargetB_1` = 0 WHERE `ID` = 66319;
