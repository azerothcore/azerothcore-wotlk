-- DB update 2024_10_13_01 -> 2024_10_13_02

UPDATE creature SET `phaseMask`=`phaseMask`& ~1 WHERE (id1 = 28660) AND (guid IN (129474, 129475, 129476, 129477, 129478, 129479));
UPDATE creature SET `phaseMask`=`phaseMask`|2  WHERE (id1 = 28660) AND (guid IN (129474, 129475, 129476, 129477, 129478, 129479)); 

UPDATE creature SET `phaseMask`=`phaseMask`& ~1 WHERE (`id1` = 28560) AND (`guid` IN (128800, 128801, 128802));
UPDATE creature SET `phaseMask`=`phaseMask`|2 WHERE (`id1` = 28560) AND (`guid` IN (128800, 128801, 128802));

UPDATE creature SET `phaseMask`=`phaseMask`& ~1 WHERE (`id1` = 28559) AND (`guid` IN (128797, 128798, 128799));
UPDATE creature SET `phaseMask`=`phaseMask`|2 WHERE (`id1` = 28559) AND (`guid` IN (128797, 128798, 128799));

UPDATE creature SET `phaseMask`=`phaseMask`& ~1 WHERE (`id1` = 28662) AND (`guid` IN (129483, 129484, 129485, 129486, 129487, 129488, 129489, 129490, 129491));
UPDATE creature SET `phaseMask`=`phaseMask`|2 WHERE (`id1` = 28662) AND (`guid` IN (129483, 129484, 129485, 129486, 129487, 129488, 129489, 129490, 129491));

UPDATE creature SET `phaseMask`=`phaseMask`& ~1 WHERE (`id1` = 28548) AND (`guid` IN (128752));
UPDATE creature SET `phaseMask`=`phaseMask`|2 WHERE (`id1` = 28548) AND (`guid` IN (128752));

UPDATE creature SET `phaseMask`=`phaseMask`& ~1 WHERE (`id1` = 28558) AND (`guid` IN (128796));
UPDATE creature SET `phaseMask`=`phaseMask`|2 WHERE (`id1` = 28558) AND (`guid` IN (128796));

UPDATE creature SET `phaseMask`=`phaseMask`& ~1 WHERE (`id1` = 28529) AND (`guid` IN (128627, 128628, 128629, 128630, 128631, 128632, 128633, 128634, 128635, 128636, 128637, 128638, 128639, 128640, 128642, 128643, 128644, 128645, 128646, 128647, 128648, 128649, 128650, 128651, 128652, 128653, 128654, 128655, 128656, 128657, 128658, 128659, 128660, 128661, 128662, 128663, 128664, 128665, 128666, 128667, 128668, 128669, 128670, 128671, 128672, 128673, 128674, 128675, 128676, 128677, 128678, 128679, 128680, 128681, 128682, 128683, 128684, 128685, 128686, 128687, 128688, 128689, 128690, 128691, 128692, 128693, 128694, 128695, 128696, 128698, 128699, 128700, 128701, 128702, 128703, 128704, 128705, 128706, 128707, 128708, 128709, 128710, 128711, 128712, 128713, 128714, 128715, 128716, 128717, 128718, 128719, 128720, 128721, 128722, 128723, 128724, 128725, 128726, 128727, 128728, 128729, 128730, 128731, 128732, 128733, 128734));
UPDATE creature SET `phaseMask`=`phaseMask`|2 WHERE (`id1` = 28529) AND (`guid` IN (128627, 128628, 128629, 128630, 128631, 128632, 128633, 128634, 128635, 128636, 128637, 128638, 128639, 128640, 128642, 128643, 128644, 128645, 128646, 128647, 128648, 128649, 128650, 128651, 128652, 128653, 128654, 128655, 128656, 128657, 128658, 128659, 128660, 128661, 128662, 128663, 128664, 128665, 128666, 128667, 128668, 128669, 128670, 128671, 128672, 128673, 128674, 128675, 128676, 128677, 128678, 128679, 128680, 128681, 128682, 128683, 128684, 128685, 128686, 128687, 128688, 128689, 128690, 128691, 128692, 128693, 128694, 128695, 128696, 128698, 128699, 128700, 128701, 128702, 128703, 128704, 128705, 128706, 128707, 128708, 128709, 128710, 128711, 128712, 128713, 128714, 128715, 128716, 128717, 128718, 128719, 128720, 128721, 128722, 128723, 128724, 128725, 128726, 128727, 128728, 128729, 128730, 128731, 128732, 128733, 128734));

UPDATE creature SET `phaseMask`=`phaseMask`& ~1 WHERE (`id1` = 28530) AND (`guid` IN (128735, 128736, 128737));
UPDATE creature SET `phaseMask`=`phaseMask`|2 WHERE (`id1` = 28530) AND (`guid` IN (128735, 128736, 128737));

