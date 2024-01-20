-- DB update 2023_06_17_00 -> 2023_06_17_01
--
DELETE FROM `creature_loot_template` WHERE `Entry` = 20521 AND `Item` IN (27424, 27428, 27430); -- removing 3 normal items from HC Skarlock
DELETE FROM `creature_loot_template` WHERE `Entry` = 20531 AND `Item` IN (27433, 27434, 27440); -- removing 3 normal items from HC Epoch Hunter
DELETE FROM `creature_loot_template` WHERE `Entry` = 20535 AND `Item` IN (27417, 27423); -- removing 2 normal items from HC Captain Drake
