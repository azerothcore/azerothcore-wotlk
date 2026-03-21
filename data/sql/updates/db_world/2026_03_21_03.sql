-- DB update 2026_03_21_02 -> 2026_03_21_03
--
DELETE FROM `command` WHERE `name`='learn all my quest';
DELETE FROM `command` WHERE `name`='learn all my trainer';
DELETE FROM `command` WHERE `name`='learn all my spells';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('learn all my quest', 2, 'Syntax: .learn all my quest  Learn all spells rewarded from quest for your class.'),
('learn all my trainer', 2, 'Syntax: .learn all my trainer  Learn all spells taught by trainers for your class.');
UPDATE `command` SET `help` = 'Syntax: .learn all my class  Learn all spells (trainer, talent, and quest rewards) for your class.' WHERE `name`='learn all my class';
