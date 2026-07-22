-- DB update 2026_07_22_02 -> 2026_07_22_03
-- Kel'Thuzad 25-player loot pool structure fix.

UPDATE `creature_loot_template` SET `MinCount`=1, `MaxCount`=1
  WHERE `Entry`=30061 AND `Item`=1 AND `Reference`=34136;

-- Pool A (5 items)
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34136 AND `Item`=40384; -- Betrayer of Humanity
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34136 AND `Item`=40387; -- Boundless Ambition
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34136 AND `Item`=40383; -- Calamity's Grasp
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34136 AND `Item`=40386; -- Sinister Revenge
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34136 AND `Item`=40385; -- Envoy of Mortality

-- Pool B (5 items)
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34136 AND `Item`=40405; -- Cape of the Unworthy Wizard
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34136 AND `Item`=40403; -- Drape of the Deadly Foe
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34136 AND `Item`=40402; -- Last Laugh
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34136 AND `Item`=40401; -- Voice of Reason
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34136 AND `Item`=40400; -- Wall of Terror

-- Pool C (5 items)
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34136 AND `Item`=40388; -- Journey's End
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34136 AND `Item`=40399; -- Signet of Manifested Pain
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34136 AND `Item`=40395; -- Torch of Holy Fire
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34136 AND `Item`=40398; -- Leggings of Mortal Arrogance
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34136 AND `Item`=40396; -- The Turning Tide
