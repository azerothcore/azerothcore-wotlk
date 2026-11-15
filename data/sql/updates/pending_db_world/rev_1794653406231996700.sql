-- Turtles with Turtle Scale (8167): leathers to GroupId 1 so every skin gives one, Turtle Scale stays an extra drop
UPDATE `skinning_loot_template` SET `GroupId` = 1
WHERE `Entry` IN (2505, 4396, 4397, 4398, 4399, 4400, 5431, 6352, 6369, 7977, 8213, 13599, 13896, 14123)
  AND `Item` IN (4234, 4235, 4304, 8169, 8170, 8171);
