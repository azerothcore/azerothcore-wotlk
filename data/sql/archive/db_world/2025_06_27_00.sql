-- DB update 2025_06_21_03 -> 2025_06_27_00
 -- Bound Fire Elemental
UPDATE `creature_template` SET `dmgschool` = 2, `spell_school_immune_mask` = 4 WHERE `entry` IN (30416, 31453);
 -- Bound Water Elemental
UPDATE `creature_template` SET `dmgschool` = 4, `spell_school_immune_mask` = 16 WHERE `entry` IN (30419, 31454);
 -- Bound Air Elemental
UPDATE `creature_template` SET `dmgschool` = 3, `spell_school_immune_mask` = 8 WHERE `entry` IN (30418, 31452);
