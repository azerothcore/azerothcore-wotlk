--
-- Most Ulduar, ToC, and ICC bosses have parry haste incorrectly enabled
-- Set NO_PARRY_HASTEN - creature can't counter-attack at parry
SET @NO_PARRY_HASTEN := 8;

UPDATE `creature_template` SET `flags_extra` = (`flags_extra` | @NO_PARRY_HASTEN)  WHERE (`entry` IN (
-- Patchwerk
16028,
29324,
-- Ignis
33118,
33190,
-- Razorscale
33186,
33724,
-- Steelbreaker
32867,
33693,
-- XT-002 Deconstructor
33293,
33885,
-- Kologarn
32930,
33909,
-- Algalon the Observer
32871,
33070,
-- Runemaster Molgeim
32927,
33692,
-- Stormcaller Brundir
32857,
33694,
-- Hodir
32845,
32846,
-- Freya
32906,
33360,
-- Leviathan Mk II
33432,
34106,
-- Anti-personnel Assault Cannon
33651,
34108,
-- Aerial Command Unit
33670,
34109,
-- General Vezax
33271,
33449,
-- Lord Jaraxxus
34780,
35216,
35268,
35269,
-- Fjola Lightbane
34497,
35350,
35351,
35352,
-- Eydis Darkbane
34496,
35347,
35348,
35349,
-- Anub'arak
34564,
34566,
35615,
35616,
-- Lord Marrowgar
36612,
37957,
37958,
37959,
-- High Overlord Saurfang
36939,
38156,
38637,
38638,
-- Muradin Bronzebeard
36948,
38157,
38639,
38640,
-- Deathbringer Saurfang
37813,
38402,
38582,
38583,
-- Festergut
36626,
37504,
37505,
37506,
-- Rotface
36627,
38390,
38549,
38550,
-- Professor Putricide
36678,
38431,
38585,
38586,
-- Prince Keleseth
37972,
38399,
38769,
38770,
-- Prince Taldaram
37973,
38400,
38771,
38772,
-- Prince Valanar
37970,
38401,
38784,
38785,
-- Blood-Queen Lana'thel
37955,
38434,
38435,
38436,
-- The Lich King
36597,
39166,
39167,
39168,
));
