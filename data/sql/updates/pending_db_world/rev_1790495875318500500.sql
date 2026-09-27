-- Update creature 'Vanilla Collector's Edition Quest Enders' with sniffed values
-- updated spawns
DELETE FROM `creature` WHERE (`id` IN (11943, 11941, 15493, 16476, 11940)) AND (`guid` IN (3416, 348, 55415, 57174, 79949));
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(3416, 11943, 1, 1, 1, 0, 349.729766845703125, -4675.84521484375, 16.541107177734375, 3.054326057434082031, 120, 0, 0, 0, 0, 0, "", 45327, 1, NULL),
(348, 11941, 0, 1, 1, 0, -5581.23681640625, -540.94610595703125, 403.62408447265625, 2.286381244659423828, 120, 0, 0, 0, 0, 0, "", 45435, 1, NULL),
(55415, 15493, 530, 1, 1, 0, 9515.8828125, -6798.50634765625, 17.27863311767578125, 4.921828269958496093, 120, 0, 0, 0, 0, 0, "", 45854, 1, NULL),
(57174, 16476, 530, 1, 1, 0, -4173.20654296875, -12499.2314453125, 45.4065704345703125, 0.401425719261169433, 120, 0, 0, 0, 0, 0, "", 45435, 1, NULL),
(79949, 11940, 0, 1, 1, 0, -9479.25, 52.86897659301757812, 56.96744918823242187, 0.820304751396179199, 120, 0, 0, 0, 0, 0, "", 45435, 1, NULL)
