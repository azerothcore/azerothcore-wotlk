-- Dark Iron Tunneler: creep flag hides the health bar
UPDATE `creature_addon` SET `bytes1` = 1048576 WHERE `guid` IN (9628, 9675, 9711);
