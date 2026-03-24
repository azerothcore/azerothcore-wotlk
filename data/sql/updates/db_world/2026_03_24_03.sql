-- DB update 2026_03_24_02 -> 2026_03_24_03
-- https://eu.forums.blizzard.com/en/wow/t/unnerf-unholy-dk-pet-names-plz/113162
-- Removes extra 'Stone' from First names for DK Ghouls
DELETE FROM `pet_name_generation` WHERE `id`=261 AND `word` = 'Stone' AND `entry` = 26125 AND `half` = 0;

-- Updates last name 'rawler' to 'crawler' for DK Ghouls
UPDATE `pet_name_generation` SET `word` = 'crawler' WHERE  `id` = 308 AND `word` = 'rawler' AND `entry` = 26125 AND `half` = 1;
