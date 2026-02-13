-- DB update 2024_11_20_05 -> 2024_11_20_06
--
-- NPC_LYNX
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 24143) AND (`source_type` = 0) AND (`id` IN (4,5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24143, 0, 4, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 43615, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Spirit of the Lynx - On Just Summoned - Cast \'Halazzi Transform\''),
(24143, 0, 5, 0, 0, 0, 100, 0, 2000, 5000, 0, 0, 0, 0, 11, 42466, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Spirit of the Lynx - In Combat - Cast \'Cosmetic - Zul`Aman Spirit Effect\'');

-- merge if lynx <20% hp
UPDATE `smart_scripts` SET `event_param1` = 0, `comment` = 'Spirit of the Lynx - Between 0-20% Health - Do Action ID 0' WHERE (`entryorguid` = 24143) AND (`source_type` = 0) AND (`id` = 3);

-- 43615 Halazzi Transform
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 43615) AND (`ConditionTypeOrReference` = 31);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 43615, 0, 0, 31, 0, 3, 23577, 0, 0, 0, 0, '', 'Target Halazzi');

-- server side SetHealth spells
UPDATE `spell_dbc` SET `ImplicitTargetA_1`=1, `Effect_1`=77, `EffectBasePoints_1`=74, `EffectDieSides_1`=1, `Name_Lang_enUS`='SetHealth (75%)' WHERE `ID`=43536;
UPDATE `spell_dbc` SET `ImplicitTargetA_1`=1, `Effect_1`=77, `EffectBasePoints_1`=49, `EffectDieSides_1`=1, `Name_Lang_enUS`='SetHealth (50%)' WHERE `ID`=43537;
UPDATE `spell_dbc` SET `ImplicitTargetA_1`=1, `Effect_1`=77, `EffectBasePoints_1`=24, `EffectDieSides_1`=1, `Name_Lang_enUS`='SetHealth (25%)' WHERE `ID`=43538;

DELETE FROM `spell_script_names` WHERE `spell_id` IN (43536, 43537, 43538) AND `ScriptName`='spell_gen_set_health';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(43536, 'spell_gen_set_health'),
(43537, 'spell_gen_set_health'),
(43538, 'spell_gen_set_health');

-- copy all the lynx text to human text
DELETE FROM `creature_text` WHERE (`CreatureID` = 24144);
INSERT INTO `creature_text`  VALUES
(24144, 0, 0, 'Get on ya knees and bow.... to da fang and claw!', 14, 0, 100, 0, 0, 12020, 23612, 0, 'Halazzi - SAY_AGGRO'),
(24144, 1, 0, 'You can	 fight da power!', 14, 0, 100, 0, 0, 12026, 0, 0, 'Halazzi - SAY_KILL'),
(24144, 1, 1, 'Ya all gonna fail!', 14, 0, 100, 0, 0, 12027, 23614, 0, 'Halazzi - SAY_KILL'),
(24144, 2, 0, 'Me gonna carve ya now!', 14, 0, 100, 0, 0, 12023, 23615, 0, 'Halazzi - SAY_SABER'),
(24144, 2, 1, 'You gonna leave in pieces!', 14, 0, 100, 0, 0, 12024, 23616, 0, 'Halazzi - SAY_SABER'),
(24144, 3, 0, 'I fight wit untamed spirit....', 14, 0, 100, 0, 0, 12021, 0, 0, 'Halazzi - SAY_SPLIT'),
(24144, 4, 0, 'Spirit, come back to me!', 14, 0, 100, 0, 0, 12022, 22964, 0, 'Halazzi - SAY_MERGE'),
(24144, 5, 0, 'Chaga... chokajinn.', 14, 0, 100, 0, 0, 12028, 0, 0, 'Halazzi - SAY_DEATH');

