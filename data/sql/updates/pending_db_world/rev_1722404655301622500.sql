-- make sure GO exists properly
DELETE FROM `gameobject_template` WHERE (`entry` = 185549);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES
(185549, 10, 378, 'Monstrous Kaliri Egg', '', '', '', 1.5, 0, 11008, 0, 3000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 12340);

-- add SAI
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 185549;
DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 185549);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(185549, 1, 0, 1, 8, 0, 100, 512, 39844, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Monstrous Kaliri Egg - On Spellhit \'Skyguard Blasting Charge\' - Activate Gameobject'),
(185549, 1, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 33, 22991, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Monstrous Kaliri Egg - On Spellhit \'Skyguard Blasting Charge\' - Quest Credit \'Fires Over Skettis\'');

-- add spawns
DELETE FROM `gameobject` WHERE (`id` = 185549);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(2135788, 185549, 530, 0, 0, 1, 1, -3857.69, 3426.25, 363.733, -0.087267, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 12767 ID: 22991'),
(2135789, 185549, 530, 0, 0, 1, 1, -3845.16, 3332.2, 338.59, 2.9147, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 21055 ID: 22991'),
(2135790, 185549, 530, 0, 0, 1, 1, -3965.16, 3232.7, 347.552, -0.122173, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 51854 ID: 22991'),
(2135791, 185549, 530, 0, 0, 1, 1, -3955.86, 3222.16, 347.503, 0.244346, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 55414 ID: 22991'),
(2135792, 185549, 530, 0, 0, 1, 1, -3953.3, 3227.94, 347.564, -0.244346, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 59471 ID: 22991'),
(2135793, 185549, 530, 0, 0, 1, 1, -4044.66, 3287.29, 348.362, 0.349066, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 63504 ID: 22991'),
(2135794, 185549, 530, 0, 0, 1, 1, -4041.39, 3271, 346.642, -2.09439, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 63518 ID: 22991'),
(2135795, 185549, 530, 0, 0, 1, 1, -4049.31, 3285.9, 348.335, 1.43117, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 63519 ID: 22991'),
(2135796, 185549, 530, 0, 0, 1, 1, -4076.99, 3415.22, 334.008, -2.33874, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 63520 ID: 22991'),
(2135797, 185549, 530, 0, 0, 1, 1, -4076.79, 3412.91, 334.617, -1.0821, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 63521 ID: 22991'),
(2135798, 185549, 530, 0, 0, 1, 1, -4077.92, 3412.57, 334.768, -0.733038, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 63522 ID: 22991'),
(2135799, 185549, 530, 0, 0, 1, 1, -4107.93, 3121.5, 357.427, 1.01229, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 66971 ID: 22991'),
(2135800, 185549, 530, 0, 0, 1, 1, -4108.31, 3123.66, 357.633, -0.680679, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 67863 ID: 22991'),
(2135801, 185549, 530, 0, 0, 1, 1, -4110.19, 3122.64, 358.083, -0.034907, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68450 ID: 22991'),
(2135802, 185549, 530, 0, 0, 1, 1, -3996.89, 3142.12, 372.729, 3.05433, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68451 ID: 22991'),
(2135803, 185549, 530, 0, 0, 1, 1, -4109.06, 3019.1, 352.24, 0.261799, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68452 ID: 22991'),
(2135804, 185549, 530, 0, 0, 1, 1, -4018.35, 3076.7, 375.29, -0.733038, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68453 ID: 22991'),
(2135805, 185549, 530, 0, 0, 1, 1, -4184.98, 3044.71, 352.394, 1.81514, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68454 ID: 22991'),
(2135806, 185549, 530, 0, 0, 1, 1, -4187.52, 3040.39, 352.071, -0.017453, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68455 ID: 22991'),
(2135807, 185549, 530, 0, 0, 1, 1, -4189.67, 3039.9, 352.247, -0.785398, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68501 ID: 22991'),
(2135808, 185549, 530, 0, 0, 1, 1, -4192.61, 3045.1, 352.096, 3.14159, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68502 ID: 22991'),
(2135809, 185549, 530, 0, 0, 1, 1, -4192.02, 3046.91, 352.297, 2.46091, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68503 ID: 22991'),
(2135810, 185549, 530, 0, 0, 1, 1, -4186.47, 3047.19, 352.316, 2.60054, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68504 ID: 22991'),
(2135811, 185549, 530, 0, 0, 1, 1, -3915.67, 2983.4, 396.957, -1.91986, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68505 ID: 22991'),
(2135812, 185549, 530, 0, 0, 1, 1, -3883.21, 3004.11, 399.738, -1.64061, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68506 ID: 22991'),
(2135813, 185549, 530, 0, 0, 1, 1, -3883.26, 3001.55, 399.431, -2.3911, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68507 ID: 22991'),
(2135814, 185549, 530, 0, 0, 1, 1, -3884.29, 3003.3, 400.063, -1.88496, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68508 ID: 22991'),
(2135815, 185549, 530, 0, 0, 1, 1, -3903.02, 3095.85, 383.783, -2.28638, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68509 ID: 22991'),
(2135816, 185549, 530, 0, 0, 1, 1, -3898.45, 3093.06, 383.667, 2.53073, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68510 ID: 22991'),
(2135817, 185549, 530, 0, 0, 1, 1, -3900.75, 3100.75, 383.795, -0.436333, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68511 ID: 22991'),
(2135818, 185549, 530, 0, 0, 1, 1, -4107.81, 3023.42, 352.142, 1.06465, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68512 ID: 22991'),
(2135819, 185549, 530, 0, 0, 1, 1, -4113.58, 3022.4, 352.157, -0.645772, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68513 ID: 22991'),
(2135820, 185549, 530, 0, 0, 1, 1, -3893.09, 3677.17, 374.516, -1.23918, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68514 ID: 22991'),
(2135821, 185549, 530, 0, 0, 1, 1, -3892.47, 3674, 374.478, -2.14675, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68515 ID: 22991'),
(2135822, 185549, 530, 0, 0, 1, 1, -4198.53, 3168.91, 355.847, -0.383972, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68516 ID: 22991'),
(2135823, 185549, 530, 0, 0, 1, 1, -4197.01, 3170.04, 356.117, -1.15192, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68517 ID: 22991'),
(2135824, 185549, 530, 0, 0, 1, 1, -4196.54, 3167.69, 356.348, -0.541052, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68518 ID: 22991'),
(2135825, 185549, 530, 0, 0, 1, 1, -4020.07, 3077.84, 374.391, 1.53589, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68519 ID: 22991'),
(2135826, 185549, 530, 0, 0, 1, 1, -4019.32, 3079.74, 375.109, -1.25664, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68520 ID: 22991'),
(2135827, 185549, 530, 0, 0, 1, 1, -3917.21, 2981.62, 396.483, 0.733038, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68521 ID: 22991'),
(2135828, 185549, 530, 0, 0, 1, 1, -3918.45, 2982.44, 397.24, -1.72788, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68522 ID: 22991'),
(2135829, 185549, 530, 0, 0, 1, 1, -3839.35, 3344.85, 337.834, 2.75762, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68539 ID: 22991'),
(2135830, 185549, 530, 0, 0, 1, 1, -3835.3, 3344.77, 338.155, -0.767945, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68540 ID: 22991'),
(2135831, 185549, 530, 0, 0, 1, 1, -3846.43, 3430.29, 363.729, 0.488692, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68541 ID: 22991'),
(2135832, 185549, 530, 0, 0, 1, 1, -3864.13, 3439.06, 363.679, -0.05236, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68542 ID: 22991'),
(2135833, 185549, 530, 0, 0, 1, 1, -3863.24, 3440.42, 363.655, 0.349066, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68554 ID: 22991'),
(2135834, 185549, 530, 0, 0, 1, 1, -3846.35, 3439.34, 363.628, -0.122173, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68555 ID: 22991'),
(2135835, 185549, 530, 0, 0, 1, 1, -3847.32, 3441.39, 363.648, 0.453786, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68556 ID: 22991'),
(2135836, 185549, 530, 0, 0, 1, 1, -3686.21, 3301, 320.513, 0.837758, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68557 ID: 22991'),
(2135837, 185549, 530, 0, 0, 1, 1, -3687.77, 3299.85, 320.307, 2.75762, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68572 ID: 22991'),
(2135838, 185549, 530, 0, 0, 1, 1, -3692.64, 3302.07, 320.396, -0.226893, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68573 ID: 22991'),
(2135839, 185549, 530, 0, 0, 1, 1, -3661.91, 3379.15, 320.377, 0.890118, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68574 ID: 22991'),
(2135840, 185549, 530, 0, 0, 1, 1, -3660.65, 3381.9, 320.182, 1.18682, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68575 ID: 22991'),
(2135841, 185549, 530, 0, 0, 1, 1, -3665.48, 3380.11, 320.365, -0.471239, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68576 ID: 22991'),
(2135842, 185549, 530, 0, 0, 1, 1, -3685.07, 3305.97, 320.198, -2.87979, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68728 ID: 22991'),
(2135843, 185549, 530, 0, 0, 1, 1, -3688.3, 3308.93, 320.337, 1.65806, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68737 ID: 22991'),
(2135844, 185549, 530, 0, 0, 1, 1, -3690.65, 3306.77, 320.43, -2.79253, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68837 ID: 22991'),
(2135845, 185549, 530, 0, 0, 1, 1, -3879.37, 3665.22, 374.393, -2.30383, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68932 ID: 22991'),
(2135846, 185549, 530, 0, 0, 1, 1, -3990.42, 3139.13, 372.878, -2.61799, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68933 ID: 22991'),
(2135847, 185549, 530, 0, 0, 1, 1, -3991.59, 3134.33, 372.703, -0.017453, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68934 ID: 22991'),
(2135848, 185549, 530, 0, 0, 1, 1, -3884.89, 3684.98, 374.492, -2.53073, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 68935 ID: 22991'),
(2135849, 185549, 530, 0, 0, 1, 1, -3800.8, 3789.62, 314, 6.0912, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 132937 ID: 22991'),
(2135850, 185549, 530, 0, 0, 1, 1, -3799.02, 3788.06, 314.158, 3.19395, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 132938 ID: 22991'),
(2135851, 185549, 530, 0, 0, 1, 1, -3798.91, 3790.61, 313.852, 3.63029, 0, 0, 0, 0, 44, 0, 1, '', 0, 'Migrated from table creature, GUID: 132939 ID: 22991');

-- remove old creature spawns
DELETE FROM `creature` WHERE (`id1` = 22991);