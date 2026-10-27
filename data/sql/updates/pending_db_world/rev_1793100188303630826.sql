--
-- Set Kologarn EMOTE_EYES (9) to Boss Whisper (42)
UPDATE `creature_text` SET `Type` = 42 WHERE (`CreatureID` = 32930) AND (`GroupID` = 9);
