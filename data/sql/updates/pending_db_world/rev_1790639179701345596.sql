--
-- Use the same friendly faction as Drunken Brewfest Revelers, including during SmartAI faction restoration.
UPDATE `creature_template` SET `faction` = 35 WHERE `entry` = 24484;

-- The linked AuraScript only changes faction; the transform visuals remain handled by the spell.
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_brewfest_reveler_transform' AND `spell_id` IN (43907, 43908, 43909, 43910, 43911, 43912, 43913, 43914, 43915, 43916, 43917, 44003, 44004, 44094, 44096, 44337, 44338);

DELETE FROM `smart_scripts` WHERE `entryorguid` = 24484 AND `source_type` = 0;
INSERT INTO `smart_scripts`
(`entryorguid`, `source_type`, `id`, `event_type`, `event_chance`, `event_flags`,
 `event_param1`, `event_param2`, `event_param3`, `event_param4`,
 `action_type`, `action_param1`, `action_param2`, `action_param3`, `target_type`, `comment`) VALUES
(24484, 0, 0, 22, 100, 512, 101, 5000, 5000, 0, 11, 42518, 2, 0, 7,
 'Brewfest Reveler - Emote Receive ''Wave'' - Cast Create Complimentary Brewfest Sampler'),
(24484, 0, 1, 22, 100, 512, 35, 5000, 5000, 0, 11, 41586, 2, 0, 7,
 'Brewfest Reveler - Emote Receive ''Drink'' - Cast Brewfest Toast'),
(24484, 0, 2, 1, 100, 0, 4000, 11000, 15000, 20000, 10, 92, 1, 4, 1,
 'Brewfest Reveler - Out of Combat - Play Random Emote'),
(24484, 0, 3, 38, 100, 512, 0, 0, 0, 0, 80, 2448400, 0, 0, 1,
 'Brewfest Reveler - On Data Set - Run Script'),
(24484, 0, 4, 58, 100, 512, 3, 24484, 0, 0, 41, 1000, 0, 0, 1,
 'Brewfest Reveler - On WP 3 - Despawn'),
(24484, 0, 5, 38, 100, 512, 0, 1, 0, 0, 80, 24508484, 0, 0, 1,
 'Brewfest Reveler - On Data Set - Run Script'),
(24484, 0, 6, 58, 100, 512, 4, 244840, 0, 0, 41, 1000, 0, 0, 1,
 'Brewfest Reveler - On WP 4 - Despawn');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 24484 AND `SourceId` = 0 AND `SourceGroup` IN (8, 9, 10, 11);
