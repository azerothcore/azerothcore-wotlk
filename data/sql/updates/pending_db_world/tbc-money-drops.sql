/* 250g
Gruul           - 19044 (28g7s55c   - 36g66s38c)
Maulgar         - 18831 (25g52s22c  - 31g19s38c)
SSC bosses except Vashj
    hydross     - 21216 (134g83s94c - 166g46s84c)
    lurker      - 21217 (134g96c    - 165g44s40c)
    leotheras   - 21215 (129g31s64c - 159g64s98c)
    karathress  - 21214 (131g14s3c  - 161g90s16c)
    tidewalker  - 21213 (134g42s76c - 165g96s)
TK bosses except Kael
    al'ar       - 19514 (126g96s50c - 155g17s95c)
    void reaver - 19516 (104g42s66c - 127g63s25c)
    solarian    - 18805 (87g33s82c  - 106g74s67c)
Hyjal bosses except Archimonde
    winterchill - 17767 (87g54s66c  - 110g28s76c)
    anetheron   - 17808 (86g90s13c  - 109g47s45c)
    kaz'rogal   - 17888 (150g23s64c - 201g89s68c)
    azgalor     - 17842 (85g73s92c  - 108g1s8c)
BT bosses except Illidan and council
    naj'entus   - 22887 (66g10s14c  - 126g47s14c)
    supremus    - 22898 (113g99s71c - 218g10s97c)
    akama       - 22841 (66g71s7c   - 127g63s71c)
    gorefiend   - 22871 (67g31s13c  - 128g78s61c)
    bloodboil   - 22948 (67g2s48c   - 128g23s82c)
    reliquary   - 23420 (66g54s17c  - 127g31s37c)
    shahraz     - 22947 (66g23s7c   - 126g71s87c)
Sunwell bosses except twins and KJ
    sathrovarr  - 24892 (225g       - 275g)
    brutallus   - 24882 (225g       - 275g)
    felmyst     - 25038 (225g       - 275g)
    entropius   - 25840 (225g       - 275g)
*/
UPDATE `creature_template` SET `mingold` = 2500000, `maxgold` = 2500000 WHERE `entry` IN (17767, 17808, 17842, 17888, 18805, 18831, 19044, 19514, 19516, 21213, 21214, 21215, 21216, 21217, 22841, 23420, 22871, 22887, 22898, 22947, 22948, 24882, 24892, 25038, 25840);

/* 250g/4=62.5g
Illidari council
    zerevor    - 22950 (21g8s95c - 40g35s5c)
    gathios    - 22949 (23g1s7c - 44g2s63c)
    darkshadow - 22952 (22g69s83c - 43g42s85c)
    malande    - 22951 (22g71s80c - 43g46s62c)
*/
UPDATE `creature_template` SET `mingold` = 625000, `maxgold` = 625000 WHERE `entry` IN (22949, 22950, 22951, 22952);

/* 300g
Vashj      - 21212 (138g45s86c - 169g22s71c)
Kael       - 19622 (107g59s54c - 131g50s55c)
Archimonde - 17968 (103g25s58c - 130g7s74c)
Illidan    - 22917 (79g84s39c - 152g76s47c)
*/
UPDATE `creature_template` SET `mingold` = 3000000, `maxgold` = 3000000 WHERE `entry` IN (17968, 19622, 21212, 22917);

/* 350g
Eredar twins
    alythess  - 25166 (225g - 275g)
    sacrolash - 25165 (225g - 275g)
*/
UPDATE `creature_template` SET `mingold` = 3500000, `maxgold` = 3500000 WHERE `entry` IN (25165, 25166);

/* 500g
KJ - 25315 (225g - 275g)
*/
UPDATE `creature_template` SET `mingold` = 5000000, `maxgold` = 5000000 WHERE `entry` = 25315;

/* ~500g
Mag        - 17257 (39g12s55c - 51g9s38c)
Kazzak     - 18728 (11g7s55c - 14g46s38c)
Doomwalker - 17711 (445g57s50c - 500g)
*/
UPDATE `creature_template` SET `mingold` = 4750000, `maxgold` = 5250000 WHERE `entry` IN (17257, 17711, 18728);