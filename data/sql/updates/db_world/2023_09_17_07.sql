-- DB update 2023_09_17_06 -> 2023_09_17_07
-- https://github.com/TrinityCore/TrinityCore/commit/dbcbfaa6c7834507b0eba291b45b3927d73ac6d0
DELETE FROM `creature_text` WHERE `CreatureID` IN (18318,18319,18320,18321,18322,18323,18325,18326,18327,18328) AND `GroupID` = 0;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(18318,0,0,'In Terokk\'s name!',12,0,100,0,0,0,16716,0,'Sethekk Halls Trash'),
(18318,0,1,'Protect the Veil!',12,0,100,0,0,0,16717,0,'Sethekk Halls Trash'),
(18318,0,2,'Darkfire -- avenge us!',12,0,100,0,0,0,16718,0,'Sethekk Halls Trash'),
(18318,0,3,'Ssssekk-sara Rith-nealaak!',12,0,100,0,0,0,16719,0,'Sethekk Halls Trash'),
(18318,0,4,'Arak-ha!',12,0,100,0,0,0,16720,0,'Sethekk Halls Trash'),

(18319,0,0,'In Terokk\'s name!',12,0,100,0,0,0,16716,0,'Sethekk Halls Trash'),
(18319,0,1,'Protect the Veil!',12,0,100,0,0,0,16717,0,'Sethekk Halls Trash'),
(18319,0,2,'Darkfire -- avenge us!',12,0,100,0,0,0,16718,0,'Sethekk Halls Trash'),
(18319,0,3,'Ssssekk-sara Rith-nealaak!',12,0,100,0,0,0,16719,0,'Sethekk Halls Trash'),
(18319,0,4,'Arak-ha!',12,0,100,0,0,0,16720,0,'Sethekk Halls Trash'),

(18320,0,0,'In Terokk\'s name!',12,0,100,0,0,0,16716,0,'Sethekk Halls Trash'),
(18320,0,1,'Protect the Veil!',12,0,100,0,0,0,16717,0,'Sethekk Halls Trash'),
(18320,0,2,'Darkfire -- avenge us!',12,0,100,0,0,0,16718,0,'Sethekk Halls Trash'),
(18320,0,3,'Ssssekk-sara Rith-nealaak!',12,0,100,0,0,0,16719,0,'Sethekk Halls Trash'),
(18320,0,4,'Arak-ha!',12,0,100,0,0,0,16720,0,'Sethekk Halls Trash'),

(18321,0,0,'In Terokk\'s name!',12,0,100,0,0,0,16716,0,'Sethekk Halls Trash'),
(18321,0,1,'Protect the Veil!',12,0,100,0,0,0,16717,0,'Sethekk Halls Trash'),
(18321,0,2,'Darkfire -- avenge us!',12,0,100,0,0,0,16718,0,'Sethekk Halls Trash'),
(18321,0,3,'Ssssekk-sara Rith-nealaak!',12,0,100,0,0,0,16719,0,'Sethekk Halls Trash'),
(18321,0,4,'Arak-ha!',12,0,100,0,0,0,16720,0,'Sethekk Halls Trash'),

(18322,0,0,'In Terokk\'s name!',12,0,100,0,0,0,16716,0,'Sethekk Halls Trash'),
(18322,0,1,'Protect the Veil!',12,0,100,0,0,0,16717,0,'Sethekk Halls Trash'),
(18322,0,2,'Darkfire -- avenge us!',12,0,100,0,0,0,16718,0,'Sethekk Halls Trash'),
(18322,0,3,'Ssssekk-sara Rith-nealaak!',12,0,100,0,0,0,16719,0,'Sethekk Halls Trash'),
(18322,0,4,'Arak-ha!',12,0,100,0,0,0,16720,0,'Sethekk Halls Trash'),

(18323,0,0,'In Terokk\'s name!',12,0,100,0,0,0,16716,0,'Sethekk Halls Trash'),
(18323,0,1,'Protect the Veil!',12,0,100,0,0,0,16717,0,'Sethekk Halls Trash'),
(18323,0,2,'Darkfire -- avenge us!',12,0,100,0,0,0,16718,0,'Sethekk Halls Trash'),
(18323,0,3,'Ssssekk-sara Rith-nealaak!',12,0,100,0,0,0,16719,0,'Sethekk Halls Trash'),
(18323,0,4,'Arak-ha!',12,0,100,0,0,0,16720,0,'Sethekk Halls Trash'),

