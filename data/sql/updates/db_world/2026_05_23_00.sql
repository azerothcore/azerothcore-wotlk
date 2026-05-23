-- DB update 2026_05_22_00 -> 2026_05_23_00
--
UPDATE `creature_template_addon` SET `auras` = '' WHERE (`entry` IN (31841, 31842));
