-- The revelers default to neutral/friendly for Shattrath and the sniffed exceptions.
UPDATE `creature_template` SET `faction` = 35 WHERE `entry` = 24484;

-- The disguise spell still provides the visual; SmartAI assigns the faction per spawn.
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_brewfest_reveler_transform' AND `spell_id` IN (43907, 43908, 43909, 43910, 43911, 43912, 43913, 43914, 43915, 43916, 43917, 44003, 44004, 44094, 44096, 44337, 44338);

-- The two Orgrimmar goblin groups use spell 43911 in the sniff, rather than 44003/44004.
UPDATE `creature_addon` SET `auras` = '43911' WHERE `guid` IN (88918, 88919, 88920, 88921, 88922, 28798, 28799, 88914, 88915) AND `auras` IN ('44003', '44004');

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
(24484, 0, 7, 11, 100, 0, 0, 0, 0, 0, 2, 774, 0, 0, 1,
 'Brewfest Reveler - On Respawn With Alliance Disguise - Set Escortee Alliance Faction'),
(24484, 0, 8, 11, 100, 0, 0, 0, 0, 0, 2, 775, 0, 0, 1,
 'Brewfest Reveler - On Respawn With Horde Disguise - Set Escortee Horde Faction'),
(24484, 0, 9, 11, 100, 0, 0, 0, 0, 0, 2, 775, 0, 0, 1,
 'Brewfest Reveler - On Respawn In Eastern Orgrimmar Goblin Group - Set Escortee Horde Faction'),
(24484, 0, 10, 11, 100, 0, 0, 0, 0, 0, 2, 35, 0, 0, 1,
 'Brewfest Reveler - On Respawn In Shattrath Or Sniffed Friendly Group - Set Friendly Faction');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 24484 AND `SourceId` = 0 AND `SourceGroup` IN (8, 9, 10, 11);
INSERT INTO `conditions`
(`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`,
 `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `Comment`) VALUES
(22, 8, 24484, 0, 1, 1, 1, 43908, 0, 0, 'Alliance Brewfest disguise'),
(22, 8, 24484, 0, 2, 1, 1, 43909, 0, 0, 'Alliance Brewfest disguise'),
(22, 8, 24484, 0, 3, 1, 1, 43910, 0, 0, 'Alliance Brewfest disguise'),
(22, 8, 24484, 0, 4, 1, 1, 43911, 0, 0, 'Alliance Brewfest disguise'),
(22, 8, 24484, 0, 5, 1, 1, 43912, 0, 0, 'Alliance Brewfest disguise'),
(22, 8, 24484, 0, 6, 1, 1, 43913, 0, 0, 'Alliance Brewfest disguise'),
(22, 8, 24484, 0, 7, 1, 1, 44094, 0, 0, 'Alliance Brewfest disguise'),
(22, 8, 24484, 0, 8, 1, 1, 44337, 0, 0, 'Alliance Brewfest disguise'),
(22, 8, 24484, 0, 9, 1, 1, 44338, 0, 0, 'Alliance Brewfest disguise'),
(22, 9, 24484, 0, 1, 1, 1, 43907, 0, 0, 'Horde Brewfest disguise'),
(22, 9, 24484, 0, 2, 1, 1, 43914, 0, 0, 'Horde Brewfest disguise'),
(22, 9, 24484, 0, 3, 1, 1, 43915, 0, 0, 'Horde Brewfest disguise'),
(22, 9, 24484, 0, 4, 1, 1, 43916, 0, 0, 'Horde Brewfest disguise'),
(22, 9, 24484, 0, 5, 1, 1, 43917, 0, 0, 'Horde Brewfest disguise'),
(22, 10, 24484, 0, 1, 31, 1, 3, 24484, 28798, 'Eastern Orgrimmar goblin'),
(22, 10, 24484, 0, 2, 31, 1, 3, 24484, 28799, 'Eastern Orgrimmar goblin'),
(22, 10, 24484, 0, 3, 31, 1, 3, 24484, 88914, 'Eastern Orgrimmar goblin'),
(22, 10, 24484, 0, 4, 31, 1, 3, 24484, 88915, 'Eastern Orgrimmar goblin'),
(22, 11, 24484, 0, 1, 23, 1, 3703, 0, 0, 'Brewfest Reveler in Shattrath City'),
(22, 11, 24484, 0, 2, 31, 1, 3, 24484, 88842, 'Stormwind gate dwarf stays friendly'),
(22, 11, 24484, 0, 3, 31, 1, 3, 24484, 88843, 'Stormwind gate dwarf stays friendly'),
(22, 11, 24484, 0, 4, 31, 1, 3, 24484, 88847, 'Stormwind gate dwarf stays friendly'),
(22, 11, 24484, 0, 5, 31, 1, 3, 24484, 88850, 'Stormwind gate dwarf stays friendly'),
(22, 11, 24484, 0, 6, 31, 1, 3, 24484, 88918, 'Western Orgrimmar goblin stays friendly'),
(22, 11, 24484, 0, 7, 31, 1, 3, 24484, 88919, 'Western Orgrimmar goblin stays friendly'),
(22, 11, 24484, 0, 8, 31, 1, 3, 24484, 88920, 'Western Orgrimmar goblin stays friendly'),
(22, 11, 24484, 0, 9, 31, 1, 3, 24484, 88921, 'Western Orgrimmar goblin stays friendly'),
(22, 11, 24484, 0, 10, 31, 1, 3, 24484, 88922, 'Western Orgrimmar goblin stays friendly');
