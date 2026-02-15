-- DB update 2026_02_15_01 -> 2026_02_15_02
--
DELETE FROM `acore_string` WHERE `entry` IN (5089, 5090, 5091, 5092, 5093, 5094, 5095, 5096, 5097, 5098, 5099, 5100, 5101, 5102, 5103, 5104, 5105, 5106, 5107, 5108, 5109, 5110);
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(5089, 'Quest {} cannot be taken. Reasons:'),
(5090, '  - Quest is disabled.'),
(5091, '  - Quest has already been taken or completed.'),
(5092, '  - Class requirement not met.'),
(5093, '  - Race requirement not met.'),
(5094, '  - Player level too low (required: {}).'),
(5095, '  - Player level too high (max: {}).'),
(5096, '  - Skill requirement not met.'),
(5097, '  - Reputation requirement not met.'),
(5098, '  - Previous quest in chain not completed.'),
(5099, '  - Already on a timed quest.'),
(5100, '  - Exclusive group quest conflict.'),
(5101, '  - Next quest in chain already started.'),
(5102, '  - Previous chain quest still active.'),
(5103, '  - Breadcrumb quest conflict.'),
(5104, '  - Daily quest not available today.'),
(5105, '  - Weekly quest already completed this week.'),
(5106, '  - Monthly quest already completed this month.'),
(5107, '  - Seasonal quest already completed this season.'),
(5108, '  - Condition requirements not met:'),
(5109, '  - Quest log is full.'),
(5110, '    - Condition not met: type {} value1: {} value2: {} value3: {}');
