-- DB update 2021_12_24_00 -> 2021_12_24_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_24_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_24_00 2021_12_24_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1640236910966594500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640236910966594500');
/* This is a amalgamation of work from a collection of parses, improving the gameobject spawns in Shadowglen.

Specific packets used are mentioned here for reference purposes, and were uploaded to the AC submission page

# TrinityCore - WowPacketParser
# File name: 2.5.2.41446 Night Elf Hunter 011 Iverron's Antidote (Part 3 failed by timer) and Iverron's Antidote (Part 3) and 8th Battered Chest.pkt
# Detected build: V2_5_2_41446
# Detected locale: enUS
# Targeted database: WrathOfTheLichKing
# Parsing date: 12/21/2021 18:34:31

# TrinityCore - WowPacketParser
# File name: 2.5.2.41446 Night Elf Hunter 08 Hyacinth Mushroom in Area 03-04.pkt
# Detected build: V2_5_2_41446
# Detected locale: enUS
# Targeted database: WrathOfTheLichKing
# Parsing date: 12/21/2021 18:34:37

# TrinityCore - WowPacketParser
# File name: 2.5.2.41446 Night Elf Hunter 07 The Balance of Nature A Good Friend Webwood Venom A Friend in Need.pkt
# Detected build: V2_5_2_41446
# Detected locale: enUS
# Targeted database: WrathOfTheLichKing
# Parsing date: 12/21/2021 18:34:36

# TrinityCore - WowPacketParser
# File name: 2.5.2.41446 Night Elf Hunter 09 Iverron's Antidote and Webwood Egg.pkt
# Detected build: V2_5_2_41446
# Detected locale: enUS
# Targeted database: WrathOfTheLichKing
# Parsing date: 12/21/2021 18:34:38

# TrinityCore - WowPacketParser
# File name: 2.5.2.41446 Night Elf Druid Hyacinth Mushroom and Moonpetal Lily and Battered Chest.pkt
# Detected build: V2_5_2_41446
# Detected locale: enUS
# Targeted database: WrathOfTheLichKing
# Parsing date: 12/21/2021 18:34:35

*/ 

