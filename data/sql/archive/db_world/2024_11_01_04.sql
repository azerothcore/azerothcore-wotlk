-- DB update 2024_11_01_03 -> 2024_11_01_04
ALTER TABLE `game_event_npc_vendor`
	DROP PRIMARY KEY,
	ADD PRIMARY KEY (`eventEntry`, `guid`, `item`) USING BTREE;
