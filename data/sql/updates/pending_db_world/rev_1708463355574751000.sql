
-- npc_test_locale translation fix for deputy Willem
-- First quest encounter for Human characters in Nortshire (Elwynn Forest)
-- Creature entry : 823
-- npc_text ID : 50016
-- No broadcastTextID currently assigned (currently at 0)

-- Setting useful variable for the SQL Script
SET @deputyWillemTextID = 50016;
SET @localeCode = 'frFR';

-- Delete existing locale before insert
-- Should be quite useless because this entry is still not translated as we can see on 2024-02-20
DELETE FROM npc_text_locale WHERE `ID` = @deputyWillemTextID AND `Locale` = @localeCode ;

-- Insert new values :
-- Translate in best effort because display in French client is weird
-- In fact Quests are translated but the gossip is still in english.
-- Better have a quite good translated string instead of an english one for player experience.
INSERT INTO npc_text_locale (`ID`, `Locale`, `Text0_0`) 
VALUES (@deputyWillemTextID, @localeCode, 'Bien le bonjour, $c. Je devrais être à la recherche des gens de Hurlevent, mais bon nombre de gardes de Hurlevent combattent sur d\'autres terres. Me voilà donc nommé adjoint et proposant des primes alors que je devrais être de patrouille...');
