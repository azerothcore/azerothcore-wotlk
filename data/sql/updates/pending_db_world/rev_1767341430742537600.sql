-- correctly link brewfest building event in ironforge to brewfest
UPDATE `game_event` SET `holiday` = 372, `holidayStage` = 1 WHERE `eventEntry` = 70;
