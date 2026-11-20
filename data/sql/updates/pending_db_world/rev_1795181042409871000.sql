--
-- Zul'Gurub entrance snake pack: 3 or 4 snakes, at least one Razzashi Serpent and one Razzashi Adder.
-- It was 20 sub-pools under pool 448, one per arrangement, with 72 creature rows on 4 spawn points.
-- Now the 4 spawn points of the old 4-pack are one spawn group that limits the entries.
DELETE FROM `pool_creature` WHERE `pool_entry` IN (449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459, 460, 461, 462, 463, 464, 465, 466, 467, 468);
DELETE FROM `pool_pool` WHERE `mother_pool` = 448 AND `pool_id` IN (449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459, 460, 461, 462, 463, 464, 465, 466, 467, 468);
DELETE FROM `pool_template` WHERE `entry` IN (448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459, 460, 461, 462, 463, 464, 465, 466, 467, 468);

-- The spawn points take their entries from the group, not from their own list
DELETE FROM `creature_spawn_entry` WHERE `guid` IN (86939, 86940, 86941, 86942, 86943, 86944, 86945, 86946, 86947, 86948, 86949, 86950, 86951, 86952, 86953, 86954, 86955, 86956, 86957, 86958, 86959, 86960, 86961, 86962, 86963, 86964, 86965, 86966, 86967, 86968, 86969, 86970, 86971, 86972, 86973, 86974, 86975, 86976, 86977, 86978, 86979, 86980, 86981, 86982, 86983, 86984, 86985, 86986, 86987, 86988, 86989, 86990, 86991, 86992, 86993, 86994, 86995, 86996, 86997, 86998, 86999, 87000, 87001, 87002, 87003, 87004, 87005, 87006, 87007, 87008, 87009, 87010);
DELETE FROM `creature_formations` WHERE `memberGUID` IN (86939, 86940, 86941, 86942, 86943, 86944, 86945, 86946, 86947, 86948, 86949, 86950, 86951, 86952, 86953, 86954, 86955, 86956, 86957, 86958, 86959, 86960, 86961, 86962, 86967, 86968, 86969, 86970, 86971, 86972, 86973, 86974, 86975, 86976, 86977, 86978, 86979, 86980, 86981, 86982, 86983, 86984, 86985, 86986, 86987, 86988, 86989, 86990, 86991, 86992, 86993, 86994, 86995, 86996, 86997, 86998, 86999, 87000, 87001, 87002, 87003, 87004, 87005, 87006, 87007, 87008, 87009, 87010);
DELETE FROM `creature` WHERE `id` IN (11371, 11372) AND `guid` IN (86939, 86940, 86941, 86942, 86943, 86944, 86945, 86946, 86947, 86948, 86949, 86950, 86951, 86952, 86953, 86954, 86955, 86956, 86957, 86958, 86959, 86960, 86961, 86962, 86967, 86968, 86969, 86970, 86971, 86972, 86973, 86974, 86975, 86976, 86977, 86978, 86979, 86980, 86981, 86982, 86983, 86984, 86985, 86986, 86987, 86988, 86989, 86990, 86991, 86992, 86993, 86994, 86995, 86996, 86997, 86998, 86999, 87000, 87001, 87002, 87003, 87004, 87005, 87006, 87007, 87008, 87009, 87010);

DELETE FROM `spawn_group_template` WHERE `groupId` = 105;
INSERT INTO `spawn_group_template` (`groupId`, `groupName`, `groupFlags`) VALUES
(105, 'Zul''Gurub - Entrance Snake Pack', 0);

-- 86963 leads the formation and always spawns. 86964 is the point the old 3-packs 5/8 to 8/8 left out.
DELETE FROM `spawn_group` WHERE `groupId` = 105;
INSERT INTO `spawn_group` (`groupId`, `spawnType`, `spawnId`, `chance`) VALUES
(105, 0, 86963, 0),
(105, 0, 86964, 50),
(105, 0, 86965, 0),
(105, 0, 86966, 0);

DELETE FROM `spawn_group_entry` WHERE `groupId` = 105;
INSERT INTO `spawn_group_entry` (`groupId`, `spawnType`, `entry`, `minCount`, `maxCount`, `chance`) VALUES
(105, 0, 11371, 1, 0, 0), -- Razzashi Serpent
(105, 0, 11372, 1, 0, 0); -- Razzashi Adder
