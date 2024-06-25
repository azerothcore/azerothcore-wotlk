-- Durnholde Lodges (First one was already linked)
UPDATE `creature_formations` SET `groupAI` = 3 WHERE `leaderGUID` = 83929;

DELETE FROM `creature_formations` WHERE `leaderGUID` IN (83927,83922,83948,77820);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
-- 2
(83927, 83927, 0, 0, 3, 0, 0),
(83927, 83926, 0, 0, 3, 0, 0),
(83927, 83987, 0, 0, 3, 0, 0),
(83927, 77817, 0, 0, 3, 0, 0),
(83927, 83934, 0, 0, 3, 0, 0), -- patrol in the house, pretty sure it's supposed to be one of the 2 npcs from the back and not a 5th one
-- 3
(83922, 83922, 0, 0, 3, 0, 0),
(83922, 83923, 0, 0, 3, 0, 0),
(83922, 77818, 0, 0, 3, 0, 0),
(83922, 83924, 0, 0, 3, 0, 0),
-- 4
(83948, 83948, 0, 0, 3, 0, 0),
(83948, 83949, 0, 0, 3, 0, 0),
(83948, 77819, 0, 0, 3, 0, 0),
(83948, 83959, 0, 0, 3, 0, 0),
-- 5
(77820, 77820, 0, 0, 3, 0, 0),
(77820, 77854, 0, 0, 3, 0, 0),
(77820, 83955, 0, 0, 3, 0, 0),
(77820, 83956, 0, 0, 3, 0, 0),
(77820, 83958, 0, 0, 3, 0, 0); -- again, 5th one
