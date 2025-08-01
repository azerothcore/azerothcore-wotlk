-- queststarters / questenders
UPDATE `creature_template` SET `npcflag` = `npcflag` | 2 WHERE (`entry` IN (16484, 16493, 16495, 29441));

DELETE FROM `creature_queststarter` WHERE (`quest` IN (9261, 9262, 9263, 12816)) AND (`id` IN (16484, 16493, 16495, 29441));
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(16484, 9261), -- Lieutenant Nevell
(16495, 9262), -- Lieutenant Beitha
(16493, 9263), -- Lieutenant Dagel
(29441, 12816); -- Lieutenant Julek

DELETE FROM `creature_questender` WHERE (`quest` IN (9261, 9262, 9263, 12816)) AND (`id` IN (16484, 16493, 16495, 29441));
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(16484, 9261), -- Lieutenant Nevell
(16495, 9262), -- Lieutenant Beitha
(16493, 9263), -- Lieutenant Dagel
(29441, 12816); -- Lieutenant Julek

-- areatrigger
DELETE FROM areatrigger_involvedrelation WHERE id IN (4105);
INSERT INTO areatrigger_involvedrelation (id, quest) VALUES
(4105, 9262);

-- 9261 Investigate the Scourge of Ironforge
-- missing circle and mobs in front of town
-- missing areatrigger link

-- 9262 Investigate the Scourge of Darnassus
-- done

-- 9263 Investigate the Scourge of Orgrimmar
-- has 2 circles and countless mobs in front of orgrimmar, apparently in the wrong spot, does not match quest poi
-- missing circle and mobs in front of town
-- missing areatrigger link

-- 12816 Investigate the Scourge of Silvermoon
-- missing circle and mobs in front of town
-- missing areatrigger link

-- 12817 Investigate the Scourge of Exodar
-- missing circle and mobs in front of town
-- missing areatrigger link
