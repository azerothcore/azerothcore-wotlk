
-- Enchant Boots - Lesser Accuracy
REPLACE INTO npc_trainer VALUES(201009, 63746, 5000, 333, 225, 0);
REPLACE INTO npc_trainer VALUES(201011, 63746, 5000, 333, 225, 0);

-- Goblin Mortar, requires Goblin Engineering
REPLACE INTO npc_trainer VALUES(201015, 12716, 1500, 202, 205, 0);
REPLACE INTO npc_trainer VALUES(201015, 13240, 1500, 202, 205, 0);


-- The Bigger One (30558)
-- Goblin Rocket Launcher (30563)
-- Foreman's Enchanted Helmet (30565)
-- Foreman's Reinforced Helmet (30566)
-- Global Thermal Sapper Charge (56514)
UPDATE npc_trainer SET reqlevel=0 WHERE spell IN(30558, 30563, 30565, 30566, 56514);

-- Skill level requirements
UPDATE npc_trainer set reqlevel=5 WHERE spell IN(2275, 7733, 7414, 25245, 4039, 2155, 2020, 3911, 2551, 45375); -- Apprentice
UPDATE npc_trainer set reqlevel=10 WHERE spell IN(7734, 7415, 25246, 2280, 4040, 2154, 2021, 3912, 3412, 45376); -- Journeyman
UPDATE npc_trainer set reqlevel=20 WHERE spell IN(54083, 7416, 28896, 3465, 4041, 3812, 3539, 3913, 54257, 45377); -- Expert
UPDATE npc_trainer set reqlevel=35 WHERE spell IN(18249, 13921, 28899, 11612, 12657, 10663, 9786, 12181, 18261, 45378, 10847); -- Artisan
UPDATE npc_trainer set reqlevel=50 WHERE spell IN(30351, 54084, 28030, 28901, 28597, 32550, 54256, 29845, 26791, 45379, 54255); -- Master
UPDATE npc_trainer set reqlevel=65 WHERE spell IN(51303, 51293, 51312, 51310, 61464, 51301, 51295, 51298, 51308, 45380, 50299); -- Grand Master
UPDATE npc_trainer set reqlevel=1 WHERE spell IN(2581, 2372, 8615, 3279); -- Apprentice Gathering and First Aid
UPDATE npc_trainer set reqlevel=1 WHERE spell IN(2582, 2373, 8619, 3280); -- Journeyman Gathering and First Aid
UPDATE npc_trainer set reqlevel=1 WHERE spell IN(54254); -- Expert First Aid
UPDATE npc_trainer set reqlevel=10 WHERE spell IN(3568, 3571, 8620); -- Expert Gathering
UPDATE npc_trainer set reqlevel=25 WHERE spell IN(10249, 11994, 10769); -- Artisan Gathering
UPDATE npc_trainer set reqlevel=40 WHERE spell IN(29355, 28696, 32679); -- Master Gathering
UPDATE npc_trainer set reqlevel=55 WHERE spell IN(50309, 50301, 50307); -- Grand Master Gathering
-- Fishing
UPDATE npc_trainer set reqlevel=5 WHERE spell IN(7733); -- Apprentice
UPDATE npc_trainer set reqlevel=10 WHERE spell IN(7734, 54083, 18249, 54084, 51293); -- Other ranks

