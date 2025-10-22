-- DB update 2025_09_15_03 -> 2025_09_16_00
-- Earthfury Belt
UPDATE `creature_loot_template` SET `chance` = 0.2 WHERE `item` = 16838 AND `entry` IN(11667,11666);
UPDATE `creature_loot_template` SET `chance` = 0.3 WHERE `item` = 16838 AND `entry` IN(12100,12076,11665);
UPDATE `creature_loot_template` SET `chance` = 0.4 WHERE `item` = 16838 AND `entry` IN(11659,12101,11668);
UPDATE `creature_loot_template` SET `chance` = 0.5 WHERE `item` = 16838 AND `entry` IN(11663);
UPDATE `creature_loot_template` SET `chance` = 0.6 WHERE `item` = 16838 AND `entry` IN(11661);
UPDATE `creature_loot_template` SET `chance` = 0.7 WHERE `item` = 16838 AND `entry` IN(12119,11658);
UPDATE `creature_loot_template` SET `chance` = 0.8 WHERE `item` = 16838 AND `entry` IN(11662,11664);
UPDATE `creature_loot_template` SET `chance` = 0.9 WHERE `item` = 16838 AND `entry` IN(11673);
-- Earthfury Bracer
UPDATE `creature_loot_template` SET `chance` = 0.2 WHERE `item` = 16840 AND `entry` IN(12076);
UPDATE `creature_loot_template` SET `chance` = 0.3 WHERE `item` = 16840 AND `entry` IN(11666,11665,11667,11668);
UPDATE `creature_loot_template` SET `chance` = 0.4 WHERE `item` = 16840 AND `entry` IN(11659,12101,12100);
UPDATE `creature_loot_template` SET `chance` = 0.5 WHERE `item` = 16840 AND `entry` IN(11663);
UPDATE `creature_loot_template` SET `chance` = 0.6 WHERE `item` = 16840 AND `entry` IN(11658);
UPDATE `creature_loot_template` SET `chance` = 0.7 WHERE `item` = 16840 AND `entry` IN(12119);
UPDATE `creature_loot_template` SET `chance` = 0.8 WHERE `item` = 16840 AND `entry` IN(11662,11664,11661);
UPDATE `creature_loot_template` SET `chance` = 0.8 WHERE `item` = 16840 AND `entry` IN(11673);
