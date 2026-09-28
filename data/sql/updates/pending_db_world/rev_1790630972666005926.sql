-- SmartAI restores the template's Horde faction after the disguise aura has already been applied.
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
 'Brewfest Reveler - On WP 4 - Despawn'),
(24484, 0, 7, 11, 100, 0, 0, 0, 0, 0, 2, 1934, 0, 0, 1,
 'Brewfest Reveler - On Respawn With Alliance Disguise - Restore Alliance Faction'),
(24484, 0, 8, 11, 100, 0, 0, 0, 0, 0, 2, 1935, 0, 0, 1,
 'Brewfest Reveler - On Respawn With Horde Disguise - Restore Horde Faction'),
(24484, 0, 9, 11, 100, 0, 0, 0, 0, 0, 2, 35, 0, 0, 1,
 'Brewfest Reveler - On Respawn With Goblin Disguise - Restore Friendly Faction');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 24484 AND `SourceId` = 0 AND `SourceGroup` IN (8, 9, 10);
INSERT INTO `conditions`
(`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`,
 `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `Comment`) VALUES
(22, 8, 24484, 0, 1, 1, 1, 43908, 0, 'Alliance Brewfest disguise'),
(22, 8, 24484, 0, 2, 1, 1, 43909, 0, 'Alliance Brewfest disguise'),
(22, 8, 24484, 0, 3, 1, 1, 43910, 0, 'Alliance Brewfest disguise'),
(22, 8, 24484, 0, 4, 1, 1, 43911, 0, 'Alliance Brewfest disguise'),
(22, 8, 24484, 0, 5, 1, 1, 43912, 0, 'Alliance Brewfest disguise'),
(22, 8, 24484, 0, 6, 1, 1, 43913, 0, 'Alliance Brewfest disguise'),
(22, 8, 24484, 0, 7, 1, 1, 44094, 0, 'Alliance Brewfest disguise'),
(22, 8, 24484, 0, 8, 1, 1, 44337, 0, 'Alliance Brewfest disguise'),
(22, 8, 24484, 0, 9, 1, 1, 44338, 0, 'Alliance Brewfest disguise'),
(22, 9, 24484, 0, 1, 1, 1, 43907, 0, 'Horde Brewfest disguise'),
(22, 9, 24484, 0, 2, 1, 1, 43914, 0, 'Horde Brewfest disguise'),
(22, 9, 24484, 0, 3, 1, 1, 43915, 0, 'Horde Brewfest disguise'),
(22, 9, 24484, 0, 4, 1, 1, 43916, 0, 'Horde Brewfest disguise'),
(22, 9, 24484, 0, 5, 1, 1, 43917, 0, 'Horde Brewfest disguise'),
(22, 10, 24484, 0, 1, 1, 1, 44003, 0, 'Goblin Brewfest disguise'),
(22, 10, 24484, 0, 2, 1, 1, 44004, 0, 'Goblin Brewfest disguise'),
(22, 10, 24484, 0, 3, 1, 1, 44096, 0, 'Goblin Brewfest disguise');
