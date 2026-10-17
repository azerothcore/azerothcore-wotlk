-- DB update 2026_07_21_00 -> 2026_07_22_00
--
UPDATE `updates` SET `state` = 'ARCHIVED' WHERE `name` LIKE '2024_%';
UPDATE `updates` SET `state` = 'ARCHIVED' WHERE `name` LIKE '2025_%';
