-- Test file designed to trigger ALL codestyle check failures
USE azerothcore_world;

-- Multiple semicolons for SQL codestyle check
INSERT INTO `test_table` VALUES (1);;

-- Tab character instead of spaces for SQL codestyle check
    UPDATE test_table SET value = 1;

-- EntryOrGuid violation for SQL codestyle check  
UPDATE `smart_scripts` SET EntryOrGuid = 123 WHERE id = 1;

-- broadcast_text violation for SQL codestyle check
INSERT INTO `broadcast_text` (`ID`, `Text`) VALUES (1, 'test');

-- Missing backticks for backtick check
SELECT entry FROM creature_template WHERE name = 'test';

-- Trailing whitespace (line below has spaces at end)    
UPDATE `test_table` SET `value` = 1 WHERE `id` = 1;

-- INSERT without DELETE for safety check
INSERT INTO `creature_template` (`entry`, `name`) VALUES (999999, 'Test Creature');

-- DELETE from protected table for safety check
DELETE FROM `creature_template` WHERE `entry` = 999999;

-- REPLACE INTO statement for safety check
REPLACE INTO `test_table` (`id`, `value`) VALUES (1, 100);

-- Invalid INSERT syntax for safety check
INSERT  INTO`test_table` VALUES (1);

-- Invalid DELETE syntax for safety check  
DELETE  FROM`test_table` WHERE id = 1;

-- Missing semicolon for semicolon check
UPDATE `test_table` SET `value` = 2 WHERE `id` = 1

-- Non-InnoDB engine for engine check
CREATE TABLE `test_engine` (
    `id` INT PRIMARY KEY
) ENGINE=MyISAM;

-- Bitwise mask violations for bitwise check
UPDATE `creature` SET `npcflag` = 123 WHERE `guid` = 1;
INSERT INTO `creature` (`guid`, `id`, `npcflag`) VALUES (1, 2, 456);

-- Multiple queries that could be consolidated for compact queries check
DELETE FROM `test_table` WHERE `id` = 1;
DELETE FROM `test_table` WHERE `id` = 2;
DELETE FROM `test_table` WHERE `id` = 3;

INSERT INTO `test_table` (`id`, `name`) VALUES (1, 'test1');
INSERT INTO `test_table` (`id`, `name`) VALUES (2, 'test2');
INSERT INTO `test_table` (`id`, `name`) VALUES (3, 'test3');

UPDATE `test_table` SET `active` = 1 WHERE `id` = 1;
UPDATE `test_table` SET `active` = 1 WHERE `id` = 2;
UPDATE `test_table` SET `active` = 1 WHERE `id` = 3;


-- Multiple blank lines above (violation for blank lines check)

-- File ends without proper newline (will be violation for newline check)