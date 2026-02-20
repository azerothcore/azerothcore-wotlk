-- DB update 2026_01_03_03 -> 2026_01_04_00
-- Archive all 2024 updates
UPDATE `updates` SET `state` = 'ARCHIVED' WHERE `name` LIKE '2024_%';
