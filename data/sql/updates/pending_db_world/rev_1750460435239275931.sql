-- Adds a spell into server to track internal cooldown of DK's Bone Shield charges
delete from spell_dbc where id = 49221;
INSERT INTO `spell_dbc` 
SET `Id` = 49221,
    `Attributes` = 0x100,
    `DurationIndex` = 21,
    `Name_Lang_enUS` = 'Bone Shield ICD',
    `SchoolMask` = 1;
