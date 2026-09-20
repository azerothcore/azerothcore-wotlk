--
-- Replace `me->SetAnimTier(AnimTier::Fly)` with packed AnimTier in bytes1
SET @ENTRY := 32592;
DELETE FROM `creature_template_addon` WHERE `entry` = @ENTRY;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(@ENTRY, 0, 0, 0x03000000, 0, 0, 0, '');

UPDATE `creature_template` SET `ScriptName` = '' WHERE (`entry` = 32592);
