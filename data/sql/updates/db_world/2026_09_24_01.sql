-- DB update 2026_09_24_00 -> 2026_09_24_01
-- Jekyll Flandring
DELETE FROM `npc_vendor` WHERE `entry` = 13219 AND `item` IN (19483);
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `VerifiedBuild`) VALUES
(13219, 0, 19483, 0, 0, 0, 54261); -- Peeling the Onion
UPDATE `npc_vendor` SET `VerifiedBuild` = 54261 WHERE `entry` = 13219 AND `item` IN (17348, 17351, 19029, 19031, 19046, 19083, 19085, 19087, 19088, 19089, 19090, 19095, 19096, 19099, 19101, 19103, 19301, 19307, 19318, 19319, 19320);
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 23) AND (`SourceGroup` = 13219) AND (`SourceEntry` = 19483);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(23, 13219, 19483, 0, 0, 8, 0, 7161, 0, 0, 0, 0, 0, '', 'Jekyll Flandring will not sell Peeling the Onion until the player has completed \'Proving Grounds\''),
(23, 13219, 19483, 0, 0, 2, 0, 19483, 1, 0, 1, 0, 0, '', 'Jekyll Flandring will not sell Peeling the Onion if the player has it in inventory');

-- Baxter
DELETE FROM `npc_vendor` WHERE `entry` = 18988 AND `item` IN (159, 2678, 30817);
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `VerifiedBuild`) VALUES
(18988, 0, 159, 0, 0, 0, 53788), -- Refreshing Spring Water
(18988, 0, 2678, 0, 0, 0, 53788), -- Mild Spices
(18988, 0, 30817, 0, 0, 0, 53788); -- Simple Flour

-- Fingin
DELETE FROM `npc_vendor` WHERE `entry` = 20121 AND `item` IN (21927);
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `VerifiedBuild`) VALUES
(20121, 0, 21927, 0, 0, 0, 53788); -- Instant Poison VII
UPDATE `npc_vendor` SET `VerifiedBuild` = 53788 WHERE `entry` = 20121 AND `item` IN (2892, 2893, 6947, 6949, 6950, 8926, 8927, 8928, 8984, 8985, 10918, 10920, 10921, 10922, 20844, 21835, 22053, 43230, 43232, 43234);

-- Barleybrew Apprentice
DELETE FROM `npc_vendor` WHERE `entry` = 23482 AND `item` IN (46400);
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `VerifiedBuild`) VALUES
(23482, 0, 46400, 0, 0, 0, 45613); -- Barleybrew Gold
UPDATE `npc_vendor` SET `VerifiedBuild` = 45613 WHERE `entry` = 23482 AND `item` IN (33028, 33029, 33030);

-- Thunderbrew Apprentice
DELETE FROM `npc_vendor` WHERE `entry` = 23510 AND `item` IN (46399);
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `VerifiedBuild`) VALUES
(23510, 0, 46399, 0, 0, 0, 45613); -- Thunder's Plunder
UPDATE `npc_vendor` SET `VerifiedBuild` = 45613 WHERE `entry` = 23510 AND `item` IN (33031, 33032, 33033);

-- Gordok Brew Apprentice
DELETE FROM `npc_vendor` WHERE `entry` = 23511 AND `item` IN (46403);
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `VerifiedBuild`) VALUES
(23511, 0, 46403, 0, 0, 0, 45613); -- Chuganpug's Delight
UPDATE `npc_vendor` SET `VerifiedBuild` = 45613 WHERE `entry` = 23511 AND `item` IN (33034, 33035, 33036);

-- Arlen Lochlan
DELETE FROM `npc_vendor` WHERE `entry` = 23522 AND `item` IN (33449, 35950);
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `VerifiedBuild`) VALUES
(23522, 0, 33449, 0, 0, 0, 45613), -- Crusty Flatbread
(23522, 0, 35950, 0, 0, 0, 45613); -- Sweet Potato Bread
UPDATE `npc_vendor` SET `VerifiedBuild` = 45613 WHERE `entry` = 23522 AND `item` IN (4540, 4541, 4542, 4544, 4601, 8950, 27855, 33043);

-- T'chali's Voodoo Brewery Apprentice
DELETE FROM `npc_vendor` WHERE `entry` = 23533 AND `item` IN (46401);
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `VerifiedBuild`) VALUES
(23533, 0, 46401, 0, 0, 0, 45613); -- Crimson Stripe
UPDATE `npc_vendor` SET `VerifiedBuild` = 45613 WHERE `entry` = 23533 AND `item` IN (34020, 34021, 34022);

