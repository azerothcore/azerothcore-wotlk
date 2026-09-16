-- DB update 2026_09_12_06 -> 2026_09_13_00
--
-- Freya's Elders: emblem loot when killed before the encounter

-- Only the 10-man Brightleaf had a loot id of its own; the 25-man entry borrows it
UPDATE `creature_template` SET `lootid` = `entry` WHERE `entry` IN (32913, 32914, 33392, 33393);

DELETE FROM `creature_loot_template` WHERE `Entry` IN (32913, 32914, 32915, 33392, 33393);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(32913, 47241, 0, 100, 0, 1, 0, 1, 1, 'Elder Ironbranch - Emblem of Triumph'),
(32914, 47241, 0, 100, 0, 1, 0, 1, 1, 'Elder Stonebark - Emblem of Triumph'),
(32915, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Elder Brightleaf - Book of Glyph Mastery'),
(32915, 47241, 0, 100, 0, 1, 0, 1, 1, 'Elder Brightleaf - Emblem of Triumph'),
(33392, 47241, 0, 100, 0, 1, 0, 1, 1, 'Elder Ironbranch (1) - Emblem of Triumph'),
(33393, 47241, 0, 100, 0, 1, 0, 1, 1, 'Elder Stonebark (1) - Emblem of Triumph');
