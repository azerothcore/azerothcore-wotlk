-- Black Rose quest placeholder kill objective.

SET @QUEST_ALLIANCE := 900100;
SET @QUEST_HORDE := 900101;
SET @GRUFF_SWIFTBITE := 100;

UPDATE `quest_template`
SET `LogDescription` = 'Slay Gruff Swiftbite, then return to Norah Rose to receive the Black Rose''s gift.',
    `QuestDescription` = 'The Black Rose has watched your steps with interest, $N. You have reached the point where the road opens before you.$B$BFirst, prove your resolve by slaying Gruff Swiftbite. Return to me when the deed is done, and the Black Rose will mark your path.',
    `QuestCompletionLog` = 'Return to Norah Rose after slaying Gruff Swiftbite.',
    `RequiredNpcOrGo1` = @GRUFF_SWIFTBITE,
    `RequiredNpcOrGoCount1` = 1,
    `ObjectiveText1` = 'Gruff Swiftbite slain'
WHERE `ID` IN (@QUEST_ALLIANCE, @QUEST_HORDE);
