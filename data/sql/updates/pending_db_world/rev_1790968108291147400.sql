-- Kirin'Var spirits (Dathric, Belmara, Luminrath, Cohlien) turn neutral for players who took their quest.
-- Sniffed: forced reaction 3 (Neutral) on factions 1006-1009 while the quest is accepted or rewarded, in Netherstorm only.
DELETE FROM `spell_area` WHERE `spell` BETWEEN 36216 AND 36219;
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `racemask`, `gender`, `autocast`, `quest_start_status`, `quest_end_status`) VALUES
(36216, 3523, 10182, 0, 0, 0, 2, 1, 74, 11), -- Kirin Tor Spirits (Dathric) - Battle-Mage Dathric
(36217, 3523, 10305, 0, 0, 0, 2, 1, 74, 11), -- Kirin Tor Spirits (Belmara) - Abjurist Belmara
(36218, 3523, 10306, 0, 0, 0, 2, 1, 74, 11), -- Kirin Tor Spirits (Luminrath) - Conjurer Luminrath
(36219, 3523, 10307, 0, 0, 0, 2, 1, 74, 11); -- Kirin Tor Spirits (Cohlien) - Cohlien Frostweaver
