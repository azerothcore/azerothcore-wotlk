-- DB update 2026_09_05_01 -> 2026_09_05_02
-- Hydross' Cleansing Field Helper and both Beam Helpers to their sniffed spawn positions
UPDATE `creature` SET `position_x` = -239.715, `position_y` = -366.44, `position_z` = -0.744514, `orientation` = 1.23918, `VerifiedBuild` = 69587 WHERE `guid` = 153019 AND `id` = 21934;
UPDATE `creature` SET `position_x` = -215.753, `position_y` = -375.343, `position_z` = 38.403, `orientation` = 5.0091, `VerifiedBuild` = 69587 WHERE `guid` = 153020 AND `id` = 21933;
UPDATE `creature` SET `position_x` = -264.165, `position_y` = -357.171, `position_z` = 38.8069, `orientation` = 2.84489, `VerifiedBuild` = 69587 WHERE `guid` = 153021 AND `id` = 21933;
UPDATE `creature` SET `VerifiedBuild` = 69587 WHERE `guid` = 153018 AND `id` = 21216;

-- The Beam Helpers now toggle Blue Beam straight from the Cleansing Field aura script
DELETE FROM `spell_script_names` WHERE `spell_id` = 37934 AND `ScriptName` = 'spell_hydross_cleansing_field_command';
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceGroup` = 1 AND `SourceEntry` = 37934;
