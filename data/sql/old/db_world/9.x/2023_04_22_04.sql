-- DB update 2023_04_22_03 -> 2023_04_22_04
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (-146209, -146210));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-146209, 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 121, 90, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Summoner - On Respawn - Set Sight Dist 90y'),
(-146209, 0, 1001, 1002, 10, 0, 100, 1, 0, 90, 3600, 3600, 1, 45, 1, 1, 0, 0, 0, 0, 9, 0, 0, 200, 0, 0, 0, 0, 0, 'Cabal Summoner - Within 0-90 Range Out of Combat LoS - Start Event'),
(-146209, 0, 1002, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -156.987, -313.371, 17.086, 0, 'Cabal Summoner - Linked - Move To Position'),
(-146209, 0, 1003, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 225, 0, 1, 0, 0, 0, 0, 10, 146104, 18708, 0, 0, 0, 0, 0, 0, 'Cabal Summoner - On Reached Point 1 - Send GUID to Murmur'),
(-146210, 0, 1000, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 53, 1, 1863400, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Summoner - On Data Set 1 1 - Start Waypoint'),
(-146210, 0, 1001, 0, 58, 0, 100, 0, 8, 1863400, 0, 0, 0, 225, 0, 1, 0, 0, 0, 0, 10, 146104, 18708, 0, 0, 0, 0, 0, 0, 'Cabal Summoner - On Waypoint Finished - Send GUID to Murmur');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 18639) AND (`source_type` = 0) AND (`id` IN (3));

DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (-146206, -146207, -146208)) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-146206, 0, 1000, 0, 1, 0, 100, 0, 3600, 3600, 3600, 3600, 0, 11, 8734, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Spellbinder - Out Of Combat - Cast \'Blackfathom Channeling\''),
(-146207, 0, 1000, 0, 1, 0, 100, 0, 3600, 3600, 3600, 3600, 0, 11, 8734, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Spellbinder - Out Of Combat - Cast \'Blackfathom Channeling\''),
(-146208, 0, 1000, 0, 1, 0, 100, 0, 3600, 3600, 3600, 3600, 0, 11, 8734, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Spellbinder - Out Of Combat - Cast \'Blackfathom Channeling\'');

UPDATE `creature_template` SET `lootid` = 18639, `pickpocketloot` = 18639, `mingold` = 881, `maxgold` = 1155 WHERE (`entry` = 18639);
UPDATE `creature_template` SET `lootid` = 18634, `pickpocketloot` = 18634, `mingold` = 881, `maxgold` = 1155 WHERE (`entry` = 18634);

