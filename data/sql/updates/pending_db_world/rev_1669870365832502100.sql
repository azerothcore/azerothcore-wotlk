--
-- Improve Mazthoril Recipe Drop Rates
UPDATE `creature_loot_template` SET `Chance`=6 WHERE `Entry`=7437 AND `Item`=14493 AND `Reference`=0 AND `GroupId`=0;
UPDATE `creature_loot_template` SET `Chance`=2 WHERE `Entry`=7437 AND `Item`=16054 AND `Reference`=0 AND `GroupId`=0;
UPDATE `creature_loot_template` SET `Chance`=10 WHERE `Entry`=7437 AND `Item`=13497 AND `Reference`=0 AND `GroupId`=0;
