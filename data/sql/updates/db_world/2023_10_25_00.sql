-- DB update 2023_10_24_00 -> 2023_10_25_00
-- Wanton Hostess
UPDATE `smart_scripts` SET `action_param1`=0, `comment`='Wanton Hostess - Between 0-50% Health - Remove All Auras' WHERE `entryorguid`=16459 AND `source_type`=0 AND `id`=4;

-- Wanton Hostess Transform (Still doesn't fix it for some reason, core issue?)
DELETE FROM `creature_text` WHERE `CreatureID`=17063;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(17063, 0, 0, 'So I said, "Yeah, but that\'ll cost you extra."', 12, 0, 100, 0, 0, 0, 13883, 0, 'Wanton Hostess Transform - Out of Combat'),
(17063, 0, 1, 'Five seconds. I\'m not kidding!', 12, 0, 100, 0, 0, 0, 13884, 0, 'Wanton Hostess Transform - Out of Combat'),
(17063, 0, 2, 'He asked if the imp could join in--can you believe it? Actually, it wasn\'t half bad....', 12, 0, 100, 0, 0, 0, 13885, 0, 'Wanton Hostess Transform - Out of Combat'),
(17063, 0, 3, 'They fall asleep after. Me, I fall asleep during....', 12, 0, 100, 0, 0, 0, 13886, 0, 'Wanton Hostess Transform - Out of Combat'),
(17063, 1, 0, 'Come play with me!', 12, 0, 100, 0, 0, 0, 13880, 0, 'Wanton Hostess Transform - On Aggro'),
(17063, 1, 1, 'You WILL be mine.', 12, 0, 100, 0, 0, 0, 13881, 0, 'Wanton Hostess Transform - On Aggro'),
(17063, 1, 2, 'Come here, pretty. You have what I need!', 12, 0, 100, 0, 0, 0, 13882, 0, 'Wanton Hostess Transform - On Aggro'),
(17063, 2, 0, 'It was fun while it lasted....', 12, 0, 100, 0, 0, 0, 13889, 0, 'Wanton Hostess Transform - On Death'),
(17063, 2, 1, '<sigh> It\'s always over too soon.', 12, 0, 100, 0, 0, 0, 13890, 0, 'Wanton Hostess Transform - On Death'),
(17063, 2, 2, 'Just when things were getting interesting.', 12, 0, 100, 0, 0, 0, 13897, 0, 'Wanton Hostess Transform - On Death'),
(17063, 2, 3, 'We could have had so much fun!', 12, 0, 100, 0, 0, 0, 13898, 0, 'Wanton Hostess Transform - On Death'),
(17063, 3, 0, 'Come any closer, and I\'ll scream.', 12, 0, 100, 0, 0, 0, 13887, 0, 'Wanton Hostess Transform - On Transform'),
(17063, 3, 1, 'I want to show you a different side of me....', 12, 0, 100, 0, 0, 0, 13888, 0, 'Wanton Hostess Transform - On Transform'),
(17063, 3, 2, 'I want you to be with me... forever and ever.', 12, 0, 100, 0, 0, 0, 13891, 0, 'Wanton Hostess Transform - On Transform'),
(17063, 3, 3, 'Shhh... I have a little secret I\'ve been keeping.\n', 12, 0, 100, 0, 0, 0, 13892, 0, 'Wanton Hostess Transform - On Transform'),
(17063, 3, 4, 'I\'ve been very, very naughty....', 12, 0, 100, 0, 0, 0, 13895, 0, 'Wanton Hostess Transform - On Transform'),
(17063, 3, 5, 'Enough foreplay. Let\'s get down to business.', 12, 0, 100, 0, 0, 0, 13896, 0, 'Wanton Hostess Transform - On Transform');
