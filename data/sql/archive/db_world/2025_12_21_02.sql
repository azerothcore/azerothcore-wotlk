-- DB update 2025_12_21_01 -> 2025_12_21_02
UPDATE `creature` SET `phaseMask` = 511 WHERE `id1` IN (
32357, -- Old Crystalbark
32358, -- Fumblub Gearwind
32361, -- Icehorn
32377, -- Perobas the Bloodthirster
32386, -- Vigdis the War Maiden
32398, -- King Ping
32400, -- Tukemuth
32409, -- Crazed Indu'le Survivor
32417, -- Scarlet Highlord Daion
32422, -- Grocklar
32429, -- Seething Hate
32438, -- Syreian the Bonecarver
32447, -- Zul'drak Sentinel
32471, -- Griegen
32475, -- Terror Spinner
32481, -- Aotona
32485, -- King Krush
32487, -- Putridus the Ancient
32491, -- Time-Lost Proto Drake
32495, -- Hildana Deathstealer
32500, -- Dirkee
32501, -- High Thane Jorfus
32517 -- Loque'nahak
-- 32630, -- Vyragosa, see TLPD
);
