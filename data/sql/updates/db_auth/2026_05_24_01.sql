-- DB update 2026_05_24_00 -> 2026_05_24_01
-- Set the login MOTD that every realm shows. realmid = -1 means
-- "applies to all realms" (the default Theta entry). Plain, practical,
-- gives players a clear path to support instead of leaning on lore.
REPLACE INTO `motd` (`realmid`, `text`) VALUES
(-1, 'Welcome to Blackrose, a hardcore WoW Pserver. If you run into any issues please don''t hesitate to reach out on the discord.');
