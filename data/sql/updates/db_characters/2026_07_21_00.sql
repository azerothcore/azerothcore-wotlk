-- DB update 2026_07_18_00 -> 2026_07_21_00
DELETE FROM `mail_server_template` WHERE `id` IN (14646, 14647, 14648, 14649, 14650, 14651, 20938, 22888, 39713);
INSERT INTO `mail_server_template` (`id`, `senderEntry`, `moneyA`, `moneyH`, `subject`, `body`, `active`) VALUES
(14646, 19506, 0, 0, 'A Very Special Delivery', 'Thank you for your purchase of the World of Warcraft Collector''s Edition! As a special gift of appreciation, we would like to present you with this gift voucher. Turn it in to receive a little companion to join you on your quest for adventure and glory!', 1),
(14647, 19506, 0, 0, 'A Very Special Delivery', 'Thank you for your purchase of the World of Warcraft Collector''s Edition! As a special gift of appreciation, we would like to present you with this gift voucher. Turn it in to receive a little companion to join you on your quest for adventure and glory!', 1),
(14648, 19506, 0, 0, 'A Very Special Delivery', 'Thank you for your purchase of the World of Warcraft Collector''s Edition! As a special gift of appreciation, we would like to present you with this gift voucher. Turn it in to receive a little companion to join you on your quest for adventure and glory!', 1),
(14649, 19506, 0, 0, 'A Very Special Delivery', 'Thank you for your purchase of the World of Warcraft Collector''s Edition! As a special gift of appreciation, we would like to present you with this gift voucher. Turn it in to receive a little companion to join you on your quest for adventure and glory!', 1),
(14650, 19506, 0, 0, 'A Very Special Delivery', 'Thank you for your purchase of the World of Warcraft Collector''s Edition! As a special gift of appreciation, we would like to present you with this gift voucher. Turn it in to receive a little companion to join you on your quest for adventure and glory!', 1),
(14651, 19506, 0, 0, 'A Very Special Delivery', 'Thank you for your purchase of the World of Warcraft Collector''s Edition! As a special gift of appreciation, we would like to present you with this gift voucher. Turn it in to receive a little companion to join you on your quest for adventure and glory!', 1),
(20938, 19506, 0, 0, 'A Very Special Delivery', 'Thank you for your purchase of the World of Warcraft Collector''s Edition! As a special gift of appreciation, we would like to present you with this gift voucher. Turn it in to receive a little companion to join you on your quest for adventure and glory!', 1),
(22888, 19506, 0, 0, 'A Very Special Delivery', 'Thank you for your purchase of the World of Warcraft Collector''s Edition! As a special gift of appreciation, we would like to present you with this gift voucher. Turn it in to receive a little companion to join you on your quest for adventure and glory!', 1),
(39713, 19506, 0, 0, 'A Very Special Delivery', 'Thank you for your purchase of the World of Warcraft Collector''s Edition! As a special gift of appreciation, we would like to present you with this gift voucher. Turn it in to receive a little companion to join you on your quest for adventure and glory!', 1);

DELETE FROM `mail_server_template_items` WHERE `templateID` IN (14646, 14647, 14648, 14649, 14650, 14651, 20938, 22888, 39713);
INSERT INTO `mail_server_template_items` (`templateID`, `faction`, `item`, `itemCount`) VALUES
(14646, 'Alliance', 14646, 1), -- Goldshire Gift Voucher (Human)
(14647, 'Alliance', 14647, 1), -- Kharanos Gift Voucher (Dwarf, Gnome)
(14648, 'Alliance', 14648, 1), -- Dolanaar Gift Voucher (Night Elf)
(14649, 'Horde', 14649, 1), -- Razor Hill Gift Voucher (Orc, Troll)
(14650, 'Horde', 14650, 1), -- Bloodhoof Village Gift Voucher (Tauren)
(14651, 'Horde', 14651, 1), -- Brill Gift Voucher (Undead)
(20938, 'Horde', 20938, 1), -- Falconwing Square Gift Voucher (Blood Elf)
(22888, 'Alliance', 22888, 1), -- Azure Watch Gift Voucher (Draenei)
(39713, 'Alliance', 39713, 1), -- Ebon Hold Gift Voucher (Death Knight, Alliance)
(39713, 'Horde', 39713, 1); -- Ebon Hold Gift Voucher (Death Knight, Horde)

DELETE FROM `mail_server_template_conditions` WHERE `templateID` IN (14646, 14647, 14648, 14649, 14650, 14651, 20938, 22888, 39713);
INSERT INTO `mail_server_template_conditions` (`templateID`, `conditionType`, `conditionValue`) VALUES
(14646, 'Race', 1),
(14646, 'Class', 1503),
(14646, 'AccountFlags', 4),
(14647, 'Race', 68),
(14647, 'Class', 1503),
(14647, 'AccountFlags', 4),
(14648, 'Race', 8),
(14648, 'Class', 1503),
(14648, 'AccountFlags', 4),
(14649, 'Race', 130),
(14649, 'Class', 1503),
(14649, 'AccountFlags', 4),
(14650, 'Race', 32),
(14650, 'Class', 1503),
(14650, 'AccountFlags', 4),
(14651, 'Race', 16),
(14651, 'Class', 1503),
(14651, 'AccountFlags', 4),
(20938, 'Race', 512),
(20938, 'Class', 1503),
(20938, 'AccountFlags', 4),
(22888, 'Race', 1024),
(22888, 'Class', 1503),
(22888, 'AccountFlags', 4),
(39713, 'Class', 32),
(39713, 'AccountFlags', 4);
