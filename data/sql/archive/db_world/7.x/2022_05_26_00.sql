-- DB update 2022_05_25_04 -> 2022_05_26_00
--

-- Content info for Durotar Shaman Quest [Rune-Inscribed Parchment]
-- EN/US Text
UPDATE `page_text`  SET `Text` = "Lok-tar, $gbrother:sister;. The elements beckon you closer and bid me to show you the path of the shaman. The spirits of our ancestors watch from beyond and swell with pride knowing you have joined our ranks.$B$BWhen you are ready, seek me out near the entrance to the Den. It is there that I will be training others of our kind. Until then, may the wind be at your back.$B$BShikrik, Shaman Trainer" WHERE `id` = 2461;

-- FR Text
UPDATE `page_text_locale`  SET `Text` = "Lok-tar, $gfrère:sœur;. Les éléments annoncent votre venue et me demandent de vous guider sur la voie du chaman. Les esprits de nos ancêtres observent depuis l'au-delà et tremblent de fierté à l'idée que vous ayez rejoint nos rangs.$B$BQuand vous le jugerez bon, venez me voir à l'entrée de l'Antre. C'est là que je forme les nôtres. Jusque là, que les vents vous soient favorables.$B$BShikrik, Maître des chamans" WHERE `id` = 2461 AND `locale` = 'frFR';

