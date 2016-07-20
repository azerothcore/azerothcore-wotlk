
REPLACE INTO game_event VALUES(9, "2015-04-06 01:00:00", "2020-12-31 06:00:00", 524160, 10080, 181, "Noblegarden", 0);

DELETE FROM creature_addon WHERE guid IN(SELECT guid from game_event_creature WHERE eventEntry=9);
DELETE FROM creature WHERE guid IN(SELECT guid FROM game_event_creature WHERE eventEntry=9);
DELETE FROM creature WHERE guid BETWEEN 244800 AND 244851;
INSERT INTO creature VALUES (244800, 19171, 530, 1, 1, 0, 0, -3909.22, -11614.8, -138.101, 3.1765, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244801, 19169, 530, 1, 1, 0, 0, 9659.86, -7115.63, 14.3239, 5.88552, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244802, 19176, 1, 1, 1, 0, 0, -1241.98, 81.7344, 129.422, 5.4992, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244803, 19172, 0, 1, 1, 0, 0, -4829.02, -1174.75, 502.193, 0.724139, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244804, 19175, 1, 1, 1, 0, 0, 1607.39, -4402.93, 10.1664, 3.11715, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244805, 18927, 0, 1, 1, 0, 0, -8854.78, 649.83, 96.7417, 1.43117, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244806, 32798, 1, 1, 1, 0, 0, 317.219, -4677.94, 16.1175, 3.80143, 120, 0, 0, 34032, 31924, 0, 0, 0, 0);
INSERT INTO creature VALUES (244807, 32798, 0, 1, 1, 0, 0, 2255.62, 271.928, 34.4734, 2.52523, 120, 0, 0, 34032, 31924, 0, 0, 0, 0);
INSERT INTO creature VALUES (244808, 32798, 1, 1, 1, 0, 0, -2383.33, -409.778, -4.03543, 4.08039, 120, 0, 0, 34032, 31924, 0, 0, 0, 0);
INSERT INTO creature VALUES (244809, 32798, 530, 1, 1, 0, 0, 9484.74, -6813.9, 16.4939, 0.571603, 120, 0, 0, 34032, 31924, 0, 0, 0, 0);
INSERT INTO creature VALUES (244810, 32837, 1, 1, 1, 0, 1, 354.242, -4684.24, 16.4578, 3.5501, 600, 0, 0, 247, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244811, 32837, 0, 1, 1, 0, 1, 2310.73, 296.853, 37.3108, 4.44553, 600, 0, 0, 247, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244812, 32837, 1, 1, 1, 0, 1, -2250.52, -291.15, -9.42481, 3.87226, 600, 0, 0, 247, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244813, 32837, 530, 1, 1, 0, 1, 9525.96, -6878.95, 18.7502, 4.97768, 600, 0, 0, 247, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244814, 32799, 0, 1, 1, 0, 0, -5607.53, -511.287, 402.237, 1.0253, 120, 0, 0, 34032, 31924, 0, 0, 0, 0);
INSERT INTO creature VALUES (244815, 32799, 0, 1, 1, 0, 0, -9474.49, 87.242, 56.7402, 2.98374, 120, 0, 0, 34032, 31924, 0, 0, 0, 0);
INSERT INTO creature VALUES (244816, 32799, 530, 1, 1, 0, 0, -4173.09, -12416.3, 41.9509, 1.42244, 120, 0, 0, 34032, 31924, 0, 0, 0, 0);
INSERT INTO creature VALUES (244817, 32799, 1, 1, 1, 0, 0, 9759.88, 904.593, 1295.52, 2.9768, 120, 0, 0, 34032, 31924, 0, 0, 0, 0);
INSERT INTO creature VALUES (244818, 32836, 0, 1, 1, 0, 1, -5604.8, -527.253, 399.659, 2.43902, 600, 0, 0, 247, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244819, 32836, 0, 1, 1, 0, 1, -9460.17, 26.0472, 56.3399, 5.44596, 600, 0, 0, 247, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244820, 32836, 530, 1, 1, 0, 1, -4135.56, -12467.1, 44.5745, 3.51945, 600, 0, 0, 247, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244821, 32836, 1, 1, 1, 0, 1, 9893.55, 980.109, 1354.88, 1.15466, 600, 0, 0, 247, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244822, 19177, 1, 1, 1, 0, 0, 1688.01, -4350.19, 61.2691, 2.56413, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244823, 19178, 0, 1, 1, 0, 0, 1626.7, 222.7, -43.1027, 1.01229, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244824, 19173, 1, 1, 1, 0, 0, 9921.56, 2499.58, 1317.77, 5.61996, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244825, 19148, 0, 1, 1, 0, 0, -4915.33, -953.892, 501.498, 2.25016, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244826, 20102, 1, 1, 1, 0, 0, 6747.03, -4664.43, 724.551, 3.61009, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244827, 20102, 1, 1, 1, 0, 0, -938.792, -3735.2, 8.57162, 3.66385, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244828, 20102, 1, 1, 1, 0, 0, -7177.24, -3810.02, 8.3753, 0.711558, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244829, 20102, 0, 1, 1, 0, 0, -14464.9, 470.287, 15.0369, 5.96098, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244830, 20102, 530, 1, 1, 0, 0, -1888.02, 5400.44, -12.4278, 5.97919, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244831, 20102, 530, 1, 1, 0, 0, 3035.51, 3635.08, 144.47, 0.901821, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244832, 19169, 571, 1, 1, 0, 0, 5889.57, 550.355, 639.637, 1.57167, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244833, 18927, 571, 1, 1, 0, 0, 5719.3, 687.257, 645.752, 5.72721, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244834, 18927, 0, 1, 1, 0, 0, -8855.97, 652.546, 96.2675, 5.07716, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244835, 18927, 571, 1, 1, 0, 0, 5678.09, 658.93, 647.134, 0.088838, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244836, 19148, 0, 1, 1, 0, 0, -4914.82, -951.191, 501.498, 4.5773, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244837, 19171, 530, 1, 1, 0, 0, -3910.91, -11612.4, -138.243, 4.99941, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244838, 19172, 0, 1, 1, 0, 0, -4826.78, -1175.89, 502.193, 2.45358, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244839, 19173, 1, 1, 1, 0, 0, 9923.44, 2496.95, 1317.49, 2.28359, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244840, 19169, 571, 1, 1, 0, 0, 5928.98, 639.593, 645.557, 3.01052, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244841, 19169, 530, 1, 1, 0, 0, 9664.38, -7117.91, 14.324, 2.63397, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244842, 19175, 1, 1, 1, 0, 0, 1603.36, -4404.49, 9.30901, 0.627438, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244843, 19176, 1, 1, 1, 0, 0, -1242.68, 76.7127, 128.935, 1.27376, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244844, 19177, 1, 1, 1, 0, 0, 1685.07, -4352.88, 61.7253, 1.79601, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244845, 19178, 0, 1, 1, 0, 0, 1629.95, 219.238, -43.1027, 1.91079, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244846, 20102, 1, 1, 1, 0, 0, 6745.48, -4667.44, 723.103, 1.03712, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244847, 20102, 1, 1, 1, 0, 0, -936.306, -3738.3, 8.96324, 3.35283, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244848, 20102, 1, 1, 1, 0, 0, -7173.14, -3808.58, 8.37043, 3.3285, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244849, 20102, 0, 1, 1, 0, 0, -14461.4, 468.507, 15.1232, 2.66545, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244850, 20102, 530, 1, 1, 0, 0, -1884.63, 5397.52, -12.4278, 2.51637, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244851, 20102, 530, 1, 1, 0, 0, 3038.56, 3635.53, 144.012, 3.32713, 300, 0, 0, 42, 0, 0, 0, 0, 0);
REPLACE INTO game_event_creature VALUES(9, 244800),(9, 244801),(9, 244802),(9, 244803),(9, 244804),(9, 244805),
(9, 244806),(9, 244807),(9, 244808),(9, 244809),(9, 244810),(9, 244811),(9, 244812),(9, 244813),(9, 244814),(9, 244815),(9, 244816),
(9, 244817),(9, 244818),(9, 244819),(9, 244820),(9, 244821),(9, 244822),(9, 244823),(9, 244824),(9, 244825),(9, 244826),(9, 244827),
(9, 244828),(9, 244829),(9, 244830),(9, 244831),(9, 244832),(9, 244833),(9, 244834),(9, 244835),(9, 244836),(9, 244837),(9, 244838),
(9, 244839),(9, 244840),(9, 244841),(9, 244842),(9, 244843),(9, 244844),(9, 244845),(9, 244846),(9, 244847),(9, 244848),(9, 244849),
(9, 244850),(9, 244851);

