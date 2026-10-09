-- Totem of Vark (9542): Shadow of the Forest (30448) must come only from Stillpine Ancestor Yor's
-- script (action list 1739302), not on quest accept.
UPDATE `quest_template_addon` SET `SourceSpellID` = 0 WHERE `ID` = 9542;
