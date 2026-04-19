-- DB update 2026_03_31_00 -> 2026_04_03_00
--
-- from mechanic_immune_mask 646000477 to school=0x10(FROST)
UPDATE `creature_template` SET `CreatureImmunitiesId`=-6 WHERE `entry`=510;
