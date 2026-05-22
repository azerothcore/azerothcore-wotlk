-- Black Rose unique socketables and standard trinket on-use handling.

SET @BLACK_ROSE_TRINKET := 900105;
SET @RED_GEM_BASE := 900300;
SET @YELLOW_GEM_BASE := 900400;
SET @BLACK_ROSE_AURA := 900900;

UPDATE `item_template` SET `maxcount` = 1, `bonding` = 1 WHERE `entry` IN (
    SELECT @RED_GEM_BASE + `family`.`id` * 10 + `rank`.`id` - 1
    FROM
        (SELECT 0 AS `id` UNION ALL SELECT 1 UNION ALL SELECT 2
         UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
         UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8) AS `family`
    JOIN
        (SELECT 1 AS `id` UNION ALL SELECT 2 UNION ALL SELECT 3
         UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6
         UNION ALL SELECT 7) AS `rank`
    UNION ALL
    SELECT @YELLOW_GEM_BASE + `family`.`id` * 10 + `rank`.`id` - 1
    FROM
        (SELECT 0 AS `id` UNION ALL SELECT 1 UNION ALL SELECT 2
         UNION ALL SELECT 3 UNION ALL SELECT 4) AS `family`
    JOIN
        (SELECT 1 AS `id` UNION ALL SELECT 2 UNION ALL SELECT 3
         UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6
         UNION ALL SELECT 7) AS `rank`);

UPDATE `item_template` SET `spellid_1` = @BLACK_ROSE_AURA, `spelltrigger_1` = 0, `spellcooldown_1` = 180000, `ScriptName` = '' WHERE `entry` = @BLACK_ROSE_TRINKET;
