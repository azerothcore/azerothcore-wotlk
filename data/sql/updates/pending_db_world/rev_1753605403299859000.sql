--
ALTER TABLE `playercreateinfo_item`
    ADD COLUMN `CollectorEdition` TINYINT UNSIGNED NOT NULL DEFAULT '0' AFTER `amount`;

DELETE FROM `playercreateinfo_item` WHERE `CollectorEdition` = 1;
INSERT INTO `playercreateinfo_item` (`race`, `class`, `itemid`, `amount`, `CollectorEdition`, `Note`) VALUES
(1, 0, 14646, 1, 1, 'Goldshire Gift Voucher'),
(3, 0, 14647, 1, 1, 'Kharanos Gift Voucher'),
(7, 0, 14647, 1, 1, 'Kharanos Gift Voucher'),
(4, 0, 14648, 1, 1, 'Dolanaar Gift Voucher'),
(2, 0, 14649, 1, 1, 'Razor Hill Gift Voucher'),
(8, 0, 14649, 1, 1, 'Razor Hill Gift Voucher'),
(6, 0, 14650, 1, 1, 'Bloodhoof Village Gift Voucher'),
(5, 0, 14651, 1, 1, 'Brill Gift Voucher'),
(10, 0, 20938, 1, 1, 'Falconwing Square Gift Voucher'),
(11, 0, 22888, 1, 1, 'Azure Watch Gift Voucher'),
(0, 6, 39713, 1, 1, 'Ebon Hold Gift Voucher');
