-- DB update 2026_08_08_09 -> 2026_08_08_10
-- Yogg-Saron Death Ray: bind the ray AI, make it a trigger like TC, let the Death Orb fly
UPDATE `creature_template` SET `ScriptName` = 'boss_yoggsaron_death_ray', `flags_extra` = `flags_extra` | 128 WHERE `entry` = 33881;
UPDATE `creature_template_movement` SET `Ground` = 0, `Flight` = 1 WHERE `CreatureId` = 33882;

-- Sniffed: the Death Ray beam visuals anchor to the Death Orb, not to Sara
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` IN (63882, 63886) AND `ConditionTypeOrReference` = 31;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 63882, 0, 0, 31, 0, 3, 33882, 0, 0, 0, 0, '', 'Death Ray Warning Visual targets Death Orb'),
(13, 1, 63886, 0, 0, 31, 0, 3, 33882, 0, 0, 0, 0, '', 'Death Ray Damage Visual targets Death Orb');

-- Give the serverside Death Ray Summon stubs their summon effect (one ray each)
UPDATE `spell_dbc` SET `Effect_1` = 28, `ImplicitTargetA_1` = 18, `EffectMiscValue_1` = 33881, `EffectMiscValueB_1` = 64 WHERE `ID` IN (63887, 63888, 63889, 63890);
