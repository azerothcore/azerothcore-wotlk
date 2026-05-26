-- ============================================================================
-- Black Rose: custom item icons.
--
-- Mirrors the client patch ItemDisplayInfo.dbc rows and points Black Rose
-- item_template rows at custom display IDs that reference shipped BLP icons.
-- ============================================================================

DELETE FROM `itemdisplayinfo_dbc` WHERE `ID` IN (
    900105,
    900200,
    900201,
    900202,
    900300,
    900310,
    900320,
    900330,
    900340,
    900350,
    900360,
    900370,
    900380,
    900400,
    900410,
    900420,
    900430,
    900440,
    901000,
    901010,
    901020,
    901030,
    901040,
    901050,
    901060,
    901070,
    901080,
    901090
);

INSERT INTO `itemdisplayinfo_dbc`
    (`ID`, `ModelName_1`, `ModelName_2`, `ModelTexture_1`, `ModelTexture_2`, `InventoryIcon_1`, `InventoryIcon_2`, `GeosetGroup_1`, `GeosetGroup_2`, `GeosetGroup_3`, `Flags`, `SpellVisualID`, `GroupSoundIndex`, `HelmetGeosetVis_1`, `HelmetGeosetVis_2`, `Texture_1`, `Texture_2`, `Texture_3`, `Texture_4`, `Texture_5`, `Texture_6`, `Texture_7`, `Texture_8`, `ItemVisual`, `ParticleColorID`)
