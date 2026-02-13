-- DB update 2024_08_31_00 -> 2024_08_31_01
UPDATE `item_template`
SET `stat_type1` = 5,
`stat_value1` = 20,
`stat_type2` = 7,
`stat_value2` = 13,
`stat_type3` = 42,
`stat_value3` = 25,
`StatsCount` = 3 
WHERE (`entry` = 13113);
