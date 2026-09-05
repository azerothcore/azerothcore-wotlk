-- Sapphiron 25-player loot pool structure fix.

UPDATE `creature_loot_template` SET `MinCount`=1, `MaxCount`=1
    WHERE `Entry`=29991 AND `Item`=1 AND `Reference`=34135;

-- Pool A (5 items)
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34135 AND `Item`=40362; -- Gloves of Fast Reactions
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34135 AND `Item`=40363; -- Bone-Inlaid Legguards
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34135 AND `Item`=40365; -- Breastplate of Frozen Pain
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34135 AND `Item`=40366; -- Platehelm of the Great Wyrm
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34135 AND `Item`=40367; -- Boots of the Great Construct

-- Pool B (5 items)
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34135 AND `Item`=40368; -- Murder
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34135 AND `Item`=40369; -- Icy Blast Amulet
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34135 AND `Item`=40370; -- Gatekeeper
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34135 AND `Item`=40371; -- Bandit's Insignia
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34135 AND `Item`=40372; -- Rune of Repulsion

-- Pool C (5 items)
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34135 AND `Item`=40373; -- Extract of Necromantic Power
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34135 AND `Item`=40374; -- Cosmic Lights
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34135 AND `Item`=40375; -- Ring of Decaying Beauty
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34135 AND `Item`=40376; -- Legwraps of the Defeated Dragon
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34135 AND `Item`=40377; -- Noble Birthright Pauldrons

-- Pool D (5 items)
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34135 AND `Item`=40378; -- Ceaseless Pity
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34135 AND `Item`=40379; -- Legguards of the Boneyard
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34135 AND `Item`=40380; -- Gloves of Grandeur
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34135 AND `Item`=40381; -- Sympathy
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34135 AND `Item`=40382; -- Soul of the Dead