UPDATE gameobject_template SET ScriptName="go_noblegarden_colored_egg" WHERE entry IN(113768, 113769, 113770, 113771, 113772);
-- ----------------------------------------
-- ACHIEVEMENTS
-- ----------------------------------------
-- Blushing Bride (2576)
DELETE FROM disables WHERE sourceType=4 AND entry IN(9858);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(9858);
INSERT INTO achievement_criteria_data VALUES(9858, 5, 62181, 0, "");
INSERT INTO achievement_criteria_data VALUES(9858, 7, 61980, 0, "");

-- Chocoholic (2418)
DELETE FROM disables WHERE sourceType=4 AND entry IN(9120);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(9120);
INSERT INTO achievement_criteria_data VALUES(9120, 16, 181, 0, "");

-- Chocolate Lover (2417)
DELETE FROM disables WHERE sourceType=4 AND entry IN(9119);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(9119);
INSERT INTO achievement_criteria_data VALUES(9119, 16, 181, 0, "");

-- Desert Rose (2436)
DELETE FROM disables WHERE sourceType=4 AND entry IN(9138, 9139, 9140, 9141, 9142);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(9138, 9139, 9140, 9141, 9142);
INSERT INTO achievement_criteria_data VALUES(9138, 6, 3, 0, "");
INSERT INTO achievement_criteria_data VALUES(9139, 6, 405, 0, "");
INSERT INTO achievement_criteria_data VALUES(9140, 6, 440, 0, "");
INSERT INTO achievement_criteria_data VALUES(9141, 6, 400, 0, "");
INSERT INTO achievement_criteria_data VALUES(9142, 6, 1377, 0, "");

