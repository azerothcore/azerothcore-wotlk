-- Skettis (Terokkar Forest, area 3679): Skettis Wing Guard, Windwalker, Talonite and Kaliri rebuilt from sniffs.
-- Positions: CO2 points from 4.4.0.55141 (Cata Classic CO2 farm of the arakkoa) and WotLK Classic 3.4.x, plus CO1
-- points that stayed put for 2+ minutes. Talonite work walks and idle loops from the same farm (3.4.3.52237,
-- 10.0.2.47213 as second witnesses). Skettis Time-Shifter, Sentinel and Eviscerator: never seen in any sniff.

-- Never sniffed
DELETE FROM `creature` WHERE `id`=21652 AND `guid` IN (75613, 75614, 75615, 75616, 75617, 75618, 75619, 75620, 75621, 75622, 75623, 75624, 75625, 75626, 75627, 75628, 75629, 75630, 75631, 75632, 75633, 75634, 75635, 75636, 75637, 75638, 75639);
DELETE FROM `creature` WHERE `id`=21912 AND `guid` IN (76677, 76678, 76679, 76680, 76681, 76682, 76683, 76684, 76685, 76686, 76687, 76688, 76689, 76690, 76691, 76692, 76693, 76694, 76695, 76696, 76697);
DELETE FROM `creature` WHERE `id`=21985 AND `guid` IN (76774, 76775, 76776, 76777, 76778, 76779, 76780, 76781, 76782, 76783, 76784, 76785, 76786, 76787, 76788, 76789, 76790, 76791, 76792, 76793, 76794);

-- Rows no sniffed spawn needs
DELETE FROM `creature` WHERE `id`=21644 AND `guid` IN (75474, 75476, 75477, 75478, 75479, 75480, 75481, 75483, 75485, 75486, 75487, 75488, 75489, 75490, 75492, 75493, 75494, 75495, 75496, 75497, 75499, 75500, 75501, 75502, 75503, 75504, 75505, 75506, 75507, 75508, 75509, 75512, 75513, 75514, 75515, 75516, 75517, 75518, 75519, 75520, 75521, 75522, 75523, 75524, 75525, 75526, 75527, 75529, 75532, 75535, 75536, 75537, 75538, 75539, 75540);
DELETE FROM `creature` WHERE `id`=21649 AND `guid` IN (75560, 75561, 75562, 75565, 75566, 75568, 75569, 75570, 75573, 75575, 75577, 75578, 75580, 75583, 75594, 75595, 75596, 75598, 75599, 75600, 75601);
DELETE FROM `creature` WHERE `id`=21804 AND `guid` IN (76137, 76138);
DELETE FROM `creature_addon` WHERE `guid` IN (75474, 75476, 75477, 75478, 75479, 75480, 75481, 75482, 75483, 75484, 75485, 75486, 75487, 75488, 75489, 75490, 75491, 75492, 75493, 75494, 75495, 75496, 75497, 75498, 75499, 75500, 75501, 75502, 75503, 75504, 75505, 75506, 75507, 75508, 75509, 75510, 75511, 75512, 75513, 75514, 75515, 75516, 75517, 75518, 75519, 75520, 75521, 75522, 75523, 75524, 75525, 75526, 75527, 75528, 75529, 75530, 75531, 75532, 75533, 75534, 75535, 75536, 75537, 75538, 75539, 75540, 75560, 75561, 75562, 75563, 75564, 75565, 75566, 75567, 75568, 75569, 75570, 75571, 75572, 75573, 75574, 75575, 75576, 75577, 75578, 75579, 75580, 75581, 75582, 75583, 75584, 75585, 75586, 75587, 75588, 75589, 75591, 75592, 75593, 75594, 75595, 75596, 75597, 75598, 75599, 75600, 75601, 75603, 75604, 75605, 75606, 75607, 75608, 75609, 75610, 75611, 75612, 75613, 75614, 75615, 75616, 75617, 75618, 75619, 75620, 75621, 75622, 75623, 75624, 75625, 75626, 75627, 75628, 75629, 75630, 75631, 75632, 75633, 75634, 75635, 75636, 75637, 75638, 75639, 76132, 76133, 76134, 76135, 76136, 76137, 76138, 76139, 76140, 76141, 76142, 76143, 76144, 76145, 76146, 76147, 76148, 76149, 76150, 76151, 76152, 76153, 76154, 76155, 76156, 76157, 76158, 76159, 76160, 76161, 76677, 76678, 76679, 76680, 76681, 76682, 76683, 76684, 76685, 76686, 76687, 76688, 76689, 76690, 76691, 76692, 76693, 76694, 76695, 76696, 76697, 76774, 76775, 76776, 76777, 76778, 76779, 76780, 76781, 76782, 76783, 76784, 76785, 76786, 76787, 76788, 76789, 76790, 76791, 76792, 76793, 76794, 132650, 132651, 132778, 132780);

-- Existing spawns: sniffed position, facing and movement
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3651.66, `position_y`=3715.64, `position_z`=281.598, `orientation`=4.6077, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21644 AND `guid`=75482;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3664.69, `position_y`=3719.19, `position_z`=281.28, `orientation`=4.2586, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21644 AND `guid`=75484;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3855.56, `position_y`=3795.27, `position_z`=287.068, `orientation`=0.4712, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21644 AND `guid`=75491;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4055.04, `position_y`=3308.39, `position_z`=284.459, `orientation`=1.4137, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21644 AND `guid`=75498;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4186.96, `position_y`=3089.44, `position_z`=324.074, `orientation`=1.5533, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21644 AND `guid`=75510;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4172.23, `position_y`=3087.3, `position_z`=323.689, `orientation`=1.0647, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21644 AND `guid`=75511;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4035.94, `position_y`=3307.84, `position_z`=284.261, `orientation`=1.5708, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21644 AND `guid`=75528;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3869.38, `position_y`=3325.48, `position_z`=274.596, `orientation`=3.7699, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21644 AND `guid`=75530;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3854.93, `position_y`=3311.53, `position_z`=274.564, `orientation`=3.7176, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21644 AND `guid`=75531;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3734.68, `position_y`=3309.81, `position_z`=293.574, `orientation`=3.0369, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21644 AND `guid`=75533;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3727.73, `position_y`=3320.53, `position_z`=291.755, `orientation`=2.6878, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21644 AND `guid`=75534;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3840.9, `position_y`=3775.09, `position_z`=285.732, `orientation`=0.6632, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21644 AND `guid`=132778;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3712.35, `position_y`=3710.6, `position_z`=277.875, `orientation`=4.486, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21649 AND `guid`=75563;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3739.6, `position_y`=3748.64, `position_z`=273.822, `orientation`=0.0698, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21649 AND `guid`=75564;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3801.34, `position_y`=3785.97, `position_z`=275.574, `orientation`=1.5882, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21649 AND `guid`=75567;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4074.62, `position_y`=3411.43, `position_z`=296.01, `orientation`=2.1467, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21649 AND `guid`=75571;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4095.32, `position_y`=3349.39, `position_z`=285.753, `orientation`=0.0873, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21649 AND `guid`=75572;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4179.07, `position_y`=3211.85, `position_z`=314.277, `orientation`=2.6015, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21649 AND `guid`=75574;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4095.24, `position_y`=3187.52, `position_z`=297.125, `orientation`=4.7298, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21649 AND `guid`=75576;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4173.23, `position_y`=3116.24, `position_z`=322.085, `orientation`=3.9199, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21649 AND `guid`=75579;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4110.59, `position_y`=3119.43, `position_z`=319.222, `orientation`=2.3038, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21649 AND `guid`=75581;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4115.69, `position_y`=3052.84, `position_z`=314.352, `orientation`=5.4454, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21649 AND `guid`=75582;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4016.57, `position_y`=3079.19, `position_z`=336.549, `orientation`=3.4383, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21649 AND `guid`=75584;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3917.48, `position_y`=2985.62, `position_z`=358.446, `orientation`=0.8901, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21649 AND `guid`=75585;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3975.3, `position_y`=3004.88, `position_z`=362.166, `orientation`=0.5061, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21649 AND `guid`=75586;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3886.4, `position_y`=3045.04, `position_z`=358.224, `orientation`=5.2884, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21649 AND `guid`=75587;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3884.6, `position_y`=3001.95, `position_z`=361.278, `orientation`=5.0964, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21649 AND `guid`=75588;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4019.05, `position_y`=3276.68, `position_z`=285.021, `orientation`=3.4383, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21649 AND `guid`=75589;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3958.68, `position_y`=3250.24, `position_z`=294.14, `orientation`=1.5533, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21649 AND `guid`=75591;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3945.96, `position_y`=3314.51, `position_z`=288.136, `orientation`=0.9599, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21649 AND `guid`=75592;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3874.46, `position_y`=3280.49, `position_z`=275.767, `orientation`=0.1396, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21649 AND `guid`=75593;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3674.94, `position_y`=3319.43, `position_z`=283.569, `orientation`=2.6005, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21649 AND `guid`=75597;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4194.8, `position_y`=3170.41, `position_z`=317.686, `orientation`=3.6568, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21649 AND `guid`=132780;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3796.52, `position_y`=3751.35, `position_z`=278.421, `orientation`=2.6529, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21650 AND `guid`=75603;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3685.11, `position_y`=3707.43, `position_z`=277.898, `orientation`=5.1313, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21650 AND `guid`=75604;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3708.66, `position_y`=3783.71, `position_z`=270.607, `orientation`=5.2709, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21650 AND `guid`=75605;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3691.04, `position_y`=3778.15, `position_z`=270.233, `orientation`=3.5605, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21650 AND `guid`=75606;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4102.73, `position_y`=3228.18, `position_z`=299.193, `orientation`=5.5676, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21650 AND `guid`=75607;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4049.66, `position_y`=3189.33, `position_z`=297.434, `orientation`=2.9845, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21650 AND `guid`=75608;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4173.061, `position_y`=3063.4504, `position_z`=314.1861, `orientation`=1.6164, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=1 WHERE `id`=21650 AND `guid`=75609;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3922.63, `position_y`=3117.9, `position_z`=329.121, `orientation`=0.7505, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21650 AND `guid`=75610;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3679.73, `position_y`=3371.85, `position_z`=283.075, `orientation`=0.6109, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21650 AND `guid`=75611;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3828.96, `position_y`=3288.91, `position_z`=275.27, `orientation`=6.0185, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=57564, `CreateObject`=2 WHERE `id`=21650 AND `guid`=75612;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4084.55, `position_y`=3050.78, `position_z`=316.467, `orientation`=1.8543, `wander_distance`=20, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21804 AND `guid`=76132;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4148.69, `position_y`=3083.04, `position_z`=316.918, `orientation`=5.2675, `wander_distance`=20, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21804 AND `guid`=76133;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3678.19, `position_y`=3720.2, `position_z`=277.687, `orientation`=0.7198, `wander_distance`=20, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21804 AND `guid`=76134;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4152.55, `position_y`=3018.96, `position_z`=316.468, `orientation`=3.5736, `wander_distance`=20, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21804 AND `guid`=76135;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3711.65, `position_y`=3750.66, `position_z`=278.43, `orientation`=1.0874, `wander_distance`=20, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21804 AND `guid`=76136;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4116.4, `position_y`=3083.52, `position_z`=316.153, `orientation`=6.2393, `wander_distance`=20, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21804 AND `guid`=76139;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3816.68, `position_y`=3751.69, `position_z`=277.678, `orientation`=1.5258, `wander_distance`=20, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21804 AND `guid`=76140;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4070.76, `position_y`=3385.79, `position_z`=289.3, `orientation`=2.7587, `wander_distance`=20, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21804 AND `guid`=76141;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4084.08, `position_y`=3214.32, `position_z`=296.479, `orientation`=5.2763, `wander_distance`=20, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21804 AND `guid`=76142;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4048.95, `position_y`=3320.29, `position_z`=284.615, `orientation`=0.5802, `wander_distance`=20, `MovementType`=1, `VerifiedBuild`=53622, `CreateObject`=2 WHERE `id`=21804 AND `guid`=76143;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4075.52, `position_y`=3185.96, `position_z`=296.605, `orientation`=1.1112, `wander_distance`=20, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21804 AND `guid`=76144;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4148.75, `position_y`=3051.13, `position_z`=314.292, `orientation`=2.7531, `wander_distance`=20, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21804 AND `guid`=76145;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4019.4, `position_y`=3149.97, `position_z`=310.319, `orientation`=4.3718, `wander_distance`=20, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21804 AND `guid`=76146;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3984.51, `position_y`=3080.77, `position_z`=339.494, `orientation`=3.5073, `wander_distance`=20, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21804 AND `guid`=76147;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3926.91, `position_y`=3048.13, `position_z`=357.963, `orientation`=4.1204, `wander_distance`=20, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21804 AND `guid`=76148;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3907.26, `position_y`=3135.78, `position_z`=328.906, `orientation`=5.8718, `wander_distance`=20, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21804 AND `guid`=76149;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3951.43, `position_y`=3283.69, `position_z`=289.425, `orientation`=2.308, `wander_distance`=20, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21804 AND `guid`=76150;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4050.43, `position_y`=3147.04, `position_z`=304.383, `orientation`=3.6253, `wander_distance`=20, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21804 AND `guid`=76151;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3983.13, `position_y`=3278.39, `position_z`=286.464, `orientation`=0.8184, `wander_distance`=20, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21804 AND `guid`=76152;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4075.22, `position_y`=3351.79, `position_z`=285.221, `orientation`=0.473, `wander_distance`=20, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21804 AND `guid`=76153;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3853.46, `position_y`=3287.82, `position_z`=275.14, `orientation`=2.1286, `wander_distance`=20, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21804 AND `guid`=76154;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4083.37, `position_y`=3113.97, `position_z`=315.975, `orientation`=3.0682, `wander_distance`=20, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21804 AND `guid`=76155;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3745.89, `position_y`=3315.35, `position_z`=293.368, `orientation`=5.2613, `wander_distance`=20, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21804 AND `guid`=76156;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3909.52, `position_y`=3020.35, `position_z`=356.844, `orientation`=5.03, `wander_distance`=20, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21804 AND `guid`=76157;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3688.77, `position_y`=3352.16, `position_z`=284.15, `orientation`=1.1117, `wander_distance`=20, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21804 AND `guid`=76158;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3954.74, `position_y`=3023.43, `position_z`=356.993, `orientation`=0.2871, `wander_distance`=20, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21804 AND `guid`=76159;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3884.1707, `position_y`=3481.9705, `position_z`=275.0785, `orientation`=3.9044, `wander_distance`=20, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21804 AND `guid`=76160;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3831.19, `position_y`=3534.54, `position_z`=279.978, `orientation`=0.9919, `wander_distance`=20, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21804 AND `guid`=76161;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4153.97, `position_y`=3117.65, `position_z`=320.665, `orientation`=3.9103, `wander_distance`=20, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21804 AND `guid`=132650;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4170.21, `position_y`=3173.47, `position_z`=316.288, `orientation`=5.6514, `wander_distance`=20, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21804 AND `guid`=132651;

-- Missing spawns
DELETE FROM `creature` WHERE `id`=21650 AND `guid` IN (75474, 75476, 75477, 75478, 75479, 75480, 75481, 75483, 75485, 75486, 75487, 75488, 75489);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(75474, 21650, 530, 0, 0, 1, 1, 1, -4183.36, 3029.33, 314.302, 0.576, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 52237, 2, NULL), -- Skettis Talonite
(75476, 21650, 530, 0, 0, 1, 1, 1, -4181.78, 3061.55, 314.312, 5.62, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 55141, 2, NULL), -- Skettis Talonite
(75477, 21650, 530, 0, 0, 1, 1, 1, -4157.19, 3186.35, 313.9, 3.6128, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 52237, 2, NULL), -- Skettis Talonite
(75478, 21650, 530, 0, 0, 1, 1, 1, -4126.36, 3018.32, 314.247, 2.6005, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 52237, 2, NULL), -- Skettis Talonite
(75479, 21650, 530, 0, 0, 1, 1, 1, -4012.37, 3145.48, 310.758, 2.7576, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 52237, 2, NULL), -- Skettis Talonite
(75480, 21650, 530, 0, 0, 1, 1, 1, -3988.88, 3031.76, 356.956, 0.0698, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 52237, 2, NULL), -- Skettis Talonite
(75481, 21650, 530, 0, 0, 1, 1, 1, -3978.2, 3045.67, 357.12, 5.3058, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 52237, 2, NULL), -- Skettis Talonite
(75483, 21650, 530, 0, 0, 1, 1, 1, -3947.9, 2991.69, 359.297, 1.2392, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 55141, 2, NULL), -- Skettis Talonite
(75485, 21650, 530, 0, 0, 1, 1, 1, -3883.88, 3126.34, 329.123, 3.5605, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 52237, 2, NULL), -- Skettis Talonite
(75486, 21650, 530, 0, 0, 1, 1, 1, -3748.89, 3299.41, 296.395, 4.2935, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 52237, 2, NULL), -- Skettis Talonite
(75487, 21650, 530, 0, 0, 1, 1, 1, -3921.5764, 2964.428, 359.2417, 5.8294, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 55141, 1, NULL), -- Skettis Talonite
(75488, 21650, 530, 0, 0, 1, 1, 1, -3917.3264, 2950.534, 358.7416, 1.9024, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 55141, 1, NULL), -- Skettis Talonite
(75489, 21650, 530, 0, 0, 1, 1, 1, -3931.8064, 3001.5652, 358.5641, 4.7469, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 52237, 1, NULL); -- Skettis Talonite

DELETE FROM `creature_addon` WHERE `guid` IN (75474, 75478, 75479, 75480, 75481, 75485, 75489, 75579, 75603, 75604, 75605, 75606, 75607, 75608, 75609, 75610, 75611, 75612);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(75474, 754740, 0, 0, 1, 0, 0, ''),
(75478, 754780, 0, 0, 1, 0, 0, ''),
(75479, 754790, 0, 0, 1, 0, 0, ''),
(75480, 754800, 0, 0, 1, 0, 0, ''),
(75481, 754810, 0, 0, 1, 0, 0, ''),
(75485, 754850, 0, 0, 1, 0, 0, ''),
(75489, 0, 0, 8, 1, 0, 0, ''),
(75579, 0, 0, 8, 1, 0, 0, ''),
(75603, 756030, 0, 0, 1, 0, 0, ''),
(75604, 0, 0, 8, 1, 0, 0, ''),
(75605, 756050, 0, 0, 1, 0, 0, ''),
(75606, 756060, 0, 0, 1, 0, 0, ''),
(75607, 756070, 0, 0, 1, 0, 0, ''),
(75608, 756080, 0, 0, 1, 0, 0, ''),
(75609, 0, 0, 8, 1, 0, 0, ''),
(75610, 756100, 0, 0, 1, 0, 0, ''),
(75611, 0, 0, 8, 1, 0, 0, ''),
(75612, 0, 0, 8, 1, 0, 0, '');

