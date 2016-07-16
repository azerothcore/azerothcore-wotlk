-- update quests with rep
UPDATE `quest_template` SET `Flags` = 4290, `RewardFactionID1` = 1082, `RewardFactionValueId1` = 1 WHERE ID BETWEEN 100000 AND 100080;

-- mark of azeroth

UPDATE item_template SET NAME = "Mark of Azeroth", stackable = 2147483647, description = "Il bottino di ogni avventuriero!", maxcount = 0, spellid_1 = 0, spellcharges_1 = 0, flags = 0 WHERE entry = 37711;


-- quest rewards
UPDATE `quest_template` SET RewardItemId1 = 37711, RewardItemCount1 = 2 WHERE ID BETWEEN 100000 AND 100080;

-- hearthstone trasmog sack
UPDATE item_template SET NAME = "Garga's Magic Box", description = "Non sono così egocentrico da chiamare un NPC come me." WHERE entry = 32558;