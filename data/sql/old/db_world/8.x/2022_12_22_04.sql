-- DB update 2022_12_22_03 -> 2022_12_22_04
--
-- Recipe: Super Mana Potion 30m
UPDATE `npc_vendor` SET `incrtime`=1800 WHERE `entry` IN (18005, 19837) AND `item`=22907 AND `ExtendedCost`=0;
-- Recipe: Elixir of Major Frost Power 
UPDATE `npc_vendor` SET `incrtime`=600 WHERE `entry`=18017 AND `item`=22902 AND `ExtendedCost`=0;
UPDATE `npc_vendor` SET `incrtime`=600 WHERE `entry`=19837 AND `item`=22902 AND `ExtendedCost`=0;
