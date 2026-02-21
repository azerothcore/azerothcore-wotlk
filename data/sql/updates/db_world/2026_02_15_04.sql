-- DB update 2026_02_15_03 -> 2026_02_15_04
-- DB update 2026_02_13_00 >> 2026_02_13_01
-- Add gameobject_summon_groups table
DROP TABLE IF EXISTS `gameobject_summon_groups`;
CREATE TABLE IF NOT EXISTS `gameobject_summon_groups` (
  `summonerId` int unsigned NOT NULL DEFAULT '0',
  `summonerType` tinyint unsigned NOT NULL DEFAULT '0',
  `groupId` tinyint unsigned NOT NULL DEFAULT '0',
  `entry` int unsigned NOT NULL DEFAULT '0',
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  `orientation` float NOT NULL DEFAULT '0',
  `rotation0` float NOT NULL DEFAULT '0',
  `rotation1` float NOT NULL DEFAULT '0',
  `rotation2` float NOT NULL DEFAULT '0',
  `rotation3` float NOT NULL DEFAULT '0',
  `respawnTime` int unsigned NOT NULL DEFAULT '120',
  `Comment` varchar(255) CHARACTER SET `utf8mb4` COLLATE `utf8mb4_unicode_ci` NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=`utf8mb4` COLLATE=`utf8mb4_unicode_ci`;

-- Quest 619 "Enticing Negolash" - Gameobject spawns on quest turn-in at Ruined Lifeboat (GO 2289)
-- Sniff data: Barbequed Buzzard Wings (2332), Stranglevine Wine (2333), Baked Bread (2562)
DELETE FROM `gameobject_summon_groups` WHERE `summonerId` = 2289 AND `summonerType` = 1;
INSERT INTO `gameobject_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `respawnTime`, `Comment`) VALUES
(2289, 1, 0, 2332, -14652.3798828125, 146.5117950439453125, 3.501179933547973632, 0.349065244197845458, 0, 0, 0.173647880554199218, 0.984807789325714111, 120, 'Enticing Negolash - Barbequed Buzzard Wings'),
(2289, 1, 0, 2332, -14652.9423828125, 146.867401123046875, 2.506906986236572265, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 'Enticing Negolash - Barbequed Buzzard Wings'),
(2289, 1, 0, 2332, -14653.017578125, 146.524169921875, 2.355585098266601562, 6.003933906555175781, 0, 0, -0.13917255401611328, 0.990268170833587646, 120, 'Enticing Negolash - Barbequed Buzzard Wings'),
(2289, 1, 0, 2332, -14653.044921875, 145.137908935546875, 2.653269052505493164, 5.84685373306274414, 0, 0, -0.21643924713134765, 0.976296067237854003, 120, 'Enticing Negolash - Barbequed Buzzard Wings'),
(2289, 1, 0, 2332, -14654.0361328125, 147.3063201904296875, 2.467313051223754882, 0.942476630210876464, 0, 0, 0.453989982604980468, 0.891006767749786376, 120, 'Enticing Negolash - Barbequed Buzzard Wings'),
(2289, 1, 0, 2332, -14654.45703125, 147.324005126953125, 2.456363916397094726, 1.815141916275024414, 0, 0, 0.788010597229003906, 0.615661680698394775, 120, 'Enticing Negolash - Barbequed Buzzard Wings'),
(2289, 1, 0, 2332, -14654.703125, 146.1419219970703125, 2.089060068130493164, 2.373644113540649414, 0, 0, 0.927183151245117187, 0.37460830807685852, 120, 'Enticing Negolash - Barbequed Buzzard Wings'),
(2289, 1, 0, 2332, -14654.87890625, 147.2779693603515625, 2.425240993499755859, 5.881760597229003906, 0, 0, -0.19936752319335937, 0.979924798011779785, 120, 'Enticing Negolash - Barbequed Buzzard Wings'),
(2289, 1, 0, 2332, -14655.1357421875, 146.6710968017578125, 2.230948925018310546, 2.652894020080566406, 0, 0, 0.970294952392578125, 0.241925001144409179, 120, 'Enticing Negolash - Barbequed Buzzard Wings'),
(2289, 1, 0, 2332, -14655.2763671875, 147.80206298828125, 2.639719009399414062, 6.161012649536132812, 0, 0, -0.06104850769042968, 0.998134791851043701, 120, 'Enticing Negolash - Barbequed Buzzard Wings'),
(2289, 1, 0, 2332, -14656.1884765625, 147.0958404541015625, 2.387770891189575195, 0.174532130360603332, 0, 0, 0.087155342102050781, 0.996194720268249511, 120, 'Enticing Negolash - Barbequed Buzzard Wings'),
(2289, 1, 0, 2332, -14656.8330078125, 148.8932647705078125, 3.288661956787109375, 5.096362113952636718, 0, 0, -0.55919265747070312, 0.829037725925445556, 120, 'Enticing Negolash - Barbequed Buzzard Wings'),
(2289, 1, 0, 2333, -14653.044921875, 145.3892364501953125, 2.85199904441833496, 4.852017402648925781, 0, 0, -0.65605831146240234, 0.754710197448730468, 120, 'Enticing Negolash - Stranglevine Wine'),
(2289, 1, 0, 2333, -14655.728515625, 148.9776458740234375, 4.056398868560791015, 3.473210096359252929, 0, 0, -0.98628520965576171, 0.165049895644187927, 120, 'Enticing Negolash - Stranglevine Wine'),
(2289, 1, 0, 2333, -14656.4482421875, 147.5946807861328125, 3.129076004028320312, 1.588248729705810546, 0, 0, 0.713250160217285156, 0.700909554958343505, 120, 'Enticing Negolash - Stranglevine Wine'),
(2289, 1, 0, 2333, -14656.8408203125, 147.4337310791015625, 3.102070093154907226, 3.019413232803344726, 0, 0, 0.998134613037109375, 0.061051756143569946, 120, 'Enticing Negolash - Stranglevine Wine'),
(2289, 1, 0, 2333, -14657.1513671875, 148.227569580078125, 2.886320114135742187, 1.535889506340026855, 0, 0, 0.694658279418945312, 0.719339847564697265, 120, 'Enticing Negolash - Stranglevine Wine'),
(2289, 1, 0, 2562, -14652.4326171875, 145.7533721923828125, 3.254641056060791015, 2.932138919830322265, 0, 0, 0.994521141052246093, 0.104535527527332305, 120, 'Enticing Negolash - Baked Bread'),
(2289, 1, 0, 2562, -14653.8486328125, 146.2042694091796875, 2.14631199836730957, 4.886923789978027343, 0, 0, -0.64278697967529296, 0.766044974327087402, 120, 'Enticing Negolash - Baked Bread'),
(2289, 1, 0, 2562, -14656.138671875, 148.3673248291015625, 3.515635967254638671, 5.637413978576660156, 0, 0, -0.31730461120605468, 0.948323667049407958, 120, 'Enticing Negolash - Baked Bread');

-- SmartAI: Ruined Lifeboat (GO 2289) - On Quest 619 Reward - Summon Gameobject Group 0
DELETE FROM `smart_scripts` WHERE `entryorguid` = 2289 AND `source_type` = 1 AND `id` = 1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2289, 1, 1, 0, 20, 0, 100, 0, 619, 0, 0, 0, 0, 0, 241, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ruined Lifeboat - On Quest ''Enticing Negolash'' Rewarded - Summon Gameobject Group 0');
