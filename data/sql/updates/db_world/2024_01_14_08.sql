-- DB update 2024_01_14_07 -> 2024_01_14_08
-- Move GameObjectScript go_midsummer_bonfire to SAI
-- Alliance Bonfires
SET @GO1  := 187944;
SET @GO2  := 187920;
SET @GO3  := 187926;
SET @GO4  := 187564;
SET @GO5  := 187934;
SET @GO6  := 187928;
SET @GO7  := 187922;
SET @GO8  := 187925;
SET @GO9  := 187932;
SET @GO10 := 187940;
SET @GO11 := 187914;
SET @GO12 := 187931;
SET @GO13 := 187938;
SET @GO14 := 187939;
SET @GO15 := 187945;
SET @GO16 := 187943;
SET @GO17 := 187929;
SET @GO18 := 187927;
SET @GO19 := 187924;
SET @GO20 := 187916;
SET @GO21 := 187923;
SET @GO22 := 187946;
SET @GO23 := 187936;
SET @GO24 := 187917;
SET @GO25 := 187935;
SET @GO26 := 187937;
SET @GO27 := 187933;
SET @GO28 := 187921;
SET @GO29 := 187930;
SET @GO30 := 187941;
SET @GO31 := 187919;
SET @GO32 := 187942;
SET @GO33 := 194038;
SET @GO34 := 194040;
SET @GO35 := 194036;
SET @GO36 := 194032;
SET @GO37 := 194045;
SET @GO38 := 194035;
SET @GO39 := 194049;
SET @GO40 := 194044;

-- Horde Bonfires
SET @GO41 := 187951;
SET @GO42 := 187969;
SET @GO43 := 187956;
SET @GO44 := 187954;
SET @GO45 := 187947;
SET @GO46 := 187972;
SET @GO47 := 187964;
SET @GO48 := 187559;
SET @GO49 := 187974;
SET @GO50 := 187952;
SET @GO51 := 187950;
SET @GO52 := 187973;
SET @GO53 := 187961;
SET @GO54 := 187959;
SET @GO55 := 187965;
SET @GO56 := 187957;
SET @GO57 := 187971;
SET @GO58 := 187958;
SET @GO59 := 187968;
SET @GO60 := 187948;
SET @GO61 := 187953;
SET @GO62 := 187967;
SET @GO63 := 187970;
SET @GO64 := 187966;
SET @GO65 := 187963;
SET @GO66 := 187975;
SET @GO67 := 187955;
SET @GO68 := 187949;
SET @GO69 := 187962;
SET @GO70 := 187960;
SET @GO71 := 194039;
SET @GO72 := 194042;
SET @GO73 := 194037;
SET @GO74 := 194033;
SET @GO75 := 194048;
SET @GO76 := 194034;
SET @GO77 := 194046;
SET @GO78 := 194043;

UPDATE `gameobject_template` SET `ScriptName` = '', `AIName` = 'SmartGameObjectAI' WHERE (`entry` IN (@GO1, @GO2, @GO3, @GO4, @GO5, @GO6, @GO7, @GO8, @GO9, @GO10, @GO11, @GO12, @GO13, @GO14, @GO15, @GO16, @GO17, @GO18, @GO19, @GO20, @GO21, @GO22, @GO23, @GO24, @GO25, @GO26, @GO27, @GO28, @GO29, @GO30, @GO31, @GO32, @GO33, @GO34, @GO35, @GO36, @GO37, @GO38, @GO39, @GO40, @GO41, @GO42, @GO43, @GO44, @GO45, @GO46, @GO47, @GO48, @GO49, @GO50, @GO51, @GO52, @GO53, @GO54, @GO55, @GO56, @GO57, @GO58, @GO59, @GO60, @GO61, @GO62, @GO63, @GO64, @GO65, @GO66, @GO67, @GO68, @GO69, @GO70, @GO71, @GO72, @GO73, @GO74, @GO75, @GO76, @GO77, @GO78));

DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` IN (@GO1, @GO2, @GO3, @GO4, @GO5, @GO6, @GO7, @GO8, @GO9, @GO10, @GO11, @GO12, @GO13, @GO14, @GO15, @GO16, @GO17, @GO18, @GO19, @GO20, @GO21, @GO22, @GO23, @GO24, @GO25, @GO26, @GO27, @GO28, @GO29, @GO30, @GO31, @GO32, @GO33, @GO34, @GO35, @GO36, @GO37, @GO38, @GO39, @GO40, @GO41, @GO42, @GO43, @GO44, @GO45, @GO46, @GO47, @GO48, @GO49, @GO50, @GO51, @GO52, @GO53, @GO54, @GO55, @GO56, @GO57, @GO58, @GO59, @GO60, @GO61, @GO62, @GO63, @GO64, @GO65, @GO66, @GO67, @GO68, @GO69, @GO70, @GO71, @GO72, @GO73, @GO74, @GO75, @GO76, @GO77, @GO78));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
-- Alliance Bonfires
(@GO1 , 1, 0, 1, 62, 0, 100, 0,  9411, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO2 , 1, 0, 1, 62, 0, 100, 0,  9386, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO3 , 1, 0, 1, 62, 0, 100, 0,  9392, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO4 , 1, 0, 1, 62, 0, 100, 0,  9406, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO5 , 1, 0, 1, 62, 0, 100, 0,  9400, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO6 , 1, 0, 1, 62, 0, 100, 0,  9394, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO7 , 1, 0, 1, 62, 0, 100, 0,  9388, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO8 , 1, 0, 1, 62, 0, 100, 0,  9391, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO9 , 1, 0, 1, 62, 0, 100, 0,  9398, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO10, 1, 0, 1, 62, 0, 100, 0,  9407, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO11, 1, 0, 1, 62, 0, 100, 0,  9352, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO12, 1, 0, 1, 62, 0, 100, 0,  9397, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO13, 1, 0, 1, 62, 0, 100, 0,  9404, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO14, 1, 0, 1, 62, 0, 100, 0,  9405, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO15, 1, 0, 1, 62, 0, 100, 0,  9412, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO16, 1, 0, 1, 62, 0, 100, 0,  9410, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO17, 1, 0, 1, 62, 0, 100, 0,  9395, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO18, 1, 0, 1, 62, 0, 100, 0,  9393, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO19, 1, 0, 1, 62, 0, 100, 0,  9390, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO20, 1, 0, 1, 62, 0, 100, 0,  9354, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO21, 1, 0, 1, 62, 0, 100, 0,  9389, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO22, 1, 0, 1, 62, 0, 100, 0,  9413, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO23, 1, 0, 1, 62, 0, 100, 0,  9402, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO24, 1, 0, 1, 62, 0, 100, 0,  9384, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO25, 1, 0, 1, 62, 0, 100, 0,  9401, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO26, 1, 0, 1, 62, 0, 100, 0,  9403, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO27, 1, 0, 1, 62, 0, 100, 0,  9399, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO28, 1, 0, 1, 62, 0, 100, 0,  9387, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO29, 1, 0, 1, 62, 0, 100, 0,  9396, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO30, 1, 0, 1, 62, 0, 100, 0,  9408, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO31, 1, 0, 1, 62, 0, 100, 0,  9385, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO32, 1, 0, 1, 62, 0, 100, 0,  9409, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO33, 1, 0, 1, 62, 0, 100, 0, 10234, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO34, 1, 0, 1, 62, 0, 100, 0, 10237, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO35, 1, 0, 1, 62, 0, 100, 0, 10233, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO36, 1, 0, 1, 62, 0, 100, 0, 10227, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO37, 1, 0, 1, 62, 0, 100, 0, 10240, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO38, 1, 0, 1, 62, 0, 100, 0, 10230, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO39, 1, 0, 1, 62, 0, 100, 0, 10243, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO40, 1, 0, 1, 62, 0, 100, 0, 10238, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
-- Horde Bonfires
(@GO41, 1, 0, 1, 62, 0, 100, 0,  9381, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO42, 1, 0, 1, 62, 0, 100, 0,  9372, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO43, 1, 0, 1, 62, 0, 100, 0,  9358, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO44, 1, 0, 1, 62, 0, 100, 0,  9356, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO45, 1, 0, 1, 62, 0, 100, 0,  9353, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO46, 1, 0, 1, 62, 0, 100, 0,  9375, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO47, 1, 0, 1, 62, 0, 100, 0,  9366, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO48, 1, 0, 1, 62, 0, 100, 0,  9370, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO49, 1, 0, 1, 62, 0, 100, 0,  9377, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO50, 1, 0, 1, 62, 0, 100, 0,  9382, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO51, 1, 0, 1, 62, 0, 100, 0,  9380, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO52, 1, 0, 1, 62, 0, 100, 0,  9376, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO53, 1, 0, 1, 62, 0, 100, 0,  9363, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO54, 1, 0, 1, 62, 0, 100, 0,  9361, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO55, 1, 0, 1, 62, 0, 100, 0,  9367, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO56, 1, 0, 1, 62, 0, 100, 0,  9359, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO57, 1, 0, 1, 62, 0, 100, 0,  9374, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO58, 1, 0, 1, 62, 0, 100, 0,  9360, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO59, 1, 0, 1, 62, 0, 100, 0,  9371, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO60, 1, 0, 1, 62, 0, 100, 0,  9355, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO61, 1, 0, 1, 62, 0, 100, 0,  9383, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO62, 1, 0, 1, 62, 0, 100, 0,  9369, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO63, 1, 0, 1, 62, 0, 100, 0,  9373, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO64, 1, 0, 1, 62, 0, 100, 0,  9368, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO65, 1, 0, 1, 62, 0, 100, 0,  9365, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO66, 1, 0, 1, 62, 0, 100, 0,  9378, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO67, 1, 0, 1, 62, 0, 100, 0,  9357, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO68, 1, 0, 1, 62, 0, 100, 0,  9379, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO69, 1, 0, 1, 62, 0, 100, 0,  9364, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO70, 1, 0, 1, 62, 0, 100, 0,  9362, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO71, 1, 0, 1, 62, 0, 100, 0, 10235, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO72, 1, 0, 1, 62, 0, 100, 0, 10236, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO73, 1, 0, 1, 62, 0, 100, 0, 10232, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO74, 1, 0, 1, 62, 0, 100, 0, 10228, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO75, 1, 0, 1, 62, 0, 100, 0, 10242, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO76, 1, 0, 1, 62, 0, 100, 0, 10231, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO77, 1, 0, 1, 62, 0, 100, 0, 10241, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
(@GO78, 1, 0, 1, 62, 0, 100, 0, 10239, 0, 0, 0, 0, 0, 134, 45437, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Invoker Cast \'Stamp Out Bonfire\''),
--
(@GO1 , 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO2 , 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO3 , 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO4 , 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO5 , 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO6 , 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO7 , 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO8 , 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO9 , 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO10, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO11, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO12, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO13, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO14, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO15, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO16, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO17, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO18, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO19, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO20, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO21, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO22, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO23, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO24, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO25, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO26, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO27, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO28, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO29, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO30, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO31, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO32, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO33, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO34, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO35, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO36, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO37, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO38, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO39, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO40, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO41, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO42, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO43, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO44, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO45, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO46, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO47, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO48, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO49, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO50, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO51, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO52, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO53, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO54, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO55, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO56, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO57, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO58, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO59, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO60, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO61, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO62, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO63, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO64, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO65, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO66, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO67, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO68, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO69, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO70, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO71, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO72, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO73, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO74, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO75, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO76, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO77, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Close Gossip'),
(@GO78, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Bonfire - On Gossip Option 0 Selected - Close Gossip');
