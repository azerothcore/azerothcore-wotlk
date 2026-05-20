-- DB update 2026_05_19_01 -> 2026_05_20_00
-- from "$R" to "troll" according to the sniff 67156
UPDATE `quest_request_items` SET `CompletionText` = 'Have you been to Vejrek\'s hut, $N? Is that troll stink I smell on you?' WHERE (`ID` = 1678);
