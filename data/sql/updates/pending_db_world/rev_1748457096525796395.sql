--
-- Changes "AllowableRaces" to only alliance races. Should stop this quest from being sharable to horde players.
-- Changes RequiredNpcOrGo1 from Captain Alina to the Shattered Hand Executioner
UPDATE `quest_template` SET `AllowableRaces` = 1101, `RequiredNpcOrGo1` = 17301 WHERE (`ID` = 9524);
