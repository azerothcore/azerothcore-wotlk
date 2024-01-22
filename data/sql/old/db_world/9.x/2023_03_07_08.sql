-- DB update 2023_03_07_07 -> 2023_03_07_08
-- Event: Pilgrim's Bounty - Few Wild Turkeys having npc gossip flag.
UPDATE `creature` SET `npcflag` = `npcflag`&~(1) WHERE `id1` = 32820 AND `guid` IN (241384,241659,241674,241862,241865,241944,241948,241961,242367,242369,242416,242952,243003,243102,243735,243736,243774,243775);
