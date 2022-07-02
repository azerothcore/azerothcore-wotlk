--
UPDATE `smart_scripts` SET `link`=10 WHERE `entryorguid`=28639 AND `source_type`=0 AND `id`=6;
UPDATE `smart_scripts` SET `link`=11 WHERE `entryorguid`=28639 AND `source_type`=0 AND `id`=9;

DELETE FROM `smart_scripts` WHERE `entryorguid`=28639 AND `source_type`=0 AND `id` IN (10,11);
INSERT INTO `smart_scripts` VALUES
(28639,0,10,7,61,0,100,0,0,0,0,0,0,19,256,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'On Update - Remove Immune to Player flag'),
(28639,0,11,0,61,0,100,0,0,0,0,0,0,18,256,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'On Update - Add Immune to Player flag');

UPDATE `smart_scripts` SET `link`=8 WHERE `entryorguid`=28636 AND `source_type`=0 AND `id`=4;
UPDATE `smart_scripts` SET `link`=9 WHERE `entryorguid`=28636 AND `source_type`=0 AND `id`=7;

DELETE FROM `smart_scripts` WHERE `entryorguid`=28639 AND `source_type`=0 AND `id` IN (8,9);
INSERT INTO `smart_scripts` VALUES
(28636,0,8,5,61,0,100,0,0,0,0,0,0,19,256,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'On Update - Remove Immune to Player flag'),
(28636,0,9,0,61,0,100,0,0,0,0,0,0,18,256,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'On Update - Add Immune to Player flag');
