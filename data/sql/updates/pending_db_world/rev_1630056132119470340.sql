INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630056132119470340');

-- Sets the minimum reputation needed to Honored (9000 rep) for the quests: Favor Amongst the Brotherhood, Blood of the Mountain, Favor Amongst the Brotherhood, Core Leather, Favor Amongst the Brotherhood, Dark Iron Ore, Favor Amongst the Brotherhood, Fiery Core, Favor Amongst the Brotherhood, Lava Core
UPDATE `quest_template_addon` SET RequiredMinRepValue = 9000 WHERE `ID` IN (6642, 6643, 6644, 6645, 6646);
