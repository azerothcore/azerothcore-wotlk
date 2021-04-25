INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1619363905724595186');

# select max(entry) from reference_loot_template; 526760, using 526760 + 30

# Create new unified reference loot template containing loot from 24037, 24039, 24041, 24056
INSERT INTO `reference_loot_template`
SELECT 526790,
       rlt.Item,
       rlt.Reference,
       rlt.Chance,
       rlt.QuestRequired,
       rlt.LootMode,
       rlt.GroupId,
       rlt.MinCount,
       rlt.MaxCount,
       rlt.Comment
FROM (SELECT DISTINCT Item,
                      Reference,
                      Chance,
                      QuestRequired,
                      LootMode,
                      GroupId,
                      MinCount,
                      MaxCount,
                      Comment
      FROM `reference_loot_template`
      WHERE `Entry` in (24037, 24039, 24041, 24056)) AS rlt;

# 763 Lost One Chieftain
# 2605 Zalas Witherbark
# 2604 Molok the Crusher
# 14234 Hayoc
# 14226 Kaskk
# 2744 Shadowforge Commander

# Remove old references for the above-mentioned rares
DELETE
FROM `creature_loot_template`
where `Reference` in (24037, 24039, 24041, 24056)
  and `Chance` = 1
  and `Entry` in
      (763,
       2605,
       2604,
       14234,
       14226,
       2744);

# Insert new reference template with 100% chance to guarantee green drop from a rare
INSERT INTO `creature_loot_template` VALUES
(763, 526780, 526790, 100, 0, 1, 1, 1, 1, 'Lost One Chieftain - (ReferenceTable)'),
(2605, 526780, 526790, 100, 0, 1, 1, 1, 1, 'Zalas Witherbark - (ReferenceTable)'),
(2604, 526780, 526790, 100, 0, 1, 1, 1, 1, 'Molok the Crusher - (ReferenceTable)'),
(14234, 526780, 526790, 100, 0, 1, 1, 1, 1, 'Hayoc - (ReferenceTable)'),
(14226, 526780, 526790, 100, 0, 1, 1, 1, 1, 'Kaskk - (ReferenceTable)'),
(2744, 526780, 526790, 100, 0, 1, 1, 1, 1, 'Shadowforge Commander - (ReferenceTable)');

# Extra - cleanup Shadowforge Commander references as those are loot tables of too low level
DELETE
FROM `creature_loot_template`
where `Reference` in (24068, 24077, 24060)
  and `Entry` = 2744;
