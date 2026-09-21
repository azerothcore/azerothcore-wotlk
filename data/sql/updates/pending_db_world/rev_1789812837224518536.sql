-- Burst Target: VX-001 aims Rapid Burst at it, so it has to stay where it was summoned. Without the trigger flag its
-- hostile faction gives it AggressorAI, and it chases the player it was summoned on, dragging the volley along.
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 128 WHERE `entry` = 34211;
