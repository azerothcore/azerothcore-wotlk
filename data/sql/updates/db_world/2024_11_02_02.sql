-- DB update 2024_11_02_01 -> 2024_11_02_02
DELETE FROM `gameobject_queststarter` WHERE `id` = 142122 AND `quest` IN (2781, 2875);

INSERT INTO `gameobject_queststarter` (`id`, `quest`) VALUES 
(142122, 2781), 
(142122, 2875);
