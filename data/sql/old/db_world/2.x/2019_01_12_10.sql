-- DB update 2019_01_12_09 -> 2019_01_12_10
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_01_12_09';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_01_12_09 2019_01_12_10 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1546089286503990310'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO version_db_world (`sql_rev`) VALUES ('1546089286503990310');

-- ----------------------------
-- Insert data quest_request_items
-- ----------------------------

INSERT INTO `quest_request_items`(`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `CompletionText`, `VerifiedBuild`) VALUES (10496, 1, 1, 'You\'re back, $N. You must tell me all about what you\'ve found out. But first let us arrange for your reward.', 0);

INSERT INTO `quest_request_items`(`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `CompletionText`, `VerifiedBuild`) VALUES (10497, 1, 1, 'You\'ve returned and I see in your eyes that you\'ve much to tell me, $N. Let us take care of your reward first.', 0);

INSERT INTO `quest_request_items`(`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `CompletionText`, `VerifiedBuild`) VALUES (10498, 6, 6, 'As per our deal, are you ready to hand over your Wildheart pieces in exchange for your new Feralheart Cowl and Vest?', 0);

INSERT INTO `quest_request_items`(`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `CompletionText`, `VerifiedBuild`) VALUES (10499, 6, 6, 'As per our deal, are you ready to hand over your Magister\'s pieces in exchange for your new Sorcerer\'s Crown and Robes?', 0);

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you find Garrick\'s shack? Are we finally free of that villain?', `VerifiedBuild` = 12340 WHERE `ID` = 6;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'How goes the hunting, $N? Have you found and defeated those vermin?', `VerifiedBuild` = 12340 WHERE `ID` = 7;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'Ah, I see you\'re back! I hope you\'ve been hard at work clearing those fields of those Harvest Watchers. Have you killed twenty yet?', `VerifiedBuild` = 12340 WHERE `ID` = 9;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Well, what news do you have?  You look like you\'ve been in quite the fight... is Scrimshank alive?', `VerifiedBuild` = 12340 WHERE `ID` = 10;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Hail, $N. Have you been killing Gnolls...?', `VerifiedBuild` = 12340 WHERE `ID` = 11;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Perhaps I did not make myself clear, pledge. In order to prove your worth as a servant to The People\'s Militia and to the Light you need to slay 15 Defias Trappers and 15 Defias Smugglers then return to me when the deed is done.', `VerifiedBuild` = 12340 WHERE `ID` = 12;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'We have not time to talk, $N. The Defias Pillagers are denying the people of Westfall the peace and prosperity they deserve. Make sure at least 15 Defias Pillagers and 15 Defias Looters have been killed. That will send a clear message that corruption is not welcome here.', `VerifiedBuild` = 12340 WHERE `ID` = 13;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = '$N, now is no time for idle chatter. If you still wish to prove yourself to The People\'s Militia you need to slay the Defias I notified you about earlier. Return to me when you have completed your duty.', `VerifiedBuild` = 12340 WHERE `ID` = 14;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you been to the mines? Are you ready to report?', `VerifiedBuild` = 12340 WHERE `ID` = 15;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Farming is thirsty work, and I\'m always looking for refreshing spring water.$B$BIf you have any, then I\'m willing to make a trade.', `VerifiedBuild` = 12340 WHERE `ID` = 16;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you obtained the magenta fungus caps I need for my alchemical work? No caps - no reward!', `VerifiedBuild` = 12340 WHERE `ID` = 17;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you gathered those bandanas for me yet?', `VerifiedBuild` = 12340 WHERE `ID` = 18;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Orc pressure from Blackrock is still tense. But have you at least rid us of Tharil\'zun?', `VerifiedBuild` = 12340 WHERE `ID` = 19;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Have you been slaying orcs, $N? If so, then show me...', `VerifiedBuild` = 12340 WHERE `ID` = 20;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I know it\'s bloody work, $N, but it\'s vital to the safety of Northshire. Are you ready to report?', `VerifiedBuild` = 12340 WHERE `ID` = 21;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Ah - $N - I was just thinking about you! How goes your hunting?', `VerifiedBuild` = 12340 WHERE `ID` = 23;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Greetings once again, $N! Have you come to show me proof of your hunt?', `VerifiedBuild` = 12340 WHERE `ID` = 24;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'I\'m sorry. I don\'t know you... but from the look of things you have at least heard something of me. Now, what can I help you with? Do you have something for me?', `VerifiedBuild` = 12340 WHERE `ID` = 32;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Is Bellygrub still at it or were you able to rid Lakeshire of the pest once and for all?', `VerifiedBuild` = 12340 WHERE `ID` = 34;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'I\'m going to miss that Verna Furlbrow so much. I don\'t suppose you happened to see her on your way here?', `VerifiedBuild` = 12340 WHERE `ID` = 36;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Come back with the following ingredients: $b $b 3 Stringy Vulture Meat $b 3 Goretusk Snouts $b 3 Murloc Eyes $b 3 Okra', `VerifiedBuild` = 12340 WHERE `ID` = 38;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'How goes the hunting, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 46;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Psst! You have that Gold Dust for me...for me?', `VerifiedBuild` = 12340 WHERE `ID` = 47;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 94, `EmoteOnIncomplete` = 94, `CompletionText` = 'Hiccup! Ho ho! You want an encore?$B$BIn the land to the south where vines twist and creep$BLies a hidden well where the water runs deep$BPure as the Light\'s sacred Daughter$BBring to me now some Holy Spring Water.', `VerifiedBuild` = 12340 WHERE `ID` = 48;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 94, `EmoteOnIncomplete` = 94, `CompletionText` = 'Encore? Well, sure!$B$BAmber is the hue of my life\'s longest love$BLike the last embers of dusk in the sky above$BRetrieve for me so that my love shall be born$BOne sack of each: barley, rye and corn.', `VerifiedBuild` = 12340 WHERE `ID` = 49;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 94, `EmoteOnIncomplete` = 94, `CompletionText` = 'An encore for you? Well sure friend!$B$BI\'ll mix and mix till we have a mash$BFor this will be our own private stash$BA still must be fashioned of metal strong$BBring me some Truesilver so I can finish this song.', `VerifiedBuild` = 12340 WHERE `ID` = 50;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 94, `EmoteOnIncomplete` = 94, `CompletionText` = 'An encore? Why for you, anything!$B$BNot yet filtered but freshly distilled$BLike unseeded land waiting there tilled.$BNext I will fashion our pile of charcoal$BDeliver a sycamore branch, that is your next goal.', `VerifiedBuild` = 12340 WHERE `ID` = 51;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 94, `EmoteOnIncomplete` = 94, `CompletionText` = 'Sure, I\'ll sing it again for you, friend!$B$BMellifluous liquid clear as a baby\'s tears$BTurns a lovely deep amber over the years$BBut before we proceed to get lit to the hilt$BA barrel of charred oak must be built.', `VerifiedBuild` = 12340 WHERE `ID` = 53;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'Is Morbent Fel defeated?!', `VerifiedBuild` = 12340 WHERE `ID` = 55;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you killed those warriors and mages?', `VerifiedBuild` = 12340 WHERE `ID` = 56;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 25, `CompletionText` = 'Return to me once you have killed 15 Skeletal Fiends and 15 Skeletal Horrors, $N.', `VerifiedBuild` = 12340 WHERE `ID` = 57;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 25, `CompletionText` = 'I need your assistance, $N. Travel to the cemetery to the northwest and rid the eastern mausoleum of 20 Plague Spreaders.$B$BReturn to me when your task is complete.', `VerifiedBuild` = 12340 WHERE `ID` = 58;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 0, `CompletionText` = 'I have been commissioned by the Stormwind Army to supply their people with cloth and leather armor.$b$bIf you have a marker for me, then I\'d be happy to make you something.', `VerifiedBuild` = 12340 WHERE `ID` = 59;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Did you gather those candles yet?', `VerifiedBuild` = 12340 WHERE `ID` = 60;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Oh, a shipment from my brother? Splendid! Fortune truly shines on me today!', `VerifiedBuild` = 12340 WHERE `ID` = 61;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Don\'t suppose you were able to get my watch?', `VerifiedBuild` = 12340 WHERE `ID` = 64;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Ah, I remember you. You\'re the one who was asking about that Stalvan fellow. Did you ever find what you were looking for?', `VerifiedBuild` = 12340 WHERE `ID` = 68;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'What have ya got there? Let me take a look at that. . .', `VerifiedBuild` = 12340 WHERE `ID` = 70;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Hello, $N. Have you discovered the fates of Rolf and Malakai?', `VerifiedBuild` = 12340 WHERE `ID` = 71;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'What have you got there? I cannot see. My eyesight is very bad. Put it in my hands.', `VerifiedBuild` = 12340 WHERE `ID` = 74;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you find that page I mentioned, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 75;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'I trust that your arrival here at our camp is to deliver the bottles of ripple that are integral to the task at hand, yes?', `VerifiedBuild` = 12340 WHERE `ID` = 77;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Marshal Haggard sent you? Why didn\'t you say so?$B$BAh, good ol\' Haggard. Poor chap is going to be completely blind before long. Anyway, let me see what you\'ve got there.', `VerifiedBuild` = 12340 WHERE `ID` = 78;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Back again, $N? What do you have this time?', `VerifiedBuild` = 12340 WHERE `ID` = 80;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 0, `CompletionText` = 'If you\'re not here to buy anything, and you\'re not here to deliver anything, then you\'re wasting my time! You better have that ripple!', `VerifiedBuild` = 12340 WHERE `ID` = 81;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'You\'re Junior Surveyor $N, yes? Quickly now, there is a dire situation at hand! Do you have the insect parts that Fizzledowser said you would?!', `VerifiedBuild` = 12340 WHERE `ID` = 82;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'I\'m running low on linen, $N. Do you have any for me?', `VerifiedBuild` = 12340 WHERE `ID` = 83;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'I don\'t think it\'s right feeding the boy who stole my necklace in the first place, but if that\'s what it takes to get back what\'s mine, then so be it!$b$bDo you have that boar meat?', `VerifiedBuild` = 12340 WHERE `ID` = 86;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 3, `EmoteOnIncomplete` = 3, `CompletionText` = 'Hello, $N. Have you found my necklace?', `VerifiedBuild` = 12340 WHERE `ID` = 87;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you see her yet? Did you get her?', `VerifiedBuild` = 12340 WHERE `ID` = 88;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'This bridge isn\'t going to build itself! Now where are those iron pikes and iron rivets?', `VerifiedBuild` = 12340 WHERE `ID` = 89;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Were you able to find 10 Lean Wolf Flanks yet? How about the herbs from Felicia in Stormwind?', `VerifiedBuild` = 12340 WHERE `ID` = 90;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Turn in 10 Shadowhide Pendants to me, and you shall be rewarded.', `VerifiedBuild` = 12340 WHERE `ID` = 91;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'I still need five pieces of Tough Condor Meat, five Great Goretusk Snouts and five helpings of Crisp Spider Meat.', `VerifiedBuild` = 12340 WHERE `ID` = 92;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 3, `EmoteOnIncomplete` = 3, `CompletionText` = 'Hail, $N. Did you get those Gooey Spider Legs yet?', `VerifiedBuild` = 12340 WHERE `ID` = 93;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Yes, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 98;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Have you secured the Pyrewood Shackles yet, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 99;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Bring to me 10 ghoul fangs, 10 skeleton fingers and 5 vials of spider venom. For you I shall enchant a Totem of Infliction which will harm those who attempt violent acts against you.', `VerifiedBuild` = 12340 WHERE `ID` = 101;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you collected 8 paws from those treacherous Gnolls yet?', `VerifiedBuild` = 12340 WHERE `ID` = 102;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'The flame will not burn for long without oil, $N.', `VerifiedBuild` = 12340 WHERE `ID` = 103;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Have you laid waste to the menace known as Old Murk-Eye yet? He has been spotted roaming the coastline of Westfall.$B$BReturn to me when the foul beast is dead.', `VerifiedBuild` = 12340 WHERE `ID` = 104;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Your task has been given to you, $N. Do you have a shard from the lich\'s phylactery as proof of the task being accomplished?', `VerifiedBuild` = 12340 WHERE `ID` = 105;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 0, `CompletionText` = 'You have what?? Maybell is the light of my dull life. Hurry, let me see her letter!', `VerifiedBuild` = 12340 WHERE `ID` = 106;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'You have a note from \"Gramma\" Stonefield, eh? I haven\'t seen Mildred in years! I wonder what she has to say...', `VerifiedBuild` = 12340 WHERE `ID` = 107;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do you have that crystal kelp? I\'m sure Maybell is anxious to see her beau...', `VerifiedBuild` = 12340 WHERE `ID` = 112;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Did you deliver my letter to Tommy Joe? What did he say??', `VerifiedBuild` = 12340 WHERE `ID` = 114;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'How goes your conflict with the shadowcasters? Did you find the midnight orbs?', `VerifiedBuild` = 12340 WHERE `ID` = 115;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 25, `EmoteOnIncomplete` = 25, `CompletionText` = 'I need you to pick up a keg of Thunderbrew Lager from Grimbooze Thunderbrew in the Westfall hills, a cask of Merlot from Stormwind, a bottle of Moonshine from Darkshire and a skin of Sweet Rum from Goldshire. Bring those back to me and I will see to it you are rewarded.', `VerifiedBuild` = 12340 WHERE `ID` = 116;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 94, `EmoteOnIncomplete` = 94, `CompletionText` = 'Hurry, my friend, move with haste $bIn order for our rich lager to taste $bMore like beer and less like stew, $bHops are needed to make the brew.', `VerifiedBuild` = 12340 WHERE `ID` = 117;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'What\'s that? Verner sent you, you say? Well give me his note. And SPEAK UP!', `VerifiedBuild` = 12340 WHERE `ID` = 118;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Great, you\'re back! Did you get the shoes?', `VerifiedBuild` = 12340 WHERE `ID` = 119;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'What have you there?', `VerifiedBuild` = 12340 WHERE `ID` = 120;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did the General send news? Are reinforcements on the way?', `VerifiedBuild` = 12340 WHERE `ID` = 121;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'I know that greedy Argus will send someone to collect his scales if I don\'t give them to him soon. Have you found those scales yet?', `VerifiedBuild` = 12340 WHERE `ID` = 122;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Were you able to find my tools?', `VerifiedBuild` = 12340 WHERE `ID` = 125;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Yowler is a dangerous creature, $N. If you\'re not ready for him, I understand.', `VerifiedBuild` = 12340 WHERE `ID` = 126;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'You have some sunfish for me, eh?', `VerifiedBuild` = 12340 WHERE `ID` = 127;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 25, `CompletionText` = 'Return once you have slain 15 Blackrock Champions.', `VerifiedBuild` = 12340 WHERE `ID` = 128;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Darcy sent me a lunch, did she? Such a kind heart she has. Well...let\'s have it!', `VerifiedBuild` = 12340 WHERE `ID` = 129;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Hello again, $N. Did Parker like the lunch I sent him?', `VerifiedBuild` = 12340 WHERE `ID` = 131;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Good to see you back, $N. What did Wiley have to say for himself?', `VerifiedBuild` = 12340 WHERE `ID` = 132;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'I think I hear a pack of Ghouls scurrying around the back of the house - I better put that effigy up quick! Did you get those Ghoul Ribs for me?', `VerifiedBuild` = 12340 WHERE `ID` = 133;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do you have my crate? If so, then please...give it to me quickly!', `VerifiedBuild` = 12340 WHERE `ID` = 134;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'What business do you have with me? I am a very busy man. . .', `VerifiedBuild` = 12340 WHERE `ID` = 135;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Did Master Shaw shed any light on things?', `VerifiedBuild` = 12340 WHERE `ID` = 141;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = '$N, were you able to gather any information? Did you locate the messenger?', `VerifiedBuild` = 12340 WHERE `ID` = 142;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Hail, $C. What business do you have with The People\'s Militia?', `VerifiedBuild` = 12340 WHERE `ID` = 143;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Shall we expect the People\'s Militia soon? Does Lord Stoutmantle\'s news bode well?', `VerifiedBuild` = 12340 WHERE `ID` = 144;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You appear to have traveled from afar, $C. What business do you have here in Darkshire?', `VerifiedBuild` = 12340 WHERE `ID` = 145;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Ah, good to see you back, messenger. Shall I inform the Marshal that the Night Watch is on its way from Darkshire?', `VerifiedBuild` = 12340 WHERE `ID` = 146;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Did you find the Collector? Did you discover whom he\'s working for?', `VerifiedBuild` = 12340 WHERE `ID` = 147;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do you have those fins? Hurry, we need those murlocs driven from the lake!', `VerifiedBuild` = 12340 WHERE `ID` = 150;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Old Blanchy is on her last leg. Did you happen to find any oats for her?', `VerifiedBuild` = 12340 WHERE `ID` = 151;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Bring me 15 red leather bandanas and I\'ll pay you well.', `VerifiedBuild` = 12340 WHERE `ID` = 153;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'I sense that you have seen Blind Mary. You have my Comb...?', `VerifiedBuild` = 12340 WHERE `ID` = 154;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Hi, $N. You have that rot blossoms for me yet?', `VerifiedBuild` = 12340 WHERE `ID` = 156;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'I need to string the Ghost Hair Thread along my door and my windows to keep out unwanted spirits. Did you get it for me?', `VerifiedBuild` = 12340 WHERE `ID` = 157;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'I need that Zombie Juice to keep me warm on these cold, dark nights. Did you get it for me?', `VerifiedBuild` = 12340 WHERE `ID` = 159;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Abercrombie...? I don\'t know a person of that name. You say you have a letter for me from this Abercrombie fellow?$B$BWell let\'s have it then...', `VerifiedBuild` = 12340 WHERE `ID` = 160;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'You say somethin\', sonny? Can\'t hear a bloody thing besides the ringin\' in me ears. Say, what\'s that you got there?', `VerifiedBuild` = 12340 WHERE `ID` = 161;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'You look a sturdy type, $C. Have you come to join our fight?', `VerifiedBuild` = 12340 WHERE `ID` = 164;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'How goes the hunt for Edwin VanCleef?', `VerifiedBuild` = 12340 WHERE `ID` = 166;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you find any sign of my brother? Is there any hope after all this time?', `VerifiedBuild` = 12340 WHERE `ID` = 167;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Were you able to retrieve any of my old co-worker\'s Miners\' Union Cards?', `VerifiedBuild` = 12340 WHERE `ID` = 168;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'What do you have there, $R?', `VerifiedBuild` = 12340 WHERE `ID` = 169;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Tenacious little buggers, aren\'t they?', `VerifiedBuild` = 12340 WHERE `ID` = 170;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you found a skilled engineer to create a bronze tube yet?', `VerifiedBuild` = 12340 WHERE `ID` = 174;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Yes, Hogger has been a real pain for me and my men. You have something to report about the beast?', `VerifiedBuild` = 12340 WHERE `ID` = 176;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'I showed Cog the beginnings of our star-viewing machine. He was impressed. Did you happen to find a reflective device?', `VerifiedBuild` = 12340 WHERE `ID` = 177;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'I spoke to you through a pendant, you say? Hmm...give it to me, so that I might study it.', `VerifiedBuild` = 12340 WHERE `ID` = 178;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'What news do you bring before the Court?', `VerifiedBuild` = 12340 WHERE `ID` = 180;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Were you able to convince Zzarc\'Vul to lend us his monocle for our experiment?', `VerifiedBuild` = 12340 WHERE `ID` = 181;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 1, `CompletionText` = 'From what I\'ve learned, these trolls hail from the Frostmane clan. I\'m afraid I don\'t know much else about them that would be of any use to you, $N.', `VerifiedBuild` = 12340 WHERE `ID` = 182;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 6, `CompletionText` = 'How goes the hunt?', `VerifiedBuild` = 12340 WHERE `ID` = 183;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 0, `CompletionText` = 'You have the deed to my farm?? That\'s good news! Some ruffians stole it days ago... I thought it was gone for good!$b$bPlease, let me have it. We\'re on our way out of Westfall and ain\'t coming back any time soon, but if we do then we\'ll need those papers...', `VerifiedBuild` = 12340 WHERE `ID` = 184;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'How goes the hunt for Sin\'Dall?', `VerifiedBuild` = 12340 WHERE `ID` = 188;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'You\'ve had success I hope? All over the place, those trolls. Filthy devils.$b$bOh yes, that reminds me! Be sure to tell your friends, yes? We could use much assistance!', `VerifiedBuild` = 12340 WHERE `ID` = 189;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Bhag\'thera can prove to be an elusive beast.  How fares the hunt?', `VerifiedBuild` = 12340 WHERE `ID` = 193;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'How goes the hunt for Tethis?  Tracked her all the way back to camp, did you?', `VerifiedBuild` = 12340 WHERE `ID` = 197;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Did you happen to discover any clues, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 199;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I see you\'re back, $g old bloke : lass;.  King Bangalash has caused me to come crawling back to camp many times.  Hang in there.', `VerifiedBuild` = 12340 WHERE `ID` = 208;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Tough buggers, aren\'t they? Well, have you had any luck? Sorry to seem impatient, but this has been a huge thorn in my side! Well?', `VerifiedBuild` = 12340 WHERE `ID` = 209;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Your task has been given to you, $N.  Do you have a shard from the lich\'s phylactery as proof of the task being accomplished?', `VerifiedBuild` = 12340 WHERE `ID` = 211;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = '$N! Do you have that haunch? I must begin preparing it soon, or the banquet will be ruined!', `VerifiedBuild` = 12340 WHERE `ID` = 212;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'I need those stones, $n. By whatever means necessary! Just do it, don\'t give me the details!$b$bIt\'s about results, $n, nothing more, nothing less.', `VerifiedBuild` = 12340 WHERE `ID` = 213;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you been reclaiming our land from the Defias gang? If so show me 10 Red Silk Bandanas as proof.', `VerifiedBuild` = 12340 WHERE `ID` = 214;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Grawmug and his two guards, Gnasher and Brawler, are still alive. Your mission is not complete until all 3 have been brought to death. The Dwarven empire is counting on you, $N.', `VerifiedBuild` = 12340 WHERE `ID` = 217;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = '$N! Any luck?', `VerifiedBuild` = 12340 WHERE `ID` = 218;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Yes, what is it? Make it quick, I\'ve pressing matters to attend to.', `VerifiedBuild` = 12340 WHERE `ID` = 223;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 5, `CompletionText` = 'Loch Modan is under siege, $N!  We need every able-bodied member of the Alliance to aid our cause.  Have you killed 10 Stonesplinter Troggs and 10 Stonesplinter Scouts yet?', `VerifiedBuild` = 12340 WHERE `ID` = 224;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'You still hunting wolves...?', `VerifiedBuild` = 12340 WHERE `ID` = 226;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I don\'t blame you if you\'re having trouble with him, $N. Some of our strongest Watchers have been lost to Mor\'Ladim.', `VerifiedBuild` = 12340 WHERE `ID` = 228;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 0, `CompletionText` = 'You found what?? Please, let me see it...', `VerifiedBuild` = 12340 WHERE `ID` = 230;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 25, `CompletionText` = 'We need more time, $r. Your orders are to kill 10 Stonesplinter Skullthumpers and 10 Stonesplinter Seers. Keep the enemy under pressure until we are granted reinforcements. This is no time for idle behavior.', `VerifiedBuild` = 12340 WHERE `ID` = 237;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = '$N, you\'re here! Do you have my food?!?', `VerifiedBuild` = 12340 WHERE `ID` = 240;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'Hurry, $N, before my fears of Morganth spreading his power are made real!', `VerifiedBuild` = 12340 WHERE `ID` = 249;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'A note from Abercrombie the hermit, eh? I don\'t know him, though if he lives out at the graveyard then I do know his brains have rotted out!', `VerifiedBuild` = 12340 WHERE `ID` = 251;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you yet found Eliza\'s grave? Do you have the Embalmer\'s heart?', `VerifiedBuild` = 12340 WHERE `ID` = 253;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you had any luck?', `VerifiedBuild` = 12340 WHERE `ID` = 255;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Yes? Is there something I can do for you?', `VerifiedBuild` = 12340 WHERE `ID` = 256;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'No luck? Don\'t feel too bad, $N...$B$BNot everyone can be me.', `VerifiedBuild` = 12340 WHERE `ID` = 257;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'It\'s only natural to feel sorry for yourself when shown up by someone so new to this world. You shouldn\'t feel bad, $N.$B$BHm? Did I get your name wrong?', `VerifiedBuild` = 12340 WHERE `ID` = 258;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 25, `CompletionText` = 'The Scourge grows in power with the passing of each day. If you truly wish to halt its advances, then show me.', `VerifiedBuild` = 12340 WHERE `ID` = 261;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'Back so soon? In case I didn\'t make myself clear we need you to kill 10 Stonesplinter Shaman and 10 Stonesplinter Bonesnappers, $N. Now go get\'em, Trogg-Slayer!', `VerifiedBuild` = 12340 WHERE `ID` = 263;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have 8 Trogg Stone Teeth to show me?  If not, there is still work to be done, $N.', `VerifiedBuild` = 12340 WHERE `ID` = 267;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you find who the Shadowy Figure was?', `VerifiedBuild` = 12340 WHERE `ID` = 268;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Ah, $N! Back so soon? No doubt you\'ve been at the hunt again? Don\'t worry if you\'ve had some setbacks, in the long run it will make you better!$B$B... You couldn\'t get much worse, anyway...', `VerifiedBuild` = 12340 WHERE `ID` = 271;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'What is that you bring from Ashlan?', `VerifiedBuild` = 12340 WHERE `ID` = 274;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'Do you have the needed items? Time is of the essence!!', `VerifiedBuild` = 12340 WHERE `ID` = 278;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Our merchants will not be safe until we are rid of Gobbler and those Murlocs.', `VerifiedBuild` = 12340 WHERE `ID` = 279;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 66, `EmoteOnIncomplete` = 66, `CompletionText` = 'Hail! Have a care, $N, the tunnel to Dun Morogh is infested with troggs and is not safe for travel.$b$bIf you haven\'t any pressing business in Dun Morogh, I\'ll have to ask you to remain in Anvilmar until the tunnel is safer.', `VerifiedBuild` = 12340 WHERE `ID` = 282;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do you have the statuette?', `VerifiedBuild` = 12340 WHERE `ID` = 286;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Oh, I\'m so very thirsty! Won\'t you buy a drink for this poor, pathetic fool?', `VerifiedBuild` = 12340 WHERE `ID` = 288;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Hmm... it would seem that my guards are becoming less discriminatory with petitioners. Well, what do you want? Make it quick.', `VerifiedBuild` = 12340 WHERE `ID` = 291;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'That drunk Fitzsimmons sent you to me? Well, you can tell him I don\'t have any extra ale. He\'s going to have to panhandle someone else!', `VerifiedBuild` = 12340 WHERE `ID` = 292;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'What is that orb you have? It looks...soiled.', `VerifiedBuild` = 12340 WHERE `ID` = 293;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 20, `EmoteOnIncomplete` = 20, `CompletionText` = 'Is Sarltooth dead? Have you redeemed the memory of the fallen?', `VerifiedBuild` = 12340 WHERE `ID` = 296;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have those Idols? We must study them and report our findings to Ironforge!', `VerifiedBuild` = 12340 WHERE `ID` = 297;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you uncovered the four fragments yet, $N?  Ados, Modr, Golm and Neru...', `VerifiedBuild` = 12340 WHERE `ID` = 299;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 25, `EmoteOnIncomplete` = 0, `CompletionText` = 'We Stormpikes don\'t like being bothered with trivial matters, $C. I hope you brought news worthy of my valuable attention.', `VerifiedBuild` = 12340 WHERE `ID` = 301;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Roggo has been unable to contact the reserve forces. We need offensive pressure on that Dark Iron encampment, $c. Now get back out there and serve your duty to King Magni!', `VerifiedBuild` = 12340 WHERE `ID` = 303;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Were you able to locate Balgaras the Foul yet, $C? He has been evading us for quite some time.', `VerifiedBuild` = 12340 WHERE `ID` = 304;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Were you able to find Merrin? Did she send word?', `VerifiedBuild` = 12340 WHERE `ID` = 306;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have that Miners\' Gear, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 307;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Hmph!  There  is all this booze down here, but I have strict orders not to touch it.  If only I could get a taste of some of our Thunder Ale...that would sharpen my wits, no lying!', `VerifiedBuild` = 12340 WHERE `ID` = 308;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Did you make the switch?', `VerifiedBuild` = 12340 WHERE `ID` = 311;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Were you able to get into my meat locker, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 312;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Hey, $N.  Been to the Grizzled Den yet?  Those Wendigos can be fierce.', `VerifiedBuild` = 12340 WHERE `ID` = 313;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Vagash still terrorizes the herd! Please help us by killing the wretched beast.', `VerifiedBuild` = 12340 WHERE `ID` = 314;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have that shimmerweed?  I almost have a batch of stout ready to brew, and I want to try throwing the weed in with this mixture.', `VerifiedBuild` = 12340 WHERE `ID` = 315;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Preparations are going well.  How goes your hunting?', `VerifiedBuild` = 12340 WHERE `ID` = 317;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Did you get that Evershine?', `VerifiedBuild` = 12340 WHERE `ID` = 320;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'How might I ply my craft for you, $C?', `VerifiedBuild` = 12340 WHERE `ID` = 322;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Battle hard, $Nn. And do not despair, for despair is evil\'s greatest weapon.', `VerifiedBuild` = 12340 WHERE `ID` = 323;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you find the lightforge iron you need?', `VerifiedBuild` = 12340 WHERE `ID` = 324;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 0, `CompletionText` = 'Greetings and welcome, $N. Have you yet tried one of our fine wines?', `VerifiedBuild` = 12340 WHERE `ID` = 332;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'You bring word from Mr. Bagley?', `VerifiedBuild` = 12340 WHERE `ID` = 333;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Wishock will soon garner enough support to cause us much grief. Were you able to obtain the Tear of Tilloa or Musquash Root yet?', `VerifiedBuild` = 12340 WHERE `ID` = 335;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'Can you not see that I am busy? My words must be heard! I am very important to the future of this Kingdom!$B$BOh... what have you there? Why it looks like a refreshing drink...', `VerifiedBuild` = 12340 WHERE `ID` = 336;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Ooh! What\'s that old book you have there? Can I see it??', `VerifiedBuild` = 12340 WHERE `ID` = 337;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you assembled the chapters yet, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 338;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Were you able to find the book?', `VerifiedBuild` = 12340 WHERE `ID` = 346;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the Rethban Ore?', `VerifiedBuild` = 12340 WHERE `ID` = 347;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'You come all the way from Stormwind? I hear it\'s getting dicey down there in the human lands, with brigands and orcs running about. A perfect place for a $C to prove his worth!', `VerifiedBuild` = 12340 WHERE `ID` = 353;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do you have the remains of the Agamands? Are those cursed beasts finally destroyed?', `VerifiedBuild` = 12340 WHERE `ID` = 354;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = '$N, have you acquired the book?', `VerifiedBuild` = 12340 WHERE `ID` = 357;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Is your task complete?  Have you destroyed those dog-things and drained them of their ichor?', `VerifiedBuild` = 12340 WHERE `ID` = 358;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Did you find Devlin?', `VerifiedBuild` = 12340 WHERE `ID` = 362;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Deathguard Simmer sent word that you were going to provide me with some much needed reagents. Were you able to gather 10 pumpkins yet, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 365;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 0, `CompletionText` = 'Have you collected 5 vials of darkhound blood yet, $N? Time is fleeting!', `VerifiedBuild` = 12340 WHERE `ID` = 367;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = '$N, were you able to obtain 5 Vile Fin Scales from the Murlocs?', `VerifiedBuild` = 12340 WHERE `ID` = 368;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do you have some venom from a Vicious Night Web Spider yet, $N? It\'s the final component I need in order to test my experiment.', `VerifiedBuild` = 12340 WHERE `ID` = 369;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Yes? Is there something I can help you with?', `VerifiedBuild` = 12340 WHERE `ID` = 373;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Have you collected 10 Scarlet Insignia Rings yet, $c?', `VerifiedBuild` = 12340 WHERE `ID` = 374;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do you have five Duskbat Pelts and some Coarse Thread yet, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 375;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do try your best to keep yourself unharmed until I get you some armor.', `VerifiedBuild` = 12340 WHERE `ID` = 376;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'So long as a molester of the dead like Dextren Ward is permitted to live, justice stands betrayed. Return to me once Lord Ebonlocke\'s sentence of death is carried out on that defiler, Ward. We shall give the families of the dead the closure they deserve and better yet, we will send a clear message to the House of Nobles in Stormwind.', `VerifiedBuild` = 12340 WHERE `ID` = 377;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I won\'t let foolish Human bureaucracy interfere with Dwarven matters, $N. Kam Deepfury is a proven conspirator in the Thandol Span attack. King Magni\'s good people lost their lives because of Deepfury\'s deceit. The Humans might be content to let Deepfury rot in The Stockade but I will not sleep soundly at night until Deepfury is slain.', `VerifiedBuild` = 12340 WHERE `ID` = 378;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Well, did the nomads \'volunteer\' up those water pouches for you?', `VerifiedBuild` = 12340 WHERE `ID` = 379;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'How goes your mission, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 382;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Yes, what do you want?', `VerifiedBuild` = 12340 WHERE `ID` = 383;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I\'m going to need six crag boar ribs and a mug of Rhapsody Malt, $N.', `VerifiedBuild` = 12340 WHERE `ID` = 384;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did I tell you about the time I almost lost my hand to one of the crocs? Nasty bugger it was, teeth like knives. But I was lucky... Jammed the brute\'s jaw shut with my knife. Still have the knife around here somewhere...', `VerifiedBuild` = 12340 WHERE `ID` = 385;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you been to Stormwind yet, to The Stockade? I fear whatever trickery that has kept Targorr the Dread alive for this long will eventually bring about his freedom. He was sentenced to die, $N, not act as some political pawn on a noble\'s whim.', `VerifiedBuild` = 12340 WHERE `ID` = 386;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 5, `CompletionText` = 'The Stockade is still overrun! These Defias Rats must be shown that their actions will not be tolerated. Now get back down there and show some force!', `VerifiedBuild` = 12340 WHERE `ID` = 387;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'I see you are back, $c.  Have you collected 10 Red Wool Bandanas from those Defias Scum in The Stockade yet?', `VerifiedBuild` = 12340 WHERE `ID` = 388;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Either you bring me Thredd\'s head, or I\'ll take yours, understand, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 391;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Yes, $N? What have you found?', `VerifiedBuild` = 12340 WHERE `ID` = 392;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Greetings. Of what service can I be to you, $C?', `VerifiedBuild` = 12340 WHERE `ID` = 393;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = '$N, yes? I was informed by Baros Alexston that you would be coming. I must say, I am most interested in what you have to say.', `VerifiedBuild` = 12340 WHERE `ID` = 396;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Yes?', `VerifiedBuild` = 12340 WHERE `ID` = 398;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = '$N! Did you have any luck?', `VerifiedBuild` = 12340 WHERE `ID` = 399;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Hm?  You look a little young to be a siege engine pilot.  But no matter...do you need something fixed?$B$BWell take a number and get comfortable.  I\'m working on a couple engines right now and won\'t have time for another job for at least a few days.$B$BOr, were you here for something else...?', `VerifiedBuild` = 12340 WHERE `ID` = 400;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Greetings. Either you do not know who I am, or your business with me is urgent.$b$bBecause if neither of these were true, then you would not be foolish enough to disturb me...', `VerifiedBuild` = 12340 WHERE `ID` = 405;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Time is not a luxury we have, $N. With each passing hour, the Scourge\'s hold on Tirisfal Glades grows more firm.', `VerifiedBuild` = 12340 WHERE `ID` = 408;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Have you returned Gunther\'s book? Has he responded?', `VerifiedBuild` = 12340 WHERE `ID` = 411;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'The Recombobulator will be up and running as soon as we have sufficient Restabilization Cogs and Gyromechanic Gears.', `VerifiedBuild` = 12340 WHERE `ID` = 412;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 3, `EmoteOnIncomplete` = 0, `CompletionText` = 'Hello, $C!  And what business takes you all the way out here?$B$BSomething exciting, I hope.  I haven\'t been in a good fight in days, and this barrel of ale is almost dry...', `VerifiedBuild` = 12340 WHERE `ID` = 413;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 0, `CompletionText` = 'Greetings, $C, and welcome to Thelsamar!', `VerifiedBuild` = 12340 WHERE `ID` = 414;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Hail, $N. How goes the rat catching?', `VerifiedBuild` = 12340 WHERE `ID` = 416;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Hello, $N. Do you have word of my friend Hildelve?', `VerifiedBuild` = 12340 WHERE `ID` = 417;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'I\'m all ready to start cooking, do you have the ingredients for me?', `VerifiedBuild` = 12340 WHERE `ID` = 418;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Before I know what we are dealing with here, $C, I need to study the spell known as Remedy of Arugal. Bring it to me now or I shall be forced to find myself a worthy servant.', `VerifiedBuild` = 12340 WHERE `ID` = 422;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'I will need 6 Glutton Shackles and 3 Darksoul Shackles before I can assess the situation and devise a final solution for Arugal. Now heed your bidding and slay Moonrage Gluttons and Moonrage Darksouls until you have what I need.', `VerifiedBuild` = 12340 WHERE `ID` = 423;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Has Grimson the Pale been slain? Varimathras will not be pleased if we ignore his bidding.', `VerifiedBuild` = 12340 WHERE `ID` = 424;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Have you killed Ivar the Foul? If you won\'t do it for me and my brother, then do it for the Forsaken.', `VerifiedBuild` = 12340 WHERE `ID` = 425;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Our battles with the Scourge wage on, $N. Do your part and throw those cursed, mindless undead back into the Plaguelands!', `VerifiedBuild` = 12340 WHERE `ID` = 426;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'My sister told me you were here to aid us. Is that true?', `VerifiedBuild` = 12340 WHERE `ID` = 430;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 15, `CompletionText` = 'It makes me so mad! Grrr...', `VerifiedBuild` = 12340 WHERE `ID` = 432;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Have you defeated Nightlash, $N?  Our success against the rot hides depends on her destruction!', `VerifiedBuild` = 12340 WHERE `ID` = 437;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = '$N. You return, so I assume your investigations bore fruit?', `VerifiedBuild` = 12340 WHERE `ID` = 439;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Hello, $N. What brings you back to Brill?', `VerifiedBuild` = 12340 WHERE `ID` = 440;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do I know you?', `VerifiedBuild` = 12340 WHERE `ID` = 441;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'The Scourge cannot be allowed to remain in Silverpine, $N. Come back to me when you have proof of Thule\'s death.', `VerifiedBuild` = 12340 WHERE `ID` = 442;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do you have the rot hide ichor, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 443;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'My studies require great concentration. So I hope your visit is not a frivolous one.', `VerifiedBuild` = 12340 WHERE `ID` = 444;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'What business do you have with me, $C?', `VerifiedBuild` = 12340 WHERE `ID` = 445;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Greetings, $N. What did Bethor have to say?', `VerifiedBuild` = 12340 WHERE `ID` = 446;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 66, `EmoteOnIncomplete` = 66, `CompletionText` = 'Hail, $C. What business do you have with the Royal Apothecary Society?', `VerifiedBuild` = 12340 WHERE `ID` = 447;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Did you discover the fate of the Deathstalkers?', `VerifiedBuild` = 12340 WHERE `ID` = 449;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I see you are back, $N.', `VerifiedBuild` = 12340 WHERE `ID` = 450;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'What brings you back to the Undercity, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 451;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 0, `CompletionText` = 'Who are you?? Leave me be!', `VerifiedBuild` = 12340 WHERE `ID` = 453;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'There is still work to be done, $N. Return to me once you have thinned the nightsaber and thistle boar populations.', `VerifiedBuild` = 12340 WHERE `ID` = 456;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 25, `EmoteOnIncomplete` = 25, `CompletionText` = 'Your task is not yet complete, $N. Return to me once 7 mangy nightsabers and 7 thistle boars have been killed.', `VerifiedBuild` = 12340 WHERE `ID` = 457;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Have you attacked the Dragonmaw encampment?', `VerifiedBuild` = 12340 WHERE `ID` = 464;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Where is that ore, $N?!', `VerifiedBuild` = 12340 WHERE `ID` = 466;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Did you find my bag?', `VerifiedBuild` = 12340 WHERE `ID` = 470;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 18, `EmoteOnIncomplete` = 18, `CompletionText` = 'My apprentice is like a son to me. It\'s going to be hard for him to live his life with only one leg.$b$bAh, $N, how goes it? Do you have my skins?', `VerifiedBuild` = 12340 WHERE `ID` = 471;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Have you killed Nek\'rosh?', `VerifiedBuild` = 12340 WHERE `ID` = 474;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Have you learned anything useful, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 478;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'We must hurry, their plans must not come to fruition, or we may lose our hold on Silverpine Forest.', `VerifiedBuild` = 12340 WHERE `ID` = 479;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Quickly, time runs short, $N!', `VerifiedBuild` = 12340 WHERE `ID` = 480;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Yes, $C? What is it?', `VerifiedBuild` = 12340 WHERE `ID` = 481;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = '$N, right? Do you have my skins?', `VerifiedBuild` = 12340 WHERE `ID` = 484;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 5, `CompletionText` = 'The road is still not safe, $c. Travel forth and slay 6 Gnarlpine Ambushers and return to me.', `VerifiedBuild` = 12340 WHERE `ID` = 487;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = '$N. Have you defeated Thule Ravenclaw?', `VerifiedBuild` = 12340 WHERE `ID` = 491;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'You have something for me?', `VerifiedBuild` = 12340 WHERE `ID` = 493;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I see you are back. I hope you were able to gather the agents I need. Another deathless day will put me in such a gloomy mood.', `VerifiedBuild` = 12340 WHERE `ID` = 496;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = '$N, are you still hunting ogres? Do you have the knucklebones I had you gather?', `VerifiedBuild` = 12340 WHERE `ID` = 500;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I remember you, $N. You were going to help me out in concocting my latest elixir. I\'ll need that blood before I can bring my own special brand of misery to the inhabitants of Hillsbrad.', `VerifiedBuild` = 12340 WHERE `ID` = 501;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Give me the key, $C, I will undo the lock myself.', `VerifiedBuild` = 12340 WHERE `ID` = 503;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'You\'ve returned, $N. Success to report?', `VerifiedBuild` = 12340 WHERE `ID` = 508;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Any luck at Nethander Stead?', `VerifiedBuild` = 12340 WHERE `ID` = 509;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = '$N, you look anxious. Is there something you wish to tell me?', `VerifiedBuild` = 12340 WHERE `ID` = 510;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Yes, $N? Do you have some business with me?', `VerifiedBuild` = 12340 WHERE `ID` = 511;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Have you been hunting the Syndicate? Do you have those rings?', `VerifiedBuild` = 12340 WHERE `ID` = 512;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 0, `CompletionText` = 'Can you not see I am busy, $C? The Dark Lady insists on a new plague before the Scourge advance from Northrend overwhelms us. And with the human threat pressing from the south, time becomes my most precious commodity. This better be important!', `VerifiedBuild` = 12340 WHERE `ID` = 513;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Dibbs from Southshore sent you, did he? How is the old bookworm doing?', `VerifiedBuild` = 12340 WHERE `ID` = 514;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'So glad to see you back, $N. I was growing so terribly bored here. Not a single entertaining thing to do besides poison and disease Umpi and reanimate her. . .over and over and over again.$b$bHow went the trip to the Undercity? Were you fortunate enough to slaughter any humans along the way?', `VerifiedBuild` = 12340 WHERE `ID` = 515;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Sometimes I get so bored out here in Tarren Mill I like to open up the formaldehyde jar and let the lovely aroma waft through the air. Makes Umpi a little nervous though.$b$bSo were you able to get a keg from the Dwarves? I swear if I have to stare at this deadly elixir without using on it someone for another day I am going to scream.', `VerifiedBuild` = 12340 WHERE `ID` = 517;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'You look out of breath! Do you have something to report?', `VerifiedBuild` = 12340 WHERE `ID` = 522;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Baron Vardus cannot think Southshore will allow him to send his thugs against us with impunity. I want his head!', `VerifiedBuild` = 12340 WHERE `ID` = 523;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = '$N. Have you been traveling through the foothills and mountains again? What news do you bring?', `VerifiedBuild` = 12340 WHERE `ID` = 525;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Were you able to carry out your orders, $C? Did you dispose of Verringtan and his assistants? And where is that iron shipment?', `VerifiedBuild` = 12340 WHERE `ID` = 529;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have those hands, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 530;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 11, `EmoteOnIncomplete` = 0, `CompletionText` = 'Great job, $N! We really showed him! Here, give me the head and I\'ll take care of it.', `VerifiedBuild` = 12340 WHERE `ID` = 531;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'What news have you?', `VerifiedBuild` = 12340 WHERE `ID` = 532;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you found anything? I fear Gol\'dir\'s prospects grow worse by the day...', `VerifiedBuild` = 12340 WHERE `ID` = 533;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Did you find the envoys of The Argus Wake?', `VerifiedBuild` = 12340 WHERE `ID` = 537;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'I wish I could search the ruins too, but I fear these bones wouldn\'t hold me during my climb up the mountains. However, how does your hunt for knowledge progress, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 540;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = '$N, you\'ve returned! How did your foray into Alterac go? Did you bring anything back with you?', `VerifiedBuild` = 12340 WHERE `ID` = 542;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Salutations, $N. Do try to avoid stepping on my pant cuffs. This outfit is newly tailored.', `VerifiedBuild` = 12340 WHERE `ID` = 543;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'So the lucky $N returns? How many humans have you slaughtered today? Hundreds I do hope!$b$bHave you any skulls for me?', `VerifiedBuild` = 12340 WHERE `ID` = 546;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Were you able to retrieve my sword, $N? High Executor Darthalia will hang me from the rafters if she discovers my folly.', `VerifiedBuild` = 12340 WHERE `ID` = 547;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Oh. You have something you\'d like me to look at? Some scrap of lore gathered from up in the mountains, I hope...', `VerifiedBuild` = 12340 WHERE `ID` = 551;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you recovered Helcular\'s Rod yet? There are so many Yeti in this region, it will be very difficult to locate. But we must have it in order to proceed.', `VerifiedBuild` = 12340 WHERE `ID` = 552;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'More interruptions?$B$BAh, this parchment is covered with a very intricate, finely woven spell. I can untangle it, of course, but it\'s going to take time. And time is very valuable to me...$B$BPerhaps I will just purchase it from you?', `VerifiedBuild` = 12340 WHERE `ID` = 554;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Any luck finding the ingredients? I\'ll tell you, this territory isn\'t the peaceful place it once was. Ah, if only this unrest never occurred...', `VerifiedBuild` = 12340 WHERE `ID` = 555;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Hello, $N. Elementals are tough quarry, but I know you\'re up to the task. Do you have those bracers of binding?', `VerifiedBuild` = 12340 WHERE `ID` = 557;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Did you get those heads for me, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 559;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Greetings, citizen. Have you come to lend your arm to upholding the safety of Southshore?', `VerifiedBuild` = 12340 WHERE `ID` = 560;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'I\'ve a letter ready to go to Major Samuelson in Stormwind. All I need are the results.', `VerifiedBuild` = 12340 WHERE `ID` = 562;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 5, `CompletionText` = 'Mountain Lions killin\' off our horses left and right and here you are wantin\' to jibber-jabber about the weather and what not.$B$BOught to go and find myself a real hero. More killin\' and less talkin\'.', `VerifiedBuild` = 12340 WHERE `ID` = 564;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 94, `EmoteOnIncomplete` = 94, `CompletionText` = 'So you have returned to the great Bartolo. Perhaps you have finished gathering the materials needed for your Yeti Fur Cloak? Or maybe you just enjoy basking in the greatness of me, Bartolo!', `VerifiedBuild` = 12340 WHERE `ID` = 565;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Ah, $N. Perhaps you\'ve come to collect the bounty on the head of Baron Vardus?', `VerifiedBuild` = 12340 WHERE `ID` = 566;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you made any progress with the ogres of the Mizjah Ruins yet, $C?', `VerifiedBuild` = 12340 WHERE `ID` = 569;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'What news do you bring?', `VerifiedBuild` = 12340 WHERE `ID` = 570;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Has fortune been on your side, $N? Were you able to obtain an aged gorilla sinew?', `VerifiedBuild` = 12340 WHERE `ID` = 571;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did your gathering efforts prove fruitful?', `VerifiedBuild` = 12340 WHERE `ID` = 572;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'I am almost ready to complete the enchantment. Have you performed my bidding?', `VerifiedBuild` = 12340 WHERE `ID` = 573;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 3, `EmoteOnIncomplete` = 3, `CompletionText` = 'Ahoy, me bucko!  Might not be able to see but I can smell ye from halfway across port.$b$bCould really use me eye back.  Captain\'s going to keelhaul me when he finds out me peeper is in the hands of them dirty Bloodsail Buccaneers.$b$bWhat good is a lookout who can\'t see?  The crow\'s nest used to be me home...without me deadlights I\'d be lucky to scrub the bilge.', `VerifiedBuild` = 12340 WHERE `ID` = 576;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'King Varian has placed great importance on learning, and thus has provided funds for making copies of various tomes and writings available to the public. It\'s very simple. You bring me a library scrip, and I can give you a copy of one of the available books.', `VerifiedBuild` = 12340 WHERE `ID` = 579;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'Sink me!  I\'m almost outta booze here!  Cap\'n is goin\' to weigh anchor and Ol\' Slim will be caught dry as the Tanaris Desert.  And once he discovers his port is missing. . . blimey!', `VerifiedBuild` = 12340 WHERE `ID` = 580;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = '$C. Show me you have made prey of the Bloodscalp tribe.$b$bShow me your trophies.', `VerifiedBuild` = 12340 WHERE `ID` = 581;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Any luck finding the goods, matey?', `VerifiedBuild` = 12340 WHERE `ID` = 587;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'The Bloodscalps will one day be crushed by the Darkspears! Do you have the necklaces of our doomed foe?', `VerifiedBuild` = 12340 WHERE `ID` = 596;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'The Skullsplitters will curse the day they brought us to war! Is your task complete?', `VerifiedBuild` = 12340 WHERE `ID` = 598;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do you have those crystals?? I need them!!$b$bI mean...I need to know the evil Venture Company is losing ground in Stranglethorn. Because, you know, we honest folk have to make a living!', `VerifiedBuild` = 12340 WHERE `ID` = 600;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Ahoy, $n.  What word do you bring of the Bloodsail encampment to the south?', `VerifiedBuild` = 12340 WHERE `ID` = 604;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 25, `EmoteOnIncomplete` = 25, `CompletionText` = 'Hey!  I don\'t like the look you\'re giving me, $gmister:lady;.', `VerifiedBuild` = 12340 WHERE `ID` = 606;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Here here, $N.  Did you get Shaky\'s payment?', `VerifiedBuild` = 12340 WHERE `ID` = 607;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Ahoy, $N! Have you yet found Maury\'s Key?', `VerifiedBuild` = 12340 WHERE `ID` = 613;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 3, `EmoteOnIncomplete` = 3, `CompletionText` = 'Ahoy, $N! Did you find Gorlash? That chest was my favorite, and it has a hidden compartment that held my greatest treasures!', `VerifiedBuild` = 12340 WHERE `ID` = 614;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'If ya got no business with me, then move along, $N.', `VerifiedBuild` = 12340 WHERE `ID` = 617;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'I await the Tablet Shard, $N.', `VerifiedBuild` = 12340 WHERE `ID` = 629;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'I thank my ancestors someone has come to aid me. Do you have the key that will free me?', `VerifiedBuild` = 12340 WHERE `ID` = 630;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Any sign of Ol\' Rustlocke, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 632;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 5, `CompletionText` = 'The cache of explosives must be destroyed!', `VerifiedBuild` = 12340 WHERE `ID` = 633;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you located the first sigil yet? It is most likely carried on the person of one of the Syndicate agents in Stromgarde.', `VerifiedBuild` = 12340 WHERE `ID` = 639;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 66, `EmoteOnIncomplete` = 66, `CompletionText` = 'Throm\'ka, $c. Zengu informed me that you required my assistance?', `VerifiedBuild` = 12340 WHERE `ID` = 640;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = '$N! Do you have the second sigil?', `VerifiedBuild` = 12340 WHERE `ID` = 641;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Valorcall will not be easy to track down, $N. Mounted on horseback, he can cover ground quickly. Nonetheless, we must have his sigil.', `VerifiedBuild` = 12340 WHERE `ID` = 643;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You\'ve returned, $N. Is the line of Ignaeus Trollbane broken?', `VerifiedBuild` = 12340 WHERE `ID` = 644;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = '$N! Have you taken the sword?', `VerifiedBuild` = 12340 WHERE `ID` = 646;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'What\'s the good word, $R?', `VerifiedBuild` = 12340 WHERE `ID` = 647;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'Well, did you get everything you needed? If you didn\'t and the power runs out, everything inside will be ruined and you\'ll have to start over.$B$BHey, don\'t look to me for sympathy; I\'m all about the Gadgetzan Water Company making a profit, and if that means selling you power sources until we can afford to import water in from the icy springs of Dun Morogh, so be it!', `VerifiedBuild` = 12340 WHERE `ID` = 654;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'We appreciate your help in looking for that courier, $N.$B$BWhile you were gone, Kin saw an apothecary come out of that same house to the south of here. I\'m confident that they\'re up to no good--I just need proof of it before we go off and do something rash.$B$BHave you had any luck yet?', `VerifiedBuild` = 12340 WHERE `ID` = 658;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'How did the goggles work? Did everything function properly? Adjustments can be made if necessary.$b$bOh, and I\'ll need those goggles back when you\'re done. I am sure Captain O\'Breen will have many uses for them later on.', `VerifiedBuild` = 12340 WHERE `ID` = 666;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Ahoy, $C. What brings you to the bridge?', `VerifiedBuild` = 12340 WHERE `ID` = 668;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'What brings you to Booty Bay, $C?', `VerifiedBuild` = 12340 WHERE `ID` = 669;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Once-cursed blood still runs through my veins, $N. If someone... something is summoning demons, it must be stopped.', `VerifiedBuild` = 12340 WHERE `ID` = 671;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'I will create an amulet that will give Gor\'mul some of the strength of the raptors. Perhaps that will awaken some flame within him...', `VerifiedBuild` = 12340 WHERE `ID` = 672;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'The burning in my blood... it grows by the day. The warlock must be stopped.', `VerifiedBuild` = 12340 WHERE `ID` = 673;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'What hope is there when the hand of a coward can slay the mightiest of the mightiest? What hope, I ask you!', `VerifiedBuild` = 12340 WHERE `ID` = 674;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 5, `CompletionText` = 'I have not the time to sharpen my axe, let alone leave the outpost to slay those beasts that would try and slay my kin.$B$BYou do not seem to have the experience of a grunt let alone a full-fledged warrior, what do you want, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 676;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 25, `CompletionText` = 'If you have not yet completed my task, then perhaps you are a coward in heart as well as a tyro in war.', `VerifiedBuild` = 12340 WHERE `ID` = 677;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'You hesitate. Why? You have shown great strength thus far, $N. Do not fail me now.', `VerifiedBuild` = 12340 WHERE `ID` = 678;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Near the Tower of Arathor--that is where you will find Or\'Kalar. His death will stop the attacks on Hammerfall and protect my husband\'s life.$B$BI see in your eyes that you think me weak--even dishonorable--for my silence. Some day you will learn what it is to love as I do. Perhaps then you will understand a different kind of strength and honor.$B$BIn the meantime, do as I ask, and slay Or\'Kalar.', `VerifiedBuild` = 12340 WHERE `ID` = 680;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Have you retrieved any Stromgarde Badges, $N? The Syndicate must learn they cannot profit from our dead.', `VerifiedBuild` = 12340 WHERE `ID` = 682;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'So you are $N the $C? News of your contributions to the Alliance has traveled quite far, you know?$B$BOn what business do you come before me today?', `VerifiedBuild` = 12340 WHERE `ID` = 683;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Greetings, $C. You have a report to make?', `VerifiedBuild` = 12340 WHERE `ID` = 684;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Hello. Do you have a report to submit?', `VerifiedBuild` = 12340 WHERE `ID` = 685;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = '$N, $N, $N! Tell me you have enough Alterac Granite for me to begin my masterpiece in honor of Sully Balloo.', `VerifiedBuild` = 12340 WHERE `ID` = 689;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 690;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you had any luck so far, $N?$B$B<Kryten makes some notes in his journal as he reads.>$B$BIf my research is correct, the tusks should come from any Witherbark troll. The medicine pouches come from the Witherbark witch doctors, and the strongest of the Witherbark shadow hunters should carry the special knife given to them after they\'ve completed their rites of passage. There\'s no way to tell which shadow hunters will have the knife until you do battle.', `VerifiedBuild` = 12340 WHERE `ID` = 691;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'Did you find those fragments?!?! You\'ll need the Scroll of Myzrael if you want to trap her again, before it\'s too late!', `VerifiedBuild` = 12340 WHERE `ID` = 692;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Our goal is the wand, $N. Focus on that for now.', `VerifiedBuild` = 12340 WHERE `ID` = 693;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = '$N, hello again. Have you found an azure agate yet?', `VerifiedBuild` = 12340 WHERE `ID` = 694;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'You do this, an\' I\'m sure Malin\'ll be more than pleased with you.', `VerifiedBuild` = 12340 WHERE `ID` = 696;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Yes? You look vaguely familiar. I do apologize, but have we met? I get so busy I lose track.', `VerifiedBuild` = 12340 WHERE `ID` = 697;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 66, `EmoteOnIncomplete` = 66, `CompletionText` = 'Lok\'tar, $C. Traveling through the swamps isn\'t a risk taken lightly. You\'re brave to test your mettle here.', `VerifiedBuild` = 12340 WHERE `ID` = 698;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Good mead, a warm fire, an army of orcs and an arsenal of weapons... that\'s all we really need out here along the coast. I don\'t regret my position out here safeguarding Stonard, but it would be nice if we could one day get a burrow, or at least a tower.', `VerifiedBuild` = 12340 WHERE `ID` = 699;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'My preparations are made, all I require are the raptor hearts.', `VerifiedBuild` = 12340 WHERE `ID` = 701;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Returned again have you? Indeed there is nothing more I could wish for now than more of Tor\'gan\'s pity.$B$BWhat have you for me this time? Perhaps a piece of brightly colored string? Or a length of rope to end this misery of mine...', `VerifiedBuild` = 12340 WHERE `ID` = 702;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Hello, $N. Did you bring me my wings?', `VerifiedBuild` = 12340 WHERE `ID` = 703;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you find those urns, $N? We must find the link between them and the troggs!', `VerifiedBuild` = 12340 WHERE `ID` = 704;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you get my pearls?  I\'m almost out of flash bombs!', `VerifiedBuild` = 12340 WHERE `ID` = 705;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'How goes the hunt, $C?', `VerifiedBuild` = 12340 WHERE `ID` = 706;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'Did you find the tablet? It must hold secrets! Secrets to save us!', `VerifiedBuild` = 12340 WHERE `ID` = 709;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'This area\'s perfect for-- Could you hold these in place for a moment? Yes, just like that, along the vector normal. Now, what was I... Right. Perfect for testing my latest project. The raw materials, the open space... what more could an intelligent and enlightened practitioner of the arts ask for?', `VerifiedBuild` = 12340 WHERE `ID` = 710;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'The stone slabs you found were ideal, $N. Lucien will be taking the extra ones back to Kharanos when we\'re done here. After all, they could prove useful again.$B$BFor instance, they\'d be a nice basis for a handy little shelter once I start looking into a multidisciplinary approach to high-yield explosives...', `VerifiedBuild` = 12340 WHERE `ID` = 712;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you found the oil I need? It would be so helpful if you were able to find some.', `VerifiedBuild` = 12340 WHERE `ID` = 713;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Yes, yes, yes. Just a moment.', `VerifiedBuild` = 12340 WHERE `ID` = 714;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'He\'s getting closer to finishing. How are things going on your end?', `VerifiedBuild` = 12340 WHERE `ID` = 715;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'I wouldn\'t wait too long to get that bracer, $N.$b$bWho knows what\'s going to happen next?', `VerifiedBuild` = 12340 WHERE `ID` = 716;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Strong magics and powers held the drakes\' prison for so long, but we cannot allow any possibility that Blacklash and Hematus may be released.', `VerifiedBuild` = 12340 WHERE `ID` = 717;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'The desert\'s a bad place to be hungry, my friend, let me tell you that.$B$BHey... what\'s that over there...', `VerifiedBuild` = 12340 WHERE `ID` = 718;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Not sure what the Shadowforge were lookin\' for, but they definitely had a purpose.', `VerifiedBuild` = 12340 WHERE `ID` = 719;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'The Shadowforge clan... is dangerous. Be careful. You must find the amulet.', `VerifiedBuild` = 12340 WHERE `ID` = 722;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = 'Ah, yes. Another traveler seeking something from the dwarves.$B$B$G Sir : Ma\'am;, I\'m truly sorry, but I\'ve no time to answer meaningless questions right now.', `VerifiedBuild` = 12340 WHERE `ID` = 724;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Hmm? Yes, $C.', `VerifiedBuild` = 12340 WHERE `ID` = 725;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 3, `EmoteOnIncomplete` = 3, `CompletionText` = 'Hello. Welcome to my shop, but watch what you touch.$B$BKnowledge can be deadly.', `VerifiedBuild` = 12340 WHERE `ID` = 727;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Ah, we have an eager $C, I see. Are you here to learn from my collection? Good!$B$BBut be warned: just as knowledge gives power to the strong...it will drive the weak mad.', `VerifiedBuild` = 12340 WHERE `ID` = 728;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'The nomadic band of ogres travels between their camps across the Badlands; heat rising from the dry earth and the swirling winds will make it difficult to track their progress. I have heard that sometimes they travel through Camp Boff. If you are lost, you might try your search there.', `VerifiedBuild` = 12340 WHERE `ID` = 732;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Well, I\'ve made do with what I could, but... it\'s not much. Have you found any more supplies?', `VerifiedBuild` = 12340 WHERE `ID` = 733;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the relics for which I asked?', `VerifiedBuild` = 12340 WHERE `ID` = 735;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'How goes your mission, $c.', `VerifiedBuild` = 12340 WHERE `ID` = 736;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Ho! You were gone a long time. Did you get the digest?', `VerifiedBuild` = 12340 WHERE `ID` = 737;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Time is of the essence, $N. Ragnaros will not wait for us to prepare.', `VerifiedBuild` = 12340 WHERE `ID` = 762;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = '<Without looking up from the shackles, Lotwil holds out a hand and waggles his fingers impatiently.>$B$BThe cog, $N, the cog!', `VerifiedBuild` = 12340 WHERE `ID` = 777;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Not quite the outcome I was expecting. Could you get my shackles back?', `VerifiedBuild` = 12340 WHERE `ID` = 778;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Tho\'grun\'s betrayal... is there any wonder why the ogres are part of the Horde no longer? I will be glad to see him dead, and the Sign of the Earth returned.$B$BIf you\'ve not dispatched him yet, then waste no time going to Camp Boff.  It is to the southeast of Kargath.', `VerifiedBuild` = 12340 WHERE `ID` = 782;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 25, `CompletionText` = 'You have your orders, $N. The safety of Durotar is in question. Complete the task before you or hang your head in shame.$B$BShow your honor and defeat the humans of Tiragarde Keep.', `VerifiedBuild` = 12340 WHERE `ID` = 784;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I fought proudly alongside the Warchief when these lands were pioneered. The scars of battle mark my skin.$b$bThe honor of the Horde has been upheld with the help of my axe and battlecry during the defeat of Archimonde, when the unholy alliance was made with the humans and elves, wrought from necessity.$b$bBut my position as watchman and provider has given me a new sense of worth.', `VerifiedBuild` = 12340 WHERE `ID` = 791;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Is your task complete, $N? Do you have the Burning Blade Medallion?', `VerifiedBuild` = 12340 WHERE `ID` = 794;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Did you find Fizzle, $N? He, and rest of the Burning Blade, must be scoured from our lands!', `VerifiedBuild` = 12340 WHERE `ID` = 806;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do you have my brother\'s skull, $N? Is he finally free?', `VerifiedBuild` = 12340 WHERE `ID` = 808;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I\'m almost glad I can\'t return to Sen\'jin as I am now. My weakness and stupidity would surely be mocked.', `VerifiedBuild` = 12340 WHERE `ID` = 812;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Remember, no matter what creature you hunt, you would do well to study it and understand its behavior. That knowledge could save your life.', `VerifiedBuild` = 12340 WHERE `ID` = 813;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'Breakfast, lunch, dinner! Who cares which meal it is? It still has to be cooked by someone--namely me!', `VerifiedBuild` = 12340 WHERE `ID` = 815;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I pray that Kron will return to me, but I\'m almost certain I know his fate already.', `VerifiedBuild` = 12340 WHERE `ID` = 816;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I remember my first tiger hunt, $N. I chose to hunt on the largest of the Echo Isles, and I sat perfectly still in the shadows of its foliage for almost a full day... watching... waiting.$b$bMy muscles were taut, and I was ready to strike. It was one of my greatest victories when that tiger finally took the bait.', `VerifiedBuild` = 12340 WHERE `ID` = 817;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Time is the true test of your strength and will. Lose patience or give in to weakness, and your true self will be shown.', `VerifiedBuild` = 12340 WHERE `ID` = 818;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Yes?', `VerifiedBuild` = 12340 WHERE `ID` = 819;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'How\'s the search going?', `VerifiedBuild` = 12340 WHERE `ID` = 821;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You working hard at finding those ingredients, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 822;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Once we learn how the humans operate their strange machinery, we will stand a greater chance of defeating them in future battles.$b$bWith our new gained knowledge, the Horde only stands to grow in strength.', `VerifiedBuild` = 12340 WHERE `ID` = 825;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Is Zalazane defeated, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 826;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 2, `CompletionText` = 'My most humble greetings, $C. How might I help my $R brother today?', `VerifiedBuild` = 12340 WHERE `ID` = 829;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'There is a look of concern on your face, $C. What have you there?', `VerifiedBuild` = 12340 WHERE `ID` = 830;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'You have something vital to report. I can sense it behind your eyes.', `VerifiedBuild` = 12340 WHERE `ID` = 832;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 15, `EmoteOnIncomplete` = 0, `CompletionText` = 'What do you want, pup? If you\'re not here for recruitment, I don\'t have time for you.', `VerifiedBuild` = 12340 WHERE `ID` = 840;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Well well well, what do we have here? Has Kargal deemed me worthy of another recruit?', `VerifiedBuild` = 12340 WHERE `ID` = 842;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'Many innocent tauren lost their lives or were forced off their ancestral birthplace when the dwarves of Bael Modan arrived. My land must be reclaimed!', `VerifiedBuild` = 12340 WHERE `ID` = 843;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you collected the plainstrider beaks?', `VerifiedBuild` = 12340 WHERE `ID` = 844;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'How many zhevra have you slain?', `VerifiedBuild` = 12340 WHERE `ID` = 845;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I see you are back, $N.$B$BWhile Khazgorm\'s death might delay the digging in my ancestral lands some, it will by no means bring a total end to the destruction.$B$BThe Keep at Bael Modan is an increasing military threat. Built to defend the dig site, it is now poised for offensive force as well.$B$BIf you have the ingredients I requested, I can fashion a charge that will make the hasty dwarves reconsider their actions here in the Barrens.', `VerifiedBuild` = 12340 WHERE `ID` = 846;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do you have the spores, $N? There is a concoction I must send to my associate in Thunder Bluff, which requires the spores...', `VerifiedBuild` = 12340 WHERE `ID` = 848;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Hello, $N. Do you have Barak\'s Head for me?', `VerifiedBuild` = 12340 WHERE `ID` = 850;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Did you find Verog, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 851;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Is Hezrul defeated, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 852;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'You have something from Apothecary Helbrim?', `VerifiedBuild` = 12340 WHERE `ID` = 853;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'How goes your hunting, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 855;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'Where is the Tear of the Moons? I need it now! Need I say!', `VerifiedBuild` = 12340 WHERE `ID` = 857;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Did you get the horns, $N? Those things are going to make me a fortune!', `VerifiedBuild` = 12340 WHERE `ID` = 865;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Cut up enough of them yet? Keep slicing and taking trophies. I want 8 Witchwing talons.', `VerifiedBuild` = 12340 WHERE `ID` = 867;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Be careful with the eggs you find, $N. If they break, they be no good to me.', `VerifiedBuild` = 12340 WHERE `ID` = 868;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do you have those heads, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 869;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Cut off the head of their leader, and chaos ensues, $N. Learn this lesson well. It will aid you in the future.$B$BThe boars will flounder without direction, and we will be able to take back the Barrens.', `VerifiedBuild` = 12340 WHERE `ID` = 872;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Fear not the waters, $R.', `VerifiedBuild` = 12340 WHERE `ID` = 873;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do you have 6 Harpy Lieutenant Rings yet? Justice must be dealt to them for their vicious attacks on the Horde.', `VerifiedBuild` = 12340 WHERE `ID` = 875;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'You\'re not getting anything until I see Serena\'s head.', `VerifiedBuild` = 12340 WHERE `ID` = 876;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you been to the Stagnant Oasis? Was there a fissure beneath its waters?', `VerifiedBuild` = 12340 WHERE `ID` = 877;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'How goes your collection? Did you get the shells?', `VerifiedBuild` = 12340 WHERE `ID` = 880;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'The great cat calls to you, $N.', `VerifiedBuild` = 12340 WHERE `ID` = 881;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = '$N, have you bested Ishamuhale?', `VerifiedBuild` = 12340 WHERE `ID` = 882;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = '$N, when you approached I saw a new power in your stride. Tell me -- has your spirit met with the great Lakota\'mani?', `VerifiedBuild` = 12340 WHERE `ID` = 883;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = '$N, there is a new power behind your eyes! You have met with the mighty Owatanka, have you not?', `VerifiedBuild` = 12340 WHERE `ID` = 884;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'There is new resolve within you, $N. A resolve born from pain...$B$BAre you burdened with the death of Washte Pawne?', `VerifiedBuild` = 12340 WHERE `ID` = 885;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Did you find my things, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 888;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Wares to send on the next ship, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 890;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'My fleet is in peril with Captain Fairmount and her damned cannoneers blasting away from Northwatch Hold. I want her soldiers to pay as well. Fill my hand with medals from their dead and I will know that vengeance has been given to my fallen privateers.', `VerifiedBuild` = 12340 WHERE `ID` = 891;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'So, what did Dizzywig have to say?', `VerifiedBuild` = 12340 WHERE `ID` = 892;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I, too, have doubts that the pathetic quilboars could attain any level of skill in the area of smithing, but I do as the Warchief commands, and I shall learn what I can about the Razormane tribe.$B$BI have had more menial tasks, and I do so willingly if it aids the orc people.', `VerifiedBuild` = 12340 WHERE `ID` = 893;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'What\'s happening? Something I can help you with? Goods to ship, perhaps an engineering job?', `VerifiedBuild` = 12340 WHERE `ID` = 895;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'If only we knew which one of the miners had found the emerald, it\'d be a walk in the park...', `VerifiedBuild` = 12340 WHERE `ID` = 896;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You seemed troubled, $N. How go your lessons in the Barrens? Did you find something that disturbs you?', `VerifiedBuild` = 12340 WHERE `ID` = 897;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'The quilboar will pay for this, $N. I swear it.', `VerifiedBuild` = 12340 WHERE `ID` = 899;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'How goes your hunt, $N? Have you found the prowlers?', `VerifiedBuild` = 12340 WHERE `ID` = 903;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Yes, what is it?', `VerifiedBuild` = 12340 WHERE `ID` = 906;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Are the thunder lizards defeated, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 907;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = 'Are we there yet?', `VerifiedBuild` = 12340 WHERE `ID` = 911;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Is it done? Have you slain the thunderhawk?', `VerifiedBuild` = 12340 WHERE `ID` = 913;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Memories of my nightmares haunt me, $N. Have you defeated the leaders of the fang and acquired their gems?', `VerifiedBuild` = 12340 WHERE `ID` = 914;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you gather the venom sacs, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 916;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you been inside the Shadowthread Cave, $N? Did you find a spider egg?', `VerifiedBuild` = 12340 WHERE `ID` = 917;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the seeds? I am eager to plant them.', `VerifiedBuild` = 12340 WHERE `ID` = 918;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 3, `EmoteOnIncomplete` = 3, `CompletionText` = 'Hello, $N. Have you found any sprouts near the waters?', `VerifiedBuild` = 12340 WHERE `ID` = 919;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 0, `CompletionText` = 'Hello...$b$bAnd how may I help you?', `VerifiedBuild` = 12340 WHERE `ID` = 922;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 3, `EmoteOnIncomplete` = 3, `CompletionText` = 'Have you been to Wellspring Lake, $N? Have you been hunting the timberlings there?', `VerifiedBuild` = 12340 WHERE `ID` = 923;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 3, `EmoteOnIncomplete` = 3, `CompletionText` = 'Hello again, $N. Have you completed your task?', `VerifiedBuild` = 12340 WHERE `ID` = 929;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = '$N, you look like you have something to tell me. Do you have news concerning the timberlings?', `VerifiedBuild` = 12340 WHERE `ID` = 930;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'You have something for me?', `VerifiedBuild` = 12340 WHERE `ID` = 931;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'I know that I did not summon you, so I cannot help but wonder why it is you have come to speak with me.$B$BWhatever it is, please make it quick.', `VerifiedBuild` = 12340 WHERE `ID` = 935;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Their slashing talons and piercing beaks may prove a difficult match for your own abilities, $N, but I have faith that you will not fail in this task.', `VerifiedBuild` = 12340 WHERE `ID` = 937;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'What is it, $C? You look concerned.', `VerifiedBuild` = 12340 WHERE `ID` = 939;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have my mushrooms, $N? Have you been to the cave?', `VerifiedBuild` = 12340 WHERE `ID` = 947;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'The pillars of this shrine are as the bars of a prison to me, $N. No strength I still possess might break them, and no magic I wield might destroy them...$B$BFor a thousand years and more I have stared at them, wondering if at long last I outlived even the stone, would I be free? Or would it be invisible bars that held me then...', `VerifiedBuild` = 12340 WHERE `ID` = 956;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'If only the tools of their undoing could have been destroyed in the cataclysm that destroyed our world... Nonetheless, we must do what we can to ensure that the horrors of our past are not repeated in the future.', `VerifiedBuild` = 12340 WHERE `ID` = 958;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'The dockmaster has been on my case ever since Mad Magglish made off with that 99-year-old port. I guess that bottle was intended as a gift for Gazlowe from none other than Baron Revilgaz himself.$B$BIf you\'re brave enough and patient enough to seek out Mad Magglish and get that port back, I\'ll see to it you get a nice reward.', `VerifiedBuild` = 12340 WHERE `ID` = 959;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'With a great sorrow in my heart, I followed the Shan\'do Stormrage into hibernation, and took my sorrow to my dreams, sleeping for the passing of thousands of years.', `VerifiedBuild` = 12340 WHERE `ID` = 963;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Kill many and kill often, $C - we\'ll need a decent supply of suitable skeletal fragments to make up the outer layer of the key. They don\'t call it a Skeleton Key for nothing, you know.', `VerifiedBuild` = 12340 WHERE `ID` = 964;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you found any more of their scrolls? I should be able to piece together a larger picture of the cult if you can find them.', `VerifiedBuild` = 12340 WHERE `ID` = 966;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'You have some business with me, $C?', `VerifiedBuild` = 12340 WHERE `ID` = 967;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 3, `EmoteOnIncomplete` = 0, `CompletionText` = 'Hello, $Gsir:madam;.$B$BMay I interest you in one of my tomes?', `VerifiedBuild` = 12340 WHERE `ID` = 968;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 11, `EmoteOnIncomplete` = 11, `CompletionText` = 'Bring back da shards, and I be tellin\' you more!', `VerifiedBuild` = 12340 WHERE `ID` = 969;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you acquired that soul gem?', `VerifiedBuild` = 12340 WHERE `ID` = 970;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'The journey to Ashenvale is long, and your task is not easy. But if you get me the manuscript, $N...then your reward will be great.', `VerifiedBuild` = 12340 WHERE `ID` = 971;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You look a bit shaken up, $n. Are you well?', `VerifiedBuild` = 12340 WHERE `ID` = 973;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I\'d go there myself, but... I\'m a little scared of the fire elementals there!', `VerifiedBuild` = 12340 WHERE `ID` = 974;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'I\'ve just about finished attaching the fur, $N. Please, hurry back with those horns!', `VerifiedBuild` = 12340 WHERE `ID` = 977;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Where could these powers have originated from? I think we are on the right track to find the answer, $N.', `VerifiedBuild` = 12340 WHERE `ID` = 978;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'The captains of those ships were good night elves, and they deserve a better fate than they were given. Perhaps tending to their personal effects will be the best way to put their spirits to rest.', `VerifiedBuild` = 12340 WHERE `ID` = 982;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Do not stay your hand from what must be done, child. I know how repulsive the idea of killing the creatures of the forest must be, but in this case it is necessary. No cure has been discovered for the corruption let loose upon the forest, and we must do what we can to halt its progress until one is found.', `VerifiedBuild` = 12340 WHERE `ID` = 985;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Welcome back, Junior Surveyor $n!  Have you completed your assignment yet?', `VerifiedBuild` = 12340 WHERE `ID` = 992;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = '', `VerifiedBuild` = 12340 WHERE `ID` = 993;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Have you found the statuette, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 1007;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'We cannot allow the naga to invade our coasts, $N.  It is vital that you go to the Zoram Strand and complete your mission.', `VerifiedBuild` = 12340 WHERE `ID` = 1008;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'It is said that the Ring of Zoram is the key to any lock within the city. Do you have it, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 1009;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you gathered the Bathran\'s Hair, $N?  The child\'s health grows weaker by the hour...', `VerifiedBuild` = 12340 WHERE `ID` = 1010;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you find the camp, $N? Do you have a bottle of disease?', `VerifiedBuild` = 12340 WHERE `ID` = 1011;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'With Arugal\'s death we stand to increase the Dark Lady\'s stronghold on Lordaeron.', `VerifiedBuild` = 12340 WHERE `ID` = 1014;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Since you must destroy the bracers to kill the elementals, it will probably be difficult to find the specific ones that contain the information the divining scroll needs. You can trade bracers with others in order to obtain the ones you need, or perhaps you have the divined paper already?', `VerifiedBuild` = 12340 WHERE `ID` = 1016;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Is it done? Is Sarilus Foulborne dead?', `VerifiedBuild` = 12340 WHERE `ID` = 1017;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 2, `CompletionText` = 'Ah, welcome back, $N.', `VerifiedBuild` = 12340 WHERE `ID` = 1023;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = '$N, did you find Iris Lake? Do you have the Tear?', `VerifiedBuild` = 12340 WHERE `ID` = 1033;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you yet have the Stardust, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 1034;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you face the Shadethicket Oracle, $N? If so, then please hand me the fallen moonstone. Relara has strength left for only a few more breaths!', `VerifiedBuild` = 12340 WHERE `ID` = 1035;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'What\'d you find out?', `VerifiedBuild` = 12340 WHERE `ID` = 1038;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'The woods are perilous for the unprepared. Keep your weapons close at hand and your wits even closer, or your next journey into the haunted forest may be your last.', `VerifiedBuild` = 12340 WHERE `ID` = 1043;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Have you slain Ran yet, my friend?$B$BEven the Night elves do not truly deserve his wrath. His hatred burns even brighter than my own, but his mind is no longer his own. He is a threat to all the natural creatures of this forest.', `VerifiedBuild` = 12340 WHERE `ID` = 1045;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'The Sentinels do what they can here in Ashenvale, but it\'s thanks to $rs like you that we have gained the ground we have.', `VerifiedBuild` = 12340 WHERE `ID` = 1046;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'The Monastery was a seminary for Paladins-in-training. Once a stronghold of the Light, it fell into the hands of the crazed zealots of the Scarlet Crusade.$b$bThe Crusade believed their goal a noble one: to purify the land of the undead plague. But insanity tainted their plight and now they stand enemies to all.$b$bBring Mythology of the Titans to me so I can study it and house it here in Ironforge.$b$bThe corrupt halls of the Monastery are no place for such a historical treasure.', `VerifiedBuild` = 12340 WHERE `ID` = 1050;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'The furbolgs\' corruption has caused Ashenvale to become a fraction of its former glory.', `VerifiedBuild` = 12340 WHERE `ID` = 1054;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 11, `EmoteOnIncomplete` = 11, `CompletionText` = 'Look at our poor little elf friends. All caged up with no forest to frolic in!$b$bNow were you able to find me some sap? How about the whiskers from the twilight runners? Don\'t suppose you have that fey dragon scale on you?$b$bAnd eyes! I\'ll need so many eyes! You just can\'t mix up a fierce forest magic brew without a good helping of eyes!', `VerifiedBuild` = 12340 WHERE `ID` = 1058;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'You seem a shady character. You have something for me to see?', `VerifiedBuild` = 12340 WHERE `ID` = 1060;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'The Greatwood Vale lies to the northwest, $N. Go. Strike fear into those who would pillage this land!', `VerifiedBuild` = 12340 WHERE `ID` = 1062;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you find the Syndicate Shadow Mages, and collect from them the blood?', `VerifiedBuild` = 12340 WHERE `ID` = 1066;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'You have returned, $N. Do you bring aid from Apothecary Lydon?', `VerifiedBuild` = 12340 WHERE `ID` = 1067;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'The tree spirits wail at the loss of their brethren, $N. You must destroy the shredders XT:4 and XT:9, or I fear Stonetalon will never be healed.', `VerifiedBuild` = 12340 WHERE `ID` = 1068;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Did you get the eggs, $N? I already made a shipping deal with Wharfmaster Dizzywig!', `VerifiedBuild` = 12340 WHERE `ID` = 1069;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'How goes the battle on your end, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 1071;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'I can\'t make any Nitromirglyceronium if I don\'t have the potions... they\'re vital to its creation.', `VerifiedBuild` = 12340 WHERE `ID` = 1073;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Ah, goodie goodie, you\'re back.', `VerifiedBuild` = 12340 WHERE `ID` = 1074;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Hello, $N. Have you found the component I need?', `VerifiedBuild` = 12340 WHERE `ID` = 1076;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 0, `CompletionText` = 'Haha! you\'re back! Do you have it? Do you have the spell?', `VerifiedBuild` = 12340 WHERE `ID` = 1077;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 2, `CompletionText` = 'Hello again, $N.$B$BHave you already returned from the Vale in Stonetalon with those scales?', `VerifiedBuild` = 12340 WHERE `ID` = 1078;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you get the plans, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 1079;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'How\'d it go, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 1080;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'The first time I saw the Charred Vale I almost wept, $N.', `VerifiedBuild` = 12340 WHERE `ID` = 1083;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I have a feeling Gaxim will find a use for the shrapnel regardless of how the Venture Co. has used it in the past.', `VerifiedBuild` = 12340 WHERE `ID` = 1084;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Here, channeling magic is like drawing water from a well with a bucket full of holes.', `VerifiedBuild` = 12340 WHERE `ID` = 1087;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'When my master bade me to the peak of Stonetalon, I expected that all I would need was to lay waste to the night elves that crawled the sacred ruins of our ancient temple of Azshara, their touch despoiling its sanctity... but Ordanus had slipped my grasp.', `VerifiedBuild` = 12340 WHERE `ID` = 1088;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Yes, $N? What can I do for you?', `VerifiedBuild` = 12340 WHERE `ID` = 1091;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Something I can help you with?', `VerifiedBuild` = 12340 WHERE `ID` = 1092;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Did you find those plans? I\'m eager to impress the new boss. Hopefully, once he\'s convinced of my loyalty--well, as much as he can be convinced... goblin\'s honor, you know?--he\'ll feel comfortable making use of my rather impressive genius.', `VerifiedBuild` = 12340 WHERE `ID` = 1093;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 3, `EmoteOnIncomplete` = 0, `CompletionText` = 'Hello there! How can I help you?', `VerifiedBuild` = 12340 WHERE `ID` = 1094;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Sputtervalve will want some sort of proof that Gerenzo\'s dead. I think his mechanical arm will probably do.', `VerifiedBuild` = 12340 WHERE `ID` = 1096;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'From your look of concern, I can tell that something is amiss....', `VerifiedBuild` = 12340 WHERE `ID` = 1100;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'So long as Charlga Razorflank is mustering a force in Razorfen Kraul, these lands are in great danger.', `VerifiedBuild` = 12340 WHERE `ID` = 1101;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Hi hi hi! Did you get that venom??', `VerifiedBuild` = 12340 WHERE `ID` = 1104;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'My brother is making progress with his new fuel design, and that has me worried. I need to start work on a tortoise shell fuel tank as soon as possible!', `VerifiedBuild` = 12340 WHERE `ID` = 1105;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 35, `EmoteOnIncomplete` = 0, `CompletionText` = 'Well, you found me. Good for you.$b$bAre you here about that axe I made for Gath\'Ilzogg? Or are you here to reclaim Duchess Pamay\'s honor?$b$bActually, I don\'t care which it is. If you\'re here to fight, then let\'s get it over with...', `VerifiedBuild` = 12340 WHERE `ID` = 1106;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the tail fins?  If I can\'t protect our car from its own speed, then it won\'t last long in these races.', `VerifiedBuild` = 12340 WHERE `ID` = 1107;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you find any indurium flakes, $N. I have my forge heated up and ready to test them.', `VerifiedBuild` = 12340 WHERE `ID` = 1108;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = '$N, have you been out into the Flats? Did you bring back that load of parts I wanted?', `VerifiedBuild` = 12340 WHERE `ID` = 1110;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Speak up! Tell me, are you dropping off or picking up?', `VerifiedBuild` = 12340 WHERE `ID` = 1111;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Did you make it to Ratchet and get those parts?', `VerifiedBuild` = 12340 WHERE `ID` = 1112;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'You have something for me? That\'s great! let\'s see it!', `VerifiedBuild` = 12340 WHERE `ID` = 1114;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Back so soon? Do you have my dream dust?', `VerifiedBuild` = 12340 WHERE `ID` = 1116;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Did you get anything on Nazz Steamboil? Anything he might want to keep a secret??', `VerifiedBuild` = 12340 WHERE `ID` = 1117;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 3, `EmoteOnIncomplete` = 0, `CompletionText` = 'Hello hello. And what brings a noble $R such as you down to Booty Bay?', `VerifiedBuild` = 12340 WHERE `ID` = 1118;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 3, `EmoteOnIncomplete` = 0, `CompletionText` = 'Hello, $N. Was Fizzlebub able to help us?', `VerifiedBuild` = 12340 WHERE `ID` = 1119;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Hi! You have something for me?', `VerifiedBuild` = 12340 WHERE `ID` = 1120;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'What are you looking at?', `VerifiedBuild` = 12340 WHERE `ID` = 1121;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Well, did it work? You\'re still in one piece, which is good news. Did you find anything?', `VerifiedBuild` = 12340 WHERE `ID` = 1126;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Have you defeated the foul Steelsnap, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 1131;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do you have the pridewing venom sacs, $N? We cannot allow the orcs to use the beasts\' poisons against us!', `VerifiedBuild` = 12340 WHERE `ID` = 1134;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Have you been to the Alterac Mountains, $N? Did you face the elusive Frostmaw?', `VerifiedBuild` = 12340 WHERE `ID` = 1136;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = '...lemon crab, whipper root crab, and Ironforge surprise crab.  That\'s about it.$B$BOh, hello there $N.  Do you have them fine crab chunks I was telling you about?', `VerifiedBuild` = 12340 WHERE `ID` = 1138;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Hammertoe\'s quest must be actualized, $N. I owe him that much.$B$BYour return to Uldaman is imperative not only to that goal, but also to the safety of all dwarven kind. With the tablet in the hands of the Dark Irons who knows how powerful their army of golems would become.', `VerifiedBuild` = 12340 WHERE `ID` = 1139;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'There\'s plenty of good dishes you use Darkshore groupers for.  They\'re good to eat, but I think it\'s more fun catching them.$B$BYou caught any Darkshore groupers yet?', `VerifiedBuild` = 12340 WHERE `ID` = 1141;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Athrikus Narassin is an ancient and powerful warlock. Perhaps we should wait for Delgren\'s assistance, but he obviously had much faith in you to send you alone.', `VerifiedBuild` = 12340 WHERE `ID` = 1143;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 25, `EmoteOnIncomplete` = 0, `CompletionText` = 'I envy you, $C. You have the look of someone who\'s been outside the walls of Orgrimmar for a while.$B$BI myself would travel in the name of the Warchief if Thrall didn\'t have need of my skills here in the city. But he leads us well, and I trust his judgement - I remain here for as long as he needs me.', `VerifiedBuild` = 12340 WHERE `ID` = 1145;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Ah, it been a long time since you\'ve come to see me, $N. What can I do for you today? You be looking like you\'ve seen the face of battle recently. Good... good for the Horde and good for you. The more battle you\'ve seen, the more helpful you\'ll be; stronger, too.', `VerifiedBuild` = 12340 WHERE `ID` = 1148;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'You must be prepared spiritually, physically and mentally for the challenges that lie ahead of you.$b$bToo often do we rush forward before we are ready. I consider it my duty to the youth, no matter which tribe they belong to, to prepare them for the dangers they may face after they leave the sanctity of their home.', `VerifiedBuild` = 12340 WHERE `ID` = 1150;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Rok\'Alim is also called the Pounder by the centaur tribes in Thousand Needles because of the thundering his fists make as he pummels the creatures brave, or stupid, enough to stand in his path.', `VerifiedBuild` = 12340 WHERE `ID` = 1151;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I saw the travelers again - the ones that would not sell me a sample of the ore. I spit at them for not helping the warchief.$B$BMay they die in battle like cowards and not like warriors as should be the right of all people who ally themselves with the Horde.', `VerifiedBuild` = 12340 WHERE `ID` = 1153;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Bring me the book after you\'ve studied it. I will not ask you your question until after you have given me the book.', `VerifiedBuild` = 12340 WHERE `ID` = 1154;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I hope you made the Scarlet Crusade suffer some before stealing the book from them.$b$bMy views of their kind are not unwarranted. The Crusade may have been followers of the Light at one time, but now, they seek to destroy any creatures that have not sided with their religion. They believe all undead, Forsaken or otherwise, must be cleansed, and those traveling in their lands must either be insane, or subject to the undead\'s powerful magics. Idiots. Idiots and fools; all of them.', `VerifiedBuild` = 12340 WHERE `ID` = 1160;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'Kill them all and bring me their heads!', `VerifiedBuild` = 12340 WHERE `ID` = 1164;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have those bones for me? I was just about to start working on lightening the steering rig, but I don\'t want to open her up without all the parts I need.', `VerifiedBuild` = 12340 WHERE `ID` = 1176;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 0, `CompletionText` = 'Watch where you\'re stepping!  Watch watch watch!!  This is delicate stuff you see here, and if we\'re to win then it must all work perfectly!', `VerifiedBuild` = 12340 WHERE `ID` = 1179;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Much as I hate to admit it, that gnome team they have out there is pretty good. Our boys need every edge they can get.', `VerifiedBuild` = 12340 WHERE `ID` = 1182;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'How\'m I supposed to show my face around the track without a little extra kick to get me going? It\'s a travesty, I tell you.', `VerifiedBuild` = 12340 WHERE `ID` = 1187;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'As I\'m sure you know, the Gizmorium can service all of your tinkering needs! How can I help you?', `VerifiedBuild` = 12340 WHERE `ID` = 1188;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I\'d like to integrate indurium into different parts of our racers, but I need large amounts of raw indurium to create these parts.$B$BYou can find indurium ore in the Uldaman excavation in the Badlands, across the sea in Khaz Modan.$B$BThe gnomes are getting their own supply of it, so it\'s important we get our own to keep pace with them.', `VerifiedBuild` = 12340 WHERE `ID` = 1192;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Once we have the filled phial, we can send it along to my associate, Rau, in the Thousand Needles. He was the one who requested the phial of water, so he\'ll better know how we can make use of it.', `VerifiedBuild` = 12340 WHERE `ID` = 1195;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'I don\'t suppose you\'ve been sent by Zangen, hm?', `VerifiedBuild` = 12340 WHERE `ID` = 1196;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'I am eager to put my hands upon the Cloven Hoof. Have you taken it yet?', `VerifiedBuild` = 12340 WHERE `ID` = 1197;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Blackfathom Deeps was once an ancient night elf temple. It once housed a most powerful moonwell. Who knows what evil brews there now at the hands of the Twilight\'s Hammer.$B$BHave you made any progress in ridding their presence?', `VerifiedBuild` = 12340 WHERE `ID` = 1199;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Time is a precious commodity, $C.$B$BMy role here in Darnassus is to ensure that the Argent Dawn thrives and that the evil forces encroaching upon Kalimdor are thwarted.$B$BState your business quickly or be on your way.', `VerifiedBuild` = 12340 WHERE `ID` = 1200;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You have my blade??', `VerifiedBuild` = 12340 WHERE `ID` = 1203;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you get the forked tongues?', `VerifiedBuild` = 12340 WHERE `ID` = 1204;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Where are those eyes?', `VerifiedBuild` = 12340 WHERE `ID` = 1206;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Spice.  We could all use some spice in our life.  You agree?', `VerifiedBuild` = 12340 WHERE `ID` = 1218;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do you have a report to make?', `VerifiedBuild` = 12340 WHERE `ID` = 1219;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'You have something for me?', `VerifiedBuild` = 12340 WHERE `ID` = 1220;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do you have the tubers, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 1221;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'You have something for me?', `VerifiedBuild` = 12340 WHERE `ID` = 1238;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'You have another matter to report, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 1239;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'There is an angry spirit about you, $gbrother:sister;. What brings you to Kin\'weelay?', `VerifiedBuild` = 12340 WHERE `ID` = 1240;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Hello, $N. Is there something I can do for you? Perhaps you\'d like to try some of our special Trias cheddar? Or a block of Darnassian bleu?', `VerifiedBuild` = 12340 WHERE `ID` = 1242;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Not too safe to be traveling about in the woods, $N. Be careful, and if you see anything suspicious or dangerous, contact the Watchers immediately. Don\'t try and take anything on yourself. We\'re not responsible for anything terrible that might happen to you.$B$BBut we both know you\'re gonna ignore me and fight whatever comes out of the darkness anyway, don\'t we? Haha, yeah, you adventurer types... all the same.', `VerifiedBuild` = 12340 WHERE `ID` = 1243;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Be careful out there, $N. I know Trias was the one to send you here, but that doesn\'t mean there isn\'t anything lurking out in the woods that couldn\'t cause you some trouble... especially with you investigating the Defias.', `VerifiedBuild` = 12340 WHERE `ID` = 1244;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'I see you\'re back, and in one piece. We both know you\'re not here for cheese, so let\'s cut out the pleasantries. Was Backus any help, or have you even left for Duskwood yet?', `VerifiedBuild` = 12340 WHERE `ID` = 1245;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you found anything of interest at the Shady Rest Inn?', `VerifiedBuild` = 12340 WHERE `ID` = 1252;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you found evidence from the site of the Shady Rest Inn?', `VerifiedBuild` = 12340 WHERE `ID` = 1253;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'My research with the Mudrock tongues is progressing nicely. I trust your crab hunt goes well?', `VerifiedBuild` = 12340 WHERE `ID` = 1258;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = '$N, did you discover Marg\'s fate?', `VerifiedBuild` = 12340 WHERE `ID` = 1261;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'You traveled from Brackenwall Village in Dustwallow? How fares Nazeer, and how fare his efforts in the marsh?', `VerifiedBuild` = 12340 WHERE `ID` = 1262;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Something for me to look at?', `VerifiedBuild` = 12340 WHERE `ID` = 1319;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'A letter from the dwarven lands? I wonder who would call from so far to the north...$B$BPlease, let me see the order.', `VerifiedBuild` = 12340 WHERE `ID` = 1338;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'You have a package for me?', `VerifiedBuild` = 12340 WHERE `ID` = 1358;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'You have something for me?', `VerifiedBuild` = 12340 WHERE `ID` = 1359;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Well now, we\'re you able to get slap around those troggs long enough to get into my chest and nab my treasure?', `VerifiedBuild` = 12340 WHERE `ID` = 1360;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'What brings you to Nethergarde Keep, $R?', `VerifiedBuild` = 12340 WHERE `ID` = 1364;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = '$N, have you defeated Khan Dez\'hepah?', `VerifiedBuild` = 12340 WHERE `ID` = 1365;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'How is your collection of ears, $N? Large?', `VerifiedBuild` = 12340 WHERE `ID` = 1366;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 11, `EmoteOnIncomplete` = 11, `CompletionText` = 'That Infiltrator in Stonard will surely.... open up... after he drinks my special serum. Haha!$b$bThe ingredients required are by no means easy to procure. Shadow Panthers are common in the Swamp but collecting enough hearts for our purpose can be daunting. And the Mire Lord can be such a fussy beast.$b$b', `VerifiedBuild` = 12340 WHERE `ID` = 1383;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do you have a report, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 1387;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'I hope you have proven yourself of use to our dear friend, Apothecary Faustin.', `VerifiedBuild` = 12340 WHERE `ID` = 1388;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the crystals?', `VerifiedBuild` = 12340 WHERE `ID` = 1389;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 20, `EmoteOnIncomplete` = 0, `CompletionText` = 'Please have mercy on me! I have information that goes beyond alliance boundaries. While I am no sympathizer of the Horde, there is political treachery going on that must be revealed!', `VerifiedBuild` = 12340 WHERE `ID` = 1391;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 3, `EmoteOnIncomplete` = 3, `CompletionText` = 'Hello! Don\'t mind all the commotion, it\'s just business as usual at Nethergarde Keep.$B$BYou have something for me?', `VerifiedBuild` = 12340 WHERE `ID` = 1395;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you find any driftwood, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 1398;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You returned. You have a report?', `VerifiedBuild` = 12340 WHERE `ID` = 1420;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do you have the wizard\'s reagents, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 1421;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'You have something for me?', `VerifiedBuild` = 12340 WHERE `ID` = 1423;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'No one knows what dark practices went on inside The Temple of Atal\'Hakkar. But we do know that great and powerful forces of magic were used.$b$bWe must learn as much as we can about such magic. Perhaps the spells of the Atal\'ai will prove of use to the Horde.$b$bOnce you have gathered enough Atal\'ai artifacts from around the Pool of Tears, I can begin to understand what the trolls were hoping to accomplish and what went so horribly wrong.', `VerifiedBuild` = 12340 WHERE `ID` = 1424;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'You have business with me?', `VerifiedBuild` = 12340 WHERE `ID` = 1425;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I have a cask of wine waiting for your success, $N. It\'s only right I taste the goods before I have it shipped back to my customers.', `VerifiedBuild` = 12340 WHERE `ID` = 1430;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'I have tried to make the magics as simple as possible. Drawing the spirit of your victim out of its injured form should be child\'s play. Do not rely on the gem\'s power to slay your foe completely. You must only activate the gem when they are close to death, or it will be useless.', `VerifiedBuild` = 12340 WHERE `ID` = 1435;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I fear Tyranis will attempt to learn the Burning Blade\'s secrets and count himself among their kind if they allow it - he has always adored the power magic brings to those who are seduced by it.$B$BI\'m not sure I could endure returning home to my family with news of Tyranis\' spirit flirting with such dangers. It\'s a terrible enough crime among my kind to pursue such things, but to become that which we attempt to protect ourselves from, well, that\'s apprehensible.', `VerifiedBuild` = 12340 WHERE `ID` = 1439;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Once Jammal\'an has been removed, I stand a chance of returning to my people.$b$bWith Jammal\'an as their spiritual leader, the Atal\'ai face certain destruction.', `VerifiedBuild` = 12340 WHERE `ID` = 1446;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Ya ever had a Rhapsody Malt? One of my finest brews, if I do say so myself. Hiccup!$B$BBut if I\'m gonna relive the horrors of that fateful flight over... hiccup... the swamp, well I\'m gonna need me something a wee bit stronger. Hiccup!$B$BDon\'t suppose you found me those gizzards and livers I need to add that extra kick to my Kalimdor Kocktail?$B$BHiccup!', `VerifiedBuild` = 12340 WHERE `ID` = 1452;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'No offense to whoever Nijel is, but this camp ain\'t the most comfortable place I\'ve spent a night, if you know what I mean, $N.', `VerifiedBuild` = 12340 WHERE `ID` = 1456;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Despicable creatures, the satyr. Story says they\'re somehow tied to the night elves, but I\'m not so sure I believe it.$B$BI think they get that on account of that one elf that brought them into the war few years back. World\'s never been the same since. Lot more dangerous, and a lot scarier.', `VerifiedBuild` = 12340 WHERE `ID` = 1458;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Sorry I couldn\'t tell you where to find the kodo or the scorpashi. I\'m not terribly familiar with the area, and I haven\'t had time to explore.', `VerifiedBuild` = 12340 WHERE `ID` = 1459;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = 'I give you one in good faith. You already proved yourself once, but me tinkin\' you should be more careful in the future.', `VerifiedBuild` = 12340 WHERE `ID` = 1463;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 1465;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I didn\'t even realize these demon things were in Desolace. Last I read, centaur pretty much owned the land after the night elves picked up and left years ago.$B$BI wonder why they took up here, and how.', `VerifiedBuild` = 12340 WHERE `ID` = 1466;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'At long last you have returned, $N. It has been quite some time since we last spoke. I thought perhaps you had forgotten about my quest.$B$BDid you locate that wily gryphon rider? Did he have anything to report?', `VerifiedBuild` = 12340 WHERE `ID` = 1469;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'As dusk slowly descends upon my career I turn to you, $N, to help me in my final quest for the Explorers\' League. If my old bones could muster the strength to brave the Swamp of Sorrows and the sunken temple I would be fighting right alongside you.$B$BPride makes it hard for me to ask for your help in collecting the Atal\'ai Tablets. But old age forces the necessity.$B$BPlease help me, $N. I want to retire from the Explorers\' League having completed their final bidding.', `VerifiedBuild` = 12340 WHERE `ID` = 1475;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'The Burning Blade begin to realize how weak they truly are. Their magics are pathetic, their strength feeble.$B$BTheir only power comes from those they serve, and not from any understanding of true power and knowledge.', `VerifiedBuild` = 12340 WHERE `ID` = 1480;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do not bring me an incorrect scalp, $c. Using the incorrect reagents could cause our deaths. The demon lord may have contingency spells on his person to slay those who would scry upon him.$B$BFate has already dealt me enough pain.', `VerifiedBuild` = 12340 WHERE `ID` = 1481;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'I am ready for the oracle crystal, $c. Finding and destroying this Lord Azrethoc would garner a great deal of favor with the Warchief for both of us. We would do well to work together and to do so swiftly so we may further our own ends and curry favor with the Warchief. ', `VerifiedBuild` = 12340 WHERE `ID` = 1482;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'I am very interested in examining the hides from the deviate creatures who have infested these caves. Have you had any luck in collecting some, $C?', `VerifiedBuild` = 12340 WHERE `ID` = 1486;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 15, `CompletionText` = 'Glory to the Horde, and death to our enemies, $N!$B$BThe demons in Desolace pose a greater threat than ever before. My hope of returning to the Warchief dwindles as more and more of the foul creatures seem to appear.$B$BI sometimes wish it was only the centaur we had to deal with.', `VerifiedBuild` = 12340 WHERE `ID` = 1488;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Where is my wailing essence?', `VerifiedBuild` = 12340 WHERE `ID` = 1491;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'You seek passage on the next ship, or have some item you wish to send aboard it?', `VerifiedBuild` = 12340 WHERE `ID` = 1492;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = 'Are we there yet?', `VerifiedBuild` = 12340 WHERE `ID` = 1558;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'I have no time to chat. Do you have business with me?', `VerifiedBuild` = 12340 WHERE `ID` = 1578;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you find my gaffer jacks, $N? Without my gaffer jacks I can\'t tune my stintle pegs!', `VerifiedBuild` = 12340 WHERE `ID` = 1579;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you find any electropellers? I\'ll need them if I\'m to continue my research on duck decoys...', `VerifiedBuild` = 12340 WHERE `ID` = 1580;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Greetings, $N.', `VerifiedBuild` = 12340 WHERE `ID` = 1582;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I hope you\'re here with good news from Ironforge. Because I\'m at my wit\'s end!', `VerifiedBuild` = 12340 WHERE `ID` = 1618;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I hope my John is having better luck in Ironforge. He so dislikes his trips there because it leaves the kids and me alone, but he knows it must be done. He\'s so kind-hearted.$B$BSome years have been easier than others, but this one\'s been rougher by far. It\'s almost as though something in the air is signaling a huge change. Who knows though?', `VerifiedBuild` = 12340 WHERE `ID` = 1644;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'What with the influx of tradesmen here and throughout Azeroth, there\'s a smaller supply of items we use to make clothes for the children of our orphanage. Helping me collect linen so my wife can make new clothes for them is very noble of you, $N. Thank you.$B$BHopefully, I\'ll be able to return home to my wife soon.', `VerifiedBuild` = 12340 WHERE `ID` = 1648;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'The items you\'re seeking will be difficult to acquire, but I can assure you, the weapon I will craft for you will be worth the effort.$B$BIt will be my finest work to date, and only a small payment for the service you\'ve done me.', `VerifiedBuild` = 12340 WHERE `ID` = 1654;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 11, `EmoteOnIncomplete` = 11, `CompletionText` = 'So, any luck yet? Haha, those ogres didn\'t get the best of ya yet, did they?', `VerifiedBuild` = 12340 WHERE `ID` = 1655;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 11, `CompletionText` = 'Have you delivered our \"gift\" to the people of Southshore?$B$B<Darkcaller Yanka laughs wickedly.>', `VerifiedBuild` = 12340 WHERE `ID` = 1657;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'I saw your fight with Bartleby. Nicely done! Did you get his mug?', `VerifiedBuild` = 12340 WHERE `ID` = 1665;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have my badge? I don\'t want to think of the mischief Dead-tooth Jack could cause with it.', `VerifiedBuild` = 12340 WHERE `ID` = 1667;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = 'Are we there yet?', `VerifiedBuild` = 12340 WHERE `ID` = 1687;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Even the older and wiser can be unmanned by the wiles of youth and beauty, $N. A piece of advice you would do well to remember throughout your life.', `VerifiedBuild` = 12340 WHERE `ID` = 1688;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I cannot show you how to control a voidwalker until you have overtaken one.', `VerifiedBuild` = 12340 WHERE `ID` = 1689;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'Well, were you able to take out those nomads like I asked? The Gadgetzan Water Company is developing plans based on your success here! Don\'t let us down, now...', `VerifiedBuild` = 12340 WHERE `ID` = 1691;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 0, `CompletionText` = 'Hello, and well met. How might I be of service to you?', `VerifiedBuild` = 12340 WHERE `ID` = 1700;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'How goes the scavenger hunt, $N? Do you have the materials?', `VerifiedBuild` = 12340 WHERE `ID` = 1701;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 3, `EmoteOnIncomplete` = 0, `CompletionText` = 'Hello! Dry times, don\'t you think?', `VerifiedBuild` = 12340 WHERE `ID` = 1702;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 0, `CompletionText` = 'I bid you greetings, $C.', `VerifiedBuild` = 12340 WHERE `ID` = 1703;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 0, `CompletionText` = 'Good day, or morning or evening. I can\'t tell from way down here. So do you have business for me?', `VerifiedBuild` = 12340 WHERE `ID` = 1704;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = '$N, do you have the burning blood and rock? I\'ll need them to complete the armor.', `VerifiedBuild` = 12340 WHERE `ID` = 1705;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Got the five Wastewander water pouches we need?  If you do, then the Gadgetzan Water Company Care Package, Model 103-XB, will be yours!', `VerifiedBuild` = 12340 WHERE `ID` = 1707;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 3, `EmoteOnIncomplete` = 3, `CompletionText` = 'Hello hello, $N! Do you have the searing coral? I can\'t wait to get to work!', `VerifiedBuild` = 12340 WHERE `ID` = 1708;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the shells, $N? They are quite strong, and can be rendered into a lacquer I will use to coat the links of my new mail armor.', `VerifiedBuild` = 12340 WHERE `ID` = 1710;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the items, $N? Gathering them is the proof I need that you have the strength to face Cyclonian.', `VerifiedBuild` = 12340 WHERE `ID` = 1712;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = '$N, I must have the whirlwind heart!', `VerifiedBuild` = 12340 WHERE `ID` = 1713;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Was your search a success, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 1738;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 11, `EmoteOnIncomplete` = 11, `CompletionText` = 'Sometimes I wonder if Surena was not a succubus in disguise, sent to warp and twist my mind... Ha! I give her too much credit, I think.', `VerifiedBuild` = 12340 WHERE `ID` = 1739;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Yer back! I\'m glad to see it, $N. My wounds are healed and I\'m about ready to return to Helm\'s Bed lake as soon as I c\'n convince me wife that I\'ll be fine.', `VerifiedBuild` = 12340 WHERE `ID` = 1784;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Is Henze safe, $N? Were you successful?$B$BBetween your skill with a weapon, and the power of the Light, I\'d imagine Heroes\' Vigil is safe from any Defias threat, but that\'s for the King and his advisors to say.', `VerifiedBuild` = 12340 WHERE `ID` = 1787;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'How goes your search for the robes, $N? Have you created them yourself? Such personal touches I find make the imbuing of magic that much sweeter. It gives you a greater sense of accomplishment. But I understand if you choose the quicker path and have it made for you - there\'s something to be said for such... ambition.', `VerifiedBuild` = 12340 WHERE `ID` = 1796;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'And obviously not being a mage, I wonder if I can trust you at all. I can smell the power of the arcane on you, but you seem to have eluded the stank of corruption that comes so willingly with your kind.$B$BYes, a $C... a $C has come to ask for my help.$B$BWell, what is it I can do for you, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 1799;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the sample, $N? The flow of magic in Stormwind and Elwynn has been altered, and I must know if it is seeping into the water.', `VerifiedBuild` = 12340 WHERE `ID` = 1861;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'Back again, $n?  If you have five more Wastewander water pouches, then I have a care package with your name on it!', `VerifiedBuild` = 12340 WHERE `ID` = 1878;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you find the gizmonitor? I must have it before its energy supply runs out!', `VerifiedBuild` = 12340 WHERE `ID` = 1880;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Yeah, what do you need?', `VerifiedBuild` = 12340 WHERE `ID` = 1918;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you captured the creatures, $n?  They must be studied in order to determine the reason behind their arrival.', `VerifiedBuild` = 12340 WHERE `ID` = 1920;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 3, `EmoteOnIncomplete` = 3, `CompletionText` = 'Hello, $N.  Jennea told me you would come.  Do you have something for me?', `VerifiedBuild` = 12340 WHERE `ID` = 1921;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the book, $N? Its secrets are not meant for the untrained, and plumbing its depths can lead to doom and ruin.', `VerifiedBuild` = 12340 WHERE `ID` = 1938;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Ah, yes. The mages of the Wizard\'s Sanctum said you\'d speak with me. Do you have the required silk?', `VerifiedBuild` = 12340 WHERE `ID` = 1940;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 3, `EmoteOnIncomplete` = 3, `CompletionText` = 'Hello, $N. Do you have the items I require?', `VerifiedBuild` = 12340 WHERE `ID` = 1948;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'What are you waiting for? I need my magic phrase!', `VerifiedBuild` = 12340 WHERE `ID` = 1950;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 2, `CompletionText` = 'Greetings, $N.  Did you find the book, Rituals of Power?', `VerifiedBuild` = 12340 WHERE `ID` = 1951;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have an infernal orb, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 1954;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'You\'ll have to kill that demon to remove its taint from the orb, $N.', `VerifiedBuild` = 12340 WHERE `ID` = 1955;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you been to Uldaman, $N?  Did you defeat the obsidian sentinel?', `VerifiedBuild` = 12340 WHERE `ID` = 1956;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'You have not killed the required amount of mana surges, $N.', `VerifiedBuild` = 12340 WHERE `ID` = 1957;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = '$N! Where are my things?!', `VerifiedBuild` = 12340 WHERE `ID` = 2038;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you found the Gnoam Sprecklesprocket, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 2040;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Have ye found me broke down key, landlubber?', `VerifiedBuild` = 12340 WHERE `ID` = 2098;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you brought me the sick animal, $N?$B$BShould you fail to spring the trap, do not fret - Tharnariun\'s Hope is eternal. If you require another trap, abandon your task and report back to me.', `VerifiedBuild` = 12340 WHERE `ID` = 2118;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 3, `EmoteOnIncomplete` = 0, `CompletionText` = 'Hi there! Come in, take a seat by the fire and warm yourself with a flagon of ale.', `VerifiedBuild` = 12340 WHERE `ID` = 2160;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'The pot is empty and I\'m hungry! What\'s taking you so long?', `VerifiedBuild` = 12340 WHERE `ID` = 2178;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You\'ve got the wrong gnome, pal! I was never there! You can\'t prove anything!$B$BWait a second... who are you? What the... where did you find this necklace at?', `VerifiedBuild` = 12340 WHERE `ID` = 2198;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Have you got the five silver bars I asked for?  I will share my sad tale of woe with you concerning the necklace you now possess... but only after I get those bars!  Please, help a gnome out, won\'t ya?', `VerifiedBuild` = 12340 WHERE `ID` = 2199;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Talvash\'s image comes into focus from the waters of the scrying bowl.$b$b\"Wow, you\'re still alive! Did you manage to find the gems? Are you truly the savior of my reputation I have hoped for? Please tell me you didn\'t waste a charge on the phial just to chat; those things are NOT cheap, and I\'m already in dire financial strai', `VerifiedBuild` = 12340 WHERE `ID` = 2201;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you obtained the magenta fungus caps I need for my alchemical work? No caps - no reward!', `VerifiedBuild` = 12340 WHERE `ID` = 2202;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you used the vessels to get me the scorched guardian dragon blood I need?  Yes, I know it is a dangerous task... but the recipe for my restorative brew awaits your success.  Risk and reward, my friend... risk and reward...', `VerifiedBuild` = 12340 WHERE `ID` = 2203;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You didn\'t even stop to tidy yourself up after leaving Uldaman, did you.  You just came straight here, lingering dungeon odors be damned.  Well, let\'s hope this visit is merely an odiferous one, and not a useless one to boot.$B$BDo you have the power source for the necklace?', `VerifiedBuild` = 12340 WHERE `ID` = 2204;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Can I help you, $C?', `VerifiedBuild` = 12340 WHERE `ID` = 2205;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 25, `EmoteOnIncomplete` = 25, `CompletionText` = 'Your mortality wanes with every moment you waste loitering in the barracks, $C.', `VerifiedBuild` = 12340 WHERE `ID` = 2206;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Did ye enjoy the stench of leper gnome? I only ask because ye got a crazy smile on yer face.$B$BWhat news do ye bring from Onin?', `VerifiedBuild` = 12340 WHERE `ID` = 2239;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you gotten the things I need yet? You won\'t get paid unless you bring me those reagents.', `VerifiedBuild` = 12340 WHERE `ID` = 2258;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Yes, may I help you with something?  I assure you I am a very busy right now.  If it is grave importance to the Explorers\' League, however, then I am all ears!', `VerifiedBuild` = 12340 WHERE `ID` = 2279;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did I forget to mention the orcs?$B$BI hear they have been nosing around up by the mill.', `VerifiedBuild` = 12340 WHERE `ID` = 2282;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Well, do you have the necklace?  You won\'t see a copper from us if you don\'t have that necklace!', `VerifiedBuild` = 12340 WHERE `ID` = 2283;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'You\'ve got another trip into the depths of Uldaman in store for yourself if you don\'t have the gems and a power source capable of channeling magical power back into the necklace.$B$BYou\'ll be getting the gems back to deliver to the goons in Orgrimmar; I will be keeping the power source, since it will be the thing that will make the necklace work in the first place...', `VerifiedBuild` = 12340 WHERE `ID` = 2339;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the demon prince\'s horns?', `VerifiedBuild` = 12340 WHERE `ID` = 2358;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Any news from Agent Kearnen?', `VerifiedBuild` = 12340 WHERE `ID` = 2359;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do you have the power stones, $N?  I have a robotic rodent that needs a power supply...', `VerifiedBuild` = 12340 WHERE `ID` = 2418;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Please move swiftly. I can only hope that my emerald dreamcatcher has been unharmed by the furbolg.$b$bHave you recovered it yet, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 2438;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Welcome to the Vault of Ironforge, $N.  What may I do for you today?', `VerifiedBuild` = 12340 WHERE `ID` = 2439;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Ferocitas and the Gnarlpine Mystics must return what is mine. Please retrieve the emerald so that I may repair my emerald dreamcatcher.', `VerifiedBuild` = 12340 WHERE `ID` = 2459;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you located Oakenscowl yet, $R?', `VerifiedBuild` = 12340 WHERE `ID` = 2499;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you gotten the things I need yet?  You won\'t get paid unless you bring me those reagents.', `VerifiedBuild` = 12340 WHERE `ID` = 2500;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you used the vessels to get me the scorched guardian dragon blood I need?  Yes, I know it is a dangerous task... but the recipe for my restorative brew awaits your success.  Risk and reward, my friend... risk and reward...', `VerifiedBuild` = 12340 WHERE `ID` = 2501;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 18, `EmoteOnIncomplete` = 18, `CompletionText` = 'I regret the task that I have asked you to carry out; but Lady Sathrah is beyond hope.$B$BIt is our hope to offer the sacrifice of the spinnerets to Elune. With this sacrifice, Elune will bless Sathrah so that she might be reborn, and at peace.', `VerifiedBuild` = 12340 WHERE `ID` = 2518;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = 'I have dedicated my life to the search of flawless draenethyst spheres. A lifetime, $r!', `VerifiedBuild` = 12340 WHERE `ID` = 2521;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'If I can examine the charm, I may be able to figure out how to break the enchantment. Have you found one?', `VerifiedBuild` = 12340 WHERE `ID` = 2541;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = '$N, be wary when approaching my physical form; the enchantment it is under is quite powerful.', `VerifiedBuild` = 12340 WHERE `ID` = 2561;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You smell foul, $N. Have you been traipsing in sulfur fields? And where are my components?!', `VerifiedBuild` = 12340 WHERE `ID` = 2581;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the beast organs?', `VerifiedBuild` = 12340 WHERE `ID` = 2582;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'Where are the organs, $N!?', `VerifiedBuild` = 12340 WHERE `ID` = 2583;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'Where are the organs, $N!?', `VerifiedBuild` = 12340 WHERE `ID` = 2584;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'Where are the organs, $N!?', `VerifiedBuild` = 12340 WHERE `ID` = 2585;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'Where are the organs, $N!?', `VerifiedBuild` = 12340 WHERE `ID` = 2586;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you returned with the requested organs?', `VerifiedBuild` = 12340 WHERE `ID` = 2601;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you returned with the requested organs?', `VerifiedBuild` = 12340 WHERE `ID` = 2602;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'Do not waste my time, $N. We have nothing to discuss, unless you have recovered the items I have requested.', `VerifiedBuild` = 12340 WHERE `ID` = 2603;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'Do not waste my time, $N. We have nothing to discuss, unless you have recovered the items I have requested.', `VerifiedBuild` = 12340 WHERE `ID` = 2604;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Please, tell me you found the dew collectors?', `VerifiedBuild` = 12340 WHERE `ID` = 2605;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'So old Marin\'s up to it again, eh? What\'s this concoction made from?', `VerifiedBuild` = 12340 WHERE `ID` = 2606;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'If you want the \'itis\' cured, you\'re going to have to try harder than that, $n. Where are the reagents for the cure?', `VerifiedBuild` = 12340 WHERE `ID` = 2609;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Awaiting orders.', `VerifiedBuild` = 12340 WHERE `ID` = 2623;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Under the waters of that lake -- it\'s the only place where the Violet Tragan can be found.  Hope you\'re good at holding your breath!', `VerifiedBuild` = 12340 WHERE `ID` = 2641;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Oh, $N, you\'re finally back.  What have you brought?', `VerifiedBuild` = 12340 WHERE `ID` = 2661;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'I\'ve been watching Lescovar for a couple weeks now. Trias has never trusted him, but we didn\'t suspect he was involved in anything to do with the Defias Brotherhood. We were following leads that tied him to the Twilight\'s Hammer. Either way, he\'s become more dangerous than this city can deal with, and that\'s where we come in.$b$bGet me those items and we can put my plan into effect.', `VerifiedBuild` = 12340 WHERE `ID` = 2746;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I have seen very few eggs retrieved from Feralas in extraordinary condition. These are eggs of the rarest sort...', `VerifiedBuild` = 12340 WHERE `ID` = 2747;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'A fine egg is one that will, in ideal conditions, hatch free of the evil effects of the Gordunni ogres\' incantations.', `VerifiedBuild` = 12340 WHERE `ID` = 2748;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Ordinary hippogryph eggs hatch about half the time. We do our best to nurture them and with a little luck, they will hatch.', `VerifiedBuild` = 12340 WHERE `ID` = 2749;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'These are the eggs that cannot be saved -- they will never hatch.', `VerifiedBuild` = 12340 WHERE `ID` = 2750;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'Aturk, like time, waits for no one! Hurry up fool!', `VerifiedBuild` = 12340 WHERE `ID` = 2756;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 25, `EmoteOnIncomplete` = 0, `CompletionText` = 'A rare breed your kind be, matey. Let me see that insignia.', `VerifiedBuild` = 12340 WHERE `ID` = 2757;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Could you be the next Galvan protege?', `VerifiedBuild` = 12340 WHERE `ID` = 2758;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 25, `EmoteOnIncomplete` = 0, `CompletionText` = 'A rare breed your kind be, matey. Let me see that insignia.', `VerifiedBuild` = 12340 WHERE `ID` = 2759;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 2, `CompletionText` = 'Hail! Come closer; show Galvan what you have.', `VerifiedBuild` = 12340 WHERE `ID` = 2760;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'After such mining, your muscles bulge and your body aches!', `VerifiedBuild` = 12340 WHERE `ID` = 2761;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'After such mining, your muscles bulge and your body aches!', `VerifiedBuild` = 12340 WHERE `ID` = 2762;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'After such mining, your muscles bulge and your body aches!', `VerifiedBuild` = 12340 WHERE `ID` = 2763;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you find Sergeant Bly?  Did you get my divino-matic rod?', `VerifiedBuild` = 12340 WHERE `ID` = 2768;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the scale?  I can\'t wait to try different ways to harness its energy!', `VerifiedBuild` = 12340 WHERE `ID` = 2770;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Yes $c, I am an official of the Gadgetzan Water Company.  What can I assist you with?', `VerifiedBuild` = 12340 WHERE `ID` = 2781;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Well, now, what is this?', `VerifiedBuild` = 12340 WHERE `ID` = 2782;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'A stack of ten thick yeti hides will net you a choice of one of my crafted items.  Because I care about quality, I am able to ensure you\'ll get a good item!$B$BIf you can\'t seem to find yetis, I know where some might be.  Try looking just inland of the Forgotten Coast, around Feral Scar Vale.', `VerifiedBuild` = 12340 WHERE `ID` = 2821;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Were you able to get a stack of ten thick yeti hides? My leather goods are second to none, and I\'ll share a sampling with you should you have the hides.$b$bIf you can\'t seem to find yetis, I know where some might be. Try looking west of here, just inland of the Forgotten Coast around the Feral Scar Vale.', `VerifiedBuild` = 12340 WHERE `ID` = 2822;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the tiara, $N?  Has Velratha learned the price of crossing me?', `VerifiedBuild` = 12340 WHERE `ID` = 2846;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Like I said, you\'ll be working for me while you learn about Wild Leather armor. Because wildvines are both potent and chaotic, it yields a random but strong benefit to the already strong armor you will be making. This knowledge, however, was not easy for me to come by.$B$BThe initial cost to begin this process is ten pieces of thick leather.$B$BOnce that is done, we\'ll get to the work you need to do in order to obtain the patterns.', `VerifiedBuild` = 12340 WHERE `ID` = 2847;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the six thick armor kits and the wildvine I require?$B$BDon\'t think of making armor kits as monotonous work; the steady fashioning method you develop as you ply your trade on these kits helps develop your skills for the intricate work needed to make Wild Leather armor.$B$BSee - there\'s a real reason behind what you\'re making for me...', `VerifiedBuild` = 12340 WHERE `ID` = 2848;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the two Turtle Scale breastplates and gloves I ordered? Also, don\'t forget the wildvine!$B$BEven with the earliest patterns, we learn that the fundamentals of shape translate well into more difficult garments. Though different items, the shape of the Turtle Scale breastplates prepares you for the detailing needed to make a Wild Leather vest.$B$BAnd the gloves... well, they\'re just for my own benefit. Remember, you\'re working for me!', `VerifiedBuild` = 12340 WHERE `ID` = 2849;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I need those tunics and headbands made, and I also need that piece of wildvine before I will share with you the knowledge of Wild Leather helmets.$B$BHead gear is highly coveted amongst adventurers, whether it be a disarmingly simple headband or a full-covering helmet. The fundamentals of creating valued head gear remain constant, no matter what the cosmetic appearance of the gear is.', `VerifiedBuild` = 12340 WHERE `ID` = 2850;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'The order on the pants, boots, and wildvines needs to be filled before you get the pattern, $N. Are you finished?$B$BFrom the earliest pair of boots we learn how to make, we start to understand that a quality boot needs to ride a razor\'s edge between comfort and function. With both, we are able to create items that allow the wearer to ignore fatigue that would cripple those wearing lower quality goods.', `VerifiedBuild` = 12340 WHERE `ID` = 2851;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the Turtle Scale bracers and helms ready? Don\'t forget the two wildvines I need!$B$BBy now, you\'re starting to realize the potential power that lies in Wild Leather armor. An armor that has no boundaries in application is nearly invaluable to a leatherworker. The limits are only in the quantities of resources to make the items - not the quality of the finished products!', `VerifiedBuild` = 12340 WHERE `ID` = 2852;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 2, `CompletionText` = 'Greetings, $R... from your countenance I can tell you are a leatherworker as am I. Have you come to draw from my skills, or perhaps you have other business with me?', `VerifiedBuild` = 12340 WHERE `ID` = 2853;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'We drive them back, and yet they still attack! Someone or something must be driving them into a frenzy... oh, you have returned, eh $N? Do you have the manes I require for the bounty to be met?', `VerifiedBuild` = 12340 WHERE `ID` = 2862;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do you have the shells?  My cousin in Booty Bay is waiting for a load of them, and he\'s getting impatient!', `VerifiedBuild` = 12340 WHERE `ID` = 2865;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = '$N, if you\'re here to verify the task given to you, then excellent - it is ten Hatecrest scales I seek.  If you are here for chit-chat, then I am currently unavailable for such trivialities.$B$BKnow this - we night elves are not warmongers.  Our race is dedicated to the preservation of peace and harmony.  This does not mean, however, that we will not proactively protect our own interests.  This is my duty to General Feathermoon, and to the stronghold.', `VerifiedBuild` = 12340 WHERE `ID` = 2869;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Bringing down Lord Shalzaru would certainly set their plans back weeks, if not months.  On top of that, the relic he uncovered is of definite interest to us.$B$BHave you performed the mission given to you, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 2870;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 0, `CompletionText` = 'Yes, may I assist you?$B$BHold on, you\'re the $C that has been helping General Feathermoon and Latro out with the naga threat, yes?  I\'m Vestia, Latro\'s - erm, rather, Latronicus\' wife.  It is a pleasure to meet you!$B$BI\'m sorry, you\'re here on business, of course.  Do you have something for me - from him, perchance?', `VerifiedBuild` = 12340 WHERE `ID` = 2871;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you find my shipment of rum, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 2873;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Did Stoley cough up my booze?', `VerifiedBuild` = 12340 WHERE `ID` = 2874;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'You look a little dazed.  Have you been reading our legal documents?', `VerifiedBuild` = 12340 WHERE `ID` = 2875;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'You look out of breath.  You have something to tell me?', `VerifiedBuild` = 12340 WHERE `ID` = 2876;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'I want five of those tribal necklaces the trolls carry on them.  If you need it spelled out further, then killing one of them stands you a good chance of getting one!$B$BProve your worth to the Wildhammers!', `VerifiedBuild` = 12340 WHERE `ID` = 2880;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Welcome back $N - were you able to find some tangible evidence as to the plans of the gnolls?', `VerifiedBuild` = 12340 WHERE `ID` = 2903;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you find Techbot?  Did you retrieve its memory core??', `VerifiedBuild` = 12340 WHERE `ID` = 2922;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the essential artificials?', `VerifiedBuild` = 12340 WHERE `ID` = 2924;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'Can\'t you see we\'re trying to cure an entire species of gnomes here??! We need more of the green glow!', `VerifiedBuild` = 12340 WHERE `ID` = 2926;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'If this were a race, you would have lost by now.', `VerifiedBuild` = 12340 WHERE `ID` = 2928;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the prismatic punch card??', `VerifiedBuild` = 12340 WHERE `ID` = 2930;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Hello, gentle $C. The day has been long and not a single experiment successful...I hope you bring good news to me.', `VerifiedBuild` = 12340 WHERE `ID` = 2933;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you get the venom?', `VerifiedBuild` = 12340 WHERE `ID` = 2937;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Word was sent of your coming, $N. You have a parcel for me?', `VerifiedBuild` = 12340 WHERE `ID` = 2938;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'A letter -- for me?', `VerifiedBuild` = 12340 WHERE `ID` = 2941;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I am glad you have returned, $N. I am eager to hear of your findings.', `VerifiedBuild` = 12340 WHERE `ID` = 2942;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Hello, $N. Have you been to Darnassus?', `VerifiedBuild` = 12340 WHERE `ID` = 2943;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'So, you have finally returned, $N. And you\'ve brought the contraption that Curgle built for me -- perfect.', `VerifiedBuild` = 12340 WHERE `ID` = 2944;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Hrm, you\'re not glowing. That\'s a good sign.', `VerifiedBuild` = 12340 WHERE `ID` = 2962;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Kindal needs time to prepare, but our kills already number in the dozens. The Grimtotem clan is more than aware of our presence in the area, and they seek us out like vipers.$B$BThey\'ll do everything in their power to take our heads from our bodies. You should be alert... they\'ll be coming for you too now that you\'ve interfered.', `VerifiedBuild` = 12340 WHERE `ID` = 2970;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'The sprite darters can be dangerous critters when provoked. Be careful when dealing with them, $C. And be even more careful of any night elves in the area. The pestering fools tend to hold up in the forests also.$b$bWhen you\'ve gotten enough of the wings, let me know, I\'ll be sure to reward you well!', `VerifiedBuild` = 12340 WHERE `ID` = 2973;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Take my words seriously, $C, the Grimtotem clan is evil. If you\'ve found their whereabouts, then it\'s up to you to return and strike the first blow against their clan... before they can come into our own lands and raze our own villages, or pilfer our lands.', `VerifiedBuild` = 12340 WHERE `ID` = 2974;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Welcome back $N.  Were you able to use the discs to your advantage, or did it end up being a wild goose chase?', `VerifiedBuild` = 12340 WHERE `ID` = 2977;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'What is this?', `VerifiedBuild` = 12340 WHERE `ID` = 2978;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'We must discover more about why the Gordunni are here, $N.', `VerifiedBuild` = 12340 WHERE `ID` = 2979;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Be watchful around the Gordunni, $N. Their magic seems to wreak havoc on the very land they stand on.', `VerifiedBuild` = 12340 WHERE `ID` = 2982;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'Get on up there and start digging!$b$bI\'ve got places to go and people to see -- time is money!', `VerifiedBuild` = 12340 WHERE `ID` = 2987;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = '$N, you come bearing a gift?', `VerifiedBuild` = 12340 WHERE `ID` = 2990;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have Nekrum\'s Medallion, $N?  There are powers hidden within it that I am eager to discover.', `VerifiedBuild` = 12340 WHERE `ID` = 2991;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'What have you brought me, $R?', `VerifiedBuild` = 12340 WHERE `ID` = 3002;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Another shipment from Curgle, I assume?', `VerifiedBuild` = 12340 WHERE `ID` = 3022;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Did you bring me the temper, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 3042;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'The hate that Edana spreads across the land must be stopped.', `VerifiedBuild` = 12340 WHERE `ID` = 3062;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = 'Welcome to Camp Narache, $n. I hear good things about you. Your bloodline is strong, and many of the elders consider you skilled already. But that we will test.$b$bThe plains of Mulgore will be your home for sometime--you should do your best to learn it very well. One day you will travel to unfamilar lands to master greater skills. You must be ready.', `VerifiedBuild` = 12340 WHERE `ID` = 3092;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 0, `CompletionText` = 'I bid you welcome, $gbrother:sister;. I knew you would come. It was only a matter of time.$b$bWhat I said interested you, didn\'t it? I hit a chord... something inside you knew what I claimed was truth. Good.$b$bKnow this though: I am no traitor to Sylvanas. If anything, she would appreciate my claims considering it was her own beliefs that has put the Forsaken in the position it is now.', `VerifiedBuild` = 12340 WHERE `ID` = 3099;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 0, `CompletionText` = 'You made it. I\'m so glad.$b$bMuch has happened over the last few years, $N: the creation of Teldrassil, the corruption of many of the forest creatures here and abroad, discovery of lands we thought lost to us like Feralas... so much, in so little time. But those are just some of the reasons we are here, the most important being to protect our kind from further evil.', `VerifiedBuild` = 12340 WHERE `ID` = 3116;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 0, `CompletionText` = 'You\'ve arrived, and none too soon, $N. Welcome to Shadowglen.$B$BI trust my sigil found you in good spirits and health?$B$BAs I said previously, I am here to train you as a $C; to tame beasts to aid you in battle; to use a bow with unerring accuracy; to respect the lands which we call home and also the lands beyond.', `VerifiedBuild` = 12340 WHERE `ID` = 3117;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 0, `CompletionText` = 'It pleases me to see you\'ve arrived so quickly, $N. Welcome.$b$bAs you\'ve probably heard, all of Teldrassil is stirring with the comings and goings of travelers. Even members of the Alliance have even been allowed access onto Teldrassil\'s boughs in order to meet with other Kaldorei who prepare for the adventures ahead.', `VerifiedBuild` = 12340 WHERE `ID` = 3119;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 0, `CompletionText` = 'Ah, young $C. I see you\'re eager to continue your studies. Good.$b$bI wonder, have you spent much time in the Emerald Dream already? Perhaps you\'re not prepared for that yet... In time, I\'m sure.$b$bBut until then, we should discuss other matters.', `VerifiedBuild` = 12340 WHERE `ID` = 3120;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Yes?', `VerifiedBuild` = 12340 WHERE `ID` = 3121;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Have you spoken to Neeru?', `VerifiedBuild` = 12340 WHERE `ID` = 3122;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Were you able to capture the wildkin?$b$bIf you succeed, we will be ready to shrink and capture the muisek of creatures of Feralas.', `VerifiedBuild` = 12340 WHERE `ID` = 3123;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Were you able to capture the hippogryphs?', `VerifiedBuild` = 12340 WHERE `ID` = 3124;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Were you able to capture the muisek of the faerie dragons?', `VerifiedBuild` = 12340 WHERE `ID` = 3125;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Were you able to capture the wandering forest walkers?', `VerifiedBuild` = 12340 WHERE `ID` = 3126;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Were you able to capture the mountain giants?', `VerifiedBuild` = 12340 WHERE `ID` = 3127;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Were you able to collect the materials I need?', `VerifiedBuild` = 12340 WHERE `ID` = 3128;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Are you having any trouble?$B$BYou can find Gahz\'ridian just about anywhere in Tanaris, $N, so keep looking!', `VerifiedBuild` = 12340 WHERE `ID` = 3161;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 274, `EmoteOnIncomplete` = 0, `CompletionText` = 'No, I will not open the gate.', `VerifiedBuild` = 12340 WHERE `ID` = 3181;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 3, `EmoteOnIncomplete` = 0, `CompletionText` = 'Why hello there young lady. Would you like a tour of the museum?', `VerifiedBuild` = 12340 WHERE `ID` = 3182;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 274, `EmoteOnIncomplete` = 0, `CompletionText` = 'I don\'t believe it.', `VerifiedBuild` = 12340 WHERE `ID` = 3201;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the silver?', `VerifiedBuild` = 12340 WHERE `ID` = 3281;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'I can smell the dust of the Barrens on you, $C. You have traveled far.', `VerifiedBuild` = 12340 WHERE `ID` = 3301;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 18, `EmoteOnIncomplete` = 18, `CompletionText` = '<Thorius sobs.>', `VerifiedBuild` = 12340 WHERE `ID` = 3368;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'May I help you with something?', `VerifiedBuild` = 12340 WHERE `ID` = 3369;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'May I help you with something?', `VerifiedBuild` = 12340 WHERE `ID` = 3370;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Here we are $N, at yet another crossroads. The time has come to make another choice. What choice do you make, mortal?', `VerifiedBuild` = 12340 WHERE `ID` = 3374;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'To make another phial I need a mana potion, a piece of coal, and some sweet nectar.$B$BThat, and a whole lotta patience apparently.', `VerifiedBuild` = 12340 WHERE `ID` = 3375;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'What brings you to the Temple of the Moon, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 3378;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'What information do you have?', `VerifiedBuild` = 12340 WHERE `ID` = 3379;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'The Trade Master still lives?', `VerifiedBuild` = 12340 WHERE `ID` = 3385;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you collected the materials?', `VerifiedBuild` = 12340 WHERE `ID` = 3442;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Eight, $N. I need eight!	', `VerifiedBuild` = 12340 WHERE `ID` = 3443;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Ratchet is not far from here, $N. The journey shouldn\'t take long.', `VerifiedBuild` = 12340 WHERE `ID` = 3444;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 4, `EmoteOnIncomplete` = 4, `CompletionText` = 'Well, well, well, glad to see you made it out here, $N. Did you get the rubbings for Tymor?$B$BAs dangerous as this place is, there hasn\'t been too much action along the coast. That might be on account of the naga swimming underwater, but that\'s not my problem... I patrol the skies.', `VerifiedBuild` = 12340 WHERE `ID` = 3449;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = 'Ah, Belgrom wizened up and finally sent someone not in his ranks to aid us, did he?$b$bThis camp used to be a dozen warriors strong, $N, but now they\'re all dead. That mage, Rimtori, has slain them all. She played Belgrom like a lute... seduced him even. It\'s none of my business, but between you and I, she is quite the temptress. That\'s probably why I\'m still out here helping Belgrom--I probably would have done the same thing.', `VerifiedBuild` = 12340 WHERE `ID` = 3504;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You return! Astounding, $R. Did you discover the true name?', `VerifiedBuild` = 12340 WHERE `ID` = 3511;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Whaddya got?', `VerifiedBuild` = 12340 WHERE `ID` = 3513;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 5, `CompletionText` = 'We cannot allow the Alliance on our land, $N. Make this known.', `VerifiedBuild` = 12340 WHERE `ID` = 3514;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the tablets of the Prophecy of Mosh\'aru, $N?$b$bWhen I gain the tablets, I will study them, and learn how to contain the essence of Hakkar!', `VerifiedBuild` = 12340 WHERE `ID` = 3527;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you defeated the avatar of Hakkar, $N? Has his essence yet empowered the egg I gave you?', `VerifiedBuild` = 12340 WHERE `ID` = 3528;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = 'Yes, what you be needin\', mon? I got many tings to be takin\' care of today, and you not be on me agenda as one of them. Pester me, and I make sure that changes.', `VerifiedBuild` = 12340 WHERE `ID` = 3541;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 274, `EmoteOnIncomplete` = 274, `CompletionText` = 'I don\'t believe you! Show me proof!', `VerifiedBuild` = 12340 WHERE `ID` = 3566;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 25, `EmoteOnIncomplete` = 25, `CompletionText` = 'Evil does not sleep, fool. You will have time for rest when you are finally dead. Now, bring me those crystals.', `VerifiedBuild` = 12340 WHERE `ID` = 3602;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Loramus, eh? It has been many years since I have heard that name.', `VerifiedBuild` = 12340 WHERE `ID` = 3621;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'The three shall form the one, the one shall light the way.', `VerifiedBuild` = 12340 WHERE `ID` = 3627;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'There is nothing left to fear.', `VerifiedBuild` = 12340 WHERE `ID` = 3628;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Yes, yes, what needs of yours might I address today? Clearly, I have the time to do such since all I do is stand here while our beloved city lies in a cloud of irradiated death.', `VerifiedBuild` = 12340 WHERE `ID` = 3630;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Yes, yes, what needs of yours might I address today? Clearly, I have the time to do such since all I do is stand here while our beloved city lies in a cloud of irradiated death.', `VerifiedBuild` = 12340 WHERE `ID` = 3632;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Yes, yes, what needs of yours might I address today? Clearly, I have the time to do such since all I do is stand here while our beloved city lies in a cloud of irradiated death.', `VerifiedBuild` = 12340 WHERE `ID` = 3634;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 3, `EmoteOnIncomplete` = 0, `CompletionText` = 'Hello there! If you\'ve come about a homing robot that may have smashed through a wall of your domicile, then I will refer you to my barrister in advance. Otherwise, what can I do for you today?', `VerifiedBuild` = 12340 WHERE `ID` = 3635;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 3, `EmoteOnIncomplete` = 0, `CompletionText` = 'Hello there! If you\'ve come about a homing robot that may have smashed through a wall of your domicile, then I will refer you to my barrister in advance. Otherwise, what can I do for you today?', `VerifiedBuild` = 12340 WHERE `ID` = 3637;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'If you\'ve signed the document and are ready to hand it to me, then that is that. You\'ve been told that this is a one way trip. If you\'re ready, then hop on board!', `VerifiedBuild` = 12340 WHERE `ID` = 3638;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Once I receive your crafted engineering items for my review, I will hand you a genuine Goblin Engineer Membership Card! So long as the card is valid, you will have unlimited access to any goblin engineer trainer anywhere in the world.', `VerifiedBuild` = 12340 WHERE `ID` = 3639;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'If you\'ve signed the document and are ready to hand it to me, then that is that.$B$BThe secrets I will share with you are of such a magnitude that the signing of the Pledge of Secrecy is absolutely critical. I signed one, as did my brother and sister gnome engineers. You will be joining quite the auspicious fold, Engineer $N!', `VerifiedBuild` = 12340 WHERE `ID` = 3640;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Once I receive your crafted engineering items for my review, I will hand you a genuine Gnome Engineer Membership Card! So long as the card is valid, you will have unlimited access to any gnome engineer trainer anywhere in the world.', `VerifiedBuild` = 12340 WHERE `ID` = 3641;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'If you\'ve signed the document and are ready to hand it to me, then that is that.$B$BWhile I may vehemently disagree with Gnomeregan - especially that fool Tinkmaster Overspark - politically, the Pledge of Secrecy transcends everything else! You must agree to commit a single path and stay true to that path throughout your life.', `VerifiedBuild` = 12340 WHERE `ID` = 3642;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Once I receive your crafted engineering items for my review, I will hand you a genuine Gnome Engineer Membership Card! So long as the card is valid, you will have unlimited access to any gnome engineer trainer anywhere in the world.', `VerifiedBuild` = 12340 WHERE `ID` = 3643;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you bring new information?', `VerifiedBuild` = 12340 WHERE `ID` = 3701;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 24, `EmoteOnIncomplete` = 24, `CompletionText` = 'Hi. I miss my necklace. My daddy got it for me. Daddy says that there are monsters in the lake. Did you beat up any monsters?', `VerifiedBuild` = 12340 WHERE `ID` = 3741;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 25, `EmoteOnIncomplete` = 25, `CompletionText` = 'At ease, Private. If you\'re here to unload soil from Un\'Goro - outstanding then! Otherwise, disappear.', `VerifiedBuild` = 12340 WHERE `ID` = 3761;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 4, `EmoteOnIncomplete` = 4, `CompletionText` = 'Ah yes, the dirt. The Arch Druid wants twenty loads per adventurer, and twenty loads he shall get. Let those who conspire against us fall to the wayside!', `VerifiedBuild` = 12340 WHERE `ID` = 3764;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 0, `CompletionText` = 'Peace and serenity be yours, friend. You are here on business from the Arch Druid himself, yes?', `VerifiedBuild` = 12340 WHERE `ID` = 3781;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 0, `CompletionText` = 'Peace and serenity be yours, friend. You are here on business from the Arch Druid himself, yes?', `VerifiedBuild` = 12340 WHERE `ID` = 3782;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'I\'ve got lots to get started on here. Please get me those furs as soon as you can!', `VerifiedBuild` = 12340 WHERE `ID` = 3783;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Yes $N, have you grown some morrowgrain for the Arch Druid\'s important research? The mysterious properties of Un\'Goro Crater become clearer with each passing day, thanks to the help you are giving us.', `VerifiedBuild` = 12340 WHERE `ID` = 3785;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Yes $N, have you grown some morrowgrain for the Arch Druid\'s important research?  The mysterious properties of Un\'Goro Crater become clearer with each passing day, thanks to the help you are giving us.', `VerifiedBuild` = 12340 WHERE `ID` = 3786;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I\'m looking for ten morrowgrain - that should be enough to at least get my research started.  I\'ll no doubt burn through a lot of those going down wrong paths, but such is the nature of research.', `VerifiedBuild` = 12340 WHERE `ID` = 3791;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Hello again, $N. My research is progressing fairly well, but if you have five more Morrowgrain I\'d be happy to take them off your hands. Well... happy is a figurative term in this case; the more I am around them, the more uncomfortable I feel. Still, my research demands I buckle down and get through this.', `VerifiedBuild` = 12340 WHERE `ID` = 3792;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'The Arch Druid is always looking for additional morrowgrain for the Cenarion Circle\'s continued research. We take them in increments of ten, and award you with a cache of goods you should find useful. When you have ten, let me know and I will reward you accordingly.', `VerifiedBuild` = 12340 WHERE `ID` = 3803;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'The Arch Druid is always looking for more morrowgrain for the Cenarion Circle\'s research project on Un\'Goro Crater. We take them in increments of ten, and award you with a cache of goods you should find useful. When you have ten, let me know and I will award you accordingly.', `VerifiedBuild` = 12340 WHERE `ID` = 3804;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you find Sha\'ni? Is she ok?', `VerifiedBuild` = 12340 WHERE `ID` = 3822;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 25, `CompletionText` = 'There is not nearly enough blood on your uniform, soldier!', `VerifiedBuild` = 12340 WHERE `ID` = 3823;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Oh glorious day! Have you returned with the head?', `VerifiedBuild` = 12340 WHERE `ID` = 3824;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'So? Did you paint any pictures of the event?', `VerifiedBuild` = 12340 WHERE `ID` = 3825;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 3, `EmoteOnIncomplete` = 0, `CompletionText` = 'Why hello, $C.$B$BDon\'t let my location fool you, I\'m really not here for the races... as entertaining as they may be.$B$BI\'m actually here in Thousand Needles investigating all I can to find out how salvageable the land is. It has become my crusade of sorts to revitalize and replenish the area with new, fertile soil. Perhaps I\'ll find there\'s a water source nearby.$B$BTell me you haven\'t noticed how odd the transition between Feralas and Thousand Needles is. Strange magic was afoot when that happened.', `VerifiedBuild` = 12340 WHERE `ID` = 3841;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'The longer I stay here, the more tempted I am to partake in these races, $N. Truly boggling...$B$BHave you found the elixirs yet? Once I can tell if the egg is going to be healthy or not, I\'ll return it to you to hold onto until it\'s prepared to hatch.$B$BLet me know.', `VerifiedBuild` = 12340 WHERE `ID` = 3842;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Greetin\'s, $N. How can I be of service to ya?', `VerifiedBuild` = 12340 WHERE `ID` = 3843;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Hi there. I\'ve seen you before... Haven\'t I?', `VerifiedBuild` = 12340 WHERE `ID` = 3845;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'If we\'re going to have any chance of getting out of here alive, we\'ll need our big crate of foodstuffs.  Also, getting at least some of our research equipment back would be a blessing in a sea of misery.', `VerifiedBuild` = 12340 WHERE `ID` = 3881;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Think whatever you want of me, but they\'re not going to care if the bones they get to research are from ones from ancient stegodons and diemetradons or the ones that almost devoured us wholesale when we were trying to set up our camps.  I\'ll just be happy if we get out of here alive...', `VerifiedBuild` = 12340 WHERE `ID` = 3882;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the sample of the Gorishi hive for me to study, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 3883;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Have you managed to scavenge up some useful items for us? There is no shame in reusing that which has been tossed aside. No one is going to give us any handouts - we Forsaken will fend for ourselves!', `VerifiedBuild` = 12340 WHERE `ID` = 3902;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do you have my harvest, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 3904;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'You look to be in fine spirits! Come! Have a seat, and have a drink!', `VerifiedBuild` = 12340 WHERE `ID` = 3905;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'The flames will soon overtake these lands. Make haste, $N!', `VerifiedBuild` = 12340 WHERE `ID` = 3907;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'My, my... So Linken did finally get around to sending me his sword.', `VerifiedBuild` = 12340 WHERE `ID` = 3908;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Back already?', `VerifiedBuild` = 12340 WHERE `ID` = 3909;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 25, `EmoteOnIncomplete` = 0, `CompletionText` = 'Oh! I remember you! You are... No, don\'t tell me!', `VerifiedBuild` = 12340 WHERE `ID` = 3914;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'I\'m very busy with my work, $C. Unless you have something for me, it\'d be best if you moved along...', `VerifiedBuild` = 12340 WHERE `ID` = 3921;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do you have the nugget slugs, $N? I\'ve been eyeing this Samophlange and I can\'t wait to tinker with it.', `VerifiedBuild` = 12340 WHERE `ID` = 3922;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Mind your head! I don\'t want it to get in the way of my work!', `VerifiedBuild` = 12340 WHERE `ID` = 3923;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do you have the manual?', `VerifiedBuild` = 12340 WHERE `ID` = 3924;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 3, `EmoteOnIncomplete` = 0, `CompletionText` = 'Hi, again, $N!', `VerifiedBuild` = 12340 WHERE `ID` = 3961;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Blazerunner is almost invincible behind the aura he has created by using the Golden Flame. Only you have the power to remove it with the Silver Totem of Aquementas.', `VerifiedBuild` = 12340 WHERE `ID` = 3962;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 5, `CompletionText` = 'Defend yourself, fool!', `VerifiedBuild` = 12340 WHERE `ID` = 3982;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'So you\'re back, eh? Hmm... Let me take a look at that, $N.', `VerifiedBuild` = 12340 WHERE `ID` = 4005;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do you have the banner?', `VerifiedBuild` = 12340 WHERE `ID` = 4021;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Bring me an Evoroot, and sure, I can make ya that Videre Elixir.$B$BI know all kinds of things about herbs and alchemy... Why, let me tell you the story about the time I transmuted gold from the cheese I was going to eat for lunch... hey... Where are you going?', `VerifiedBuild` = 12340 WHERE `ID` = 4041;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'Do not take this task lightly, $N!', `VerifiedBuild` = 12340 WHERE `ID` = 4061;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'What have you got there, $R?', `VerifiedBuild` = 12340 WHERE `ID` = 4062;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Was it him? Was he really alive?', `VerifiedBuild` = 12340 WHERE `ID` = 4063;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'You again? I have to hand it to you, $N, you are tenacious.', `VerifiedBuild` = 12340 WHERE `ID` = 4082;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I can tell you more of the power of which you required to defeat Blazerunner, but first, you need to gather the things I require.', `VerifiedBuild` = 12340 WHERE `ID` = 4084;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'I know Felwood suffers, $N - I suffer along with it!  I must remain steadfast in my conviction; were the knowledge I possess to fall into the wrong hands, it would spell disaster for all of Felwood.$B$BBring to me the blood amber drawn from the slain Warpwood elementals, and I will trust you enough to help me enact a means to fight the corruption.', `VerifiedBuild` = 12340 WHERE `ID` = 4101;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'I know Felwood suffers, $N - I suffer along with it!  I must remain steadfast in my conviction; were the knowledge I possess to fall into the wrong hands, it would spell disaster for all of Felwood.$B$BBring to me the blood amber drawn from the slain Warpwood elementals, and I will trust you enough to help me enact a means to fight the corruption.', `VerifiedBuild` = 12340 WHERE `ID` = 4102;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Possessing a Cenarion Beacon allows one to sea a corrupted soul shard on those tainted beasts that are put down for the greater good. I grind shards into a usable reagent that goes into making Cenarion plant salve. We will use that salve to turn corrupted plants into healthy ones again.$b$bIn exchange for these shards, I will give you some Cenarion plant salves I have already prepared.', `VerifiedBuild` = 12340 WHERE `ID` = 4103;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Possessing a Cenarion Beacon allows one to sea a corrupted soul shard on those tainted beasts that are put down for the greater good. I grind shards into a usable reagent that goes into making Cenarion plant salve. We will use that salve to turn corrupted plants into healthy ones again.$b$bIn exchange for these shards, I will give you some Cenarion plant salves I have already prepared.', `VerifiedBuild` = 12340 WHERE `ID` = 4108;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'I will take this traitorous filth, $N.', `VerifiedBuild` = 12340 WHERE `ID` = 4121;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'Do you have the recipe, $N? I can\'t stand the idea of those Dark Iron dwarves drinking my family\'s drink!', `VerifiedBuild` = 12340 WHERE `ID` = 4126;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 2, `CompletionText` = 'Ah, welcome back $N.  I hope that you were able to uncover some clue as to Raschal\'s ultimate fate, as tragic as that may be.', `VerifiedBuild` = 12340 WHERE `ID` = 4127;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Ginro sent you, eh?$B$BMy psychometric readings are fairly draining on the psyche... but so are my losses at Kalimdor Hold \'Em.  They call me \"King of the Bad Beats\" here in the Stronghold.  Unlucky at cards... lucky at mastering the secrets of nature, I guess.$B$BAnyway, of course I\'ll do it.  This may be just the breakthrough we need to uncover Raschal\'s fate.  If you would hand me the knife, we can get started.', `VerifiedBuild` = 12340 WHERE `ID` = 4129;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the recipe for the Thunderbrew Lager, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 4134;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 11, `EmoteOnIncomplete` = 11, `CompletionText` = 'Larion\'s got something coming, that\'s for sure!', `VerifiedBuild` = 12340 WHERE `ID` = 4141;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'I live out here in the forest... Peaceful.$B$BWell, at least I thought it would be. I get more visitors out here than I ever did when I lived in Ironforge!', `VerifiedBuild` = 12340 WHERE `ID` = 4142;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Larion\'s still not speaking to me! He sure knows how to hold a grudge.', `VerifiedBuild` = 12340 WHERE `ID` = 4143;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Here\'s the plan, $n: Go out and collect some bloodpetal sprouts -- you know, the plants that haven\'t fully sprouted yet, and bring them here. Then I\'ll see what the Atal\'ai haze can do.$B$BYou may think I\'m vengeful... Actually, you\'d be right about that! $B$BTruth is, I know the way out of here, but until Larion will admit that I\'m right, I\'m staying right here!$B$BSo off with you, find those bloodpetal sprouts and let\'s have some fun!', `VerifiedBuild` = 12340 WHERE `ID` = 4144;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'This is exhausting, $N. Those things just won\'t leave me alone!', `VerifiedBuild` = 12340 WHERE `ID` = 4146;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'For the zapper to work, it needs a sample of the target creature. Head out into the crater and collect a Bloodpetal sprout. Then I can calibrate it to work on Muigin\'s little friends...$b$bIf he weren\'t so stubborn, we could be on our way home, already... But until then, I\'ll just have to show him that his little prank doesn\'t bother me at all!', `VerifiedBuild` = 12340 WHERE `ID` = 4148;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'Is the fiend dead??', `VerifiedBuild` = 12340 WHERE `ID` = 4263;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 2, `CompletionText` = 'Welcome to this blessed temple, friend.  Your arrival here from Feathermoon Stronghold has been foretold to me.  Do you have the report Shandris Feathermoon asked you to bring?', `VerifiedBuild` = 12340 WHERE `ID` = 4267;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 0, `CompletionText` = 'Welcome to Thalanaar, $C. Do you need assistance of some sort?', `VerifiedBuild` = 12340 WHERE `ID` = 4281;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = '<Oralius is talking into a rather large, severed ogre ear.>$B$BBurning Steppes to control, come in control.', `VerifiedBuild` = 12340 WHERE `ID` = 4283;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'I just know I\'m onto something here, $N!', `VerifiedBuild` = 12340 WHERE `ID` = 4284;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I can\'t be bothered right now, $N. Me and Winky got a meeting to attend.', `VerifiedBuild` = 12340 WHERE `ID` = 4286;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 2, `CompletionText` = 'Have the creatures here bested you already, $N?$B$BDo not be dissuaded so easily. Tracking and defeating the apes of Un\'Goro is no simple task, even for a great hunter.', `VerifiedBuild` = 12340 WHERE `ID` = 4289;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Do not take my words lightly, $N. If you truly wish to face this creature, then you must be careful... and smart. It will take a great deal of strength and insight to draw out Lar\'korwi and defeat him.', `VerifiedBuild` = 12340 WHERE `ID` = 4290;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Be careful, $N. Getting close to any of nest of eggs surely will provoke the mothers... even if you\'ve already secured a gland from one. The mothers can be just as deadly as Lar\'korwi himself when they fight to protect their young. But, if you are successful, then we shall have a definitive way of bringing Lar\'korwi out from hiding.', `VerifiedBuild` = 12340 WHERE `ID` = 4291;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 2, `CompletionText` = 'Do not let fear overpower you, $N. Fear is the great betrayer... you must remain strong!$B$BTake the meat, place it in the small valley, and then use the gland on it. Only then will death come for you.', `VerifiedBuild` = 12340 WHERE `ID` = 4292;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'Oh, ale!  I would kill for some Dark Iron ale!!  Quick, I\'m getting sober!  I know this because sobriety blurs my vision... and it\'s making you look like the $r I slew last week!', `VerifiedBuild` = 12340 WHERE `ID` = 4295;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do you have the writings of the Seven, $N?  Have you learned the secrets from their tablet?', `VerifiedBuild` = 12340 WHERE `ID` = 4296;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Find that meat yet, $N? Your little egg here\'s just about ready to hatch. If he don\'t have a good enough first meal, then he might not make it past his first week, and I\'d hate for that to happen.$B$BCan\'t much lie to ya, $N. I\'m jealous of you gettin\' this egg to begin with. Don\'t make me regret helpin\' ya out like this.', `VerifiedBuild` = 12340 WHERE `ID` = 4297;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Me clients are not so patient, $N. Have you gotten any of the claws yet?', `VerifiedBuild` = 12340 WHERE `ID` = 4300;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'U\'cha... the beast was magnificent. Huge and red, with teeth the size of daggers. His arms as thick as tree trunks, and as fast as any mountain lion I have ever laid eyes upon. You should consider yourself lucky to find such a test of bravery--my people would go generations without seeing such a creature.', `VerifiedBuild` = 12340 WHERE `ID` = 4301;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you finished collecting cactus apples?', `VerifiedBuild` = 12340 WHERE `ID` = 4402;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'The water will hopefully release the spirit of the ancient, and allow it to be at peace.', `VerifiedBuild` = 12340 WHERE `ID` = 4441;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Yes, yes? What can I do for you, $R? I\'m awfully busy and have many patrons requesting my services. Perhaps you can speed things up. I don\'t mean to be rude, but I just don\'t have the time if I\'m to catch up on all my work.', `VerifiedBuild` = 12340 WHERE `ID` = 4450;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 25, `EmoteOnIncomplete` = 25, `CompletionText` = 'Present the components, mortal.$B$BI will also require payment in the form of thirty gold pieces for this creation.', `VerifiedBuild` = 12340 WHERE `ID` = 4463;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'There is a price to pay for all things in this world. The price for the specific item that you seek is thirty gold pieces.$B$BNaturally, I shall retain the majority of the components which you collected. But worry not, you shall have your trinket.', `VerifiedBuild` = 12340 WHERE `ID` = 4481;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Thirty gold, $R. Thirty gold and the required components.', `VerifiedBuild` = 12340 WHERE `ID` = 4482;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'If it is resilience you desire, thirty gold I require.', `VerifiedBuild` = 12340 WHERE `ID` = 4483;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 274, `EmoteOnIncomplete` = 274, `CompletionText` = 'Do not waste my time, $R. Give me what I require. Thirty gold and the components.', `VerifiedBuild` = 12340 WHERE `ID` = 4484;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Finding a suitable scent gland might take a bit - the gland can\'t be damaged, but the process of getting one certainly doesn\'t lend itself to it. As for the soil, I\'d assume it should be easy enough to find.$b$bAnyway, do you have the items I need to make the lure?', `VerifiedBuild` = 12340 WHERE `ID` = 4496;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Is it true that the volcano in Un\'Goro is active? I\'m sure I could learn a lot with some ash from the volcano, $N.', `VerifiedBuild` = 12340 WHERE `ID` = 4502;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Every great vehicle needs a name... I was thinking I\'d call it... Pwned!', `VerifiedBuild` = 12340 WHERE `ID` = 4503;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 4, `EmoteOnIncomplete` = 4, `CompletionText` = 'Tran\'rek\'s done it again -- this super sticky glue will be all the rage!', `VerifiedBuild` = 12340 WHERE `ID` = 4504;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'This is of utmost importance. Be on your way, now.', `VerifiedBuild` = 12340 WHERE `ID` = 4505;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 5, `CompletionText` = 'Don\'t tell me that you can\'t go back there! Get going!', `VerifiedBuild` = 12340 WHERE `ID` = 4506;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Acquiring the queen\'s brain for our research is absolutely imperative.  From what we have learned, we believe that these silithid are quite possibly being controlled by a malign intelligence.  I shudder to think what could control something as insidious as the silithid, $N.', `VerifiedBuild` = 12340 WHERE `ID` = 4507;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'They are fools, $N!  They cannot even think to look around them for a greater threat; their irrational hatred of the Horde will be the end of us all.  I do not know how much more proof I can give them of the silithid threat short of dropping them in one of the hives so they can see for themselves!$B$BI\'m sorry, you bring news for my attention?', `VerifiedBuild` = 12340 WHERE `ID` = 4508;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'They are fools, $N!  They cannot even think to look around them for a greater threat; their irrational hatred of the Alliance will be our undoing.  I do not know how much more proof I can give them of the silithid threat short of dropping them in one of the hives so they can see for themselves!$B$BI\'m sorry, you bring news for my attention?', `VerifiedBuild` = 12340 WHERE `ID` = 4509;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 2, `CompletionText` = 'Elune\'adore, $C.  What may I do for you today?', `VerifiedBuild` = 12340 WHERE `ID` = 4510;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 2, `CompletionText` = 'Zug zug!  What may I help you with today, $C?', `VerifiedBuild` = 12340 WHERE `ID` = 4511;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Some of the experiments I\'ve done are fascinating. I think with a little more work, I\'ll be able to figure out the nature of these creatures and how they play into how life developed on Azeroth... if they even have anything to do with it to begin with.$B$BOne of my biggest theories that isn\'t well liked is the idea that oozes and slimes are tied to the creation of this planet... almost like they\'re a secretion of it.$B$BBut I can\'t prove or disprove it until I get more samples.', `VerifiedBuild` = 12340 WHERE `ID` = 4512;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'So many things to consider. But what does it mean? And how does it affect the lives of the people of Azeroth?', `VerifiedBuild` = 12340 WHERE `ID` = 4513;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 25, `CompletionText` = 'Report back to me after you have completed the task I gave you.', `VerifiedBuild` = 12340 WHERE `ID` = 4521;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'What do you want, $C? An urgent message - for me?$b', `VerifiedBuild` = 12340 WHERE `ID` = 4542;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do you have something for me?', `VerifiedBuild` = 12340 WHERE `ID` = 4581;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Once you have investigated the creature\'s remains in the water to the west of here, I should be able to file a proper report with the Temple of the Moon in Darnassus. Perhaps then we will be closer to discovering the reason why these unfortunate creatures choose to end their lives beached on the coast of Darkshore.', `VerifiedBuild` = 12340 WHERE `ID` = 4681;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you discovered and dealt with the source of the worg menace?', `VerifiedBuild` = 12340 WHERE `ID` = 4701;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 25, `CompletionText` = 'You know your orders, $N.', `VerifiedBuild` = 12340 WHERE `ID` = 4721;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 3, `EmoteOnIncomplete` = 0, `CompletionText` = 'Hello $N - do you have any discoveries of creatures that have washed ashore to report on?', `VerifiedBuild` = 12340 WHERE `ID` = 4722;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 3, `EmoteOnIncomplete` = 0, `CompletionText` = 'Hello again, $N! Are you here to report on another discovery?', `VerifiedBuild` = 12340 WHERE `ID` = 4723;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the broodling essence, $N?  I can\'t wait to study it.$B$BAnd besides that... my patron is not the type of person you want to disappoint.', `VerifiedBuild` = 12340 WHERE `ID` = 4726;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 3, `EmoteOnIncomplete` = 0, `CompletionText` = 'Hello again, $N! Are you here to report on another discovery?', `VerifiedBuild` = 12340 WHERE `ID` = 4727;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 3, `EmoteOnIncomplete` = 0, `CompletionText` = 'Greetings once again, $N!  What brings you back to Auberdine?  Are you here to report on another discovery, perhaps?', `VerifiedBuild` = 12340 WHERE `ID` = 4728;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = '<Kibler is busy arguing with Toucan Stan.>', `VerifiedBuild` = 12340 WHERE `ID` = 4729;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 3, `EmoteOnIncomplete` = 0, `CompletionText` = 'Hello again, $N!  Are you here to report on another discovery?', `VerifiedBuild` = 12340 WHERE `ID` = 4730;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 3, `EmoteOnIncomplete` = 0, `CompletionText` = 'Hello again, $N.  The work you have done on behalf of the Temple of the Moon has been outstanding.  Are we to be blessed with more of your effort on our behalf?', `VerifiedBuild` = 12340 WHERE `ID` = 4731;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = '$N, did you test the eggscilloscope?', `VerifiedBuild` = 12340 WHERE `ID` = 4734;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the eggs, $N?  My patron heard you were collecting them for me, and is very eager to get his hands on them!', `VerifiedBuild` = 12340 WHERE `ID` = 4735;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'The pollution of the Cliffspring River is but the start of an alarming trend here in Darkshore.  The sample you provide will help us formalize a plan... a plan of attack, I am starting to suspect.', `VerifiedBuild` = 12340 WHERE `ID` = 4762;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'The Talisman of Corruption is a sinister device that only serves to pervert the balance of nature. When you obtain this item from whatever satyr is tormenting the furbolgs and bring it to me for disposal, we will have won a great victory this day!', `VerifiedBuild` = 12340 WHERE `ID` = 4763;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do you have the clasp, $N? My patron will pay very handsomely for it.', `VerifiedBuild` = 12340 WHERE `ID` = 4764;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'I was told a messenger would come. One with a gift from Blackrock Spire.$B$BAre you he?', `VerifiedBuild` = 12340 WHERE `ID` = 4765;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = '$N, have you retrieved the wyvern eggs that I seek? I\'m really anxious to start my wind rider training!', `VerifiedBuild` = 12340 WHERE `ID` = 4767;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you found the Tablet, $N?  I yearn to delve into its secrets.', `VerifiedBuild` = 12340 WHERE `ID` = 4768;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 25, `CompletionText` = 'Remember, $N - we must be tolerant yet rigid in our beliefs!', `VerifiedBuild` = 12340 WHERE `ID` = 4771;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 2, `CompletionText` = 'Gold bars, yes... yes. Bring me one and we\'ll see what we can do about spinning some thread for you. Until then, I would suggest you focus your efforts on becoming more powerful. Your toughest trials are still ahead. And trust me... you\'ll wish you were more prepared, regardless of how powerful you think you might be.', `VerifiedBuild` = 12340 WHERE `ID` = 4781;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Desolace is not a kind area: naga, giants, satyr, the Burning Legion... all of those and warring centaur clans all make the land dangerous if you\'re not careful.$B$BLike I said before, it will not only test your strength and cunning, but also your patience. Be wary in those lands, $N.', `VerifiedBuild` = 12340 WHERE `ID` = 4783;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Soon, $N. I promise you. The robe will be more than adequate for your needs and certainly give you an edge over your opponents.', `VerifiedBuild` = 12340 WHERE `ID` = 4784;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do you have the ancient egg? I sense great forces stirring, and I fear that time grows short.', `VerifiedBuild` = 12340 WHERE `ID` = 4787;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you been to the spire, $N? Do you have the fifth and sixth tables?', `VerifiedBuild` = 12340 WHERE `ID` = 4788;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'In Winterspring, you will fight great cats called frostsabers. These beasts possess incredible speed an\' cunning. If you wish ta gain the speed a\' da frostsaber, bring me da E\'ko you find from dem.$B$BRememba, you must have the Cache of Mau\'ari in your inventory if you want ta hunt for E\'ko.', `VerifiedBuild` = 12340 WHERE `ID` = 4801;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'In Winterspring, you will fight misguided creatures known as da Winterfall furbolg. Through the wishes of their leader, dey have gained incredible strength. If you wish ta gain the power a\' da Winterfall, bring me da E\'ko you find from dem.$B$BRememba, you must have the Cache of Mau\'ari in your inventory if you want ta hunt for E\'ko.', `VerifiedBuild` = 12340 WHERE `ID` = 4802;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'In Winterspring, you will find large bears wit extremely thick hides. These Shardtooth bears gain much protection from what dey can withstand. If you wish ta gain the resistance against fire, bring me da E\'ko you find from da Shardtooth.$B$BRememba, you must have the Cache of Mau\'ari in your inventory if you want ta hunt for E\'ko.$B$B', `VerifiedBuild` = 12340 WHERE `ID` = 4803;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'In Winterspring, you will fight great flying creatures called da Chillwind. These beasts possess da power ta wield frost magics. If you wish ta gain resistance ta frost, bring me da E\'ko you find from da Chillwind.$B$BRememba, you must have the Cache of Mau\'ari in your inventory if you want ta hunt for E\'ko.$B$B', `VerifiedBuild` = 12340 WHERE `ID` = 4804;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'In Winterspring, you will fight great creatures called da ice thistle yeti. These beasts move slowly, but dey are able to evade many blows from da protection their thick fur provides dem. If you wish ta gain da ability to dodge attacks, bring me da E\'ko you find from dem.$B$BRememba, you must have the Cache of Mau\'ari in your inventory if you want ta hunt for E\'ko.$B$B', `VerifiedBuild` = 12340 WHERE `ID` = 4805;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'In Winterspring, you have fought da large ice giants called frostmaul. Sheer power and force is at their disposal. If you wish ta gain da force of da frostmaul, bring me da E\'ko you find from dem.$B$BRememba, you must have the Cache of Mau\'ari in your inventory if you want ta hunt for E\'ko.', `VerifiedBuild` = 12340 WHERE `ID` = 4806;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'In Winterspring, you will fight creatures of might dat seem to possess an innate magic ability. These wildkin can use strong magics. If you wish ta gain an increase in your intellect bring me da E\'ko you find from any a\' da owlbeasts you find der.$B$BRememba, you must have the Cache of Mau\'ari in your inventory if you want ta hunt for E\'ko.$B$B', `VerifiedBuild` = 12340 WHERE `ID` = 4807;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the chillwind horns, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 4809;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = '$N! Did you talk to Felnok? Did you bring the components I need?', `VerifiedBuild` = 12340 WHERE `ID` = 4810;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'What do you have to report on that red crystal? Does it even really exist?', `VerifiedBuild` = 12340 WHERE `ID` = 4811;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I must know more about this mysterious egg, who knows what will hatch from it.', `VerifiedBuild` = 12340 WHERE `ID` = 4821;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 25, `CompletionText` = 'Come now $N, I know you haven\'t killed your share yet. Hunt them down, and I shall give you a reward for my gratitude.', `VerifiedBuild` = 12340 WHERE `ID` = 4841;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Are those spider eggs in your pack or are you just happy to see me?', `VerifiedBuild` = 12340 WHERE `ID` = 4862;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Aye... Tell me the news.', `VerifiedBuild` = 12340 WHERE `ID` = 4864;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'How may I help you, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 4883;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 66, `EmoteOnIncomplete` = 66, `CompletionText` = '<Warlord Goretooth salutes.>', `VerifiedBuild` = 12340 WHERE `ID` = 4903;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 20, `CompletionText` = 'Please, put and end to the suffering of Felwood\'s creatures.', `VerifiedBuild` = 12340 WHERE `ID` = 4906;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you found any sign of her at all? The pain in my chest tells me that the worst has happened, but I have hope you will find her safe and sound.', `VerifiedBuild` = 12340 WHERE `ID` = 4921;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'You\'ll have to kill that demon to remove its presence permanently from the orb, $N.', `VerifiedBuild` = 12340 WHERE `ID` = 4961;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Yes, $N? Have you chosen? Infernal or felhound?$B$BEach choice is personal and should reflect your strengths and weaknesses. It is not unheard of for a $C to enhance themselves further instead of making up in areas they lack. Sometimes overpowering an enemy is just as strong a tactic than becoming a more balanced spell caster.', `VerifiedBuild` = 12340 WHERE `ID` = 4962;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Yes, $N? Have you chosen? Infernal or felhound?$B$BEach choice is personal and should reflect your strengths and weaknesses. It is not unheard of for a $C to enhance themselves further instead of making up in areas they lack. Sometimes overpowering an enemy is just as strong a tactic than becoming a more balanced spell caster.', `VerifiedBuild` = 12340 WHERE `ID` = 4963;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Discipline and determination are your goals. I may ask you to do a simple task many times; you must perform to the best of your ability each time.', `VerifiedBuild` = 12340 WHERE `ID` = 4970;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'The time trinkets I seek are simple devices.  They are watches mainly, and their hands are trapped forever when the plague first ravaged Andorhal.$B$BTime is never ending, and the watches you bring to me will invariably find themselves counted out back to their homes... that is, so long as the disturbances continue here.', `VerifiedBuild` = 12340 WHERE `ID` = 4972;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'The watches of Andorhal, much like the large clock on the ruins of the town hall, all are frozen in time at three o\'clock.  This was when the full effects of the plague first spread out over the city, choking the life out of it.$B$BAs much as we all may regret what happened that day, it has shaped the flow of time as you mortals perceive it.  The bronze dragonflight must persevere in protecting the timeline!', `VerifiedBuild` = 12340 WHERE `ID` = 4973;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = '<Thrall grunts.>', `VerifiedBuild` = 12340 WHERE `ID` = 4974;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'How goes your search for Tabetha and the orb, $N?$B$BTabetha has been more than useful when it comes to matters of the arcane. I\'m sure she would have no problem aiding you if you\'re able to find her.', `VerifiedBuild` = 12340 WHERE `ID` = 4976;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Any luck?', `VerifiedBuild` = 12340 WHERE `ID` = 4982;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'Where\'s the goblin???', `VerifiedBuild` = 12340 WHERE `ID` = 4983;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 0, `CompletionText` = 'On behalf of the Cenarion Circle, I bid you welcome to this enclave, $c.  What business do you have with us?', `VerifiedBuild` = 12340 WHERE `ID` = 4986;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 0, `CompletionText` = 'On behalf of the Cenarion Circle, I bid you welcome to this enclave, $C. What business do you have with us?', `VerifiedBuild` = 12340 WHERE `ID` = 4987;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Any luck?', `VerifiedBuild` = 12340 WHERE `ID` = 5001;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Are you here to seek the assistance of the Undercity census, or just to ask me if someone you knew is dead? I get asked that a lot.', `VerifiedBuild` = 12340 WHERE `ID` = 5023;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'How goes your search for the supplies, $N? I trust the quilboar fall under your strength easily.', `VerifiedBuild` = 12340 WHERE `ID` = 5041;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Yea?', `VerifiedBuild` = 12340 WHERE `ID` = 5047;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 18, `EmoteOnIncomplete` = 0, `CompletionText` = 'Every time someone steps on a cockroach, I cry. Please don\'t make me cry.', `VerifiedBuild` = 12340 WHERE `ID` = 5049;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 25, `CompletionText` = 'Brumeran calls out to you, $N.', `VerifiedBuild` = 12340 WHERE `ID` = 5055;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Shy-Rotam is bold and unforgiving; she will defend her kind with fervent enthusiasm.', `VerifiedBuild` = 12340 WHERE `ID` = 5056;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'So, Motega Firemane sends word of Arikara... well now that is grave news.$B$B<Magatha looks around.>$B$BArikara is a deadly creature born only to seek vengeance against those who have committed heinous acts.$B$B<Magatha smiles.>', `VerifiedBuild` = 12340 WHERE `ID` = 5062;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Unless you\'ve got everything I need, you\'re wasting my time.', `VerifiedBuild` = 12340 WHERE `ID` = 5063;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you discovered what the Grimtotem are up to?', `VerifiedBuild` = 12340 WHERE `ID` = 5064;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the tablets?  I fear their texts will reveal a great threat to our world.', `VerifiedBuild` = 12340 WHERE `ID` = 5065;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Unless you\'ve got everything I need, you\'re wasting my time.', `VerifiedBuild` = 12340 WHERE `ID` = 5067;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Unless you\'ve got everything I need, you\'re wasting my time.', `VerifiedBuild` = 12340 WHERE `ID` = 5068;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 0, `CompletionText` = 'I hope you found something, $N. The Winterfall are becoming increasingly aggressive!', `VerifiedBuild` = 12340 WHERE `ID` = 5085;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'I think we are beginning to uncover what is happening here, $N.', `VerifiedBuild` = 12340 WHERE `ID` = 5086;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'We\'ll see what happens when the Winterfall don\'t get their firewater!', `VerifiedBuild` = 12340 WHERE `ID` = 5087;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Have you slain the vicious serpent Arikara, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 5088;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'What have you got there, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 5089;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'Is it done?', `VerifiedBuild` = 12340 WHERE `ID` = 5102;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Now, what\'s this, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 5123;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 0, `CompletionText` = 'The Emerald Circle is friendly to all, $R. What can I do for you?', `VerifiedBuild` = 12340 WHERE `ID` = 5128;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Nature is a force that must be appeased before you hope to learn how to bend its will into your leather garments. Bring me your offering to this force, and I will make sure you are heard.', `VerifiedBuild` = 12340 WHERE `ID` = 5143;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'If you\'re ready to commit to a permanent decision by becoming a dragonscale leatherworker, then I\'m ready to take you on as a student. Just bring to me the things I asked for, and we\'ll begin your education.', `VerifiedBuild` = 12340 WHERE `ID` = 5145;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Making this kind of leather-based armor requires patience and dedication. Once you have cast your lot with the elements, there is no turning your back on them. Bring me proof of your worthiness, and we\'ll get started.', `VerifiedBuild` = 12340 WHERE `ID` = 5146;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Have you any news of that murderous Arnak Grimtotem?', `VerifiedBuild` = 12340 WHERE `ID` = 5147;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do you have my hypercapacitor?', `VerifiedBuild` = 12340 WHERE `ID` = 5151;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you find the book, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 5154;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'How goes your fight, $N? I know the shedding of blood as proof of honor can be disgusting to some, but you must understand that it serves two goals: you make my task easier by hurting their numbers, and we gain a respect for each other that will only make us stronger in times to come.$B$BI hope you understand.', `VerifiedBuild` = 12340 WHERE `ID` = 5155;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I hope your search goes well, $N. I haven\'t started heading that far north, but I will admit, the thought of crossing the path of an infernal at any point scares me just a little. The creatures are brainless, but still quite intimidating.', `VerifiedBuild` = 12340 WHERE `ID` = 5156;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Once we have the waters from the Moon Well, we will purify it and use it to extinguish the braziers of protection within Shadow Hold. That should allow me ample time to see into the chambers even deeper and discern who actually leads this... cult.$b$bI pray the Earthmother is with us.', `VerifiedBuild` = 12340 WHERE `ID` = 5157;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 0, `CompletionText` = 'I sense you are not just a simple traveler looking for the path to Ratchet. Come, sit and rest at our camp. Speak to me when you\'re ready.', `VerifiedBuild` = 12340 WHERE `ID` = 5158;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 0, `CompletionText` = 'Ah, I see you\'ve returned, $N. Good. Did you find Islen in the Barrens? Or do we have to find another way to accomplish our goals?', `VerifiedBuild` = 12340 WHERE `ID` = 5159;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 2, `CompletionText` = 'It is good to see you, $N.', `VerifiedBuild` = 12340 WHERE `ID` = 5160;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'I can\'t wait to hear how my friends react!$B$BThey\'ll never expect it!', `VerifiedBuild` = 12340 WHERE `ID` = 5163;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'The braziers must be extinguished if we are to have any hope of being prepared for a much greater battle. Going in to the dragon\'s lair without any knowledge is a fool\'s errand. And this is much worse than a dragon. The Shadow Council are solely responsible for a great number of crimes and atrocities. We\'ll have to work quickly if we\'re to stop them.', `VerifiedBuild` = 12340 WHERE `ID` = 5165;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 273, `EmoteOnIncomplete` = 273, `CompletionText` = 'You have chosen wisely, $R.', `VerifiedBuild` = 12340 WHERE `ID` = 5166;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Such an item has never been crafted!', `VerifiedBuild` = 12340 WHERE `ID` = 5167;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'The furbolgs seem to suffer from such paranoia...', `VerifiedBuild` = 12340 WHERE `ID` = 5201;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'I begin to wonder if I\'ll ever escape this cage.$b$bIt\'s only a matter of time before they sacrifice me to whatever demons they worship. The monsters!', `VerifiedBuild` = 12340 WHERE `ID` = 5202;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the skulls?  Chromie said they will be critical for her spell, and that spell will give us the chance to save Darrowshire.', `VerifiedBuild` = 12340 WHERE `ID` = 5206;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 5, `CompletionText` = 'The poor defenders of Darrowshire cry out to me in my dreams, $N. You must free them!', `VerifiedBuild` = 12340 WHERE `ID` = 5211;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'Some say I worry too much - to them I say, \'You don\'t worry enough!\'', `VerifiedBuild` = 12340 WHERE `ID` = 5212;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'We are on the verge of discovering what this new active plague agent may be!', `VerifiedBuild` = 12340 WHERE `ID` = 5213;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'I can\'t take it, $N! You gotta help me! I\'m dying!', `VerifiedBuild` = 12340 WHERE `ID` = 5214;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Welcome back to the relative safety of the Bulwark, $N. What progress on the cauldrons do you have to report?', `VerifiedBuild` = 12340 WHERE `ID` = 5230;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Without Fel\'dan, the Shadow Council will hopefully lose focus and start infighting. They will struggle with one another for control and hoard assets for future plans. That will be an opportune time to devastate them and their demon slaves.', `VerifiedBuild` = 12340 WHERE `ID` = 5242;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Be wary, not all supply crates will have survived the destruction of the city. The Scourge dare not touch the water but surely the holy water will not prevent vermin infestations.', `VerifiedBuild` = 12340 WHERE `ID` = 5243;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Why have you come here?', `VerifiedBuild` = 12340 WHERE `ID` = 5245;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'It is only in the pages of the sacred writings that I will be able to discern whether or not I can help you...', `VerifiedBuild` = 12340 WHERE `ID` = 5246;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'The relic must be placed in the hands of only the most trustworthy. It can not be stolen again...', `VerifiedBuild` = 12340 WHERE `ID` = 5247;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 5, `CompletionText` = 'Remember, $N - we must be tolerant yet rigid in our beliefs!', `VerifiedBuild` = 12340 WHERE `ID` = 5251;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'It has been some time since you left, $N. How have you fared?', `VerifiedBuild` = 12340 WHERE `ID` = 5252;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Yes, $R?', `VerifiedBuild` = 12340 WHERE `ID` = 5253;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 25, `EmoteOnIncomplete` = 0, `CompletionText` = 'What have you got there, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 5262;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'The Baron has slain more people than you have most likely seen in your lifetime.', `VerifiedBuild` = 12340 WHERE `ID` = 5263;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Ah, ain\'t nothing like a good forge tan. Ye can tell who\'s got the really good tans by their apron lines.', `VerifiedBuild` = 12340 WHERE `ID` = 5283;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = '<Ironus is busy stacking gold coins into neat little piles.>', `VerifiedBuild` = 12340 WHERE `ID` = 5284;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I will pound the steel until the breath itself has been taken from me.', `VerifiedBuild` = 12340 WHERE `ID` = 5301;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 4, `EmoteOnIncomplete` = 4, `CompletionText` = 'For the glory of the Horde!', `VerifiedBuild` = 12340 WHERE `ID` = 5302;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'His apron! Where is it?', `VerifiedBuild` = 12340 WHERE `ID` = 5305;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'Legend states that one use of Vosh\'gajin\'s snakestone will keep an axe razor sharp for a 1000 years!', `VerifiedBuild` = 12340 WHERE `ID` = 5306;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you forgotten what it is that you were tasked with, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 5307;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Has Kerlonian arrived?', `VerifiedBuild` = 12340 WHERE `ID` = 5321;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 25, `EmoteOnIncomplete` = 25, `CompletionText` = 'Bow your head in my presence, $r. I am a noble, after all, and you are a copperless peasant.', `VerifiedBuild` = 12340 WHERE `ID` = 5341;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Secure my fortune and share in the spoils.', `VerifiedBuild` = 12340 WHERE `ID` = 5342;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 25, `EmoteOnIncomplete` = 25, `CompletionText` = 'Bow your head in my presence, $R. I am a noble, after all, and you are a copperless peasant.', `VerifiedBuild` = 12340 WHERE `ID` = 5343;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You do want payment, do you not?', `VerifiedBuild` = 12340 WHERE `ID` = 5344;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'What news have you, $C! Ah - a message from my brother you say? Well then, hand over the report!', `VerifiedBuild` = 12340 WHERE `ID` = 5361;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = '$n, do you have the Demon Box?', `VerifiedBuild` = 12340 WHERE `ID` = 5381;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 5, `CompletionText` = 'The Butcher must be stopped!', `VerifiedBuild` = 12340 WHERE `ID` = 5382;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Be wary, Kirtonos is a seasoned fighter.', `VerifiedBuild` = 12340 WHERE `ID` = 5384;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'How did things go in Jaedenar, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 5385;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'My hoof tingles and my mouth starts to water when I think of fried Bloodbelly fish... You have any on you?', `VerifiedBuild` = 12340 WHERE `ID` = 5386;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'A Minion\'s Scourgestone is the insignia of the Scourge rank and file.  These are sometimes found on the weaker of their troops positioned in the Plaguelands, though the term \"weaker\" is certainly to be considered in context.  The Scourge, no matter where they are, should never be underestimated.$B$BThe Argent Dawn currently offers a valor token in exchange for twenty of these insignia - an exchange I\'m happy to do, provided you have earned enough scourgestones!', `VerifiedBuild` = 12340 WHERE `ID` = 5402;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'An Invader\'s Scourgestone is the insignia of the Scourge\'s elite troops.  These are sometimes found on the stronger of the troops positioned in the Plaguelands.  Slaying such a creature is indeed a challenge, but one that should be relished with a commission to vanquish evil.$B$BThe Argent Dawn currently offers a valor token in exchange for ten of these insignia.  Bring them to me here, and I will make sure you receive your just reward.', `VerifiedBuild` = 12340 WHERE `ID` = 5403;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'A Corruptor\'s Scourgestone is the insignia of the Scourge\'s overlords.  A powerful being that holds a position of authority over the Scourge will always possess one.  To slay such a malevolent creature would surely advance the cause of the Argent Dawn, and all good causes!$B$BOn behalf of the Argent Dawn, I will give you a valor token in exchange for just a single one these insignia.  Use caution in acquiring one, $N - such powerful beings are not to be trifled with.', `VerifiedBuild` = 12340 WHERE `ID` = 5404;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'A Corruptor\'s Scourgestone is the insignia of the Scourge\'s overlords.  A powerful being that holds a position of authority over the Scourge will always possess one.  To slay such a malevolent creature would surely advance the cause of the Argent Dawn, and all good causes!$B$BOn behalf of the Argent Dawn, I will give you a valor token in exchange for just a single one these insignia.  Use caution in acquiring one, $N - such powerful beings are not to be trifled with.', `VerifiedBuild` = 12340 WHERE `ID` = 5406;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'An Invader\'s Scourgestone is the insignia of the Scourge\'s elite troops.  These are sometimes found on the stronger of the troops positioned in the Plaguelands.  Slaying such a creature is indeed a challenge, but one that should be relished with a commission to vanquish evil.$B$BThe Argent Dawn currently offers a valor token in exchange for ten of these insignia.  Bring them to me here, and I will make sure you receive your just reward.', `VerifiedBuild` = 12340 WHERE `ID` = 5407;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'A Minion\'s Scourgestone is the insignia of the Scourge rank and file.  These are sometimes found on the weaker of their troops positioned in the Plaguelands, though the term \"weaker\" is certainly to be considered in context.  The Scourge, no matter where they are, should never be underestimated.$B$BThe Argent Dawn currently offers a valor token in exchange for twenty of these insignia - an exchange I\'m happy to do, provided you have earned enough scourgestones!', `VerifiedBuild` = 12340 WHERE `ID` = 5408;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I\'ll reward anyone who makes my life a bit easier... I enjoy doing as little as possible, mon!$B$BBelow the docks here in Shadowprey Village, I\'ve many shellfish traps.  If you\'re kind enough to do my work and collect me my shellfish, then I\'ll reward you with something you want... get my drift mon?  For every five shellfish you bring me I will give you a fine Bloodbelly fish!', `VerifiedBuild` = 12340 WHERE `ID` = 5421;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'A keepsake of remembrance is a rare find, $N.', `VerifiedBuild` = 12340 WHERE `ID` = 5461;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 274, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do not ask questions of which you do not want answers.', `VerifiedBuild` = 12340 WHERE `ID` = 5462;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = '<Leonid shudders.>', `VerifiedBuild` = 12340 WHERE `ID` = 5464;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Have you done the impossible?', `VerifiedBuild` = 12340 WHERE `ID` = 5465;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'You carry the burden of ten thousand restless souls, $N.', `VerifiedBuild` = 12340 WHERE `ID` = 5466;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Where\'s that useless abomination? Either you have what I need or you\'d best get out there and find it.', `VerifiedBuild` = 12340 WHERE `ID` = 5481;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'This had better be good. I trust you have all of the doom weed that I require?', `VerifiedBuild` = 12340 WHERE `ID` = 5482;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do you have the bones?  The caravan will be here any moment.  I need just ten more kodo bones to reach a career high.  A career high, I tell you!', `VerifiedBuild` = 12340 WHERE `ID` = 5501;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'A Corruptor\'s Scourgestone is the insignia of the Scourge\'s overlords.  A powerful being that holds a position of authority over the Scourge will always possess one.  To slay such a malevolent creature would surely advance the cause of the Argent Dawn, and all good causes!$B$BOn behalf of the Argent Dawn, I will give you a valor token in exchange for just a single one of these insignia.  Use caution in acquiring one, $N - such powerful beings are not to be trifled with.', `VerifiedBuild` = 12340 WHERE `ID` = 5508;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'An Invader\'s Scourgestone is the insignia of the Scourge\'s elite troops.  These are sometimes found on the stronger of the troops positioned in the Plaguelands.  Slaying such a creature is indeed a challenge, but one that should be relished with a commission to vanquish evil.$B$BThe Argent Dawn currently offers a valor token in exchange for ten of these insignia.  Bring them to me here, and I will make sure you receive your just reward.', `VerifiedBuild` = 12340 WHERE `ID` = 5509;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'A Minion\'s Scourgestone is the insignia of the Scourge rank and file.  These are sometimes found on the weaker of their troops positioned in the Plaguelands, though the term \"weaker\" is certainly to be considered in context.  The Scourge, no matter where they are, should never be underestimated.$B$BThe Argent Dawn currently offers a valor token in exchange for twenty of these insignia - an exchange I\'m happy to do, provided you have earned enough scourgestones!', `VerifiedBuild` = 12340 WHERE `ID` = 5510;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'You are the one up to mischief in Blackrock Spire, yes? Do you have what I asked for?', `VerifiedBuild` = 12340 WHERE `ID` = 5522;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 3, `EmoteOnIncomplete` = 0, `CompletionText` = 'Hello, $N! I heard you were here with some dragon eggs? Well, let\'s see them!', `VerifiedBuild` = 12340 WHERE `ID` = 5531;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'As morbid as it sounds, we\'ll need a decent supply of suitable skeletal fragments to make up the outer layer of the key.  They don\'t call it a Skeleton Key for nothing, you know.', `VerifiedBuild` = 12340 WHERE `ID` = 5537;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'I hope you\'re not here for ammo, because I\'m almost out!', `VerifiedBuild` = 12340 WHERE `ID` = 5541;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'You will grow to tolerate the taste, $r.', `VerifiedBuild` = 12340 WHERE `ID` = 5544;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'That deadline isn\'t getting any further away, $C. Please hurry and collect those bundles of wood.', `VerifiedBuild` = 12340 WHERE `ID` = 5545;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'The caravan will be here shortly; do you have the five new tamed kodos I was asking for?', `VerifiedBuild` = 12340 WHERE `ID` = 5561;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you banished the demon portals at Mannoroc Coven?', `VerifiedBuild` = 12340 WHERE `ID` = 5581;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'As you may have already learned, our healing magics are vital to the survival of our people in these harsh times--especially to adventurers and heroes who take up arms and magic to fight back so many different threats.$B$BYou would do well to always remember how important that skill is. That, coupled with Fortitude, make your companions far more capable in battle since they will be able to stand up to a greater number of blows.$B$BDo not let anyone dismiss how powerful your magics are.', `VerifiedBuild` = 12340 WHERE `ID` = 5624;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the insignia yet, $N?$b$bIt will be a vital tool in you infiltrating what I believe is the greatest threat to the Horde and us finally finding peace in our new home.$b$bYou will learn how intricate a web men and orcs alike can weave when they are motivated by greed and power. The hidden agendas, the corruption, all of it will become clear. You will find yourself in the midst of a war you never knew existed.', `VerifiedBuild` = 12340 WHERE `ID` = 5726;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'Well, $c? Does he believe our ploy, or are things worse than I had first estimated?$b$bProving valuable to Neeru will make our infiltration of the Shadow Council much easier. He will have plenty of information that we can use to route out those who would destroy all we have built in Durotar.', `VerifiedBuild` = 12340 WHERE `ID` = 5727;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the Sceptre of Light?', `VerifiedBuild` = 12340 WHERE `ID` = 5741;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Is that desert dust on your collar?$b$bHm... if my nose tells true, I\'d say it\'s not desert dust, it\'s desert salt!  Been to the Shimmering Flats, have you?', `VerifiedBuild` = 12340 WHERE `ID` = 5762;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Sit, $C. Soon enough you\'ll strike back into the jungle.', `VerifiedBuild` = 12340 WHERE `ID` = 5763;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'He must be redeemed.', `VerifiedBuild` = 12340 WHERE `ID` = 5781;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do you have the stem of the skeletal key finished? I\'m truly sorry you had to bear the brunt of the fee to purchase the mold, but we must all do our part to counter the Scourge. Once you hand me the unfinished key, you\'ll be ready for the final item needed to complete its construction.$b$bIt won\'t be easy at all, but the work you\'ve done to date in preparing for an assault on Andorhal will now start to pay for itself. You\'ll see.', `VerifiedBuild` = 12340 WHERE `ID` = 5801;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do you have the stem of the skeletal key finished? I\'m truly sorry you had to bear the brunt of the fee to purchase the mold, but we must all do our part to counter the Scourge. Once you hand me the unfinished key, you\'ll be ready for the final item needed to complete its construction.$b$bIt won\'t be easy at all, but the work you\'ve done to date in preparing for an assault on Andorhal will now start to pay for itself. You\'ll see.', `VerifiedBuild` = 12340 WHERE `ID` = 5802;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'You\'ve come this far $N - only the destruction of the physical form of Araj the Summoner will provide us with the means to finish the key. Get Araj\'s scarab, by hook or by crook, and bring it to me - I will fuse it on as the head of the key.', `VerifiedBuild` = 12340 WHERE `ID` = 5803;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'You\'ve come this far $N - only the destruction of the physical form of Araj the Summoner will provide us with the means to finish the key. Get Araj\'s scarab, by hook or by crook, and bring it to me - I will fuse it on as the head of the key.', `VerifiedBuild` = 12340 WHERE `ID` = 5804;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'My faith will guide you, $N. The Light knows no bounds.', `VerifiedBuild` = 12340 WHERE `ID` = 5845;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'The painting, $N. Do you have the painting?', `VerifiedBuild` = 12340 WHERE `ID` = 5848;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 0, `CompletionText` = 'I knew this day would come.', `VerifiedBuild` = 12340 WHERE `ID` = 5861;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 25, `EmoteOnIncomplete` = 0, `CompletionText` = 'Are you the reinforcements from Tyr\'s Hand?', `VerifiedBuild` = 12340 WHERE `ID` = 5862;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Possessing a Cenarion Beacon allows one to sea a corrupted soul shard on those tainted beasts that are put down for the greater good. I grind shards into a usable reagent that goes into making Cenarion plant salve. We will use that salve to turn corrupted plants into healthy ones again.$b$bIn exchange for these shards, I will give you some Cenarion plant salves I have already prepared.', `VerifiedBuild` = 12340 WHERE `ID` = 5882;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Possessing a Cenarion beacon allows one to see a corrupted soul shard on those tainted beasts that are put down for the greater good.  I grind shards into a usable reagent that goes into making Cenarion plant salve.  We will use that salve to turn corrupted plants into healthy ones again.$B$BIn exchange for these shards, I will give you some Cenarion plant salves I have already prepared.', `VerifiedBuild` = 12340 WHERE `ID` = 5887;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the termites yet, $N? I am sure it is obvious to a smart $C like yourself.$B$BOnce we have enough of them, we\'ll make sure no one can use the lumber mill ever again!', `VerifiedBuild` = 12340 WHERE `ID` = 5901;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you find the termite mounds, $N? I\'ve heard they are all over Plaguewood.', `VerifiedBuild` = 12340 WHERE `ID` = 5903;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'You must continue to prove yourself, $N.', `VerifiedBuild` = 12340 WHERE `ID` = 5981;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Are you crying? If this is too \'tedious\' for you, \'hero,\' I recommend that you head back to the Dark Lady and inform her of the horrible mistreatment you received at my farmstead.$b$bNow get out of my sight!', `VerifiedBuild` = 12340 WHERE `ID` = 6022;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you found them yet, $N? With the two of them taken care of, I can proceed to enter Hearthglen to take a closer look at their setup. I can\'t do it without your help. Please, find Radley and Durgen for me.', `VerifiedBuild` = 12340 WHERE `ID` = 6023;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'It\'s a dangerous task, $n. I envy your courage.', `VerifiedBuild` = 12340 WHERE `ID` = 6025;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Trust ol\' Smokey, $r. The reward will be worth it. These Argent Dawn folk don\'t mess around when it comes to payment.\n', `VerifiedBuild` = 12340 WHERE `ID` = 6026;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Ah, $N! It\'s good to see you again. Do you have the Book of the Ancients?', `VerifiedBuild` = 12340 WHERE `ID` = 6027;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 66, `EmoteOnIncomplete` = 0, `CompletionText` = 'Greetings, $N. On behalf of the Argent Dawn, I offer you safety and shelter while you are here at Chillwind Camp. I might also have some work for you...', `VerifiedBuild` = 12340 WHERE `ID` = 6028;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 66, `EmoteOnIncomplete` = 0, `CompletionText` = 'Greetings, $C.  On behalf of the Argent Dawn, I offer you safety and shelter while you are here at Bulwark.  I might also offer you the chance to fight for a cause that\'s worth fighting for!', `VerifiedBuild` = 12340 WHERE `ID` = 6029;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 0, `CompletionText` = 'May the Light guide you in these troubling times, $C. What brings you here to this beacon of hope in the middle of darkness and despair?', `VerifiedBuild` = 12340 WHERE `ID` = 6030;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Have you brought the mooncloth, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 6032;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I got supplies left over to make a few more sticks of the special compound. Just let ol\' Smokey know if you need more.', `VerifiedBuild` = 12340 WHERE `ID` = 6041;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'It could have been worse. I could have had you collecting bat guano.$B$B<Nathanos stares at you in contemplation.>$B$BHrm... Hey! Wait a minute. Where are you going?', `VerifiedBuild` = 12340 WHERE `ID` = 6042;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Good luck, young $C.', `VerifiedBuild` = 12340 WHERE `ID` = 6062;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Don\'t worry, lass! You\'ll get ta try a few before you\'ll need to decide on just one.', `VerifiedBuild` = 12340 WHERE `ID` = 6064;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Were you able to tame the scorpid?', `VerifiedBuild` = 12340 WHERE `ID` = 6082;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'You need to practice in order to gain the skills you need to effectively control your pet. Have you tamed a surf crawler?', `VerifiedBuild` = 12340 WHERE `ID` = 6083;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'What do you think of the snow leopard, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 6084;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you tamed the ice claw bear yet?', `VerifiedBuild` = 12340 WHERE `ID` = 6085;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do not leave me waiting, $C.', `VerifiedBuild` = 12340 WHERE `ID` = 6133;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Where\'s my ghost-o-plasm, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 6134;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I would not recommend that you take on this challenge alone, $c.', `VerifiedBuild` = 12340 WHERE `ID` = 6135;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have I told you lately that I hate you?', `VerifiedBuild` = 12340 WHERE `ID` = 6136;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 0, `CompletionText` = 'This is unacceptable, soldier!', `VerifiedBuild` = 12340 WHERE `ID` = 6146;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the beast\'s claw yet, $N? It will pay for its crimes. I don\'t care if it\'s corrupt or just angry for living in such a dismal forest. No furbolg will live for long committing such crimes against my family!', `VerifiedBuild` = 12340 WHERE `ID` = 6162;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'After Sylvanas freed me, I hunted the beast across these wastes for months. It fled to the safety of Stratholme. The bastard...', `VerifiedBuild` = 12340 WHERE `ID` = 6163;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'You look like you\'re in a hurry. Well, then you came to the right place!', `VerifiedBuild` = 12340 WHERE `ID` = 6181;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = '<King Varian Wrynn is lost in thought.>', `VerifiedBuild` = 12340 WHERE `ID` = 6187;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'You\'ve been traveling, eh? Have you been anywhere interesting?', `VerifiedBuild` = 12340 WHERE `ID` = 6281;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Do not be weary of Charred Vale; many evil creatures reside in those hills. Stay strong $N, and you shall prevail over this threat to our people. Go now and strike hard - our children shall never know of the evil of what was.', `VerifiedBuild` = 12340 WHERE `ID` = 6282;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Bloodfury Ripper is a nasty creature! You will have success finding her along the western hill line in the Charred Vale.$b$bThe bloodfuries will be helpless with out... surely we can vanquish them forever!', `VerifiedBuild` = 12340 WHERE `ID` = 6283;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Besseleth is a ruthless predator... I fear for those that travel Webwinder Path at night. It\'s then that she and her children prey upon innocent travelers. I myself fell prey to her two-foot fang of death, but luckily I was able to fend her off and get to safety. I would give anything to see that monster destroyed.', `VerifiedBuild` = 12340 WHERE `ID` = 6284;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'You\'re back from Stormwind? Did Osric send the armor?', `VerifiedBuild` = 12340 WHERE `ID` = 6285;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'The continuous destruction caused by war and those that seek a profit from lumber pains me deeply. To aid the cycle of rebirth and replenish the lands, I need Gaea seeds. Do you have them, $C?', `VerifiedBuild` = 12340 WHERE `ID` = 6301;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'You appear to be on official business...', `VerifiedBuild` = 12340 WHERE `ID` = 6321;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'I keep my weapons in top condition. They are cleaned and ready for use.', `VerifiedBuild` = 12340 WHERE `ID` = 6323;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = '$N, you return. Do you have our supplies from the Undercity?', `VerifiedBuild` = 12340 WHERE `ID` = 6324;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = '', `VerifiedBuild` = 12340 WHERE `ID` = 6344;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'You need to get somewhere fast? Then you\'re talking to the right orc!', `VerifiedBuild` = 12340 WHERE `ID` = 6365;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'These seeds you plant are strong, resisting corruption, and making a foothold for other life. They will grow and grow, first preventing corruption and healing the scarred land, and then one day, restoring Stonetalon to a lush forest, once again.$b$bHave you planted all of the Gaea seeds?', `VerifiedBuild` = 12340 WHERE `ID` = 6381;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Something smells good! You don\'t have raw meat on you, do you?', `VerifiedBuild` = 12340 WHERE `ID` = 6384;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do you need one of my wind riders?', `VerifiedBuild` = 12340 WHERE `ID` = 6385;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Have you returned from Orgrimmar? Did Gryshka like the meat I sent her?', `VerifiedBuild` = 12340 WHERE `ID` = 6386;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Have you had your fill of Thelsamar so soon? Are you ready to leave for another city?', `VerifiedBuild` = 12340 WHERE `ID` = 6387;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'You look like you have somewhere to go. Need one of my gryphons?', `VerifiedBuild` = 12340 WHERE `ID` = 6388;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you done it, $N? Have you released the termites in the lumber mill?$B$BIt was bad enough that my family lost their jobs and lives, but then to see the place where my childhood was spent taken over by those disgusting so-called holy men... pfah!!', `VerifiedBuild` = 12340 WHERE `ID` = 6390;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'What can I do for you, sir?', `VerifiedBuild` = 12340 WHERE `ID` = 6391;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Ah, $N. Have you returned from Ironforge?', `VerifiedBuild` = 12340 WHERE `ID` = 6392;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Have you entered the Burning Blade Coven, $N? Did you find my pick?', `VerifiedBuild` = 12340 WHERE `ID` = 6394;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'We must respect our dead, $N. It is one of the ways in which we differ from the Scourge...', `VerifiedBuild` = 12340 WHERE `ID` = 6395;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'What news have you discovered from Boulderslide Ravine? I recall some legend that deals with Resonite... I just cannot place my hoof on it. Perhaps knowing what lies at the bottom of the cave will illuminate their devious intentions.', `VerifiedBuild` = 12340 WHERE `ID` = 6421;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'I hope you can be quick about getting those horns, $N. I\'m heading back to Ratchet soon!', `VerifiedBuild` = 12340 WHERE `ID` = 6441;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'Hey mon, have you slain the hairy blood feeders? I fear none here in Stonetalon but I don\'t go walking around here at night... if you know what I mean mon!$b$bAs long as I stay off their dinner plate then all is well.$b$bGood luck to you, $c!', `VerifiedBuild` = 12340 WHERE `ID` = 6461;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 14, `EmoteOnIncomplete` = 14, `CompletionText` = 'Did you find the charms, $N?  Every moment the furbolgs possess those sacred items, my blood boils with rage!', `VerifiedBuild` = 12340 WHERE `ID` = 6462;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I fear if we do not dispose of this threat immediately, all of Stonetalon will be lost. The might of an Earthen can not be matched by any means. When awakened, Goggeroc will be weak from his long slumber, this will be the opportunity that you must take advantage of... go now $N!', `VerifiedBuild` = 12340 WHERE `ID` = 6481;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you seen my brother Ruul? He walked into the forest days ago and has not returned...', `VerifiedBuild` = 12340 WHERE `ID` = 6482;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'So you\'re here with my orders? Always good to see a new recruit with an exuberant nature and a strong will.$B$BYou\'d best learn fast if you expect to keep up here. The threat of the naga grows, $N. I have observed and have taken up defenses against several attacks on this outpost since I arrived here.$B$BBut if you\'d like to pitch in with that effort, speak with one of the others here at the outpost.', `VerifiedBuild` = 12340 WHERE `ID` = 6545;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Much danger lies along this path, $N. You\'d do best to remember this while traveling in these lands. The threat of the alliance is quite near.$B$BWe are faced by enemies on all fronts. The satyr are a formidable and prevalent force in eastern Ashenvale. I have also discovered that the naga have taken over a large area of the land of Azshara.$B$BIt\'s good to see that we are still bolstering our numbers -- be ready for what lies ahead, $N.', `VerifiedBuild` = 12340 WHERE `ID` = 6546;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Keep an eye out, $R. The elves are often hiding in the shadows...$B$BWe must always be watching. We have worked very hard to claim this land, and the elves are looking for a chance to take it from us.$B$BI assume you have my next orders from Kadrak?', `VerifiedBuild` = 12340 WHERE `ID` = 6547;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you killed them yet?', `VerifiedBuild` = 12340 WHERE `ID` = 6548;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'How goes your search for the crystals, $N? Have you witnessed the naga harvesting them? I pray to my ancestors we find the reason they are collecting such things.', `VerifiedBuild` = 12340 WHERE `ID` = 6563;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Yes, $N? What is it you need? There is still much I must learn about the crystals the naga are gathering.', `VerifiedBuild` = 12340 WHERE `ID` = 6564;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 5, `CompletionText` = 'Have you found him yet, $N? Lorgus must be stopped!', `VerifiedBuild` = 12340 WHERE `ID` = 6565;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 11, `EmoteOnIncomplete` = 11, `CompletionText` = 'The eyes of that which we wish to mimic are the most important ingredient of any illusion, $N.$B$B<Myranda points to a bag almost overflowing with eyeballs labeled \'Scarlet Crusade.\'>$B$B<Myranda laughs.>', `VerifiedBuild` = 12340 WHERE `ID` = 6569;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I hope you can come through with the supplies!', `VerifiedBuild` = 12340 WHERE `ID` = 6571;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = '<Emberstrife hisses.>', `VerifiedBuild` = 12340 WHERE `ID` = 6582;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 15, `EmoteOnIncomplete` = 15, `CompletionText` = 'Do not return here until you have bathed in the blood of our enemies and drank in their suffering.', `VerifiedBuild` = 12340 WHERE `ID` = 6583;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Ironically, whelp, time is of the essencccce.', `VerifiedBuild` = 12340 WHERE `ID` = 6584;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Changesss... I sense them taking place in you, whelp. Pass this test and only ceremony remains.', `VerifiedBuild` = 12340 WHERE `ID` = 6585;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I don\'t think I need to tell you that Drakkisath is not to be taken lightly.$B$BI let the thousands dead by his hand do the talking.', `VerifiedBuild` = 12340 WHERE `ID` = 6602;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Anything bitin\' today?', `VerifiedBuild` = 12340 WHERE `ID` = 6607;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'My cravings are going to be the end of me! Hurry, $N - before I dip into my own supply.', `VerifiedBuild` = 12340 WHERE `ID` = 6610;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you defeat Chief Murgut, $N? Did you retrieve his Foulweald Totem?', `VerifiedBuild` = 12340 WHERE `ID` = 6621;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Life is full of questions, $C. You will never be able to answer all of them, but with some time and study, perhaps you will become a little more knowledgeable.', `VerifiedBuild` = 12340 WHERE `ID` = 6627;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'There is only one rule I feel you must know if you wish to survive in this world: the more you know, the more you\'ll see.$b$bIf you study, if you observe, then you will begin to see things in the world that no other $r will see.', `VerifiedBuild` = 12340 WHERE `ID` = 6628;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you killed Grundig Darkcloud and his personal band of Brutes?', `VerifiedBuild` = 12340 WHERE `ID` = 6629;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'Yarrr... Swabby, what be takin\' ye so long?', `VerifiedBuild` = 12340 WHERE `ID` = 6661;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = '<Nipsy puts his index finger through one of the air holes in the carton.>$b$bAlive and kicking... and just in time!', `VerifiedBuild` = 12340 WHERE `ID` = 6662;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you been successful in locating the fathom core?  Without it we\'ll have no idea what the Twilight\'s Hammer is exactly up to down there.', `VerifiedBuild` = 12340 WHERE `ID` = 6921;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 0, `CompletionText` = 'Hello, $R. What can I do for you?', `VerifiedBuild` = 12340 WHERE `ID` = 6981;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Miniaturization residue, I assure you, is a valuable commodity when it comes to engineering!  Well, it is valuable in that it helps me make sure the zapper won\'t do something as disappointing as explode on the user.$B$BOh, I mean for the zappers other than the one I gave you.  Absolutely!', `VerifiedBuild` = 12340 WHERE `ID` = 7003;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 25, `EmoteOnIncomplete` = 25, `CompletionText` = 'Don\'t ask questions!$B$BYou have my request.', `VerifiedBuild` = 12340 WHERE `ID` = 7028;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'If you are able to heal the plant, it will again begin to grow. We must do what we can, $N...', `VerifiedBuild` = 12340 WHERE `ID` = 7029;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'If you are able to heal the plant, it will again begin to grow. We must do what we can, $N...', `VerifiedBuild` = 12340 WHERE `ID` = 7041;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you made the trip yet? I realize it\'d be quite dangerous, but if you were successful, it would very much be worth it.', `VerifiedBuild` = 12340 WHERE `ID` = 7070;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 5, `CompletionText` = '$N, you have not yet assaulted a graveyard. Return to me when this task is complete!', `VerifiedBuild` = 12340 WHERE `ID` = 7081;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 5, `CompletionText` = 'You haven\'t yet assaulted a tower, $N! What are you waiting for?', `VerifiedBuild` = 12340 WHERE `ID` = 7102;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 5, `CompletionText` = 'You haven\'t captured the mine yet, $N!$B$BAfter we control a mine, it will be much easier to gather minerals and supplies from it.', `VerifiedBuild` = 12340 WHERE `ID` = 7122;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'Beware the harpies of the region, $C. They\'ll not think twice to rip out your throat!', `VerifiedBuild` = 12340 WHERE `ID` = 7162;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Most do not live long enough to rise above their own mediocrity. You have proven yourself to be an exemplary soldier, $c. The time has come.$B$BPresent your insignia.', `VerifiedBuild` = 12340 WHERE `ID` = 7168;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'The base buzzes with news of your exploits in the Field of Strife! You have struck mighty blows against our enemy - crushing their morale! For this, you have earned a rank of honor among the Stormpike.$B$BPresent your insignia.', `VerifiedBuild` = 12340 WHERE `ID` = 7169;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'I must know, $n. When you look directly into the eyes of the enemy, do you see fear? Do they now cower in your presence? They must realize that they are defeated!$B$BYou have earned reverence among the Guard. Present your insignia!', `VerifiedBuild` = 12340 WHERE `ID` = 7170;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 66, `EmoteOnIncomplete` = 66, `CompletionText` = 'Before me stands an exalted hero of the Alliance.$B$B<Lieutenant Haggerdin salutes.>$B$BFew have earned such a rank among the Stormpike. I have watched the enemy fall before you. I have seen their resolve crumble in your presence. When you enter the fray, you become the beacon of hope for our forces!$B$BPresent your insignia.', `VerifiedBuild` = 12340 WHERE `ID` = 7171;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'Let them hear your voice, commander $n! Let them know fear. Show them what power the Stormpike holds in their rank!$B$BPresent your insignia.', `VerifiedBuild` = 12340 WHERE `ID` = 7172;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'Show them to me!', `VerifiedBuild` = 12340 WHERE `ID` = 7201;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Any luck finding the ingredients?  I\'ll tell you, the alliance maggots are far too numerous in this area now... In my opinion, they have come far too close already...', `VerifiedBuild` = 12340 WHERE `ID` = 7321;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'Can you believe this rubbish?! The last shipment of ammunition from Kharanos was botched! All we have for ammo now are these flimsy, good for nothing arrows! What in the world am I going to do with 500,000 thorium headed arrows?$b$bI\'ll tell you what, kid. If you can bring me thorium shells, I\'ll trade you thorium headed arrows - straight up! Deal?', `VerifiedBuild` = 12340 WHERE `ID` = 7342;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Along with the druids, the Oracle Tree and the Arch Druid have been carefully monitoring the growth of Teldrassil. But though we have a new home, our immortal lives have not been restored.', `VerifiedBuild` = 12340 WHERE `ID` = 7383;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the web, $N?  Its concentrated magical energy must be dissipated!', `VerifiedBuild` = 12340 WHERE `ID` = 7488;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you seen the raging owl beasts, $N? The magic of those creatures is strong, and it concentrates in the blood that flows through their torturted forms.', `VerifiedBuild` = 12340 WHERE `ID` = 7563;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'You have something for me?  It\'s not a big, juicy spider, is it?  Or maybe a roach?  I hope it\'s still alive... I so love chewing on them when they\'re still alive...', `VerifiedBuild` = 12340 WHERE `ID` = 7564;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Only the blood of Wildspawn satyr will suffice.', `VerifiedBuild` = 12340 WHERE `ID` = 7581;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'The Hederine will not give up their precious gems without a fight, $N.', `VerifiedBuild` = 12340 WHERE `ID` = 7582;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Hrm? Well?', `VerifiedBuild` = 12340 WHERE `ID` = 7583;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you get lost?', `VerifiedBuild` = 12340 WHERE `ID` = 7603;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 15, `EmoteOnIncomplete` = 15, `CompletionText` = 'I can already taste the heart of Ulathek on my lips. So sweet is the flesh of a traitor...', `VerifiedBuild` = 12340 WHERE `ID` = 7624;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you been to Jaedenar, $N? Did you get the stardust from Lord Banehollow?', `VerifiedBuild` = 12340 WHERE `ID` = 7625;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You have those elixirs, $N? Mor\'zul told me you need a Bell of Dethmoora, and making one of those takes a lot of shadow power!', `VerifiedBuild` = 12340 WHERE `ID` = 7626;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'The Wheel of the Black March isn\'t easy to make, and takes a lot of materials. Have you gathered them yet?', `VerifiedBuild` = 12340 WHERE `ID` = 7627;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you bring the dragonscales, $N? I don\'t want to start on the candle until I have them... or I might blow up the whole camp!', `VerifiedBuild` = 12340 WHERE `ID` = 7628;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you been to the Scholomance, $N? Has the imp yet infused the parchment with the stardust?', `VerifiedBuild` = 12340 WHERE `ID` = 7629;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the arcanite, $N? Once I have it I can make you the black lodestone.', `VerifiedBuild` = 12340 WHERE `ID` = 7630;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 0, `CompletionText` = 'Welcome back, $N. Have you acquired the exorcism censer?', `VerifiedBuild` = 12340 WHERE `ID` = 7639;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'It is good to see you again $N. Is your work done in Terrordale?', `VerifiedBuild` = 12340 WHERE `ID` = 7640;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Ah, $C. I won\'t be able to finish your barding without the things I mentioned. Have you gotten everything together?', `VerifiedBuild` = 12340 WHERE `ID` = 7642;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = '$N, you\'re back! Were you able to successfully deal with Merideth Carlson and Tendris Warpwood?  Honestly, I\'m not sure which one is a greater threat at times...', `VerifiedBuild` = 12340 WHERE `ID` = 7644;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'Yes, I\'ve proved you wrong now, haven\'t I? I\'ve proved them all wrong! I WAS RIGHT ALL ALONG!!!', `VerifiedBuild` = 12340 WHERE `ID` = 7645;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'You have come so very far, $N. Your final act of worldly-item sacrifice will be the genesis for one of your greatest accomplishments. I can feel it in the very fiber of my being!', `VerifiedBuild` = 12340 WHERE `ID` = 7646;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'For the belt plans, I\'ll be needin\' 10 thorium bars.', `VerifiedBuild` = 12340 WHERE `ID` = 7653;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 11, `EmoteOnIncomplete` = 11, `CompletionText` = 'For the boot plans, I\'ll be needin\' 20 thorium bars. Yep, 20. Are you gonna cry? Would you like a hanky?$B$B<Derotain laughs.>', `VerifiedBuild` = 12340 WHERE `ID` = 7654;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'For the bracer plans, I\'ll be needin\' 10 thorium bars.$B$BAre you alright, sonny? Yer getting\' all red.', `VerifiedBuild` = 12340 WHERE `ID` = 7655;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'For the chest piece plans, I\'ll be needin\' 30 thorium bars.$B$BOh boy, there you go again. Are you gonna be runnin\' to yer blue Gods, askin\' why they have forsaken you?!? Toughen up, Nancy! Nobody ever said life\'s fair.', `VerifiedBuild` = 12340 WHERE `ID` = 7656;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Just hand over 25 thorium bars and the helm plans are yers.', `VerifiedBuild` = 12340 WHERE `ID` = 7657;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Just hand over 30 thorium bars and the leg plans are yers.$B$BI know, I\'m driving you into bankruptcy! I\'ve heard it all before so you can save your sob story, weakling.', `VerifiedBuild` = 12340 WHERE `ID` = 7658;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'For the shoulder plans, I\'ll be needin\' 10 thorium bars.', `VerifiedBuild` = 12340 WHERE `ID` = 7659;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 34, `EmoteOnIncomplete` = 34, `CompletionText` = 'Can\'t ya shee I\'m bushy? What *hic* ish it ya be wantin? *hic*', `VerifiedBuild` = 12340 WHERE `ID` = 7701;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'While I could bore you with the technical details of the utility behind elemental cores, I will instead tempt you to completion of this important task by offering valuable coin and prizes for doing so.  Yon verily, are you finished?', `VerifiedBuild` = 12340 WHERE `ID` = 7721;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you find the plans?', `VerifiedBuild` = 12340 WHERE `ID` = 7722;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did ye pound \'em?', `VerifiedBuild` = 12340 WHERE `ID` = 7723;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'Was he right? Does it come out their rumps?', `VerifiedBuild` = 12340 WHERE `ID` = 7724;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Ah, the fruits of research and utilization in the form of sweet, sweet residue.  Well, that is to say, I don\'t taste it or anything when I study it.$B$BMuch.', `VerifiedBuild` = 12340 WHERE `ID` = 7725;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you managed to find the elemental cores I need?', `VerifiedBuild` = 12340 WHERE `ID` = 7726;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'If you\'re here for the reward, you\'re gonna have to give me the stolen goods.', `VerifiedBuild` = 12340 WHERE `ID` = 7728;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'We\'re gonna need to weigh you with and without clothes to be sure.', `VerifiedBuild` = 12340 WHERE `ID` = 7729;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'How goes the hunt, $N?  Are you here to report your success?', `VerifiedBuild` = 12340 WHERE `ID` = 7730;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you managed to bring down Stinglasher yet?', `VerifiedBuild` = 12340 WHERE `ID` = 7731;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Greetings friend... you look as though you are on urgent business.  Is there something I can help you with?', `VerifiedBuild` = 12340 WHERE `ID` = 7732;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'If these Rage Scar yeti hides are anything like the quality displayed by their Feral Scar counterparts, they could very well be as resilient as thorium!$B$BImagine that!', `VerifiedBuild` = 12340 WHERE `ID` = 7733;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'If these Rage Scar yeti hides are anything like the quality displayed by their Feral Scar counterparts, they could very well be as resilient as thorium!$B$BImagine that!', `VerifiedBuild` = 12340 WHERE `ID` = 7734;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'What\'s this, $N - you\'ve got something special for me?', `VerifiedBuild` = 12340 WHERE `ID` = 7735;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Let\'s not waste more of my precious time with jibber jabber, $r. It\'s time to focus on replenishing our dwindling fiery flux supply.$B$BWhat I\'m gonna need from you is the following:$B$B*Incendosaur scales.$B$B*Kingsblood.$B$B*Coal.$B$BI\'ll take all that you can offer!$B$BAnd you\'ll do it fast if you wanna get in good with the Brotherhood.', `VerifiedBuild` = 12340 WHERE `ID` = 7736;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'What\'s this, $N - you\'ve got something special for me?', `VerifiedBuild` = 12340 WHERE `ID` = 7738;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'If you have the sixty pieces of wool cloth on you and are ready to donate them, I\'m able to take them from you now.', `VerifiedBuild` = 12340 WHERE `ID` = 7791;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'If you have the sixty pieces of wool cloth on you and are ready to donate them, I\'m able to take them from you now.', `VerifiedBuild` = 12340 WHERE `ID` = 7792;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'A benevolent gift such as silk, might I add, would certainly increase your local standing in the community! If you have the sixty pieces of silk cloth on you and are ready to donate them, I\'m able to take them from you now.', `VerifiedBuild` = 12340 WHERE `ID` = 7793;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'If you have the sixty pieces of mageweave cloth on you and are ready to donate them, I\'m able to take them from you now.', `VerifiedBuild` = 12340 WHERE `ID` = 7794;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = '$n, you\'ve been a tremendous contributor to our cloth drive. As we work hard to replenish our reserves, one form of cloth remains critically low - runecloth. We are in absolutely dire need of it, and we hope that you will be able to help us as you have in the past!$b$bIf you are willing, please bring me what runecloth you can spare. We\'ll initially accept a single donation of sixty, and then we\'ll go from there.', `VerifiedBuild` = 12340 WHERE `ID` = 7795;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Whenever you are ready to hand in the stack of runecloth, I\'ll accept it.', `VerifiedBuild` = 12340 WHERE `ID` = 7796;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'A benevolent gift such as silk, might I add, would certainly increase your local standing in the community! If you have the sixty pieces of silk cloth on you and are ready to donate them, I\'m able to take them from you now.', `VerifiedBuild` = 12340 WHERE `ID` = 7798;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'If you have the sixty pieces of mageweave cloth on you and are ready to donate them, I\'m able to take them from you now.', `VerifiedBuild` = 12340 WHERE `ID` = 7799;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = '$n, you\'ve been a tremendous contributor to our cloth drive. As we work hard to replenish our reserves, one form of cloth remains critically low - runecloth. We are in absolutely dire need of it, and we hope that you will be able to help us as you have in the past!$b$bIf you are willing, please bring me what runecloth you can spare. We\'ll initially accept a single donation of sixty, and then we\'ll go from there.', `VerifiedBuild` = 12340 WHERE `ID` = 7800;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'We are currently accepting donations for wool cloth.  A donation of sixty pieces of wool cloth will net you full recognition by Ironforge for your generous actions.  Our stores are such on wool that we would only need sixty pieces from you total; we should be able to acquire enough from others in the realm to support our drive.$B$BIf you have the sixty pieces of wool cloth on you and are ready to donate them, I\'m able to take them from you now.', `VerifiedBuild` = 12340 WHERE `ID` = 7802;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'As with most other fabrics, our stocks of silk are at an all-time low.  Our stores are such that we\'d only need sixty pieces of silk from you total; we should be able to reach our goal with the support of others.$B$BA benevolent gift such as silk, might I add, would certainly increase your local standing in the community!  If you have the sixty pieces of silk cloth on you and are ready to donate them, I\'m able to take them from you now.', `VerifiedBuild` = 12340 WHERE `ID` = 7803;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Mageweave is running low, and we could use your help to replenish our stocks!  By counting on the community as a whole, we would only need a donation of 60 pieces of mageweave cloth from you to enable us to reach our goal.  Such generosity would not go unnoticed by Ironforge, I assure you!$B$BIf you have the sixty pieces of mageweave cloth on you and are ready to donate them, I\'m able to take them from you now.', `VerifiedBuild` = 12340 WHERE `ID` = 7804;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = '$N, you\'ve been a tremendous contributor to our cloth drive.  As we work hard to replenish our reserves, one form of cloth remains critically low - runecloth.  We are in absolutely dire need of it, and we hope that you will be able to help us as you have in the past!$B$BIf you are willing, please bring me what runecloth you can spare.  We\'ll initially accept a single donation of sixty, and then we\'ll go from there.', `VerifiedBuild` = 12340 WHERE `ID` = 7805;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Whenever you are ready to hand in the stack of runecloth, I\'ll accept it.', `VerifiedBuild` = 12340 WHERE `ID` = 7806;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'We are currently accepting donations for wool cloth.  A donation of sixty pieces of wool cloth will net you full recognition by the Gnomeregan Exiles for your generous actions.  Our stores are such on wool that we would only need sixty pieces from you total; we should be able to acquire enough from others in the realm to support our drive.$B$BIf you have the sixty pieces of wool cloth on you and are ready to donate them, I\'m able to take them from you now.', `VerifiedBuild` = 12340 WHERE `ID` = 7807;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'As with most other fabrics, our stocks of silk are at an all-time low.  Our stores are such that we\'d only need sixty pieces of silk from you total; we should be able to reach our goal with the support of others.$B$BA benevolent gift such as silk, might I add, would certainly increase your local standing in the community!  If you have the sixty pieces of silk cloth on you and are ready to donate them, I\'m able to take them from you now.', `VerifiedBuild` = 12340 WHERE `ID` = 7808;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'If you have the sixty pieces of mageweave cloth on you and are ready to donate them, I\'m able to take them from you now.', `VerifiedBuild` = 12340 WHERE `ID` = 7809;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = '$n, you\'ve been a tremendous contributor to our cloth drive. As we work hard to replenish our reserves, one form of cloth remains critically low - runecloth. We are in absolutely dire need of it, and we hope that you will be able to help us as you have in the past!$b$bIf you are willing, please bring me what runecloth you can spare. We\'ll initially accept a single donation of sixty, and then we\'ll go from there.', `VerifiedBuild` = 12340 WHERE `ID` = 7811;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Whenever you are ready to hand in the stack of runecloth, I\'ll accept it.', `VerifiedBuild` = 12340 WHERE `ID` = 7812;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'If you have the sixty pieces of wool cloth on you and are ready to donate them, I\'m able to take them from you now.', `VerifiedBuild` = 12340 WHERE `ID` = 7813;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'A benevolent gift such as silk, might I add, would certainly increase your local standing in the community! If you have the sixty pieces of silk cloth on you and are ready to donate them, I\'m able to take them from you now.', `VerifiedBuild` = 12340 WHERE `ID` = 7814;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'How goes the hunt?', `VerifiedBuild` = 12340 WHERE `ID` = 7815;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you get it yet?', `VerifiedBuild` = 12340 WHERE `ID` = 7816;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'If you have the sixty pieces of mageweave cloth on you and are ready to donate them, I\'m able to take them from you now.', `VerifiedBuild` = 12340 WHERE `ID` = 7817;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = '$n, you\'ve been a tremendous contributor to our cloth drive. As we work hard to replenish our reserves, one form of cloth remains critically low - runecloth. We are in absolutely dire need of it, and we hope that you will be able to help us as you have in the past!$b$bIf you are willing, please bring me what runecloth you can spare. We\'ll initially accept a single donation of sixty, and then we\'ll go from there.', `VerifiedBuild` = 12340 WHERE `ID` = 7818;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Greetings once again, $N!  Our need for runecloth is constant, and we can always use additional resources if you are willing to part with them.  For an additional stack of twenty runecloth, I will make sure that you are recognized for your continuing efforts on behalf of the Undercity.$B$BWhenever you are ready to hand in the stack of runecloth, I\'ll accept it.', `VerifiedBuild` = 12340 WHERE `ID` = 7819;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'We are currently accepting donations for wool cloth.  A donation of sixty pieces of wool cloth will net you full recognition by Thunder Bluff for your generous actions.  Our stores are such on wool that we would only need sixty pieces from you total; we should be able to acquire enough from others in the realm to support our drive.$B$BIf you have the sixty pieces of wool cloth on you and are ready to donate them, I\'m able to take them from you now.', `VerifiedBuild` = 12340 WHERE `ID` = 7820;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'As with most other fabrics, our stocks of silk are at an all-time low.  Our stores are such that we\'d only need sixty pieces of silk from you total; we should be able to reach our goal with the support of others.$B$BA benevolent gift such as silk, might I add, would certainly increase your local standing in the community!  If you have the sixty pieces of silk cloth on you and are ready to donate them, I\'m able to take them from you now.', `VerifiedBuild` = 12340 WHERE `ID` = 7821;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Mageweave is running low, and we could use your help to replenish our stocks!  By counting on the community as a whole, we would only need a donation of 60 pieces of mageweave cloth from you to enable us to reach our goal.  Such generosity would not go unnoticed by Thunder Bluff, I assure you!$B$BIf you have the sixty pieces of mageweave cloth on you and are ready to donate them, I\'m able to take them from you now.', `VerifiedBuild` = 12340 WHERE `ID` = 7822;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = '$n, you\'ve been a tremendous contributor to our cloth drive. As we work hard to replenish our reserves, one form of cloth remains critically low - runecloth. We are in absolutely dire need of it, and we hope that you will be able to help us as you have in the past!$b$bIf you are willing, please bring me what runecloth you can spare. We\'ll initially accept a single donation of sixty, and then we\'ll go from there.', `VerifiedBuild` = 12340 WHERE `ID` = 7823;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = '$n, you\'ve been a tremendous contributor to our cloth drive. As we work hard to replenish our reserves, one form of cloth remains critically low - runecloth. We are in absolutely dire need of it, and we hope that you will be able to help us as you have in the past!$b$bIf you are willing, please bring me what runecloth you can spare. We\'ll initially accept a single donation of sixty, and then we\'ll go from there.', `VerifiedBuild` = 12340 WHERE `ID` = 7824;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Whenever you are ready to hand in the stack of runecloth, I\'ll accept it.', `VerifiedBuild` = 12340 WHERE `ID` = 7825;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'If you have the sixty pieces of wool cloth on you and are ready to donate them, I\'m able to take them from you now.', `VerifiedBuild` = 12340 WHERE `ID` = 7826;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'As with most other fabrics, our stocks of silk are at an all-time low.  Our stores are such that we\'d only need sixty pieces of silk from you total; we should be able to reach our goal with the support of others.$B$BA benevolent gift such as silk, might I add, would certainly increase your local standing in the community!  If you have the sixty pieces of silk cloth on you and are ready to donate them, I\'m able to take them from you now.', `VerifiedBuild` = 12340 WHERE `ID` = 7827;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'The Razorbeak Skylord is a much rarer breed of gryphon: One responsible for mating and creating murderous offspring.', `VerifiedBuild` = 12340 WHERE `ID` = 7830;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Mageweave is running low, and we could use your help to replenish our stocks!  By counting on the community as a whole, we would only need a donation of 60 pieces of mageweave cloth from you to enable us to reach our goal.  Such generosity would not go unnoticed by Orgrimmar, I assure you!$B$BIf you have the sixty pieces of mageweave cloth on you and are ready to donate them, I\'m able to take them from you now.', `VerifiedBuild` = 12340 WHERE `ID` = 7831;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Whenever you are ready to hand in the stack of runecloth, I\'ll accept it.', `VerifiedBuild` = 12340 WHERE `ID` = 7832;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'If you have the sixty pieces of wool cloth on you and are ready to donate them, I\'m able to take them from you now.', `VerifiedBuild` = 12340 WHERE `ID` = 7833;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'As with most other fabrics, our stocks of silk are at an all-time low.  Our stores are such that we\'d only need sixty pieces of silk from you total; we should be able to reach our goal with the support of others.$B$BA benevolent gift such as silk, might I add, would certainly increase your local standing in the community!  If you have the sixty pieces of silk cloth on you and are ready to donate them, I\'m able to take them from you now.', `VerifiedBuild` = 12340 WHERE `ID` = 7834;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Mageweave is running low, and we could use your help to replenish our stocks!  By counting on the community as a whole, we would only need a donation of 60 pieces of mageweave cloth from you to enable us to reach our goal.  Such generosity would not go unnoticed by the Darkspear Trolls, I assure you!$B$BIf you have the sixty pieces of mageweave cloth on you and are ready to donate them, I\'m able to take them from you now.', `VerifiedBuild` = 12340 WHERE `ID` = 7835;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = '$n, you\'ve been a tremendous contributor to our cloth drive. As we work hard to replenish our reserves, one form of cloth remains critically low - runecloth. We are in absolutely dire need of it, and we hope that you will be able to help us as you have in the past!$b$bIf you are willing, please bring me what runecloth you can spare. We\'ll initially accept a single donation of sixty, and then we\'ll go from there.', `VerifiedBuild` = 12340 WHERE `ID` = 7836;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Whenever you are ready to hand in the stack of runecloth, I\'ll accept it.', `VerifiedBuild` = 12340 WHERE `ID` = 7837;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Watch out for the Vilebranch trolls of the region, $N. They are ruthless, murderous filth.', `VerifiedBuild` = 12340 WHERE `ID` = 7839;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = '<Lard rubs his enormous belly.>$B$BLard so hungry.', `VerifiedBuild` = 12340 WHERE `ID` = 7840;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'What\'s the hold up, mon?', `VerifiedBuild` = 12340 WHERE `ID` = 7843;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'When I have his remains, I shall take them to Yayo\'jin and have them prepared for a proper burial.', `VerifiedBuild` = 12340 WHERE `ID` = 7849;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Be cautious in battling the Vilebranch, $N. Their minds are clouded - they fight to the death.', `VerifiedBuild` = 12340 WHERE `ID` = 7850;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you bring news from Jintha\'alor?', `VerifiedBuild` = 12340 WHERE `ID` = 7861;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'Are you here about the job opening?', `VerifiedBuild` = 12340 WHERE `ID` = 7862;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the resource crate, $N? The League of Arathor can\'t fight a decent battle without them...', `VerifiedBuild` = 12340 WHERE `ID` = 8080;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the resource crate, $N? The League of Arathor can\'t fight a decent battle without them...', `VerifiedBuild` = 12340 WHERE `ID` = 8154;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the resource crate, $N? The League of Arathor can\'t fight a decent battle without them...', `VerifiedBuild` = 12340 WHERE `ID` = 8155;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the resource crate, $N? The League of Arathor can\'t fight a decent battle without them...', `VerifiedBuild` = 12340 WHERE `ID` = 8156;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do I know you?', `VerifiedBuild` = 12340 WHERE `ID` = 8234;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you found enough fragments to continue my work?', `VerifiedBuild` = 12340 WHERE `ID` = 8235;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'The bag has already arrived from Archmage Xylem, have you found the key?', `VerifiedBuild` = 12340 WHERE `ID` = 8236;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Let\'s not waste more of my precious time with jibber jabber, $r. It\'s time to focus on replenishing our dwindling fiery flux supply.$B$BWhat I\'m gonna need from you is the following:$B$B*Incendosaur scales.$B$B*Iron bars.$B$B*Coal.$B$BI\'ll take all that you can offer!$B$BAnd you\'ll do it fast if you wanna get in good with the Brotherhood.', `VerifiedBuild` = 12340 WHERE `ID` = 8241;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Let\'s not waste more of my precious time with jibber jabber, $r. It\'s time to focus on replenishing our dwindling fiery flux supply.$B$BWhat I\'m gonna need from you is the following:$B$B*Incendosaur scales.$B$B*Heavy Leather.$B$B*Coal.$B$BI\'ll take all that you can offer!$B$BAnd you\'ll do it fast if you wanna get in good with the Brotherhood.\n', `VerifiedBuild` = 12340 WHERE `ID` = 8242;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'You have returned. Were you successful?', `VerifiedBuild` = 12340 WHERE `ID` = 8255;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'We must obtain the ichor quickly. Have you found it?', `VerifiedBuild` = 12340 WHERE `ID` = 8256;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the blood of Morphaz?', `VerifiedBuild` = 12340 WHERE `ID` = 8257;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have the resource crate, $N? The League of Arathor can\'t fight a decent battle without them...', `VerifiedBuild` = 12340 WHERE `ID` = 8297;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 8328;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Have you had a chance to find my belongings?  Once we reassert our dominance over Sunstrider Isle, I will need them in my work.  For now though, I must maintain my watch over the Sunwell... or what remains of it.', `VerifiedBuild` = 12340 WHERE `ID` = 8330;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 25, `CompletionText` = 'It is better you learn about survival - and the costs of survival - now rather than later. Making hard choices is something you\'re going to have to get used to as a blood elf.$B$BNo one was there for us when the Scourge ripped our home in two. It was us and us alone who pulled ourselves up by the bootstraps.', `VerifiedBuild` = 12340 WHERE `ID` = 8334;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 25, `CompletionText` = 'Ah $N. Have you completed your task?', `VerifiedBuild` = 12340 WHERE `ID` = 8346;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 0, `CompletionText` = 'Welcome to my inn, $C.  Am I to understand that you have something for me?', `VerifiedBuild` = 20886 WHERE `ID` = 8350;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have all 20 hats? I don\'t believe you, let me see them. They better be in pristine condition!', `VerifiedBuild` = 12340 WHERE `ID` = 8365;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'What evil have you brought me?', `VerifiedBuild` = 12340 WHERE `ID` = 8414;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Was Thal\'danis able to cleanse the scourgestones?', `VerifiedBuild` = 12340 WHERE `ID` = 8416;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Have you slain the wretched trolls?', `VerifiedBuild` = 12340 WHERE `ID` = 8418;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'The burning spines of the helboar leave horrific scars. Do not fear the pain and disfigurement, warrior, they are nothing compared to the prison to which I am bound.', `VerifiedBuild` = 12340 WHERE `ID` = 8423;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'The shadowsworn are not easily defeated, are they? But you are a warrior, and you will triumph or perish trying.', `VerifiedBuild` = 12340 WHERE `ID` = 8424;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Are you back so soon? Time is not the same to me any more, perhaps it has indeed been a long journey for you...', `VerifiedBuild` = 12340 WHERE `ID` = 8425;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 1, `CompletionText` = 'While you have proven yourself to me, you may need to continue to work toward proving yourself to the suspicious brethren of my tribe.  To that end, I may be able to continue assisting you.$B$BSome of the Deadwood furbolgs wear a distinctive headdress that may be used as a means of proof in thinning their numbers.  Bring me a feather from any headdresses you acquire; for every set of five you bring me, you will earn recognition amongst the Timbermaw.', `VerifiedBuild` = 12340 WHERE `ID` = 8466;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 1, `CompletionText` = 'While you have proven yourself to me, you may need to continue to work toward proving yourself to the suspicious brethren of my tribe.  To that end, I may be able to continue assisting you.$B$BSome of the Deadwood furbolgs wear a distinctive headdress that may be used as a means of proof in thinning their numbers.  Bring me a feather from any headdresses you acquire; for every set of five you bring me, you will earn recognition amongst the Timbermaw.', `VerifiedBuild` = 12340 WHERE `ID` = 8467;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'You have returned to us, $N... does this mean that the demon has been slain?', `VerifiedBuild` = 12340 WHERE `ID` = 8481;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 0, `CompletionText` = '$C, you are welcomed in my domain.  Ironforge should always be considered a home to a hero such as yourself.  Now, what business do you have with me?', `VerifiedBuild` = 12340 WHERE `ID` = 8484;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 0, `CompletionText` = 'The warchief\'s greetings are bestowed upon you, $C. Your deeds make the Horde grow stronger in these troubling times.  Now, what business do you have with me?', `VerifiedBuild` = 12340 WHERE `ID` = 8485;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = 'You have something for me, $N?$b$b', `VerifiedBuild` = 12340 WHERE `ID` = 8496;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 8497;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 8541;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Hello. Do you have business with me? ', `VerifiedBuild` = 12340 WHERE `ID` = 8552;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you get my cutlass, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 8554;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 8563;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 8564;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 8661;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 8741;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 8763;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 8779;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 8780;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 8782;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 8783;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 8799;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 8809;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = 'You have something for me, $N?$b$b', `VerifiedBuild` = 12340 WHERE `ID` = 8810;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 8846;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you brought me what I requested of you, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 8905;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you brought me what I requested of you, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 8906;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you brought me what I requested of you, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 8907;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you brought me what I requested of you, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 8908;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you brought me what I requested of you, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 8909;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you brought me what I requested of you, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 8910;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you brought me what I requested of you, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 8911;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you brought me what I requested of you, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 8912;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you obtained the items I require, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 8913;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you obtained the items I require, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 8914;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you obtained the items I require, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 8915;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you obtained the items I require, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 8916;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you obtained the items I require, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 8917;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you obtained the items I require, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 8918;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you obtained the items I require, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 8919;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you obtained the items I require, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 8920;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I understand the materials are a bit pricey... but I promise you every last one of them shall be necessary!', `VerifiedBuild` = 12340 WHERE `ID` = 8921;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'You\'ve something for me?', `VerifiedBuild` = 12340 WHERE `ID` = 8922;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'You wish to speak to me?', `VerifiedBuild` = 12340 WHERE `ID` = 8923;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you gathered the ectoplasm yet, $R?', `VerifiedBuild` = 12340 WHERE `ID` = 8924;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you found the Magma Lord, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 8925;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You\'re ready to perform the trade?', `VerifiedBuild` = 12340 WHERE `ID` = 8926;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You\'re ready to perform the exchange?', `VerifiedBuild` = 12340 WHERE `ID` = 8927;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you had any luck finding the imp in Darkwhisper Gorge?', `VerifiedBuild` = 12340 WHERE `ID` = 8928;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You\'re ready to perform the trade?', `VerifiedBuild` = 12340 WHERE `ID` = 8931;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You\'re ready to perform the trade?', `VerifiedBuild` = 12340 WHERE `ID` = 8932;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You\'re ready to perform the trade?', `VerifiedBuild` = 12340 WHERE `ID` = 8933;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You\'re ready to perform the trade?', `VerifiedBuild` = 12340 WHERE `ID` = 8934;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You\'re ready to perform the trade?', `VerifiedBuild` = 12340 WHERE `ID` = 8935;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You\'re ready to perform the trade?', `VerifiedBuild` = 12340 WHERE `ID` = 8936;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You\'re ready to perform the trade?', `VerifiedBuild` = 12340 WHERE `ID` = 8937;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You\'re ready to perform the exchange?', `VerifiedBuild` = 12340 WHERE `ID` = 8938;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You\'re ready to perform the exchange?', `VerifiedBuild` = 12340 WHERE `ID` = 8939;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You\'re ready to perform the exchange?', `VerifiedBuild` = 12340 WHERE `ID` = 8940;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You\'re ready to perform the exchange?', `VerifiedBuild` = 12340 WHERE `ID` = 8941;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You\'re ready to perform the exchange?', `VerifiedBuild` = 12340 WHERE `ID` = 8942;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You\'re ready to perform the exchange?', `VerifiedBuild` = 12340 WHERE `ID` = 8943;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You\'re ready to perform the exchange?', `VerifiedBuild` = 12340 WHERE `ID` = 8944;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Ysida... is she alive?', `VerifiedBuild` = 12340 WHERE `ID` = 8946;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you obtain the materials I asked for, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 8947;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you performed the favor I asked of you, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 8949;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you gathered the materials I require, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 8950;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'You\'re back, $N. You must tell me all about what you\'ve found out. But first let us arrange for your reward.', `VerifiedBuild` = 12340 WHERE `ID` = 8951;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'You\'re back, $N. You must tell me all about what you\'ve found out. But first let us arrange for your reward.', `VerifiedBuild` = 12340 WHERE `ID` = 8952;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'You\'re back, $N. You must tell me all about what you\'ve found out. But first let us arrange for your reward.', `VerifiedBuild` = 12340 WHERE `ID` = 8953;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'You\'re back, $N. You must tell me all about what you\'ve found out. But first let us arrange for your reward.', `VerifiedBuild` = 12340 WHERE `ID` = 8954;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'You\'re back, $N. You must tell me all about what you\'ve found out. But first let us arrange for your reward.', `VerifiedBuild` = 12340 WHERE `ID` = 8955;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'You\'re back, $N. You must tell me all about what you\'ve found out. But first let us arrange for your reward.', `VerifiedBuild` = 12340 WHERE `ID` = 8956;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'You\'re back, $N. You must tell me all about what you\'ve found out. But first let us arrange for your reward.', `VerifiedBuild` = 12340 WHERE `ID` = 8957;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'You\'re back, $N. You must tell me all about what you\'ve found out. But first let us arrange for your reward.', `VerifiedBuild` = 12340 WHERE `ID` = 8958;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'You\'re back, $N. You must tell me all about what you\'ve found out. But first let us arrange for your reward.', `VerifiedBuild` = 12340 WHERE `ID` = 8959;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'It was our folly... our doom that we took that last job. If only we hadn\'t inadvertently stolen Lord Valthalak\'s spirit, which was contained in the amulet; if only there weren\'t those in our mercenary group that had been so greedy and divided it up amongst themselves. I\'d be alive today, maybe tossing back a beer, or tossing one of my kids into the air.$B$B$N, don\'t let the avarice of the ignoble in our old mercenary company be your doom as well.', `VerifiedBuild` = 12340 WHERE `ID` = 8961;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you returned already then, $C, with what I sent you out to gather?', `VerifiedBuild` = 12340 WHERE `ID` = 8962;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you returned already then, $C, with what I sent you out to gather?', `VerifiedBuild` = 12340 WHERE `ID` = 8963;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you returned already then, $C, with what I sent you out to gather?', `VerifiedBuild` = 12340 WHERE `ID` = 8964;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you returned already then, $C, with what I sent you out to gather?', `VerifiedBuild` = 12340 WHERE `ID` = 8965;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Then it is done? You have retrieved the left piece of Lord Valthalak\'s amulet and finally put to rest the spirit of my old companion, Mor Grayhoof?', `VerifiedBuild` = 12340 WHERE `ID` = 8966;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Surely you haven\'t already dealt with the salvation of Isalien\'s spirit and the retrieval of the left piece of Lord Valthalak\'s amulet, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 8967;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Does this mean then, $C, that you\'ve already put the souls of those two fools to rest and retrieved the left piece of Lord Valthalak\'s amulet?', `VerifiedBuild` = 12340 WHERE `ID` = 8968;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'I commend you, $N, if you have returned with the left piece of the amulet. If not, however, please take care of that as there is no time to waste, I assure you!', `VerifiedBuild` = 12340 WHERE `ID` = 8969;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Bloodkelp, $N, a big stack of it, that\'s what I need to power my divinatory spells. You\'re likely to need to take at least a couple of friends along with you to Alcaz Island to gather it up... those Strashaz are a nasty lot!', `VerifiedBuild` = 12340 WHERE `ID` = 8970;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'You\'ve returned?', `VerifiedBuild` = 12340 WHERE `ID` = 8977;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'You\'ve returned with the device?', `VerifiedBuild` = 12340 WHERE `ID` = 8978;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you returned already then, $C, with what I sent you out to gather?', `VerifiedBuild` = 12340 WHERE `ID` = 8985;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you returned already then, $C, with what I sent you out to gather?', `VerifiedBuild` = 12340 WHERE `ID` = 8986;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you returned already then, $C, with what I sent you out to gather?', `VerifiedBuild` = 12340 WHERE `ID` = 8987;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you returned already then, $C, with what I sent you out to gather?', `VerifiedBuild` = 12340 WHERE `ID` = 8988;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Then it is done? You have retrieved the right piece of Lord Valthalak\'s amulet, recombined the amulet into one whole, and finally put to rest the spirit of my old companion, Mor Grayhoof?', `VerifiedBuild` = 12340 WHERE `ID` = 8989;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Surely you haven\'t already dealt with the salvation of Isalien\'s spirit and the retrieval of the right piece of Lord Valthalak\'s amulet, $N? Be sure to recombine the pieces of the amulet before handing it to me.', `VerifiedBuild` = 12340 WHERE `ID` = 8990;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Does this mean then, $C, that you\'ve already put the souls of those two fools to rest and recombined the pieces of Lord Valthalak\'s amulet?', `VerifiedBuild` = 12340 WHERE `ID` = 8991;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'I commend you, $N, if you have returned with the completed amulet. If not, however, please take care of that as there is no time to waste, I assure you!', `VerifiedBuild` = 12340 WHERE `ID` = 8992;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 2, `EmoteOnIncomplete` = 2, `CompletionText` = 'We\'ve come a long way, $N, and I just wanted to say that no matter what happens, thank you! You\'ve put yourself in mortal danger to try to help the surviving members of our mercenary company, The Veiled Blade, and as far as I\'m concerned, you\'re one of us now.', `VerifiedBuild` = 12340 WHERE `ID` = 8994;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 15, `EmoteOnIncomplete` = 15, `CompletionText` = '$C, you dare disturb my rest!', `VerifiedBuild` = 12340 WHERE `ID` = 8995;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = '$N, you\'re back and still alive! Well, at least that makes one of us.$B$BYou\'re going to have to tell me all about it!', `VerifiedBuild` = 12340 WHERE `ID` = 8996;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'As per our deal, are you ready to hand over your Wildheart pieces in exchange for your new Feralheart Cowl and Vest?', `VerifiedBuild` = 12340 WHERE `ID` = 8999;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'As per our deal, are you ready to hand over your Beaststalker pieces in exchange for your new Beastmaster\'s Cap and Tunic?', `VerifiedBuild` = 12340 WHERE `ID` = 9000;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'As per our deal, are you ready to hand over your Magister\'s pieces in exchange for your new Sorcerer\'s Crown and Robes?', `VerifiedBuild` = 12340 WHERE `ID` = 9001;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'As per our deal, are you ready to hand over your Lightforge pieces in exchange for your new Soulforge Helmet and Breastplate?', `VerifiedBuild` = 12340 WHERE `ID` = 9002;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'As per our deal, are you ready to hand over your Devout pieces in exchange for your new Virtuous Crown and Robe?', `VerifiedBuild` = 12340 WHERE `ID` = 9003;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'As per our deal, are you ready to hand over your Shadowcraft pieces in exchange for your new Darkmantle Cap and Tunic?', `VerifiedBuild` = 12340 WHERE `ID` = 9004;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'As per our deal, are you ready to hand over your Dreadmist pieces in exchange for your new Deathmist Mask and Robe?', `VerifiedBuild` = 12340 WHERE `ID` = 9005;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'As per our deal, are you ready to hand over your Valor pieces in exchange for your new Helm and Breastplate of Heroism?', `VerifiedBuild` = 12340 WHERE `ID` = 9006;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'As per our deal, are you ready to hand over your Wildheart pieces in exchange for your new Feralheart Cowl and Vest?', `VerifiedBuild` = 12340 WHERE `ID` = 9007;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'As per our deal, are you ready to hand over your Beaststalker pieces in exchange for your new Beastmaster\'s Cap and Tunic?', `VerifiedBuild` = 12340 WHERE `ID` = 9008;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'As per our deal, are you ready to hand over your Devout pieces in exchange for your new Virtuous Crown and Robe?', `VerifiedBuild` = 12340 WHERE `ID` = 9009;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'As per our deal, are you ready to hand over your Shadowcraft pieces in exchange for your new Darkmantle Cap and Tunic?', `VerifiedBuild` = 12340 WHERE `ID` = 9010;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'As per our deal, are you ready to hand over your Elements pieces in exchange for your new Coif and Vest of The Five Thunders', `VerifiedBuild` = 12340 WHERE `ID` = 9011;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'As per our deal, are you ready to hand over your Dreadmist pieces in exchange for your new Deathmist Mask and Robe?', `VerifiedBuild` = 12340 WHERE `ID` = 9012;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'As per our deal, are you ready to hand over your Valor pieces in exchange for your new Helm and Breastplate of Heroism?', `VerifiedBuild` = 12340 WHERE `ID` = 9013;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'As per our deal, are you ready to hand over your Magister\'s pieces in exchange for your new Sorcerer\'s Crown and Robes?', `VerifiedBuild` = 12340 WHERE `ID` = 9014;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'You\'re back, $N!', `VerifiedBuild` = 12340 WHERE `ID` = 9015;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'You\'ve returned and I see in your eyes that you\'ve much to tell me, $N.  Let us take care of your reward first.', `VerifiedBuild` = 12340 WHERE `ID` = 9016;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'You\'ve returned and I see in your eyes that you\'ve much to tell me, $N.  Let us take care of your reward first.', `VerifiedBuild` = 12340 WHERE `ID` = 9017;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'You\'ve returned and I see in your eyes that you\'ve much to tell me, $N.  Let us take care of your reward first.', `VerifiedBuild` = 12340 WHERE `ID` = 9018;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'You\'ve returned and I see in your eyes that you\'ve much to tell me, $N.  Let us take care of your reward first.', `VerifiedBuild` = 12340 WHERE `ID` = 9019;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'You\'ve returned and I see in your eyes that you\'ve much to tell me, $N.  Let us take care of your reward first.', `VerifiedBuild` = 12340 WHERE `ID` = 9020;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'You\'ve returned and I see in your eyes that you\'ve much to tell me, $N.  Let us take care of your reward first.', `VerifiedBuild` = 12340 WHERE `ID` = 9021;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'You\'ve returned and I see in your eyes that you\'ve much to tell me, $N. Let us take care of your reward first.', `VerifiedBuild` = 12340 WHERE `ID` = 9022;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'Were you able to pacify the great beast?', `VerifiedBuild` = 12340 WHERE `ID` = 9051;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you met with success?', `VerifiedBuild` = 12340 WHERE `ID` = 9052;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you recovered the vine?', `VerifiedBuild` = 12340 WHERE `ID` = 9053;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 9120;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'How goes the hunt?', `VerifiedBuild` = 12340 WHERE `ID` = 9124;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'You did an exemplary job on the first bundle, $n. If you have more, I will take them now. For every bundle that you turn in, I will reward you with another insignia.', `VerifiedBuild` = 12340 WHERE `ID` = 9125;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I can direct you to skeleton infested locales, $c.', `VerifiedBuild` = 12340 WHERE `ID` = 9126;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'A man in my line of work can never have too many bone fragments, $n. Whenever you have a surplus of fragments, bring them to me and I\'ll reward you with another insignia.', `VerifiedBuild` = 12340 WHERE `ID` = 9127;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I can only steer you in the right direction, $N.', `VerifiedBuild` = 12340 WHERE `ID` = 9128;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Truth be told, I use the cores to create Frostfire armor. It is the armor used by the mages battling in Naxxramas. Without you and others like you, we would most definitely be losing this war.$B$BWith that said, bring me more cores and I shall grant you more insignias.\n', `VerifiedBuild` = 12340 WHERE `ID` = 9129;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = '<Korfax growls at you.>$B$BWhat do you want? Directions? I can provide those...', `VerifiedBuild` = 12340 WHERE `ID` = 9131;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 25, `EmoteOnIncomplete` = 25, `CompletionText` = 'For every armful of the scraps, I\'ll give you an insignia - the more the better. Now get out of my sight before I split you in two!\n', `VerifiedBuild` = 12340 WHERE `ID` = 9132;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'I have intimate knowledge of the flora in our world. Do you require direction?', `VerifiedBuild` = 12340 WHERE `ID` = 9136;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'For every bundle of fronds that you deliver to me, I will pay you with your choice of an insignia of the Dawn or the Crusade.$b$bInsignias may be turned in to the Quartermaster for various rewards.', `VerifiedBuild` = 12340 WHERE `ID` = 9137;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = '<Commander Metz chews on his cigar.>$B$BWhat is it? I\'m a busy man.', `VerifiedBuild` = 12340 WHERE `ID` = 9141;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 9142;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 9154;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 9177;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'If it were not for these Argent Dawn guards, you would be a stain upon this floor.\n', `VerifiedBuild` = 12340 WHERE `ID` = 9211;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 9212;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 274, `EmoteOnIncomplete` = 274, `CompletionText` = '<Mataus yawns.>$B$BBe gone, insect, lest you have something for me.', `VerifiedBuild` = 12340 WHERE `ID` = 9213;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 9238;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you brought the materials?', `VerifiedBuild` = 12340 WHERE `ID` = 9239;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 9260;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 9261;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 9262;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 9263;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 9264;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 9265;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'You must\'ve done something really bad to us or our friends, $n.  At any rate, I\'m here to offer you a way to get our good graces back.$b$bAs you know, Winterspring is quite cold.  With so many of us goblins coming from other cities, we could use a hand keeping warm.  Bring me some runecloth and coal and I\'ll put in the good word for ya.  Be warned though, our enemies are not going to take kindly to your helping us.', `VerifiedBuild` = 12340 WHERE `ID` = 9266;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Magistrix Elosai\'s note was a bit cryptic, but I think I understand what she wants me to do. If you have the earth she talked about, I can put it into the vessel you\'ll need for the moonwell water.', `VerifiedBuild` = 12340 WHERE `ID` = 9431;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Did it do the job?', `VerifiedBuild` = 12340 WHERE `ID` = 9433;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Were you and Wizlo able to gather the reagents?', `VerifiedBuild` = 12340 WHERE `ID` = 9434;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Were you able to retrieve the crystals from the Forsaken?', `VerifiedBuild` = 12340 WHERE `ID` = 9435;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'For Sunstrider\'s sake, don\'t stare at me! It\'s bad enough I\'m forced to endure out here in my soiled clothing! After all I\'ve been through, the last thing I need is to be gawked at. Did you manage to collect my possessions from that hole-in-the-ground those Dark Irons call a fortress?', `VerifiedBuild` = 12340 WHERE `ID` = 9439;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you feed their captured animals all of the morsels?  Wait!  You didn\'t give any to that stupid human they have out there in the cage, did you?$B$BOh, good!  That would have been a waste!', `VerifiedBuild` = 12340 WHERE `ID` = 9440;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'When you\'ve managed to retrieve his \'mark\', we\'re going to change it a bit; make it better.', `VerifiedBuild` = 12340 WHERE `ID` = 9443;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'It is done, then?  Uther\'s Tomb is defiled?', `VerifiedBuild` = 12340 WHERE `ID` = 9444;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'You are doing the right thing, hunter. The Lost Ones have suffered so much already. They shouldn\'t have to suffer this further indignity.', `VerifiedBuild` = 12340 WHERE `ID` = 9448;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'The look on your face marks you as the bearer of bad news. What have you discovered?', `VerifiedBuild` = 12340 WHERE `ID` = 9475;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 9500;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 9501;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'Are there demons yet standing?', `VerifiedBuild` = 12340 WHERE `ID` = 9516;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Can you feel it, $N, the touch of corruption upon the wind? If we do nothing, it will continue to advance. That is why I seek the Chalice of Elune. Were you able to find it?', `VerifiedBuild` = 12340 WHERE `ID` = 9519;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'What do you have there, $gsir:ma\'am;?', `VerifiedBuild` = 12340 WHERE `ID` = 9520;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'What\'s that you have there, $C?', `VerifiedBuild` = 12340 WHERE `ID` = 9521;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'Our night elf scouts report that preparations for the attack may still be ongoing. Those dreadlords must die soon, $N!', `VerifiedBuild` = 12340 WHERE `ID` = 9522;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'What do you have there, scout?', `VerifiedBuild` = 12340 WHERE `ID` = 9535;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'Those dreadlords must die soon, $N!', `VerifiedBuild` = 12340 WHERE `ID` = 9536;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = 'You can hear a low-pitched hum emanating from the totem.', `VerifiedBuild` = 12340 WHERE `ID` = 9538;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 9578;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I look forward to you gathering enough of the Atal\'ai artifacts so that I might begin to study them.  I\'m eager to discover what happened to their once-great civilization.', `VerifiedBuild` = 12340 WHERE `ID` = 9610;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 9617;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 9620;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'When the towers are under our control, we will soon be able to surround the Forsaken. After that, it is only a matter of time before we can crush them.', `VerifiedBuild` = 12340 WHERE `ID` = 9664;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'They must be fools to think that we would allow them to establish bases so close to one of our capitals.$B$BWe will bleed their numbers until they turn tail and retreat back to the south.', `VerifiedBuild` = 12340 WHERE `ID` = 9665;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 9672;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 9676;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 9677;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 9681;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 5, `CompletionText` = 'Be sure that you collect all of the evidence carefully, $c!  We\'re fitting the pieces of a giant puzzle together here.  A mistake on your part could lead us to the wrong conclusions.$B$BThen where would we be in our understanding of Zangarmarsh\'s ecology?', `VerifiedBuild` = 12340 WHERE `ID` = 9702;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have those samples yet?', `VerifiedBuild` = 12340 WHERE `ID` = 9708;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'You have all of the mushrooms that we need to create a new garden for the bog lords?', `VerifiedBuild` = 12340 WHERE `ID` = 9709;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 9711;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 9753;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 9756;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 9759;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 9760;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 9762;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'From the looks of things, we\'ll need to replenish our spores soon.', `VerifiedBuild` = 12340 WHERE `ID` = 9777;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Have you any fish to contribute to our stores?', `VerifiedBuild` = 12340 WHERE `ID` = 9780;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'How goes the hunt, friend?', `VerifiedBuild` = 12340 WHERE `ID` = 9781;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Were you able to get a sample of the soil in the Dead Mire?', `VerifiedBuild` = 12340 WHERE `ID` = 9782;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'It pains me to kill the creatures of the Dead Mire, but they are beyond saving. The best we can do is work to restore the area and nurture a new generation.', `VerifiedBuild` = 12340 WHERE `ID` = 9783;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Have you examined the Boha\'mu Ruins? Can you imagine what they were like in their full splendor?', `VerifiedBuild` = 12340 WHERE `ID` = 9786;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Do you have the idols?', `VerifiedBuild` = 12340 WHERE `ID` = 9787;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Did you manage to gather any diaphanous wings?', `VerifiedBuild` = 12340 WHERE `ID` = 9790;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Have you been successful in your marshfang hunt?', `VerifiedBuild` = 12340 WHERE `ID` = 9791;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = '<Kialon eyes you suspiciously.>$B$BI don\'t know you, $R. Do you have business with me?', `VerifiedBuild` = 12340 WHERE `ID` = 9794;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Have you gathered the reagents?', `VerifiedBuild` = 12340 WHERE `ID` = 9801;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Did you speak with the Feralfen elder?', `VerifiedBuild` = 12340 WHERE `ID` = 9803;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I hope to demonstrate the uses of bleeder venom to Anchorite Ahuurn and the others at Telredor. That\'s going to require me to double my supply.', `VerifiedBuild` = 12340 WHERE `ID` = 9830;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Have you made progress in securing the roads?', `VerifiedBuild` = 12340 WHERE `ID` = 9833;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Does $N have hides for Maktu?', `VerifiedBuild` = 12340 WHERE `ID` = 9834;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'How goes the fight against the Ango\'rosh?', `VerifiedBuild` = 12340 WHERE `ID` = 9835;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Is it done? Have you dealt with Overlord Gorefist?', `VerifiedBuild` = 12340 WHERE `ID` = 9839;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Did your search of Daggerfen Village yield the information I need in order to get to the bottom of this poison puzzle?', `VerifiedBuild` = 12340 WHERE `ID` = 9848;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Have you encountered Boglash?', `VerifiedBuild` = 12340 WHERE `ID` = 9895;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Did you manage to get the stinger? Remember, it\'s useless to me if it\'s damaged.', `VerifiedBuild` = 12340 WHERE `ID` = 9896;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Did you manage to track down Sporewing?', `VerifiedBuild` = 12340 WHERE `ID` = 9901;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I am ashamed that I cannot do more to help my enslaved brethren. but at least we have prevented more needless deaths.', `VerifiedBuild` = 12340 WHERE `ID` = 9902;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Long time ago, Maktu might have used Mragesh\'s hide to make strong armor. Mragesh far too old for that now. Hide too soft for good armor.', `VerifiedBuild` = 12340 WHERE `ID` = 9905;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 9949;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Do you have my samples?', `VerifiedBuild` = 12340 WHERE `ID` = 9968;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you discovered anything yet?', `VerifiedBuild` = 12340 WHERE `ID` = 9971;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 9974;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 9984;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 9985;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'It\'s good to see you again, $N. Have you done as I asked?', `VerifiedBuild` = 12340 WHERE `ID` = 9986;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 9989;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'What news do you bring, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 9990;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I\'ve started a seed collection, but I\'m going to need some help before I have enough to send back to the park in Stormwind.', `VerifiedBuild` = 12340 WHERE `ID` = 9992;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'You look concerned. What is it, $C?', `VerifiedBuild` = 12340 WHERE `ID` = 9994;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'You look concerned.  What is it, $C?', `VerifiedBuild` = 12340 WHERE `ID` = 9995;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'Report. What news do you bring from Firewing Point?', `VerifiedBuild` = 12340 WHERE `ID` = 9996;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I take it Bertelm sent you to hamper the efforts of their peons?', `VerifiedBuild` = 12340 WHERE `ID` = 9998;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'The activity in the camp continues to escalate. Have you carried out your mission?', `VerifiedBuild` = 12340 WHERE `ID` = 10002;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = '<Sal\'salabim rubs his head.>$B$B[Demonic] Ik il romath sardon.', `VerifiedBuild` = 0 WHERE `ID` = 10004;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Was your attack successful?', `VerifiedBuild` = 12340 WHERE `ID` = 10007;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I see you\'ve managed to survive the rigors of the forest. Have you brought any tails for my cloak?', `VerifiedBuild` = 12340 WHERE `ID` = 10016;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Has old Ironjaw gotten the better of you, too, friend? Or have you managed to outsmart the old fellow?', `VerifiedBuild` = 12340 WHERE `ID` = 10022;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Have you cleared the warp stalkers from the vicinity of the stronghold?', `VerifiedBuild` = 12340 WHERE `ID` = 10026;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Were you able to find any intact vessels?', `VerifiedBuild` = 12340 WHERE `ID` = 10028;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'What\'s this? Who are you?', `VerifiedBuild` = 12340 WHERE `ID` = 10030;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I suppose you\'re after the bonelasher bounty too?', `VerifiedBuild` = 12340 WHERE `ID` = 10033;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'You have the feather? Am I to reward you for your foolhardy bravery?', `VerifiedBuild` = 12340 WHERE `ID` = 10035;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = '<Seth tugs on your cloak.>$B$BDid you find the eels? Didja?', `VerifiedBuild` = 12340 WHERE `ID` = 10037;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'You speak with all of them yet? What did they have to say?', `VerifiedBuild` = 12340 WHERE `ID` = 10040;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Well, what did ye find out, $glad:lass;?', `VerifiedBuild` = 12340 WHERE `ID` = 10042;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 10048;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 10049;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 10063;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 10064;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Have you mastered Corruption?', `VerifiedBuild` = 20886 WHERE `ID` = 10073;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'The relics of Terokk have been absent from Skettis for too long. Were you able to recover them from the Sethekk?', `VerifiedBuild` = 12340 WHERE `ID` = 10098;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Have you seen what the Daggerfen have done? Now you understand why we must isolate them from the other Lost Ones.', `VerifiedBuild` = 12340 WHERE `ID` = 10115;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'So you wish to claim the bounty on Chieftain Mummaki?', `VerifiedBuild` = 12340 WHERE `ID` = 10116;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 10138;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 10195;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 10196;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = 'What did you think?  Still needs some tweaking, eh?', `VerifiedBuild` = 12340 WHERE `ID` = 10248;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'If you have the sixty pieces of wool cloth on you and are ready to donate them, I\'m able to take them from you now.', `VerifiedBuild` = 12340 WHERE `ID` = 10352;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'A benevolent gift such as silk, might I add, would certainly increase your local standing in the community! If you have the sixty pieces of silk cloth on you and are ready to donate them, I\'m able to take them from you now.', `VerifiedBuild` = 12340 WHERE `ID` = 10354;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Were you able to gather the samples?', `VerifiedBuild` = 12340 WHERE `ID` = 10355;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'If you have the sixty pieces of mageweave cloth on you and are ready to donate them, I\'m able to take them from you now.', `VerifiedBuild` = 12340 WHERE `ID` = 10356;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = '$n, you\'ve been a tremendous contributor to our cloth drive. As we work hard to replenish our reserves, one form of cloth remains critically low - runecloth. We are in absolutely dire need of it, and we hope that you will be able to help us as you have in the past!$b$bIf you are willing, please bring me what runecloth you can spare. We\'ll initially accept a single donation of sixty, and then we\'ll go from there.', `VerifiedBuild` = 12340 WHERE `ID` = 10357;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'If you have the sixty pieces of wool cloth on you and are ready to donate them, I\'m able to take them from you now.', `VerifiedBuild` = 12340 WHERE `ID` = 10359;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'A benevolent gift such as silk, might I add, would certainly increase your local standing in the community! If you have the sixty pieces of silk cloth on you and are ready to donate them, I\'m able to take them from you now.', `VerifiedBuild` = 12340 WHERE `ID` = 10360;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'If you have the sixty pieces of mageweave cloth on you and are ready to donate them, I\'m able to take them from you now.', `VerifiedBuild` = 12340 WHERE `ID` = 10361;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'Lieutenant Meridian has been keeping us apprised of the situation at Firewing Point. Is everything okay?', `VerifiedBuild` = 12340 WHERE `ID` = 10446;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you brought me what I requested of you, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 10492;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you obtained the items I require, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 10493;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You\'re ready to perform the trade?', `VerifiedBuild` = 12340 WHERE `ID` = 10494;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You\'re ready to perform the exchange?', `VerifiedBuild` = 12340 WHERE `ID` = 10495;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have the Scourge crumbled beneath your weapon?', `VerifiedBuild` = 12340 WHERE `ID` = 10590;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 0, `CompletionText` = 'Do you have something for me, $R?', `VerifiedBuild` = 12340 WHERE `ID` = 10592;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Given that you are alive, I can only surmise you were lucky enough to receive wisdom rather than death from Lady Sylvanas.', `VerifiedBuild` = 12340 WHERE `ID` = 10593;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'What do you mean? I\'m going to make something out of the ash - obviously.', `VerifiedBuild` = 12340 WHERE `ID` = 10624;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Snap to it! That gnome\'s appetite knows no limit!', `VerifiedBuild` = 12340 WHERE `ID` = 10673;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 10725;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 10726;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 10727;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 10728;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 10733;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 10734;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 10735;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 10736;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 10738;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 10739;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 10740;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 0, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 10741;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'You have returned, $C. What news do you bring?', `VerifiedBuild` = 12340 WHERE `ID` = 10847;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Have you done your bidding? Quash the evil before it is too late!', `VerifiedBuild` = 12340 WHERE `ID` = 10861;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you find our missing people?', `VerifiedBuild` = 12340 WHERE `ID` = 10873;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'It\'s a terrible thing to ask, I know...', `VerifiedBuild` = 12340 WHERE `ID` = 10913;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 5, `CompletionText` = 'Take no prisoners!', `VerifiedBuild` = 12340 WHERE `ID` = 10914;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Do you bring the feathers I asked for, $N?', `VerifiedBuild` = 12340 WHERE `ID` = 10917;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Skettis\'s lapdogs still keeps a close watch over us, outcasts.  The moment any of us sets foot outside Shattrath we\'ll be as good as dead.$B$BBring me more feathers as proof of your victory over them.', `VerifiedBuild` = 12340 WHERE `ID` = 10918;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 273, `CompletionText` = 'You get paid when the job is done, $Gsonny:missy;.', `VerifiedBuild` = 12340 WHERE `ID` = 10922;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 5, `CompletionText` = 'We think the one that popped up at the dig was actually a baby worm!', `VerifiedBuild` = 12340 WHERE `ID` = 10929;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I am in need of more I.D. tags, $N. What I\'ve discovered thus far is that this is not just a way to catalogue prisoners but it also documents locations!$B$BOnce this code is broken we\'ll be able to pinpoint exactly where all of our allies are held and free them with minimal hostile action received.', `VerifiedBuild` = 27980 WHERE `ID` = 10972;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'I would understand if you chose not to continue, $N.', `VerifiedBuild` = 27980 WHERE `ID` = 10977;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 11052;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Were you able to find any trace of the orders?', `VerifiedBuild` = 12340 WHERE `ID` = 11144;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you capture those raptors?', `VerifiedBuild` = 12340 WHERE `ID` = 11146;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you get those weapons from Blackhoof Village?', `VerifiedBuild` = 12340 WHERE `ID` = 11148;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 15, `EmoteOnIncomplete` = 15, `CompletionText` = 'Brogg will have his revenge!', `VerifiedBuild` = 12340 WHERE `ID` = 11162;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you had any luck testing the totem?', `VerifiedBuild` = 12340 WHERE `ID` = 11169;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you make any progress against those oozes?', `VerifiedBuild` = 12340 WHERE `ID` = 11174;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'What is that you\'re carrying, $C?', `VerifiedBuild` = 12340 WHERE `ID` = 11185;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Were you able to get any of that thresher oil?', `VerifiedBuild` = 12340 WHERE `ID` = 11192;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'What did your search of Blackhoof Village reveal?', `VerifiedBuild` = 12340 WHERE `ID` = 11200;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Were you able to find any trace of the orders?', `VerifiedBuild` = 12340 WHERE `ID` = 11201;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Have you put that torch to good use?', `VerifiedBuild` = 12340 WHERE `ID` = 11205;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = '<Moxie looks frantic with worry.>$B$BDid the cargo survive? Did you find any of it?', `VerifiedBuild` = 12340 WHERE `ID` = 11207;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Yes?', `VerifiedBuild` = 12340 WHERE `ID` = 11208;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'Did you find any of the wyrmtail?', `VerifiedBuild` = 12340 WHERE `ID` = 11217;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = NULL, `VerifiedBuild` = 12340 WHERE `ID` = 11403;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'This dirt has been recently disturbed. Earthworms lie in the topsoil, squirming to escape the dark depths beneath them.', `VerifiedBuild` = 12340 WHERE `ID` = 11405;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You don\'t have any Bread of the Dead, do you?', `VerifiedBuild` = 0 WHERE `ID` = 13952;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You don\'t have any Bread of the Dead, do you?', `VerifiedBuild` = 0 WHERE `ID` = 14166;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You don\'t have any Bread of the Dead, do you?', `VerifiedBuild` = 0 WHERE `ID` = 14167;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You don\'t have any Bread of the Dead, do you?', `VerifiedBuild` = 0 WHERE `ID` = 14168;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You don\'t have any Bread of the Dead, do you?', `VerifiedBuild` = 0 WHERE `ID` = 14169;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You don\'t have any Bread of the Dead, do you?', `VerifiedBuild` = 0 WHERE `ID` = 14170;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You don\'t have any Bread of the Dead, do you?', `VerifiedBuild` = 0 WHERE `ID` = 14171;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You don\'t have any Bread of the Dead, do you?', `VerifiedBuild` = 0 WHERE `ID` = 14172;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You don\'t have any Bread of the Dead, do you?', `VerifiedBuild` = 0 WHERE `ID` = 14173;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You don\'t have any Bread of the Dead, do you?', `VerifiedBuild` = 0 WHERE `ID` = 14174;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You don\'t have any Bread of the Dead, do you?', `VerifiedBuild` = 0 WHERE `ID` = 14175;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You don\'t have any Bread of the Dead, do you?', `VerifiedBuild` = 0 WHERE `ID` = 14176;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 6, `EmoteOnIncomplete` = 6, `CompletionText` = 'You don\'t have any Bread of the Dead, do you?', `VerifiedBuild` = 0 WHERE `ID` = 14177;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 1, `EmoteOnIncomplete` = 1, `CompletionText` = 'Succeed now and you will have almost earned my respect, $C.', `VerifiedBuild` = 12340 WHERE `ID` = 14350;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 5, `EmoteOnIncomplete` = 0, `CompletionText` = 'Why aren\'t you out on the battlefield, $c?', `VerifiedBuild` = 12340 WHERE `ID` = 14351;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'What do you want, $N?  This had better be important.', `VerifiedBuild` = 12340 WHERE `ID` = 14352;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Did you secure the books? They need to be kept out of the wrong hands.', `VerifiedBuild` = 12340 WHERE `ID` = 14356;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Well met, $c. Did you have something for me?', `VerifiedBuild` = -1 WHERE `ID` = 24597;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Well met, $c. Did you have something for me?', `VerifiedBuild` = -1 WHERE `ID` = 24609;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Well met, $c. Did you have something for me?', `VerifiedBuild` = -1 WHERE `ID` = 24610;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Well met, $c. Did you have something for me?', `VerifiedBuild` = -1 WHERE `ID` = 24611;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Well met, $c. Did you have something for me?', `VerifiedBuild` = -1 WHERE `ID` = 24612;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Well met, $c. Did you have something for me?', `VerifiedBuild` = -1 WHERE `ID` = 24613;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Well met, $c. Did you have something for me?', `VerifiedBuild` = -1 WHERE `ID` = 24614;

UPDATE `quest_request_items` SET `EmoteOnComplete` = 0, `EmoteOnIncomplete` = 0, `CompletionText` = 'Well met, $c. Did you have something for me?', `VerifiedBuild` = -1 WHERE `ID` = 24615;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
