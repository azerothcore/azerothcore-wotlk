-- Black Rose explicit socketable Ribbon and Mist item names.

UPDATE `item_template`
SET `class` = 3,
    `subclass` = CASE WHEN `entry` BETWEEN 900400 AND 900446 THEN 2 ELSE 0 END,
    `SoundOverrideSubclass` = -1,
    `name` = CASE
        WHEN `entry` BETWEEN 900300 AND 900306 THEN 'Stark Ribbon'
        WHEN `entry` BETWEEN 900310 AND 900316 THEN 'Klug Ribbon'
        WHEN `entry` BETWEEN 900320 AND 900326 THEN 'Geist Ribbon'
        WHEN `entry` BETWEEN 900330 AND 900336 THEN 'Schnell Ribbon'
        WHEN `entry` BETWEEN 900340 AND 900346 THEN 'Fett Ribbon'
        WHEN `entry` BETWEEN 900350 AND 900356 THEN 'Gross Ribbon'
        WHEN `entry` BETWEEN 900360 AND 900366 THEN 'Spinnst Ribbon'
        WHEN `entry` BETWEEN 900370 AND 900376 THEN 'Scharf Ribbon'
        WHEN `entry` BETWEEN 900380 AND 900386 THEN 'Weise Ribbon'
        WHEN `entry` BETWEEN 900400 AND 900406 THEN 'Pouvoir Mist'
        WHEN `entry` BETWEEN 900410 AND 900416 THEN 'Douleur Mist'
        WHEN `entry` BETWEEN 900420 AND 900426 THEN 'Pointe Mist'
        WHEN `entry` BETWEEN 900430 AND 900436 THEN 'Vitesse Mist'
        WHEN `entry` BETWEEN 900440 AND 900446 THEN 'Restaurer Mist'
        ELSE `name`
    END,
    `displayid` = CASE WHEN `entry` BETWEEN 900400 AND 900446 THEN 54318 ELSE 58601 END,
    `Quality` = 4,
    `BuyCount` = 1,
    `BuyPrice` = 0,
    `SellPrice` = 0,
    `InventoryType` = 0,
    `AllowableClass` = -1,
    `AllowableRace` = -1,
    `ItemLevel` = 20,
    `RequiredLevel` = 20,
    `maxcount` = 1,
    `stackable` = 1,
    `bonding` = 1,
    `description` = CASE `entry`
        WHEN 900300 THEN 'Grants The Black Rose +2 strength when socketed.'
        WHEN 900301 THEN 'Grants The Black Rose +22 strength when socketed.'
        WHEN 900302 THEN 'Grants The Black Rose +42 strength when socketed.'
        WHEN 900303 THEN 'Grants The Black Rose +62 strength when socketed.'
        WHEN 900304 THEN 'Grants The Black Rose +82 strength when socketed.'
        WHEN 900305 THEN 'Grants The Black Rose +102 strength when socketed.'
        WHEN 900306 THEN 'Grants The Black Rose +122 strength when socketed.'
        WHEN 900310 THEN 'Grants The Black Rose +2 intellect when socketed.'
        WHEN 900311 THEN 'Grants The Black Rose +22 intellect when socketed.'
        WHEN 900312 THEN 'Grants The Black Rose +42 intellect when socketed.'
        WHEN 900313 THEN 'Grants The Black Rose +62 intellect when socketed.'
        WHEN 900314 THEN 'Grants The Black Rose +82 intellect when socketed.'
        WHEN 900315 THEN 'Grants The Black Rose +102 intellect when socketed.'
        WHEN 900316 THEN 'Grants The Black Rose +122 intellect when socketed.'
        WHEN 900320 THEN 'Grants The Black Rose +2 spirit when socketed.'
        WHEN 900321 THEN 'Grants The Black Rose +22 spirit when socketed.'
        WHEN 900322 THEN 'Grants The Black Rose +42 spirit when socketed.'
        WHEN 900323 THEN 'Grants The Black Rose +62 spirit when socketed.'
        WHEN 900324 THEN 'Grants The Black Rose +82 spirit when socketed.'
        WHEN 900325 THEN 'Grants The Black Rose +102 spirit when socketed.'
        WHEN 900326 THEN 'Grants The Black Rose +122 spirit when socketed.'
        WHEN 900330 THEN 'Grants The Black Rose +2 agility when socketed.'
        WHEN 900331 THEN 'Grants The Black Rose +22 agility when socketed.'
        WHEN 900332 THEN 'Grants The Black Rose +42 agility when socketed.'
        WHEN 900333 THEN 'Grants The Black Rose +62 agility when socketed.'
        WHEN 900334 THEN 'Grants The Black Rose +82 agility when socketed.'
        WHEN 900335 THEN 'Grants The Black Rose +102 agility when socketed.'
        WHEN 900336 THEN 'Grants The Black Rose +122 agility when socketed.'
        WHEN 900340 THEN 'Grants The Black Rose +2 stamina when socketed.'
        WHEN 900341 THEN 'Grants The Black Rose +22 stamina when socketed.'
        WHEN 900342 THEN 'Grants The Black Rose +42 stamina when socketed.'
        WHEN 900343 THEN 'Grants The Black Rose +62 stamina when socketed.'
        WHEN 900344 THEN 'Grants The Black Rose +82 stamina when socketed.'
        WHEN 900345 THEN 'Grants The Black Rose +102 stamina when socketed.'
        WHEN 900346 THEN 'Grants The Black Rose +122 stamina when socketed.'
        WHEN 900350 THEN 'Grants The Black Rose +1 strength and +1 stamina when socketed.'
        WHEN 900351 THEN 'Grants The Black Rose +11 strength and +11 stamina when socketed.'
        WHEN 900352 THEN 'Grants The Black Rose +21 strength and +21 stamina when socketed.'
        WHEN 900353 THEN 'Grants The Black Rose +31 strength and +31 stamina when socketed.'
        WHEN 900354 THEN 'Grants The Black Rose +41 strength and +41 stamina when socketed.'
        WHEN 900355 THEN 'Grants The Black Rose +51 strength and +51 stamina when socketed.'
        WHEN 900356 THEN 'Grants The Black Rose +61 strength and +61 stamina when socketed.'
        WHEN 900360 THEN 'Grants The Black Rose +1 intellect and +1 spirit when socketed.'
        WHEN 900361 THEN 'Grants The Black Rose +11 intellect and +11 spirit when socketed.'
        WHEN 900362 THEN 'Grants The Black Rose +21 intellect and +21 spirit when socketed.'
        WHEN 900363 THEN 'Grants The Black Rose +31 intellect and +31 spirit when socketed.'
        WHEN 900364 THEN 'Grants The Black Rose +41 intellect and +41 spirit when socketed.'
        WHEN 900365 THEN 'Grants The Black Rose +51 intellect and +51 spirit when socketed.'
        WHEN 900366 THEN 'Grants The Black Rose +61 intellect and +61 spirit when socketed.'
        WHEN 900370 THEN 'Grants The Black Rose +1 strength and +1 agility when socketed.'
        WHEN 900371 THEN 'Grants The Black Rose +11 strength and +11 agility when socketed.'
        WHEN 900372 THEN 'Grants The Black Rose +21 strength and +21 agility when socketed.'
        WHEN 900373 THEN 'Grants The Black Rose +31 strength and +31 agility when socketed.'
        WHEN 900374 THEN 'Grants The Black Rose +41 strength and +41 agility when socketed.'
        WHEN 900375 THEN 'Grants The Black Rose +51 strength and +51 agility when socketed.'
        WHEN 900376 THEN 'Grants The Black Rose +61 strength and +61 agility when socketed.'
        WHEN 900380 THEN 'Grants The Black Rose +1 intellect and +1 stamina when socketed.'
        WHEN 900381 THEN 'Grants The Black Rose +11 intellect and +11 stamina when socketed.'
        WHEN 900382 THEN 'Grants The Black Rose +21 intellect and +21 stamina when socketed.'
        WHEN 900383 THEN 'Grants The Black Rose +31 intellect and +31 stamina when socketed.'
        WHEN 900384 THEN 'Grants The Black Rose +41 intellect and +41 stamina when socketed.'
        WHEN 900385 THEN 'Grants The Black Rose +51 intellect and +51 stamina when socketed.'
        WHEN 900386 THEN 'Grants The Black Rose +61 intellect and +61 stamina when socketed.'
        WHEN 900400 THEN 'Grants The Black Rose +6 spell power when socketed.'
        WHEN 900401 THEN 'Grants The Black Rose +26 spell power when socketed.'
        WHEN 900402 THEN 'Grants The Black Rose +86 spell power when socketed.'
        WHEN 900403 THEN 'Grants The Black Rose +126 spell power when socketed.'
        WHEN 900404 THEN 'Grants The Black Rose +166 spell power when socketed.'
        WHEN 900405 THEN 'Grants The Black Rose +206 spell power when socketed.'
        WHEN 900406 THEN 'Grants The Black Rose +246 spell power when socketed.'
        WHEN 900410 THEN 'Grants The Black Rose +6 attack power when socketed.'
        WHEN 900411 THEN 'Grants The Black Rose +26 attack power when socketed.'
        WHEN 900412 THEN 'Grants The Black Rose +86 attack power when socketed.'
        WHEN 900413 THEN 'Grants The Black Rose +126 attack power when socketed.'
        WHEN 900414 THEN 'Grants The Black Rose +166 attack power when socketed.'
        WHEN 900415 THEN 'Grants The Black Rose +206 attack power when socketed.'
        WHEN 900416 THEN 'Grants The Black Rose +246 attack power when socketed.'
        WHEN 900420 THEN 'Grants The Black Rose +6 crit rating when socketed.'
        WHEN 900421 THEN 'Grants The Black Rose +26 crit rating when socketed.'
        WHEN 900422 THEN 'Grants The Black Rose +86 crit rating when socketed.'
        WHEN 900423 THEN 'Grants The Black Rose +126 crit rating when socketed.'
        WHEN 900424 THEN 'Grants The Black Rose +166 crit rating when socketed.'
        WHEN 900425 THEN 'Grants The Black Rose +206 crit rating when socketed.'
        WHEN 900426 THEN 'Grants The Black Rose +246 crit rating when socketed.'
        WHEN 900430 THEN 'Grants The Black Rose +6 haste rating when socketed.'
        WHEN 900431 THEN 'Grants The Black Rose +26 haste rating when socketed.'
        WHEN 900432 THEN 'Grants The Black Rose +86 haste rating when socketed.'
        WHEN 900433 THEN 'Grants The Black Rose +126 haste rating when socketed.'
        WHEN 900434 THEN 'Grants The Black Rose +166 haste rating when socketed.'
        WHEN 900435 THEN 'Grants The Black Rose +206 haste rating when socketed.'
        WHEN 900436 THEN 'Grants The Black Rose +246 haste rating when socketed.'
        WHEN 900440 THEN 'Grants The Black Rose +10 mana per 5 seconds when socketed.'
        WHEN 900441 THEN 'Grants The Black Rose +25 mana per 5 seconds when socketed.'
        WHEN 900442 THEN 'Grants The Black Rose +50 mana per 5 seconds when socketed.'
        WHEN 900443 THEN 'Grants The Black Rose +75 mana per 5 seconds when socketed.'
        WHEN 900444 THEN 'Grants The Black Rose +200 mana per 5 seconds when socketed.'
        WHEN 900445 THEN 'Grants The Black Rose +325 mana per 5 seconds when socketed.'
        WHEN 900446 THEN 'Grants The Black Rose +525 mana per 5 seconds when socketed.'
        ELSE `description`
    END,
    `Material` = -1,
    `GemProperties` = `entry`,
    `VerifiedBuild` = 0
WHERE (`entry` BETWEEN 900300 AND 900306)
   OR (`entry` BETWEEN 900310 AND 900316)
   OR (`entry` BETWEEN 900320 AND 900326)
   OR (`entry` BETWEEN 900330 AND 900336)
   OR (`entry` BETWEEN 900340 AND 900346)
   OR (`entry` BETWEEN 900350 AND 900356)
   OR (`entry` BETWEEN 900360 AND 900366)
   OR (`entry` BETWEEN 900370 AND 900376)
   OR (`entry` BETWEEN 900380 AND 900386)
   OR (`entry` BETWEEN 900400 AND 900406)
   OR (`entry` BETWEEN 900410 AND 900416)
   OR (`entry` BETWEEN 900420 AND 900426)
   OR (`entry` BETWEEN 900430 AND 900436)
   OR (`entry` BETWEEN 900440 AND 900446);
