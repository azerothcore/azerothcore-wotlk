-- DB update 2023_04_24_00 -> 2023_05_23_00
--
ALTER TABLE `characters` MODIFY `name` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL AFTER `account`;
