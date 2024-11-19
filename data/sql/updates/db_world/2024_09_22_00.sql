-- DB update 2024_09_21_02 -> 2024_09_22_00
--
UPDATE `quest_offer_reward` SET `RewardText`='We will leave this place on our own, $G Lord:Lady; $N - once we are certain that the evil within has been wholly destroyed. Your journey of legend is almost at an end.', `VerifiedBuild`=0 WHERE `ID`=8801;
UPDATE `quest_request_items` SET `CompletionText`='$G Lord:Lady; $N, you have freed us of its grasp.', `VerifiedBuild`=0 WHERE `ID`=8801;