UPDATE creature SET `phaseMask`=`phaseMask`& ~1 WHERE (`id1` = 28594) AND (`guid` IN (129165, 129168, 129169, 129170, 129171));
UPDATE creature SET `phaseMask`=`phaseMask`|2 WHERE (`id1` = 28594) AND (`guid` IN (129165, 129168, 129169, 129170, 129171));

UPDATE creature SET `phaseMask`=`phaseMask`|2 WHERE (`id1` = 28683) AND (`guid` IN (128455));

UPDATE creature SET `phaseMask`=`phaseMask`|2 WHERE (`id1` = 28605) AND (`guid` IN (129202, 129203, 129204, 129205, 129206, 129207, 129208, 129210, 129211, 129212, 129213, 129214, 129215, 129216, 129217));

UPDATE creature SET `phaseMask`=`phaseMask`|2 WHERE (`id1` = 28606) AND (`guid` IN (129220, 129221, 129222, 129223, 129224, 129225, 129226, 129227, 129228, 129229, 129230, 129231, 129232, 129233, 129234, 129235, 129236, 129237));

UPDATE creature SET `phaseMask`=`phaseMask`|2 WHERE (`id1` = 28607) AND (`guid` IN (129238, 129239, 129240, 129241, 129242, 129243, 129244, 129245, 129246, 129247, 129248, 129249, 129250, 129251, 129252));

UPDATE creature SET `phaseMask`=`phaseMask`|2 WHERE (`id1` = 28766) AND (`guid` IN (128583, 128584, 128585, 128586, 128587, 128588, 128589));

UPDATE creature SET `phaseMask`=`phaseMask`|2 WHERE (`id1` = 29501) AND (`guid` IN (128509, 128510));

UPDATE creature SET `phaseMask`=`phaseMask`|2 WHERE (`id1` = 28614) AND (`guid` IN (129308, 129309));

UPDATE creature SET `phaseMask`=`phaseMask` |2 WHERE (`id1` = 25462) AND (`guid` IN (128738));

UPDATE creature SET `phaseMask`=`phaseMask` |2 WHERE (`id1` = 28487) AND (`guid` IN (128515, 128516));

UPDATE creature SET `phaseMask`=`phaseMask` |2 WHERE (`id1` = 29488) AND (`guid` IN (128500, 128501));

UPDATE creature SET `phaseMask`=`phaseMask` |2 WHERE (`id1` = 28510) AND (`guid` IN (128582));

UPDATE creature SET `phaseMask`=`phaseMask` |2 WHERE (`id1` = 27928) AND (`guid` IN (128460));

UPDATE creature SET `phaseMask`=`phaseMask` |2 WHERE (`id1` = 28486) AND (`guid` IN (128514));

UPDATE creature SET `phaseMask`=`phaseMask` |2 WHERE (`id1` = 28447) AND (`guid` IN (128481));

UPDATE creature SET `phaseMask`=`phaseMask` |2 WHERE (`id1` = 28448) AND (`guid` IN (128482));

UPDATE creature SET `phaseMask`=`phaseMask` |2 WHERE (`id1` = 28449) AND (`guid` IN (128483));

UPDATE creature SET `phaseMask`=`phaseMask` |2 WHERE (`id1` = 28444) AND (`guid` IN (128470));

UPDATE creature SET `phaseMask`=`phaseMask` |2 WHERE (`id1` = 28445) AND (`guid` IN (128475));

UPDATE creature SET `phaseMask`=`phaseMask` |2 WHERE (`id1` = 28356) AND (`guid` IN (129306));

UPDATE creature SET `phaseMask`=`phaseMask` |2 WHERE (`id1` = 28474) AND (`guid` IN (128507));

UPDATE creature SET `phaseMask`=`phaseMask` |2 WHERE (`id1` = 28488) AND (`guid` IN (128522, 128523, 128525, 128526));

UPDATE creature SET `phaseMask`=`phaseMask` |2 WHERE (`id1` = 28472) AND (`guid` IN (128506));

UPDATE creature SET `phaseMask`=`phaseMask` |2 WHERE (`id1` = 28471) AND (`guid` IN (128505));

UPDATE creature SET `phaseMask`=`phaseMask` |2 WHERE (`id1` = 28489) AND (`guid` IN (128527, 128528, 128529, 128530, 128531, 128532, 128533, 128534));

UPDATE creature SET `phaseMask`=`phaseMask` |2 WHERE (`id1` = 28490) AND (`guid` IN (128535, 128536, 128537, 128538, 128539, 128540, 128541, 128542, 128543));

UPDATE creature SET `phaseMask`=`phaseMask` |2 WHERE (`id1` = 28491) AND (`guid` IN (128545, 128546, 128547, 128548, 128549, 128550, 128551, 128552, 128553));

