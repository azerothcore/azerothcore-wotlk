-- DB update 2024_11_05_01 -> 2024_11_05_02
UPDATE `npc_vendor` SET `incrtime` = 300 WHERE `item` = 22909 AND `entry` IN (18005, 19837);
