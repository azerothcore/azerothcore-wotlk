-- DB update 2022_09_21_07 -> 2022_09_21_08
--
-- Correct speeds for display ids that were seen in 1.14 but not 1.13 sniffs. (Credit VMangos)
UPDATE `creature_template` SET `speed_walk`=0.666668 WHERE `modelid1` IN (9444);
UPDATE `creature_template` SET `speed_walk`=0.888888 WHERE `modelid1` IN (8315, 9489);
UPDATE `creature_template` SET `speed_walk`=1 WHERE `modelid1` IN (127, 2142, 3212, 3231, 4537, 4869, 4912, 4937, 6117, 7311, 7336, 8594, 8702, 8870, 10443, 10454, 10612, 10802, 11014, 11017, 11023, 11308, 11341, 12069, 12070, 12071, 12072, 12081, 12082, 12083, 12084, 12935, 13229, 13230, 13231, 13232, 13249, 13250, 13251, 13252, 13254, 13255, 13256, 13257, 13266, 13267, 13268, 13269, 13270, 13271, 13272, 13273, 13286, 13287, 13288, 13289, 13290, 13291, 13292, 13293, 13296, 13297, 13301, 13302, 13303, 13304, 13306, 13307, 13308, 13309, 13351, 13352, 13353, 13354, 13357, 13358, 13359, 13360, 13365, 13366, 13367, 13368, 13371, 13372, 13373, 13374, 13375, 13376, 13377, 13378, 13379, 13380, 13381, 13382, 13456, 13459, 13533, 13534, 13544, 13546, 13547, 13549, 13557, 13558, 13559, 13560, 13561, 13563, 13564, 13565, 13566, 13567, 13568, 13569, 13632, 13633, 13634, 13635, 13636, 13637, 13638, 13639, 13640, 13641, 13642, 13643, 13775, 13789, 13790, 13791, 13792, 13803, 13804, 13805, 13806, 13889, 13890, 13893, 13894, 14255, 14515, 14520, 14523, 15201, 15330, 15563, 15622, 15637, 15641, 15735);
UPDATE `creature_template` SET `speed_walk`=1.11111 WHERE `modelid1` IN (12342);
UPDATE `creature_template` SET `speed_walk`=1.4 WHERE `modelid1` IN (10042);
UPDATE `creature_template` SET `speed_walk`=1.55556 WHERE `modelid1` IN (549, 1127, 1128, 14514);
UPDATE `creature_template` SET `speed_walk`=1.6 WHERE `modelid1` IN (11570);
UPDATE `creature_template` SET `speed_walk`=4 WHERE `modelid1` IN (14884);
UPDATE `creature_template` SET `speed_run`=1.14286 WHERE `modelid1` IN (127, 549, 1127, 1128, 2142, 3212, 3231, 4537, 4912, 4937, 6117, 7311, 8315, 8594, 8702, 8870, 9444, 9489, 10454, 10802, 11014, 11017, 11023, 11308, 11570, 12069, 12070, 12071, 12072, 12081, 12082, 12083, 12084, 12342, 13229, 13230, 13231, 13232, 13249, 13250, 13251, 13252, 13254, 13255, 13256, 13257, 13266, 13267, 13268, 13269, 13270, 13271, 13272, 13273, 13286, 13287, 13288, 13289, 13290, 13291, 13292, 13293, 13296, 13297, 13301, 13302, 13303, 13304, 13306, 13307, 13308, 13309, 13351, 13352, 13353, 13354, 13357, 13358, 13359, 13360, 13365, 13366, 13367, 13368, 13371, 13372, 13373, 13374, 13375, 13376, 13377, 13378, 13379, 13380, 13381, 13382, 13456, 13459, 13533, 13534, 13544, 13546, 13547, 13549, 13557, 13558, 13559, 13560, 13561, 13563, 13564, 13565, 13566, 13567, 13568, 13569, 13632, 13633, 13634, 13635, 13636, 13637, 13638, 13639, 13640, 13641, 13642, 13643, 13775, 13789, 13790, 13791, 13792, 13803, 13804, 13805, 13806, 13889, 13890, 13893, 13894, 14514, 14523, 15201, 15330, 15563, 15622, 15637, 15641, 15735);
UPDATE `creature_template` SET `speed_run`=1.14286 WHERE `modelid1` IN (4869, 7336, 10443, 10612, 11341, 12935, 14255, 14515, 14520);
UPDATE `creature_template` SET `speed_run`=1.42857 WHERE `modelid1` IN (10042);
UPDATE `creature_template` SET `speed_run`=2.14286 WHERE `modelid1` IN (14884);

-- Correct speeds for creatures that were seen in 1.14 but not 1.13 sniffs. (Credit VMangos)
UPDATE `creature_template` SET `speed_run`=1 WHERE `entry`=9688; -- Windwall Totem II
UPDATE `creature_template` SET `speed_run`=0.992063 WHERE `entry`=10199; -- Grizzle Snowpaw
UPDATE `creature_template` SET `speed_run`=0.992063 WHERE `entry`=14342; -- Ragepaw
UPDATE `creature_template` SET `speed_walk`=0.888888 WHERE `entry`=1050; -- Scalebane Royal Guard
UPDATE `creature_template` SET `speed_walk`=1.11111 WHERE `entry`=1552; -- Scale Belly
UPDATE `creature_template` SET `speed_walk`=0.777776 WHERE `entry`=1847; -- Foulmane
UPDATE `creature_template` SET `speed_walk`=1.55556 WHERE `entry`=2752; -- Rumbler
UPDATE `creature_template` SET `speed_walk`=1.11111 WHERE `entry`=3094; -- Unseen
UPDATE `creature_template` SET `speed_walk`=1.11111 WHERE `entry`=3617; -- Lordaeron Citizen
UPDATE `creature_template` SET `speed_walk`=0.666668 WHERE `entry`=5808; -- Warlord Kolkanis
UPDATE `creature_template` SET `speed_walk`=1.55556 WHERE `entry`=5889; -- Mesa Earth Spirit
UPDATE `creature_template` SET `speed_walk`=1.55556 WHERE `entry`=5891; -- Minor Manifestation of Earth
UPDATE `creature_template` SET `speed_walk`=1.11111 WHERE `entry`=8302; -- Deatheye
UPDATE `creature_template` SET `speed_walk`=0.888888 WHERE `entry`=10196; -- General Colbatann
UPDATE `creature_template` SET `speed_walk`=0.666668 WHERE `entry`=10199; -- Grizzle Snowpaw
UPDATE `creature_template` SET `speed_walk`=1.55556 WHERE `entry`=10642; -- Eck'alom
UPDATE `creature_template` SET `speed_walk`=0.666668 WHERE `entry`=13742; -- Kolk
UPDATE `creature_template` SET `speed_walk`=0.666668 WHERE `entry`=14342; -- Ragepaw
UPDATE `creature_template` SET `speed_walk`=1.55556 WHERE `entry`=14457; -- Princess Tempestria
UPDATE `creature_template` SET `speed_walk`=1.55556 WHERE `entry`=14458; -- Watery Invader
UPDATE `creature_template` SET `speed_walk`=0.666668 WHERE `entry`=15082; -- Gri'lek
