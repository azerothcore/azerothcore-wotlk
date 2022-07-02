--
UPDATE `smart_scripts` SET `event_flags`=512, `event_type`=8, `link`=10, `event_param1`=52151, `event_param2`=0 WHERE `entryorguid`=28639 AND `source_type`=0 AND `id`=6;
UPDATE `smart_scripts` SET `link`=12 WHERE `entryorguid`=28639 AND `source_type`=0 AND `id`=9;

DELETE FROM `smart_scripts` WHERE `entryorguid`=28639 AND `source_type`=0 AND `id` IN (10,11,12);
INSERT INTO `smart_scripts` VALUES
(28639,0,10,11,61,1,100,512,0,0,0,0,0,19,256,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'On Update - Remove Immune to Player flag'),
(28639,0,11,7,61,1,100,512,0,0,0,0,0,45,1,4,0,0,0,0,19,28636,20,0,0,0,0,0,0,'On Update - Add Immune to Player flag'),
(28639,0,12,0,61,1,100,512,0,0,0,0,0,18,256,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'On Update - Add Immune to Player flag');

UPDATE `smart_scripts` SET `link`=0 WHERE `entryorguid`=28636 AND `source_type`=0 AND `id`=4;
UPDATE `smart_scripts` SET `link`=9 WHERE `entryorguid`=28636 AND `source_type`=0 AND `id`=7;

DELETE FROM `smart_scripts` WHERE `entryorguid`=28636 AND `source_type`=0 AND `id` IN (8,9);
INSERT INTO `smart_scripts` VALUES
(28636,0,8,5,38,0,100,0,1,4,0,0,0,19,256,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'On Update - Remove Immune to Player flag'),
(28636,0,9,0,61,0,100,0,0,0,0,0,0,18,256,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'On Update - Add Immune to Player flag');
