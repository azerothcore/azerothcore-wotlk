-- Quest 11690 "Bring 'Em Back Alive" tells the player they have 10 minutes
-- to deliver the Infected Kodo, but quest_template.TimeAllowed was 0, so no
-- timer was ever enforced/shown. The engine auto-flags a quest as timed
-- (QUEST_SPECIAL_FLAGS_TIMED) whenever TimeAllowed is nonzero on load
-- (ObjectMgr::LoadQuests), so setting it is sufficient to show the
-- in-game countdown.
-- https://github.com/azerothcore/azerothcore-wotlk/issues/26412
UPDATE `quest_template` SET `TimeAllowed` = 600 WHERE `ID` = 11690;
