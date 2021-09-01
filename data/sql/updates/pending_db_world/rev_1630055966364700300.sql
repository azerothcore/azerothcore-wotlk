INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630055966364700300');

-- Set Honored rep requirement for the following quests:
-- 6645 - [Favor Amongst the Brotherhood, Core Leather]
-- 6646 - [Favor Amongst the Brotherhood, Blood of the Mountain]
-- 6642 - [Favor Amongst the Brotherhood, Dark Iron Ore]
-- 6643 - [Favor Amongst the Brotherhood, Fiery Core]
-- 6644 - [Favor Amongst the Brotherhood, Lava Core]
UPDATE `quest_template_addon` SET `RequiredMinRepValue` = 9000 WHERE `ID` IN ('6645', '6646', '6642', '6643', '6644');
