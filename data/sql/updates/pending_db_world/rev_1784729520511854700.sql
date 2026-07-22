-- Fix (Instance/Ulduar): teleporter greeting text was incorrect
UPDATE `broadcast_text`
SET `MaleText` = 'The teleporter appears to be active and stable.',
    `FemaleText` = 'The teleporter appears to be active and stable.'
WHERE `ID` = 33918;
