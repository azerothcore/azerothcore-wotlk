-- DB update 2026_07_04_04 -> 2026_07_04_05
-- Update TotemCategories for Savage and Hateful totems
UPDATE `item_template` SET `TotemCategory` = 21 WHERE (`entry` IN (42593, 42594, 42595, 42596, 42601, 42606));
