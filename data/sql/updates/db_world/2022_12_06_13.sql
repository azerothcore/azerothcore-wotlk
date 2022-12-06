-- DB update 2022_12_06_12 -> 2022_12_06_13
-- Updates condition for Drain Schematics (24330) drop with prerequisite of having completed quest As the Crow Flies (9718)
UPDATE `conditions` SET `ConditionValue1` = 9718 WHERE `ConditionTypeOrReference` = 8 AND `SourceEntry` = 24330;
