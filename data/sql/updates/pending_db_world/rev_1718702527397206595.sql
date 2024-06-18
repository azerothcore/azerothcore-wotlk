--
UPDATE `command` SET `help` = REPLACE(`help`, 'trigered', 'triggered') WHERE `name` like 'cast%';
