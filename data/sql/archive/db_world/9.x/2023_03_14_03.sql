-- DB update 2023_03_14_02 -> 2023_03_14_03
DELETE FROM `quest_request_items` WHERE `ID` IN (660, 714, 722, 747, 754, 758, 789, 829, 934);
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `CompletionText`, `VerifiedBuild`) VALUES
(660, 1, 0, 'The time for talk is done. Protect Kinelory if you care about the people of Hillsbrad at all.', 0), 
(714, 0, 0, 'Yes, yes, yes. Just a moment.$B$B<Lotwil continues to work on some kind of contraption.>', 0),
(722, 1, 1, 'The Shadowforge clan... <cough> is dangerous. Be careful. <cough> You must find the amulet.', 0),
(747, 1, 1, 'Providing meat and feathers for the tribe is the first step in proving yourself as a hunter before the Chief.', 0),
(754, 1, 0, 'Do not delay, $n. The Winterhoof Well\'s taint must be removed!', 0),
(758, 1, 0, 'The Thunderhorn Water Well is still tainted, $n. Please, you must perform the ritual!', 0),
(789, 1, 0, 'The carapace of a scorpid isn\'t so thick that the strength of a determined warrior will be deterred. Strike strongly and without doubt, and the scorpids should prove easy prey.', 0),
(829, 2, 2, 'My most humble greetings, $C. How might I help my $R $Gbrother:sister; today?', 0),
(934, 1, 0, 'Along with the druids, the Oracle Tree and the Arch Druid have been carefully monitoring the growth of Teldrassil. But though we have a new home, our immortal lives have not been restored.', 0);
