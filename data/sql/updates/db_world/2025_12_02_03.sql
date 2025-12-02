-- DB update 2025_12_02_02 -> 2025_12_02_03
-- From: "from that $r" to "from that troll" as refers to the troll (Drakkari prisoner) and not the player's race.
UPDATE `quest_offer_reward` SET `RewardText` = 'You\'ve done it!$B$BThe intelligence gathered from that troll will undoubtedly be of great value. I\'ll be certain to make mention of your efforts in my report to the commander.$B$BThank you, $N.' WHERE `ID` = 12541;
