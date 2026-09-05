-- Remove the SmartAI On-Aggro yell for Timmy the Cruel (10808)
-- so that "TIMMY!" only plays once during the emerge sequence
-- (controlled by EVENT_TIMMY_EMERGE in the instance script).
-- Retail behaviour: Timmy yells on emerge, not on aggro.
DELETE FROM smart_scripts WHERE entryorguid = 10808 AND id = 2;
