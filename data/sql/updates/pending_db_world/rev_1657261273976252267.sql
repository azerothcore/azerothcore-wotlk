-- Change modelid1 that was an infernal to Enchanted Tiki Warriors modelid (25749) and delete modelid2 to not duplicate
UPDATE `creature_template` SET `modelid1` = 25749, `modelid2` = 0 WHERE (`entry` = 28882);
