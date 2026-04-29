-- DB update 2026_04_29_03 -> 2026_04_29_04
--
-- Unit flags observed: 8, 2304 (256 | 2048)
-- +256 IMMUNE_TO_PC - disables combat/assistance with PlayerCharacters (PC)
-- +2048 PET_IN_COMBAT
UPDATE `creature_template` SET `faction` = 2101, `unit_flags` = 256, `unit_flags2` = 2048 WHERE (`entry` IN (32343, 32342, 32324, 32321));
UPDATE `creature_template` SET `faction` = 1770, `unit_flags` = 256, `unit_flags2` = 2048 WHERE (`entry` IN (32322, 32341, 32340, 32325));
