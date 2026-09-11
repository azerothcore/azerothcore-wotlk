-- Enable temporary patrol leader promotion for the Warpwood Treant formations in Dire Maul East.
UPDATE `creature_formations` SET `groupAI` = `groupAI` | 64
WHERE `leaderGUID` IN (248356, 248359, 248362, 248365, 248368, 248371) AND `memberGUID` = `leaderGUID`;