-- Uta Roughdough
DELETE FROM `npc_vendor` WHERE `entry` = 23603 AND `item` IN (33449, 35950);
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `VerifiedBuild`) VALUES
(23603, 0, 33449, 0, 0, 0, 45613), -- Crusty Flatbread
(23603, 0, 35950, 0, 0, 0, 45613); -- Sweet Potato Bread
UPDATE `npc_vendor` SET `VerifiedBuild` = 45613 WHERE `entry` = 23603 AND `item` IN (4540, 4541, 4542, 4544, 4601, 8950, 27855, 33043);

-- Agnes Farwithers
DELETE FROM `npc_vendor` WHERE `entry` = 23604 AND `item` IN (33443, 35952);
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `VerifiedBuild`) VALUES
(23604, 0, 33443, 0, 0, 0, 45613), -- Sour Goat Cheese
(23604, 0, 35952, 0, 0, 0, 45613); -- Briny Hardcheese
UPDATE `npc_vendor` SET `VerifiedBuild` = 45613 WHERE `entry` = 23604 AND `item` IN (414, 422, 1707, 2070, 3927, 8932, 27857, 34065);

-- Bron
DELETE FROM `npc_vendor` WHERE `entry` = 23605 AND `item` IN (33454, 35953);
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `VerifiedBuild`) VALUES
(23605, 0, 33454, 0, 0, 0, 45613), -- Salted Venison
(23605, 0, 35953, 0, 0, 0, 45613); -- Mead Basted Caribou
UPDATE `npc_vendor` SET `VerifiedBuild` = 45613 WHERE `entry` = 23605 AND `item` IN (117, 2287, 3770, 3771, 4599, 8952, 27854, 33023, 33024, 33025, 33026, 34063, 34064);

-- Bartender Jason Goodhutch
DELETE FROM `npc_vendor` WHERE `entry` = 24333 AND `item` IN (33444, 33445, 35954);
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `VerifiedBuild`) VALUES
(24333, 0, 33444, 0, 0, 0, 52237), -- Pungent Seal Whey
(24333, 0, 33445, 0, 0, 0, 52237), -- Honeymint Tea
(24333, 0, 35954, 0, 0, 0, 52237); -- Sweetened Goat's Milk
UPDATE `npc_vendor` SET `VerifiedBuild` = 52237 WHERE `entry` = 24333 AND `item` IN (2593, 2594, 2595, 2596, 2723, 4600, 8766, 27860, 28284, 28399);

-- Drohn's Distillery Apprentice
DELETE FROM `npc_vendor` WHERE `entry` = 24501 AND `item` IN (46402);
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `VerifiedBuild`) VALUES
(24501, 0, 46402, 0, 0, 0, 45613); -- Promise of the Pandaren
UPDATE `npc_vendor` SET `VerifiedBuild` = 45613 WHERE `entry` = 24501 AND `item` IN (34017, 34018, 34019);

-- Aelthin
DELETE FROM `npc_vendor` WHERE `entry` = 33630 AND `item` IN (21927);
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `VerifiedBuild`) VALUES
(33630, 0, 21927, 0, 0, 0, 53788); -- Instant Poison VII
UPDATE `npc_vendor` SET `VerifiedBuild` = 53788 WHERE `entry` = 33630 AND `item` IN (3371, 3372, 5565, 8925, 8927, 8928, 8985, 10922, 16583, 17020, 17021, 17026, 17028, 17029, 17030, 17031, 17032, 17033, 17034, 17035, 17036, 17037, 17038, 18256, 20844, 21177, 21835, 22053, 22147, 22148, 37201, 40411);

-- Enchantress Andiala
DELETE FROM `npc_vendor` WHERE `entry` = 33633 AND `item` IN (10940);
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `VerifiedBuild`) VALUES
(33633, 0, 10940, 4, 7200, 0, 53788); -- Strange Dust
UPDATE `npc_vendor` SET `VerifiedBuild` = 53788 WHERE `entry` = 33633 AND `item` IN (4470, 5565, 6217, 10938, 11291, 16583, 17020, 17021, 17026, 17028, 17029, 17030, 17031, 17032, 17033, 17034, 17035, 17036, 17037, 17038, 20752, 20753, 20758, 21177, 22147, 22148, 22307, 37201);
