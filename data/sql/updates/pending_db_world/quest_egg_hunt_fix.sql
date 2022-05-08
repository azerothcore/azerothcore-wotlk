-- Remove Questitem from NPC's

DELETE FROM `creature_loot_template` WHERE (`Entry` IN (3250, 3503, 3251)) AND (`Item` IN (5058));

-- Gameobject Loot Fix

DELETE FROM `gameobject_loot_template` WHERE (`Entry` = 2620) AND (`Item` IN (5058));
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2620, 5058, 0, 100, 1, 1, 0, 1, 3, 'Silithid Mound - Silithid Egg');

-- Set SmartAI for Silithid Protector

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3503;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 3503);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3503, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Silithid Protector - Just Summoned - Say Line 0'),
(3503, 0, 2, 0, 1, 0, 100, 0, 100, 5000, 0, 0, 0, 2, 413, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Silithid Protector - Just Summoned - Set Faction');