DELETE FROM `creature_loot_template` WHERE `Entry` IN (18634, 18639);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(18634, 21877, 0, 23.142, 0, 1, 0, 2, 3, 'Cabal Summoner - Netherweave Cloth'),
(18634, 22790, 0, 0.0518105, 0, 1, 0, 1, 2, 'Cabal Summoner - Ancient Lichen'),
(18634, 24001, 24001, 5, 0, 1, 1, 1, 1, 'Cabal Summoner - (ReferenceTable)'),
(18634, 24002, 24002, 5, 0, 1, 1, 1, 1, 'Cabal Summoner - (ReferenceTable)'),
(18634, 24009, 24009, 1, 0, 1, 1, 1, 1, 'Cabal Summoner - (ReferenceTable)'),
(18634, 24011, 24011, 1, 0, 1, 1, 1, 1, 'Cabal Summoner - (ReferenceTable)'),
(18634, 24013, 24013, 1, 0, 1, 1, 1, 1, 'Cabal Summoner - (ReferenceTable)'),
(18634, 24014, 24014, 0.5, 0, 1, 1, 1, 1, 'Cabal Summoner - (ReferenceTable)'),
(18634, 24035, 24035, 2, 0, 1, 1, 1, 1, 'Cabal Summoner - (ReferenceTable)'),
(18634, 27854, 0, 4.82413, 0, 1, 0, 1, 1, 'Cabal Summoner - Smoked Talbuk Venison'),
(18634, 27860, 0, 2.41782, 0, 1, 0, 1, 1, 'Cabal Summoner - Purified Draenic Water'),
(18634, 29549, 0, 0.0460538, 0, 1, 0, 1, 1, 'Cabal Summoner - Codex: Prayer of Fortitude III'),
(18634, 29550, 0, 0.040297, 0, 1, 0, 1, 1, 'Cabal Summoner - Tome of Conjure Water IX'),
(18634, 29740, 0, 5, 0, 1, 0, 1, 1, 'Cabal Summoner - Fel Armament'),
(18634, 30809, 0, 39, 0, 1, 0, 1, 1, 'Cabal Summoner - Mark of Sargeras'),
(18634, 31501, 0, 0.0575672, 0, 1, 0, 1, 1, 'Cabal Summoner - Tome of Conjure Food VIII'),
(18634, 31837, 0, 0.0575672, 0, 1, 0, 1, 1, 'Cabal Summoner - Codex: Prayer of Shadow Protection II'),
(18634, 31952, 0, 0.0345403, 0, 1, 0, 1, 1, 'Cabal Summoner - Khorium Lockbox'),
(18639, 21877, 0, 22.8698, 0, 1, 0, 2, 3, 'Cabal Spellbinder - Netherweave Cloth'),
(18639, 22146, 0, 0.0368001, 0, 1, 0, 1, 1, 'Cabal Spellbinder - Book: Gift of the Wild III'),
(18639, 22790, 0, 0.0368001, 0, 1, 0, 1, 3, 'Cabal Spellbinder - Ancient Lichen'),
(18639, 23077, 0, 0.172677, 0, 1, 0, 1, 1, 'Cabal Spellbinder - Blood Garnet'),
(18639, 24001, 24001, 5, 0, 1, 1, 1, 1, 'Cabal Spellbinder - (ReferenceTable)'),
(18639, 24002, 24002, 5, 0, 1, 1, 1, 1, 'Cabal Spellbinder - (ReferenceTable)'),
(18639, 24009, 24009, 1, 0, 1, 1, 1, 1, 'Cabal Spellbinder - (ReferenceTable)'),
(18639, 24011, 24011, 1, 0, 1, 1, 1, 1, 'Cabal Spellbinder - (ReferenceTable)'),
(18639, 24013, 24013, 1, 0, 1, 1, 1, 1, 'Cabal Spellbinder - (ReferenceTable)'),
(18639, 24035, 24035, 2, 0, 1, 1, 1, 1, 'Cabal Spellbinder - (ReferenceTable)'),
(18639, 27854, 0, 4.62549, 0, 1, 0, 1, 1, 'Cabal Spellbinder - Smoked Talbuk Venison'),
(18639, 27860, 0, 2.03533, 0, 1, 0, 1, 1, 'Cabal Spellbinder - Purified Draenic Water'),
(18639, 29549, 0, 0.0594463, 0, 1, 0, 1, 1, 'Cabal Spellbinder - Codex: Prayer of Fortitude III'),
(18639, 29740, 0, 5, 0, 1, 0, 1, 1, 'Cabal Spellbinder - Fel Armament'),
(18639, 30809, 0, 39, 0, 1, 0, 1, 1, 'Cabal Spellbinder - Mark of Sargeras'),
(18639, 31501, 0, 0.0368001, 0, 1, 0, 1, 1, 'Cabal Spellbinder - Tome of Conjure Food VIII'),
(18639, 31952, 0, 0.0820925, 0, 1, 0, 1, 1, 'Cabal Spellbinder - Khorium Lockbox');

DELETE FROM `pickpocketing_loot_template` WHERE `Entry` IN (18634, 18639);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(18634, 22829, 0, 3.26, 0, 1, 0, 1, 1, 'Cabal Summoner - Super Healing Potion'),
(18634, 27854, 0, 3.58, 0, 1, 0, 1, 1, 'Cabal Summoner - Smoked Talbuk Venison'),
(18634, 27855, 0, 0.65, 0, 1, 0, 1, 1, 'Cabal Summoner - Mag\'har Grainbread'),
(18634, 29569, 0, 9.12, 0, 1, 0, 1, 1, 'Cabal Summoner - Strong Junkbox'),
(18634, 29570, 0, 14.33, 0, 1, 0, 1, 1, 'Cabal Summoner - A Gnome Effigy'),
(18639, 22829, 0, 1.88, 0, 1, 0, 1, 1, 'Cabal Spellbinder - Super Healing Potion'),
(18639, 27854, 0, 3.47, 0, 1, 0, 1, 1, 'Cabal Spellbinder - Smoked Talbuk Venison'),
(18639, 27855, 0, 2.32, 0, 1, 0, 1, 1, 'Cabal Spellbinder - Mag\'har Grainbread'),
(18639, 29569, 0, 7.53, 0, 1, 0, 1, 1, 'Cabal Spellbinder - Strong Junkbox'),
(18639, 29570, 0, 7.53, 0, 1, 0, 1, 1, 'Cabal Spellbinder - A Gnome Effigy');
