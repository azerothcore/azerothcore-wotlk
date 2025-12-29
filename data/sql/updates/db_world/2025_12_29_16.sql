-- DB update 2025_12_29_15 -> 2025_12_29_16
--
ALTER TABLE `trainer`
    DROP PRIMARY KEY,
    ADD PRIMARY KEY (`Id`);

ALTER TABLE `trainer_locale`
    DROP PRIMARY KEY,
    ADD PRIMARY KEY (`Id`, `locale`);

ALTER TABLE `trainer_spell`
    DROP PRIMARY KEY,
    ADD PRIMARY KEY (`TrainerId`, `SpellId`);

ALTER TABLE `creature_default_trainer`
    DROP PRIMARY KEY,
    ADD PRIMARY KEY (`CreatureId`);
