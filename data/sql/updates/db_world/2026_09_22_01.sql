-- DB update 2026_09_22_00 -> 2026_09_22_01
-- riding skill gates flying the carpet, not learning to sew one
UPDATE `trainer_spell` SET `ReqAbility1` = 0 WHERE `SpellId` IN (60969, 60971);
