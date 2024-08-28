-- Removes creature reference to broadcast text
/*
https://www.azerothcore.org/wiki states that broadcast text table contains only confirmed retail data.
So to avoid polluting the table issue #19480 is being fixed in creature_text table instead.
More info in issue #19480 and PR #19542
*/
UPDATE `creature_text` SET 
`BroadcastTextId` = 0,
`comment` = CONCAT(`comment`, ', removed BroadcastTextId 12690 (more info in PR#19542)')
WHERE `CreatureID` IN (16325, 16326);
