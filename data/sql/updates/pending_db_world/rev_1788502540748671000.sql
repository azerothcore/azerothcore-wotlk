-- Ulduar: make the left riverside Forest Swarmers patrol with their Guardian Lasher.
UPDATE `creature` SET `wander_distance` = 0, `MovementType` = 0
WHERE `id` = 33431 AND `guid` BETWEEN 136611 AND 136620;
DELETE FROM `creature_formations` WHERE `memberGUID` IN (136607, 136611, 136612, 136613, 136614, 136615, 136616, 136617, 136618, 136619, 136620);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(136607, 136607, 0, 0, 515, 0, 0),
(136607, 136611, 20.038, 109.498, 515, 0, 0),
(136607, 136612, 11.422, 141.135, 515, 0, 0),
(136607, 136613, 14.308, 118.254, 515, 0, 0),
(136607, 136614, 8.199, 164.137, 515, 0, 0),
(136607, 136615, 9.308, 165.012, 515, 0, 0),
(136607, 136616, 6.042, 63.470, 515, 0, 0),
(136607, 136617, 6.040, 122.801, 515, 0, 0),
(136607, 136618, 12.079, 210.404, 515, 0, 0),
(136607, 136619, 10.914, 85.590, 515, 0, 0),
(136607, 136620, 15.625, 124.750, 515, 0, 0);