DELETE FROM `gameobject` WHERE `guid` IN (49515, 49516, 49517, 49518, 49519, 49520, 49839, 49853, 49854, 49855, 49856, 49857, 49858, 49859, 49860, 49861, 49863, 49864, 49865, 49866, 49867, 49868, 49869, 49870, 49871, 49872, 49873, 49874, 49875, 49876, 49877, 49878, 49879, 49880, 49881, 49882, 49883);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES
/* Existing spawntimes used, excluding chests for which provided video shows non-static short timer ranging from ~1-5mins */
/* Added some missing mushrooms and lillies for Iverron's Antidote */
/* Mushrooms */
(49883, 152094, 1, 141, 188, 1, 1, 10470.0673828125, 693.744384765625, 1319.9708251953125, 2.548179388046264648, 0, 0, 0.956304550170898437, 0.292372345924377441, 300, 255, 1, 0), -- 152094 (Area: 188 - Difficulty: 0)
(49854, 152094, 1, 141, 188, 1, 1, 10349.681640625, 700.1064453125, 1327.87255859375, 1.658061861991882324, 0, 0, 0.737277030944824218, 0.67559051513671875, 300, 255, 1, 0), -- 152094 (Area: 188 - Difficulty: 0)
(49855, 152094, 1, 141, 188, 1, 1, 10476.873046875, 765.03411865234375, 1317.308349609375, 3.43830275535583496, 0, 0, -0.98901557922363281, 0.147811368107795715, 300, 255, 1, 0), -- 152094 (Area: 188 - Difficulty: 0)
(49856, 152094, 1, 141, 188, 1, 1, 10332.42578125, 886.39874267578125, 1329.337890625, 1.658061861991882324, 0, 0, 0.737277030944824218, 0.67559051513671875, 300, 255, 1, 0), -- 152094 (Area: 188 - Difficulty: 0)
(49857, 152094, 1, 141, 256, 1, 1, 10354.619140625, 870.8338623046875, 1325.5206298828125, 5.654868602752685546, 0, 0, -0.30901622772216796, 0.95105677843093872, 300, 255, 1, 0), -- 152094 (Area: 256 - Difficulty: 0)
(49858, 152094, 1, 141, 188, 1, 1, 10396.669921875, 940.62078857421875, 1324.4490966796875, 3.682650327682495117, 0, 0, -0.96362972259521484, 0.26724100112915039, 300, 255, 1, 0), -- 152094 (Area: 188 - Difficulty: 0)
(49859, 152094, 1, 141, 188, 1, 1, 10456.4580078125, 1004.090576171875, 1324.4625244140625, 0.017452461645007133, 0, 0, 0.008726119995117187, 0.999961912631988525, 300, 255, 1, 0), -- 152094 (Area: 188 - Difficulty: 0)
(49860, 152094, 1, 141, 188, 1, 1, 10304.6396484375, 1031.9207763671875, 1343.5362548828125, 6.248279094696044921, 0, 0, -0.01745223999023437, 0.999847710132598876, 300, 255, 1, 0), -- 152094 (Area: 188 - Difficulty: 0)
(49861, 152094, 1, 141, 188, 1, 1, 10369.1171875, 1029.924072265625, 1339.69189453125, 6.003933906555175781, 0, 0, -0.13917255401611328, 0.990268170833587646, 300, 255, 1, 0), -- 152094 (Area: 188 - Difficulty: 0)
(49863, 152094, 1, 141, 188, 1, 1, 10343.337890625, 1010.95208740234375, 1336.194091796875, 0.174532130360603332, 0, 0, 0.087155342102050781, 0.996194720268249511, 300, 255, 1, 0), -- 152094 (Area: 188 - Difficulty: 0)
(49864, 152094, 1, 141, 188, 1, 1, 10253.103515625, 992.01495361328125, 1344.4947509765625, 5.602506637573242187, 0, 0, -0.33380699157714843, 0.942641437053680419, 300, 255, 1, 0), -- 152094 (Area: 188 - Difficulty: 0)
(49865, 152094, 1, 141, 188, 1, 1, 10268.564453125, 877.720947265625, 1341.4788818359375, 5.881760597229003906, 0, 0, -0.19936752319335937, 0.979924798011779785, 300, 255, 1, 0), -- 152094 (Area: 188 - Difficulty: 0)
(49866, 152094, 1, 141, 188, 1, 1, 10256.1611328125, 963.86566162109375, 1341.6524658203125, 1.797688722610473632, 0, 0, 0.7826080322265625, 0.622514784336090087, 300, 255, 1, 0), -- 152094 (Area: 188 - Difficulty: 0)
(49867, 152094, 1, 141, 188, 1, 1, 10579.396484375, 899.791748046875, 1312.0941162109375, 5.270895957946777343, 0, 0, -0.48480892181396484, 0.87462007999420166, 300, 255, 1, 0), -- 152094 (Area: 188 - Difficulty: 0)
(49868, 152094, 1, 141, 188, 1, 1, 10703.904296875, 918.69989013671875, 1326.657958984375, 5.864306926727294921, 0, 0, -0.20791149139404296, 0.978147625923156738, 300, 255, 1, 0), -- 152094 (Area: 188 - Difficulty: 0)
(49869, 152094, 1, 141, 188, 1, 1, 10700.8232421875, 894.12103271484375, 1323.481201171875, 5.811946868896484375, 0, 0, -0.2334451675415039, 0.972369968891143798, 300, 255, 1, 0), -- 152094 (Area: 188 - Difficulty: 0)
(49870, 152094, 1, 141, 188, 1, 1, 10267.2783203125, 849.1507568359375, 1341.7108154296875, 5.462882041931152343, 0, 0, -0.39874839782714843, 0.917060375213623046, 300, 255, 1, 0), -- 152094 (Area: 188 - Difficulty: 0)
(49871, 152094, 1, 141, 256, 1, 1, 10451.423828125, 908.64495849609375, 1314.57080078125, 5.84685373306274414, 0, 0, -0.21643924713134765, 0.976296067237854003, 300, 255, 1, 0), -- 152094 (Area: 256 - Difficulty: 0)
(49872, 152094, 1, 141, 188, 1, 1, 10285.7900390625, 979.7530517578125, 1340.1605224609375, 3.682650327682495117, 0, 0, -0.96362972259521484, 0.26724100112915039, 300, 255, 1, 0), -- 152094 (Area: 188 - Difficulty: 0)
(49873, 152094, 1, 141, 188, 1, 1, 10345.66015625, 1041.502197265625, 1339.74951171875, 2.635444164276123046, 0, 0, 0.96814727783203125, 0.250381410121917724, 300, 255, 1, 0), -- 152094 (Area: 188 - Difficulty: 0)
(49874, 152094, 1, 141, 188, 1, 1, 10393.2646484375, 901.1304931640625, 1324.7691650390625, 2.426007747650146484, 0, 0, 0.936672210693359375, 0.350207358598709106, 300, 255, 1, 0), -- 152094 (Area: 188 - Difficulty: 0)
(49875, 152094, 1, 141, 188, 1, 1, 10695.7529296875, 687.30609130859375, 1334.133544921875, 3.420850038528442382, 0, 0, -0.99026775360107421, 0.139175355434417724, 300, 255, 1, 0), -- 152094 (Area: 188 - Difficulty: 0)
(49876, 152094, 1, 141, 188, 1, 1, 10609.662109375, 606.9052734375, 1339.111572265625, 5.654868602752685546, 0, 0, -0.30901622772216796, 0.95105677843093872, 300, 255, 1, 0), -- 152094 (Area: 188 - Difficulty: 0)
(49877, 152094, 1, 141, 188, 1, 1, 10451.4189453125, 604.15460205078125, 1328.911376953125, 5.253442287445068359, 0, 0, -0.49242305755615234, 0.870355963706970214, 300, 255, 1, 0), -- 152094 (Area: 188 - Difficulty: 0)
(49878, 152094, 1, 141, 188, 1, 1, 10404.1171875, 516.12457275390625, 1330.17333984375, 4.48549652099609375, 0, 0, -0.7826080322265625, 0.622514784336090087, 300, 255, 1, 0), -- 152094 (Area: 188 - Difficulty: 0)
(49879, 152094, 1, 141, 256, 1, 1, 10505.1220703125, 929.50177001953125, 1315.2119140625, 3.665196180343627929, 0, 0, -0.96592521667480468, 0.258821308612823486, 300, 255, 1, 0), -- 152094 (Area: 256 - Difficulty: 0)
(49880, 152094, 1, 141, 188, 1, 1, 10643.5869140625, 857.4588623046875, 1314.6304931640625, 1.48352813720703125, 0, 0, 0.675589561462402343, 0.737277925014495849, 300, 255, 1, 0), -- 152094 (Area: 188 - Difficulty: 0)
(49881, 152094, 1, 141, 188, 1, 1, 10546.4482421875, 569.5899658203125, 1343.113037109375, 2.757613182067871093, 0, 0, 0.981626510620117187, 0.190812408924102783, 300, 255, 1, 0), -- 152094 (Area: 188 - Difficulty: 0)
(49882, 152094, 1, 141, 256, 1, 1, 10407.9189453125, 741.27130126953125, 1319.691650390625, 5.916667938232421875, 0, 0, -0.18223476409912109, 0.98325502872467041, 300, 255, 1, 0), -- 152094 (Area: 256 - Difficulty: 0)
/* Lillies */
(49839, 152095, 1, 141, 188, 1, 1, 10527.638671875, 935.30694580078125, 1314.0538330078125, 2.391098499298095703, 0, 0, 0.930417060852050781, 0.366502493619918823, 300, 255, 1, 0), -- 152095 (Area: 188 - Difficulty: 0)
(49853, 152095, 1, 141, 256, 1, 1, 10571.2431640625, 903.6798095703125, 1311.4034423828125, 1.605701684951782226, 0, 0, 0.719339370727539062, 0.694658815860748291, 300, 255, 1, 0), -- 152095 (Area: 256 - Difficulty: 0)

