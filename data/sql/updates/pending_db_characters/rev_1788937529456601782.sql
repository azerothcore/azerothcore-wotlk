-- Cataclysm reserves slots 7-9; move the five WotLK property enchantments to slots 10-14.
-- Match only the old 36-word representation so rerunning the update leaves Cata rows alone.
UPDATE `item_instance` SET `enchantments` =
    CONCAT(SUBSTRING_INDEX(TRIM(`enchantments`), ' ', 21),
        ' 0 0 0 0 0 0 0 0 0 ',
        SUBSTRING_INDEX(TRIM(`enchantments`), ' ', -15), ' ')
WHERE
    LENGTH(TRIM(`enchantments`)) - LENGTH(REPLACE(TRIM(`enchantments`), ' ', '')) = 35;
