-- DB update 2026_02_25_01 -> 2026_02_25_02
-- Add acore_string for Debug.LFG config message (same pattern as Debug.Battleground / Debug.Arena)
DELETE FROM `acore_string` WHERE `entry` = 30098;
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(30098, 'LFG Debugging is already enabled in the config, thus you are unable to enable/disable it with command.');
