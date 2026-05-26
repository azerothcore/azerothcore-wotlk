--
-- Dark Iron Legacy (Shadowforge Key) - convert from quest chain to boss drop.
--
-- Vanilla path required talking to the ghost of Franclorn Forgewright at
-- Forgewright's Tomb to start quest 3801 "Dark Iron Legacy". The ghost is
-- only interactable while the player is also a ghost (i.e. has died and is
-- running back from a graveyard). On a permadeath realm dying ends the
-- character, so the Shadowforge Key (item 11000) shortcut is unreachable.
--
-- Solution: disable the questline (3801 + 3802) and sever its giver / ender
-- bindings so it can't be accepted or turned in, then add the Shadowforge
-- Key as a guaranteed drop from High Interrogator Gerstahn (NPC 9018), the
-- first boss inside BRD's Detention Block. Also strip the now-unused
-- Ironfel hammer (item 10999) from Fineous Darkvire's loot and disable the
-- Monument of Franclorn SmartAI that listened for the now-disabled quest
-- completion to spawn the hammer prop. Franclorn's ghost (NPC 8888) and
-- the monument gameobject (GO 164689) themselves are left in place as
-- world flavour.

-- =====================================================================
-- Loot: add Shadowforge Key drop to High Interrogator Gerstahn (9018),
-- remove Ironfel drop from Fineous Darkvire (9056).
-- =====================================================================
DELETE FROM `creature_loot_template` WHERE `Entry` = 9018 AND `Item` = 11000;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(9018, 11000, 0, 100, 0, 1, 0, 1, 1, 'High Interrogator Gerstahn - Shadowforge Key (replaces Dark Iron Legacy quest)');

DELETE FROM `creature_loot_template` WHERE `Entry` = 9056 AND `Item` = 10999;

-- =====================================================================
-- Disable quests 3801 / 3802 via the disables table (DISABLE_TYPE_QUEST
-- = 1). Players can no longer see, accept, or be granted these quests.
-- The quest_template rows are left untouched per AC convention.
-- =====================================================================
DELETE FROM `disables` WHERE `sourceType` = 1 AND `entry` IN (3801, 3802);
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `params_0`, `params_1`, `comment`) VALUES
(1, 3801, 0, '', '', 'Dark Iron Legacy - ghost-NPC start step incompatible with permadeath'),
(1, 3802, 0, '', '', 'Dark Iron Legacy - chained from disabled quest 3801');

-- =====================================================================
-- Quest-giver / quest-ender bindings.
-- Franclorn Forgewright (NPC 8888) - quest starter for 3801 and 3802,
-- quest ender for 3801.
-- Monument of Franclorn (GO 164689) - quest ender for 3802.
-- Stripping these makes the quest unreachable even without the disables
-- row above, providing defence in depth.
-- =====================================================================
DELETE FROM `creature_queststarter` WHERE `id` = 8888 AND `quest` IN (3801, 3802);
DELETE FROM `creature_questender` WHERE `id` = 8888 AND `quest` IN (3801, 3802);
DELETE FROM `gameobject_questender` WHERE `id` = 164689 AND `quest` IN (3801, 3802);

-- =====================================================================
-- Monument of Franclorn SmartAI: source_type=1 (gameobject), entry 164689.
-- Sole row fires on quest 3802 reward to spawn the Ironfel hammer (GO
-- 164688) for 150s. The quest is gone, so the SAI can never fire; remove
-- it to keep the gameobject script registry clean.
-- =====================================================================
DELETE FROM `smart_scripts` WHERE `entryorguid` = 164689 AND `source_type` = 1;
