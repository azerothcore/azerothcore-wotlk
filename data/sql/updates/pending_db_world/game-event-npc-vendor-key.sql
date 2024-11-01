ALTER TABLE `game_event_npc_vendor`
	DROP PRIMARY KEY,
	ADD PRIMARY KEY (`eventEntry`, `guid`, `item`) USING BTREE;
