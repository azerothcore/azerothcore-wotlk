-- Fixes issue #21682

-- Pack .go xyz 1024 1197 440 578
-- 3 construct and 1 mage
-- Mage doesn't appear to link in video
DELETE FROM `creature_formations` WHERE LeaderGUID = 101933;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(101933, 101933, 0, 0, 3, 0, 0),
(101933, 101924, 0, 0, 3, 0, 0),
(101933, 101922, 0, 0, 3, 0, 0);

-- Pack .go xyz 1052 922 440 578
-- 3 construct and 1 mage
-- Mage doesn't appear to link in video
DELETE FROM `creature_formations` WHERE LeaderGUID = 102064;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(102064, 102064, 0, 0, 3, 0, 0),
(102064, 101974, 0, 0, 3, 0, 0),
(102064, 101967, 0, 0, 3, 0, 0);

-- Pack .go xyz 1070 1104 433 578
-- 3 mages and one Construct
-- all appear to link
DELETE FROM `creature_formations` WHERE LeaderGUID = 101918;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(101918, 101918, 0, 0, 3, 0, 0),
(101918, 101898, 0, 0, 3, 0, 0),
(101918, 101909, 0, 0, 3, 0, 0),
(101918, 101897, 0, 0, 3, 0, 0);

-- Pack .go xyz 1121 1110 433 578
-- 4 mages and one Construct
-- all appear to link
DELETE FROM `creature_formations` WHERE LeaderGUID = 101937;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(101937, 101937, 0, 0, 3, 0, 0),
(101937, 101915, 0, 0, 3, 0, 0),
(101937, 101903, 0, 0, 3, 0, 0),
(101937, 101914, 0, 0, 3, 0, 0),
(101937, 101904, 0, 0, 3, 0, 0);

-- Pack .go xyz 1131 995 433 578
-- 4 mages and one Construct
-- all appear to link
DELETE FROM `creature_formations` WHERE LeaderGUID = 101919;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(101919, 101919, 0, 0, 3, 0, 0),
(101919, 101912, 0, 0, 3, 0, 0),
(101919, 101910, 0, 0, 3, 0, 0),
(101919, 101899, 0, 0, 3, 0, 0),
(101919, 101900, 0, 0, 3, 0, 0);

-- Pack .go xyz 1079 997 433 578
-- 3 mages and one Construct
-- all appear to link
DELETE FROM `creature_formations` WHERE LeaderGUID = 101917;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(101917, 101917, 0, 0, 3, 0, 0),
(101917, 101895, 0, 0, 3, 0, 0),
(101917, 101896, 0, 0, 3, 0, 0),
(101917, 101907, 0, 0, 3, 0, 0);
