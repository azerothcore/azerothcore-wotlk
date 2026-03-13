-- DB update 2024_11_14_04 -> 2024_11_14_05
--
DELETE FROM `smart_scripts` WHERE `entryorguid` IN
(-45537,-45570,-45571,-48394,-48400,-54994,-54996,-54999,-55062,-55064,-55065)
AND `event_type` = 61 AND `action_type` IN (18, 19);