/* Shadowglen has 8 Battered Chests, 49528 and 49529 already existed */
(49520, 2843, 1, 141, 188, 1, 1, 10504.78515625, 1064.7088623046875, 1325.8319091796875, 6.003933906555175781, 0, 0, -0.13917255401611328, 0.990268170833587646, 60, 255, 1, 0), -- 2843 (Area: 188 - Difficulty: 0)
(49515, 2843, 1, 141, 257, 1, 1, 10952.6123046875, 945.79656982421875, 1340.7747802734375, 4.223697185516357421, 0, 0, -0.85716724395751953, 0.515038192272186279, 90, 255, 1, 0), -- 2843 (Area: 257 - Difficulty: 0)
(49516, 2843, 1, 141, 188, 1, 1, 10816.9423828125, 896.036376953125, 1336.0264892578125, 0.349065244197845458, 0, 0, 0.173647880554199218, 0.984807789325714111, 120, 255, 1, 0), -- 2843 (Area: 188 - Difficulty: 0)
(49517, 2843, 1, 141, 188, 1, 1, 10485.255859375, 1059.9840087890625, 1325.470458984375, 5.235987663269042968, 0, 0, -0.5, 0.866025388240814208, 150, 255, 1, 0), -- 2843 (Area: 188 - Difficulty: 0)
(49518, 2843, 1, 141, 188, 1, 1, 10261.837890625, 960.93304443359375, 1340.9468994140625, 3.24634718894958496, 0, 0, -0.99862861633300781, 0.052353221923112869, 180, 255, 1, 0), -- 2843 (Area: 188 - Difficulty: 0)
(49519, 2843, 1, 141, 257, 1, 1, 10908.3759765625, 977.76202392578125, 1338.316162109375, 2.827429771423339843, 0, 0, 0.987688064575195312, 0.156436234712600708, 210, 255, 1, 0); -- 2843 (Area: 257 - Difficulty: 0)