(18325,0,0,'In Terokk\'s name!',12,0,100,0,0,0,16716,0,'Sethekk Halls Trash'),
(18325,0,1,'Protect the Veil!',12,0,100,0,0,0,16717,0,'Sethekk Halls Trash'),
(18325,0,2,'Darkfire -- avenge us!',12,0,100,0,0,0,16718,0,'Sethekk Halls Trash'),
(18325,0,3,'Ssssekk-sara Rith-nealaak!',12,0,100,0,0,0,16719,0,'Sethekk Halls Trash'),
(18325,0,4,'Arak-ha!',12,0,100,0,0,0,16720,0,'Sethekk Halls Trash'),

(18326,0,0,'In Terokk\'s name!',12,0,100,0,0,0,16716,0,'Sethekk Halls Trash'),
(18326,0,1,'Protect the Veil!',12,0,100,0,0,0,16717,0,'Sethekk Halls Trash'),
(18326,0,2,'Darkfire -- avenge us!',12,0,100,0,0,0,16718,0,'Sethekk Halls Trash'),
(18326,0,3,'Ssssekk-sara Rith-nealaak!',12,0,100,0,0,0,16719,0,'Sethekk Halls Trash'),
(18326,0,4,'Arak-ha!',12,0,100,0,0,0,16720,0,'Sethekk Halls Trash'),

(18327,0,0,'In Terokk\'s name!',12,0,100,0,0,0,16716,0,'Sethekk Halls Trash'),
(18327,0,1,'Protect the Veil!',12,0,100,0,0,0,16717,0,'Sethekk Halls Trash'),
(18327,0,2,'Darkfire -- avenge us!',12,0,100,0,0,0,16718,0,'Sethekk Halls Trash'),
(18327,0,3,'Ssssekk-sara Rith-nealaak!',12,0,100,0,0,0,16719,0,'Sethekk Halls Trash'),
(18327,0,4,'Arak-ha!',12,0,100,0,0,0,16720,0,'Sethekk Halls Trash'),

(18328,0,0,'In Terokk\'s name!',12,0,100,0,0,0,16716,0,'Sethekk Halls Trash'),
(18328,0,1,'Protect the Veil!',12,0,100,0,0,0,16717,0,'Sethekk Halls Trash'),
(18328,0,2,'Darkfire -- avenge us!',12,0,100,0,0,0,16718,0,'Sethekk Halls Trash'),
(18328,0,3,'Ssssekk-sara Rith-nealaak!',12,0,100,0,0,0,16719,0,'Sethekk Halls Trash'),
(18328,0,4,'Arak-ha!',12,0,100,0,0,0,16720,0,'Sethekk Halls Trash');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (18318,18319,18320,18321,18322,18323,18325,18326,18327,18328,18701,18703,19203,19204,19205,19206,19428,19429,21891,21904) AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18318, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Initiate - On Aggro - Say Line 0'),
(18318, 0, 1, 0, 0, 0, 100, 0, 5300, 7100, 10800, 18100, 0, 0, 11, 16145, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Initiate - In Combat - Cast \'Sunder Armor\''),
(18318, 0, 2, 0, 0, 0, 100, 0, 7400, 15700, 27300, 47100, 0, 0, 11, 33961, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Initiate - In Combat - Cast \'Spell Reflection\''),

