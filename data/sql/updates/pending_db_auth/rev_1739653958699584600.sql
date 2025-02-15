--
ALTER TABLE `autobroadcast_locale`
DROP PRIMARY KEY,
ADD PRIMARY KEY (`realmid`, `id`, `locale`);
