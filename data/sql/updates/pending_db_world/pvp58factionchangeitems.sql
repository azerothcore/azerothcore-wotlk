-- Champion's Sanctuary and Lieutenant Commander's Sanctuary (Druid)
DELETE FROM `player_factionchange_items` WHERE `alliance_id` IN (16393, 16397, 16423, 16422, 16424, 16421) OR `horde_id` IN (16494, 16496, 16501, 16503, 16504);
INSERT INTO `player_factionchange_items` (`alliance_id`, `alliance_comment`, `horde_id`, `horde_comment`) VALUES
(16393, 'Knight-Lieutenant\'s Dragonhide Footwraps', 16494, 'Blood Guard\'s Dragonhide Boots'),
(16397, 'Knight-Lieutenant\'s Dragonhide Gloves', 16496, 'Blood Guard\'s Dragonhide Gauntlets'),
(16423, 'Lieutenant Commander\'s Dragonhide Epaulets', 16501, 'Champion\'s Dragonhide Spaulders'),
(16422, 'Knight-Captain\'s Dragonhide Leggings', 16502, 'Legionnaire\'s Dragonhide Trousers'),
(16424, 'Lieutenant Commander\'s Dragonhide Shroud', 16503, 'Champion\'s Dragonhide Helm'),
(16421, 'Knight-Captain\'s Dragonhide Tunic', 16504, 'Legionnaire\'s Dragonhide Breastplate');

-- Champion's Pursuit and Lieutenant Commander's Pursuit (Hunter)
DELETE FROM `player_factionchange_items` WHERE `alliance_id` IN (16401, 16403, 16425, 16426, 16427, 16428) OR `horde_id` IN (16525, 16526, 16527, 16528, 16530, 16531);
INSERT INTO `player_factionchange_items` (`alliance_id`, `alliance_comment`, `horde_id`, `horde_comment`) VALUES
(16401, 'Knight-Lieutenant\'s Chain Boots', 16531, 'Blood Guard\'s Chain Boots'),
(16403, 'Knight-Lieutenant\'s Chain Gauntlets', 16530, 'Blood Guard\'s Chain Gauntlets'),
(16425, 'Knight-Captain\'s Chain Hauberk', 16525, 'Legionnaire\'s Chain Breastplate'),
(16426, 'Knight-Captain\'s Chain Leggings', 16527, 'Legionnaire\'s Chain Leggings'),
(16427, 'Lieutenant Commander\'s Chain Pauldrons', 16528, 'Champion\'s Chain Pauldrons'),
(16428, 'Lieutenant Commander\'s Chain Helmet', 16526, 'Champion\'s Chain Headguard');

-- Champion's Regalia and Lieutenant Commander's Regalia (Mage)
DELETE FROM `player_factionchange_items` WHERE `alliance_id` IN (16369, 16391, 16413, 16414, 16415, 16416) OR `horde_id` IN (16485, 16487, 16489, 16490, 16491, 16492);
INSERT INTO `player_factionchange_items` (`alliance_id`, `alliance_comment`, `horde_id`, `horde_comment`) VALUES
(16369, 'Knight-Lieutenant\'s Silk Boots', 16485, 'Blood Guard\'s Silk Footwraps'),
(16391, 'Knight-Lieutenant\'s Silk Gloves',  16487, 'Blood Guard\'s Silk Gloves'),
(16413, 'Knight-Captain\'s Silk Raiment', 16491, 'Legionnaire\'s Silk Robes'),
(16414, 'Knight-Captain\'s Silk Leggings', 16490, 'Legionnaire\'s Silk Pants'),
(16415, 'Lieutenant Commander\'s Silk Spaulders', 16492, 'Champion\'s Silk Shoulderpads'),
(16416, 'Lieutenant Commander\'s Crown', 16489, 'Champion\'s Silk Hood');

