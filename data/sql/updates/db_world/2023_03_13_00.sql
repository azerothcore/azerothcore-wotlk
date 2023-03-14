-- DB update 2023_03_12_00 -> 2023_03_13_00
-- Yogg Saron Vision -- Add missing text
DELETE FROM `creature_text` WHERE `CreatureID`=33552;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(33552, 0, 0, 'A thousand deaths....', 12, 0, 100, 0, 0, 15762, 33616, 0, 'Yogg-Saron'),
(33552, 1, 0, 'Or one murder.', 12, 0, 100, 0, 0, 15763, 33617, 0, 'Yogg-Saron'),
(33552, 2, 0, 'Your petty quarrels only make me stronger.', 12, 0, 100, 0, 0, 15764, 34188, 0, 'Yogg-Saron'),
(33552, 3, 0, 'Yrr n\'lyeth... shuul anagg!', 12, 0, 100, 0, 0, 15766, 33628, 0, 'Yogg-Saron'),
(33552, 4, 0, 'He will learn... no king rules forever; only death is eternal!', 12, 0, 100, 0, 0, 15767, 33629, 0, 'Yogg-Saron'),
(33552, 5, 0, 'His brood learned their lesson before too long. You will soon learn yours!', 12, 0, 100, 0, 0, 15765, 33663, 0, 'Yogg-Saron');

DELETE FROM `creature_text_locale` WHERE `CreatureID`=33552 AND `Locale`='zhCN';
INSERT INTO `creature_text_locale` (`CreatureID`, `GroupID`, `ID`, `Locale`, `Text`) VALUES
(33552, 0, 0, 'zhCN', '被无情地杀戮……'),
(33552, 1, 0, 'znCN', '或者杀戮别人。'),
(33552, 2, 0, 'zhCN', '你们微不足道的抵抗只能让我变得更加强大。'),
(33552, 3, 0, 'zhCN', 'Yrr n\'lyeth... shuul anagg!'),
(33552, 4, 0, 'zhCN', '他会明白……没有谁可以永远坐在王位上，只有死亡才是永恒的！'),
(33552, 5, 0, 'zhCN', '他的族群没用多久就得到了教训。你们也快了！');

-- Death Orb (Death Ray)
DELETE FROM `creature_template_movement` WHERE `CreatureId` = 33882;
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(33882, 1, 0, 0, 0, 0, 0, 0);
