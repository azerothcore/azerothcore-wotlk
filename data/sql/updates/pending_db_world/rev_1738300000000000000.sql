-- Codestyle error test file
-- Each section should trigger a specific error

-- Test 1: Missing backticks (should fail backtick check)
DELETE FROM creature WHERE guid = 99999999;

-- Test 2: Missing DELETE before INSERT (should fail INSERT/DELETE safety check)
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (99999999, 0);

-- Test 3: Double semicolon (should fail SQL check)
DELETE FROM `creature_addon` WHERE `guid` = 99999998;;

-- Test 4: Tab character (should fail SQL check)
	DELETE FROM `creature_addon` WHERE `guid` = 99999997;

-- Test 5: Missing semicolon on SET
SET @ENTRY := 99999999

-- Test 6: Trailing whitespace (should fail trailing whitespace check)
DELETE FROM `creature_addon` WHERE `guid` = 99999996;

-- Test 7: Missing comma in multi-line VALUES (should fail semicolon check)
DELETE FROM `creature` WHERE `guid` IN (99999990, 99999991);
INSERT INTO `creature` (`guid`, `id1`, `map`)
VALUES
(99999990, 1, 0)
(99999991, 1, 0);

-- Test 8: Indented comment mentioning table names (should NOT fail - tests our fix)
    -- This references creature_addon and other tables without backticks

-- Test 9: Inline comment (should NOT fail - tests our fix)
DELETE FROM `creature_addon` WHERE `guid` = 99999995; -- Delete the creature_addon entry
