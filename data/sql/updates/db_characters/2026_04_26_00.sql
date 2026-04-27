-- DB update 2026_04_12_00 -> 2026_04_26_00
-- Lasagna HC: strip Troll racial Regeneration (20555) from existing Troll
-- characters so DB matches spell state after world `disables` + core fix.

DELETE `cs` FROM `character_spell` AS `cs`
INNER JOIN `characters` AS `c` ON `c`.`guid` = `cs`.`guid`
WHERE `c`.`race` = 8 AND `cs`.`spell` = 20555;
