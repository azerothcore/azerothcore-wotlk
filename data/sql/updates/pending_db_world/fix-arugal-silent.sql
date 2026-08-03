-- Fix Archmage Arugal is silend during Shadowfang Keep progression
-- All voices IDs were taken from Wowhead 
update acore_world.creature_text set Sound = 5793 where CreatureID = 4275 and BroadcastTextId = 6115;
update acore_world.creature_text set Sound = 5791 where CreatureID = 4275 and BroadcastTextId = 1435;
update acore_world.creature_text set Sound = 5797 where CreatureID = 4275 and BroadcastTextId = 6535;
update acore_world.creature_text set Sound = 5795 where CreatureID = 4275 and BroadcastTextId = 6116;
