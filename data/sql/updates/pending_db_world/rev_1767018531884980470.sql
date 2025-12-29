--
ALTER TABLE `trainer`
    ADD PRIMARY KEY (`Id`);

ALTER TABLE `trainer_locale`
    ADD PRIMARY KEY (`Id`, `locale`);

ALTER TABLE `trainer_spell`
    ADD PRIMARY KEY (`TrainerId`, `SpellId`);

ALTER TABLE `creature_default_trainer`
    ADD PRIMARY KEY (`CreatureId`);
