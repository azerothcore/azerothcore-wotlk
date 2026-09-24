-- DB update 2026_09_14_00 -> 2026_09_15_00
-- Argent Tournament construction daily "Jack Me Some Lumber" (13627).
-- Chop Tree (62990) resolves TARGET_UNIT_NEARBY_ENTRY through a condition that did not exist,
-- so the axe never found an oak. The rest is in the spell data: Lumberjackin' (62855) makes
-- the planks and force-casts Summon Angry Oak Spirit (64040) on the player. The oak dies
-- rather than despawning so the client plays the fall; 62990 allows dead targets, hence
-- NOT_REPEATABLE on the spellhit.

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 62990;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 62990, 0, 0, 31, 0, 3, 33308, 0, 0, 0, 0, '', 'Chop Tree targets Crystalsong Oak');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 33308;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 33308);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(33308, 0, 0, 1, 8, 0, 100, 1, 62990, 0, 0, 0, 0, 0, 11, 62855, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Crystalsong Oak - On Spellhit \'Chop Tree\' - Cast \'Lumberjackin\'\' On Invoker'),
(33308, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crystalsong Oak - On Link - Die (the tree falls)');

-- Argent Tournament construction daily "A Chip Off the Ulduar Block" (13681).
-- Goblin Chisel (63381) summons the chisel (33660) and fires GameObjectActions::Disturb on a
-- nearby Stone Block (194461). Its TARGET_GAMEOBJECT_NEARBY_ENTRY had no condition either, and
-- Disturb lands in GameObject::Use(), which for a spell focus gets no further than the AI's
-- GossipHello hook - so SmartGameObjectAI drives the rest from there.
--
-- Timings are measured off a 3.4.1 sniff: 63381 and Ticking Bomb (64068) share a CastTime,
-- the chisel self-casts Ticking Bomb (61393) to detonate 2884ms later, and the chiselled block
-- is destroyed 1570ms after that. 64068's tooltip claims a 6s fuse; the capture disagrees.
-- The same capture has every Stone Block at Scale 0.65, and the chisel at DisplayID 15294 with
-- Movement Flags 1536 (DisableGravity + Root). 33660 is faction 14, so it is set passive.
--
-- 33958, 33953, 194463 and 63385/64050/63386/64055/64061 appear nowhere in that capture - the
-- recorder was not on 13681 - so the chunk half is read off template and spell data rather than
-- observed and wants a live check. Explosion (64061) is the blast and the damage both;
-- unconditioned it would hit every unit within 15y, so it is restricted to players.

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 63381;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 2, 63381, 0, 0, 31, 0, 5, 194461, 0, 0, 0, 0, '', 'Goblin Chisel targets Stone Block');

UPDATE `gameobject_template` SET `size` = 0.65, `AIName` = 'SmartGameObjectAI' WHERE `entry` = 194461;
DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 194461);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(194461, 1, 0, 1, 64, 0, 100, 1, 0, 0, 0, 0, 0, 0, 12, 33958, 3, 12000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stone Block - On Gossip Hello - Summon Exploding Goblin Chisel'),
(194461, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 4500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stone Block - On Link - Despawn (respawn on spawntimesecs)');

UPDATE `creature_template` SET `unit_flags` = 33554432, `unit_flags2` = 32, `AIName` = 'SmartAI' WHERE `entry` = 33660;
DELETE FROM `creature_template_movement` WHERE `CreatureId` = 33660;
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(33660, 0, 0, 1, 1, 0, 0, NULL);
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 33660);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(33660, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Goblin Chisel - On Just Summoned - Set React Passive'),
(33660, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 64068, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Goblin Chisel - On Link - Cast \'Ticking Bomb\' (fuse and blast radius)'),
(33660, 0, 2, 3, 60, 0, 100, 1, 2900, 2900, 0, 0, 0, 0, 11, 61393, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Goblin Chisel - On Update - Cast \'Ticking Bomb\' (detonate)'),
(33660, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 64061, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Goblin Chisel - On Link - Cast \'Explosion\'');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 64061;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 64061, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Explosion hits players only');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 33958;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 33958);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(33958, 0, 0, 0, 60, 0, 100, 1, 2900, 2900, 0, 0, 0, 0, 11, 63385, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Exploding Goblin Chisel - On Update - Cast \'Blow Apart Stone Block\''),
(33958, 0, 1, 0, 60, 0, 50, 1, 3400, 3400, 0, 0, 0, 0, 11, 63385, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Exploding Goblin Chisel - On Update - Cast \'Blow Apart Stone Block\' (second chunk - 50 percent)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 33953;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 33953);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(33953, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 63386, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Small Stone Summoner - On Just Summoned - Cast \'Summon Small Stone Block\'');

-- This is the case in 3.4.1, but may not be the case in later versions, could not verify at this time
-- UPDATE `gameobject_template` SET `Data1` = 26890 WHERE `entry` = 194463;
-- DELETE FROM `gameobject_loot_template` WHERE `Entry` = 26890;
-- INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
-- (26890, 45278, 0, 100, 1, 1, 0, 1, 1, 'Small Stone Block - Small Stone Block');

DELETE FROM `gameobject_questitem` WHERE `GameObjectEntry` = 194463;
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`) VALUES
(194463, 0, 45278, 0);
