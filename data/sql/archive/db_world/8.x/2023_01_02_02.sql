-- DB update 2023_01_02_01 -> 2023_01_02_02
--
-- Recipe: Elixir of Major Frost Power 
UPDATE `npc_vendor` SET `incrtime`=1800 WHERE `entry` IN (18005, 18017) AND `item`=22902 AND `ExtendedCost`=0;

-- Tailoring Recipes off Aarond
UPDATE `npc_vendor` SET `incrtime`=1800 WHERE `entry`=19521 AND `item` IN (21900, 21901) AND `ExtendedCost`=0;
