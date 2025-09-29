--
-- Update summon position
DELETE FROM `spell_target_position` WHERE `ID` = 49992;
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES
(49992, 0, 571, 479.019, -5941.53, 308.829, 0.0, 15595);

-- Fixes "Bluff", Set `allowOverride` of action list
UPDATE `smart_scripts` SET `action_param3` = 1 WHERE (`entryorguid` IN (23672, 23673, 23675, 24271)) AND (`source_type` = 0) AND (`event_type` = 8) AND (`event_param1` = 44609);

-- Removes double spawns
DELETE FROM `gameobject` WHERE `id` = 186959 AND `guid` IN (264459, 264460, 264461, 264462, 264463, 264464, 264465);

-- Fixes "Rocketjump"
SET @A1A2:=24826;
SET @B1B2:=24827;
SET @C1C2:=24828;
SET @D1:=24831;
SET @D2:=24829;
SET @D3:=24832;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (@A1A2, @B1B2, @C1C2, @D1, @D2, @D3);

-- Add missing aura. It does nothing
DELETE FROM `creature_template_addon` WHERE (`entry` = 24825);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(24825, 0, 0, 0, 1, 0, 0, '44652');

-- Disable flying vehicle, but causes camera stuttering on rocket jump
UPDATE `creature_template_movement` SET `Flight` = 0 WHERE (`CreatureId` = 24825);
