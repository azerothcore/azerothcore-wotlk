INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1619355377341877915');

# select max(entry) from reference_loot_template; 526760, using 526760 + 20

# Create new unified reference loot template containing loot from 24037, 24039, 24041
INSERT INTO `reference_loot_template`
SELECT 526780,
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
      WHERE `Entry` in (24037, 24039, 24041)) AS rlt;

# 2779 Prince Nazjak
# 5356 Snarler
# 8211 Old Cliff Jumper
# 14491 Kurmokk
# 14448 Molt Thorn
# 14492 Verifonix
# 14224 7:XT

# Remove old references for the above-mentioned rares
DELETE
FROM `creature_loot_template`
where `Reference` in (24037, 24039, 24041)
  and `Chance` = 1
  and `Entry` in
      (2779,
       5356,
       8211,
       14491,
       14448,
       14492,
       14224);

# Insert new reference template with 100% chance to guarantee green drop from a rare
INSERT INTO `creature_loot_template` VALUES
    (2779, 526780, 526780, 100, 0, 1, 1, 1, 1, 'Prince Nazjak - (ReferenceTable)'),
    (5356, 526780, 526780, 100, 0, 1, 1, 1, 1, 'Snarler - (ReferenceTable)'),
    (8211, 526780, 526780, 100, 0, 1, 1, 1, 1, 'Old Cliff Jumper - (ReferenceTable)'),
    (14491, 526780, 526780, 100, 0, 1, 1, 1, 1, 'Kurmokk - (ReferenceTable)'),
    (14448, 526780, 526780, 100, 0, 1, 1, 1, 1, 'Molt Thorn - (ReferenceTable)'),
    (14492, 526780, 526780, 100, 0, 1, 1, 1, 1, 'Verifonix - (ReferenceTable)'),
    (14224, 526780, 526780, 100, 0, 1, 1, 1, 1, '7:XT - (ReferenceTable)');
