-- ALTER TABLE access_requirement ADD COLUMN reqItemLevel SMALLINT(5) UNSIGNED DEFAULT 0 NOT NULL;
UPDATE access_requirement SET item_level=0;

UPDATE access_requirement SET item_level=180 WHERE difficulty=1 AND mapId IN(
619, -- Azjol-Nerub: Ahn'kahet: The Old Kingdom
601, -- Azjol-Nerub: Azjol-Nerub
595, -- Caverns of Time: The Culling of Stratholme
600, -- Drak'Tharon Keep
604, -- Gundrak
576, -- The Nexus: The Nexus
578, -- The Nexus: The Oculus
608, -- The Violet Hold
602, -- Ulduar: Halls of Lightning
599, -- Ulduar: Halls of Stone
574, -- Utgarde Keep: Utgarde Keep
575 -- Utgarde Keep: Utgarde Pinnacle
);

UPDATE access_requirement SET item_level=180 WHERE difficulty=0 AND mapId IN(
650, -- Crusaders' Coliseum: Trial of the Champion
632, -- Icecrown Citadel: The Forge of Souls
658, -- Icecrown Citadel: Pit of Saron
668 -- Icecrown Citadel: Halls of Reflection
);

UPDATE access_requirement SET item_level=200 WHERE difficulty=1 AND mapId IN(
650, -- Crusaders' Coliseum: Trial of the Champion
632, -- Icecrown Citadel: The Forge of Souls
658 -- Icecrown Citadel: Pit of Saron
);

UPDATE access_requirement SET item_level=219 WHERE difficulty=1 AND mapId IN(
668 -- Icecrown Citadel: Halls of Reflection
);
