-- DB update 2022_10_11_06 -> 2022_10_11_07
--
-- Replenishing the Healing Crystals (9280 Draenei Version) (DROP QUEST)
-- Vial of Moth Blood (item 22889): 50/50 
UPDATE `creature_loot_template` SET `Chance`=100 WHERE `Entry`=16517 AND `Item`=22934 AND `Reference`=0 AND `GroupId`=0;

-- What Must Be Done... (9293) (DROP QUEST)  (DONE)
-- Lasher Sample (item 16517): 50/50
UPDATE `creature_loot_template` SET `Chance`=100 WHERE `Entry`=16520 AND `Item`=22889 AND `Reference`=0 AND `GroupId`=0;