(18319, 0, 0, 0, 1, 0, 100, 0, 1000, 1000, 30000, 30000, 0, 0, 11, 32689, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Scryer - Out of Combat - Cast \'Arcane Destruction\''),
(18319, 0, 1, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Scryer - On Aggro - Say Line 0'),
(18319, 0, 2, 0, 0, 0, 100, 0, 3100, 5300, 3100, 5300, 0, 0, 11, 32689, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Scryer - In Combat - Cast \'Arcane Destruction\''),
(18319, 0, 3, 0, 0, 0, 100, 2, 7800, 13300, 10400, 17700, 0, 0, 11, 22272, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Scryer - In Combat - Cast \'Arcane Missiles\' (Normal Dungeon)'),
(18319, 0, 4, 0, 0, 0, 100, 4, 7800, 13300, 10400, 17700, 0, 0, 11, 33988, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Scryer - In Combat - Cast \'Arcane Missiles\' (Heroic Dungeon)'),
(18319, 0, 5, 0, 74, 0, 100, 2, 9600, 15700, 9600, 15700, 75, 40, 11, 17843, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Scryer - On Friendly Between 0-75% Health - Cast \'Flash Heal\' (Normal Dungeon)'),
(18319, 0, 6, 0, 74, 0, 100, 4, 9600, 15700, 9600, 15700, 75, 40, 11, 17138, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Scryer - On Friendly Between 0-75% Health - Cast \'Flash Heal\' (Heroic Dungeon)'),
(18319, 0, 7, 0, 74, 0, 100, 2, 13200, 21700, 13200, 21700, 40, 40, 11, 12160, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Scryer - On Friendly Between 0-40% Health - Cast \'Rejuvenation\' (Normal Dungeon)'),
(18319, 0, 8, 0, 74, 0, 100, 4, 13200, 21700, 13200, 21700, 40, 40, 11, 15981, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Scryer - On Friendly Between 0-40% Health - Cast \'Rejuvenation\' (Heroic Dungeon)'),

(18320, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Shadowmage - On Aggro - Say Line 0'),
(18320, 0, 1, 0, 0, 0, 100, 2, 6600, 18600, 9300, 21800, 0, 0, 11, 32675, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Shadowmage - In Combat - Cast \'Shadow Missiles\' (Normal Dungeon)'),
(18320, 0, 2, 0, 0, 0, 100, 4, 6600, 18600, 9300, 21800, 0, 0, 11, 38148, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Shadowmage - In Combat - Cast \'Shadow Missiles\' (Heroic Dungeon)'),
(18320, 0, 3, 0, 0, 0, 100, 2, 4800, 9600, 21700, 33800, 0, 0, 11, 32682, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Shadowmage - In Combat - Cast \'Curse of the Dark Talon\' (Normal Dungeon)'),
(18320, 0, 4, 0, 0, 0, 100, 4, 4800, 9600, 21700, 33800, 0, 0, 11, 38149, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Shadowmage - In Combat - Cast \'Curse of the Dark Talon\' (Heroic Dungeon)'),

(18321, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Talon Lord - On Aggro - Say Line 0'),
(18321, 0, 2, 0, 0, 0, 100, 0, 0, 0, 16300, 24300, 0, 0, 11, 32674, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Talon Lord - In Combat - Cast \'Avenger\'s Shield\''),
(18321, 0, 3, 0, 0, 0, 100, 0, 9300, 16700, 14300, 25400, 0, 0, 11, 32654, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Talon Lord - In Combat - Cast \'Talon of Justice\''),

(18322, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Ravenguard - On Aggro - Say Line 0'),
(18322, 0, 1, 0, 0, 0, 100, 2, 7200, 20500, 10800, 21700, 0, 0, 11, 33964, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Ravenguard - In Combat - Cast \'Bloodthirst\' (Normal Dungeon)'),
(18322, 0, 2, 0, 0, 0, 100, 4, 7200, 20500, 10800, 21700, 0, 0, 11, 40423, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Ravenguard - In Combat - Cast \'Bloodthirst\' (Heroic Dungeon)'),
(18322, 0, 3, 0, 0, 0, 100, 0, 6100, 17400, 16800, 21700, 0, 0, 11, 32651, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Ravenguard - In Combat - Cast \'Howling Screech\''),
(18322, 0, 4, 0, 38, 0, 100, 0, 0, 1, 0, 0, 0, 0, 11, 34970, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Ravenguard - On Data Set 0 1 - Cast \'Frenzy\''),
(18322, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 19, 18322, 30, 0, 0, 0, 0, 0, 0, 'Sethekk Ravenguard - On Death - Set Data 0 1'),

(18323, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Guard - On Aggro - Say Line 0'),
(18323, 0, 1, 0, 0, 0, 100, 0, 3600, 15700, 10900, 22100, 0, 0, 11, 33967, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Guard - In Combat - Cast \'Thunderclap\''),

(18325, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Prophet - On Aggro - Say Line 0'),
(18325, 0, 1, 0, 0, 0, 100, 0, 8700, 17700, 13200, 24100, 0, 0, 11, 27641, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Prophet - In Combat - Cast \'Fear\''),
(18325, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 32692, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Prophet - On Death - Cast \'Summon Arakkoa Spirit\''),

(18326, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Shaman - On Aggro - Say Line 0'),
(18326, 0, 1, 0, 0, 0, 100, 2, 4300, 9100, 7200, 14500, 0, 0, 11, 15501, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Shaman - In Combat - Cast \'Earth Shock\' (Normal Dungeon)'),
(18326, 0, 2, 0, 0, 0, 100, 4, 4300, 9100, 7200, 14500, 0, 0, 11, 22885, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Shaman - In Combat - Cast \'Earth Shock\' (Heroic Dungeon)'),
(18326, 0, 3, 0, 0, 0, 100, 0, 7900, 14500, 90000, 90000, 0, 0, 11, 32663, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Shaman - In Combat - Cast \'Summon Dark Vortex\''),

(18327, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Controller - On Aggro - Say Line 0'),
(18327, 0, 1, 0, 0, 0, 100, 0, 9100, 24100, 27800, 48300, 0, 0, 11, 32764, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Controller - In Combat - Cast \'Summon Charming Totem\''),
(18327, 0, 2, 0, 0, 0, 100, 0, 8400, 23200, 9700, 32600, 0, 0, 11, 35013, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Controller - In Combat - Cast \'Shrink\''),

(18328, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Oracle - On Aggro - Say Line 0'),
(18328, 0, 1, 0, 0, 0, 100, 2, 6100, 12100, 18500, 27700, 0, 0, 11, 32690, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Oracle - In Combat - Cast \'Arcane Lightning\' (Normal Dungeon)'),
(18328, 0, 2, 0, 0, 0, 100, 4, 1200, 12100, 7200, 13300, 0, 0, 11, 38146, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Oracle - In Combat - Cast \'Arcane Lightning\' (Heroic Dungeon)'),
(18328, 0, 3, 0, 0, 0, 100, 0, 2400, 8700, 8400, 19300, 0, 0, 11, 32129, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Oracle - In Combat - Cast \'Faerie Fire\''),

(18701, 0, 0, 0, 0, 0, 100, 0, 3600, 7200, 8400, 19300, 0, 0, 11, 12471, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Vortex - In Combat - Cast \'Shadow Bolt\''),

(18703, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Spirit - On Just Summoned - Set In Combat With Zone'),
(18703, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 17321, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Spirit - On Link - Cast \'Spirit Spawn-in\''),
(18703, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 24051, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Spirit - On Link - Cast \'Spirit Burst\''),
(18703, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 116, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Spirit - On Link - Set Corpse Delay'),
(18703, 0, 4, 0, 60, 0, 100, 1, 10000, 10000, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Spirit - On Update - Kill Self (No Repeat)'),

(19203, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 33610, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Syth Fire Elemental - On Just Summoned - Cast \'Syth A Dummy\''),
(19203, 0, 1, 0, 0, 0, 100, 2, 1600, 7600, 8400, 18100, 0, 0, 11, 33526, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Syth Fire Elemental - In Combat - Cast \'Flame Buffet\' (Normal Dungeon)'),
(19203, 0, 2, 0, 0, 0, 100, 4, 1200, 3600, 6000, 7200, 0, 0, 11, 38141, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Syth Fire Elemental - In Combat - Cast \'Flame Buffet\' (Heroic Dungeon)'),
(19203, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 33621, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Syth Fire Elemental - On Death - Cast \'Syth Dummy\''),

(19204, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 33611, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Syth Frost Elemental - On Just Summoned - Cast \'Syth B Dummy\''),
(19204, 0, 1, 0, 0, 0, 100, 2, 1600, 7600, 8400, 18100, 0, 0, 11, 33528, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Syth Frost Elemental - In Combat - Cast \'Frost Buffet\' (Normal Dungeon)'),
(19204, 0, 2, 0, 0, 0, 100, 4, 1200, 3600, 6000, 7200, 0, 0, 11, 38142, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Syth Frost Elemental - In Combat - Cast \'Frost Buffet\' (Heroic Dungeon)'),
(19204, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 33621, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Syth Frost Elemental - On Death - Cast \'Syth Dummy\''),

(19205, 0, 0, 0, 0, 0, 100, 2, 1600, 7600, 8400, 18100, 0, 0, 11, 33527, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Syth Arcane Elemental - In Combat - Cast \'Arcane Buffet\' (Normal Dungeon)'),
(19205, 0, 1, 0, 0, 0, 100, 4, 1200, 3600, 6000, 7200, 0, 0, 11, 38138, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Syth Arcane Elemental - In Combat - Cast \'Arcane Buffet\' (Heroic Dungeon)'),
(19205, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 33621, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Syth Arcane Elemental - On Death - Cast \'Syth Dummy\''),

(19206, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 33612, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Syth Shadow Elemental - On Just Summoned - Cast \'Syth C Dummy\''),
(19206, 0, 1, 0, 0, 0, 100, 2, 1600, 7600, 8400, 18100, 0, 0, 11, 33529, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Syth Shadow Elemental - In Combat - Cast \'Shadow Buffet\' (Normal Dungeon)'),
(19206, 0, 2, 0, 0, 0, 100, 4, 1200, 3600, 6000, 7200, 0, 0, 11, 38143, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Syth Shadow Elemental - In Combat - Cast \'Shadow Buffet\' (Heroic Dungeon)'),
(19206, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 33621, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Syth Shadow Elemental - On Death - Cast \'Syth Dummy\''),

(19428, 0, 0, 0, 0, 0, 100, 2, 4800, 14500, 13300, 22900, 0, 0, 11, 17503, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cobalt Serpent - In Combat - Cast \'Frostbolt\' (Normal Dungeon)'),
(19428, 0, 1, 0, 0, 0, 100, 4, 4800, 14500, 13300, 22900, 0, 0, 11, 38238, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cobalt Serpent - In Combat - Cast \'Frostbolt\' (Heroic Dungeon)'),
(19428, 0, 2, 0, 0, 0, 100, 2, 5600, 22100, 8400, 25400, 0, 0, 11, 38193, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cobalt Serpent - In Combat - Cast \'Lightning Breath\' (Normal Dungeon)'),
(19428, 0, 3, 0, 0, 0, 100, 4, 3600, 22100, 7200, 14400, 0, 0, 11, 38133, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cobalt Serpent - In Combat - Cast \'Lightning Breath\' (Heroic Dungeon)'),
(19428, 0, 4, 0, 0, 0, 100, 0, 6200, 21700, 12100, 22800, 0, 0, 11, 38110, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cobalt Serpent - In Combat - Cast \'Wing Buffet\''),

(19429, 0, 0, 0, 9, 0, 100, 3, 0, 0, 0, 0, 8, 25, 11, 38059, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Avian Darkhawk - Within 8-25 Range - Cast \'Sonic Charge\' (Normal Dungeon) (No Repeat)'),
(19429, 0, 1, 0, 9, 0, 100, 5, 0, 0, 0, 0, 8, 25, 11, 39197, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Avian Darkhawk - Within 8-25 Range - Cast \'Sonic Charge\' (Heroic Dungeon) (No Repeat)'),
(19429, 0, 2, 0, 0, 0, 100, 2, 4800, 13600, 10900, 24100, 0, 0, 11, 32901, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Avian Darkhawk - In Combat - Cast \'Carnivorous Bite\' (Normal Dungeon)'),
(19429, 0, 3, 0, 0, 0, 100, 4, 4800, 13600, 10900, 24100, 0, 0, 11, 39198, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Avian Darkhawk - In Combat - Cast \'Carnivorous Bite\' (Heroic Dungeon)'),

(21891, 0, 0, 0, 0, 0, 100, 0, 4300, 12100, 15600, 19300, 0, 0, 11, 38056, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Avian Ripper - In Combat - Cast \'Flesh Rip\''),

(21904, 0, 0, 0, 9, 0, 100, 3, 0, 0, 0, 0, 8, 25, 11, 38059, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Avian Warhawk - Within 8-25 Range - Cast \'Sonic Charge\' (Normal Dungeon) (No Repeat)'),
(21904, 0, 1, 0, 9, 0, 100, 5, 0, 0, 0, 0, 8, 25, 11, 39197, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Avian Warhawk - Within 8-25 Range - Cast \'Sonic Charge\' (Heroic Dungeon) (No Repeat)'),
(21904, 0, 2, 0, 0, 0, 100, 2, 3800, 11100, 10900, 21700, 0, 0, 11, 32901, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Avian Warhawk - In Combat - Cast \'Carnivorous Bite\' (Normal Dungeon)'),
(21904, 0, 3, 0, 0, 0, 100, 4, 3800, 11100, 10900, 21700, 0, 0, 11, 39198, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Avian Warhawk - In Combat - Cast \'Carnivorous Bite\' (Heroic Dungeon)'),
(21904, 0, 4, 0, 0, 0, 100, 0, 6200, 25500, 12100, 24100, 0, 0, 11, 18144, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Avian Warhawk - In Combat - Cast \'Swoop\'');

-- Ravenguard ImmuneMask
UPDATE `creature_template` SET `mechanic_immune_mask` = 71698 WHERE (`entry` IN (18322, 20696));
