-- DB update 2025_07_22_00 -> 2025_07_22_01

-- Delete some guids.
DELETE FROM `gameobject` WHERE (`id` = 188691) AND (`guid` IN (55959, 55960, 55961, 55962));

-- Update positions and orientations (sniffed values).
UPDATE `gameobject` SET `position_x` = 4049.0764, `position_y` = -3725.0347, `position_z` = 222.83528, `orientation` = 5.811947, `VerifiedBuild` = 61967 WHERE (`id` = 188691) AND (`guid` = 55930);
UPDATE `gameobject` SET `position_x` = 4089.6614, `position_y` = -3676.9949, `position_z` = 178.89473, `orientation` = 5.811947, `VerifiedBuild` = 61967 WHERE (`id` = 188691) AND (`guid` = 55931);
UPDATE `gameobject` SET `position_x` = 4111.0522, `position_y` = -3677.9045, `position_z` = 179.84273, `orientation` = 5.811947, `VerifiedBuild` = 61967 WHERE (`id` = 188691) AND (`guid` = 55932);
UPDATE `gameobject` SET `position_x` = 4127.012, `position_y` = -3665.212, `position_z` = 179.51326, `orientation` = 5.811947, `VerifiedBuild` = 61967 WHERE (`id` = 188691) AND (`guid` = 55933);
UPDATE `gameobject` SET `position_x` = 4072.3828, `position_y` = -3725.7395, `position_z` = 144.04156, `orientation` = 5.811947, `VerifiedBuild` = 61967 WHERE (`id` = 188691) AND (`guid` = 55935);
UPDATE `gameobject` SET `position_x` = 4062.7354, `position_y` = -3728.8699, `position_z` = 143.54272, `orientation` = 5.811947, `VerifiedBuild` = 61967 WHERE (`id` = 188691) AND (`guid` = 55936);
UPDATE `gameobject` SET `position_x` = 4031.572, `position_y` = -3718.9636, `position_z` = 145.44913, `orientation` = 5.811947, `VerifiedBuild` = 61967 WHERE (`id` = 188691) AND (`guid` = 55937);
UPDATE `gameobject` SET `position_x` = 4002.6104, `position_y` = -3716.4358, `position_z` = 148.05672, `orientation` = 5.811947, `VerifiedBuild` = 61967 WHERE (`id` = 188691) AND (`guid` = 55938);
UPDATE `gameobject` SET `position_x` = 4177.96, `position_y` = -3727.9253, `position_z` = 130.41643, `orientation` = 5.811947, `VerifiedBuild` = 61967 WHERE (`id` = 188691) AND (`guid` = 55939);
UPDATE `gameobject` SET `position_x` = 4034.9836, `position_y` = -3799.606, `position_z` = 114.09692, `orientation` = 5.811947, `VerifiedBuild` = 61967 WHERE (`id` = 188691) AND (`guid` = 55940);
UPDATE `gameobject` SET `position_x` = 4209.658, `position_y` = -3755.5833, `position_z` = 181.86472, `orientation` = 5.811947, `VerifiedBuild` = 61967 WHERE (`id` = 188691) AND (`guid` = 55941);
UPDATE `gameobject` SET `position_x` = 4208.241, `position_y` = -3747.861, `position_z` = 124.98235, `orientation` = 5.811947, `VerifiedBuild` = 61967 WHERE (`id` = 188691) AND (`guid` = 55942);
UPDATE `gameobject` SET `position_x` = 4184.1787, `position_y` = -3762.8247, `position_z` = 126.69702, `orientation` = 5.811947, `VerifiedBuild` = 61967 WHERE (`id` = 188691) AND (`guid` = 55943);
UPDATE `gameobject` SET `position_x` = 4201.357, `position_y` = -3805.2969, `position_z` = 118.89274, `orientation` = 5.811947, `VerifiedBuild` = 61967 WHERE (`id` = 188691) AND (`guid` = 55944);
UPDATE `gameobject` SET `position_x` = 4224.1807, `position_y` = -3778.0105, `position_z` = 183.51997, `orientation` = 5.811947, `VerifiedBuild` = 61967 WHERE (`id` = 188691) AND (`guid` = 55945);
UPDATE `gameobject` SET `position_x` = 4204.343, `position_y` = -3851.4202, `position_z` = 181.15436, `orientation` = 5.811947, `VerifiedBuild` = 61967 WHERE (`id` = 188691) AND (`guid` = 55946);
UPDATE `gameobject` SET `position_x` = 4198.049, `position_y` = -3876.462, `position_z` = 178.56763, `orientation` = 5.811947, `VerifiedBuild` = 61967 WHERE (`id` = 188691) AND (`guid` = 55947);
UPDATE `gameobject` SET `position_x` = 4180.7476, `position_y` = -3887.882, `position_z` = 178.74002, `orientation` = 5.811947, `VerifiedBuild` = 61967 WHERE (`id` = 188691) AND (`guid` = 55948);
UPDATE `gameobject` SET `position_x` = 4198.53, `position_y` = -3916.6128, `position_z` = 177.42749, `orientation` = 5.811947, `VerifiedBuild` = 61967 WHERE (`id` = 188691) AND (`guid` = 55949);
UPDATE `gameobject` SET `position_x` = 4109.0723, `position_y` = -3910.1614, `position_z` = 174.23239, `orientation` = 5.811947, `VerifiedBuild` = 61967 WHERE (`id` = 188691) AND (`guid` = 55950);
UPDATE `gameobject` SET `position_x` = 4202.6284, `position_y` = -3965.2778, `position_z` = 172.75789, `orientation` = 5.811947, `VerifiedBuild` = 61967 WHERE (`id` = 188691) AND (`guid` = 55951);
UPDATE `gameobject` SET `position_x` = 4172.5615, `position_y` = -3973.8438, `position_z` = 171.01875, `orientation` = 5.811947, `VerifiedBuild` = 61967 WHERE (`id` = 188691) AND (`guid` = 55952);
UPDATE `gameobject` SET `position_x` = 4087.7986, `position_y` = -3926.1963, `position_z` = 175.39967, `orientation` = 5.811947, `VerifiedBuild` = 61967 WHERE (`id` = 188691) AND (`guid` = 55953);
UPDATE `gameobject` SET `position_x` = 4061.7222, `position_y` = -3963.1284, `position_z` = 168.42976, `orientation` = 5.811947, `VerifiedBuild` = 61967 WHERE (`id` = 188691) AND (`guid` = 55954);
UPDATE `gameobject` SET `position_x` = 4018.9792, `position_y` = -3980.8386, `position_z` = 168.22932, `orientation` = 5.811947, `VerifiedBuild` = 61967 WHERE (`id` = 188691) AND (`guid` = 55955);
UPDATE `gameobject` SET `position_x` = 4006.3196, `position_y` = -3979.9497, `position_z` = 168.12288, `orientation` = 5.811947, `VerifiedBuild` = 61967 WHERE (`id` = 188691) AND (`guid` = 55956);
UPDATE `gameobject` SET `position_x` = 3850.862, `position_y` = -3841.2065, `position_z` = 178.91513, `orientation` = 5.811947, `VerifiedBuild` = 61967 WHERE (`id` = 188691) AND (`guid` = 55957);
UPDATE `gameobject` SET `position_x` = 3890.2996, `position_y` = -3731.5244, `position_z` = 177.54457, `orientation` = 5.811947, `VerifiedBuild` = 61967 WHERE (`id` = 188691) AND (`guid` = 55958);
