-- DB update 2022_12_20_03 -> 2022_12_20_04
--
-- Mulgore Zone Drops
-- Squealear's Belt Should be 100% (Already Correct on AC)
-- Crooked Staff could be up to seems to be closer to 1.5% than 2% both in game and on wowhead
UPDATE `creature_loot_template` SET `Chance`=1.5 WHERE `Entry`=2953 AND `Item`=1388 AND `Reference`=0 AND `GroupId`=0;
-- Dull Blade should probbably be about 1.25%
UPDATE `creature_loot_template` SET `Chance`=1.25 WHERE `Entry`=2952 AND `Item`=1384 AND `Reference`=0 AND `GroupId`=0;
