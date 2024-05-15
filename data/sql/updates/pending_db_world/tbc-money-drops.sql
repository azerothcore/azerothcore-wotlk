/* 250g
Gruul - 19044
Maulgar - 18831
SSC bosses except Vashj
    hydross - 21216
    lurker - 21217
    leotheras - 21215
    karathress - 21214
    tidewalker - 21213
TK bosses except Kael
    al'ar - 19514
    void reaver - 19516
    solarian - 18805
Hyjal bosses except Archimonde
    winterchill - 17767
    anetheron - 17808
    kaz'rogal - 17888
    azgalor - 17842
BT bosses except Illidan and council
    naj'entus - 22887
    supremus - 22898
    akama - 22841
    gorefiend - 22871
    bloodboil - 22948
    reliquary - 22856
    shahraz - 22947
Sunwell bosses except twins and KJ
    sathrovarr - 24892
    brutallus - 24882
    felmyst - 25038
    entropius - 25840
*/
UPDATE `creature_template` SET `mingold` = 2500000, `maxgold` = 2500000 WHERE `entry` IN (17767, 17808, 17842, 17888, 18805, 18831, 19044, 19514, 19516, 21213, 21214, 21215, 21216, 21217, 22841, 22856, 22871, 22887, 22898, 22947, 22948, 24882, 24892, 25038, 25840);

/* 250g/4=62.5g
Illidari council
    zerevor - 22950
    gathios - 22949
    darkshadow - 22952
    malande - 22951
*/
UPDATE `creature_template` SET `mingold` = 625000, `maxgold` = 625000 WHERE `entry` IN (22949, 22950, 22951, 22952);

/* 300g
Vashj - 21212
Kael - 19622
Archimonde - 17968
Illidan - 22917
*/
UPDATE `creature_template` SET `mingold` = 3000000, `maxgold` = 3000000 WHERE `entry` IN (17968, 19622, 21212, 22917);

/* 350g
Eredar twins
    alythess - 25166
    sacrolash - 25165
*/
UPDATE `creature_template` SET `mingold` = 3500000, `maxgold` = 3500000 WHERE `entry` IN (25165, 25166);

/* 500g
KJ - 25315
*/
UPDATE `creature_template` SET `mingold` = 5000000, `maxgold` = 5000000 WHERE `entry` = 25315;

/* ~500g
Mag - 17257
Kazzak - 18728
Doomwalker - 17711
*/
UPDATE `creature_template` SET `mingold` = 4750000, `maxgold` = 5250000 WHERE `entry` IN (17257, 17711, 18728);