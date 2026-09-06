-- DB update 2025_07_20_00 -> 2025_07_20_01
-- Stackable debuffs
SET @flag := 4194304;

DELETE FROM `spell_custom_attr` WHERE `spell_id` IN (50370,63615,63612,63673,62326,64375,64667,64666,64374,18958,69308,70964,70189,71127,70435,71154,71257);
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES
(50370, @flag), -- Sunder Armor; Ulduar
(63615, @flag), -- Ravage Armor
(63612, @flag), -- Lightning Brand
(63673, @flag),
(62326, @flag), -- Low Blow
(64375, @flag), -- Rip Flesh
(64667, @flag),
(64666, @flag), -- Savage Pounce
(64374, @flag),
(18958, @flag), -- Flame Lash; Onyxia
(69308, @flag),
(70964, @flag), -- Shield Bash; Icecrown Citadel
(70189, @flag), -- Poison Spit
(71127, @flag), -- Mortal Wound (can be abused if you pull the 2 dogs, stacks will never go over 1)
(70435, @flag), -- Rend Flesh
(71154, @flag),
(71257, @flag); -- Barbaric Strike
