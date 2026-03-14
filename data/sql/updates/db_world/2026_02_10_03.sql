-- DB update 2026_02_10_02 -> 2026_02_10_03
--
-- 'Jeeves'
-- 'Scrapbot'
-- Add Mind-numbing Poison and limited poisons
SET @INCRTIME := 600;
DELETE FROM `npc_vendor` WHERE (`entry` IN (29561, 35642)) AND (`item` IN (43233, 43235, 43237, 3775, 5237, 43231));
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `VerifiedBuild`) VALUES
(29561, 0, 43233, 30, @INCRTIME, 0, 0),
(29561, 0, 43235, 30, @INCRTIME, 0, 0),
(29561, 0, 43237, 10, @INCRTIME, 0, 0),
(29561, 0, 3775, 10, @INCRTIME, 0, 0),
(29561, 0, 5237, 0, 0, 0, 0),
(29561, 0, 43231, 30, @INCRTIME, 0, 0),
(35642, 0, 43233, 30, @INCRTIME, 0, 0),
(35642, 0, 43235, 30, @INCRTIME, 0, 0),
(35642, 0, 43237, 10, @INCRTIME, 0, 0),
(35642, 0, 3775, 10, @INCRTIME, 0, 0),
(35642, 0, 5237, 0, 0, 0, 0),
(35642, 0, 43231, 30, @INCRTIME, 0, 0);

-- Remove 'Simple Wood'
DELETE FROM `npc_vendor` WHERE (`entry` IN (32639, 32641, 30438, 30345, 30825, 31115)) AND (`item` = 4470);

-- Add 'Wild Spineleaf', 'Starleaf Seed', and 'Devout Candle'
DELETE FROM `npc_vendor` WHERE (`entry` IN (1257, 1275, 1308, 1351, 3335, 3351, 3562, 4220, 4575, 5110, 5151, 16612, 16706, 16757)) AND (`item` IN (44605, 44614, 44615));
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `VerifiedBuild`) VALUES
-- 'Keldric Boucher <Alchemy Supplies & Reagents>'
(1257, 0, 44605, 0, 0, 0, 0),
(1257, 0, 44614, 0, 0, 0, 0),
(1257, 0, 44615, 0, 0, 0, 0),
-- 'Kyra Boucher <Reagents>'
(1275, 0, 44605, 0, 0, 0, 0),
(1275, 0, 44614, 0, 0, 0, 0),
(1275, 0, 44615, 0, 0, 0, 0),
-- 'Owen Vaughn <Reagents>'
(1308, 0, 44605, 0, 0, 0, 0),
(1308, 0, 44614, 0, 0, 0, 0),
(1308, 0, 44615, 0, 0, 0, 0),
-- 'Brother Cassius <Reagents>'
(1351, 0, 44605, 0, 0, 0, 0),
(1351, 0, 44614, 0, 0, 0, 0),
(1351, 0, 44615, 0, 0, 0, 0),
-- 'Hagrus <Reagents>'
(3335, 0, 44605, 0, 0, 0, 0),
(3335, 0, 44614, 0, 0, 0, 0),
(3335, 0, 44615, 0, 0, 0, 0),
-- 'Magenius <Reagents>'
(3351, 0, 44605, 0, 0, 0, 0),
(3351, 0, 44614, 0, 0, 0, 0),
(3351, 0, 44615, 0, 0, 0, 0),
-- 'Alaindia <Reagents>'
(3562, 0, 44605, 0, 0, 0, 0),
(3562, 0, 44614, 0, 0, 0, 0),
(3562, 0, 44615, 0, 0, 0, 0),
-- 'Cyroen <Reagents>'
(4220, 0, 44605, 0, 0, 0, 0),
(4220, 0, 44614, 0, 0, 0, 0),
(4220, 0, 44615, 0, 0, 0, 0),
-- 'Hannah Akeley <Reagents>'
(4575, 0, 44605, 0, 0, 0, 0),
(4575, 0, 44614, 0, 0, 0, 0),
(4575, 0, 44615, 0, 0, 0, 0),
-- 'Barim Jurgenstaad <Reagents>'
(5110, 0, 44605, 0, 0, 0, 0),
(5110, 0, 44614, 0, 0, 0, 0),
(5110, 0, 44615, 0, 0, 0, 0),
-- 'Ginny Longberry <Reagents>'
(5151, 0, 44605, 0, 0, 0, 0),
(5151, 0, 44614, 0, 0, 0, 0),
(5151, 0, 44615, 0, 0, 0, 0),
-- 'Velanni <Alchemy Supplies & Reagents>'
(16612, 0, 44605, 0, 0, 0, 0),
(16612, 0, 44614, 0, 0, 0, 0),
(16612, 0, 44615, 0, 0, 0, 0),
-- 'Musal <Alchemy Supplies & Reagents>'
(16706, 0, 44605, 0, 0, 0, 0),
(16706, 0, 44614, 0, 0, 0, 0),
(16706, 0, 44615, 0, 0, 0, 0),
-- 'Bildine <Reagents>'
(16757, 0, 44605, 0, 0, 0, 0),
(16757, 0, 44614, 0, 0, 0, 0),
(16757, 0, 44615, 0, 0, 0, 0);