/* Remove bad pooling (49528 49529) */
DELETE FROM `pool_gameobject` WHERE  `guid` IN (49528, 49529, 49515, 49516, 49517, 49518, 49519, 49520);
DELETE FROM `pool_template` WHERE `entry` IN (376);
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(376, 1, 'Shadowglen, Teldrassil, Battered Chest');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(49528, 376, 0, 'Shadowglen Battered Chest 1 of 8'),
(49529, 376, 0, 'Shadowglen Battered Chest 2 of 8'),
(49515, 376, 0, 'Shadowglen Battered Chest 3 of 8'),
(49516, 376, 0, 'Shadowglen Battered Chest 4 of 8'),
(49517, 376, 0, 'Shadowglen Battered Chest 5 of 8'),
(49518, 376, 0, 'Shadowglen Battered Chest 6 of 8'),
(49519, 376, 0, 'Shadowglen Battered Chest 7 of 8'),
(49520, 376, 0, 'Shadowglen Battered Chest 8 of 8');


/* Spawns counted by WPP on a complete area scan:  40 Mushrooms, 15 Lillies active at once: 

# TrinityCore - WowPacketParser
# File name: 2.5.2.41446 Quick Scan Counting Active Spawns for Iverron's Antidote Part 2.pkt
# Detected build: V2_5_2_41446
# Detected locale: enUS
# Targeted database: WrathOfTheLichKing
# Parsing date: 12/22/2021 22:16:03

*/

