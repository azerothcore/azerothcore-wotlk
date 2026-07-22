-- DB update 2026_07_22_09 -> 2026_07_22_10
--
UPDATE `updates` SET `state` = 'ARCHIVED' WHERE `name` LIKE '2025_%';
