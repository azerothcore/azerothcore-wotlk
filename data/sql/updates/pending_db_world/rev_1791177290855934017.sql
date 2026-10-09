-- frFR quest progress and completion texts missing from AzerothCore, taken from vmangos.
-- Source: https://github.com/vmangos/core (db_latest release, locales_quest). Licence: GPL-2.0.
-- A text is kept only when the source's English matches AzerothCore's English for the same quest,
-- or, for sources without English, when it passes length, placeholder and language checks.
-- vmangos texts are used only for a quest and column that SPP also has: elsewhere its French appears to be a community
-- translation rather than the client's text.

DELETE FROM `quest_request_items_locale` WHERE `locale` = 'frFR' AND `ID` IN (1692, 3114, 3511, 3907, 4083, 6027, 6301, 8243, 8428, 8429);
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(1692, 'frFR', 'Bonjour, $C. Comment puis-je vous servir ?', 0),
(3114, 'frFR', 'Ouais, qu''est-ce qui y a ? Plus fort, si ça vous gêne pas, $N. J''entends plus très bien après quelques bières.', 0),
(3511, 'frFR', 'Vous êtes là ! Etonnant, $N. Avez-vous découvert le véritable nom ?', 0),
(3907, 'frFR', 'Les flammes vont bientôt ravager ces terres. Hâtez-vous, $N !', 0),
(4083, 'frFR', 'Le Calice spectral flotte dans les airs, descendant et remontant tout doucement… au rythme d''un cœur agonisant.', 0),
(6027, 'frFR', 'Ha, $N ! C''est bon de vous revoir. Avez-vous le Livre des Anciens ?', 0),
(6301, 'frFR', 'La destruction perpétuelle que cause la guerre, et ceux qui cherchent leurs intérêts dans ce massacre, m''endolorissent profondément. Pour aider le cycle de la vie à redonner une nouvelle jeunesse aux terres, j''ai besoin de Graines de Gaea. En avez-vous, $C ?', 0),
(8243, 'frFR', 'Votre nouveau statut au sein de la tribu vous donne accès à certains de nos breuvages plus puissants.  Regardez... ces mixtures sont fortes en mojo, bénies par Zanza et conviennent aux aventuriers de tous horizons !$B$BJe vais vous permettre de choisir l''une des trois que je propose. En échange, je demande une marque d''honneur zandalar.  Veuillez noter que les effets d''un seul breuvage à la fois peuvent habiter votre esprit.$B$BDites-moi quand vous serez prêt à faire l''échange !', 0),
(8428, 'frFR', 'La bataille dans le goulet des Chanteguerres contre les Sentinelles d''Aile-argent est d''une grande importance. Sous le prétexte de protéger une forêt qui ne lui appartient pas, l''Alliance cherche à refuser à la Horde l''une de ses plus grandes ressources en bois.$B$BNe la laissez pas faire, $N ! Revenez me voir quand vous aurez la preuve que vous avez bien servi la Horde !', 0),
(8429, 'frFR', 'La bataille dans le goulet des Chanteguerres contre les Sentinelles d''Aile-argent est d''une grande importance. Sous le prétexte de protéger une forêt qui ne lui appartient pas, l''Alliance cherche à refuser à la Horde l''une de ses plus grandes ressources en bois.$B$BNe la laissez pas faire, $N ! Revenez me voir quand vous aurez la preuve que vous avez bien servi la Horde !', 0);

DELETE FROM `quest_offer_reward_locale` WHERE `locale` = 'frFR' AND `ID` IN (5634, 6568, 7623, 7884, 8101, 8233, 8420, 8424);
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(5634, 'frFR', 'Vous avez rendu un grand service à la Lumière en devenant un exemple remarquable pour ceux qui voyagent dans et au-delà de ces contrées dangereuses. S''il vous plaît, veuillez accepter cette leçon en remerciement de tout ce que vous avez fait.', 0),
(6568, 'frFR', '<Myranda tient la note, fait une pause et sourit. >$B$BComment va-t-il ? Je veux dire Rexxar. Oh, détendez-vous, ne soyez pas si confus. Cette lettre a intentionnellement été laissée blanche. Elle portait avec elle les intentions et les pensées de son créateur. À en juger par son contenu, pas la peine de se demander pourquoi Rexxar l''a laissée comme ça. Imaginez ce qui se serait passé, si par la capture ou dans la mort, ces informations vous avaient échappé !$B$BOh, aucune importance ! Myranda vous aidera, $N. Je dois au Chef de guerre une faveur ou deux.', 0),
(7623, 'frFR', 'Ma patience couvre des millénaires, $C. Mais ne vous imaginez pas que cela vous donne droit à plus d’une seconde de mon temps…', 0),
(7884, 'frFR', 'Super, vous les avez faites ! Elles conviendront parfaitement... J''espère seulement que ce ne sera pas moi qui devrai nettoyer la cage des crocilisques. Ces bêtes sont parfois assez agressives, vous ne trouvez pas ?$B$BVoici vos bons, $N. Profitez-en bien et amusez-vous à la foire de Sombrelune !', 0),
(8101, 'frFR', '$R, le caillou tenu dans le cadre de ce talisman provient du mont Kajaro, dans les mers du Sud. Le mont Kajaro est une région en proie à la volatilité - marquée par des éruptions volcaniques violentes et souvent magiques.$B$BA votre lien avec les trolls de Zandalar grandit, tout comme la puissance de ce caillou. Exploiter le pouvoir du caillou pour abattre nos ennemis.Soyez comme la montagne: rapide, explosif, mortel ...', 0),
(8233, 'frFR', 'Bienvenue, bienvenue, bienvenue ! S''il vous plaît, $N, asseyez-vous et discutez avec moi d''une question simple.$B$BVoyez-vous, $N, j''ai récemment perdu quelque chose qui m''était cher, et pour parler franchement, je veux le récupérer à tout prix. Il y a quelque chose pour vous, ne vous inquiétez pas ! Oh oui, quelque chose de très beau.$B$BMaintenant, qu''en dites-vous $N... êtes-vous prêt pour l''aventure ?', 0),
(8420, 'frFR', 'Ouah ! Vous êtes trop gentil. Surtout pour un $C !$B$B<Impsy porte le tissu de feutre à son visage.>$B$BOh comme j''aime la sensation qu''il procure, la façon dont il brûle votre peau et tisse des pensées maléfiques dans votre esprit...', 0),
(8424, 'frFR', 'Vous avez déjà calmé ma douleur et vous m''avez honoré. Je vous remercie, $C.', 0);