DELETE FROM `pool_template` WHERE `entry` IN (377, 378);
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(377, 40, 'Shadowglen, Teldrassil, Quest Iverrons Antidote Part 2 Mushrooms Object'),
(378, 15, 'Shadowglen, Teldrassil, Quest Iverrons Antidote Part 2 Lillies Object');
DELETE FROM `pool_gameobject` WHERE  `guid` IN (49533, 49534, 49535, 49536, 49537, 49538, 49539, 49540, 49541, 49542, 49543, 49544, 49545, 49546, 49547, 49548, 49549, 49550, 49551, 49552, 49553, 49554, 49555, 49556, 49557, 49558, 49559, 49560, 49561, 49562, 49563, 49564, 49565, 49566, 49567, 49568, 49569, 49570, 49883, 49882, 49881, 49880, 49879, 49878, 49877, 49876, 49875, 49874, 49873, 49872, 49871, 49870, 49869, 49868, 49867, 49866, 49865, 49864, 49863, 49861, 49860, 49859, 49858, 49857, 49856, 49854, 49855, 49571, 49572, 49573, 49574, 49575, 49576, 49577, 49578, 49579, 49580, 49581, 49582, 49583, 49584, 49585, 49586, 49587, 49588, 49839, 49853);
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(49533, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49534, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49535, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49536, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49537, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49538, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49539, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49540, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49541, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49542, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49543, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49544, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49545, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49546, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49547, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49548, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49549, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49550, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49551, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49552, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49553, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49554, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49555, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49556, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49557, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49558, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49559, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49560, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49561, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49562, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49563, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49564, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49565, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49566, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49567, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49568, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49569, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49570, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49883, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49882, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49881, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49880, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49879, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49878, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49877, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49876, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49875, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49874, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49873, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49872, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49871, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49870, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49869, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49868, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49867, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49866, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49865, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49864, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49863, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49861, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49860, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49859, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49858, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49857, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49856, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49854, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest'),
(49855, 377, 0, 'Hyacinth Mushroom for Iverrons Antidote Quest');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(49571, 378, 0, 'Moonpetal Lily for Iverrons Antidote Quest'),
(49572, 378, 0, 'Moonpetal Lily for Iverrons Antidote Quest'),
(49573, 378, 0, 'Moonpetal Lily for Iverrons Antidote Quest'),
(49574, 378, 0, 'Moonpetal Lily for Iverrons Antidote Quest'),
(49575, 378, 0, 'Moonpetal Lily for Iverrons Antidote Quest'),
(49576, 378, 0, 'Moonpetal Lily for Iverrons Antidote Quest'),
(49577, 378, 0, 'Moonpetal Lily for Iverrons Antidote Quest'),
(49578, 378, 0, 'Moonpetal Lily for Iverrons Antidote Quest'),
(49579, 378, 0, 'Moonpetal Lily for Iverrons Antidote Quest'),
(49580, 378, 0, 'Moonpetal Lily for Iverrons Antidote Quest'),
(49581, 378, 0, 'Moonpetal Lily for Iverrons Antidote Quest'),
(49582, 378, 0, 'Moonpetal Lily for Iverrons Antidote Quest'),
(49583, 378, 0, 'Moonpetal Lily for Iverrons Antidote Quest'),
(49584, 378, 0, 'Moonpetal Lily for Iverrons Antidote Quest'),
(49585, 378, 0, 'Moonpetal Lily for Iverrons Antidote Quest'),
(49586, 378, 0, 'Moonpetal Lily for Iverrons Antidote Quest'),
(49587, 378, 0, 'Moonpetal Lily for Iverrons Antidote Quest'),
(49588, 378, 0, 'Moonpetal Lily for Iverrons Antidote Quest'),
(49839, 378, 0, 'Moonpetal Lily for Iverrons Antidote Quest'),
(49853, 378, 0, 'Moonpetal Lily for Iverrons Antidote Quest');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_24_01' WHERE sql_rev = '1640236910966594500';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
