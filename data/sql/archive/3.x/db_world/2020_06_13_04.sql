-- DB update 2020_06_13_03 -> 2020_06_13_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_06_13_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_06_13_03 2020_06_13_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1547749856254633700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1547749856254633700');

DELETE FROM `achievement_reward_locale` WHERE `locale` = 'frFR';
INSERT INTO `achievement_reward_locale` (`ID`, `Locale`, `Subject`, `Text`) VALUES
(13, 'frFR', '', 'Toutes mes félicitations pour votre application à atteindre votre quatre-vingtième saison d\'aventures. Vous êtes indubitablement $gdévoué:dévouée; à la cause de l\'éradication du mal qui nous touche en Azeroth.\n\nEt bien que le voyage n\'ait pas été une mince affaire jusqu\'à présent, la véritable bataille nous attend encore.\n\nContinuez le combat !\n\nRhonin'),
(45, 'frFR', 'Vous avez bien bourlingué !', 'Eh ben, vous !\n\nEt moi qui croyais avoir tout vu sur ces terres gelées ! Le feu de l\'exploration brûle en vous. Cela saute à mes yeux de nain.\n\nPortez ce tabard avec fierté. De cette façon, vos amis sauront toujours à qui demander leur chemin en temps voulu !\n\nRestez bien en selle !\n\nBrann Barbe-de-bronze'),
(46, 'frFR', '', NULL),
(230, 'frFR', '', NULL),
(432, 'frFR', '', NULL),
(456, 'frFR', '', NULL),
(614, 'frFR', 'Pour l\'Alliance !', 'La guerre fait rage sur nos terres. Seuls les héros les plus courageux osent frapper la Horde en ses points les plus sensibles. Vous êtes l\'un d\'eux.\n\nLes coups que vous avez portés au commandement de la Horde vont nous permettre de lancer notre assaut final. La Horde fléchira sous la puissance de l\'Alliance.\n\nVos actes seront récompensés. Chevauchez avec fierté !\n\n— Votre roi'),
(619, 'frFR', 'Pour la Horde !', 'En ces temps troublés, nos souffrances engendrent de vrais héros. Vous êtes l\'un d\'eux.\n\nNous sommes en guerre. Vos efforts soutiennent notre cause en Azeroth. Vos hautes actions seront récompensées. Prenez ce prix d\'Orgrimmar et chevauchez vers la gloire.\n\nPour la Horde !\n\nChef de guerre Thrall'),
(714, 'frFR', '', NULL),
(762, 'frFR', '', NULL),
(870, 'frFR', '', NULL),
(871, 'frFR', '', NULL),
(876, 'frFR', 'Je vous surveille , enfent.', NULL),
(907, 'frFR', '', NULL),
(913, 'frFR', '', NULL),
(942, 'frFR', '', NULL),
(943, 'frFR', '', NULL),
(945, 'frFR', '', NULL),
(948, 'frFR', '', NULL),
(953, 'frFR', '', NULL),
(978, 'frFR', '', NULL),
(1015, 'frFR', '', NULL),
(1021, 'frFR', '', NULL),
(1038, 'frFR', '', NULL),
(1039, 'frFR', '', NULL),
(1174, 'frFR', '', NULL),
(1175, 'frFR', '', NULL),
(1250, 'frFR', '', NULL),
(1400, 'frFR', '', NULL),
(1402, 'frFR', '', NULL),
(1516, 'frFR', '', NULL),
(1563, 'frFR', '', NULL),
(1656, 'frFR', '', NULL),
(1657, 'frFR', '', NULL),
(1658, 'frFR', '', NULL),
(1681, 'frFR', '', NULL),
(1682, 'frFR', '', NULL),
(1683, 'frFR', '', NULL),
(1684, 'frFR', '', NULL),
(1691, 'frFR', '', NULL),
(1692, 'frFR', '', NULL),
(1693, 'frFR', '', NULL),
(1707, 'frFR', '', NULL),
(1784, 'frFR', '', NULL),
(1793, 'frFR', '', NULL),
(1956, 'frFR', 'Lectures studieuses', 'Félicitations ! Vous avez terminé d\'étudier « Les écoles de magie des arcanes ». En récompense de votre dévouement, veuillez trouver ci-joint le volume spécial qui termine la collection.\n\nJe pense que vous trouverez ce tome particulièrement divertissant. Mais je vous laisse le découvrir par vous-même.\n\nCordialement,\n\nRhonin'),
(2051, 'frFR', '', NULL),
(2054, 'frFR', '', NULL),
(2096, 'frFR', '', NULL),
(2136, 'frFR', '', NULL),
(2143, 'frFR', '', NULL),
(2144, 'frFR', '', NULL),
(2145, 'frFR', '', NULL),
(2186, 'frFR', '', NULL),
(2187, 'frFR', '', NULL),
(2188, 'frFR', '', NULL),
(2336, 'frFR', '', NULL),
(2516, 'frFR', '', NULL),
(2536, 'frFR', '', NULL),
(2537, 'frFR', '', NULL),
(2760, 'frFR', '', NULL),
(2761, 'frFR', '', NULL),
(2762, 'frFR', '', NULL),
(2763, 'frFR', '', NULL),
(2764, 'frFR', '', NULL),
(2765, 'frFR', '', NULL),
(2766, 'frFR', '', NULL),
(2767, 'frFR', '', NULL),
(2768, 'frFR', '', NULL),
(2769, 'frFR', '', NULL),
(2796, 'frFR', '', NULL),
(2797, 'frFR', '', NULL),
(2798, 'frFR', '', NULL),
(2816, 'frFR', '', NULL),
(2817, 'frFR', '', NULL),
(2903, 'frFR', '', NULL),
(2904, 'frFR', '', NULL),
(2957, 'frFR', '', NULL),
(2958, 'frFR', '', NULL),
(3036, 'frFR', '', NULL),
(3037, 'frFR', '', NULL),
(3117, 'frFR', '', NULL),
(3259, 'frFR', '', NULL),
(3316, 'frFR', '', NULL),
(3478, 'frFR', '', NULL),
(3656, 'frFR', '', NULL),
(3857, 'frFR', 'Maître de l\'île des Conquérants', NULL),
(3957, 'frFR', 'Maître de l\'île des Conquérants', NULL),
(4078, 'frFR', '', NULL),
(4079, 'frFR', 'Une offrande à l\'immortalité', NULL),
(4080, 'frFR', '', NULL),
(4156, 'frFR', 'Une offrande à l\'immortalité', NULL),
(4477, 'frFR', '', NULL),
(4478, 'frFR', 'Groupe improvisé', '$gCher membre assidu:Chère membre assidue;,\n\nnous aimerions récompenser votre ténacité à parcourir les donjons avec des personnes que vous n\'aviez probablement jamais rencontrées auparavant. Vous avez peut-être même appris les ficelles du métier à quelques petits nouveaux.\n\nBref, nous avons entendu dire que vous aimiez les groupes improvisés. Alors voici le petit Groopy, qui proclamera à tout le monde : « Vous savez quoi ? J\'suis groupé ! »\n\nAvec toute notre affection,\n\nVos amis de l\'équipe de développement de WoW'),
(4530, 'frFR', '', NULL),
(4583, 'frFR', '', NULL),
(4584, 'frFR', '', NULL),
(4597, 'frFR', '', NULL),
(4598, 'frFR', '', NULL),
(4602, 'frFR', '', NULL),
(4603, 'frFR', 'Gloire à l\'écumeur de raids de la Couronne de glace', NULL),
(4784, 'frFR', '', NULL),
(4785, 'frFR', '', NULL);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
