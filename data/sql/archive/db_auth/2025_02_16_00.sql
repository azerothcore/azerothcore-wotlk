-- DB update 2025_01_26_00 -> 2025_02_16_00
--
ALTER TABLE `autobroadcast_locale`
DROP PRIMARY KEY,
ADD PRIMARY KEY (`realmid`, `id`, `locale`);
