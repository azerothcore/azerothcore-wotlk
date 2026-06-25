-- DB update 2024_01_14_10 -> 2024_01_14_11
-- SOULS_LICH_KING_RAND_WHISPER
-- quest "A Feast of Souls" quest id 24547

DELETE FROM `creature_text` WHERE `CreatureID`=37181 AND `GroupID` BETWEEN 20 AND 35;

DELETE
FROM `creature_text`
WHERE `CreatureID`=37181 AND `GroupID`=5;

INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(37181, 5, 0, 'Take them mortal! These souls will again be mine soon enough...', 15, 0, 100, 0, 0, 17235, 37899, 0, 'A Feast of Souls Lich King (Also ICC Intro)'), 
(37181, 5, 1, 'Soon, mortal, you too shall have a blade for a prison.', 15, 0, 100, 0, 0, 17236, 37900, 0, 'A Feast of Souls Lich King (Also ICC Intro)'),
(37181, 5, 2, 'Remember hero: I, too, once sought a weapon of great power...', 15, 0, 100, 0, 0, 17237, 37901, 0, 'A Feast of Souls Lich King (Also ICC Intro)'),
(37181, 5, 3, 'I see you too are gathering souls for your own ends. Are we really so different, champion?', 15, 0, 100, 0, 0, 17238, 37902, 0, 'A Feast of Souls Lich King (Also ICC Intro)'),
(37181, 5, 4, 'Yes, do it! Create your monstrous new weapon. It too will serve me when your soul is mine!', 15, 0, 100, 0, 0, 17239, 37903, 0, 'A Feast of Souls Lich King (Also ICC Intro)'),
(37181, 5, 5, 'Bring me your weapon champion and I might feed it with the souls of its master...', 15, 0, 100, 0, 0, 17240, 37904, 0, 'A Feast of Souls Lich King (Also ICC Intro)'),
(37181, 5, 6, 'Look at you, child; would-be wielder of souls... You cannot fathom the power that lies at my command.', 15, 0, 100, 0, 0, 17241, 37905, 0, 'A Feast of Souls Lich King (Also ICC Intro)'),
(37181, 5, 7, 'Come to me, pretender! Feed MY blade!', 15, 0, 100, 0, 0, 17242, 37906, 0, 'A Feast of Souls Lich King (Also ICC Intro)'),
(37181, 5, 8, 'My challenges have strengthened you champion, you shall serve me well!', 15, 0, 100, 0, 0, 17243, 37907, 0, 'A Feast of Souls Lich King (Also ICC Intro)'),
(37181, 5, 9, 'Never have I had cause to regret sparing your life, mortal. Always, you find ways to amuse me.', 15, 0, 100, 0, 0, 17244, 37908, 0, 'A Feast of Souls Lich King (Also ICC Intro)'),
(37181, 5, 10, 'The moment is soon at hand mortal. You shall toil for eternity in a new Azeroth!', 15, 0, 100, 0, 0, 17245, 37909, 0, 'A Feast of Souls Lich King (Also ICC Intro)'),
(37181, 5, 11, 'More souls, yes, more! You will find it hard to stop.', 15, 0, 100, 0, 0, 17246, 37910, 0, 'A Feast of Souls Lich King (Also ICC Intro)'),
(37181, 5, 12, 'The hunger your weapon feels is but a shade of what awaits. Do you want to see real hunger? Real power? continue onwards hero! I am waiting.', 15, 0, 100, 0, 0, 17247, 37911, 0, 'A Feast of Souls Lich King (Also ICC Intro)'),
(37181, 5, 13, 'You stumble about in darkness. There is no light here. No mercy. Icecrown has claimed the souls of better heroes than you.', 15, 0, 100, 0, 0, 17248, 37912, 0, 'A Feast of Souls Lich King (Also ICC Intro)'),
(37181, 5, 14, 'Your heart... its incessant drumming disgusts me. I will silence it, as I did my own.', 15, 0, 100, 0, 0, 17249, 37913, 0, 'A Feast of Souls Lich King (Also ICC Intro)'),
(37181, 5, 15, 'The Light will abandon you, hero, just as it did me.', 15, 0, 100, 0, 0, 17250, 37914, 0, 'A Feast of Souls Lich King (Also ICC Intro)');


UPDATE `creature_text` SET `BroadcastTextId`=37027
WHERE `CreatureID`=37119 AND `GroupID`=0 AND `ID`=0;
UPDATE `creature_text` SET `BroadcastTextId`=37105
WHERE `CreatureID`=37503 AND `GroupID`=0 AND `ID`=0;
UPDATE `creature_text` SET `BroadcastTextId`=36129
WHERE `CreatureID`=34996 AND `GroupID`=17 AND `ID`=0;

-- I appear to have lost my ring.
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID`=38227
WHERE `MenuID`=10996 AND `OptionID`=6;
-- You must not approach the Frost Queen. Quickly, stop them!
UPDATE `creature_text` SET `BroadcastTextId`=37105
WHERE `CreatureID`=37503 AND `GroupID`=0 AND `ID`=0;
-- 
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID`=38229 WHERE `MenuID`=10995 AND `OptionID`=0;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID`=38229 WHERE `MenuID`=10995 AND `OptionID`=1;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID`=38229 WHERE `MenuID`=10995 AND `OptionID`=2;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID`=38229 WHERE `MenuID`=10995 AND `OptionID`=3;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID`=38229 WHERE `MenuID`=10995 AND `OptionID`=4;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID`=38229 WHERE `MenuID`=10995 AND `OptionID`=5;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID`=38229 WHERE `MenuID`=10995 AND `OptionID`=6;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID`=38229 WHERE `MenuID`=10995 AND `OptionID`=7;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID`=38229 WHERE `MenuID`=10995 AND `OptionID`=8;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID`=38229 WHERE `MenuID`=10995 AND `OptionID`=9;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID`=38229 WHERE `MenuID`=10995 AND `OptionID`=10;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID`=38229 WHERE `MenuID`=10995 AND `OptionID`=11;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID`=38229 WHERE `MenuID`=10995 AND `OptionID`=12;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID`=38229 WHERE `MenuID`=10995 AND `OptionID`=13;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID`=38229 WHERE `MenuID`=10995 AND `OptionID`=14;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID`=38229 WHERE `MenuID`=10995 AND `OptionID`=15;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID`=38229 WHERE `MenuID`=10995 AND `OptionID`=16;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID`=38229 WHERE `MenuID`=10995 AND `OptionID`=17;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID`=38229 WHERE `MenuID`=10995 AND `OptionID`=18;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID`=38229 WHERE `MenuID`=10995 AND `OptionID`=19;
