-- DB update 2022_09_07_09 -> 2022_09_08_00
DELETE FROM creature_loot_template
WHERE Item IN (
	20874, #Idol of the Sun
	20875, #Idol of Night
	20876, #Idol of Death
	20877, #Idol of the Sage
	20878, #Idol of Rebirth
	20879, #Idol of Life
	20881, #Idol of Strife
	20882  #Idol of War
) AND Entry IN (
	15318, #Hive'Zara Drone
	15323, #Hive'Zara Sandstalker
	15325, #Hive'Zara Wasp
	15327, #Hive'Zara Stinger
	15333, #Silicate Feeder
	15336, #Hive'Zara Tail Lasher
	15338, #Obsidian Destroyer
	15343, #Qiraji Swarmguard
	15355, #Anubisath Guardian
	15386, #Major Yeggeth
	15392  #Captain Tuubid
);

