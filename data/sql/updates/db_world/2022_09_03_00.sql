-- DB update 2022_09_02_05 -> 2022_09_03_00
--
UPDATE `creature_loot_template` SET `QuestRequired`=0, `Chance`=2 WHERE `Item` BETWEEN 20858 AND 20865;
UPDATE `creature_loot_template` SET `QuestRequired`=0, `Chance`=4 WHERE `entry`=15335 AND `Item` BETWEEN 20858 AND 20865;
UPDATE `creature_loot_template` SET `QuestRequired`=0, `Chance`=6 WHERE `entry`=15333 AND `Item` BETWEEN 20858 AND 20865;
