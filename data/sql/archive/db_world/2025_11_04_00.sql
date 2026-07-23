-- DB update 2025_11_03_01 -> 2025_11_04_00
-- fix appearances of newly added 'Winter Reveler's
-- assign correct model to creature 15792 `Troll Male Winter Reveler` used by spell 26252 `Winter Reveler - Troll Male`
UPDATE `creature_template_model` SET `CreatureDisplayID` = 18809, `VerifiedBuild` = 0 WHERE (`CreatureID` = 15792) AND (`Idx` = 0);

-- assign costume auras
DELETE FROM `creature_addon` WHERE (`guid` BETWEEN 66801 AND 66898);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(66801, 0, 0, 0, 1, 0, 0, '26247'), -- Orc Female
(66802, 0, 0, 0, 1, 0, 0, '26248'), -- Orc Male
(66803, 0, 0, 0, 1, 0, 0, '26247'), -- Orc Female
(66804, 0, 0, 0, 1, 0, 0, '26248'), -- Orc Male
(66805, 0, 0, 0, 1, 0, 0, '26239'), -- Human Male
(66806, 0, 0, 0, 1, 0, 0, '26240'), -- Human Female
(66807, 0, 0, 0, 1, 0, 0, '26239'), -- Human Male
(66808, 0, 0, 0, 1, 0, 0, '26240'), -- Human Female
(66809, 0, 0, 0, 1, 0, 0, '26251'), -- Troll Female
(66810, 0, 0, 0, 1, 0, 0, '26252'), -- Troll Male
(66811, 0, 0, 0, 1, 0, 0, '26249'), -- Tauren Female
(66812, 0, 0, 0, 1, 0, 0, '26250'), -- Tauren Male
(66813, 0, 0, 0, 1, 0, 0, '26241'), -- Dwarf Male
(66814, 0, 0, 0, 1, 0, 0, '26242'), -- Dwarf Female
(66815, 0, 0, 0, 1, 0, 0, '26253'), -- Undead Female
(66816, 0, 0, 0, 1, 0, 0, '26254'), -- Undead Male
(66817, 0, 0, 0, 1, 0, 0, '26243'), -- Goblin Female
(66818, 0, 0, 0, 1, 0, 0, '26244'), -- Goblin Male
(66819, 0, 0, 0, 1, 0, 0, '26249'), -- Tauren Female
(66820, 0, 0, 0, 1, 0, 0, '26250'), -- Tauren Male
(66821, 0, 0, 0, 1, 0, 0, '26249'), -- Tauren Female
(66822, 0, 0, 0, 1, 0, 0, '26250'), -- Tauren Male
(66823, 0, 0, 0, 1, 0, 0, '26239'), -- Human Male
(66824, 0, 0, 0, 1, 0, 0, '26240'), -- Human Female
(66825, 0, 0, 0, 1, 0, 0, '26245'), -- Night Elf Female
(66826, 0, 0, 0, 1, 0, 0, '26246'), -- Night Elf Male
(66827, 0, 0, 0, 1, 0, 0, '26249'), -- Tauren Female
(66828, 0, 0, 0, 1, 0, 0, '26250'), -- Tauren Male
(66829, 0, 0, 0, 1, 0, 0, '26249'), -- Tauren Female
(66830, 0, 0, 0, 1, 0, 0, '26250'), -- Tauren Male
(66831, 0, 0, 0, 1, 0, 0, '39860'), -- Blood Elf Female
(66832, 0, 0, 0, 1, 0, 0, '39861'), -- Blood Elf Male
(66833, 0, 0, 0, 1, 0, 0, '26243'), -- Goblin Female
(66834, 0, 0, 0, 1, 0, 0, '26244'), -- Goblin Male
(66835, 0, 0, 0, 1, 0, 0, '26245'), -- Night Elf Female
(66836, 0, 0, 0, 1, 0, 0, '26246'), -- Night Elf Male
(66837, 0, 0, 0, 1, 0, 0, '26247'), -- Orc Female
(66838, 0, 0, 0, 1, 0, 0, '26248'), -- Orc Male
(66839, 0, 0, 0, 1, 0, 0, '26245'), -- Night Elf Female
(66840, 0, 0, 0, 1, 0, 0, '26246'), -- Night Elf Male
(66841, 0, 0, 0, 1, 0, 0, '26245'), -- Night Elf Female
(66842, 0, 0, 0, 1, 0, 0, '26246'), -- Night Elf Male
(66843, 0, 0, 0, 1, 0, 0, '26245'), -- Night Elf Female
(66844, 0, 0, 0, 1, 0, 0, '26246'), -- Night Elf Male
(66845, 0, 0, 0, 1, 0, 0, '26243'), -- Goblin Female
(66846, 0, 0, 0, 1, 0, 0, '26244'), -- Goblin Male
(66847, 0, 0, 0, 1, 0, 0, '26247'), -- Orc Female
(66848, 0, 0, 0, 1, 0, 0, '26248'), -- Orc Male
(66849, 0, 0, 0, 1, 0, 0, '39858'), -- Draenei Female
(66850, 0, 0, 0, 1, 0, 0, '39859'), -- Draenei Male
(66851, 0, 0, 0, 1, 0, 0, '39860'), -- Blood Elf Female
(66852, 0, 0, 0, 1, 0, 0, '39861'), -- Blood Elf Male
(66853, 0, 0, 0, 1, 0, 0, '26247'), -- Orc Female
(66854, 0, 0, 0, 1, 0, 0, '26248'), -- Orc Male
(66855, 0, 0, 0, 1, 0, 0, '39860'), -- Blood Elf Female
(66856, 0, 0, 0, 1, 0, 0, '39861'), -- Blood Elf Male
(66857, 0, 0, 0, 1, 0, 0, '26247'), -- Orc Female
(66858, 0, 0, 0, 1, 0, 0, '26248'), -- Orc Male
(66859, 0, 0, 0, 1, 0, 0, '39858'), -- Draenei Female
(66860, 0, 0, 0, 1, 0, 0, '39859'), -- Draenei Male
(66861, 0, 0, 0, 1, 0, 0, '39858'), -- Draenei Female
(66862, 0, 0, 0, 1, 0, 0, '39859'), -- Draenei Male
(66863, 0, 0, 0, 1, 0, 0, '26241'), -- Dwarf Male
(66864, 0, 0, 0, 1, 0, 0, '26242'), -- Dwarf Female
(66865, 0, 0, 0, 1, 0, 0, '39860'), -- Blood Elf Female
(66866, 0, 0, 0, 1, 0, 0, '39861'), -- Blood Elf Male
(66867, 0, 0, 0, 1, 0, 0, '39860'), -- Blood Elf Female
(66868, 0, 0, 0, 1, 0, 0, '39861'), -- Blood Elf Male
(66869, 0, 0, 0, 1, 0, 0, '26239'), -- Human Male
(66870, 0, 0, 0, 1, 0, 0, '26240'), -- Human Female
(66871, 0, 0, 0, 1, 0, 0, '39858'), -- Draenei Female
(66872, 0, 0, 0, 1, 0, 0, '39859'), -- Draenei Male
(66873, 0, 0, 0, 1, 0, 0, '26253'), -- Undead Female
(66874, 0, 0, 0, 1, 0, 0, '26254'), -- Undead Male
(66875, 0, 0, 0, 1, 0, 0, '39876'), -- Gnome Female
(66876, 0, 0, 0, 1, 0, 0, '39877'), -- Gnome Male
(66877, 0, 0, 0, 1, 0, 0, '26245'), -- Night Elf Female
(66878, 0, 0, 0, 1, 0, 0, '26246'), -- Night Elf Male
(66879, 0, 0, 0, 1, 0, 0, '26251'), -- Troll Female
(66880, 0, 0, 0, 1, 0, 0, '26252'), -- Troll Male
(66881, 0, 0, 0, 1, 0, 0, '39858'), -- Draenei Female
(66882, 0, 0, 0, 1, 0, 0, '39859'), -- Draenei Male
(66883, 0, 0, 0, 1, 0, 0, '26247'), -- Orc Female
(66884, 0, 0, 0, 1, 0, 0, '26248'), -- Orc Male
(66885, 0, 0, 0, 1, 0, 0, '39858'), -- Draenei Female
(66886, 0, 0, 0, 1, 0, 0, '39859'), -- Draenei Male
(66887, 0, 0, 0, 1, 0, 0, '39860'), -- Blood Elf Female
(66888, 0, 0, 0, 1, 0, 0, '39861'), -- Blood Elf Male
(66889, 0, 0, 0, 1, 0, 0, '26243'), -- Goblin Female
(66890, 0, 0, 0, 1, 0, 0, '26244'), -- Goblin Male
(66891, 0, 0, 0, 1, 0, 0, '39860'), -- Blood Elf Female
(66892, 0, 0, 0, 1, 0, 0, '39861'), -- Blood Elf Male
(66893, 0, 0, 0, 1, 0, 0, '39860'), -- Blood Elf Female
(66894, 0, 0, 0, 1, 0, 0, '39861'), -- Blood Elf Male
(66895, 0, 0, 0, 1, 0, 0, '26239'), -- Human Male
(66896, 0, 0, 0, 1, 0, 0, '26240'), -- Human Female
(66897, 0, 0, 0, 1, 0, 0, '39860'), -- Blood Elf Female
(66898, 0, 0, 0, 1, 0, 0, '39861'); -- Blood Elf Male
