DELETE FROM creature_loot_template
WHERE (
Item = 20874 #Idol of the Sun
OR Item = 20875 #Idol of Night
OR Item = 20876 #Idol of Death
OR Item = 20877 #Idol of the Sage
OR Item = 20878 #Idol of Rebirth
OR Item = 20879 #Idol of Life
OR Item = 20881 #Idol of Strife
OR Item = 20882 #Idol of War
) AND (
Entry = 15318 #Hive'Zara Drone
OR Entry = 15323 #Hive'Zara Sandstalker
OR Entry = 15325 #Hive'Zara Wasp
OR Entry = 15327 #Hive'Zara Stinger
OR Entry = 15333 #Silicate Feeder
OR Entry = 15336 #Hive'Zara Tail Lasher
OR Entry = 15338 #Obsidian Destroyer
OR Entry = 15343 #Qiraji Swarmguard
OR Entry = 15355 #Anubisath Guardian
OR Entry = 15386 #Major Yeggeth
OR Entry = 15392 #Captain Tuubid
);