VALUES
    (900105, '', '', '', '', 'INV_BR_Trinket_BlackRose', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
    (900200, '', '', '', '', 'INV_BR_Misc_BlackMiasma', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
    (900201, '', '', '', '', 'INV_BR_Misc_BlackPetals', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
    (900202, '', '', '', '', 'INV_BR_Misc_BlackThorns', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
    (900300, '', '', '', '', 'INV_BR_Misc_StarkRibbon', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
    (900310, '', '', '', '', 'INV_BR_Misc_KlugRibbon', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
    (900320, '', '', '', '', 'INV_BR_Misc_GeistRibbon', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
    (900330, '', '', '', '', 'INV_BR_Misc_SchnellRibbon', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
    (900340, '', '', '', '', 'INV_BR_Misc_FettRibbon', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
    (900350, '', '', '', '', 'INV_BR_Misc_GrossRibbon', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
    (900360, '', '', '', '', 'INV_BR_Misc_SpinnstRibbon', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
    (900370, '', '', '', '', 'INV_BR_Misc_ScharfRibbon', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
    (900380, '', '', '', '', 'INV_BR_Misc_WeiseRibbon', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
    (900400, '', '', '', '', 'INV_BR_Misc_PouvoirMist', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
    (900410, '', '', '', '', 'INV_BR_Misc_DouleurMist', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
    (900420, '', '', '', '', 'INV_BR_Misc_PointeMist', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
    (900430, '', '', '', '', 'INV_BR_Misc_VitesseMist', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
    (900440, '', '', '', '', 'INV_BR_Misc_RestaurerMist', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
    (901000, '', '', '', '', 'INV_BR_Misc_Jewel_Commander', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
    (901010, '', '', '', '', 'INV_BR_Misc_Jewel_Highlord', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
    (901020, '', '', '', '', 'INV_BR_Misc_Jewel_Huntmaster', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
    (901030, '', '', '', '', 'INV_BR_Misc_Jewel_Mastermind', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
    (901040, '', '', '', '', 'INV_BR_Misc_Jewel_HighPriestess', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
    (901050, '', '', '', '', 'INV_BR_Misc_Jewel_Herald', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
    (901060, '', '', '', '', 'INV_BR_Misc_Jewel_Speaker', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
    (901070, '', '', '', '', 'INV_BR_Misc_Jewel_Archmage', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
    (901080, '', '', '', '', 'INV_BR_Misc_Jewel_Corrupter', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
    (901090, '', '', '', '', 'INV_BR_Misc_Jewel_Archdruid', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0);

UPDATE `item_template` SET `displayid` = 900105 WHERE `entry` = 900105;
UPDATE `item_template` SET `displayid` = 900200 WHERE `entry` = 900200;
UPDATE `item_template` SET `displayid` = 900201 WHERE `entry` = 900201;
UPDATE `item_template` SET `displayid` = 900202 WHERE `entry` = 900202;

UPDATE `item_template` SET `displayid` = 900300 WHERE (`entry` BETWEEN 900300 AND 900306) OR (`entry` BETWEEN 900500 AND 900505);
UPDATE `item_template` SET `displayid` = 900310 WHERE (`entry` BETWEEN 900310 AND 900316) OR (`entry` BETWEEN 900510 AND 900515);
UPDATE `item_template` SET `displayid` = 900320 WHERE (`entry` BETWEEN 900320 AND 900326) OR (`entry` BETWEEN 900520 AND 900525);
UPDATE `item_template` SET `displayid` = 900330 WHERE (`entry` BETWEEN 900330 AND 900336) OR (`entry` BETWEEN 900530 AND 900535);
UPDATE `item_template` SET `displayid` = 900340 WHERE (`entry` BETWEEN 900340 AND 900346) OR (`entry` BETWEEN 900540 AND 900545);
UPDATE `item_template` SET `displayid` = 900350 WHERE (`entry` BETWEEN 900350 AND 900356) OR (`entry` BETWEEN 900550 AND 900555);
UPDATE `item_template` SET `displayid` = 900360 WHERE (`entry` BETWEEN 900360 AND 900366) OR (`entry` BETWEEN 900560 AND 900565);
UPDATE `item_template` SET `displayid` = 900370 WHERE (`entry` BETWEEN 900370 AND 900376) OR (`entry` BETWEEN 900570 AND 900575);
UPDATE `item_template` SET `displayid` = 900380 WHERE (`entry` BETWEEN 900380 AND 900386) OR (`entry` BETWEEN 900580 AND 900585);

UPDATE `item_template` SET `displayid` = 900400 WHERE (`entry` BETWEEN 900400 AND 900406) OR (`entry` BETWEEN 900600 AND 900605);
UPDATE `item_template` SET `displayid` = 900410 WHERE (`entry` BETWEEN 900410 AND 900416) OR (`entry` BETWEEN 900610 AND 900615);
UPDATE `item_template` SET `displayid` = 900420 WHERE (`entry` BETWEEN 900420 AND 900426) OR (`entry` BETWEEN 900620 AND 900625);
UPDATE `item_template` SET `displayid` = 900430 WHERE (`entry` BETWEEN 900430 AND 900436) OR (`entry` BETWEEN 900630 AND 900635);
UPDATE `item_template` SET `displayid` = 900440 WHERE (`entry` BETWEEN 900440 AND 900446) OR (`entry` BETWEEN 900640 AND 900645);

UPDATE `item_template` SET `displayid` = 901000 WHERE (`entry` BETWEEN 901000 AND 901006) OR (`entry` BETWEEN 901100 AND 901105);
UPDATE `item_template` SET `displayid` = 901010 WHERE (`entry` BETWEEN 901010 AND 901016) OR (`entry` BETWEEN 901110 AND 901115);
UPDATE `item_template` SET `displayid` = 901020 WHERE (`entry` BETWEEN 901020 AND 901026) OR (`entry` BETWEEN 901120 AND 901125);
UPDATE `item_template` SET `displayid` = 901030 WHERE (`entry` BETWEEN 901030 AND 901036) OR (`entry` BETWEEN 901130 AND 901135);
UPDATE `item_template` SET `displayid` = 901040 WHERE (`entry` BETWEEN 901040 AND 901046) OR (`entry` BETWEEN 901140 AND 901145);
UPDATE `item_template` SET `displayid` = 901050 WHERE (`entry` BETWEEN 901050 AND 901056) OR (`entry` BETWEEN 901150 AND 901155);
UPDATE `item_template` SET `displayid` = 901060 WHERE (`entry` BETWEEN 901060 AND 901066) OR (`entry` BETWEEN 901160 AND 901165);
UPDATE `item_template` SET `displayid` = 901070 WHERE (`entry` BETWEEN 901070 AND 901076) OR (`entry` BETWEEN 901170 AND 901175);
UPDATE `item_template` SET `displayid` = 901080 WHERE (`entry` BETWEEN 901080 AND 901086) OR (`entry` BETWEEN 901180 AND 901185);
UPDATE `item_template` SET `displayid` = 901090 WHERE (`entry` BETWEEN 901090 AND 901096) OR (`entry` BETWEEN 901190 AND 901195);
