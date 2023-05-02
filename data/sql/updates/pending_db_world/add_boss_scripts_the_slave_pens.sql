--add the new boss scripts to the desired bosses
UPDATE `creature_template`
SET `Scriptname` = 'boss_mennu_the_betrayer'
WHERE `entry` = 17941 AND `difficulty_entry_1` = 19893;

UPDATE `creature_template`
SET `Scriptname` = 'boss_quagmirran'
WHERE `entry` = 17942 AND `difficulty_entry_1` = 19894;

UPDATE `creature_template`
SET `Scriptname` = 'boss_rokmar_the_crackler'
WHERE `entry` = 17991 AND `difficulty_entry_1` = 19895;

