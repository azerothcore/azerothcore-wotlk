drop table if exists acore_world.forge_talent_flagged_reset;
CREATE TABLE acore_world.`forge_talent_flagged_reset` (
  `guid` int unsigned NOT null,
  `spec` int unsigned NOT null,
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;