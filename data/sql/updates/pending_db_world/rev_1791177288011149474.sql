-- frFR quest progress and completion texts missing from AzerothCore, taken from SPP Classics, TBC world locales.
-- Source: https://github.com/celguar/spp-classics-cmangos (Server/Sql/tbc/locales.7z, quest_locale_all.sql). Licence: no licence file.
-- A text is kept only when the source's English matches AzerothCore's English for the same quest,
-- or, for sources without English, when it passes length, placeholder and language checks.

DELETE FROM `quest_request_items_locale` WHERE `locale` = 'frFR' AND `ID` IN (3382, 8196, 8246, 8751, 8756, 8761);
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(3382, 'frFR', 'Ça va être une bataille difficile...', 0),
(8196, 'frFR', 'La mangue d''essence, extrêmement puissante, pousse sur nombre des îles des Mers du sud.  Une seule mangue rafraîchit celui qui la mange à la fois physiquement et mentalement.  Si vous n''en avez jamais mangé, vous ne savez pas ce que vous manquez !$B$BNous en avons suffisamment sur l''île pour vous en proposer quelques-unes en échange d''une marque d''honneur zandalar.  Parlez à Vinchaxa si vous ne savez pas comment obtenir les marques d''honneur ; sinon, faisons affaire immédiatement !', 0),
(8246, 'frFR', 'Pour quelqu''un d''aussi honoré parmi les Zandalar que vous, $N, j''ai quelque chose de très spécial.  Venus tout droit de notre patrie dans les Mers du sud... les cachets des Zandalar !  Ils permettent d''améliorer tout objet porté sur les épaules.  Que vous cherchiez la puissance, le mojo ou la sérénité, j''ai ce qu''il vous faut !$B$BJe demande quinze marques d''honneur zandalar en échange d''un cachet de votre choix.  Si vous avez les marques, faisons affaire immédiatement !', 0),
(8751, 'frFR', 'Je n’ai jamais vu une telle ténacité ! À la demande expresse de l’Intemporel, le Vol de bronze vous accorde un nouvel enchantement !$B$BDonnez-moi votre chevalière, que je procède aux ajustements nécessaires.', 0),
(8756, 'frFR', 'Je n’ai jamais vu une telle ténacité ! À la demande expresse de l’Intemporel, le Vol de bronze vous accorde un nouvel enchantement !$B$BDonnez-moi votre chevalière, que je procède aux ajustements nécessaires.', 0),
(8761, 'frFR', 'Je n’ai jamais vu une telle ténacité ! À la demande expresse de l’Intemporel, le Vol de bronze vous accorde un nouvel enchantement !$B$BDonnez-moi votre chevalière, que je procède aux ajustements nécessaires.', 0);

DELETE FROM `quest_offer_reward_locale` WHERE `locale` = 'frFR' AND `ID` IN (9485, 9502);
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(9485, 'frFR', 'Eh bien, $N, je n''ai plus rien à vous apprendre pour le moment. Vous comprenez déjà ce que c''est de devenir l''ami de ceux que vous avez chassés. Il ne vous reste plus qu''à choisir un allié issu de la nature dont les traits complèteront les vôtres.', 0),
(9502, 'frFR', 'Nous nous retrouvons donc. J''ai observé de loin vos progrès, $C. Je suis satisfait.$B$BIl est temps pour vous d''apprendre à communier avec l''eau, de découvrir ses mystères et de vous y abandonner afin d''apprendre à la maîtriser.', 0);
