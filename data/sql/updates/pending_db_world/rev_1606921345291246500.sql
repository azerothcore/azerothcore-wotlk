INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1606921345291246500');

-- update general tables
DELETE FROM `broadcast_text` WHERE `id` = 100003;
INSERT INTO `broadcast_text` (`ID`, `Language`, `MaleText`, `FemaleText`, `EmoteID0`, `EmoteID1`, `EmoteID2`, `EmoteDelay0`, `EmoteDelay1`, `EmoteDelay2`, `SoundId`, `Unk1`, `Unk2`, `VerifiedBuild`)VALUES 
(100003, 0, 'Mooooo...', '', 5, 0, 0, 0, 0, 0, 0, 0, 1, 18019);

DELETE FROM `broadcast_text` WHERE `id` = 100004;
INSERT INTO `broadcast_text` (`ID`, `Language`, `MaleText`, `FemaleText`, `EmoteID0`, `EmoteID1`, `EmoteID2`, `EmoteDelay0`, `EmoteDelay1`, `EmoteDelay2`, `SoundId`, `Unk1`, `Unk2`, `VerifiedBuild`)VALUES 
(100004, 0, 'Moooooooooo!', '', 5, 0, 0, 0, 0, 0, 0, 0, 1, 18019);

DELETE FROM `broadcast_text` WHERE `id` = 100006;
INSERT INTO `broadcast_text` (`ID`, `Language`, `MaleText`, `FemaleText`, `EmoteID0`, `EmoteID1`, `EmoteID2`, `EmoteDelay0`, `EmoteDelay1`, `EmoteDelay2`, `SoundId`, `Unk1`, `Unk2`, `VerifiedBuild`)VALUES 
(100005, 0, 'Thank you for bringing back my Bessy, $N. I couldn\'t live without her!', '', 5, 0, 0, 0, 0, 0, 0, 0, 1, 18019);


DESC creature_text;
-- update Bessy messages
DELETE FROM `creature_text` WHERE `creatureId` = 20415;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `id`, `text`, `type`, `language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(20415, 0, 0, 'Mooooo...', 12, 0, 100, 0, 0, 0, 100003, 0, 'Bessy calmly moo when quest starts');
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `id`, `text`, `type`, `language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(20415, 1, 0, 'Moooooooooo!', 12, 0, 100, 0, 0, 0, 100004, 0, 'Bessy angry moo when being attacked');

-- update Thadell messages
DELETE FROM `creature_text` WHERE `creatureId` = 20464;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `id`, `text`, `type`, `language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(20464, 2, 0, 'Bessy, you''re home. Thank the Light!', 12, 0, 100, 0, 0, 0, 18181, 0, 'Thadell say to Bessy');
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `id`, `text`, `type`, `language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(20464, 3, 0, 'Thank you for bringing back my Bessy, $N. I couldn''t live without her!', 12, 0, 100, 0, 0, 0, 100005, 0, 'Thadell say to player');