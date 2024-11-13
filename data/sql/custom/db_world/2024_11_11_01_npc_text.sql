--
SET @LOCALIZED_STRINGS_START = 70687;
SET @LOCALIZED_STRINGS_END   = 70688;

DELETE FROM `npc_text` WHERE ID BETWEEN @LOCALIZED_STRINGS_START and @LOCALIZED_STRINGS_END;
INSERT INTO `npc_text` (`ID`,`text0_0`,`VerifiedBuild`) VALUES
(@LOCALIZED_STRINGS_START+0,' (gear bank)','-1'),
(@LOCALIZED_STRINGS_START+1,'Not enough gear bank space to store %u item(s) (%u / %u)!','-1');
