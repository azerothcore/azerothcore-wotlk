-- DB update 2026_09_17_00 -> 2026_09_17_01
-- Dark Iron Tunneler: sniff leftovers (creep flag, Defensive Stance) hid the health bars
DELETE FROM `creature_addon` WHERE `guid` IN (9628, 9675, 9711);
