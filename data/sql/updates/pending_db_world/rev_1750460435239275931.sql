-- Adds a spell into server to track internal cooldown of DK's Bone Shield charges
DELETE from `spell_dbc` WHERE `id` = 49221;
INSERT INTO `spell_dbc` SET `id` = 49221, `Attributes` = 0x100, `DurationIndex` = 21, `Name_Lang_enUS` = 'Bone Shield ICD', `SchoolMask` = 1;
