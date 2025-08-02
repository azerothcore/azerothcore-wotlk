-- queststarters / questenders
UPDATE `creature_template` SET `npcflag` = `npcflag` | 2 WHERE (`entry` IN (16484, 16490, 16493, 16495, 29441));

DELETE FROM `creature_queststarter` WHERE (`quest` IN (9261, 9262, 9263, 9264, 12816)) AND (`id` IN (16484, 16490, 16493, 16495, 29441));
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(16484, 9261), -- Lieutenant Nevell
(16490, 9264), -- Lieutenant Lisande
(16495, 9262), -- Lieutenant Beitha
(16493, 9263), -- Lieutenant Dagel
(29441, 12816); -- Lieutenant Julek

DELETE FROM `creature_questender` WHERE (`quest` IN (9261, 9262, 9263, 9264, 12816)) AND (`id` IN (16484, 16490, 16493, 16495, 29441));
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(16484, 9261), -- Lieutenant Nevell
(16490, 9264), -- Lieutenant Lisande
(16495, 9262), -- Lieutenant Beitha
(16493, 9263), -- Lieutenant Dagel
(29441, 12816); -- Lieutenant Julek

-- areatrigger
DELETE FROM areatrigger_involvedrelation WHERE id IN (4100, 4105);
INSERT INTO areatrigger_involvedrelation (id, quest) VALUES
(4100, 9265),
(4103, 9264),
(4105, 9262);

-- 9260 Investigate the Scourge of Stormwind (A)
-- .go c id 16478
-- circle and mobs in front of town need sniff update, do not match any areatriggers as far as i can tell
-- missing areatrigger link

-- 9261 Investigate the Scourge of Ironforge (A)
-- .go c id 16484
-- missing circle and mobs in front of town
-- missing areatrigger link

-- 9262 Investigate the Scourge of Darnassus (A)
-- .go c id 16495
-- done

-- 9263 Investigate the Scourge of Orgrimmar (H)
-- .go c id 16493
-- has 2 circles and countless mobs in front of orgrimmar, apparently in the wrong spot, does not match quest poi
-- missing circle and mobs in front of town
-- missing areatrigger link

-- 9264 Investigate the Scourge of Thunder Bluff
-- .go c id 16490
-- done

-- 9265 Investigate the Scourge of the Undercity (H)
-- .go c id 16494
-- done

-- 12816 Investigate the Scourge of Silvermoon
-- .go c id 29441
-- missing circle and mobs in front of town
-- missing areatrigger link

-- 12817 Investigate the Scourge of Exodar
-- .go c id 29442
-- missing circle and mobs in front of town
-- missing areatrigger link
