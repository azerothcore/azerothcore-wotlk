-- Grunnda Wolfheart: vendor stock must not also drop as creature loot.
DELETE FROM `creature_loot_template` WHERE `Entry` = 13218 AND `Item` IN (
    17348, 17349, 17351, 17352, 19029, 19031, 19046, 19083, 19085, 19087,
    19088, 19089, 19090, 19095, 19096, 19099, 19101, 19103, 19301, 19307,
    19308, 19309, 19310, 19311, 19312, 19315, 19316, 19317, 19318, 19319,
    19320, 19321, 19323, 19324, 19325
);