UPDATE creature SET `phaseMask`=`phaseMask` |2 WHERE (`id1` = 29203) AND (`guid` IN (128456));

UPDATE creature SET `phaseMask`=`phaseMask` |2 WHERE (`id1` = 29207) AND (`guid` IN (128458));

UPDATE creature SET `phaseMask`=`phaseMask` |2 WHERE (`id1` = 29208) AND (`guid` IN (128459));

UPDATE creature SET `phaseMask`=`phaseMask` |2 WHERE (`id1` = 29205) AND (`guid` IN (128457));

UPDATE creature SET `phaseMask`=`phaseMask` |2 WHERE (`id1` = 29212) AND (`guid` IN (128465));

UPDATE creature SET `phaseMask`=`phaseMask` |2 WHERE (`id1` = 28506) AND (`guid` IN (128580));

UPDATE creature SET `phaseMask`=`phaseMask` |2 WHERE (`id1` = 28500) AND (`guid` IN (128577));

UPDATE creature SET `phaseMask`=`phaseMask` |2 WHERE (`id1` = 28505) AND (`guid` IN (128579));

UPDATE creature SET `phaseMask`=`phaseMask` |2 WHERE (`id1` = 28357) AND (`guid` IN (129307));

UPDATE creature SET `phaseMask`=`phaseMask` |2 WHERE (`id1` = 28383) AND (`guid` IN (129388, 129389, 129390, 129391));

UPDATE gameobject SET `phaseMask`=`phaseMask` |2 WHERE (`id` = 191609) AND (`guid` IN (65961, 65962));

UPDATE gameobject SET `phaseMask`=`phaseMask` |2 WHERE (`id` = 191612) AND (`guid` IN (65963, 65964));

UPDATE gameobject SET `phaseMask`=`phaseMask` |2 WHERE (`id` = 191613) AND (`guid` IN (65965, 65966));

UPDATE gameobject SET `phaseMask`=`phaseMask` |2 WHERE (`id` = 191577) AND (`guid` IN (65915));

UPDATE gameobject SET `phaseMask`=`phaseMask` |2 WHERE (`id` = 191580) AND (`guid` IN (65916));

UPDATE gameobject SET `phaseMask`=`phaseMask` |2 WHERE (`id` = 191581) AND (`guid` IN (65920));

UPDATE gameobject SET `phaseMask`=`phaseMask` |2 WHERE (`id` = 191582) AND (`guid` IN (65921));

UPDATE gameobject SET `phaseMask`=`phaseMask` |2 WHERE (`id` = 191583) AND (`guid` IN (65923));

UPDATE gameobject SET `phaseMask`=`phaseMask` |2 WHERE (`id` = 191584) AND (`guid` IN (65925));

UPDATE gameobject SET `phaseMask`=`phaseMask` |2 WHERE (`id` = 191585) AND (`guid` IN (65926));

UPDATE gameobject SET `phaseMask`=`phaseMask` |2 WHERE (`id` = 191586) AND (`guid` IN (65927));

UPDATE gameobject SET `phaseMask`=`phaseMask` |2 WHERE (`id` = 191587) AND (`guid` IN (65928));

UPDATE gameobject SET `phaseMask`=`phaseMask` |2 WHERE (`id` = 191588) AND (`guid` IN (65929));

UPDATE gameobject SET `phaseMask`=`phaseMask` |2 WHERE (`id` = 191589) AND (`guid` IN (65930));

UPDATE gameobject SET `phaseMask`=`phaseMask` |2 WHERE (`id` = 191590) AND (`guid` IN (65931));

UPDATE creature SET `phaseMask`=`phaseMask` |2 WHERE (`id1` = 29519) AND (`guid` IN (128557, 128558, 128559));

UPDATE creature SET `phaseMask`=`phaseMask` |2 WHERE (`id1` = 29520) AND (`guid` IN (128561, 128563));

UPDATE creature SET `phaseMask`=`phaseMask` |2 WHERE (`id1` = 29565) AND (`guid` IN (128740));

UPDATE creature SET `phaseMask`=`phaseMask` |2 WHERE (`id1` = 29566) AND (`guid` IN (128742, 128743, 128744));

UPDATE creature SET `phaseMask`=`phaseMask` |2 WHERE (`id1` = 29567) AND (`guid` IN (128747, 128748, 128749));

UPDATE creature SET `phaseMask`=`phaseMask` |2 WHERE (`id1` = 29521) AND (`guid` IN (128565, 128566, 128567, 128568, 128569, 128570, 128571, 128572, 128573, 128574, 128575, 128576));

UPDATE creature SET `phaseMask`=`phaseMask` |2 WHERE (`id1` = 28385) AND (`guid` IN (129392, 129393, 129395));

UPDATE creature SET `phaseMask`=`phaseMask` |2 WHERE (`id1` = 28386) AND (`guid` IN (129401, 129402, 129404));
