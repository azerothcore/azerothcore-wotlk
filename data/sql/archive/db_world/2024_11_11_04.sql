-- DB update 2024_11_11_03 -> 2024_11_11_04
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (-40568, -40575, -40572, -40567, -40573, -40576);
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(-40568, -40582, 0, 'Unstable Flask of the Elder'),
(-40575, -40587, 0, 'Unstable Flask of the Soldier'),
(-40572, -40580, 0, 'Unstable Flask of the Beast'),
(-40567, -40577, 0, 'Unstable Flask of the Bandit'),
(-40567, -40579, 0, 'Unstable Flask of the Bandit'),
(-40573, -40586, 0, 'Unstable Flask of the Physician'),
(-40576, -40588, 0, 'Unstable Flask of the Sorcerer'),
(-40576, -40763, 0, 'Unstable Flask of the Sorcerer');

DELETE FROM `spell_area` WHERE `spell` IN (40567, 40568, 40572, 40573, 40575, 40576, 40577, 40579, 40580, 40582, 40586, 40587, 40588, 40763);
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `racemask`, `gender`, `autocast`, `quest_start_status`, `quest_end_status`) VALUES
(40577, 3522, 0, 0, 40567, 0, 2, 1, 0, 0),
(40577, 3923, 0, 0, 40567, 0, 2, 1, 0, 0),
(40579, 3522, 0, 0, 40567, 0, 2, 1, 0, 0),
(40579, 3923, 0, 0, 40567, 0, 2, 1, 0, 0),
(40580, 3522, 0, 0, 40572, 0, 2, 1, 0, 0),
(40580, 3923, 0, 0, 40572, 0, 2, 1, 0, 0),
(40582, 3522, 0, 0, 40568, 0, 2, 1, 0, 0),
(40582, 3923, 0, 0, 40568, 0, 2, 1, 0, 0),
(40586, 3522, 0, 0, 40573, 0, 2, 1, 0, 0),
(40586, 3923, 0, 0, 40573, 0, 2, 1, 0, 0),
(40587, 3522, 0, 0, 40575, 0, 2, 1, 0, 0),
(40587, 3923, 0, 0, 40575, 0, 2, 1, 0, 0),
(40588, 3522, 0, 0, 40576, 0, 2, 1, 0, 0),
(40588, 3923, 0, 0, 40576, 0, 2, 1, 0, 0),
(40763, 3522, 0, 0, 40576, 0, 2, 1, 0, 0),
(40763, 3923, 0, 0, 40576, 0, 2, 1, 0, 0);
