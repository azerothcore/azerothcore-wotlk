-- The Nexus
-- Level 70 originally
-- map 576

-- NHC
update creature_template set minlevel = (minlevel + 30)  where entry in (select id1 from creature where map = 576);
update creature_template set maxlevel = (maxlevel + 30) where entry in (select id1 from creature where map = 576);

-- HC
select difficulty_entry_1 as entry from creature_template where entry in (select id1 from creature where map = 576);

update creature_template set minlevel = (minlevel + 20) where entry in (30398, 30496, 30509, 30498 ,30522, 30525, 30459, 30457, 30540, 30460, 30478, 30485, 30473, 30510, 30516, 30517, 30518, 30519, 30520, 30521, 30529, 30526, 30524, 30528, 30532);
update creature_template set maxlevel = (maxlevel + 20) where entry in (30398, 30496, 30509, 30498 ,30522, 30525, 30459, 30457, 30540, 30460, 30478, 30485, 30473, 30510, 30516, 30517, 30518, 30519, 30520, 30521, 30529, 30526, 30524, 30528, 30532);

-- Dungeon updated to level 98+ for NHC and HC
INSERT INTO `dungeon_access_template` (`id`, `map_id`, `difficulty`, `min_level`, `max_level`, `min_avg_item_level`, `comment`) VALUES (71, 576, 0, 98, 0, 0, 'The Nexus');
INSERT INTO `dungeon_access_template` (`id`, `map_id`, `difficulty`, `min_level`, `max_level`, `min_avg_item_level`, `comment`) VALUES (72, 576, 1, 98, 0, 180, 'The Nexus');
