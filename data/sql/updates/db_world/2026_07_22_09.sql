-- DB update 2026_07_22_08 -> 2026_07_22_09
-- Fel Creep - requires Cenarion Beacon in inventory
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 4 AND `SourceEntry` = 11514;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `Comment`) VALUES
(4, 13965, 11514, 2, 11511, 1, 'Sungrass - Fel Creep requires Cenarion Beacon'),
(4, 13966, 11514, 2, 11511, 1, 'Gromsblood - Fel Creep requires Cenarion Beacon'),
(4, 13967, 11514, 2, 11511, 1, 'Golden Sansam - Fel Creep requires Cenarion Beacon'),
(4, 13968, 11514, 2, 11511, 1, 'Dreamfoil - Fel Creep requires Cenarion Beacon'),
(4, 13969, 11514, 2, 11511, 1, 'Mountain Silversage - Fel Creep requires Cenarion Beacon'),
(4, 13970, 11514, 2, 11511, 1, 'Arthas\' Tears - Fel Creep requires Cenarion Beacon'),
(4, 13971, 11514, 2, 11511, 1, 'Plaguebloom - Fel Creep requires Cenarion Beacon');
