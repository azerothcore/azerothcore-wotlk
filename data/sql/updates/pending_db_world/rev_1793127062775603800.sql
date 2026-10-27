-- 66319 Summon Fire Bomb (serverside): summon at the triggering Fire Bomb's impact point
UPDATE `spell_dbc` SET `ImplicitTargetA_1` = 87, `ImplicitTargetB_1` = 0 WHERE `ID` = 66319;
