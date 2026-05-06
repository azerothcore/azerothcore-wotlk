--
-- Fix wrong Chinese (zhCN) translation for creature_text 19175, GroupID 6, ID 6.
-- The English text is "For the Alliance!" but the current zhCN translation
-- shows "为了部落！" (For the Horde!). Replacing it with "为了联盟！" so the
-- localized text matches the English one.
-- Closes issue #13501.
--

DELETE FROM `creature_text_locale` WHERE `CreatureID`=19175 AND `GroupID`=6 AND `ID`=6 AND `Locale`='zhCN';
INSERT INTO `creature_text_locale` (`CreatureID`, `GroupID`, `ID`, `Locale`, `Text`) VALUES
(19175, 6, 6, 'zhCN', '为了联盟！');