-- Champion's Raiment and Lieutenant Commander's Raiment (Priest)
DELETE FROM `player_factionchange_items` WHERE `alliance_id` IN (17594, 17596, 17598, 17599, 17600, 17601) OR `horde_id` IN (17610, 17611, 17612, 17613, 17616, 17617);
INSERT INTO `player_factionchange_items` (`alliance_id`, `alliance_comment`, `horde_id`, `horde_comment`) VALUES
(17594, 'Knight-Lieutenant\'s Satin Boots', 17616, 'Blood Guard\'s Satin Boots'),
(17596, 'Knight-Lieutenant\'s Satin Gloves', 17617, 'Blood Guard\'s Satin Gloves'),
(17598, 'Lieutenant Commander\'s Diadem', 17610, 'Champion\'s Satin Cowl'),
(17599, 'Knight-Captain\'s Satin Leggings', 17611, 'Legionnaire\'s Satin Trousers'),
(17600, 'Knight-Captain\'s Satin Robes', 17612, 'Legionnaire\'s Satin Vestments'),
(17601, 'Lieutenant Commander\'s Satin Amice', 17613, 'Champion\'s Satin Shoulderpads');

-- Champion's Vestments and Lieutenant Commander's Vestments (Rogue)
DELETE FROM `player_factionchange_items` WHERE `alliance_id` IN (16392, 16396, 16417, 16418, 16419, 16420) OR `horde_id` IN (16498, 16499, 16505, 16506, 16507, 16508);
INSERT INTO `player_factionchange_items` (`alliance_id`, `alliance_comment`, `horde_id`, `horde_comment`) VALUES
(16392, 'Knight-Lieutenant\'s Leather Boots', 16498, 'Blood Guard\'s Leather Treads'),
(16396, 'Knight-Lieutenant\'s Leather Gauntlets', 16499, 'Blood Guard\'s Leather Vices'),
(16417, 'Knight-Captain\'s Leather Armor', 16505, 'Legionnaire\'s Leather Hauberk'),
(16418, 'Lieutenant Commander\'s Leather Veil', 16506, 'Champion\'s Leather Headguard'),
(16419, 'Knight-Captain\'s Leather Legguards', 16508, 'Legionnaire\'s Leather Leggings'),
(16420, 'Lieutenant Commander\'s Leather Spaulders', 16507, 'Champion\'s Leather Mantle');

-- Lieutenant Commander's Threads and Champion's Threads (Warlock)
DELETE FROM `player_factionchange_items` WHERE `alliance_id` IN (17562, 17564, 17566, 17547, 16568, 17569) OR `horde_id` IN (17570, 17571, 17572, 17573, 17576, 17577);
INSERT INTO `player_factionchange_items` (`alliance_id`, `alliance_comment`, `horde_id`, `horde_comment`) VALUES
(17562, 'Knight-Lieutenant\'s Dreadweave Boots', 17576, 'Blood Guard\'s Dreadweave Boots'),
(17564, 'Knight-Lieutenant\'s Dreadweave Gloves', 17577, 'Blood Guard\'s Dreadweave Gloves'),
(17566, 'Lieutenant Commander\'s Headguard', 17570, 'Champion\'s Dreadweave Hood'),
(17567, 'Knight-Captain\'s Dreadweave Leggings', 17571, 'Legionnaire\'s Dreadweave Leggings'),
(17568, 'Knight-Captain\'s Dreadweave Robe', 17572, 'Legionnaire\'s Dreadweave Robe'),
(17569, 'Lieutenant Commander\'s Dreadweave Mantle', 17573, 'Champion\'s Dreadweave Shoulders');

-- Champion's Battlegear and Lieutenant Commander's Battlegear (Warrior)
DELETE FROM `player_factionchange_items` WHERE `alliance_id` IN (16405, 16406, 16429, 16430, 16431, 16432) OR `horde_id` IN (16509, 16510, 16513, 16514, 16515, 16516);
INSERT INTO `player_factionchange_items` (`alliance_id`, `alliance_comment`, `horde_id`, `horde_comment`) VALUES
(16405, 'Knight-Lieutenant\'s Plate Boots', 16509, 'Blood Guard\'s Plate Boots'),
(16406, 'Knight-Lieutenant\'s Plate Gauntlets', 16510, 'Blood Guard\'s Plate Gloves'),
(16429, 'Lieutenant Commander\'s Plate Helm',16514, 'Champion\'s Plate Headguard'),
(16430, 'Knight-Captain\'s Plate Chestguard',  16513, 'Legionnaire\'s Plate Armor'),
(16431, 'Knight-Captain\'s Plate Leggings', 16515, 'Legionnaire\'s Plate Legguards'),
(16432, 'Lieutenant Commander\'s Plate Pauldrons', 16516, 'Champion\'s Plate Pauldrons');
