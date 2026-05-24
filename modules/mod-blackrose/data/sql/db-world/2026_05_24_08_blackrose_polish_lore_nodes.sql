-- ============================================================================
-- Black Rose: trinket flavor text rewrite + 10x faster gathering nodes
--
--   1. Trinket description rewrite. Old text was "Worn first by the founders.
--      The Rose remembers." which read flat. Replacement threads all three
--      currency mats (Petals, Thorns, Miasma) into the in-tooltip lore so
--      players who pick up a Black Petal in the field implicitly understand
--      what they are holding before they ever talk to the vendor.
--
--   2. Mining and Herbalism node respawn -> 10x faster. We do this by
--      dividing gameobject.spawntimesecs by 10 (floor at 30 seconds so
--      nodes don't pop in and out within a single skill animation).
--
--      Filter is intentionally narrow: only gameobject_template.type = 3
--      (CHEST) where data0 is a lock_dbc lockId tied to a Type=2 / Index=2
--      (Herbalism) or Type=2 / Index=3 (Mining) skill check. The lockId
--      list was extracted by parsing the stock client Lock.dbc -- the
--      server's lock_dbc table is empty (it's an override-only table on
--      this server), so we can't join to it. Treasure chests, doors,
--      lockboxes, and quest objects keep their stock respawn timers.
--
--      Affected: ~31.5k node spawns. Average respawn ~62 min -> ~6 min.
-- ============================================================================

SET @BR_TRINKET := 900105;

-- ----------------------------------------------------------------------------
-- 1. Trinket description rewrite
-- ----------------------------------------------------------------------------
UPDATE `item_template`
   SET `description` =
       'Pinned first to the breast of the founders. Each thorn, a name. Each petal, a death. The Rose remembers them all.'
 WHERE `entry` = @BR_TRINKET;

-- ----------------------------------------------------------------------------
-- 2. Gathering node respawn x10
-- ----------------------------------------------------------------------------
-- LockIds whose Type=2/Index=2 (Herbalism) or Type=2/Index=3 (Mining) check
-- in the stock 3.3.5a client Lock.dbc. 51 herb locks + 32 mining locks.
SET @NODE_LOCKS := '8,9,10,11,26,27,29,30,31,32,33,34,35,45,47,48,49,50,51,259,439,440,441,442,443,444,519,521,1119,1120,1121,1122,1123,1124,1639,1641,1642,1643,1644,1645,1646,1702,1714,1786,1787,1788,1789,1790,1791,1792,1793,18,19,20,21,22,25,38,39,40,41,42,379,380,399,400,719,939,1632,1649,1650,1651,1652,1713,1771,1775,1782,1783,1784,1785,1800,1802,1860';

UPDATE `gameobject` g
  JOIN `gameobject_template` gt ON gt.entry = g.id
   SET g.spawntimesecs = GREATEST(30, FLOOR(g.spawntimesecs / 10))
 WHERE gt.type = 3
   AND g.spawntimesecs >= 60
   AND FIND_IN_SET(gt.data0, @NODE_LOCKS) > 0;