-- Shenthul (3401) -- missing trainer gossip conditions
DELETE FROM gossip_menu WHERE entry=21221;
INSERT INTO gossip_menu VALUES(21221, 1124), (21221, 4793);
DELETE FROM gossip_menu_option WHERE menu_id=21221;
INSERT INTO gossip_menu_option VALUES (21221, 0, 3, 'I would like training.', 5, 16, 0, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (21221, 1, 0, 'I wish to unlearn my talents.', 16, 16, 4461, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (21221, 2, 0, 'I wish to know about Dual Talent Specialization.', 1, 1, 10371, 0, 0, 0, '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(14, 15) AND SourceGroup=21221;
INSERT INTO conditions VALUES (14, 21221, 1124, 0, 0, 15, 0, 8, 0, 0, 0, 0, 0, '', 'Show gossip text if player is a Rogue');
INSERT INTO conditions VALUES (14, 21221, 4793, 0, 0, 15, 0, 1527, 0, 0, 0, 0, 0, '', 'Show gossip text if player is not a Rogue');
INSERT INTO conditions VALUES (15, 21221, 0, 0, 0, 15, 0, 8, 0, 0, 0, 0, 0, '', 'Show gossip option if player is a Rogue');
INSERT INTO conditions VALUES (15, 21221, 1, 0, 0, 15, 0, 8, 0, 0, 0, 0, 0, '', 'Show gossip option if player is a Rogue');
INSERT INTO conditions VALUES (15, 21221, 2, 0, 0, 15, 0, 8, 0, 0, 0, 0, 0, '', 'Show gossip option if player is a Rogue');

-- Charles Worth (28699) -- Fixed recipe conditions
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(14, 15) AND SourceGroup=10118;
INSERT INTO conditions VALUES (14, 10118, 14076, 0, 0, 7, 0, 197, 420, 0, 0, 0, 0, '', 'Only show gossip text 14076 if player has Tailoring with skill level 420');
INSERT INTO conditions VALUES (15, 10118, 2, 0, 0, 7, 0, 197, 420, 0, 0, 0, 0, '', 'Only show gossip option if player has Tailoring with skill level 420');
INSERT INTO conditions VALUES (15, 10118, 2, 0, 0, 25, 0, 56016, 0, 0, 1, 0, 0, '', 'Only show gossip option if player has not learned spell 56016');
INSERT INTO conditions VALUES (15, 10118, 3, 0, 0, 7, 0, 197, 420, 0, 0, 0, 0, '', 'Only show gossip option if player has Tailoring with skill level 420 Alliance');
INSERT INTO conditions VALUES (15, 10118, 3, 0, 0, 17, 0, 1288, 0, 0, 0, 0, 0, '', 'Only show gossip option if player has achievement Northrend Dungeonmaster');
INSERT INTO conditions VALUES (15, 10118, 3, 0, 0, 25, 0, 56016, 0, 0, 1, 0, 0, '', 'Only show gossip option if player has not learned spell 56016');
INSERT INTO conditions VALUES (15, 10118, 4, 0, 0, 7, 0, 197, 420, 0, 0, 0, 0, '', 'Only show gossip option if player has Tailoring with skill level 420');
INSERT INTO conditions VALUES (15, 10118, 4, 0, 0, 25, 0, 56017, 0, 0, 1, 0, 0, '', 'Only show gossip option if player has not learned spell 56017');
INSERT INTO conditions VALUES (15, 10118, 5, 0, 0, 7, 0, 197, 420, 0, 0, 0, 0, '', 'Only show gossip option if player has Tailoring with skill level 420');
INSERT INTO conditions VALUES (15, 10118, 5, 0, 0, 25, 0, 56017, 0, 0, 1, 0, 0, '', 'Only show gossip option if player has not learned spell 56017');
INSERT INTO conditions VALUES (15, 10118, 5, 0, 0, 17, 0, 41, 0, 0, 0, 0, 0, '', 'Only show gossip option if player has achievement Loremaster of Northrend Alliance');
INSERT INTO conditions VALUES (15, 10118, 5, 0, 1, 7, 0, 197, 420, 0, 0, 0, 0, '', 'Only show gossip option if player has Tailoring with skill level 420 Horde');
INSERT INTO conditions VALUES (15, 10118, 5, 0, 1, 25, 0, 56017, 0, 0, 1, 0, 0, '', 'Only show gossip option if player has not learned spell 56017');
INSERT INTO conditions VALUES (15, 10118, 5, 0, 1, 17, 0, 1360, 0, 0, 0, 0, 0, '', 'Only show gossip option if player has achievement Loremaster of Northrend Horde');


-- ----------------------------
-- Remove auto-learned recipes
-- ----------------------------
-- Brown Linen Shirt (3915)
DELETE FROM npc_trainer WHERE spell=3915;

-- Enchant Bracer - Minor Deflection (7428)
DELETE FROM npc_trainer WHERE spell=7428;

-- Rune of Razorice (53343)
DELETE FROM npc_trainer WHERE spell=53343;

-- Rune of Cinderglacier (53341)
DELETE FROM npc_trainer WHERE spell=53341;



