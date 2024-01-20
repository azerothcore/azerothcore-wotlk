-- DB update 2023_08_06_10 -> 2023_08_06_11
UPDATE `creature_template` SET `scriptname` = '' WHERE `entry` = 27326;

DELETE FROM `spell_target_position` WHERE `ID` = 48324 AND `EffectIndex` = 0;
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES
(48324, 0, 571, 3454.11, -2802.37, 202.14, 0, 34149345);

DELETE FROM `spell_script_names` WHERE `spell_id` IN (48382, 47533);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(48382, 'spell_q12227_outhouse_groans'),
(47533, 'spell_q12227_camera_shake');

UPDATE `creature_template` SET `flags_extra`=`flags_extra`|128 WHERE `entry` =27326;

