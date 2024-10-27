DELETE FROM `player_factionchange_items` WHERE `alliance_id` IN (28379, 28380) AND `horde_id` IN (28377, 28378);
INSERT INTO `player_factionchange_items` (`alliance_id`, `alliance_comment`, `horde_id`, `horde_comment`) VALUES
(28379, 'Sergeant\'s Heavy Cape', 28378, 'Sergeant\'s Heavy Cape'),
(28380, 'Sergeant\'s Heavy Cloak', 28377, 'Sergeant\'s Heavy Cloak');