-- Talonite work walks: home wait first, then out to the work spot and back
DELETE FROM `waypoint_data` WHERE `id` IN (754740, 754780, 754790, 754800, 754810, 754850, 756030, 756050, 756060, 756070, 756080, 756100);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`, `smoothTransition`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(754740, 1, -4183.3594, 3029.3325, 314.2143, 0.576, 0, 95200, 0, 0, 0, 100, 0),
(754740, 2, -4176.507, 3032.678, 313.9821, NULL, 0, 0, 0, 0, 0, 100, 0),
(754740, 3, -4159.6787, 3049.016, 314.1471, NULL, 0, 0, 0, 0, 0, 100, 0),
(754740, 4, -4144.494, 3066.288, 314.1599, NULL, 0, 7200, 0, 0, 0, 100, 0),
(754740, 5, -4168.358, 3037.7812, 314.4267, NULL, 0, 700, 0, 0, 0, 100, 0),
(754780, 1, -4126.551, 3018.273, 314.1504, 2.6005, 0, 223800, 0, 0, 0, 100, 0),
(754780, 2, -4134.263, 3016.8599, 313.9356, NULL, 0, 6600, 0, 0, 0, 100, 0),
(754790, 1, -4012.3655, 3145.4846, 310.6744, 2.7576, 0, 112800, 0, 0, 0, 100, 0),
(754790, 2, -4026.464, 3152.882, 309.7105, NULL, 0, 0, 0, 0, 0, 100, 0),
(754790, 3, -4042.2605, 3138.0051, 307.5522, NULL, 0, 0, 0, 0, 0, 100, 0),
(754790, 4, -4039.0156, 3133.951, 307.8937, NULL, 0, 0, 0, 0, 0, 100, 0),
(754790, 5, -4020.3816, 3151.1953, 310.2844, NULL, 0, 0, 0, 0, 0, 100, 0),
(754790, 6, -4006.283, 3153.4526, 311.1021, NULL, 0, 0, 0, 0, 0, 100, 0),
(754790, 7, -4003.839, 3149.182, 311.3159, NULL, 0, 6100, 0, 0, 0, 100, 0),
(754800, 1, -3988.7783, 3031.8325, 356.8655, 0.0698, 0, 101700, 0, 0, 0, 100, 0),
(754800, 2, -3981.6245, 3036.7305, 356.6657, NULL, 0, 6300, 0, 0, 0, 100, 0),
(754810, 1, -3978.2668, 3045.474, 357.0268, 5.3058, 0, 113000, 0, 0, 0, 100, 0),
(754810, 2, -3980.5742, 3039.2378, 356.6657, NULL, 0, 5700, 0, 0, 0, 100, 0),
(754850, 1, -3883.875, 3126.336, 329.0268, 3.5605, 0, 94400, 0, 0, 0, 100, 0),
(754850, 2, -3912.356, 3122.227, 328.4998, NULL, 0, 0, 0, 0, 0, 100, 0),
(754850, 3, -3925.2488, 3136.9797, 328.0956, NULL, 0, 0, 0, 0, 0, 100, 0),
(754850, 4, -3930.7356, 3131.4038, 329.0748, NULL, 0, 7700, 0, 0, 0, 100, 0),
(754850, 5, -3914.8665, 3121.2551, 328.5578, NULL, 0, 0, 0, 0, 0, 100, 0),
(754850, 6, -3894.9766, 3126.6204, 328.36, NULL, 0, 500, 0, 0, 0, 100, 0),
(756030, 1, -3796.6428, 3751.3416, 278.3296, 2.6529, 0, 144200, 0, 0, 0, 100, 0),
(756030, 2, -3801.6714, 3745.0347, 278.3214, NULL, 0, 6800, 0, 0, 0, 100, 0),
(756050, 1, -3708.568, 3783.6902, 270.5092, 5.2709, 0, 114400, 0, 0, 0, 100, 0),
(756050, 2, -3702.0088, 3780.9536, 269.8425, NULL, 0, 7000, 0, 0, 0, 100, 0),
(756060, 1, -3691.0442, 3778.145, 270.1543, 3.5605, 0, 98700, 0, 0, 0, 100, 0),
(756060, 2, -3698.8901, 3780.1184, 269.7896, NULL, 0, 7200, 0, 0, 0, 100, 0),
(756070, 1, -4102.7266, 3228.1804, 299.1032, 5.5676, 0, 89300, 0, 0, 0, 100, 0),
(756070, 2, -4101.667, 3224.9785, 299.0628, NULL, 0, 6300, 0, 0, 0, 100, 0),
(756080, 1, -4049.6624, 3189.3347, 297.3443, 2.9845, 0, 102000, 0, 0, 0, 100, 0),
(756080, 2, -4056.8057, 3191.108, 297.2066, NULL, 0, 0, 0, 0, 0, 100, 0),
(756080, 3, -4077.4778, 3192.3352, 296.3344, NULL, 0, 0, 0, 0, 0, 100, 0),
(756080, 4, -4079.159, 3217.289, 296.5707, NULL, 0, 7900, 0, 0, 0, 100, 0),
(756080, 5, -4076.013, 3191.405, 296.4065, NULL, 0, 0, 0, 0, 0, 100, 0),
(756080, 6, -4057.568, 3191.0781, 297.1728, NULL, 0, 1400, 0, 0, 0, 100, 0),
(756100, 1, -3922.6272, 3117.9004, 329.0268, 0.7505, 0, 133200, 0, 0, 0, 100, 0),
(756100, 2, -3925.668, 3125.6785, 328.9043, NULL, 0, 7400, 0, 0, 0, 100, 0),
(756100, 3, -3917.2766, 3121.8152, 328.5911, NULL, 0, 1000, 0, 0, 0, 100, 0);

-- Guid SAI; DONT_OVERRIDE_ENTRY_SAI so the entry combat scripts keep loading beside it
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|0x08000000 WHERE `entry` IN (21649, 21650);
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid` IN (-75612, -75611, -75610, -75608, -75607, -75606, -75605, -75604, -75603, -75591, -75579, -75576, -75564, -75486, -75485, -75481, -75480, -75479, -75478, -75477);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-75612, 0, 0, 0, 1, 0, 100, 0, 0, 40000, 32000, 40000, 0, 0, 80, 2165002, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - Out of Combat - Run Script'),
(-75611, 0, 0, 0, 1, 0, 100, 0, 0, 40000, 32000, 40000, 0, 0, 80, 2165002, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - Out of Combat - Run Script'),
(-75610, 0, 0, 0, 108, 0, 100, 0, 2, 756100, 0, 0, 0, 0, 80, 7561002, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - On Point 2 of Path 756100 Reached - Run Script'),
(-75608, 0, 0, 0, 108, 0, 100, 0, 4, 756080, 0, 0, 0, 0, 80, 7560804, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - On Point 4 of Path 756080 Reached - Run Script'),
(-75607, 0, 0, 0, 108, 0, 100, 0, 2, 756070, 0, 0, 0, 0, 80, 2165001, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - On Point 2 of Path 756070 Reached - Run Script'),
(-75606, 0, 0, 0, 108, 0, 100, 0, 2, 756060, 0, 0, 0, 0, 80, 7560602, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - On Point 2 of Path 756060 Reached - Run Script'),
(-75605, 0, 0, 0, 108, 0, 100, 0, 2, 756050, 0, 0, 0, 0, 80, 7560502, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - On Point 2 of Path 756050 Reached - Run Script'),
(-75604, 0, 0, 0, 1, 0, 100, 0, 0, 40000, 32000, 40000, 0, 0, 80, 2165002, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - Out of Combat - Run Script'),
(-75603, 0, 0, 0, 108, 0, 100, 0, 2, 756030, 0, 0, 0, 0, 80, 7560302, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - On Point 2 of Path 756030 Reached - Run Script'),
(-75591, 0, 0, 0, 1, 0, 100, 0, 0, 168000, 95000, 168000, 0, 0, 80, 2164901, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Windwalker - Out of Combat - Run Script'),
(-75579, 0, 0, 0, 1, 0, 100, 0, 0, 38000, 30000, 38000, 0, 0, 80, 7557901, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Windwalker - Out of Combat - Run Script'),
(-75576, 0, 0, 0, 1, 0, 100, 0, 3643, 6494, 3643, 6494, 0, 0, 5, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Windwalker - Out of Combat - Play Emote 1'),
(-75564, 0, 0, 0, 1, 0, 100, 0, 0, 553000, 128000, 553000, 0, 0, 80, 2164901, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Windwalker - Out of Combat - Run Script'),
(-75486, 0, 0, 0, 1, 0, 100, 0, 0, 203000, 51000, 203000, 0, 0, 80, 7548601, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - Out of Combat - Run Script'),
(-75485, 0, 0, 0, 108, 0, 100, 0, 4, 754850, 0, 0, 0, 0, 80, 7548504, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - On Point 4 of Path 754850 Reached - Run Script'),
(-75481, 0, 0, 0, 108, 0, 100, 0, 2, 754810, 0, 0, 0, 0, 80, 7548102, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - On Point 2 of Path 754810 Reached - Run Script'),
(-75480, 0, 0, 0, 108, 0, 100, 0, 2, 754800, 0, 0, 0, 0, 80, 2165001, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - On Point 2 of Path 754800 Reached - Run Script'),
(-75479, 0, 0, 0, 108, 0, 100, 0, 7, 754790, 0, 0, 0, 0, 80, 7547907, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - On Point 7 of Path 754790 Reached - Run Script'),
(-75478, 0, 0, 0, 108, 0, 100, 0, 2, 754780, 0, 0, 0, 0, 80, 7547802, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - On Point 2 of Path 754780 Reached - Run Script'),
(-75477, 0, 0, 0, 1, 0, 100, 0, 0, 178000, 129000, 178000, 0, 0, 80, 7547701, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - Out of Combat - Run Script');
DELETE FROM `smart_scripts` WHERE `source_type`=9 AND `entryorguid` IN (2164901, 2165001, 2165002, 7547701, 7547802, 7547907, 7548102, 7548504, 7548601, 7557901, 7560302, 7560502, 7560602, 7560804, 7561002);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2164901, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 69, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Windwalker - Actionlist - Set Emote State 69'),
(2164901, 9, 1, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Windwalker - Actionlist - Set Emote State 0'),
(2165001, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 69, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - Actionlist - Set Emote State 69'),
(2165001, 9, 1, 0, 0, 0, 100, 0, 6300, 6300, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - Actionlist - Set Emote State 0'),
(2165002, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - Actionlist - Remove Bytes1 8 (Stand)'),
(2165002, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 5, 61, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - Actionlist - Play Emote 61'),
(2165002, 9, 2, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - Actionlist - Set Bytes1 8 (Kneel)'),
(7547701, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 69, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - Actionlist - Set Emote State 69'),
(7547701, 9, 1, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - Actionlist - Set Emote State 0'),
(7547802, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 69, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - Actionlist - Set Emote State 69'),
(7547802, 9, 1, 0, 0, 0, 100, 0, 6600, 6600, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - Actionlist - Set Emote State 0'),
(7547907, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 69, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - Actionlist - Set Emote State 69'),
(7547907, 9, 1, 0, 0, 0, 100, 0, 6100, 6100, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - Actionlist - Set Emote State 0'),
(7548102, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 69, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - Actionlist - Set Emote State 69'),
(7548102, 9, 1, 0, 0, 0, 100, 0, 5700, 5700, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - Actionlist - Set Emote State 0'),
(7548504, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - Actionlist - Set Bytes1 8 (Kneel)'),
(7548504, 9, 1, 0, 0, 0, 100, 0, 7700, 7700, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - Actionlist - Remove Bytes1 8 (Kneel)'),
(7548601, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 69, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - Actionlist - Set Emote State 69'),
(7548601, 9, 1, 0, 0, 0, 100, 0, 27000, 27000, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - Actionlist - Set Emote State 0'),
(7557901, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Windwalker - Actionlist - Remove Bytes1 8 (Stand)'),
(7557901, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 5, 61, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Windwalker - Actionlist - Play Emote 61'),
(7557901, 9, 2, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Windwalker - Actionlist - Set Bytes1 8 (Kneel)'),
(7560302, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 69, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - Actionlist - Set Emote State 69'),
(7560302, 9, 1, 0, 0, 0, 100, 0, 6800, 6800, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - Actionlist - Set Emote State 0'),
(7560502, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 69, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - Actionlist - Set Emote State 69'),
(7560502, 9, 1, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - Actionlist - Set Emote State 0'),
(7560602, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 69, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - Actionlist - Set Emote State 69'),
(7560602, 9, 1, 0, 0, 0, 100, 0, 7200, 7200, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - Actionlist - Set Emote State 0'),
(7560804, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 5, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - Actionlist - Play Emote 1'),
(7561002, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - Actionlist - Set Bytes1 8 (Kneel)'),
(7561002, 9, 1, 0, 0, 0, 100, 0, 7400, 7400, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Talonite - Actionlist - Remove Bytes1 8 (Kneel)');

-- Skettis: Skettis Soulcaller and the Time-Lost Skettis Reaver, High Priest and
-- Worshipper rebuilt from sniffs. Positions: CO2 points (4.4.0.55141 Cata Classic CO2 farm, WotLK Classic 3.4.x).
-- Behaviour from the same farm's out-of-combat windows, 3.4.3.52237 and 10.0.2.47213 as second witnesses.
-- Soulcallers walk to a Kneel Target of their ritual circle, face the Spell Origin and channel; Time-Lost
-- wander 2 yd, kneel and shout, or walk their routes.

-- Skettis Soulcaller second weapon set: sniffed on one spawn only
DELETE FROM `creature_equip_template` WHERE `CreatureID`=21911 AND `ID`=2;
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`) VALUES
(21911, 2, 1117, 12861, 0, 52237); -- Monster - Item, Fishing Pole / Monster - Item, Book - Black Skull Glowing Offhand

-- Sniffed auras and VisFlags 1
DELETE FROM `creature_template_addon` WHERE `entry` IN (21651, 21763, 21787);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(21651, 0, 0, 65536, 1, 0, 0, '33900 37411 37816'), -- Time-Lost Skettis Reaver
(21763, 0, 0, 65536, 1, 0, 0, '33900 37411 37509 37816'), -- Time-Lost Skettis Worshipper
(21787, 0, 0, 65536, 1, 0, 0, '33900 37411 37509'); -- Time-Lost Skettis High Priest

-- Ritual bunnies: static in every sniff (AC had the Kneel Targets wandering 5 yd)
UPDATE `creature` SET `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=1 WHERE `id`=21654 AND `guid` IN (75640, 75641, 75642, 75643, 75644, 75645, 75646, 132837); -- Skettis Followers Spawner
UPDATE `creature` SET `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=1 WHERE `id`=21791 AND `guid` IN (76086, 76087, 76088, 76089, 76090, 76091, 76092, 132616); -- Skettis Kneel Target 01
UPDATE `creature` SET `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=1 WHERE `id`=21792 AND `guid` IN (76093, 76094, 76095, 76096, 76097, 76098, 76099, 132621); -- Skettis Kneel Target 02
UPDATE `creature` SET `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=1 WHERE `id`=21793 AND `guid` IN (76100, 76101, 76102, 76103, 76104, 76105, 76106, 132630); -- Skettis Kneel Target 03
UPDATE `creature` SET `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=1 WHERE `id`=21794 AND `guid` IN (76107, 76108, 76109, 76110, 76111, 76112, 76113, 132635); -- Skettis Arakkoa Spell Origin 01
UPDATE `creature` SET `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=1 WHERE `id`=21855 AND `guid` IN (76488, 76489, 76490, 76491, 132675); -- Skettis Arakkoa Spell Origin 02
UPDATE `creature` SET `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=1 WHERE `id`=21856 AND `guid` IN (76492, 76493, 76494, 76495, 132677); -- Skettis Kneel Target 04

-- Rows no sniffed spawn needs
DELETE FROM `creature_addon` WHERE `guid` IN (75492, 75493, 75494, 75495, 75496, 75497, 75499, 75500, 75501, 75502, 75503, 75504, 75505, 75506, 75508, 75509, 75512, 75514, 75515, 75516, 75517, 75518, 75519, 75520, 75521, 75522, 75523, 75524, 76656, 76657, 76658, 76659, 76660, 76661, 76662, 76663, 76664, 76665, 76666, 76667, 76668, 76669, 76670, 76671, 76672, 76673, 76674, 76675, 76676, 132539, 132540, 132541, 132542, 132543, 132544, 132545, 132546, 132547, 132548, 132549, 132550, 132551, 132552, 132572, 132574, 132575, 132576, 132577, 132578, 132579, 132580, 132581, 132582, 132583, 132584, 132585, 132586, 132587, 132588, 132589, 132590, 132591, 132592, 132593, 132594, 132595, 132596, 132597, 132598, 132599, 132600, 132601, 132602, 132603, 132604, 132605, 132606, 132607, 132608, 132781, 132782, 132783, 132784, 132785, 132786, 132787, 132788, 132789, 132790, 132791, 132792, 132793, 132794, 132795, 132796, 132797, 132798, 132799, 132800, 132801, 132802, 132803, 132804, 132805, 132806, 132807, 132808, 132809, 132810, 132811, 132812, 132813, 132839, 132840, 132841, 132842);

-- Existing spawns: sniffed position, facing and movement
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4147.09, `position_y`=3046.92, `position_z`=315.049, `orientation`=1.3861, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=55141, `CreateObject`=2 WHERE `id`=21651 AND `guid`=132781;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4111.81, `position_y`=3034.16, `position_z`=344.638, `orientation`=5.1514, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=55141, `CreateObject`=2 WHERE `id`=21651 AND `guid`=132782;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4098.58, `position_y`=3014.3, `position_z`=344.291, `orientation`=1.1345, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=55141, `CreateObject`=2 WHERE `id`=21651 AND `guid`=132783;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4176.98, `position_y`=3038.34, `position_z`=343.808, `orientation`=6.2723, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=55141, `CreateObject`=2 WHERE `id`=21651 AND `guid`=132784;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4201.81, `position_y`=3048.26, `position_z`=344.221, `orientation`=1.003, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=55262, `CreateObject`=2 WHERE `id`=21651 AND `guid`=132785;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4177.21, `position_y`=3185.07, `position_z`=315.629, `orientation`=1.3587, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=55141, `CreateObject`=2 WHERE `id`=21651 AND `guid`=132786;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3669.3, `position_y`=3390.64, `position_z`=312.961, `orientation`=1.4835, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21651 AND `guid`=132787;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3691.59, `position_y`=3290.75, `position_z`=312.3, `orientation`=5.7072, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21651 AND `guid`=132788;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3681.63, `position_y`=3315.34, `position_z`=312.017, `orientation`=2.3777, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21651 AND `guid`=132789;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3647.5, `position_y`=3383.45, `position_z`=312.345, `orientation`=4.2237, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21651 AND `guid`=132790;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3711.1, `position_y`=3809.29, `position_z`=302.272, `orientation`=6.1086, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21651 AND `guid`=132791;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3889.44, `position_y`=3788.59, `position_z`=334.885, `orientation`=5.2534, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21651 AND `guid`=132792;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3629.47, `position_y`=3753.76, `position_z`=302.228, `orientation`=5.6464, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21651 AND `guid`=132793;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3642.93, `position_y`=3771.03, `position_z`=302.04, `orientation`=3.6489, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21651 AND `guid`=132794;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3725.2, `position_y`=3785.74, `position_z`=302.199, `orientation`=2.234, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21651 AND `guid`=132795;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3899.07, `position_y`=3679.88, `position_z`=335.833, `orientation`=5.6654, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21651 AND `guid`=132796;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3862.81, `position_y`=3671.75, `position_z`=335.951, `orientation`=2.4784, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21651 AND `guid`=132797;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3883.7, `position_y`=3654.49, `position_z`=336.01, `orientation`=1.4137, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21651 AND `guid`=132798;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3882.51, `position_y`=3753.75, `position_z`=334.89, `orientation`=1.1759, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21651 AND `guid`=132799;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4050.19, `position_y`=3297.91, `position_z`=332.937, `orientation`=1.8402, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21651 AND `guid`=132800;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4059.92, `position_y`=3269.66, `position_z`=332.927, `orientation`=2.5831, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21651 AND `guid`=132801;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3946.89, `position_y`=3222, `position_z`=334.047, `orientation`=0.0349, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21651 AND `guid`=132802;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3976.86, `position_y`=3218.68, `position_z`=333.897, `orientation`=2.4671, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21651 AND `guid`=132803;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3885.38, `position_y`=3110.65, `position_z`=362.677, `orientation`=0.9461, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21651 AND `guid`=132804;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3999.54, `position_y`=3152.35, `position_z`=362.617, `orientation`=2.6455, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21651 AND `guid`=132805;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3893.43, `position_y`=3075.96, `position_z`=362.592, `orientation`=3.0892, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=53622, `CreateObject`=2 WHERE `id`=21651 AND `guid`=132806;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4002.44, `position_y`=3127.34, `position_z`=363.567, `orientation`=3.7699, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21651 AND `guid`=132807;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3907.58, `position_y`=3112.35, `position_z`=328.537, `orientation`=6.0116, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21651 AND `guid`=132808;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3894.04, `position_y`=3086.47, `position_z`=374.747, `orientation`=5.5327, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21651 AND `guid`=132809;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3920.75, `position_y`=3017.94, `position_z`=356.836, `orientation`=2.2167, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21651 AND `guid`=132810;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3852.98, `position_y`=3322.64, `position_z`=324.138, `orientation`=0.8378, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=53622, `CreateObject`=2 WHERE `id`=21651 AND `guid`=132811;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3818.04, `position_y`=3330.86, `position_z`=324.138, `orientation`=2.7925, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21651 AND `guid`=132812;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3685.78, `position_y`=3733.7, `position_z`=279.515, `orientation`=2.1701, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21651 AND `guid`=132813;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3996.29, `position_y`=2984.32, `position_z`=367.039, `orientation`=4.8092, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=57564, `CreateObject`=2 WHERE `id`=21763 AND `guid`=132539;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3975.11, `position_y`=3032.89, `position_z`=356.752, `orientation`=5.2536, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21763 AND `guid`=132540;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4119.47, `position_y`=3108.57, `position_z`=318.43, `orientation`=1.7702, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=55141, `CreateObject`=2 WHERE `id`=21763 AND `guid`=132541;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4137.56, `position_y`=3024.82, `position_z`=314.437, `orientation`=4.1441, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=53622, `CreateObject`=2 WHERE `id`=21763 AND `guid`=132542;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4094.43, `position_y`=3222.03, `position_z`=297.902, `orientation`=5.9312, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21763 AND `guid`=132543;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4177.553, `position_y`=3196.212, `position_z`=314.0851, `orientation`=2.208, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=55141, `CreateObject`=2 WHERE `id`=21763 AND `guid`=132544;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3746.1, `position_y`=3304.42, `position_z`=295.558, `orientation`=5.478, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21763 AND `guid`=132545;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3680.6814, `position_y`=3378.9436, `position_z`=282.7346, `orientation`=0.329, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21763 AND `guid`=132546;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4071.17, `position_y`=3399.93, `position_z`=294.319, `orientation`=5.7072, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21763 AND `guid`=132547;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4028.94, `position_y`=3049.97, `position_z`=341.779, `orientation`=4.6251, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21763 AND `guid`=132548;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3901.3, `position_y`=3036, `position_z`=357.732, `orientation`=0.3596, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21763 AND `guid`=132549;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3858.2, `position_y`=3322.09, `position_z`=274.691, `orientation`=0.7051, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21763 AND `guid`=132550;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3700.15, `position_y`=3774.08, `position_z`=270.23, `orientation`=2.3874, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21763 AND `guid`=132551;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3849.33, `position_y`=3785.17, `position_z`=284.396, `orientation`=1.5708, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21763 AND `guid`=132552;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3870.89, `position_y`=3487.53, `position_z`=275.855, `orientation`=2.3283, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21787 AND `guid`=132572;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4152.78, `position_y`=3042.52, `position_z`=315.855, `orientation`=0.9699, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=55262, `CreateObject`=2 WHERE `id`=21787 AND `guid`=132574;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4073.83, `position_y`=3189.6, `position_z`=296.624, `orientation`=1.6709, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21787 AND `guid`=132575;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4096.88, `position_y`=3018.4, `position_z`=344.202, `orientation`=4.2935, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=55262, `CreateObject`=2 WHERE `id`=21787 AND `guid`=132576;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4185.09, `position_y`=3056.96, `position_z`=344.23, `orientation`=5.2699, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=55141, `CreateObject`=2 WHERE `id`=21787 AND `guid`=132577;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4172.24, `position_y`=3180.69, `position_z`=315.881, `orientation`=4.4331, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=55141, `CreateObject`=2 WHERE `id`=21787 AND `guid`=132578;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4121.05, `position_y`=3013.41, `position_z`=344.24, `orientation`=3.0475, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=55141, `CreateObject`=2 WHERE `id`=21787 AND `guid`=132579;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3690.04, `position_y`=3322.21, `position_z`=284.17, `orientation`=1.0947, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21787 AND `guid`=132580;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3702.42, `position_y`=3308.64, `position_z`=312.313, `orientation`=3.1416, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21787 AND `guid`=132581;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3668.63, `position_y`=3395.73, `position_z`=312.211, `orientation`=4.5379, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21787 AND `guid`=132582;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3649.2, `position_y`=3379.72, `position_z`=312.337, `orientation`=1.0297, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21787 AND `guid`=132583;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3668.87, `position_y`=3371.78, `position_z`=313.102, `orientation`=4.6852, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21787 AND `guid`=132584;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3687.17, `position_y`=3287.76, `position_z`=312.312, `orientation`=2.6005, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21787 AND `guid`=132585;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3707.91, `position_y`=3807.72, `position_z`=302.27, `orientation`=2.5831, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21787 AND `guid`=132586;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3886.83, `position_y`=3783.83, `position_z`=334.878, `orientation`=2.0595, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21787 AND `guid`=132587;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3651.44, `position_y`=3750.56, `position_z`=302.141, `orientation`=0.0524, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21787 AND `guid`=132588;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3868.04, `position_y`=3675.77, `position_z`=335.904, `orientation`=5.62, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21787 AND `guid`=132589;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3856.26, `position_y`=3785.09, `position_z`=334.891, `orientation`=0.6803, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21787 AND `guid`=132590;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3705.29, `position_y`=3787.83, `position_z`=303.032, `orientation`=4.6354, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21787 AND `guid`=132591;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3882.7278, `position_y`=3661.1675, `position_z`=335.9971, `orientation`=4.6251, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=1 WHERE `id`=21787 AND `guid`=132592;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3727.48, `position_y`=3789.05, `position_z`=302.126, `orientation`=5.3407, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21787 AND `guid`=132593;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3940.65, `position_y`=3222.22, `position_z`=334.057, `orientation`=3.1416, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21787 AND `guid`=132594;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3962.09, `position_y`=3243.77, `position_z`=333.589, `orientation`=1.3477, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21787 AND `guid`=132595;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4038.8, `position_y`=3258.21, `position_z`=332.936, `orientation`=3.114, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21787 AND `guid`=132596;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3981.15, `position_y`=3134.27, `position_z`=363.592, `orientation`=1.3216, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21787 AND `guid`=132597;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4065.68, `position_y`=3273.31, `position_z`=332.931, `orientation`=5.7072, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21787 AND `guid`=132598;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4008.98, `position_y`=3126.44, `position_z`=362.605, `orientation`=0.6283, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21787 AND `guid`=132599;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3912.38, `position_y`=3095.58, `position_z`=374.801, `orientation`=4.0492, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21787 AND `guid`=132600;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3888.01, `position_y`=3080.66, `position_z`=373.795, `orientation`=2.3562, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21787 AND `guid`=132601;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3895.8, `position_y`=3109.75, `position_z`=374.735, `orientation`=1.9931, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21787 AND `guid`=132602;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3904.77, `position_y`=3116.96, `position_z`=329.021, `orientation`=5.3744, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21787 AND `guid`=132603;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3927.41, `position_y`=3024.03, `position_z`=356.908, `orientation`=0.3215, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21787 AND `guid`=132604;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3823.37, `position_y`=3332.76, `position_z`=324.128, `orientation`=5.969, `wander_distance`=0, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21787 AND `guid`=132605;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3860.19, `position_y`=3299.72, `position_z`=275.409, `orientation`=5.1636, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21787 AND `guid`=132606;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3831.21, `position_y`=3354.01, `position_z`=324.133, `orientation`=6.161, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21787 AND `guid`=132607;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3689.88, `position_y`=3737.84, `position_z`=278.899, `orientation`=1.905, `wander_distance`=2, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21787 AND `guid`=132608;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3658.74, `position_y`=3716.84, `position_z`=282.626, `orientation`=1.2402, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=55141, `CreateObject`=2 WHERE `id`=21911 AND `guid`=76656;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3673.81, `position_y`=3751.91, `position_z`=277.84, `orientation`=0.0575, `wander_distance`=5, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21911 AND `guid`=76657;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3724.74, `position_y`=3772.46, `position_z`=271.228, `orientation`=5.9752, `wander_distance`=10, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21911 AND `guid`=76658;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4120.7, `position_y`=3031.75, `position_z`=314.09, `orientation`=2.4188, `wander_distance`=5, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21911 AND `guid`=76659;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4179.71, `position_y`=3087.22, `position_z`=325.272, `orientation`=1.5064, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=55141, `CreateObject`=2 WHERE `id`=21911 AND `guid`=76660;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4118.42, `position_y`=3034.38, `position_z`=344.21, `orientation`=3.9121, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21911 AND `guid`=76661;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4141.05, `position_y`=3084.63, `position_z`=315.736, `orientation`=4.8872, `wander_distance`=10, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21911 AND `guid`=76662;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4166.66, `position_y`=3020.29, `position_z`=315.567, `orientation`=2.8623, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21911 AND `guid`=76663;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4129.26, `position_y`=3026.73, `position_z`=343.992, `orientation`=5.6477, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=55141, `CreateObject`=2 WHERE `id`=21911 AND `guid`=76664;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3876, `position_y`=3108.36, `position_z`=331.782, `orientation`=1.5361, `wander_distance`=5, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21911 AND `guid`=76665;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3911.55, `position_y`=3109.35, `position_z`=373.686, `orientation`=3.717, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=55141, `CreateObject`=2 WHERE `id`=21911 AND `guid`=76666;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3898.88, `position_y`=3150.28, `position_z`=325.349, `orientation`=2.2688, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21911 AND `guid`=76667;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3979.96, `position_y`=3240.45, `position_z`=332.812, `orientation`=5.6912, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21911 AND `guid`=76668;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4000.14, `position_y`=3272, `position_z`=284.18, `orientation`=1.52, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=53622, `CreateObject`=2 WHERE `id`=21911 AND `guid`=76669;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4011.03, `position_y`=3305.47, `position_z`=283.896, `orientation`=4.311, `wander_distance`=5, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21911 AND `guid`=76670;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3857.84, `position_y`=3324.47, `position_z`=324.143, `orientation`=0.2802, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21911 AND `guid`=76671;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3896.73, `position_y`=3299.82, `position_z`=287.386, `orientation`=0.6371, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21911 AND `guid`=76672;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3852.71, `position_y`=3286.2, `position_z`=275.285, `orientation`=0.4024, `wander_distance`=5, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21911 AND `guid`=76673;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3708.826, `position_y`=3318.9648, `position_z`=289.8624, `orientation`=4.2154, `wander_distance`=5, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21911 AND `guid`=76674;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3681.8394, `position_y`=3341.2036, `position_z`=285.4997, `orientation`=0.3111, `wander_distance`=5, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21911 AND `guid`=76675;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3704.948, `position_y`=3339.5085, `position_z`=286.5748, `orientation`=4.119, `wander_distance`=5, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21911 AND `guid`=76676;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3876.89, `position_y`=3690.93, `position_z`=335.228, `orientation`=6.2502, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21911 AND `guid`=132839;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3967.03, `position_y`=3204.66, `position_z`=334.124, `orientation`=4.2682, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=55141, `CreateObject`=2 WHERE `id`=21911 AND `guid`=132840;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3848.12, `position_y`=3418.07, `position_z`=324.521, `orientation`=0.4073, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21911 AND `guid`=132841;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4166.77, `position_y`=3162.57, `position_z`=316.658, `orientation`=6.0343, `wander_distance`=5, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `id`=21911 AND `guid`=132842;

-- Skettis Windwalkers left standing above: wander, and two walk to a Kneel Target to channel
UPDATE `creature` SET `spawntimesecs`=300, `wander_distance`=3, `MovementType`=1 WHERE `id`=21649 AND `guid`=75563;
UPDATE `creature` SET `spawntimesecs`=300, `wander_distance`=2, `MovementType`=1 WHERE `id`=21649 AND `guid`=75574;
UPDATE `creature` SET `spawntimesecs`=300, `wander_distance`=3, `MovementType`=1 WHERE `id`=21649 AND `guid`=132780;

-- Missing spawns
DELETE FROM `creature` WHERE `id`=21911 AND `guid` IN (75492, 75493, 75494, 75495, 75496, 75497, 75499, 75500, 75501, 75502, 75503, 75504, 75505, 75506);
DELETE FROM `creature` WHERE `id`=21651 AND `guid` IN (75508, 75509, 75512, 75514, 75515);
DELETE FROM `creature` WHERE `id`=21787 AND `guid` IN (75516, 75517, 75518, 75519, 75520);
DELETE FROM `creature` WHERE `id`=21763 AND `guid` IN (75521, 75522, 75523, 75524);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(75492, 21911, 530, 0, 0, 1, 1, 1, -3978.95, 3230.24, 333.329, 3.2572, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 52237, 2, NULL), -- Skettis Soulcaller
(75493, 21911, 530, 0, 0, 1, 1, 1, -3933.67, 3146.5, 326.217, 5.2919, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 52237, 2, NULL), -- Skettis Soulcaller
(75494, 21911, 530, 0, 0, 1, 1, 1, -3921.22, 3102.81, 373.619, 2.7682, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 53622, 2, NULL), -- Skettis Soulcaller
(75495, 21911, 530, 0, 0, 1, 1, 1, -3917.57, 3103.06, 362.376, 1.2669, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 55141, 2, NULL), -- Skettis Soulcaller
(75496, 21911, 530, 0, 0, 1, 1, 2, -3892.49, 3332.78, 275.45, 1.7104, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 52237, 2, NULL), -- Skettis Soulcaller
(75497, 21911, 530, 0, 0, 1, 1, 1, -3879.7, 3698.13, 334.763, 1.4781, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 52237, 2, NULL), -- Skettis Soulcaller
(75499, 21911, 530, 0, 0, 1, 1, 1, -3859.15, 3527.61, 278.447, 2.8623, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 52237, 2, NULL), -- Skettis Soulcaller
(75500, 21911, 530, 0, 0, 1, 1, 1, -3846.55, 3749.79, 281.67, 2.8546, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 52237, 2, NULL), -- Skettis Soulcaller
(75501, 21911, 530, 0, 0, 1, 1, 1, -3815.26, 3727.33, 282.229, 0.2456, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 52237, 2, NULL), -- Skettis Soulcaller
(75502, 21911, 530, 0, 0, 1, 1, 1, -3786.22, 3766.61, 277.464, 0.8203, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 52237, 2, NULL), -- Skettis Soulcaller
(75503, 21911, 530, 0, 0, 1, 1, 1, -3708.16, 3745.77, 277.109, 3.8746, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 52237, 2, NULL), -- Skettis Soulcaller
(75504, 21911, 530, 0, 0, 1, 1, 1, -3705.52, 3782.21, 302.252, 0.983, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 52237, 2, NULL), -- Skettis Soulcaller
(75505, 21911, 530, 0, 0, 1, 1, 1, -3696.97, 3787.36, 302.157, 5.9022, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 55141, 2, NULL), -- Skettis Soulcaller
(75506, 21911, 530, 0, 0, 1, 1, 1, -3960.3586, 3279.2422, 290.4366, 1.1546, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 52237, 2, NULL), -- Skettis Soulcaller
(75508, 21651, 530, 0, 0, 1, 1, 1, -3998.12, 3293.52, 284.247, 5.9489, 300, 2, 0, 1, 0, 1, 0, 0, 0, '', 52237, 2, NULL), -- Time-Lost Skettis Reaver
(75509, 21651, 530, 0, 0, 1, 1, 1, -3868.96, 3425.71, 324.907, 2.3911, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 52237, 2, NULL), -- Time-Lost Skettis Reaver
(75512, 21651, 530, 0, 0, 1, 1, 1, -3858.87, 3448.51, 325.247, 0.7679, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 52237, 2, NULL), -- Time-Lost Skettis Reaver
(75514, 21651, 530, 0, 0, 1, 1, 1, -3839.25, 3429.05, 325.135, 3.308, 300, 2, 0, 1, 0, 1, 0, 0, 0, '', 52237, 2, NULL), -- Time-Lost Skettis Reaver
(75515, 21651, 530, 0, 0, 1, 1, 1, -3863.5286, 3435.638, 363.5901, 5.7181, 300, 2, 0, 1, 0, 1, 0, 0, 0, '', 52237, 1, NULL), -- Time-Lost Skettis Reaver
(75516, 21787, 530, 0, 0, 1, 1, 1, -4002.64, 3288.83, 284.363, 0.2443, 300, 2, 0, 1, 0, 1, 0, 0, 0, '', 53622, 2, NULL), -- Time-Lost Skettis High Priest
(75517, 21787, 530, 0, 0, 1, 1, 1, -3898.61, 3075.97, 362.578, 6.2483, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 52237, 2, NULL), -- Time-Lost Skettis High Priest
(75518, 21787, 530, 0, 0, 1, 1, 1, -3873.43, 3429.23, 325.033, 5.62, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 52237, 2, NULL), -- Time-Lost Skettis High Priest
(75519, 21787, 530, 0, 0, 1, 1, 1, -3854.17, 3452.98, 325.253, 3.8921, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 52237, 2, NULL), -- Time-Lost Skettis High Priest
(75520, 21787, 530, 0, 0, 1, 1, 1, -3898.1233, 3474.968, 274.2646, 1.7887, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 55141, 2, NULL), -- Time-Lost Skettis High Priest
(75521, 21763, 530, 0, 0, 1, 1, 1, -3957.93, 3307.35, 287.057, 3.365, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 52237, 2, NULL), -- Time-Lost Skettis Worshipper
(75522, 21763, 530, 0, 0, 1, 1, 1, -3890.99, 3472.83, 274.006, 2.974, 300, 2, 0, 1, 0, 1, 0, 0, 0, '', 53622, 2, NULL), -- Time-Lost Skettis Worshipper
(75523, 21763, 530, 0, 0, 1, 1, 1, -3868.35, 3521.88, 278.561, 3.4924, 300, 2, 0, 1, 0, 1, 0, 0, 0, '', 52237, 2, NULL), -- Time-Lost Skettis Worshipper
(75524, 21763, 530, 0, 0, 1, 1, 1, -3851.71, 3537.58, 278.888, 3.1047, 300, 2, 0, 1, 0, 1, 0, 0, 0, '', 52237, 2, NULL); -- Time-Lost Skettis Worshipper

-- Route walkers (a guid addon replaces the template one, so it repeats its auras)
DELETE FROM `creature_addon` WHERE `guid` IN (75492, 75494, 75495, 75496, 75497, 75499, 75502, 75503, 75504, 75505, 75520, 75521, 76656, 76660, 76661, 76663, 76664, 76666, 76667, 76668, 76669, 76671, 76672, 132539, 132540, 132541, 132542, 132543, 132544, 132545, 132546, 132547, 132548, 132549, 132550, 132551, 132552, 132839, 132840, 132841);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(75492, 754920, 0, 0, 1, 0, 0, ''),
(75494, 754940, 0, 0, 1, 0, 0, ''),
(75495, 754950, 0, 0, 1, 0, 0, ''),
(75496, 754960, 0, 0, 1, 0, 0, ''),
(75497, 754970, 0, 0, 1, 0, 0, ''),
(75499, 754990, 0, 0, 1, 0, 0, ''),
(75502, 755020, 0, 0, 1, 0, 0, ''),
(75503, 755030, 0, 0, 1, 0, 0, ''),
(75504, 755040, 0, 0, 1, 0, 0, ''),
(75505, 755050, 0, 0, 1, 0, 0, ''),
(75520, 755200, 0, 65536, 1, 0, 0, '33900 37411 37509'),
(75521, 755210, 0, 65536, 1, 0, 0, '33900 37411 37509 37816'),
(76656, 766560, 0, 0, 1, 0, 0, ''),
(76660, 766600, 0, 0, 1, 0, 0, ''),
(76661, 766610, 0, 0, 1, 0, 0, ''),
(76663, 766630, 0, 0, 1, 0, 0, ''),
(76664, 766640, 0, 0, 1, 0, 0, ''),
(76666, 766660, 0, 0, 1, 0, 0, ''),
(76667, 766670, 0, 0, 1, 0, 0, ''),
(76668, 766680, 0, 0, 1, 0, 0, ''),
(76669, 766690, 0, 0, 1, 0, 0, ''),
(76671, 766710, 0, 0, 1, 0, 0, ''),
(76672, 766720, 0, 0, 1, 0, 0, ''),
(132539, 1325390, 0, 65536, 1, 0, 0, '33900 37411 37509 37816'),
(132540, 1325400, 0, 65536, 1, 0, 0, '33900 37411 37509 37816'),
(132541, 1325410, 0, 65536, 1, 0, 0, '33900 37411 37509 37816'),
(132542, 1325420, 0, 65536, 1, 0, 0, '33900 37411 37509 37816'),
(132543, 1325430, 0, 65536, 1, 0, 0, '33900 37411 37509 37816'),
(132544, 1325440, 0, 65536, 1, 0, 0, '33900 37411 37509 37816'),
(132545, 1325450, 0, 65536, 1, 0, 0, '33900 37411 37509 37816'),
(132546, 1325460, 0, 65536, 1, 0, 0, '33900 37411 37509 37816'),
(132547, 1325470, 0, 65536, 1, 0, 0, '33900 37411 37509 37816'),
(132548, 1325480, 0, 65536, 1, 0, 0, '33900 37411 37509 37816'),
(132549, 1325490, 0, 65536, 1, 0, 0, '33900 37411 37509 37816'),
(132550, 1325500, 0, 65536, 1, 0, 0, '33900 37411 37509 37816'),
(132551, 1325510, 0, 65536, 1, 0, 0, '33900 37411 37509 37816'),
(132552, 1325520, 0, 65536, 1, 0, 0, '33900 37411 37509 37816'),
(132839, 1328390, 0, 0, 1, 0, 0, ''),
(132840, 1328400, 0, 0, 1, 0, 0, ''),
(132841, 1328410, 0, 0, 1, 0, 0, '');

-- Routes
DELETE FROM `waypoint_data` WHERE `id` IN (754920, 754940, 754950, 754960, 754970, 754990, 755020, 755030, 755040, 755050, 755200, 755210, 766560, 766600, 766610, 766630, 766640, 766660, 766670, 766680, 766690, 766710, 766720, 1325390, 1325400, 1325410, 1325420, 1325430, 1325440, 1325450, 1325460, 1325470, 1325480, 1325490, 1325500, 1325510, 1325520, 1328390, 1328400, 1328410);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`, `smoothTransition`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(754920, 1, -3979.675, 3230.1602, 333.1696, NULL, 0, 1300, 0, 0, 0, 100, 0),
(754920, 2, -3972.5642, 3215.3735, 333.8397, NULL, 0, 0, 0, 0, 0, 100, 0),
(754920, 3, -3956.398, 3211.5452, 333.9555, NULL, 0, 0, 0, 0, 0, 100, 0),
(754920, 4, -3943.3052, 3220.0417, 333.9646, NULL, 0, 0, 0, 0, 0, 100, 0),
(754920, 5, -3945.2092, 3233.3677, 333.9548, NULL, 0, 0, 0, 0, 0, 100, 0),
(754920, 6, -3950.404, 3242.912, 333.9514, NULL, 0, 0, 0, 0, 0, 100, 0),
(754920, 7, -3967.1846, 3241.0876, 333.4553, NULL, 0, 1200, 0, 0, 0, 100, 0),
(754920, 8, -3950.404, 3242.912, 333.9514, NULL, 0, 0, 0, 0, 0, 100, 0),
(754920, 9, -3945.2092, 3233.3677, 333.9548, NULL, 0, 0, 0, 0, 0, 100, 0),
(754920, 10, -3943.3052, 3220.0417, 333.9646, NULL, 0, 0, 0, 0, 0, 100, 0),
(754920, 11, -3956.398, 3211.5452, 333.9555, NULL, 0, 0, 0, 0, 0, 100, 0),
(754920, 12, -3972.5642, 3215.3735, 333.8397, NULL, 0, 0, 0, 0, 0, 100, 0),
(754940, 1, -3921.2488, 3103.0203, 373.5206, NULL, 0, 800, 0, 0, 0, 100, 0),
(754940, 2, -3946.1594, 3112.5728, 360.8225, NULL, 0, 0, 0, 0, 0, 100, 0),
(754940, 3, -3977.6104, 3124.79, 361.5005, NULL, 0, 0, 0, 0, 0, 100, 0),
(754940, 4, -3976.4832, 3139.8503, 362.0873, NULL, 0, 0, 0, 0, 0, 100, 0),
(754940, 5, -3985.8503, 3153.4163, 362.5413, NULL, 0, 500, 0, 0, 0, 100, 0),
(754940, 6, -3976.4832, 3139.8503, 362.0873, NULL, 0, 0, 0, 0, 0, 100, 0),
(754940, 7, -3977.6104, 3124.79, 361.5005, NULL, 0, 0, 0, 0, 0, 100, 0),
(754940, 8, -3946.1594, 3112.5728, 360.8225, NULL, 0, 0, 0, 0, 0, 100, 0),
(754950, 1, -3917.0725, 3104.655, 362.3135, NULL, 0, 0, 0, 0, 0, 100, 0),
(754950, 2, -3920.866, 3091.8174, 362.4522, NULL, 0, 0, 0, 0, 0, 100, 0),
(754950, 3, -3911.4888, 3077.632, 362.4228, NULL, 0, 0, 0, 0, 0, 100, 0),
(754950, 4, -3897.3923, 3073.7356, 362.4474, NULL, 0, 0, 0, 0, 0, 100, 0),
(754950, 5, -3889.3616, 3083.736, 362.6131, NULL, 0, 0, 0, 0, 0, 100, 0),
(754950, 6, -3878.6233, 3097.0227, 362.2149, NULL, 0, 0, 0, 0, 0, 100, 0),
(754950, 7, -3880.6384, 3110.4788, 362.4264, NULL, 0, 0, 0, 0, 0, 100, 0),
(754950, 8, -3895.4275, 3115.9922, 362.4439, NULL, 0, 0, 0, 0, 0, 100, 0),
(754950, 9, -3880.6384, 3110.4788, 362.4264, NULL, 0, 0, 0, 0, 0, 100, 0),
(754950, 10, -3878.6233, 3097.0227, 362.2149, NULL, 0, 0, 0, 0, 0, 100, 0),
(754950, 11, -3889.3616, 3083.736, 362.6131, NULL, 0, 0, 0, 0, 0, 100, 0),
(754950, 12, -3897.3923, 3073.7356, 362.4474, NULL, 0, 0, 0, 0, 0, 100, 0),
(754950, 13, -3911.4888, 3077.632, 362.4228, NULL, 0, 0, 0, 0, 0, 100, 0),
(754950, 14, -3920.866, 3091.8174, 362.4522, NULL, 0, 0, 0, 0, 0, 100, 0),
(754960, 1, -3892.504, 3332.7725, 275.2459, 1.7104, 0, 25500, 0, 0, 0, 100, 0),
(754960, 2, -3861.0037, 3304.964, 274.2073, 4.9607, 0, 13500, 0, 0, 0, 100, 0),
(754970, 1, -3879.636, 3698.129, 334.6788, NULL, 0, 500, 0, 0, 0, 100, 0),
(754970, 2, -3877.5898, 3720.8643, 328.1123, NULL, 0, 0, 0, 0, 0, 100, 0),
(754970, 3, -3875.2283, 3747.4084, 334.7927, NULL, 0, 0, 0, 0, 0, 100, 0),
(754970, 4, -3877.839, 3757.5051, 334.7869, NULL, 0, 0, 0, 0, 0, 100, 0),
(754970, 5, -3891.9436, 3763.0017, 334.7969, NULL, 0, 0, 0, 0, 0, 100, 0),
(754970, 6, -3896.1416, 3776.6243, 334.798, NULL, 0, 0, 0, 0, 0, 100, 0),
(754970, 7, -3882.0981, 3792.001, 334.7945, NULL, 0, 0, 0, 0, 0, 100, 0),
(754970, 8, -3865.477, 3791.346, 334.7944, NULL, 0, 0, 0, 0, 0, 100, 0),
(754970, 9, -3852.9348, 3777.069, 334.8033, NULL, 0, 900, 0, 0, 0, 100, 0),
(754970, 10, -3865.477, 3791.346, 334.7944, NULL, 0, 0, 0, 0, 0, 100, 0),
(754970, 11, -3882.0981, 3792.001, 334.7945, NULL, 0, 0, 0, 0, 0, 100, 0),
(754970, 12, -3896.1416, 3776.6243, 334.798, NULL, 0, 0, 0, 0, 0, 100, 0),
(754970, 13, -3891.9436, 3763.0017, 334.7969, NULL, 0, 0, 0, 0, 0, 100, 0),
(754970, 14, -3877.839, 3757.5051, 334.7869, NULL, 0, 0, 0, 0, 0, 100, 0),
(754970, 15, -3875.2283, 3747.4084, 334.7927, NULL, 0, 0, 0, 0, 0, 100, 0),
(754970, 16, -3877.5898, 3720.8643, 328.1123, NULL, 0, 0, 0, 0, 0, 100, 0),
(754990, 1, -3859.5474, 3529.0017, 278.3712, 2.249, 0, 8200, 0, 0, 0, 100, 0),
(754990, 2, -3871.9565, 3484.2576, 275.6827, NULL, 0, 2400, 0, 0, 0, 100, 0),
(754990, 3, -3810.8813, 3518.7517, 286.586, NULL, 0, 3100, 0, 0, 0, 100, 0),
(755020, 1, -3786.217, 3766.6145, 277.3807, 0.8203, 0, 20400, 0, 0, 0, 100, 0),
(755020, 2, -3813.5952, 3771.2048, 275.5306, 5.5251, 0, 13000, 0, 0, 0, 100, 0),
(755030, 1, -3708.1606, 3745.7678, 277.0256, 3.8746, 0, 16200, 0, 0, 0, 100, 0),
(755030, 2, -3685.522, 3739.7942, 278.7046, 4.0977, 0, 12600, 0, 0, 0, 100, 0),
(755040, 1, -3705.2253, 3782.6472, 302.0942, NULL, 0, 1400, 0, 0, 0, 100, 0),
(755040, 2, -3714.6113, 3778.5593, 302.0506, NULL, 0, 0, 0, 0, 0, 100, 0),
(755040, 3, -3724.2444, 3783.6914, 302.0708, NULL, 0, 0, 0, 0, 0, 100, 0),
(755040, 4, -3728.3147, 3794.7415, 302.0524, NULL, 0, 0, 0, 0, 0, 100, 0),
(755040, 5, -3725.4915, 3806.317, 302.1558, NULL, 0, 0, 0, 0, 0, 100, 0),
(755040, 6, -3715.03, 3811.0352, 302.1557, NULL, 0, 0, 0, 0, 0, 100, 0),
(755040, 7, -3704.3499, 3806.5503, 302.1576, NULL, 0, 0, 0, 0, 0, 100, 0),
(755040, 8, -3698.5305, 3794.304, 302.1649, NULL, 0, 1300, 0, 0, 0, 100, 0),
(755040, 9, -3704.3499, 3806.5503, 302.1576, NULL, 0, 0, 0, 0, 0, 100, 0),
(755040, 10, -3715.03, 3811.0352, 302.1557, NULL, 0, 0, 0, 0, 0, 100, 0),
(755040, 11, -3725.4915, 3806.317, 302.1558, NULL, 0, 0, 0, 0, 0, 100, 0),
(755040, 12, -3728.3147, 3794.7415, 302.0524, NULL, 0, 0, 0, 0, 0, 100, 0),
(755040, 13, -3724.2444, 3783.6914, 302.0708, NULL, 0, 0, 0, 0, 0, 100, 0),
(755040, 14, -3714.6113, 3778.5593, 302.0506, NULL, 0, 0, 0, 0, 0, 100, 0),
(755050, 1, -3696.8303, 3787.2747, 302.0487, NULL, 0, 600, 0, 0, 0, 100, 0),
(755050, 2, -3675.4854, 3778.7532, 294.9226, NULL, 0, 0, 0, 0, 0, 100, 0),
(755050, 3, -3655.665, 3770.6611, 301.1831, NULL, 0, 0, 0, 0, 0, 100, 0),
(755050, 4, -3652.7449, 3765.4575, 301.8218, NULL, 0, 0, 0, 0, 0, 100, 0),
(755050, 5, -3655.9314, 3757.4387, 302.0021, NULL, 0, 0, 0, 0, 0, 100, 0),
(755050, 6, -3652.0925, 3748.4956, 302.1305, NULL, 0, 0, 0, 0, 0, 100, 0),
(755050, 7, -3655.9314, 3757.4387, 302.0021, NULL, 0, 0, 0, 0, 0, 100, 0),
(755050, 8, -3652.7449, 3765.4575, 301.8218, NULL, 0, 0, 0, 0, 0, 100, 0),
(755050, 9, -3655.665, 3770.6611, 301.1831, NULL, 0, 0, 0, 0, 0, 100, 0),
(755050, 10, -3675.4854, 3778.7532, 294.9226, NULL, 0, 0, 0, 0, 0, 100, 0),
(755200, 1, -3898.3176, 3475.8457, 274.281, NULL, 0, 1200, 0, 0, 0, 100, 0),
(755200, 2, -3879.4426, 3476.9558, 275.301, NULL, 0, 0, 0, 0, 0, 100, 0),
(755200, 3, -3871.5737, 3501.3276, 275.6153, NULL, 0, 0, 0, 0, 0, 100, 0),
(755200, 4, -3857.968, 3526.888, 278.3676, NULL, 0, 0, 0, 0, 0, 100, 0),
(755200, 5, -3832.9392, 3535.7705, 279.894, NULL, 0, 0, 0, 0, 0, 100, 0),
(755200, 6, -3819.3867, 3534.5393, 280.5679, NULL, 0, 0, 0, 0, 0, 100, 0),
(755200, 7, -3816.3855, 3523.9053, 284.4, NULL, 0, 1200, 0, 0, 0, 100, 0),
(755200, 8, -3819.3867, 3534.5393, 280.5679, NULL, 0, 0, 0, 0, 0, 100, 0),
(755200, 9, -3832.9392, 3535.7705, 279.894, NULL, 0, 0, 0, 0, 0, 100, 0),
(755200, 10, -3857.968, 3526.888, 278.3676, NULL, 0, 0, 0, 0, 0, 100, 0),
(755200, 11, -3871.5737, 3501.3276, 275.6153, NULL, 0, 0, 0, 0, 0, 100, 0),
(755200, 12, -3879.4426, 3476.9558, 275.301, NULL, 0, 0, 0, 0, 0, 100, 0),
(755210, 1, -3960.1086, 3306.8525, 286.9295, NULL, 0, 0, 0, 0, 0, 100, 0),
(755210, 2, -3955.9036, 3285.8503, 289.1464, NULL, 0, 0, 0, 0, 0, 100, 0),
(755210, 3, -3951.8645, 3260.9402, 292.6077, NULL, 0, 0, 0, 0, 0, 100, 0),
(755210, 4, -3961.2527, 3256.1785, 293.3661, NULL, 0, 0, 0, 0, 0, 100, 0),
(755210, 5, -3969.8184, 3270.8545, 289.1246, NULL, 0, 0, 0, 0, 0, 100, 0),
(755210, 6, -3996.9385, 3276.039, 284.2456, NULL, 0, 0, 0, 0, 0, 100, 0),
(755210, 7, -4011.5244, 3291.004, 284.1814, NULL, 0, 0, 0, 0, 0, 100, 0),
(755210, 8, -4004.7751, 3301.5044, 283.8785, NULL, 0, 0, 0, 0, 0, 100, 0),
(755210, 9, -3976.6106, 3308.26, 286.0079, NULL, 0, 0, 0, 0, 0, 100, 0),
(766560, 1, -3658.6975, 3717.0217, 282.6242, NULL, 0, 500, 0, 0, 0, 100, 0),
(766560, 2, -3651.3252, 3738.4424, 300.3384, NULL, 0, 0, 0, 0, 0, 100, 0),
(766560, 3, -3646.5552, 3745.7136, 302.1546, NULL, 0, 0, 0, 0, 0, 100, 0),
(766560, 4, -3633.4158, 3747.3728, 302.1448, NULL, 0, 0, 0, 0, 0, 100, 0),
(766560, 5, -3626.2249, 3756.6099, 302.1474, NULL, 0, 0, 0, 0, 0, 100, 0),
(766560, 6, -3627.999, 3765.2622, 302.1399, NULL, 0, 0, 0, 0, 0, 100, 0),
(766560, 7, -3634.116, 3771.958, 301.9804, NULL, 0, 0, 0, 0, 0, 100, 0),
(766560, 8, -3648.544, 3770.1963, 301.7569, NULL, 0, 500, 0, 0, 0, 100, 0),
(766560, 9, -3634.116, 3771.958, 301.9804, NULL, 0, 0, 0, 0, 0, 100, 0),
(766560, 10, -3627.999, 3765.2622, 302.1399, NULL, 0, 0, 0, 0, 0, 100, 0),
(766560, 11, -3626.2249, 3756.6099, 302.1474, NULL, 0, 0, 0, 0, 0, 100, 0),
(766560, 12, -3633.4158, 3747.3728, 302.1448, NULL, 0, 0, 0, 0, 0, 100, 0),
(766560, 13, -3646.5552, 3745.7136, 302.1546, NULL, 0, 0, 0, 0, 0, 100, 0),
(766560, 14, -3651.3252, 3738.4424, 300.3384, NULL, 0, 0, 0, 0, 0, 100, 0),
(766600, 1, -4179.644, 3088.3142, 324.5648, NULL, 0, 1400, 0, 0, 0, 100, 0),
(766600, 2, -4182.831, 3065.9062, 342.2722, NULL, 0, 0, 0, 0, 0, 100, 0),
(766600, 3, -4185.462, 3058.0088, 344.1413, NULL, 0, 0, 0, 0, 0, 100, 0),
(766600, 4, -4198.1475, 3054.5625, 344.1319, NULL, 0, 0, 0, 0, 0, 100, 0),
(766600, 5, -4203.268, 3043.3118, 344.1339, NULL, 0, 0, 0, 0, 0, 100, 0),
(766600, 6, -4197.607, 3031.4548, 344.1468, NULL, 0, 0, 0, 0, 0, 100, 0),
(766600, 7, -4180.885, 3032.4524, 343.7166, NULL, 0, 1400, 0, 0, 0, 100, 0),
(766600, 8, -4197.607, 3031.4548, 344.1468, NULL, 0, 0, 0, 0, 0, 100, 0),
(766600, 9, -4203.268, 3043.3118, 344.1339, NULL, 0, 0, 0, 0, 0, 100, 0),
(766600, 10, -4198.1475, 3054.5625, 344.1319, NULL, 0, 0, 0, 0, 0, 100, 0),
(766600, 11, -4185.462, 3058.0088, 344.1413, NULL, 0, 0, 0, 0, 0, 100, 0),
(766600, 12, -4182.831, 3065.9062, 342.2722, NULL, 0, 0, 0, 0, 0, 100, 0),
(766610, 1, -4120.7275, 3032.1362, 344.0628, NULL, 0, 500, 0, 0, 0, 100, 0),
(766610, 2, -4115.7905, 3036.8044, 344.0368, NULL, 0, 0, 0, 0, 0, 100, 0),
(766610, 3, -4105.2437, 3036.2212, 344.0897, NULL, 0, 0, 0, 0, 0, 100, 0),
(766610, 4, -4097.892, 3031.1714, 344.0211, NULL, 0, 0, 0, 0, 0, 100, 0),
(766610, 5, -4095.6885, 3020.4426, 343.9413, NULL, 0, 0, 0, 0, 0, 100, 0),
(766610, 6, -4098.6934, 3011.087, 344.1329, NULL, 0, 0, 0, 0, 0, 100, 0),
(766610, 7, -4106.727, 3008.4463, 344.1311, NULL, 0, 0, 0, 0, 0, 100, 0),
(766610, 8, -4117.7734, 3008.964, 344.1373, NULL, 0, 0, 0, 0, 0, 100, 0),
(766610, 9, -4125.1694, 3020.0972, 344.1456, NULL, 0, 0, 0, 0, 0, 100, 0),
(766610, 10, -4117.7734, 3008.964, 344.1373, NULL, 0, 0, 0, 0, 0, 100, 0),
(766610, 11, -4106.727, 3008.4463, 344.1311, NULL, 0, 0, 0, 0, 0, 100, 0),
(766610, 12, -4098.6934, 3011.087, 344.1329, NULL, 0, 0, 0, 0, 0, 100, 0),
(766610, 13, -4095.6885, 3020.4426, 343.9413, NULL, 0, 0, 0, 0, 0, 100, 0),
(766610, 14, -4097.892, 3031.1714, 344.0211, NULL, 0, 0, 0, 0, 0, 100, 0),
(766610, 15, -4105.2437, 3036.2212, 344.0897, NULL, 0, 0, 0, 0, 0, 100, 0),
(766610, 16, -4115.7905, 3036.8044, 344.0368, NULL, 0, 0, 0, 0, 0, 100, 0),
(766630, 1, -4166.664, 3020.2903, 315.4832, 2.8623, 0, 17800, 0, 0, 0, 100, 0),
(766630, 2, -4149.563, 3047.709, 314.897, 4.6675, 0, 12600, 0, 0, 0, 100, 0),
(766640, 1, -4128.608, 3026.253, 344.0488, NULL, 0, 1400, 0, 0, 0, 100, 0),
(766640, 2, -4151.159, 3030.708, 336.9018, NULL, 0, 0, 0, 0, 0, 100, 0),
(766640, 3, -4172.558, 3034.8955, 343.1928, NULL, 0, 0, 0, 0, 0, 100, 0),
(766640, 4, -4175.5327, 3039.4915, 343.7418, NULL, 0, 0, 0, 0, 0, 100, 0),
(766640, 5, -4174.932, 3050.146, 344.0067, NULL, 0, 0, 0, 0, 0, 100, 0),
(766640, 6, -4180.7207, 3057.8203, 344.1301, NULL, 0, 1300, 0, 0, 0, 100, 0),
(766640, 7, -4174.932, 3050.146, 344.0067, NULL, 0, 0, 0, 0, 0, 100, 0),
(766640, 8, -4175.5327, 3039.4915, 343.7418, NULL, 0, 0, 0, 0, 0, 100, 0),
(766640, 9, -4172.558, 3034.8955, 343.1928, NULL, 0, 0, 0, 0, 0, 100, 0),
(766640, 10, -4151.159, 3030.708, 336.9018, NULL, 0, 0, 0, 0, 0, 100, 0),
(766660, 1, -3913.7769, 3107.9124, 373.7085, NULL, 0, 900, 0, 0, 0, 100, 0),
(766660, 2, -3899.5674, 3115.6294, 373.0995, NULL, 0, 0, 0, 0, 0, 100, 0),
(766660, 3, -3888.237, 3111.188, 372.9488, NULL, 0, 0, 0, 0, 0, 100, 0),
(766660, 4, -3882.6145, 3096.3357, 373.4665, NULL, 0, 0, 0, 0, 0, 100, 0),
(766660, 5, -3886.255, 3082.3755, 373.7457, NULL, 0, 0, 0, 0, 0, 100, 0),
(766660, 6, -3896.8472, 3077.6775, 373.7125, NULL, 0, 0, 0, 0, 0, 100, 0),
(766660, 7, -3910.4446, 3081.3984, 373.7133, NULL, 0, 0, 0, 0, 0, 100, 0),
(766660, 8, -3915.569, 3094.6538, 373.7094, NULL, 0, 900, 0, 0, 0, 100, 0),
(766660, 9, -3910.4446, 3081.3984, 373.7133, NULL, 0, 0, 0, 0, 0, 100, 0),
(766660, 10, -3896.8472, 3077.6775, 373.7125, NULL, 0, 0, 0, 0, 0, 100, 0),
(766660, 11, -3886.255, 3082.3755, 373.7457, NULL, 0, 0, 0, 0, 0, 100, 0),
(766660, 12, -3882.6145, 3096.3357, 373.4665, NULL, 0, 0, 0, 0, 0, 100, 0),
(766660, 13, -3888.237, 3111.188, 372.9488, NULL, 0, 0, 0, 0, 0, 100, 0),
(766660, 14, -3899.5674, 3115.6294, 373.0995, NULL, 0, 0, 0, 0, 0, 100, 0),
(766670, 1, -3898.8777, 3150.2817, 325.2655, NULL, 0, 2000, 0, 0, 0, 100, 0),
(766670, 2, -3901.5078, 3154.44, 324.2157, NULL, 0, 0, 0, 0, 0, 100, 0),
(766670, 3, -3904.742, 3119.956, 328.5284, 4.6299, 0, 13000, 0, 0, 0, 100, 0),
(766680, 1, -3979.7344, 3240.2856, 332.7147, NULL, 0, 0, 0, 0, 0, 100, 0),
(766680, 2, -3998.7415, 3251.665, 326.2155, NULL, 0, 0, 0, 0, 0, 100, 0),
(766680, 3, -4022.9385, 3265.63, 332.8559, NULL, 0, 0, 0, 0, 0, 100, 0),
(766680, 4, -4032.4563, 3265.425, 332.8462, NULL, 0, 0, 0, 0, 0, 100, 0),
(766680, 5, -4042.0916, 3258.3933, 332.8478, NULL, 0, 0, 0, 0, 0, 100, 0),
(766680, 6, -4054.2908, 3258.9631, 332.8474, NULL, 0, 0, 0, 0, 0, 100, 0),
(766680, 7, -4065.5442, 3273.3625, 332.8449, NULL, 0, 0, 0, 0, 0, 100, 0),
(766680, 8, -4061.1143, 3290.4307, 332.8522, NULL, 0, 0, 0, 0, 0, 100, 0),
(766680, 9, -4048.0066, 3298.704, 332.8534, NULL, 0, 1200, 0, 0, 0, 100, 0),
(766680, 10, -4061.1143, 3290.4307, 332.8522, NULL, 0, 0, 0, 0, 0, 100, 0),
(766680, 11, -4065.5442, 3273.3625, 332.8449, NULL, 0, 0, 0, 0, 0, 100, 0),
(766680, 12, -4054.2908, 3258.9631, 332.8474, NULL, 0, 0, 0, 0, 0, 100, 0),
(766680, 13, -4042.0916, 3258.3933, 332.8478, NULL, 0, 0, 0, 0, 0, 100, 0),
(766680, 14, -4032.4563, 3265.425, 332.8462, NULL, 0, 0, 0, 0, 0, 100, 0),
(766680, 15, -4022.9385, 3265.63, 332.8559, NULL, 0, 0, 0, 0, 0, 100, 0),
(766680, 16, -3998.7415, 3251.665, 326.2155, NULL, 0, 0, 0, 0, 0, 100, 0),
(766690, 1, -4000.1401, 3271.9973, 284.0971, 4.1015, 0, 24200, 0, 0, 0, 100, 0),
(766690, 2, -3999.4663, 3285.2563, 284.182, 1.6001, 0, 13700, 0, 0, 0, 100, 0),
(766710, 1, -3857.0317, 3324.702, 324.0519, NULL, 0, 1000, 0, 0, 0, 100, 0),
(766710, 2, -3837.2812, 3317.9302, 324.0434, NULL, 0, 0, 0, 0, 0, 100, 0),
(766710, 3, -3821.9385, 3327.5425, 324.0389, NULL, 0, 0, 0, 0, 0, 100, 0),
(766710, 4, -3817.5308, 3343.313, 324.0486, NULL, 0, 0, 0, 0, 0, 100, 0),
(766710, 5, -3842.6345, 3357.8826, 324.0461, NULL, 0, 0, 0, 0, 0, 100, 0),
(766710, 6, -3844.6138, 3362.3254, 324.0543, NULL, 0, 0, 0, 0, 0, 100, 0),
(766710, 7, -3849.1519, 3392.4536, 317.4971, NULL, 0, 0, 0, 0, 0, 100, 0),
(766710, 8, -3852.7683, 3413.0305, 324.0158, NULL, 0, 800, 0, 0, 0, 100, 0),
(766710, 9, -3849.1519, 3392.4536, 317.4971, NULL, 0, 0, 0, 0, 0, 100, 0),
(766710, 10, -3844.6138, 3362.3254, 324.0543, NULL, 0, 0, 0, 0, 0, 100, 0),
(766710, 11, -3842.6345, 3357.8826, 324.0461, NULL, 0, 0, 0, 0, 0, 100, 0),
(766710, 12, -3817.5308, 3343.313, 324.0486, NULL, 0, 0, 0, 0, 0, 100, 0),
(766710, 13, -3821.9385, 3327.5425, 324.0389, NULL, 0, 0, 0, 0, 0, 100, 0),
(766710, 14, -3837.2812, 3317.9302, 324.0434, NULL, 0, 0, 0, 0, 0, 100, 0),
(766720, 1, -3896.7336, 3299.8215, 287.3037, NULL, 0, 2000, 0, 0, 0, 100, 0),
(766720, 2, -3907.4167, 3322.7825, 285.5895, NULL, 0, 1000, 0, 0, 0, 100, 0),
(766720, 3, -3895.9436, 3300.4062, 286.841, NULL, 0, 1000, 0, 0, 0, 100, 0),
(766720, 4, -3907.4167, 3322.7825, 285.5895, NULL, 0, 0, 0, 0, 0, 100, 0),
(766720, 5, -3865.4016, 3300.3113, 274.4873, 0.0405, 0, 13400, 0, 0, 0, 100, 0),
(1325390, 1, -3996.0503, 2981.9167, 366.3596, NULL, 0, 800, 0, 0, 0, 100, 0),
(1325390, 2, -4000.198, 2999.9773, 362.2325, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325390, 3, -3996.9888, 3033.023, 357.0765, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325390, 4, -3994.8503, 3054.8823, 358.3323, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325390, 5, -3979.3108, 3059.3472, 356.358, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325390, 6, -3966.9504, 3056.263, 359.2541, NULL, 0, 1000, 0, 0, 0, 100, 0),
(1325390, 7, -3979.3108, 3059.3472, 356.358, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325390, 8, -3994.8503, 3054.8823, 358.3323, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325390, 9, -3996.9888, 3033.023, 357.0765, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325390, 10, -4000.198, 2999.9773, 362.2325, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325400, 1, -3973.707, 3030.5564, 356.673, NULL, 0, 800, 0, 0, 0, 100, 0),
(1325400, 2, -3939.1501, 3020.5642, 356.6612, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325400, 3, -3916.924, 2998.073, 358.1305, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325400, 4, -3932.9875, 3012.829, 356.6942, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325400, 5, -3961.7617, 3009.0342, 361.1651, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325400, 6, -3937.8606, 3015.6252, 356.6717, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325400, 7, -3922.0078, 3042.606, 356.7934, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325400, 8, -3914.5508, 3069.2585, 361.5072, NULL, 0, 1000, 0, 0, 0, 100, 0),
(1325400, 9, -3922.0078, 3042.606, 356.7934, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325400, 10, -3937.8606, 3015.6252, 356.6717, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325400, 11, -3961.7617, 3009.0342, 361.1651, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325400, 12, -3932.9875, 3012.829, 356.6942, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325400, 13, -3916.924, 2998.073, 358.1305, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325400, 14, -3939.1501, 3020.5642, 356.6612, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325410, 1, -4119.7417, 3109.896, 318.4244, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325410, 2, -4134.002, 3093.2654, 316.3293, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325410, 3, -4100.2393, 3091.1284, 316.7613, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325410, 4, -4069.76, 3119.6082, 312.6313, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325410, 5, -4053.822, 3134.2864, 307.0858, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325410, 6, -4021.1067, 3150.3342, 310.1628, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325410, 7, -4048.0208, 3137.3962, 307.1355, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325410, 8, -4058.3237, 3152.0464, 301.4464, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325410, 9, -4048.0208, 3137.3962, 307.1355, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325410, 10, -4021.1067, 3150.3342, 310.1628, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325410, 11, -4053.822, 3134.2864, 307.0858, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325410, 12, -4069.76, 3119.6082, 312.6313, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325410, 13, -4100.2393, 3091.1284, 316.7613, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325410, 14, -4134.002, 3093.2654, 316.3293, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325420, 1, -4139.3574, 3022.0112, 314.5214, NULL, 0, 700, 0, 0, 0, 100, 0),
(1325420, 2, -4136.969, 3050.4604, 313.7775, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325420, 3, -4150.546, 3058.2642, 313.7302, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325420, 4, -4174.9653, 3031.0698, 314.0562, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325420, 5, -4163.602, 3046.923, 314.1393, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325420, 6, -4174.6484, 3057.3164, 313.9355, NULL, 0, 1600, 0, 0, 0, 100, 0),
(1325420, 7, -4163.602, 3046.923, 314.1393, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325420, 8, -4174.9653, 3031.0698, 314.0562, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325420, 9, -4150.546, 3058.2642, 313.7302, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325420, 10, -4136.969, 3050.4604, 313.7775, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325430, 1, -4093.7534, 3221.7761, 297.7387, NULL, 0, 1200, 0, 0, 0, 100, 0),
(1325430, 2, -4081.8901, 3212.3157, 296.2597, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325430, 3, -4075.513, 3192.0007, 296.4495, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325430, 4, -4093.861, 3192.7876, 296.8782, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325430, 5, -4075.4526, 3192.612, 296.4727, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325430, 6, -4070.375, 3168.125, 297.5828, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325430, 7, -4059.1858, 3155.4675, 300.5921, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325430, 8, -4070.5273, 3168.9583, 297.498, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325430, 9, -4075.513, 3192.0007, 296.4495, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325430, 10, -4058.432, 3191.9246, 297.1926, NULL, 0, 1300, 0, 0, 0, 100, 0),
(1325430, 11, -4075.513, 3192.0007, 296.4495, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325430, 12, -4070.5273, 3168.9583, 297.498, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325430, 13, -4059.1858, 3155.4675, 300.5921, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325430, 14, -4070.375, 3168.125, 297.5828, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325430, 15, -4075.4526, 3192.612, 296.4727, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325430, 16, -4093.861, 3192.7876, 296.8782, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325430, 17, -4075.513, 3192.0007, 296.4495, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325430, 18, -4081.8901, 3212.3157, 296.2597, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325440, 1, -4165.559, 3184.8762, 314.8151, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325440, 2, -4166.746, 3166.2896, 316.3796, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325440, 3, -4162.3135, 3133.0076, 317.8702, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325440, 4, -4163.2524, 3102.3423, 320.6021, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325440, 5, -4145.0854, 3090.6345, 316.6877, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325440, 6, -4163.4307, 3101.851, 320.6096, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325440, 7, -4176.16, 3096.3442, 323.4846, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325440, 8, -4165.0566, 3100.9766, 320.959, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325440, 9, -4160.315, 3132.466, 317.9405, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325440, 10, -4168.0054, 3165.2698, 316.4063, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325440, 11, -4182.0454, 3178.0552, 316.2212, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325440, 12, -4168.0054, 3165.2698, 316.4063, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325440, 13, -4160.315, 3132.466, 317.9405, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325440, 14, -4165.0566, 3100.9766, 320.959, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325440, 15, -4176.16, 3096.3442, 323.4846, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325440, 16, -4163.4307, 3101.851, 320.6096, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325440, 17, -4145.0854, 3090.6345, 316.6877, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325440, 18, -4163.2524, 3102.3423, 320.6021, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325440, 19, -4162.3135, 3133.0076, 317.8702, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325440, 20, -4166.746, 3166.2896, 316.3796, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325450, 1, -3744.2668, 3302.509, 295.6921, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325450, 2, -3737.996, 3317.6348, 292.1595, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325450, 3, -3719.209, 3335.497, 288.1424, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325450, 4, -3693.2634, 3332.8772, 284.0348, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325450, 5, -3676.0378, 3323.4683, 283.5865, NULL, 0, 1600, 0, 0, 0, 100, 0),
(1325450, 6, -3693.2634, 3332.8772, 284.0348, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325450, 7, -3719.209, 3335.497, 288.1424, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325450, 8, -3737.996, 3317.6348, 292.1595, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325460, 1, -3679.8496, 3379.1377, 282.6162, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325460, 2, -3685.4558, 3366.3135, 283.1652, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325460, 3, -3693.9727, 3340.1736, 284.2847, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325460, 4, -3697.1963, 3309.8274, 284.073, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325460, 5, -3693.9727, 3340.1736, 284.2847, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325460, 6, -3685.4558, 3366.3135, 283.1652, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325470, 1, -4070.2266, 3367.7197, 286.2718, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325470, 2, -4085.0078, 3348.8535, 284.8255, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325470, 3, -4066.0447, 3333.26, 283.9706, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325470, 4, -4048.2527, 3313.073, 284.0718, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325470, 5, -4030.6707, 3315.8843, 283.3297, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325470, 6, -4008.5312, 3303.6086, 283.7416, NULL, 0, 900, 0, 0, 0, 100, 0),
(1325470, 7, -4030.6707, 3315.8843, 283.3297, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325470, 8, -4048.2527, 3313.073, 284.0718, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325470, 9, -4066.0447, 3333.26, 283.9706, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325470, 10, -4085.0078, 3348.8535, 284.8255, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325480, 1, -4029.7048, 3096.8508, 336.7336, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325480, 2, -3999.01, 3099.4229, 337.358, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325480, 3, -3970.3848, 3113.7354, 335.0745, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325480, 4, -3955.395, 3121.525, 340.959, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325480, 5, -3934.9514, 3099.86, 342.4817, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325480, 6, -3935.2297, 3086.063, 336.8768, NULL, 0, 1200, 0, 0, 0, 100, 0),
(1325480, 7, -3934.9514, 3099.86, 342.4817, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325480, 8, -3955.395, 3121.525, 340.959, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325480, 9, -3970.3848, 3113.7354, 335.0745, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325480, 10, -3999.01, 3099.4229, 337.358, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325490, 1, -3920.524, 3031.806, 356.6682, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325490, 2, -3951.6516, 3060.3833, 351.4317, NULL, 0, 700, 0, 0, 0, 100, 0),
(1325490, 3, -3920.524, 3031.806, 356.6682, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325490, 4, -3897.1597, 3008.251, 360.1607, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325490, 5, -3905.9675, 3013.8137, 358.0692, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325490, 6, -3919.2002, 3007.8684, 357.5858, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325490, 7, -3961.2744, 3010.0105, 360.9463, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325490, 8, -3941.884, 3015.6917, 356.7059, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325490, 9, -3929.5195, 3032.05, 356.7416, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325490, 10, -3941.884, 3015.6917, 356.7059, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325490, 11, -3961.2744, 3010.0105, 360.9463, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325490, 12, -3919.2002, 3007.8684, 357.5858, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325490, 13, -3905.9675, 3013.8137, 358.0692, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325490, 14, -3897.1597, 3008.251, 360.1607, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325500, 1, -3857.5686, 3322.6333, 274.6719, NULL, 0, 600, 0, 0, 0, 100, 0),
(1325500, 2, -3871.2354, 3312.5947, 274.5233, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325500, 3, -3881.366, 3325.4749, 274.165, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325500, 4, -3864.644, 3307.7246, 274.1976, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325500, 5, -3869.131, 3291.722, 275.1654, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325500, 6, -3864.675, 3285.9624, 275.0975, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325500, 7, -3845.0266, 3293.582, 274.7799, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325500, 8, -3833.0618, 3288.5322, 275.0233, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325500, 9, -3845.0266, 3293.582, 274.7799, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325500, 10, -3864.675, 3285.9624, 275.0975, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325500, 11, -3869.131, 3291.722, 275.1654, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325500, 12, -3864.644, 3307.7246, 274.1976, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325500, 13, -3881.366, 3325.4749, 274.165, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325500, 14, -3871.2354, 3312.5947, 274.5233, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325510, 1, -3700.4822, 3774.388, 270.1134, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325510, 2, -3728.8442, 3763.8247, 271.4504, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325510, 3, -3726.4966, 3740.9666, 275.7964, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325510, 4, -3700.691, 3724.0374, 276.8549, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325510, 5, -3666.9414, 3711.4863, 279.7839, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325510, 6, -3700.691, 3724.0374, 276.8549, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325510, 7, -3726.4966, 3740.9666, 275.7964, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325510, 8, -3728.8442, 3763.8247, 271.4504, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325520, 1, -3848.26, 3785.417, 284.0748, NULL, 0, 900, 0, 0, 0, 100, 0),
(1325520, 2, -3833.8047, 3787.5781, 279.9487, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325520, 3, -3817.5503, 3776.197, 275.7072, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325520, 4, -3809.9543, 3778.3372, 275.3922, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325520, 5, -3801.8845, 3772.5586, 275.4824, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325520, 6, -3805.6245, 3758.638, 276.6786, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325520, 7, -3801.8252, 3753.408, 277.8285, NULL, 0, 600, 0, 0, 0, 100, 0),
(1325520, 8, -3805.6245, 3758.638, 276.6786, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325520, 9, -3801.8845, 3772.5586, 275.4824, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325520, 10, -3809.9543, 3778.3372, 275.3922, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325520, 11, -3817.5503, 3776.197, 275.7072, NULL, 0, 0, 0, 0, 0, 100, 0),
(1325520, 12, -3833.8047, 3787.5781, 279.9487, NULL, 0, 0, 0, 0, 0, 100, 0),
(1328390, 1, -3874.6858, 3690.8586, 335.16, NULL, 0, 1300, 0, 0, 0, 100, 0),
(1328390, 2, -3868.3772, 3683.0781, 335.453, NULL, 0, 0, 0, 0, 0, 100, 0),
(1328390, 3, -3866.359, 3670.0999, 335.9136, NULL, 0, 0, 0, 0, 0, 100, 0),
(1328390, 4, -3878.931, 3656.7063, 335.9134, NULL, 0, 0, 0, 0, 0, 100, 0),
(1328390, 5, -3896.576, 3661.4697, 335.9094, NULL, 0, 0, 0, 0, 0, 100, 0),
(1328390, 6, -3901.9111, 3676.683, 335.9148, NULL, 0, 0, 0, 0, 0, 100, 0),
(1328390, 7, -3885.0474, 3692.2058, 335.2407, NULL, 0, 900, 0, 0, 0, 100, 0),
(1328390, 8, -3901.9111, 3676.683, 335.9148, NULL, 0, 0, 0, 0, 0, 100, 0),
(1328390, 9, -3896.576, 3661.4697, 335.9094, NULL, 0, 0, 0, 0, 0, 100, 0),
(1328390, 10, -3878.931, 3656.7063, 335.9134, NULL, 0, 0, 0, 0, 0, 100, 0),
(1328390, 11, -3866.359, 3670.0999, 335.9136, NULL, 0, 0, 0, 0, 0, 100, 0),
(1328390, 12, -3868.3772, 3683.0781, 335.453, NULL, 0, 0, 0, 0, 0, 100, 0),
(1328400, 1, -3967.2666, 3204.6196, 334.0428, NULL, 0, 0, 0, 0, 0, 100, 0),
(1328400, 2, -3978.829, 3179.861, 345.176, NULL, 0, 0, 0, 0, 0, 100, 0),
(1328400, 3, -3986.9844, 3162.9255, 360.8237, NULL, 0, 0, 0, 0, 0, 100, 0),
(1328400, 4, -3991.1814, 3154.4539, 362.5404, NULL, 0, 0, 0, 0, 0, 100, 0),
(1328400, 5, -4006.073, 3150.619, 362.5322, NULL, 0, 0, 0, 0, 0, 100, 0),
(1328400, 6, -4014.3667, 3134.9302, 362.5286, NULL, 0, 0, 0, 0, 0, 100, 0),
(1328400, 7, -4004.2158, 3122.3123, 362.5383, NULL, 0, 0, 0, 0, 0, 100, 0),
(1328400, 8, -3985.1904, 3123.6284, 362.0462, NULL, 0, 600, 0, 0, 0, 100, 0),
(1328400, 9, -4004.2158, 3122.3123, 362.5383, NULL, 0, 0, 0, 0, 0, 100, 0),
(1328400, 10, -4014.3667, 3134.9302, 362.5286, NULL, 0, 0, 0, 0, 0, 100, 0),
(1328400, 11, -4006.073, 3150.619, 362.5322, NULL, 0, 0, 0, 0, 0, 100, 0),
(1328400, 12, -3991.1814, 3154.4539, 362.5404, NULL, 0, 0, 0, 0, 0, 100, 0),
(1328400, 13, -3986.9844, 3162.9255, 360.8237, NULL, 0, 0, 0, 0, 0, 100, 0),
(1328400, 14, -3978.829, 3179.861, 345.176, NULL, 0, 0, 0, 0, 0, 100, 0),
(1328410, 1, -3846.655, 3418.7048, 324.4809, NULL, 0, 0, 0, 0, 0, 100, 0),
(1328410, 2, -3837.9353, 3431.9197, 325.0981, NULL, 0, 0, 0, 0, 0, 100, 0),
(1328410, 3, -3844.3538, 3450.1216, 325.1585, NULL, 0, 0, 0, 0, 0, 100, 0),
(1328410, 4, -3860.3086, 3452.64, 325.1643, NULL, 0, 0, 0, 0, 0, 100, 0),
(1328410, 5, -3872.5183, 3439.7778, 325.1433, NULL, 0, 0, 0, 0, 0, 100, 0),
(1328410, 6, -3864.665, 3420.7825, 324.6057, NULL, 0, 0, 0, 0, 0, 100, 0),
(1328410, 7, -3857.961, 3419.8645, 324.5635, NULL, 0, 600, 0, 0, 0, 100, 0),
(1328410, 8, -3864.665, 3420.7825, 324.6057, NULL, 0, 0, 0, 0, 0, 100, 0),
(1328410, 9, -3872.5183, 3439.7778, 325.1433, NULL, 0, 0, 0, 0, 0, 100, 0),
(1328410, 10, -3860.3086, 3452.64, 325.1643, NULL, 0, 0, 0, 0, 0, 100, 0),
(1328410, 11, -3844.3538, 3450.1216, 325.1585, NULL, 0, 0, 0, 0, 0, 100, 0),
(1328410, 12, -3837.9353, 3431.9197, 325.0981, NULL, 0, 0, 0, 0, 0, 100, 0);

-- Entry SAI: Reaver spawn visual (every sniffed spawn, 44/44 CO2, casts 24240 as it appears); Reaver and High
-- Priest idle casts, picked by UNIT_STATE_ROAMING (wanderers kneel and shout / keep up 16592, statics keep up
-- Battle Shout / 41912); unroot on aggro for the creatures whose idle actionlists root them. Soulcaller combat
-- movement is cast flag 64 on Shadow Bolt.
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid` IN (21649, 21651, 21787, 21911);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21649, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 0, 11, 13901, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Windwalker - On Aggro - Cast ''Arcane Bolt'' (No Repeat)'),
(21649, 0, 1, 0, 0, 0, 100, 0, 2400, 3800, 2400, 3800, 0, 0, 11, 13901, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Windwalker - In Combat - Cast ''Arcane Bolt'''),
(21649, 0, 2, 0, 0, 0, 100, 0, 4000, 6500, 14000, 18000, 0, 0, 11, 40578, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Windwalker - In Combat - Cast ''Cyclone'''),
(21649, 0, 3, 0, 14, 0, 100, 0, 3000, 40, 20000, 30000, 0, 0, 11, 34110, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Windwalker - Friendly At 3000 Health - Cast ''Shadow Mend'''),
(21649, 0, 4, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 103, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Windwalker - On Aggro - Set Rooted Off'),
(21651, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 0, 11, 42247, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Skettis Reaver - On Aggro - Cast ''42247'' (No Repeat)'),
(21651, 0, 1, 0, 0, 0, 100, 0, 2500, 5000, 10000, 15000, 0, 0, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Skettis Reaver - In Combat - Cast ''15496'''),
(21651, 0, 2, 0, 2, 0, 100, 1, 5, 30, 0, 0, 0, 0, 11, 3019, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Skettis Reaver - Between 5-30% Health - Cast ''3019'' (No Repeat)'),
(21651, 0, 3, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 24240, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Skettis Reaver - On Respawn - Cast ''Spawn - Red Lightning'''),
(21651, 0, 4, 0, 1, 0, 100, 0, 5000, 254500, 155100, 254500, 0, 0, 80, 2165101, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Skettis Reaver - Out of Combat - Run Script (Roaming)'),
(21651, 0, 5, 0, 60, 0, 100, 0, 1000, 1000, 5000, 5000, 0, 0, 11, 42247, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Skettis Reaver - On Update - Cast ''Battle Shout'' (Not Roaming)'),
(21651, 0, 6, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 103, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Skettis Reaver - On Aggro - Set Rooted Off'),
(21787, 0, 0, 0, 0, 0, 100, 0, 4000, 8000, 7000, 16000, 0, 0, 11, 11639, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Skettis High Priest - In Combat - Cast ''Shadow Word: Pain'''),
(21787, 0, 1, 0, 0, 0, 100, 0, 2300, 3000, 8000, 12000, 0, 0, 11, 9734, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Skettis High Priest - In Combat - Cast ''Holy Smite'''),
(21787, 0, 2, 0, 74, 0, 100, 0, 0, 0, 10000, 15000, 40, 40, 11, 42420, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Skettis High Priest - On Friendly Below 40% Health - Cast ''Flash Heal'''),
(21787, 0, 3, 0, 60, 0, 100, 0, 1000, 1000, 5000, 5000, 0, 0, 11, 16592, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Skettis High Priest - On Update - Cast ''Shadowform'' (Roaming)'),
(21787, 0, 4, 0, 60, 0, 100, 0, 1000, 1000, 5000, 5000, 0, 0, 11, 41912, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Skettis High Priest - On Update - Cast ''Shadowform'' (Not Roaming)'),
(21911, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 20298, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - On Aggro - Cast ''Shadow Bolt'''),
(21911, 0, 1, 0, 0, 0, 100, 0, 2400, 3800, 2400, 3800, 0, 0, 11, 20298, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - In Combat - Cast ''Shadow Bolt'''),
(21911, 0, 2, 0, 2, 0, 100, 1, 0, 30, 0, 0, 0, 0, 11, 5137, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Between 0-30% Health - Cast ''Call of the Grave'' (No Repeat)'),
(21911, 0, 3, 0, 0, 0, 100, 0, 6000, 10000, 13000, 18000, 0, 0, 11, 38663, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - In Combat - Cast ''Slow'''),
(21911, 0, 4, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 103, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - On Aggro - Set Rooted Off');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceId`=0 AND ((`SourceGroup`=5 AND `SourceEntry`=21651) OR (`SourceGroup`=6 AND `SourceEntry`=21651) OR (`SourceGroup`=4 AND `SourceEntry`=21787) OR (`SourceGroup`=5 AND `SourceEntry`=21787));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 5, 21651, 0, 0, 21, 1, 16, 0, 0, 0, 0, 0, '', 'Time-Lost Skettis Reaver - Object has unit state UNIT_STATE_ROAMING'),
(22, 6, 21651, 0, 0, 21, 1, 16, 0, 0, 1, 0, 0, '', 'Time-Lost Skettis Reaver - Object doesn''t have unit state UNIT_STATE_ROAMING'),
(22, 4, 21787, 0, 0, 21, 1, 16, 0, 0, 0, 0, 0, '', 'Time-Lost Skettis High Priest - Object has unit state UNIT_STATE_ROAMING'),
(22, 5, 21787, 0, 0, 21, 1, 16, 0, 0, 1, 0, 0, '', 'Time-Lost Skettis High Priest - Object doesn''t have unit state UNIT_STATE_ROAMING');
-- Guid SAI; DONT_OVERRIDE_ENTRY_SAI so the entry combat scripts keep loading beside it
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|0x08000000 WHERE `entry` IN (21649, 21911);
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid` IN (-132842, -132841, -132840, -132839, -132780, -76676, -76675, -76674, -76673, -76672, -76671, -76670, -76669, -76668, -76667, -76666, -76665, -76664, -76663, -76662, -76661, -76660, -76659, -76658, -76657, -76656, -75574, -75506, -75505, -75504, -75503, -75502, -75501, -75500, -75499, -75497, -75496, -75495, -75494, -75493, -75492);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-132842, 0, 0, 0, 1, 0, 100, 0, 5000, 58300, 35600, 58300, 0, 0, 80, 2191106, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Out of Combat - Run Script'),
(-132842, 0, 1, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 2191103, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - On Point 1 Reached - Run Script'),
(-132841, 0, 0, 0, 1, 0, 100, 0, 30000, 200000, 100000, 200000, 0, 0, 80, 2191101, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Out of Combat - Run Script'),
(-132840, 0, 0, 0, 1, 0, 100, 0, 30000, 200000, 100000, 200000, 0, 0, 80, 2191101, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Out of Combat - Run Script'),
(-132839, 0, 0, 0, 1, 0, 100, 0, 30000, 200000, 100000, 200000, 0, 0, 80, 2191101, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Out of Combat - Run Script'),
(-132780, 0, 0, 0, 1, 0, 100, 0, 5000, 59500, 35600, 59500, 0, 0, 80, 13278001, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Windwalker - Out of Combat - Run Script'),
(-132780, 0, 1, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 2164902, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Windwalker - On Point 1 Reached - Run Script'),
(-76676, 0, 0, 0, 1, 0, 100, 0, 5000, 58300, 39300, 58300, 0, 0, 80, 2191102, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Out of Combat - Run Script'),
(-76676, 0, 1, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 2191103, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - On Point 1 Reached - Run Script'),
(-76675, 0, 0, 0, 1, 0, 100, 0, 5000, 58300, 37200, 58300, 0, 0, 80, 2191102, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Out of Combat - Run Script'),
(-76675, 0, 1, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 2191103, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - On Point 1 Reached - Run Script'),
(-76674, 0, 0, 0, 1, 0, 100, 0, 5000, 59900, 38800, 59900, 0, 0, 80, 2191102, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Out of Combat - Run Script'),
(-76674, 0, 1, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 2191103, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - On Point 1 Reached - Run Script'),
(-76673, 0, 0, 0, 1, 0, 100, 0, 5000, 56300, 40500, 56300, 0, 0, 80, 2191106, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Out of Combat - Run Script'),
(-76673, 0, 1, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 2191103, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - On Point 1 Reached - Run Script'),
(-76672, 0, 0, 0, 108, 0, 100, 0, 5, 766720, 0, 0, 0, 0, 80, 2191104, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - On Point 5 of Path 766720 Reached - Run Script'),
(-76671, 0, 0, 0, 1, 0, 100, 0, 30000, 200000, 100000, 200000, 0, 0, 80, 2191101, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Out of Combat - Run Script'),
(-76670, 0, 0, 0, 1, 0, 100, 0, 5000, 56600, 32000, 56600, 0, 0, 80, 2191102, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Out of Combat - Run Script'),
(-76670, 0, 1, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 2191103, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - On Point 1 Reached - Run Script'),
(-76669, 0, 0, 0, 108, 0, 100, 0, 1, 766690, 0, 0, 0, 0, 80, 7666901, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - On Point 1 of Path 766690 Reached - Run Script'),
(-76669, 0, 1, 0, 108, 0, 100, 0, 2, 766690, 0, 0, 0, 0, 80, 2191104, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - On Point 2 of Path 766690 Reached - Run Script'),
(-76668, 0, 0, 0, 1, 0, 100, 0, 30000, 200000, 100000, 200000, 0, 0, 80, 2191101, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Out of Combat - Run Script'),
(-76667, 0, 0, 0, 108, 0, 100, 0, 3, 766670, 0, 0, 0, 0, 80, 2191104, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - On Point 3 of Path 766670 Reached - Run Script'),
(-76666, 0, 0, 0, 1, 0, 100, 0, 30000, 200000, 100000, 200000, 0, 0, 80, 2191101, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Out of Combat - Run Script'),
(-76665, 0, 0, 0, 1, 0, 100, 0, 5000, 82600, 46900, 82600, 0, 0, 80, 2191106, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Out of Combat - Run Script'),
(-76665, 0, 1, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 2191103, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - On Point 1 Reached - Run Script'),
(-76664, 0, 0, 0, 1, 0, 100, 0, 30000, 200000, 100000, 200000, 0, 0, 80, 2191101, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Out of Combat - Run Script'),
(-76663, 0, 0, 0, 108, 0, 100, 0, 1, 766630, 0, 0, 0, 0, 80, 2191107, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - On Point 1 of Path 766630 Reached - Run Script'),
(-76663, 0, 1, 0, 108, 0, 100, 0, 2, 766630, 0, 0, 0, 0, 80, 2191104, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - On Point 2 of Path 766630 Reached - Run Script'),
(-76662, 0, 0, 0, 1, 0, 100, 0, 5000, 77800, 49100, 77800, 0, 0, 80, 2191105, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Out of Combat - Run Script'),
(-76662, 0, 1, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 2191103, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - On Point 1 Reached - Run Script'),
(-76661, 0, 0, 0, 1, 0, 100, 0, 30000, 200000, 100000, 200000, 0, 0, 80, 2191101, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Out of Combat - Run Script'),
(-76660, 0, 0, 0, 1, 0, 100, 0, 30000, 200000, 100000, 200000, 0, 0, 80, 2191101, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Out of Combat - Run Script'),
(-76659, 0, 0, 0, 1, 0, 100, 0, 5000, 65600, 41600, 65600, 0, 0, 80, 2191106, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Out of Combat - Run Script'),
(-76659, 0, 1, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 2191103, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - On Point 1 Reached - Run Script'),
(-76658, 0, 0, 0, 1, 0, 100, 0, 5000, 95600, 74500, 95600, 0, 0, 80, 2191106, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Out of Combat - Run Script'),
(-76658, 0, 1, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 2191103, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - On Point 1 Reached - Run Script'),
(-76657, 0, 0, 0, 1, 0, 100, 0, 5000, 53300, 35700, 53300, 0, 0, 80, 2191105, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Out of Combat - Run Script'),
(-76657, 0, 1, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 2191103, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - On Point 1 Reached - Run Script'),
(-76656, 0, 0, 0, 1, 0, 100, 0, 30000, 200000, 100000, 200000, 0, 0, 80, 2191101, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Out of Combat - Run Script'),
(-75574, 0, 0, 0, 1, 0, 100, 0, 5000, 49400, 39400, 49400, 0, 0, 80, 7557401, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Windwalker - Out of Combat - Run Script'),
(-75574, 0, 1, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 2164902, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Windwalker - On Point 1 Reached - Run Script'),
(-75506, 0, 0, 0, 1, 0, 100, 0, 5000, 74100, 55100, 74100, 0, 0, 80, 2191106, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Out of Combat - Run Script'),
(-75506, 0, 1, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 2191103, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - On Point 1 Reached - Run Script'),
(-75505, 0, 0, 0, 1, 0, 100, 0, 30000, 200000, 100000, 200000, 0, 0, 80, 2191101, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Out of Combat - Run Script'),
(-75504, 0, 0, 0, 1, 0, 100, 0, 30000, 200000, 100000, 200000, 0, 0, 80, 2191101, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Out of Combat - Run Script'),
(-75503, 0, 0, 0, 108, 0, 100, 0, 1, 755030, 0, 0, 0, 0, 80, 2191107, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - On Point 1 of Path 755030 Reached - Run Script'),
(-75503, 0, 1, 0, 108, 0, 100, 0, 2, 755030, 0, 0, 0, 0, 80, 2191104, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - On Point 2 of Path 755030 Reached - Run Script'),
(-75502, 0, 0, 0, 108, 0, 100, 0, 2, 755020, 0, 0, 0, 0, 80, 2191104, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - On Point 2 of Path 755020 Reached - Run Script'),
(-75501, 0, 0, 0, 1, 0, 100, 0, 5000, 84200, 53400, 84200, 0, 0, 80, 2191106, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Out of Combat - Run Script'),
(-75501, 0, 1, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 2191103, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - On Point 1 Reached - Run Script'),
(-75500, 0, 0, 0, 1, 0, 100, 0, 5000, 84200, 51800, 84200, 0, 0, 80, 2191105, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Out of Combat - Run Script'),
(-75500, 0, 1, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 2191103, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - On Point 1 Reached - Run Script'),
(-75499, 0, 0, 0, 108, 0, 100, 0, 1, 754990, 0, 0, 0, 0, 80, 7549901, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - On Point 1 of Path 754990 Reached - Run Script'),
(-75497, 0, 0, 0, 1, 0, 100, 0, 30000, 200000, 100000, 200000, 0, 0, 80, 2191101, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Out of Combat - Run Script'),
(-75496, 0, 0, 0, 108, 0, 100, 0, 2, 754960, 0, 0, 0, 0, 80, 2191104, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - On Point 2 of Path 754960 Reached - Run Script'),
(-75495, 0, 0, 0, 1, 0, 100, 0, 30000, 200000, 100000, 200000, 0, 0, 80, 2191101, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Out of Combat - Run Script'),
(-75494, 0, 0, 0, 1, 0, 100, 0, 30000, 200000, 100000, 200000, 0, 0, 80, 2191101, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Out of Combat - Run Script'),
(-75493, 0, 0, 0, 1, 0, 100, 0, 5000, 92400, 52100, 92400, 0, 0, 80, 2191102, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Out of Combat - Run Script'),
(-75493, 0, 1, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 2191103, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - On Point 1 Reached - Run Script'),
(-75492, 0, 0, 0, 1, 0, 100, 0, 30000, 200000, 100000, 200000, 0, 0, 80, 2191101, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Out of Combat - Run Script');
DELETE FROM `smart_scripts` WHERE `source_type`=9 AND `entryorguid` IN (2164902, 2165101, 2191101, 2191102, 2191103, 2191104, 2191105, 2191106, 2191107, 7549901, 7557401, 7666901, 13278001);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2164902, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 103, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Windwalker - Actionlist - Set Rooted On'),
(2164902, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 21794, 20, 0, 0, 0, 0, 0, 0, 'Skettis Windwalker - Actionlist - Set Orientation Closest Creature ''Skettis Arakkoa Spell Origin 01'''),
(2164902, 9, 2, 0, 0, 0, 100, 0, 1400, 1400, 0, 0, 0, 0, 11, 37679, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Windwalker - Actionlist - Cast ''Arakkoa Channeling (no duration)'''),
(2164902, 9, 3, 0, 0, 0, 100, 0, 9700, 9700, 0, 0, 0, 0, 28, 37679, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Windwalker - Actionlist - Remove Aura ''Arakkoa Channeling (no duration)'''),
(2164902, 9, 4, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 0, 0, 103, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Windwalker - Actionlist - Set Rooted Off'),
(2165101, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 103, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Skettis Reaver - Actionlist - Set Rooted On'),
(2165101, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Skettis Reaver - Actionlist - Set Bytes1 8 (Kneel)'),
(2165101, 9, 2, 0, 0, 0, 100, 0, 19500, 19500, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Skettis Reaver - Actionlist - Remove Bytes1 8 (Kneel)'),
(2165101, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 42247, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Skettis Reaver - Actionlist - Cast ''Battle Shout'''),
(2165101, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 103, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Skettis Reaver - Actionlist - Set Rooted Off'),
(2191101, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 235, 9700, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Actionlist - Pause Movement'),
(2191101, 9, 1, 0, 0, 0, 100, 0, 1600, 1600, 0, 0, 0, 0, 5, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Actionlist - Play Emote 1'),
(2191101, 9, 2, 0, 0, 0, 100, 0, 3300, 3300, 0, 0, 0, 0, 5, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Actionlist - Play Emote 1'),
(2191102, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Actionlist - Set Run Off'),
(2191102, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 1, 0, 0, 19, 21791, 58, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Actionlist - Move To Closest Creature ''Skettis Kneel Target 01'''),
(2191103, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 103, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Actionlist - Set Rooted On'),
(2191103, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 21794, 20, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Actionlist - Set Orientation Closest Creature ''Skettis Arakkoa Spell Origin 01'''),
(2191103, 9, 2, 0, 0, 0, 100, 0, 1400, 1400, 0, 0, 0, 0, 11, 37679, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Actionlist - Cast ''Arakkoa Channeling (no duration)'''),
(2191103, 9, 3, 0, 0, 0, 100, 0, 9700, 9700, 0, 0, 0, 0, 28, 37679, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Actionlist - Remove Aura ''Arakkoa Channeling (no duration)'''),
(2191103, 9, 4, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 0, 0, 103, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Actionlist - Set Rooted Off'),
(2191104, 9, 0, 0, 0, 0, 100, 0, 1400, 1400, 0, 0, 0, 0, 11, 37679, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Actionlist - Cast ''Arakkoa Channeling (no duration)'''),
(2191104, 9, 1, 0, 0, 0, 100, 0, 9700, 9700, 0, 0, 0, 0, 28, 37679, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Actionlist - Remove Aura ''Arakkoa Channeling (no duration)'''),
(2191105, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Actionlist - Set Run Off'),
(2191105, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 1, 0, 0, 19, 21792, 58, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Actionlist - Move To Closest Creature ''Skettis Kneel Target 02'''),
(2191106, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Actionlist - Set Run Off'),
(2191106, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 1, 0, 0, 19, 21793, 58, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Actionlist - Move To Closest Creature ''Skettis Kneel Target 03'''),
(2191107, 9, 0, 0, 0, 0, 100, 0, 1600, 1600, 0, 0, 0, 0, 5, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Actionlist - Play Emote 1'),
(2191107, 9, 1, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 5, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Actionlist - Play Emote 1'),
(7549901, 9, 0, 0, 0, 0, 100, 0, 1600, 1600, 0, 0, 0, 0, 5, 61, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Actionlist - Play Emote 61'),
(7557401, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Windwalker - Actionlist - Set Run Off'),
(7557401, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 1, 0, 0, 19, 21791, 58, 0, 0, 0, 0, 0, 0, 'Skettis Windwalker - Actionlist - Move To Closest Creature ''Skettis Kneel Target 01'''),
(7666901, 9, 0, 0, 0, 0, 100, 0, 1600, 1600, 0, 0, 0, 0, 5, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Actionlist - Play Emote 1'),
(7666901, 9, 1, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 5, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Actionlist - Play Emote 1'),
(7666901, 9, 2, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 5, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Soulcaller - Actionlist - Play Emote 1'),
(13278001, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skettis Windwalker - Actionlist - Set Run Off'),
(13278001, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 1, 0, 0, 19, 21792, 58, 0, 0, 0, 0, 0, 0, 'Skettis Windwalker - Actionlist - Move To Closest Creature ''Skettis Kneel Target 02''');

-- Skettis: Skettis Surger, Blackwind Warp Chaser and Blackwind Sabercat spawns
-- (#19517), from 89 sniffs over the area (63 WotLK Classic 3.4.x; Retail, Cata Classic 4.4.0, TBC, MoP).
-- All three wander and were seen mostly by CO1, so the points are approximations: exact where a CO2 or an untouched
-- CO1 spawn point repeats across sniffs, else the middle of the sightings. The Sabercats on the plateau go: every
-- sniff shows Warp Chasers there; sniffed Sabercats keep to the south and east edges.

-- Rows no sniffed spawn needs
DELETE FROM `creature` WHERE `id`=21728 AND `guid` IN (75901, 75902, 75908, 75912, 75913, 75918, 75919, 75920, 75921, 75922, 75923, 75927, 75928, 75930, 75933, 75934, 75935, 75937, 75938, 75941, 75944, 75946, 75947);
DELETE FROM `creature` WHERE `id`=23219 AND `guid` IN (79020);
DELETE FROM `creature` WHERE `id`=21723 AND `guid` IN (75830, 75831, 75832, 75833, 75834, 75835, 75836, 75837, 75838, 75839, 75840, 75841, 75842, 75843, 75844, 75845, 75846, 75847, 75848, 75849, 75850, 75851, 75852, 75853, 75854, 75855, 75857, 75858, 75859, 75860, 75861, 75862, 75863, 75864, 75865, 75866, 75867, 75868, 75869, 75870, 75871, 75872, 75873, 75874, 75875, 75876, 75877, 75878, 75879, 75880, 75881, 75882, 75883, 75884, 75885, 75886, 75887, 75888, 75891, 75894);
DELETE FROM `creature_addon` WHERE `guid` IN (75830, 75831, 75832, 75833, 75834, 75835, 75836, 75837, 75838, 75839, 75840, 75841, 75842, 75843, 75844, 75845, 75846, 75847, 75848, 75849, 75850, 75851, 75852, 75853, 75854, 75855, 75857, 75858, 75859, 75860, 75861, 75862, 75863, 75864, 75865, 75866, 75867, 75868, 75869, 75870, 75871, 75872, 75873, 75874, 75875, 75876, 75877, 75878, 75879, 75880, 75881, 75882, 75883, 75884, 75885, 75886, 75887, 75888, 75891, 75894, 75901, 75902, 75908, 75912, 75913, 75918, 75919, 75920, 75921, 75922, 75923, 75927, 75928, 75930, 75933, 75934, 75935, 75937, 75938, 75941, 75944, 75946, 75947, 79020);

-- Existing spawns: sniffed position and wander radius
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3623.67, `position_y`=3141.01, `position_z`=312.9, `orientation`=0.7875, `wander_distance`=10, `MovementType`=1, `VerifiedBuild`=51943, `CreateObject`=1 WHERE `id`=21723 AND `guid`=75889;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3640.29, `position_y`=3187.47, `position_z`=314.058, `orientation`=1.3602, `wander_distance`=10, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=1 WHERE `id`=21723 AND `guid`=75890;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3607.55, `position_y`=3089.61, `position_z`=312.391, `orientation`=5.5888, `wander_distance`=10, `MovementType`=1, `VerifiedBuild`=51943, `CreateObject`=1 WHERE `id`=21723 AND `guid`=75892;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3573.34, `position_y`=3135.87, `position_z`=315.027, `orientation`=1.0835, `wander_distance`=10, `MovementType`=1, `VerifiedBuild`=50375, `CreateObject`=1 WHERE `id`=21723 AND `guid`=75893;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3586.7, `position_y`=3112.5, `position_z`=314.072, `orientation`=3.9802, `wander_distance`=10, `MovementType`=1, `VerifiedBuild`=51943, `CreateObject`=1 WHERE `id`=21723 AND `guid`=75895;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3545.18, `position_y`=3146.07, `position_z`=314.753, `orientation`=3.5973, `wander_distance`=10, `MovementType`=1, `VerifiedBuild`=51943, `CreateObject`=1 WHERE `id`=21723 AND `guid`=75896;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3552.27, `position_y`=3200.1, `position_z`=310.476, `orientation`=2.6737, `wander_distance`=10, `MovementType`=1, `VerifiedBuild`=51943, `CreateObject`=1 WHERE `id`=21723 AND `guid`=75899;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3297.87, `position_y`=3672.95, `position_z`=229.236, `orientation`=5.0981, `wander_distance`=17, `MovementType`=1, `VerifiedBuild`=53788, `CreateObject`=1 WHERE `id`=21728 AND `guid`=75900;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3347.09, `position_y`=3531.5, `position_z`=266.439, `orientation`=0.026, `wander_distance`=17, `MovementType`=1, `VerifiedBuild`=53788, `CreateObject`=1 WHERE `id`=21728 AND `guid`=75907;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3459.19, `position_y`=3539.28, `position_z`=267.795, `orientation`=2.8257, `wander_distance`=17, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=1 WHERE `id`=21728 AND `guid`=75911;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3433.05, `position_y`=3530.75, `position_z`=267.928, `orientation`=3.1955, `wander_distance`=17, `MovementType`=1, `VerifiedBuild`=53788, `CreateObject`=1 WHERE `id`=21728 AND `guid`=75915;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3623.62, `position_y`=3610.59, `position_z`=271.852, `orientation`=3.023, `wander_distance`=17, `MovementType`=1, `VerifiedBuild`=53622, `CreateObject`=1 WHERE `id`=21728 AND `guid`=75916;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3609.27, `position_y`=3551.92, `position_z`=269.003, `orientation`=5.9819, `wander_distance`=17, `MovementType`=1, `VerifiedBuild`=53622, `CreateObject`=1 WHERE `id`=21728 AND `guid`=75917;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3944.52, `position_y`=3613.95, `position_z`=268.344, `orientation`=0.2622, `wander_distance`=17, `MovementType`=1, `VerifiedBuild`=53622, `CreateObject`=1 WHERE `id`=21728 AND `guid`=75924;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3979.05, `position_y`=3576.85, `position_z`=269.131, `orientation`=4.5305, `wander_distance`=17, `MovementType`=1, `VerifiedBuild`=53622, `CreateObject`=1 WHERE `id`=21728 AND `guid`=75925;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4015.19, `position_y`=3542.4, `position_z`=266.702, `orientation`=5.3456, `wander_distance`=17, `MovementType`=1, `VerifiedBuild`=53622, `CreateObject`=1 WHERE `id`=21728 AND `guid`=75926;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3916.64, `position_y`=3384.57, `position_z`=255.29, `orientation`=1.0942, `wander_distance`=17, `MovementType`=1, `VerifiedBuild`=53788, `CreateObject`=1 WHERE `id`=21728 AND `guid`=75929;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3971.87, `position_y`=3384.85, `position_z`=270.473, `orientation`=0.7769, `wander_distance`=17, `MovementType`=1, `VerifiedBuild`=53788, `CreateObject`=1 WHERE `id`=21728 AND `guid`=75931;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3886.9, `position_y`=3353.53, `position_z`=266, `orientation`=5.0395, `wander_distance`=17, `MovementType`=1, `VerifiedBuild`=53788, `CreateObject`=1 WHERE `id`=21728 AND `guid`=75932;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3788.04, `position_y`=3386.14, `position_z`=262.383, `orientation`=2.0319, `wander_distance`=17, `MovementType`=1, `VerifiedBuild`=53622, `CreateObject`=1 WHERE `id`=21728 AND `guid`=75936;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3691.57, `position_y`=3425, `position_z`=268.868, `orientation`=0.9906, `wander_distance`=17, `MovementType`=1, `VerifiedBuild`=53622, `CreateObject`=1 WHERE `id`=21728 AND `guid`=75939;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3679.09, `position_y`=3484.22, `position_z`=260.89, `orientation`=2.8511, `wander_distance`=17, `MovementType`=1, `VerifiedBuild`=53622, `CreateObject`=1 WHERE `id`=21728 AND `guid`=75940;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3641.67, `position_y`=3516.67, `position_z`=269.708, `orientation`=3.8256, `wander_distance`=17, `MovementType`=1, `VerifiedBuild`=53622, `CreateObject`=1 WHERE `id`=21728 AND `guid`=75942;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3719.83, `position_y`=3447.34, `position_z`=254.212, `orientation`=6.2776, `wander_distance`=17, `MovementType`=1, `VerifiedBuild`=53622, `CreateObject`=1 WHERE `id`=21728 AND `guid`=75943;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3658.85, `position_y`=3508.93, `position_z`=263.678, `orientation`=4.7397, `wander_distance`=17, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=1 WHERE `id`=21728 AND `guid`=75945;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3770.01, `position_y`=3421.01, `position_z`=248.395, `orientation`=0.493, `wander_distance`=17, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=1 WHERE `id`=21728 AND `guid`=75948;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3377.52, `position_y`=3530.71, `position_z`=266.439, `orientation`=6.2215, `wander_distance`=17, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=1 WHERE `id`=21728 AND `guid`=75949;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3477.47, `position_y`=3548.44, `position_z`=270.467, `orientation`=0.6419, `wander_distance`=17, `MovementType`=1, `VerifiedBuild`=53622, `CreateObject`=1 WHERE `id`=21728 AND `guid`=75953;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3533.1, `position_y`=3551.36, `position_z`=269.219, `orientation`=3.0065, `wander_distance`=17, `MovementType`=1, `VerifiedBuild`=53622, `CreateObject`=1 WHERE `id`=21728 AND `guid`=75954;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3747.24, `position_y`=3415.18, `position_z`=251.523, `orientation`=4.8471, `wander_distance`=17, `MovementType`=1, `VerifiedBuild`=53622, `CreateObject`=1 WHERE `id`=21728 AND `guid`=133044;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4013.15, `position_y`=3475.84, `position_z`=269.79, `orientation`=0.7806, `wander_distance`=17, `MovementType`=1, `VerifiedBuild`=53622, `CreateObject`=1 WHERE `id`=21728 AND `guid`=133045;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3844.72, `position_y`=3383.23, `position_z`=262.064, `orientation`=0.3394, `wander_distance`=17, `MovementType`=1, `VerifiedBuild`=53788, `CreateObject`=1 WHERE `id`=21728 AND `guid`=133046;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3724.53, `position_y`=3393.63, `position_z`=269.929, `orientation`=3.8886, `wander_distance`=17, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=1 WHERE `id`=21728 AND `guid`=133047;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3982.8, `position_y`=3514.95, `position_z`=259.001, `orientation`=3.8672, `wander_distance`=17, `MovementType`=1, `VerifiedBuild`=53622, `CreateObject`=1 WHERE `id`=21728 AND `guid`=133048;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4025.4, `position_y`=3424, `position_z`=269, `orientation`=5.1916, `wander_distance`=17, `MovementType`=1, `VerifiedBuild`=53622, `CreateObject`=1 WHERE `id`=21728 AND `guid`=133049;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3654.08, `position_y`=3648.21, `position_z`=265.523, `orientation`=1.7518, `wander_distance`=17, `MovementType`=1, `VerifiedBuild`=53622, `CreateObject`=1 WHERE `id`=21728 AND `guid`=133050;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3586.72, `position_y`=3478.58, `position_z`=284.873, `orientation`=2.4971, `wander_distance`=15, `MovementType`=1, `VerifiedBuild`=53622, `CreateObject`=1 WHERE `id`=23219 AND `guid`=79019;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4233.33, `position_y`=3106.2, `position_z`=330.525, `orientation`=5.4402, `wander_distance`=15, `MovementType`=1, `VerifiedBuild`=53622, `CreateObject`=1 WHERE `id`=23219 AND `guid`=132849;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4147.71, `position_y`=3296.11, `position_z`=291.165, `orientation`=2.4649, `wander_distance`=15, `MovementType`=1, `VerifiedBuild`=53622, `CreateObject`=1 WHERE `id`=23219 AND `guid`=132850;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4086.99, `position_y`=3602.48, `position_z`=314, `orientation`=5.5427, `wander_distance`=15, `MovementType`=1, `VerifiedBuild`=53622, `CreateObject`=2 WHERE `id`=23219 AND `guid`=132851;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4141.67, `position_y`=3550, `position_z`=316.936, `orientation`=5.6392, `wander_distance`=15, `MovementType`=1, `VerifiedBuild`=53622, `CreateObject`=1 WHERE `id`=23219 AND `guid`=132852;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4022.66, `position_y`=3681.2, `position_z`=299.929, `orientation`=4.2412, `wander_distance`=15, `MovementType`=1, `VerifiedBuild`=53622, `CreateObject`=1 WHERE `id`=23219 AND `guid`=132853;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4123.28, `position_y`=3441.42, `position_z`=291.342, `orientation`=4.4819, `wander_distance`=15, `MovementType`=1, `VerifiedBuild`=53622, `CreateObject`=1 WHERE `id`=23219 AND `guid`=132854;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3622.75, `position_y`=3452.95, `position_z`=286.08, `orientation`=1.2302, `wander_distance`=15, `MovementType`=1, `VerifiedBuild`=52237, `CreateObject`=1 WHERE `id`=23219 AND `guid`=132855;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3590.87, `position_y`=3716.71, `position_z`=286.514, `orientation`=3.9512, `wander_distance`=15, `MovementType`=1, `VerifiedBuild`=53622, `CreateObject`=1 WHERE `id`=23219 AND `guid`=132856;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4056.16, `position_y`=3590.31, `position_z`=292.042, `orientation`=5.8659, `wander_distance`=15, `MovementType`=1, `VerifiedBuild`=53622, `CreateObject`=1 WHERE `id`=23219 AND `guid`=132857;

-- Missing spawns
DELETE FROM `creature` WHERE `id`=21728 AND `guid` IN (75538, 75539, 75540, 75560, 75561, 75562, 75565, 75566, 75568, 75569, 75570, 75573, 75577, 75578, 75580, 75583, 75594, 75595, 75596, 75598, 75599, 75600, 75601, 75613, 75614, 75615, 75616, 75617);
DELETE FROM `creature` WHERE `id`=23219 AND `guid` IN (75618, 75619, 75620, 75621, 75622, 75623, 75624, 75625, 75626, 75627, 75628, 75629, 75630, 75631, 75632, 75633, 75634, 75635, 75636, 75637, 75638, 75639, 75830, 75831, 75832, 75833, 75834, 75835, 75836, 75837);
DELETE FROM `creature` WHERE `id`=21723 AND `guid` IN (75525, 75526, 75527, 75529, 75532, 75535, 75536, 75537);
DELETE FROM `creature_addon` WHERE `guid` IN (75525, 75526, 75527, 75529, 75532, 75535, 75536, 75537, 75538, 75539, 75540, 75560, 75561, 75562, 75565, 75566, 75568, 75569, 75570, 75573, 75577, 75578, 75580, 75583, 75594, 75595, 75596, 75598, 75599, 75600, 75601, 75613, 75614, 75615, 75616, 75617, 75618, 75619, 75620, 75621, 75622, 75623, 75624, 75625, 75626, 75627, 75628, 75629, 75630, 75631, 75632, 75633, 75634, 75635, 75636, 75637, 75638, 75639, 75830, 75831, 75832, 75833, 75834, 75835, 75836, 75837);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(75525, 21723, 530, 0, 0, 1, 1, 0, -3652.76, 2919.23, 330.934, 0.2819, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 53788, 1, NULL), -- Blackwind Sabercat
(75526, 21723, 530, 0, 0, 1, 1, 0, -3646.83, 2987.04, 338.294, 5.4543, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 53788, 1, NULL), -- Blackwind Sabercat
(75527, 21723, 530, 0, 0, 1, 1, 0, -3539.44, 3239.89, 302.228, 3.7874, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 45942, 1, NULL), -- Blackwind Sabercat
(75529, 21723, 530, 0, 0, 1, 1, 0, -3408.53, 3376.66, 317.284, 5.761, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 52237, 1, NULL), -- Blackwind Sabercat
(75532, 21723, 530, 0, 0, 1, 1, 0, -3407.36, 3316.18, 316.301, 2.678, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 53788, 1, NULL), -- Blackwind Sabercat
(75535, 21723, 530, 0, 0, 1, 1, 0, -3374.22, 3282.82, 303.906, 3.1053, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 53788, 1, NULL), -- Blackwind Sabercat
(75536, 21723, 530, 0, 0, 1, 1, 0, -3285.75, 3290.48, 261.206, 2.6561, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 53788, 1, NULL), -- Blackwind Sabercat
(75537, 21723, 530, 0, 0, 1, 1, 0, -3244.37, 3323.73, 254.352, 0.5923, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 53788, 1, NULL), -- Blackwind Sabercat
(75538, 21728, 530, 0, 0, 1, 1, 0, -4030.67, 3458.7, 273.242, 3.8063, 300, 17, 0, 1, 0, 1, 0, 0, 0, '', 52237, 1, NULL), -- Skettis Surger
(75539, 21728, 530, 0, 0, 1, 1, 0, -3983.44, 3450.69, 259.365, 1.6353, 300, 17, 0, 1, 0, 1, 0, 0, 0, '', 53788, 1, NULL), -- Skettis Surger
(75540, 21728, 530, 0, 0, 1, 1, 0, -3953.68, 3416.16, 253.965, 6.0216, 300, 17, 0, 1, 0, 1, 0, 0, 0, '', 53788, 1, NULL), -- Skettis Surger
(75560, 21728, 530, 0, 0, 1, 1, 0, -3950.06, 3483.32, 249.846, 4.0282, 300, 17, 0, 1, 0, 1, 0, 0, 0, '', 53788, 1, NULL), -- Skettis Surger
(75561, 21728, 530, 0, 0, 1, 1, 0, -3947.33, 3549.92, 258.197, 0.162, 300, 17, 0, 1, 0, 1, 0, 0, 0, '', 53788, 1, NULL), -- Skettis Surger
(75562, 21728, 530, 0, 0, 1, 1, 0, -3923.87, 3569.8, 252.848, 3.6445, 300, 17, 0, 1, 0, 1, 0, 0, 0, '', 53788, 1, NULL), -- Skettis Surger
(75565, 21728, 530, 0, 0, 1, 1, 0, -3916.26, 3517.72, 249.962, 1.8188, 300, 17, 0, 1, 0, 1, 0, 0, 0, '', 53788, 1, NULL), -- Skettis Surger
(75566, 21728, 530, 0, 0, 1, 1, 0, -3887.3, 3589.72, 250.364, 3.6186, 300, 17, 0, 1, 0, 1, 0, 0, 0, '', 52237, 1, NULL), -- Skettis Surger
(75568, 21728, 530, 0, 0, 1, 1, 0, -3881.32, 3382.8, 251.073, 6.0555, 300, 17, 0, 1, 0, 1, 0, 0, 0, '', 52237, 1, NULL), -- Skettis Surger
(75569, 21728, 530, 0, 0, 1, 1, 0, -3876.49, 3617.08, 267.108, 0.774, 300, 17, 0, 1, 0, 1, 0, 0, 0, '', 53788, 1, NULL), -- Skettis Surger
(75570, 21728, 530, 0, 0, 1, 1, 0, -3857.73, 3605, 253.114, 0.4822, 300, 17, 0, 1, 0, 1, 0, 0, 0, '', 52237, 1, NULL), -- Skettis Surger
(75573, 21728, 530, 0, 0, 1, 1, 0, -3849.77, 3584.62, 254.237, 1.6468, 300, 17, 0, 1, 0, 1, 0, 0, 0, '', 53788, 1, NULL), -- Skettis Surger
(75577, 21728, 530, 0, 0, 1, 1, 0, -3846.51, 3638.59, 269.347, 0.1876, 300, 17, 0, 1, 0, 1, 0, 0, 0, '', 53788, 1, NULL), -- Skettis Surger
(75578, 21728, 530, 0, 0, 1, 1, 0, -3826.58, 3617.61, 254.848, 0.3845, 300, 17, 0, 1, 0, 1, 0, 0, 0, '', 53788, 1, NULL), -- Skettis Surger
(75580, 21728, 530, 0, 0, 1, 1, 0, -3790.28, 3649.85, 262.576, 6.0526, 300, 17, 0, 1, 0, 1, 0, 0, 0, '', 53788, 1, NULL), -- Skettis Surger
(75583, 21728, 530, 0, 0, 1, 1, 0, -3788.81, 3585.18, 261.757, 1.4671, 300, 17, 0, 1, 0, 1, 0, 0, 0, '', 53788, 1, NULL), -- Skettis Surger
(75594, 21728, 530, 0, 0, 1, 1, 0, -3748.54, 3615.95, 250.808, 2.7103, 300, 17, 0, 1, 0, 1, 0, 0, 0, '', 53788, 1, NULL), -- Skettis Surger
(75595, 21728, 530, 0, 0, 1, 1, 0, -3718.81, 3583.12, 246.87, 5.9518, 300, 17, 0, 1, 0, 1, 0, 0, 0, '', 53622, 1, NULL), -- Skettis Surger
(75596, 21728, 530, 0, 0, 1, 1, 0, -3711.51, 3654.38, 264.238, 4.1811, 300, 17, 0, 1, 0, 1, 0, 0, 0, '', 53788, 1, NULL), -- Skettis Surger
(75598, 21728, 530, 0, 0, 1, 1, 0, -3699.6, 3590.5, 243.423, 2.1428, 300, 17, 0, 1, 0, 1, 0, 0, 0, '', 53788, 1, NULL), -- Skettis Surger
(75599, 21728, 530, 0, 0, 1, 1, 0, -3683.89, 3616.03, 252.897, 0.992, 300, 17, 0, 1, 0, 1, 0, 0, 0, '', 53622, 1, NULL), -- Skettis Surger
(75600, 21728, 530, 0, 0, 1, 1, 0, -3683.3, 3553.32, 249.826, 1.6982, 300, 17, 0, 1, 0, 1, 0, 0, 0, '', 53622, 1, NULL), -- Skettis Surger
(75601, 21728, 530, 0, 0, 1, 1, 0, -3650.03, 3549.74, 261.842, 0.8685, 300, 17, 0, 1, 0, 1, 0, 0, 0, '', 52237, 1, NULL), -- Skettis Surger
(75613, 21728, 530, 0, 0, 1, 1, 0, -3645.78, 3590.05, 261.96, 1.4657, 300, 17, 0, 1, 0, 1, 0, 0, 0, '', 53622, 1, NULL), -- Skettis Surger
(75614, 21728, 530, 0, 0, 1, 1, 0, -3566.48, 3555.92, 269.192, 3.0058, 300, 17, 0, 1, 0, 1, 0, 0, 0, '', 52237, 1, NULL), -- Skettis Surger
(75615, 21728, 530, 0, 0, 1, 1, 0, -3403.91, 3532.34, 266.899, 3.0793, 300, 17, 0, 1, 0, 1, 0, 0, 0, '', 52237, 1, NULL), -- Skettis Surger
(75616, 21728, 530, 0, 0, 1, 1, 0, -3314.35, 3592.06, 266.829, 4.0469, 300, 17, 0, 1, 0, 1, 0, 0, 0, '', 53788, 1, NULL), -- Skettis Surger
(75617, 21728, 530, 0, 0, 1, 1, 0, -3304.17, 3479.17, 266.939, 5.5093, 300, 17, 0, 1, 0, 1, 0, 0, 0, '', 53788, 1, NULL), -- Skettis Surger
(75618, 23219, 530, 0, 0, 1, 1, 0, -4296.23, 3019.46, 356.617, 4.0044, 300, 15, 0, 1, 0, 1, 0, 0, 0, '', 53622, 1, NULL), -- Blackwind Warp Chaser
(75619, 23219, 530, 0, 0, 1, 1, 0, -4275, 3175, 327.968, 2.9372, 300, 15, 0, 1, 0, 1, 0, 0, 0, '', 52237, 1, NULL), -- Blackwind Warp Chaser
(75620, 23219, 530, 0, 0, 1, 1, 0, -4256.79, 2977.17, 316.798, 4.1932, 300, 15, 0, 1, 0, 1, 0, 0, 0, '', 53622, 1, NULL), -- Blackwind Warp Chaser
(75621, 23219, 530, 0, 0, 1, 1, 0, -4240.66, 3345.27, 280.616, 1.3443, 300, 15, 0, 1, 0, 1, 0, 0, 0, '', 52237, 1, NULL), -- Blackwind Warp Chaser
(75622, 23219, 530, 0, 0, 1, 1, 0, -4208.89, 3286.1, 295.9, 0.6802, 300, 15, 0, 1, 0, 1, 0, 0, 0, '', 52237, 1, NULL), -- Blackwind Warp Chaser
(75623, 23219, 530, 0, 0, 1, 1, 0, -4178.24, 3342.97, 269.65, 0.9644, 300, 15, 0, 1, 0, 1, 0, 0, 0, '', 53622, 1, NULL), -- Blackwind Warp Chaser
(75624, 23219, 530, 0, 0, 1, 1, 0, -4117.42, 3517.29, 291.209, 2.6947, 300, 15, 0, 1, 0, 1, 0, 0, 0, '', 53622, 2, NULL), -- Blackwind Warp Chaser
(75625, 23219, 530, 0, 0, 1, 1, 0, -4078.8, 3556.69, 289.928, 1.197, 300, 15, 0, 1, 0, 1, 0, 0, 0, '', 53622, 1, NULL), -- Blackwind Warp Chaser
(75626, 23219, 530, 0, 0, 1, 1, 0, -4076.38, 3487, 288.401, 4.3323, 300, 15, 0, 1, 0, 1, 0, 0, 0, '', 53622, 2, NULL), -- Blackwind Warp Chaser
(75627, 23219, 530, 0, 0, 1, 1, 0, -4053.78, 3518.98, 283.012, 5.2771, 300, 15, 0, 1, 0, 1, 0, 0, 0, '', 53622, 1, NULL), -- Blackwind Warp Chaser
(75628, 23219, 530, 0, 0, 1, 1, 0, -4051.76, 3721.05, 311.747, 1.3502, 300, 15, 0, 1, 0, 1, 0, 0, 0, '', 53622, 1, NULL), -- Blackwind Warp Chaser
(75629, 23219, 530, 0, 0, 1, 1, 0, -4044.91, 3804.42, 316.467, 2.7883, 300, 15, 0, 1, 0, 1, 0, 0, 0, '', 53622, 1, NULL), -- Blackwind Warp Chaser
(75630, 23219, 530, 0, 0, 1, 1, 0, -4044.84, 3843.79, 311.987, 2.5544, 300, 15, 0, 1, 0, 1, 0, 0, 0, '', 52237, 1, NULL), -- Blackwind Warp Chaser
(75631, 23219, 530, 0, 0, 1, 1, 0, -4040.08, 3649.3, 293.76, 2.7908, 300, 15, 0, 1, 0, 1, 0, 0, 0, '', 53622, 1, NULL), -- Blackwind Warp Chaser
(75632, 23219, 530, 0, 0, 1, 1, 0, -4022.51, 3821.67, 300.861, 5.8195, 300, 15, 0, 1, 0, 1, 0, 0, 0, '', 53622, 1, NULL), -- Blackwind Warp Chaser
(75633, 23219, 530, 0, 0, 1, 1, 0, -4017.02, 3614.94, 284.942, 3.7112, 300, 15, 0, 1, 0, 1, 0, 0, 0, '', 53622, 1, NULL), -- Blackwind Warp Chaser
(75634, 23219, 530, 0, 0, 1, 1, 0, -3980.41, 3658.91, 283.656, 0.3341, 300, 15, 0, 1, 0, 1, 0, 0, 0, '', 53622, 1, NULL), -- Blackwind Warp Chaser
(75635, 23219, 530, 0, 0, 1, 1, 0, -3975.88, 3776.79, 296.013, 0.5985, 300, 15, 0, 1, 0, 1, 0, 0, 0, '', 53622, 1, NULL), -- Blackwind Warp Chaser
(75636, 23219, 530, 0, 0, 1, 1, 0, -3974.11, 3849.22, 313.029, 5.6662, 300, 15, 0, 1, 0, 1, 0, 0, 0, '', 52237, 1, NULL), -- Blackwind Warp Chaser
(75637, 23219, 530, 0, 0, 1, 1, 0, -3959.05, 3807.34, 299.248, 6.2633, 300, 15, 0, 1, 0, 1, 0, 0, 0, '', 53622, 1, NULL), -- Blackwind Warp Chaser
(75638, 23219, 530, 0, 0, 1, 1, 0, -3946.6, 3747.44, 295.016, 0.2455, 300, 15, 0, 1, 0, 1, 0, 0, 0, '', 53622, 1, NULL), -- Blackwind Warp Chaser
(75639, 23219, 530, 0, 0, 1, 1, 0, -3918.22, 3783.26, 291.501, 4.3246, 300, 15, 0, 1, 0, 1, 0, 0, 0, '', 53622, 1, NULL), -- Blackwind Warp Chaser
(75830, 23219, 530, 0, 0, 1, 1, 0, -3874.47, 3750.22, 292.025, 0.2849, 300, 15, 0, 1, 0, 1, 0, 0, 0, '', 53622, 1, NULL), -- Blackwind Warp Chaser
(75831, 23219, 530, 0, 0, 1, 1, 0, -3861.84, 2946.1, 354.988, 3.8606, 300, 15, 0, 1, 0, 1, 0, 0, 0, '', 53622, 1, NULL), -- Blackwind Warp Chaser
(75832, 23219, 530, 0, 0, 1, 1, 0, -3814.1, 2902.04, 384.391, 3.8433, 300, 15, 0, 1, 0, 1, 0, 0, 0, '', 52237, 1, NULL), -- Blackwind Warp Chaser
(75833, 23219, 530, 0, 0, 1, 1, 0, -3608.36, 3824.04, 249.584, 0.2104, 300, 15, 0, 1, 0, 1, 0, 0, 0, '', 53788, 1, NULL), -- Blackwind Warp Chaser
(75834, 23219, 530, 0, 0, 1, 1, 0, -3441.81, 3485.52, 283.775, 1.8661, 300, 15, 0, 1, 0, 1, 0, 0, 0, '', 53622, 1, NULL), -- Blackwind Warp Chaser
(75835, 23219, 530, 0, 0, 1, 1, 0, -3265.29, 3523.78, 323.554, 3.387, 300, 15, 0, 1, 0, 1, 0, 0, 0, '', 52237, 1, NULL), -- Blackwind Warp Chaser
(75836, 23219, 530, 0, 0, 1, 1, 0, -3259.7, 3487.17, 331.668, 3.918, 300, 15, 0, 1, 0, 1, 0, 0, 0, '', 53788, 1, NULL), -- Blackwind Warp Chaser
(75837, 23219, 530, 0, 0, 1, 1, 0, -3248.97, 3647.82, 247.602, 5.9669, 300, 15, 0, 1, 0, 1, 0, 0, 0, '', 53622, 2, NULL); -- Blackwind Warp Chaser

-- Talonsworn Forest-Rager: four patrols, one Rager each, walked node for node in 5 sniffs (3.4.3.52237, 4.4.0.55141,
-- 10.0.2.47213); two are loops, two go out and back. AC had three of them standing still, and a Rotting Forest-Rager
-- (22307, never sniffed here) by the long route, now its Talonsworn Forest-Rager.
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3763.23, `position_y`=3681.93, `position_z`=278.484, `orientation`=0, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=1 WHERE `id`=23029 AND `guid`=133904;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4104.81, `position_y`=3466.5, `position_z`=288.74, `orientation`=0, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=1 WHERE `id`=23029 AND `guid`=133905;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3974.28, `position_y`=3171.61, `position_z`=314.926, `orientation`=0, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=1 WHERE `id`=23029 AND `guid`=133906;
UPDATE `creature` SET `spawntimesecs`=300, `id`=23029, `position_x`=-3660.77, `position_y`=3406.13, `position_z`=279.736, `orientation`=0, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=1 WHERE `id`=22307 AND `guid`=133907; -- Talonsworn Forest-Rager (was Rotting Forest-Rager)
DELETE FROM `creature_addon` WHERE `guid` IN (133904, 133905, 133906, 133907);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(133904, 1339040, 0, 0, 0, 0, 0, ''),
(133905, 1339050, 0, 0, 0, 0, 0, ''),
(133906, 1339060, 0, 0, 0, 0, 0, ''),
(133907, 1339070, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id` IN (1339040, 1339050, 1339060, 1339070);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`, `smoothTransition`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(1339040, 1, -3763.2314, 3681.9329, 278.4845, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339040, 2, -3787.1792, 3673.231, 273.1423, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339040, 3, -3805.7002, 3674.625, 275.1015, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339040, 4, -3820.5386, 3676.619, 278.138, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339040, 5, -3836.7356, 3672.0308, 279.3422, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339040, 6, -3847.6355, 3660.096, 277.9118, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339040, 7, -3860.626, 3684.3074, 282.2921, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339040, 8, -3878.5178, 3707.26, 288.8733, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339040, 9, -3875.8794, 3729.6536, 292.3589, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339040, 10, -3858.23, 3750.7104, 284.8148, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339040, 11, -3832.4778, 3752.8958, 280.026, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339040, 12, -3816.5596, 3743.665, 279.6506, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339040, 13, -3793.4307, 3736.477, 281.0099, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339040, 14, -3764.6987, 3729.1423, 275.7398, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339040, 15, -3740.2505, 3721.6104, 279.2516, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339040, 16, -3747.8994, 3707.057, 278.1962, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339050, 1, -4104.812, 3466.502, 288.7402, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339050, 2, -4111.296, 3463.3264, 288.4685, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339050, 3, -4111.105, 3454.1282, 290.6418, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339050, 4, -4105.2393, 3439.6418, 294.7865, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339050, 5, -4116.511, 3445.287, 291.2625, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339050, 6, -4124.2427, 3462.4849, 285.3331, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339050, 7, -4123.3613, 3471.4177, 284.353, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339050, 8, -4119.372, 3482.8398, 284.0157, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339050, 9, -4114.492, 3490.1682, 284.9941, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339050, 10, -4107.6357, 3490.7253, 287.6631, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339050, 11, -4098.3906, 3494.964, 290.9387, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339050, 12, -4087.4436, 3497.5173, 289.0527, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339050, 13, -4075.2102, 3505.4182, 285.3683, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339050, 14, -4075.2727, 3523.6108, 286.7752, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339050, 15, -4050.8315, 3545.947, 279.0636, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339050, 16, -4044.957, 3526.0557, 279.0543, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339050, 17, -4046.246, 3514.126, 278.7895, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339050, 18, -4052.5999, 3508.6287, 281.7215, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339050, 19, -4050.3801, 3498.0022, 281.7927, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339050, 20, -4048.4543, 3483.6455, 281.6827, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339050, 21, -4044.1736, 3473.1638, 278.3059, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339050, 22, -4048.7695, 3461.002, 277.8698, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339050, 23, -4059.0989, 3459.5898, 279.9444, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339050, 24, -4065.0527, 3470.0078, 283.3538, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339050, 25, -4077.356, 3470.0938, 285.8, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339050, 26, -4091.5825, 3467.204, 288.1631, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 1, -3974.2812, 3171.6143, 314.9264, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 2, -3983.005, 3167.6003, 315.2781, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 3, -3994.2673, 3162.858, 314.4681, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 4, -4002.8494, 3159.2297, 312.9146, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 5, -4009.191, 3155.8176, 311.0853, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 6, -4020.0808, 3152.9426, 310.433, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 7, -4009.191, 3155.8176, 311.0853, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 8, -4002.8494, 3159.2297, 312.9146, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 9, -3994.2673, 3162.858, 314.4681, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 10, -3983.005, 3167.6003, 315.2781, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 11, -3974.2812, 3171.6143, 314.9264, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 12, -3959.7942, 3172.956, 315.5983, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 13, -3952.6519, 3169.2, 318.6616, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 14, -3942.9285, 3164.2825, 321.5184, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 15, -3932.7573, 3159.213, 322.9302, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 16, -3925.3164, 3153.9443, 324.9433, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 17, -3915.928, 3148.2297, 327.7116, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 18, -3906.4746, 3151.4814, 326.2473, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 19, -3899.0737, 3152.2227, 324.724, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 20, -3893.631, 3158.734, 324.7067, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 21, -3890.263, 3168.0496, 322.3998, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 22, -3896.059, 3178.552, 316.3988, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 23, -3900.7952, 3187.0994, 312.2808, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 24, -3904.5386, 3198.202, 312.1881, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 25, -3901.3381, 3206.9556, 311.2201, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 26, -3898.5713, 3216.9714, 307.3555, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 27, -3906.2065, 3225.9446, 303.346, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 28, -3898.5713, 3216.9714, 307.3555, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 29, -3901.3381, 3206.9556, 311.2201, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 30, -3904.5386, 3198.202, 312.1881, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 31, -3900.7952, 3187.0994, 312.2808, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 32, -3896.059, 3178.552, 316.3988, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 33, -3890.263, 3168.0496, 322.3998, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 34, -3893.631, 3158.734, 324.7067, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 35, -3899.0737, 3152.2227, 324.724, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 36, -3906.4746, 3151.4814, 326.2473, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 37, -3915.928, 3148.2297, 327.7116, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 38, -3925.3164, 3153.9443, 324.9433, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 39, -3932.7573, 3159.213, 322.9302, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 40, -3942.9285, 3164.2825, 321.5184, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 41, -3952.6519, 3169.2, 318.6616, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339060, 42, -3959.7942, 3172.956, 315.5983, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 1, -3660.7734, 3406.1252, 279.7359, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 2, -3667.871, 3404.4634, 278.1343, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 3, -3678.053, 3405.2805, 276.6374, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 4, -3685.4966, 3401.4539, 277.683, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 5, -3690.2444, 3393.602, 281.0622, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 6, -3696.2231, 3384.9846, 280.8211, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 7, -3708.1245, 3382.1633, 276.6953, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 8, -3720.112, 3372.9597, 276.126, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 9, -3730.162, 3381.4805, 272.3735, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 10, -3747.552, 3369.7297, 274.7652, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 11, -3760.789, 3365.1648, 273.9818, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 12, -3768.2063, 3356.0808, 275.4185, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 13, -3774.083, 3348.3381, 275.9141, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 14, -3780.8743, 3348.7898, 275.6941, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 15, -3790.4993, 3352.5264, 275.263, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 16, -3803.5034, 3354.9375, 275.519, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 17, -3809.409, 3360.9268, 273.9014, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 18, -3818.1204, 3364.9578, 275.313, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 19, -3827.4626, 3369.0793, 275.0353, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 20, -3831.0608, 3373.4685, 273.6012, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 21, -3840.586, 3371.8806, 273.8385, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 22, -3847.457, 3362.3481, 276.203, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 23, -3857.4485, 3357.6455, 274.6682, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 24, -3865.595, 3354.3684, 273.9031, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 25, -3873.3147, 3349.3, 273.6675, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 26, -3881.5496, 3341.0876, 272.2865, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 27, -3887.8223, 3332.0537, 274.4516, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 28, -3898.8967, 3331.77, 278.2835, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 29, -3911.2317, 3327.7666, 285.1615, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 30, -3920.9119, 3331.918, 284.8549, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 31, -3927.9922, 3337.3237, 281.4114, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 32, -3941.0305, 3339.7905, 280.0672, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 33, -3950.013, 3343.1704, 279.0152, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 34, -3957.4849, 3341.635, 280.7435, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 35, -3967.0847, 3337.234, 283.9685, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 36, -3979.037, 3336.086, 284.2416, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 37, -3989.7617, 3336.8083, 283.4137, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 38, -3985.8586, 3346.338, 276.1684, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 39, -3987.2996, 3356.511, 273.7131, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 40, -3993.3196, 3363.3508, 273.9065, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 41, -4021.2783, 3359.6106, 273.351, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 42, -4033.8823, 3357.4165, 278.695, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 43, -4046.7812, 3354.365, 283.4271, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 44, -4057.6953, 3355.8154, 285.2971, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 45, -4046.7812, 3354.365, 283.4271, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 46, -4033.8823, 3357.4165, 278.695, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 47, -4021.2783, 3359.6106, 273.351, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 48, -3993.3196, 3363.3508, 273.9065, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 49, -3987.2996, 3356.511, 273.7131, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 50, -3985.8586, 3346.338, 276.1684, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 51, -3989.7617, 3336.8083, 283.4137, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 52, -3979.037, 3336.086, 284.2416, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 53, -3967.0847, 3337.234, 283.9685, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 54, -3957.4849, 3341.635, 280.7435, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 55, -3950.013, 3343.1704, 279.0152, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 56, -3941.0305, 3339.7905, 280.0672, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 57, -3927.9922, 3337.3237, 281.4114, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 58, -3920.9119, 3331.918, 284.8549, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 59, -3911.2317, 3327.7666, 285.1615, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 60, -3898.8967, 3331.77, 278.2835, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 61, -3887.8223, 3332.0537, 274.4516, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 62, -3881.5496, 3341.0876, 272.2865, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 63, -3873.3147, 3349.3, 273.6675, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 64, -3865.595, 3354.3684, 273.9031, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 65, -3857.4485, 3357.6455, 274.6682, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 66, -3847.457, 3362.3481, 276.203, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 67, -3840.586, 3371.8806, 273.8385, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 68, -3831.0608, 3373.4685, 273.6012, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 69, -3827.4626, 3369.0793, 275.0353, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 70, -3818.1204, 3364.9578, 275.313, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 71, -3809.409, 3360.9268, 273.9014, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 72, -3803.5034, 3354.9375, 275.519, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 73, -3790.4993, 3352.5264, 275.263, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 74, -3780.8743, 3348.7898, 275.6941, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 75, -3774.083, 3348.3381, 275.9141, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 76, -3768.2063, 3356.0808, 275.4185, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 77, -3760.789, 3365.1648, 273.9818, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 78, -3747.552, 3369.7297, 274.7652, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 79, -3730.162, 3381.4805, 272.3735, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 80, -3720.112, 3372.9597, 276.126, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 81, -3708.1245, 3382.1633, 276.6953, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 82, -3696.2231, 3384.9846, 280.8211, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 83, -3690.2444, 3393.602, 281.0622, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 84, -3685.4966, 3401.4539, 277.683, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 85, -3678.053, 3405.2805, 276.6374, NULL, 0, 0, 0, 0, 0, 100, 0),
(1339070, 86, -3667.871, 3404.4634, 278.1343, NULL, 0, 0, 0, 0, 0, 100, 0);

-- Skettis: Monstrous Kaliri fly 18 loops, one each; the loops are the cyclic splines every sighting carries (seen
-- 100-440 times each in 3.4.3.52237, 4.4.0.55141, 10.0.2.47213). AC had them all, three twice, and 9 more on random
-- movement that no sniff shows: one row per loop, full sniffed loop as its path.
DELETE FROM `creature` WHERE `id`=23051 AND `guid` IN (79016, 83237, 86118, 86119, 86120, 86155, 132559, 132560, 132561, 132562, 132563, 132568);
DELETE FROM `creature_addon` WHERE `guid` IN (79016, 83237, 86118, 86119, 86120, 86155, 132559, 132560, 132561, 132562, 132563, 132568);
DELETE FROM `waypoint_data` WHERE `id` IN (790160, 832370, 861180, 861190, 861200, 861550, 1325590, 1325600, 1325610, 1325620, 1325630, 1325680);
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3712.47, `position_y`=3449.822, `position_z`=329.5283, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=1 WHERE `id`=23051 AND `guid`=79017;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3740.3542, `position_y`=3781.2002, `position_z`=318.1236, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=1 WHERE `id`=23051 AND `guid`=83238;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3617.6555, `position_y`=3768.4983, `position_z`=321.4414, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=1 WHERE `id`=23051 AND `guid`=86099;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3844.0105, `position_y`=3755.4524, `position_z`=357.5598, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=1 WHERE `id`=23051 AND `guid`=86115;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3876.8325, `position_y`=3314.5122, `position_z`=379.5609, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=1 WHERE `id`=23051 AND `guid`=86116;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3894.5637, `position_y`=3430.6545, `position_z`=372.4708, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=1 WHERE `id`=23051 AND `guid`=86117;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3884.442, `position_y`=3113.8308, `position_z`=389.185, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=1 WHERE `id`=23051 AND `guid`=86131;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4210.0513, `position_y`=3036.0354, `position_z`=359.2715, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=1 WHERE `id`=23051 AND `guid`=86133;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3852.5088, `position_y`=3183.0647, `position_z`=439.9884, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=1 WHERE `id`=23051 AND `guid`=132553;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4096.788, `position_y`=3033.9592, `position_z`=360.6063, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=1 WHERE `id`=23051 AND `guid`=132554;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3910.414, `position_y`=2965.875, `position_z`=390.4576, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=1 WHERE `id`=23051 AND `guid`=132555;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4209.917, `position_y`=3166.6692, `position_z`=345.6775, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=1 WHERE `id`=23051 AND `guid`=132556;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-4027.1272, `position_y`=3236.1365, `position_z`=342.3879, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=1 WHERE `id`=23051 AND `guid`=132557;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3889.631, `position_y`=3647.4463, `position_z`=379.841, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=1 WHERE `id`=23051 AND `guid`=132558;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3811.5754, `position_y`=3318.0117, `position_z`=350.0489, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=1 WHERE `id`=23051 AND `guid`=132564;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3700.1868, `position_y`=3268.5312, `position_z`=332.5694, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=1 WHERE `id`=23051 AND `guid`=132565;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3671.4944, `position_y`=3402.6416, `position_z`=324.4617, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=1 WHERE `id`=23051 AND `guid`=132566;
UPDATE `creature` SET `spawntimesecs`=300, `position_x`=-3800.0442, `position_y`=3329.8716, `position_z`=342.0992, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=52237, `CreateObject`=1 WHERE `id`=23051 AND `guid`=132567;
DELETE FROM `creature_addon` WHERE `guid` IN (79017, 83238, 86099, 86115, 86116, 86117, 86131, 86133, 132553, 132554, 132555, 132556, 132557, 132558, 132564, 132565, 132566, 132567);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(79017, 790170, 0, 0, 1, 0, 0, ''),
(83238, 832380, 0, 0, 1, 0, 0, ''),
(86099, 860990, 0, 0, 1, 0, 0, ''),
(86115, 861150, 0, 0, 1, 0, 0, ''),
(86116, 861160, 0, 0, 1, 0, 0, ''),
(86117, 861170, 0, 0, 1, 0, 0, ''),
(86131, 861310, 0, 0, 1, 0, 0, ''),
(86133, 861330, 0, 0, 1, 0, 0, ''),
(132553, 1325530, 0, 0, 1, 0, 0, ''),
(132554, 1325540, 0, 0, 1, 0, 0, ''),
(132555, 1325550, 0, 0, 1, 0, 0, ''),
(132556, 1325560, 0, 0, 1, 0, 0, ''),
(132557, 1325570, 0, 0, 1, 0, 0, ''),
(132558, 1325580, 0, 0, 1, 0, 0, ''),
(132564, 1325640, 0, 0, 1, 0, 0, ''),
(132565, 1325650, 0, 0, 1, 0, 0, ''),
(132566, 1325660, 0, 0, 1, 0, 0, ''),
(132567, 1325670, 0, 0, 1, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id` IN (790170, 832380, 860990, 861150, 861160, 861170, 861310, 861330, 1325530, 1325540, 1325550, 1325560, 1325570, 1325580, 1325640, 1325650, 1325660, 1325670);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`, `smoothTransition`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(790170, 1, -3712.47, 3449.822, 329.5283, NULL, 0, 0, 1, 1, 0, 100, 0),
(790170, 2, -3692.2126, 3483.7014, 323.2226, NULL, 0, 0, 1, 1, 0, 100, 0),
(790170, 3, -3682.3057, 3518.4473, 319.0838, NULL, 0, 0, 1, 1, 0, 100, 0),
(790170, 4, -3686.2917, 3551.1206, 328.0282, NULL, 0, 0, 1, 1, 0, 100, 0),
(790170, 5, -3704.019, 3589.462, 327.0838, NULL, 0, 0, 1, 1, 0, 100, 0),
(790170, 6, -3720.923, 3618.0938, 323.1671, NULL, 0, 0, 1, 1, 0, 100, 0),
(790170, 7, -3746.3313, 3629.9578, 322.9449, NULL, 0, 0, 1, 1, 0, 100, 0),
(790170, 8, -3788.0356, 3651.1992, 328.056, NULL, 0, 0, 1, 1, 0, 100, 0),
(790170, 9, -3829.1545, 3656.9514, 343.6671, NULL, 0, 0, 1, 1, 0, 100, 0),
(790170, 10, -3864.9128, 3641.72, 343.6671, NULL, 0, 0, 1, 1, 0, 100, 0),
(790170, 11, -3899.7668, 3634.007, 334.5004, NULL, 0, 0, 1, 1, 0, 100, 0),
(790170, 12, -3829.1545, 3656.9514, 343.6671, NULL, 0, 0, 1, 1, 0, 100, 0),
(790170, 13, -3864.9128, 3641.72, 343.6671, NULL, 0, 0, 1, 1, 0, 100, 0),
(790170, 14, -3899.7668, 3634.007, 334.5004, NULL, 0, 0, 1, 1, 0, 100, 0),
(790170, 15, -3932.7935, 3625.8047, 327.7228, NULL, 0, 0, 1, 1, 0, 100, 0),
(790170, 16, -3965.9844, 3604.831, 323.5561, NULL, 0, 0, 1, 1, 0, 100, 0),
(790170, 17, -3994.316, 3568.82, 324.0004, NULL, 0, 0, 1, 1, 0, 100, 0),
(790170, 18, -4020.8074, 3533.4736, 321.6671, NULL, 0, 0, 1, 1, 0, 100, 0),
(790170, 19, -4017.4602, 3505.427, 320.4171, NULL, 0, 0, 1, 1, 0, 100, 0),
(790170, 20, -4012.915, 3469.4365, 318.2504, NULL, 0, 0, 1, 1, 0, 100, 0),
(790170, 21, -4008.8286, 3443.473, 322.9727, NULL, 0, 0, 1, 1, 0, 100, 0),
(790170, 22, -3987.1277, 3409.8364, 320.0283, NULL, 0, 0, 1, 1, 0, 100, 0),
(790170, 23, -3956.549, 3381.6802, 323.2782, NULL, 0, 0, 1, 1, 0, 100, 0),
(790170, 24, -3917.0925, 3373.9038, 324.1949, NULL, 0, 0, 1, 1, 0, 100, 0),
(790170, 25, -3879.394, 3373.8633, 331.1393, NULL, 0, 0, 1, 1, 0, 100, 0),
(790170, 26, -3846.889, 3379.7812, 335.556, NULL, 0, 0, 1, 1, 0, 100, 0),
(790170, 27, -3815.7205, 3383.2422, 336.0282, NULL, 0, 0, 1, 1, 0, 100, 0),
(790170, 28, -3785.7297, 3387.1472, 333.7504, NULL, 0, 0, 1, 1, 0, 100, 0),
(790170, 29, -3745.971, 3412.0447, 331.7226, NULL, 0, 0, 1, 1, 0, 100, 0),
(832380, 1, -3740.3542, 3781.2002, 318.1236, NULL, 0, 0, 1, 1, 0, 100, 0),
(832380, 2, -3733.342, 3800.063, 318.5958, NULL, 0, 0, 1, 1, 0, 100, 0),
(832380, 3, -3700.761, 3815.8376, 314.9293, NULL, 0, 0, 1, 1, 0, 100, 0),
(832380, 4, -3684.3767, 3790.5703, 311.3183, NULL, 0, 0, 1, 1, 0, 100, 0),
(832380, 5, -3673.302, 3755.679, 311.3183, NULL, 0, 0, 1, 1, 0, 100, 0),
(832380, 6, -3654.1907, 3733.8577, 317.7345, NULL, 0, 0, 1, 1, 0, 100, 0),
(832380, 7, -3627.8118, 3735.3486, 321.0125, NULL, 0, 0, 1, 1, 0, 100, 0),
(832380, 8, -3620.8496, 3745.5078, 318.7352, NULL, 0, 0, 1, 1, 0, 100, 0),
(832380, 9, -3616.7327, 3766.586, 318.0404, NULL, 0, 0, 1, 1, 0, 100, 0),
(832380, 10, -3633.5903, 3782.2996, 318.1792, NULL, 0, 0, 1, 1, 0, 100, 0),
(832380, 11, -3666.7065, 3773.2153, 316.2348, NULL, 0, 0, 1, 1, 0, 100, 0),
(832380, 12, -3699.9675, 3755.0056, 317.2626, NULL, 0, 0, 1, 1, 0, 100, 0),
(832380, 13, -3728.8308, 3766.5737, 318.1514, NULL, 0, 0, 1, 1, 0, 100, 0),
(832380, 14, -3740.3542, 3781.2002, 318.1236, NULL, 0, 0, 1, 1, 0, 100, 0),
(832380, 15, -3733.342, 3800.063, 318.5958, NULL, 0, 0, 1, 1, 0, 100, 0),
(832380, 16, -3700.761, 3815.8376, 314.9293, NULL, 0, 0, 1, 1, 0, 100, 0),
(860990, 1, -3617.6555, 3768.4983, 321.4414, NULL, 0, 0, 1, 1, 0, 100, 0),
(860990, 2, -3621.7197, 3753.039, 319.025, NULL, 0, 0, 1, 1, 0, 100, 0),
(860990, 3, -3619.6443, 3727.8972, 309.8305, NULL, 0, 0, 1, 1, 0, 100, 0),
(860990, 4, -3627.1782, 3681.1077, 308.5527, NULL, 0, 0, 1, 1, 0, 100, 0),
(860990, 5, -3656.429, 3650.5986, 304.2195, NULL, 0, 0, 1, 1, 0, 100, 0),
(860990, 6, -3696.8079, 3638.6028, 303.0528, NULL, 0, 0, 1, 1, 0, 100, 0),
(860990, 7, -3734.566, 3654.5972, 302.6361, NULL, 0, 0, 1, 1, 0, 100, 0),
(860990, 8, -3766.3237, 3670.2449, 301.1362, NULL, 0, 0, 1, 1, 0, 100, 0),
(860990, 9, -3799.2708, 3684.9714, 303.1361, NULL, 0, 0, 1, 1, 0, 100, 0),
(860990, 10, -3832.1497, 3705.0305, 308.4691, NULL, 0, 0, 1, 1, 0, 100, 0),
(860990, 11, -3868.131, 3721.5022, 318.4415, NULL, 0, 0, 1, 1, 0, 100, 0),
(860990, 12, -3909.399, 3735.2136, 328.5527, NULL, 0, 0, 1, 1, 0, 100, 0),
(860990, 13, -3931.0173, 3766.7844, 334.3581, NULL, 0, 0, 1, 1, 0, 100, 0),
(860990, 14, -3917.4453, 3807.967, 334.4695, NULL, 0, 0, 1, 1, 0, 100, 0),
(860990, 15, -3890.3489, 3823.759, 327.1639, NULL, 0, 0, 1, 1, 0, 100, 0),
(860990, 16, -3849.0295, 3819.391, 319.025, NULL, 0, 0, 1, 1, 0, 100, 0),
(860990, 17, -3822.9983, 3781.3064, 314.3583, NULL, 0, 0, 1, 1, 0, 100, 0),
(860990, 18, -3792.1914, 3762.2996, 302.9972, NULL, 0, 0, 1, 1, 0, 100, 0),
(860990, 19, -3753.8801, 3777.9207, 300.1916, NULL, 0, 0, 1, 1, 0, 100, 0),
(860990, 20, -3738.559, 3813.2969, 304.1084, NULL, 0, 0, 1, 1, 0, 100, 0),
(860990, 21, -3707.9124, 3826.754, 304.9972, NULL, 0, 0, 1, 1, 0, 100, 0),
(860990, 22, -3666.7595, 3801.158, 304.9972, NULL, 0, 0, 1, 1, 0, 100, 0),
(860990, 23, -3632.4524, 3787.691, 313.8025, NULL, 0, 0, 1, 1, 0, 100, 0),
(860990, 24, -3617.6555, 3768.4983, 321.4414, NULL, 0, 0, 1, 1, 0, 100, 0),
(860990, 25, -3621.7197, 3753.039, 319.025, NULL, 0, 0, 1, 1, 0, 100, 0),
(860990, 26, -3619.6443, 3727.8972, 309.8305, NULL, 0, 0, 1, 1, 0, 100, 0),
(861150, 1, -3844.0105, 3755.4524, 357.5598, NULL, 0, 0, 1, 1, 0, 100, 0),
(861150, 2, -3852.5105, 3791.2153, 357.0599, NULL, 0, 0, 1, 1, 0, 100, 0),
(861150, 3, -3890.182, 3810.264, 355.8931, NULL, 0, 0, 1, 1, 0, 100, 0),
(861150, 4, -3916.0916, 3784.6848, 356.5043, NULL, 0, 0, 1, 1, 0, 100, 0),
(861150, 5, -3923.033, 3754.5312, 361.0602, NULL, 0, 0, 1, 1, 0, 100, 0),
(861150, 6, -3922.9949, 3732.8254, 381.1874, NULL, 0, 0, 1, 1, 0, 100, 0),
(861150, 7, -3926.192, 3702.9917, 389.9645, NULL, 0, 0, 1, 1, 0, 100, 0),
(861150, 8, -3920.2166, 3670.4075, 389.9645, NULL, 0, 0, 1, 1, 0, 100, 0),
(861150, 9, -3902.139, 3652.9275, 389.9645, NULL, 0, 0, 1, 1, 0, 100, 0),
(861150, 10, -3881.5764, 3654.323, 389.9645, NULL, 0, 0, 1, 1, 0, 100, 0),
(861150, 11, -3865.4045, 3672.89, 381.4647, NULL, 0, 0, 1, 1, 0, 100, 0),
(861150, 12, -3862.587, 3682.567, 374.4212, NULL, 0, 0, 1, 1, 0, 100, 0),
(861150, 13, -3856.3352, 3709.2214, 366.0322, NULL, 0, 0, 1, 1, 0, 100, 0),
(861150, 14, -3865.4045, 3672.89, 381.4647, NULL, 0, 0, 1, 1, 0, 100, 0),
(861150, 15, -3862.587, 3682.567, 374.4212, NULL, 0, 0, 1, 1, 0, 100, 0),
(861150, 16, -3856.3352, 3709.2214, 366.0322, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 1, -3876.8325, 3314.5122, 379.5609, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 2, -3886.0972, 3325.3447, 379.5609, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 3, -3911.6719, 3347.092, 379.5609, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 4, -3945.02, 3355.806, 379.5609, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 5, -3972.9722, 3374.654, 379.5609, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 6, -4009.4973, 3393.9702, 379.5609, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 7, -4038.9954, 3394.8333, 379.5609, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 8, -4084.3057, 3383.7795, 379.5609, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 9, -4114.1006, 3348.3977, 379.5609, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 10, -4121.2847, 3315.1567, 359.6998, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 11, -4133.357, 3269.0408, 344.6721, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 12, -4127.8716, 3224.2434, 336.2553, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 13, -4088.5798, 3195.2961, 338.8943, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 14, -4068.468, 3153.2822, 341.0054, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 15, -4070.8762, 3123.4539, 342.6997, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 16, -4097.5913, 3094.7825, 347.3388, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 17, -4122.6655, 3063.9814, 348.1721, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 18, -4162.2764, 3056.1965, 349.6165, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 19, -4202.113, 3083.117, 358.5054, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 20, -4214.2163, 3116.8706, 357.2553, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 21, -4193.5986, 3157.3235, 355.2832, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 22, -4155.592, 3185.0447, 347.0332, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 23, -4111.882, 3181.4912, 345.0886, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 24, -4062.1042, 3179.6804, 348.9498, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 25, -4020.4268, 3179.234, 361.4219, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 26, -3982.6724, 3180.415, 363.0051, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 27, -3951.4475, 3159.8662, 363.561, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 28, -3937.524, 3133.349, 370.6444, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 29, -3931.4036, 3105.327, 376.0884, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 30, -3933.8733, 3066.7444, 379.5609, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 31, -3940.6401, 3017.5972, 385.5607, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 32, -3962.612, 2986.6416, 387.3109, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 33, -3987.704, 2976.624, 388.1721, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 34, -4028.2278, 2974.0737, 379.5609, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 35, -4068.6428, 2997.1016, 369.2554, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 36, -4093.0396, 3026.7693, 367.2279, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 37, -4081.1506, 3058.7651, 357.4498, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 38, -4050.2505, 3086.566, 362.8388, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 39, -4009.6284, 3109.6907, 361.9498, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 40, -3962.2588, 3115.2002, 365.2273, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 41, -3931.4932, 3131.2705, 371.1159, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 42, -3901.8525, 3157.1682, 376.1166, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 43, -3882.1948, 3190.0078, 374.5609, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 44, -3907.507, 3233.7036, 369.0056, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 45, -3930.3862, 3264.1172, 346.8111, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 46, -3952.398, 3305.4119, 329.4775, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 47, -3949.9583, 3344.6558, 317.033, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 48, -3933.0776, 3390.3, 316.2833, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 49, -3924.3838, 3438.506, 320.0887, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 50, -3908.001, 3480.083, 321.7832, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 51, -3881.9636, 3513.231, 323.2551, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 52, -3844.5908, 3536.4724, 335.8942, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 53, -3822.9045, 3535.2656, 339.8388, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 54, -3792.5442, 3507.1223, 337.1997, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 55, -3760.572, 3487.1323, 351.5052, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 56, -3744.966, 3453.4185, 364.5888, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 57, -3744.3074, 3416.9082, 367.4221, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 58, -3740.5361, 3368.5356, 367.0886, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 59, -3734.6223, 3321.6226, 379.5609, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 60, -3731.1807, 3282.1707, 379.5609, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 61, -3694.8767, 3249.842, 379.5609, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 62, -3655.5647, 3261.0627, 379.5609, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 63, -3641.6692, 3284.0708, 367.7832, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 64, -3641.303, 3315.5872, 364.9221, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 65, -3654.0305, 3343.666, 369.4221, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 66, -3680.5508, 3352.7625, 367.6166, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 67, -3714.7935, 3358.927, 363.9776, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 68, -3753.7917, 3357.8345, 379.5609, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 69, -3787.5127, 3323.2922, 384.7554, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 70, -3817.4023, 3284.4482, 390.9497, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 71, -3855.8047, 3289.496, 379.5609, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 72, -3876.8325, 3314.5122, 379.5609, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 73, -3886.0972, 3325.3447, 379.5609, NULL, 0, 0, 1, 1, 0, 100, 0),
(861160, 74, -3911.6719, 3347.092, 379.5609, NULL, 0, 0, 1, 1, 0, 100, 0),
(861170, 1, -3894.5637, 3430.6545, 372.4708, NULL, 0, 0, 1, 1, 0, 100, 0),
(861170, 2, -3857.2102, 3447.0312, 372.4708, NULL, 0, 0, 1, 1, 0, 100, 0),
(861170, 3, -3823.5603, 3471.6929, 372.4708, NULL, 0, 0, 1, 1, 0, 100, 0),
(861170, 4, -3784.5986, 3479.697, 372.4708, NULL, 0, 0, 1, 1, 0, 100, 0),
(861170, 5, -3742.4683, 3490.9468, 353.0265, NULL, 0, 0, 1, 1, 0, 100, 0),
(861170, 6, -3709.6519, 3520.5015, 345.0263, NULL, 0, 0, 1, 1, 0, 100, 0),
(861170, 7, -3664.3142, 3533.1711, 334.0263, NULL, 0, 0, 1, 1, 0, 100, 0),
(861170, 8, -3616.4033, 3539.1155, 323.9706, NULL, 0, 0, 1, 1, 0, 100, 0),
(861170, 9, -3582.8013, 3553.0276, 325.193, NULL, 0, 0, 1, 1, 0, 100, 0),
(861170, 10, -3589.008, 3587.3877, 329.9429, NULL, 0, 0, 1, 1, 0, 100, 0),
(861170, 11, -3636.932, 3603.025, 325.1376, NULL, 0, 0, 1, 1, 0, 100, 0),
(861170, 12, -3663.247, 3624.5256, 321.2208, NULL, 0, 0, 1, 1, 0, 100, 0),
(861170, 13, -3704.0708, 3625.825, 318.6652, NULL, 0, 0, 1, 1, 0, 100, 0),
(861170, 14, -3750.566, 3629.2808, 322.7488, NULL, 0, 0, 1, 1, 0, 100, 0),
(861170, 15, -3785.251, 3646.6294, 322.5265, NULL, 0, 0, 1, 1, 0, 100, 0),
(861170, 16, -3821.6477, 3660.9917, 332.4431, NULL, 0, 0, 1, 1, 0, 100, 0),
(861170, 17, -3844.5234, 3693.0815, 347.1931, NULL, 0, 0, 1, 1, 0, 100, 0),
(861170, 18, -3873.0786, 3712.2249, 349.1932, NULL, 0, 0, 1, 1, 0, 100, 0),
(861170, 19, -3903.7244, 3693.4475, 347.4153, NULL, 0, 0, 1, 1, 0, 100, 0),
(861170, 20, -3935.1846, 3680.1497, 346.9429, NULL, 0, 0, 1, 1, 0, 100, 0),
(861170, 21, -3961.5305, 3655.501, 345.2486, NULL, 0, 0, 1, 1, 0, 100, 0),
(861170, 22, -3966.7903, 3606.8218, 348.2763, NULL, 0, 0, 1, 1, 0, 100, 0),
(861170, 23, -3973.9292, 3571.161, 341.0261, NULL, 0, 0, 1, 1, 0, 100, 0),
(861170, 24, -3980.9001, 3522.6052, 335.8875, NULL, 0, 0, 1, 1, 0, 100, 0),
(861170, 25, -4004.4514, 3487.919, 317.9431, NULL, 0, 0, 1, 1, 0, 100, 0),
(861170, 26, -4001.448, 3441.2612, 334.3042, NULL, 0, 0, 1, 1, 0, 100, 0),
(861170, 27, -3966.929, 3406.7505, 330.5819, NULL, 0, 0, 1, 1, 0, 100, 0),
(861170, 28, -3922.9927, 3396.193, 351.9707, NULL, 0, 0, 1, 1, 0, 100, 0),
(861170, 29, -3894.5637, 3430.6545, 372.4708, NULL, 0, 0, 1, 1, 0, 100, 0),
(861170, 30, -3857.2102, 3447.0312, 372.4708, NULL, 0, 0, 1, 1, 0, 100, 0),
(861170, 31, -3823.5603, 3471.6929, 372.4708, NULL, 0, 0, 1, 1, 0, 100, 0),
(861310, 1, -3884.442, 3113.8308, 389.185, NULL, 0, 0, 1, 1, 0, 100, 0),
(861310, 2, -3869.6768, 3093.1807, 392.3522, NULL, 0, 0, 1, 1, 0, 100, 0),
(861310, 3, -3876.1145, 3078.7996, 392.3522, NULL, 0, 0, 1, 1, 0, 100, 0),
(861310, 4, -3900.006, 3066.9216, 392.3522, NULL, 0, 0, 1, 1, 0, 100, 0),
(861310, 5, -3934.1719, 3083.2773, 392.3522, NULL, 0, 0, 1, 1, 0, 100, 0),
(861310, 6, -3942.4055, 3108.2751, 392.3522, NULL, 0, 0, 1, 1, 0, 100, 0),
(861310, 7, -3955.4058, 3132.5908, 392.3522, NULL, 0, 0, 1, 1, 0, 100, 0),
(861310, 8, -3983.802, 3151.2354, 400.1577, NULL, 0, 0, 1, 1, 0, 100, 0),
(861310, 9, -4018.7292, 3167.3176, 408.8244, NULL, 0, 0, 1, 1, 0, 100, 0),
(861310, 10, -4048.5596, 3146.7227, 397.5466, NULL, 0, 0, 1, 1, 0, 100, 0),
(861310, 11, -4034.6775, 3106.9165, 375.3246, NULL, 0, 0, 1, 1, 0, 100, 0),
(861310, 12, -3999.2415, 3105.8196, 364.3524, NULL, 0, 0, 1, 1, 0, 100, 0),
(861310, 13, -3976.7432, 3112.3213, 363.4634, NULL, 0, 0, 1, 1, 0, 100, 0),
(861310, 14, -3934.0647, 3120.9983, 373.4079, NULL, 0, 0, 1, 1, 0, 100, 0),
(861310, 15, -3904.7627, 3124.4395, 386.7683, NULL, 0, 0, 1, 1, 0, 100, 0),
(861310, 16, -3884.442, 3113.8308, 389.185, NULL, 0, 0, 1, 1, 0, 100, 0),
(861310, 17, -3869.6768, 3093.1807, 392.3522, NULL, 0, 0, 1, 1, 0, 100, 0),
(861310, 18, -3876.1145, 3078.7996, 392.3522, NULL, 0, 0, 1, 1, 0, 100, 0),
(861330, 1, -4210.0513, 3036.0354, 359.2715, NULL, 0, 0, 1, 1, 0, 100, 0),
(861330, 2, -4197.814, 3024.3442, 366.188, NULL, 0, 0, 1, 1, 0, 100, 0),
(861330, 3, -4166.5947, 3015.7825, 353.327, NULL, 0, 0, 1, 1, 0, 100, 0),
(861330, 4, -4119.3613, 3000.5183, 350.3828, NULL, 0, 0, 1, 1, 0, 100, 0),
(861330, 5, -4078.058, 3004.4368, 346.7713, NULL, 0, 0, 1, 1, 0, 100, 0),
(861330, 6, -4047.4949, 3033.212, 346.8269, NULL, 0, 0, 1, 1, 0, 100, 0),
(861330, 7, -4037.8174, 3075.9368, 350.9382, NULL, 0, 0, 1, 1, 0, 100, 0),
(861330, 8, -4037.2214, 3122.4866, 345.1326, NULL, 0, 0, 1, 1, 0, 100, 0),
(861330, 9, -4020.0774, 3150.2566, 329.8825, NULL, 0, 0, 1, 1, 0, 100, 0),
(861330, 10, -3983.1143, 3172.777, 330.1326, NULL, 0, 0, 1, 1, 0, 100, 0),
(861330, 11, -3945.7964, 3163.1763, 338.4935, NULL, 0, 0, 1, 1, 0, 100, 0),
(861330, 12, -3906.7444, 3138.0767, 347.0494, NULL, 0, 0, 1, 1, 0, 100, 0),
(861330, 13, -3872.9583, 3116.5413, 357.4377, NULL, 0, 0, 1, 1, 0, 100, 0),
(861330, 14, -3857.6948, 3086.127, 367.6046, NULL, 0, 0, 1, 1, 0, 100, 0),
(861330, 15, -3866.0508, 3043.0464, 372.1045, NULL, 0, 0, 1, 1, 0, 100, 0),
(861330, 16, -3902.3628, 3025, 374.7159, NULL, 0, 0, 1, 1, 0, 100, 0),
(861330, 17, -3939.9446, 3047.4375, 368.138, NULL, 0, 0, 1, 1, 0, 100, 0),
(861330, 18, -3976.8103, 3075.321, 357.9659, NULL, 0, 0, 1, 1, 0, 100, 0),
(861330, 19, -4015.7805, 3101.057, 352.3272, NULL, 0, 0, 1, 1, 0, 100, 0),
(861330, 20, -4057.2974, 3120.64, 344.0215, NULL, 0, 0, 1, 1, 0, 100, 0),
(861330, 21, -3976.8103, 3075.321, 357.9659, NULL, 0, 0, 1, 1, 0, 100, 0),
(861330, 22, -4015.7805, 3101.057, 352.3272, NULL, 0, 0, 1, 1, 0, 100, 0),
(861330, 23, -4057.2974, 3120.64, 344.0215, NULL, 0, 0, 1, 1, 0, 100, 0),
(861330, 24, -4093.9922, 3151.9001, 340.0216, NULL, 0, 0, 1, 1, 0, 100, 0),
(861330, 25, -4133.5747, 3148.6257, 338.077, NULL, 0, 0, 1, 1, 0, 100, 0),
(861330, 26, -4161.5957, 3113.0127, 348.6326, NULL, 0, 0, 1, 1, 0, 100, 0),
(861330, 27, -4193.336, 3081.1177, 359.2715, NULL, 0, 0, 1, 1, 0, 100, 0),
(861330, 28, -4214.1055, 3060.0781, 359.2715, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 1, -3852.5088, 3183.0647, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 2, -3819.889, 3184.7944, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 3, -3782.8274, 3181.2283, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 4, -3750.342, 3182.0723, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 5, -3722.763, 3185.5825, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 6, -3686.632, 3214.135, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 7, -3656.3862, 3240.6462, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 8, -3626.8508, 3272.0518, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 9, -3614.4475, 3315.6545, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 10, -3607.8894, 3352.5586, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 11, -3585.0325, 3376.6025, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 12, -3587.3894, 3402.6633, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 13, -3579.0435, 3438.1174, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 14, -3548.2283, 3462.3137, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 15, -3537.5222, 3491.375, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 16, -3536.8162, 3529.879, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 17, -3531.7812, 3565.558, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 18, -3534.7327, 3584.7612, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 19, -3540.309, 3619.0327, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 20, -3548.71, 3648.0657, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 21, -3565.1497, 3673.7886, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 22, -3593.257, 3700.0322, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 23, -3629.6086, 3714.8337, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 24, -3663.7297, 3728.1985, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 25, -3699.5837, 3743.1614, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 26, -3730.9714, 3758.693, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 27, -3763.8047, 3764.0513, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 28, -3796.2773, 3791.5999, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 29, -3829.4753, 3825.9102, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 30, -3866.1946, 3833.0574, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 31, -3901.688, 3854.4758, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 32, -3932.7673, 3851.7114, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 33, -3965.5852, 3849.4236, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 34, -3999.3152, 3846.842, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 35, -4034.0474, 3812.7817, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 36, -4053.7544, 3766.9084, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 37, -4065.977, 3737.4019, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 38, -4097.885, 3717.7812, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 39, -4102.0425, 3680.5112, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 40, -4104.0356, 3655.9263, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 41, -4101.1685, 3611.5854, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 42, -4102.0425, 3680.5112, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 43, -4104.0356, 3655.9263, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 44, -4101.1685, 3611.5854, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 45, -4102.894, 3574.5906, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 46, -4103.9316, 3544.9133, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 47, -4104.6416, 3508.5637, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 48, -4106.7993, 3476.6653, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 49, -4107.433, 3449.9324, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 50, -4104.114, 3418.2432, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 51, -4089.375, 3376.1914, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 52, -4055.6233, 3343.7166, 446.405, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 53, -4011.4688, 3341.7883, 448.6551, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 54, -3975.7405, 3311.9739, 446.6827, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 55, -3947.2769, 3278.1584, 445.544, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 56, -3922.8142, 3246.1511, 445.7939, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325530, 57, -3886.3572, 3212.919, 439.9884, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325540, 1, -4096.788, 3033.9592, 360.6063, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325540, 2, -4104.214, 3041.3003, 359.5785, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325540, 3, -4125.4443, 3052.2583, 358.9676, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325540, 4, -4159.8667, 3033.5964, 358.9952, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325540, 5, -4186.089, 3020.4775, 361.6621, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325540, 6, -4216.2056, 3023.308, 363.8009, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325540, 7, -4219.7764, 3049.4814, 362.9398, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325540, 8, -4205.9736, 3076.2058, 360.8285, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325540, 9, -4175.602, 3071.7048, 356.4121, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325540, 10, -4149.558, 3039.067, 356.4121, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325540, 11, -4139.2866, 3016.1675, 361.1343, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325540, 12, -4115.8345, 2995.427, 363.3842, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325540, 13, -4089.4558, 3009.014, 362.3842, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325540, 14, -4096.788, 3033.9592, 360.6063, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325540, 15, -4104.214, 3041.3003, 359.5785, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325540, 16, -4125.4443, 3052.2583, 358.9676, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325550, 1, -3910.414, 2965.875, 390.4576, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325550, 2, -3933.329, 2966.6572, 390.4576, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325550, 3, -3954.8845, 2975.5017, 382.291, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325550, 4, -3963.7878, 3013.6497, 381.3741, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325550, 5, -3969.197, 3050.4192, 375.9853, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325550, 6, -3984.5305, 3090.1692, 372.0131, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325550, 7, -3972.2769, 3135.5713, 367.5407, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325550, 8, -3947.4739, 3178.7573, 362.0131, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325550, 9, -3930.6536, 3222.3308, 346.0131, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325550, 10, -3944.7852, 3269.0537, 337.6526, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325550, 11, -3988.9844, 3283.4736, 328.0133, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325550, 12, -4020.1746, 3305.8313, 332.7634, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325550, 13, -4043.3042, 3338.7832, 339.9855, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325550, 14, -4076.572, 3375.8723, 343.2631, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325550, 15, -4067.4849, 3424.7651, 347.1243, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325550, 16, -4037.804, 3458.1733, 351.3187, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325550, 17, -4007.092, 3452.119, 341.2909, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325550, 18, -3969.2048, 3437.3425, 334.1797, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325550, 19, -3932.2026, 3431.731, 332.2077, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325550, 20, -3896.7048, 3421.3809, 327.7629, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325550, 21, -3871.9783, 3389.38, 331.041, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325550, 22, -3827.5134, 3390.7136, 332.2075, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325550, 23, -3802.1284, 3368.3062, 336.7633, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325550, 24, -3790.8743, 3332.89, 343.6242, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325550, 25, -3808.6558, 3291.0442, 352.0409, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325550, 26, -3817.2053, 3243.8745, 361.9853, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325550, 27, -3841.9236, 3206.9128, 365.2077, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325550, 28, -3882.9058, 3183.5642, 363.3185, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325550, 29, -3903.0447, 3142.097, 372.3742, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325550, 30, -3883.6936, 3111.3386, 382.5131, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325550, 31, -3856.8567, 3076.7336, 390.4576, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325550, 32, -3843.808, 3035.8784, 390.4576, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325550, 33, -3833.4524, 2993.256, 390.4576, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325550, 34, -3866.5447, 2965.673, 390.4576, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325550, 35, -3910.414, 2965.875, 390.4576, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325550, 36, -3933.329, 2966.6572, 390.4576, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325550, 37, -3954.8845, 2975.5017, 382.291, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 1, -4209.917, 3166.6692, 345.6775, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 2, -4209.917, 3166.6692, 345.6775, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 3, -4205.362, 3152.6692, 344.1049, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 4, -4209.917, 3166.6694, 345.6775, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 5, -4214.472, 3180.6697, 347.2502, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 6, -4216.5195, 3213.6128, 345.6775, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 7, -4208.682, 3255.8838, 339.0109, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 8, -4189.062, 3300.134, 333.0109, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 9, -4149.259, 3324.875, 328.7887, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 10, -4108.4517, 3350.1702, 317.0111, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 11, -4062.7024, 3352.5784, 312.0665, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 12, -4014.4302, 3348.0264, 315.1498, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 13, -3986.4758, 3375.0217, 322.1496, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 14, -3981.1458, 3423.131, 315.4276, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 15, -3984.3542, 3463.0352, 318.9552, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 16, -3983.0764, 3512.5579, 312.2053, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 17, -3966.2126, 3540.754, 323.3442, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 18, -3949.2205, 3584.559, 328.372, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 19, -3913.3264, 3616.7148, 336.8163, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 20, -3871.808, 3634.6821, 342.0666, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 21, -3845.7097, 3666.634, 355.0107, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 22, -3851.3772, 3715.548, 351.7607, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 23, -3821.307, 3750.763, 351.2052, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 24, -3795.1614, 3777.2275, 334.7328, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 25, -3763.429, 3800.6936, 324.3996, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 26, -3732.7288, 3778.1016, 316.9553, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 27, -3699.6624, 3753.8152, 315.6498, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 28, -3666.8699, 3741.2087, 315.7606, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 29, -3634.0603, 3717.2366, 319.2329, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 30, -3613.8672, 3678.0837, 317.8165, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 31, -3622.779, 3632.8213, 322.9277, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 32, -3620.3682, 3590.8164, 320.0942, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 33, -3625.737, 3551.3528, 323.3442, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 34, -3626.56, 3508.4846, 328.3718, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 35, -3652.823, 3477.1516, 326.2332, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 36, -3666.5774, 3433.208, 328.844, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 37, -3689.0156, 3394.7292, 323.7608, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 38, -3716.7378, 3363.7483, 323.2885, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 39, -3754.879, 3351.8333, 332.8161, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 40, -3795.4224, 3366.0596, 336.0938, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 41, -3839.274, 3378.5244, 336.0663, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 42, -3884.2722, 3383.1204, 331.8162, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 43, -3923.9739, 3361.8455, 329.0664, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 44, -3938.3672, 3317.121, 327.0108, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 45, -3970.304, 3289.182, 332.4276, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 46, -4001.4905, 3255.9995, 340.0942, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 47, -4017.2808, 3211.0535, 337.8997, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 48, -4034.0012, 3168.0508, 336.3162, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 49, -4060.1094, 3128.3042, 345.6775, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 50, -4089.7883, 3088.0674, 342.4553, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 51, -4130.0205, 3082.1636, 339.8998, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 52, -4161.369, 3103.5603, 345.6775, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325560, 53, -4187.5063, 3137.097, 345.6775, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325570, 1, -4027.1272, 3236.1365, 342.3879, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325570, 2, -4050.7249, 3247.826, 342.3879, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325570, 3, -4074.9016, 3254.4016, 339.4433, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325570, 4, -4099.817, 3279.1775, 340.388, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325570, 5, -4090.6138, 3300.5657, 342.3879, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325570, 6, -4066.2556, 3322.0337, 342.3879, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325570, 7, -4034.0251, 3315.976, 340.4436, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325570, 8, -4000.6267, 3300.2336, 340.7216, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325570, 9, -3962.7786, 3269.4583, 342.3879, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325570, 10, -3932.3325, 3241.6914, 350.6101, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325570, 11, -3924.3838, 3214.1946, 353.11, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325570, 12, -3948.1885, 3192.5747, 352.915, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325570, 13, -3975.5022, 3190.0981, 351.4991, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325570, 14, -4002.0798, 3217.6836, 348.0821, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325570, 15, -4027.1272, 3236.1365, 342.3879, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325570, 16, -4050.7249, 3247.826, 342.3879, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325570, 17, -4074.9016, 3254.4016, 339.4433, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 1, -3889.631, 3647.4463, 379.841, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 2, -3867.698, 3661.5972, 374.2303, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 3, -3829.1047, 3657.187, 352.5638, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 4, -3781.7354, 3660.6711, 339.2026, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 5, -3733.9072, 3659.38, 326.0082, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 6, -3700.1692, 3654.3042, 306.0638, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 7, -3666.533, 3646.2722, 305.6746, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 8, -3633.5032, 3666.8186, 305.6747, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 9, -3615.8333, 3700.0012, 308.675, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 10, -3612.9297, 3733.3955, 310.8136, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 11, -3620.4004, 3766.1814, 312.286, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 12, -3633.8906, 3791.9788, 308.6469, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 13, -3672.7378, 3787.0635, 303.5358, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 14, -3699.6611, 3766.1611, 308.3416, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 15, -3722.004, 3734.2622, 307.3692, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 16, -3758.981, 3700.7158, 303.9804, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 17, -3780.9514, 3669.244, 307.3968, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 18, -3823.718, 3662.3677, 306.5638, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 19, -3855.7666, 3696.3625, 309.2023, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 20, -3888.8125, 3716.2222, 313.5079, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 21, -3922.7354, 3736.9487, 316.8968, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 22, -3932.095, 3764.875, 321.5081, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 23, -3910.4854, 3799.0876, 334.758, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 24, -3868.0994, 3812.7612, 342.1745, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 25, -3842.4106, 3793.997, 354.0078, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 26, -3820.2214, 3754.304, 346.8967, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 27, -3833.7322, 3709.265, 337.0357, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 28, -3851.1003, 3670.116, 337.0357, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 29, -3880.1067, 3634.346, 337.0357, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 30, -3922.091, 3616.533, 325.3135, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 31, -3965.4849, 3605.9712, 311.0912, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 32, -3990.2036, 3580.163, 305.9802, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 33, -4011.7961, 3540.7188, 305.9802, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 34, -4011.6802, 3508.126, 305.9802, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 35, -3987.1155, 3486.2817, 305.9802, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 36, -3945.38, 3469.2996, 318.3691, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 37, -3915.3823, 3492.9368, 334.7857, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 38, -3903.774, 3531.6292, 345.4246, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 39, -3920.1555, 3565.9487, 365.369, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 40, -3933.3564, 3594.1145, 376.4244, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 41, -3912.3928, 3631.5222, 376.4244, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 42, -3889.631, 3647.4463, 379.841, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 43, -3867.698, 3661.5972, 374.2303, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325580, 44, -3829.1047, 3657.187, 352.5638, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 1, -3811.5754, 3318.0117, 350.0489, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 2, -3839.5442, 3360.737, 346.5213, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 3, -3844.5317, 3382.859, 327.4657, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 4, -3824.744, 3421.5105, 330.4099, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 5, -3815.8625, 3458.307, 331.2989, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 6, -3810.683, 3497.7166, 331.2989, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 7, -3813.6584, 3530.7778, 320.3823, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 8, -3816.1868, 3562.303, 309.2156, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 9, -3807.29, 3592.1125, 304.2435, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 10, -3785.319, 3618.5693, 304.2435, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 11, -3745.1467, 3632.4465, 304.2435, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 12, -3709.0234, 3627.5415, 304.2435, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 13, -3675.7683, 3604.466, 304.2435, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 14, -3671.1458, 3576.6675, 304.2435, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 15, -3681.4587, 3543.929, 304.2435, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 16, -3683.9458, 3516.303, 304.2435, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 17, -3690.9697, 3482.8098, 304.2435, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 18, -3718.6094, 3446.1519, 304.2435, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 19, -3752.8716, 3415.494, 304.2435, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 20, -3787.4414, 3393.2478, 306.6046, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 21, -3819.7075, 3391.4885, 304.2435, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 22, -3843.183, 3389.0034, 306.9379, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 23, -3878.6472, 3381.2192, 308.4658, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 24, -3917.6038, 3385.0461, 313.9101, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 25, -3948.8877, 3388.8745, 314.6601, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 26, -3981.8594, 3411.4072, 311.4101, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 27, -4006.548, 3451.2646, 312.8823, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 28, -4013.0256, 3483.8694, 313.6044, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 29, -4007.704, 3522.0864, 312.9934, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 30, -3979.9583, 3551.5352, 309.1602, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 31, -3949.836, 3557.0361, 311.2711, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 32, -3916.583, 3556.7817, 310.1603, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 33, -3878.4915, 3547.684, 308.91, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 34, -3848.3582, 3529.3064, 308.3823, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 35, -3810.6611, 3519.9695, 310.9657, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 36, -3788.1284, 3509.623, 314.0765, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 37, -3746.3772, 3484.1052, 314.4373, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 38, -3720.4146, 3453.266, 311.1879, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 39, -3711.39, 3414.8354, 316.1873, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 40, -3695.241, 3382.7544, 310.2711, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 41, -3690.6277, 3349.2617, 309.5485, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 42, -3707.5012, 3320.029, 317.0488, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 43, -3743.7834, 3305.247, 330.9654, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 44, -3787.1077, 3314.23, 339.9933, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 45, -3811.5754, 3318.0117, 350.0489, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 46, -3839.5442, 3360.737, 346.5213, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325640, 47, -3844.5317, 3382.859, 327.4657, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325650, 1, -3700.1868, 3268.5312, 332.5694, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325650, 2, -3712.4448, 3309.058, 332.5694, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325650, 3, -3731.0496, 3347.2288, 317.6805, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325650, 4, -3716.804, 3386.1643, 312.5971, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325650, 5, -3714.7957, 3416.0854, 310.3194, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325650, 6, -3726.4307, 3460.464, 311.0414, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325650, 7, -3753.8645, 3482.5378, 314.9584, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325650, 8, -3788.9983, 3508.9424, 314.9305, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325650, 9, -3824.7036, 3524.107, 309.9028, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325650, 10, -3848.736, 3512.5364, 316.0972, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325650, 11, -3888.7605, 3485.173, 326.2916, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325650, 12, -3912.3342, 3450.1382, 334.236, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325650, 13, -3915.3186, 3410.7224, 336.7916, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325650, 14, -3881.3872, 3385.134, 337.5138, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325650, 15, -3847.4856, 3374.93, 332.5694, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325650, 16, -3805.3862, 3361.0386, 326.6804, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325650, 17, -3773.7761, 3364.174, 321.6806, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325650, 18, -3746.5764, 3378.9297, 320.8195, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325650, 19, -3711.6785, 3399.8513, 324.7638, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325650, 20, -3677.3176, 3417.9404, 324.6248, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325650, 21, -3633.1125, 3400.247, 323.4302, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325650, 22, -3626.5535, 3376.9746, 323.0689, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325650, 23, -3616.881, 3334.8723, 332.5694, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325650, 24, -3627.39, 3296.5574, 332.5694, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325650, 25, -3664.1433, 3265.2632, 332.5694, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325650, 26, -3700.1868, 3268.5312, 332.5694, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325650, 27, -3712.4448, 3309.058, 332.5694, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325650, 28, -3664.1433, 3265.2632, 332.5694, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325660, 1, -3671.4944, 3402.6416, 324.4617, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325660, 2, -3675.1008, 3400.7961, 324.5731, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325660, 3, -3695.9956, 3378.851, 323.7954, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325660, 4, -3677.757, 3333.3738, 329.4622, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325660, 5, -3671.7935, 3306.1846, 341.9066, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325660, 6, -3691.3313, 3277.3928, 341.9066, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325660, 7, -3714.7102, 3287.5542, 341.9066, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325660, 8, -3715.6328, 3314.2666, 336.4897, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325660, 9, -3681.4888, 3340.8586, 327.934, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325660, 10, -3648.4844, 3360.056, 326.1562, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325660, 11, -3641.23, 3384.0898, 325.4898, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325660, 12, -3655.433, 3406.7253, 325.0451, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325660, 13, -3671.4944, 3402.6416, 324.4617, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325660, 14, -3675.1008, 3400.7961, 324.5731, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325660, 15, -3695.9956, 3378.851, 323.7954, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325670, 1, -3800.0442, 3329.8716, 342.0992, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325670, 2, -3820.0344, 3366.339, 344.5435, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325670, 3, -3848.72, 3382.158, 349.6544, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325670, 4, -3866.4448, 3399.19, 356.9323, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325670, 5, -3892.6082, 3428.6404, 364.4878, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325670, 6, -3875.4944, 3457.7415, 364.4878, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325670, 7, -3846.3047, 3462.7932, 364.4878, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325670, 8, -3835.5244, 3455.2778, 363.4879, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325670, 9, -3826.3416, 3432.9006, 363.4879, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325670, 10, -3846.3047, 3462.7932, 364.4878, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325670, 11, -3835.5244, 3455.2778, 363.4879, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325670, 12, -3826.3416, 3432.9006, 363.4879, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325670, 13, -3833.529, 3403.3623, 349.9602, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325670, 14, -3849.9045, 3384.7563, 348.2379, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325670, 15, -3869.0183, 3342.6797, 345.9046, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325670, 16, -3866.8733, 3308.942, 344.5435, NULL, 0, 0, 1, 1, 0, 100, 0),
(1325670, 17, -3833.3508, 3299.7788, 344.5435, NULL, 0, 0, 1, 1, 0, 100, 0);
