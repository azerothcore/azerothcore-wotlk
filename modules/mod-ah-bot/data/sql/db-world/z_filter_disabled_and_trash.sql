
INSERT IGNORE INTO mod_auctionhousebot_disabled_items (item)
SELECT entry
FROM item_template
WHERE (
    NAME LIKE '%tablet%' OR 
    NAME LIKE '%sulfuron%' OR 
    NAME LIKE '%nightcrawlers%' OR 
    NAME LIKE '%throwing dagger%' OR 
    NAME LIKE '%shot pouch%' OR 
    NAME LIKE '%brimstone%' OR 
    NAME LIKE '%small pouch%' OR 
    NAME LIKE '%dye%' OR 
    NAME LIKE '%ironwood seed%' OR 
    NAME LIKE '%stranglethorn seed%' OR 
    NAME LIKE '%simple wood%' OR 
    NAME LIKE '%bleach%' OR 
    NAME LIKE '%flour%' OR 
    NAME LIKE '%brew%' OR 
    NAME LIKE '%parchment%' OR 
    NAME LIKE '%light quiver%' OR 
    NAME LIKE '%honey%' OR 
    NAME LIKE '%/%' OR 
    NAME LIKE '%creeping anguish%' OR 
    NAME LIKE '%felcloth bag%' OR 
    NAME LIKE '%elementium ore%' OR 
    NAME LIKE '%unused%' OR 
    NAME LIKE '%lava core%' OR 
    NAME LIKE '%fiery core%' OR 
    NAME LIKE '%sulfuron ingot%' OR 
    NAME LIKE '%sak%' OR 
    NAME LIKE '%gigantique%' OR 
    NAME LIKE '%portable hole%' OR 
    NAME LIKE '%deptecated%' OR 
    NAME LIKE '%durability%' OR 
    NAME LIKE '%big sack%' OR 
    NAME LIKE '%decoded%' OR 
    NAME LIKE '%knowledge:%' OR 
    NAME LIKE '%manual%' OR 
    NAME LIKE '%gnome head%' OR 
    NAME LIKE '%critter enlarger%' OR 
    NAME LIKE '%box of%' OR 
    NAME LIKE '%summoning%' OR 
    NAME LIKE '%turtle egg%' OR 
    NAME LIKE '%heavy crate%' OR 
    NAME LIKE '%assasin throwing axe%' OR 
    NAME LIKE '%sack of gems%' OR 
    NAME LIKE '%plans: darkspear%' OR 
    NAME LIKE '%of swords%' OR 
    NAME LIKE '%gnomish alarm%' OR 
    NAME LIKE '%world enlarger%' OR 
    NAME LIKE '%tome%' OR 
    NAME LIKE '%ornate spyglass%' OR 
    NAME LIKE '%test%' OR 
    NAME LIKE '%darkmoon prize%' OR 
    NAME LIKE '%codex%' OR 
    NAME LIKE '%grimoire%' OR 
    NAME LIKE '%deprecated%' OR 
    NAME LIKE '%book%' OR 
    NAME LIKE '%libram%' OR 
    NAME LIKE '%guide%'
)
OR UPPER(NAME) LIKE '%OLD%' 
OR UPPER(NAME) LIKE '%NPC%' 
OR UPPER(NAME) LIKE '%QA%'
OR (CLASS = 0 AND SUBCLASS = 5 AND REQUIREDLEVEL < 40);