-- Dressed for the Occasion (249)
DELETE FROM disables WHERE sourceType=4 AND entry IN(3220);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(3220);

-- Hard Boiled (2416)
DELETE FROM disables WHERE sourceType=4 AND entry IN(9118);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(9118);
INSERT INTO achievement_criteria_data VALUES(9118, 6, 543, 0, "");
INSERT INTO achievement_criteria_data VALUES(9118, 16, 181, 0, "");

-- I Found One! (2676)
DELETE FROM disables WHERE sourceType=4 AND entry IN(9538);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(9538);

-- Noble Garden (2421)
DELETE FROM disables WHERE sourceType=4 AND entry IN(9123);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(9123);
INSERT INTO achievement_criteria_data VALUES(9123, 6, 1519, 0, "");

-- Noble Garden (2420)
DELETE FROM disables WHERE sourceType=4 AND entry IN(9122);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(9122);
INSERT INTO achievement_criteria_data VALUES(9122, 6, 3487, 0, "");

-- Shake Your Bunny-Maker (2422)
DELETE FROM disables WHERE sourceType=4 AND entry IN(9124, 9143, 9144, 9145, 9146, 9147, 9148, 9149, 9150, 9151);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(9124, 9143, 9144, 9145, 9146, 9147, 9148, 9149, 9150, 9151);
INSERT INTO achievement_criteria_data VALUES(9124, 2, 0, 10, "");
INSERT INTO achievement_criteria_data VALUES(9124, 9, 18, 0, "");
INSERT INTO achievement_criteria_data VALUES(9124, 10, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(9143, 2, 0, 11, "");
INSERT INTO achievement_criteria_data VALUES(9143, 9, 18, 0, "");
INSERT INTO achievement_criteria_data VALUES(9143, 10, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(9144, 2, 0, 1, "");
INSERT INTO achievement_criteria_data VALUES(9144, 9, 18, 0, "");
INSERT INTO achievement_criteria_data VALUES(9144, 10, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(9145, 2, 0, 3, "");
INSERT INTO achievement_criteria_data VALUES(9145, 9, 18, 0, "");
INSERT INTO achievement_criteria_data VALUES(9145, 10, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(9146, 2, 0, 7, "");
INSERT INTO achievement_criteria_data VALUES(9146, 9, 18, 0, "");
INSERT INTO achievement_criteria_data VALUES(9146, 10, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(9147, 2, 0, 4, "");
INSERT INTO achievement_criteria_data VALUES(9147, 9, 18, 0, "");
INSERT INTO achievement_criteria_data VALUES(9147, 10, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(9148, 2, 0, 2, "");
INSERT INTO achievement_criteria_data VALUES(9148, 9, 18, 0, "");
INSERT INTO achievement_criteria_data VALUES(9148, 10, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(9149, 2, 0, 6, "");
INSERT INTO achievement_criteria_data VALUES(9149, 9, 18, 0, "");
INSERT INTO achievement_criteria_data VALUES(9149, 10, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(9150, 2, 0, 8, "");
INSERT INTO achievement_criteria_data VALUES(9150, 9, 18, 0, "");
INSERT INTO achievement_criteria_data VALUES(9150, 10, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(9151, 2, 0, 5, "");
INSERT INTO achievement_criteria_data VALUES(9151, 9, 18, 0, "");
INSERT INTO achievement_criteria_data VALUES(9151, 10, 1, 0, "");

-- Sunday's Finest (248)
DELETE FROM disables WHERE sourceType=4 AND entry IN(3221, 3222);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(3221, 3222);

-- Spring Fling (2419)
DELETE FROM disables WHERE sourceType=4 AND entry IN(9121, 9199, 9200, 9201);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(9121, 9199, 9200, 9201);
INSERT INTO achievement_criteria_data VALUES(9121, 6, 3576, 0, "");
INSERT INTO achievement_criteria_data VALUES(9199, 6, 186, 0, "");
INSERT INTO achievement_criteria_data VALUES(9200, 6, 87, 0, "");
INSERT INTO achievement_criteria_data VALUES(9201, 6, 131, 0, "");

-- Spring Fling (2497)
DELETE FROM disables WHERE sourceType=4 AND entry IN(9202, 9203, 9204, 9205);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(9202, 9203, 9204, 9205);
INSERT INTO achievement_criteria_data VALUES(9202, 6, 222, 0, "");
INSERT INTO achievement_criteria_data VALUES(9203, 6, 159, 0, "");
INSERT INTO achievement_criteria_data VALUES(9204, 6, 3665, 0, "");
INSERT INTO achievement_criteria_data VALUES(9205, 6, 362, 0, "");
