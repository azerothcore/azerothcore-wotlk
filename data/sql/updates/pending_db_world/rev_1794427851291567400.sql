-- Instant Poison, all ranks (2010-01-07 hotfix: AP bonus -10%)
UPDATE `spell_bonus_data` SET `ap_bonus` = 0.09
WHERE `entry` IN (8680, 8685, 8689, 11335, 11336, 11337, 26890, 57964, 57965);

-- Wound Poison, all ranks (2010-01-07 hotfix: AP bonus -10%)
UPDATE `spell_bonus_data` SET `ap_bonus` = 0.036
WHERE `entry` IN (13218, 13222, 13223, 13224, 27189, 57974, 57975);

-- Deadly Poison, all ranks (2010-01-07 hotfix: AP bonus -10%)
UPDATE `spell_bonus_data` SET `ap_dot_bonus` = 0.027,
`comments` = REPLACE(`comments`, '$AP*0.12', '$AP*0.108')
WHERE `entry` IN (2818, 2819, 11353, 11354, 25349, 26968, 27187, 57969, 57970);
