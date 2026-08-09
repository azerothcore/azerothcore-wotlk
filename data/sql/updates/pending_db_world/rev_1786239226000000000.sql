-- Quest 619 "Enticing Negolash" has no QuestDescription, so its quest log entry
-- shows only the required items. The lifeboat itself does show text, from
-- quest_request_items.CompletionText, so the string already exists in the DB and is
-- the quest's own wording: it is simply never shown in the log.
--
-- Reusing that exact text rather than writing new flavour, so nothing here is
-- invented. The original data leaves QuestDescription empty (checked on Wowhead
-- WotLK and Classic, Warcraft Wiki, TrinityCore and VMaNGOS), so this is a
-- readability change, not a restoration.
UPDATE `quest_template` SET
    `QuestDescription` = 'This is an abandoned lifeboat.  Printed along its side in scratched, faded paint are the words:$B$B"Smotts\' Revenge"',
    `LogDescription`   = 'Bring 10 Barbecued Buzzard Wings and 5 Junglevine Wine to the Ruined Lifeboat.'
WHERE `ID` = 619;
