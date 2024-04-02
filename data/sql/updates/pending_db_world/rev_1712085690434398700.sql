-- remove duplicate 'Door' spawns from Black Temple
DELETE from `gameobject` WHERE (`id` IN (185482, 185892, 185479, 185478, 185481, 185480)) AND (`guid` IN (20567, 20523, 20559, 20558, 20563, 20561));
