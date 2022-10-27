-- DB update 2022_10_13_00 -> 2022_10_20_00
-- Insert world states (for conditions)
DELETE FROM `worldstates` WHERE `entry` IN (197,198,199,200);
INSERT INTO `worldstates` (`entry`, `value`, `comment`) values
(197,0,'Fishing Extravaganza - STV_FISHING_PREV_WIN_TIME'),
(198,0,'Fishing Extravaganza - STV_FISHING_HAS_WINNER'),
(199,0,'Fishing Extravaganza - STV_FISHING_ANNOUNCE_EVENT_BEGIN'),
(200,0,'Fishing Extravaganza - STV_FISHING_ANNOUNCE_POOLS_DESPAN');
