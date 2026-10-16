-- Alterac Valley graveyard defender tiers: Seasoned Defender and Seasoned Guardsman are Alliance and pay
-- Frostwolf Clan, the Veteran and Champion Defenders and Guardians pay like the lower tiers, in every bracket
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` IN (13324, 22687, 32064, 37385, 13326, 22714, 32062, 37383, 13331, 22588, 32125, 37450, 13332, 22589, 32126, 37451, 13421, 22609, 31933, 37251, 13422, 22608, 31932, 37250);
INSERT INTO `creature_onkill_reputation` (`creature_id`, `RewOnKillRepFaction1`, `RewOnKillRepFaction2`, `MaxStanding1`, `IsTeamAward1`, `RewOnKillRepValue1`, `MaxStanding2`, `IsTeamAward2`, `RewOnKillRepValue2`, `TeamDependent`) VALUES
(13324, 729, 0, 6, 0, 5, 0, 0, 0, 0),
(22687, 729, 0, 6, 0, 5, 0, 0, 0, 0),
(32064, 729, 0, 6, 0, 5, 0, 0, 0, 0),
(37385, 729, 0, 6, 0, 5, 0, 0, 0, 0),
(13326, 729, 0, 6, 0, 5, 0, 0, 0, 0),
(22714, 729, 0, 6, 0, 5, 0, 0, 0, 0),
(32062, 729, 0, 6, 0, 5, 0, 0, 0, 0),
(37383, 729, 0, 6, 0, 5, 0, 0, 0, 0),
(13331, 729, 0, 6, 0, 5, 0, 0, 0, 0),
(22588, 729, 0, 6, 0, 5, 0, 0, 0, 0),
(32125, 729, 0, 6, 0, 5, 0, 0, 0, 0),
(37450, 729, 0, 6, 0, 5, 0, 0, 0, 0),
(13332, 730, 0, 6, 0, 5, 0, 0, 0, 0),
(22589, 730, 0, 6, 0, 5, 0, 0, 0, 0),
(32126, 730, 0, 6, 0, 5, 0, 0, 0, 0),
(37451, 730, 0, 6, 0, 5, 0, 0, 0, 0),
(13421, 730, 0, 6, 0, 5, 0, 0, 0, 0),
(22609, 730, 0, 6, 0, 5, 0, 0, 0, 0),
(31933, 730, 0, 6, 0, 5, 0, 0, 0, 0),
(37251, 730, 0, 6, 0, 5, 0, 0, 0, 0),
(13422, 729, 0, 6, 0, 5, 0, 0, 0, 0),
(22608, 729, 0, 6, 0, 5, 0, 0, 0, 0),
(31932, 729, 0, 6, 0, 5, 0, 0, 0, 0),
(37250, 729, 0, 6, 0, 5, 0, 0, 0, 0);
