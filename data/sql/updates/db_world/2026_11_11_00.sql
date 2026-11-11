-- DB update 2026_11_10_02 -> 2026_11_11_00
-- Searing Hatchling (4323), Searing Whelp (4324): group the skinning loot so every skin gives exactly one item
UPDATE `skinning_loot_template` SET `GroupId` = 1
WHERE `Entry` IN (4323, 4324)
  AND `Item` IN (4234, 4235, 4304, 8165, 8169);
