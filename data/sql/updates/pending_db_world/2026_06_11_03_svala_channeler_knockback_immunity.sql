-- DB update 2026_06_11_02 -> 2026_06_11_03
-- Ritual Channeler (27281) immune to knockback — fixes encounter break in Utgarde Pinnacle
UPDATE `creature_template` SET `CreatureImmunitiesId` = -3 WHERE `entry` = 27281;
