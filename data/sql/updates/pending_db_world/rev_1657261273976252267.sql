-- Delete modelid2 that was causing conflict to Enchanted Tiki Warriors
UPDATE `creature_template` SET `modelid2` = 0 WHERE (`entry` = 28882);
