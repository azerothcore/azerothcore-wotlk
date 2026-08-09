-- Quest 619 "Enticing Negolash" has no QuestDescription or LogDescription, so its
-- log entry shows only the requirements. The original data has none either: neither
-- Wowhead's WotLK nor its Classic page has a Description section, and neither
-- TrinityCore nor VMaNGOS has ever filled it. It is the hand-in step of "Facing
-- Negolash" (618), offered and turned in by the same lifeboat, so nothing presents
-- it to the player.
--
-- This is therefore PROPOSED text rather than restored data, written to match the
-- quest's own mechanics and the tone of its chain. Maintainers may well prefer to
-- leave it blank as blizzlike, which is a fair call.
UPDATE `quest_template` SET
    `QuestDescription` = 'The lifeboat lies half-buried in the sand, its timbers picked clean by salt and years. Negolash and his crew went down with the captain they served, and hunger is the one thing that still moves them.$B$BLay out a feast he cannot refuse. Buzzard wings and Junglevine wine carry a long way on the sea wind, and the dead have never been known for their patience.',
    `LogDescription`   = 'Bring 10 Barbecued Buzzard Wings and 5 Junglevine Wine to the Ruined Lifeboat on the coast southeast of Booty Bay.'
WHERE `ID` = 619;
