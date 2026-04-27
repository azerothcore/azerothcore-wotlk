-- Hotfix for 2026_04_28_00 custom DK low-rank IDs (900200-900211)
-- These IDs are not real spells in DBC, so remove all references and restore valid chains.

-- Cleanup non-existing custom spell references
DELETE FROM `spell_ranks`
WHERE `first_spell_id` IN (900200, 900204, 900208)
   OR `spell_id` BETWEEN 900200 AND 900211;

DELETE FROM `spell_bonus_data`
WHERE `entry` BETWEEN 900200 AND 900211;

DELETE FROM `trainer_spell`
WHERE `TrainerId` = 13
  AND (`SpellId` BETWEEN 900200 AND 900211
       OR `ReqAbility1` BETWEEN 900200 AND 900211
       OR `ReqAbility2` BETWEEN 900200 AND 900211
       OR `ReqAbility3` BETWEEN 900200 AND 900211);

DELETE FROM `spell_dbc`
WHERE `ID` BETWEEN 900200 AND 900211;

-- Restore default DK rank chains for the three modified lines
DELETE FROM `spell_ranks`
WHERE `first_spell_id` IN (45477, 45462, 47541);

INSERT INTO `spell_ranks` (`first_spell_id`, `spell_id`, `rank`) VALUES
(45477, 45477, 1),
(45477, 49896, 2),
(45477, 49903, 3),
(45477, 49904, 4),
(45477, 49909, 5),

(45462, 45462, 1),
(45462, 49917, 2),
(45462, 49918, 3),
(45462, 49919, 4),
(45462, 49920, 5),
(45462, 49921, 6),

(47541, 47541, 1),
(47541, 49892, 2),
(47541, 49893, 3),
(47541, 49894, 4),
(47541, 49895, 5);

-- Rebuild DK trainer progression rows only for these spells
DELETE FROM `trainer_spell`
WHERE `TrainerId` = 13
  AND `SpellId` IN (45462, 45477, 47541, 49896, 49903, 49904, 49909, 49917, 49918, 49919, 49920, 49921, 49892, 49893, 49894, 49895);

INSERT INTO `trainer_spell`
(`TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild`) VALUES
(13, 45462, 5,      0, 0, 0,     0, 0, 1,  0),
(13, 45477, 10,     0, 0, 0,     0, 0, 1,  0),
(13, 47541, 20,     0, 0, 0,     0, 0, 1,  0),
(13, 49896, 61000,  0, 0, 45477, 0, 0, 30, 0),
(13, 49903, 8000,   0, 0, 49896, 0, 0, 36, 0),
(13, 49904, 12000,  0, 0, 49903, 0, 0, 40, 0),
(13, 49909, 20000,  0, 0, 49904, 0, 0, 44, 0),
(13, 49917, 5800,   0, 0, 45462, 0, 0, 56, 0),
(13, 49918, 12000,  0, 0, 49917, 0, 0, 60, 0),
(13, 49919, 20000,  0, 0, 49918, 0, 0, 64, 0),
(13, 49920, 50000,  0, 0, 49919, 0, 0, 70, 0),
(13, 49921, 200000, 0, 0, 49920, 0, 0, 80, 0),
(13, 49892, 59000,  0, 0, 47541, 0, 0, 58, 0),
(13, 49893, 68000,  0, 0, 49892, 0, 0, 64, 0),
(13, 49894, 360000, 0, 0, 49893, 0, 0, 72, 0),
(13, 49895, 360000, 0, 0, 49894, 0, 0, 80, 0);

-- Restore DK starter action to existing valid spell
UPDATE `playercreateinfo_action`
SET `action` = 45462
WHERE `class` = 6
  AND `action` = 900204;
