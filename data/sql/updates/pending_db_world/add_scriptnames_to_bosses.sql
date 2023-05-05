--
UPDATE `creature_template`
SET `Scriptname` =
    CASE
    WHEN `entry` = 17941 THEN 'boss_mennu_the_betrayer'
    WHEN `entry` = 17942 THEN 'boss_quagmirran'
    WHEN `entry` = 17991 THEN 'boss_rokmar_the_crackler'
    END, `AIName` = ''
WHERE `entry` IN (17941, 17942, 17991);

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (17941, 17942, 17991) AND `source_type` = 0;
