#include "Message.h"

#include "DatabaseEnv.h"
#include "ItemTemplate.h"

#include <iostream>
#include <sstream>
#include <string>
#include <unordered_map>
#include <vector>

const std::unordered_map<LocaleConstant, std::string> AB_WELCOME_TO_PLAYER = {
    {LOCALE_enUS, "|cffc3dbff [AutoBalance]|r|cffFF8000 Welcome to {} ({}-player {}). There are {} player(s) in this instance. Difficulty set to {} player(s).|r"},
    {LOCALE_koKR, "|cffc3dbff [AutoBalance]|r|cffFF8000 {} ({}-player {})에 오신 것을 환영합니다. 이 인스턴스에는 {}명의 플레이어가 있습니다. 난이도가 {}명으로 설정되었습니다.|r"},
    {LOCALE_frFR, "|cffc3dbff [AutoBalance]|r|cffFF8000 Bienvenue dans {} ({} {}). Il y a {} joueur(s) dans cette instance. La difficulté est réglée sur {} joueur(s).|r"},
    {LOCALE_deDE, "|cffc3dbff [AutoBalance]|r|cffFF8000 Willkommen in {} ({} Spieler {}). Es gibt {} Spieler in dieser Instanz. Schwierigkeit auf {} Spieler eingestellt.|r"},
    {LOCALE_zhCN, "|cffc3dbff [AutoBalance]|r|cffFF8000 欢迎来到 {}（{}人 {}）。此副本中有 {} 名玩家。难度设置为 {} 名玩家。|r"},
    {LOCALE_zhTW, "|cffc3dbff [AutoBalance]|r|cffFF8000 歡迎來到 {}（{}人 {}）。此副本中有 {} 名玩家。難度設定為 {} 名玩家。|r"},
    {LOCALE_esES, "|cffc3dbff [AutoBalance]|r|cffFF8000 Bienvenido a {} ({} jugador {}). Hay {} jugador(es) en esta instancia. La dificultad se establece en {} jugador(es).|r"},
    {LOCALE_esMX, "|cffc3dbff [AutoBalance]|r|cffFF8000 Bienvenido a {} ({} jugador {}). Hay {} jugador(es) en esta instancia. La dificultad se establece en {} jugador(es).|r"},
    {LOCALE_ruRU, "|cffc3dbff [AutoBalance]|r|cffFF8000 Добро пожаловать в {} ({} игрок {}). В этом экземпляре {} игроков. Сложность установлена на {} игроков.|r"},
};

const std::unordered_map<LocaleConstant, std::string> AB_WELCOME_TO_GM = {
    {LOCALE_enUS, "|cffc3dbff [AutoBalance]|r|cffFF8000 Your GM flag is turned on. AutoBalance will ignore you. Please turn GM off and exit/re-enter the instance if you'd like to be considering for AutoBalancing.|r"},
    {LOCALE_koKR, "|cffc3dbff [AutoBalance]|r|cffFF8000 GM 플래그가 켜져 있습니다. AutoBalance는 당신을 무시합니다. AutoBalancing을 고려하려면 GM을 끄고 인스턴스를 나가고 다시 들어가십시오.|r"},
    {LOCALE_frFR, "|cffc3dbff [AutoBalance]|r|cffFF8000 Votre drapeau GM est activé. AutoBalance vous ignorera. Veuillez désactiver GM et sortir/revenir dans l'instance si vous souhaitez être pris en compte pour l'AutoBalancing.|r"},
    {LOCALE_deDE, "|cffc3dbff [AutoBalance]|r|cffFF8000 Ihre GM-Flagge ist eingeschaltet. AutoBalance wird Sie ignorieren. Bitte schalten Sie GM aus und verlassen Sie das Instanz, wenn Sie für das AutoBalancing berücksichtigt werden möchten.|r"},
    {LOCALE_zhCN, "|cffc3dbff [AutoBalance]|r|cffFF8000 您的GM模式已打开。AutoBalance将忽略。如果您希望考虑自动平衡，请关闭GM并退出/重新进入副本。|r"},
    {LOCALE_zhTW, "|cffc3dbff [AutoBalance]|r|cffFF8000 您的GM模式已打開。AutoBalance將忽略。如果您希望考慮自動平衡，請關閉GM並退出/重新進入副本。|r"},
    {LOCALE_esES, "|cffc3dbff [AutoBalance]|r|cffFF8000 Su bandera de GM está encendida. AutoBalance te ignorará. Por favor, apague GM y salga/vuelva a entrar en la instancia si desea ser considerado para el AutoBalance.|r"},
    {LOCALE_esMX, "|cffc3dbff [AutoBalance]|r|cffFF8000 Su bandera de GM está encendida. AutoBalance te ignorará. Por favor, apague GM y salga/vuelva a entrar en la instancia si desea ser considerado para el AutoBalance.|r"},
    {LOCALE_ruRU, "|cffc3dbff [AutoBalance]|r|cffFF8000 Ваш флаг GM включен. AutoBalance будет игнорировать вас. Пожалуйста, отключите GM и выйдите/войдите в экземпляр, если хотите, чтобы вас учитывали при автобалансировке.|r"},
};

const std::unordered_map<LocaleConstant, std::string> AB_ANNOUNCE_NON_GM_ENTERING_INSTANCE = {
    {LOCALE_enUS, "|cffc3dbff [AutoBalance]|r|cffFF8000 {} enters the instance. There are {} player(s) in this instance. Difficulty set to {} player(s).|r"},
    {LOCALE_koKR, "|cffc3dbff [AutoBalance]|r|cffFF8000 {}이(가) 인스턴스에 들어왔습니다. 이 인스턴스에는 {}명의 플레이어가 있습니다. 난이도가 {}명으로 설정되었습니다.|r"},
    {LOCALE_frFR, "|cffc3dbff [AutoBalance]|r|cffFF8000 {} entre dans l'instance. Il y a {} joueur(s) dans cette instance. La difficulté est réglée sur {} joueur(s).|r"},
    {LOCALE_deDE, "|cffc3dbff [AutoBalance]|r|cffFF8000 {} betritt die Instanz. Es gibt {} Spieler in dieser Instanz. Schwierigkeit auf {} Spieler eingestellt.|r"},
    {LOCALE_zhCN, "|cffc3dbff [AutoBalance]|r|cffFF8000 {}进入了副本。此副本中有 {} 名玩家。难度设置为 {} 名玩家。|r"},
    {LOCALE_zhTW, "|cffc3dbff [AutoBalance]|r|cffFF8000 {}進入了副本。此副本中有 {} 名玩家。難度設定為 {} 名玩家。|r"},
    {LOCALE_esES, "|cffc3dbff [AutoBalance]|r|cffFF8000 {} entra en la instancia. Hay {} jugador(es) en esta instancia. La dificultad se establece en {} jugador(es).|r"},
    {LOCALE_esMX, "|cffc3dbff [AutoBalance]|r|cffFF8000 {} entra en la instancia. Hay {} jugador(es) en esta instancia. La dificultad se establece en {} jugador(es).|r"},
    {LOCALE_ruRU, "|cffc3dbff [AutoBalance]|r|cffFF8000 {} входит в экземпляр. В этом экземпляре {} игроков. Сложность установлена на {} игроков.|r"},
};

const std::unordered_map<LocaleConstant, std::string> AB_LEAVING_INSTANCE_COMBAT = {
    {LOCALE_enUS, "|cffc3dbff [AutoBalance]|r|cffFF8000 {} left the instance while combat was in progress. Difficulty locked to no less than {} players until combat ends.|r"},
    {LOCALE_koKR, "|cffc3dbff [AutoBalance]|r|cffFF8000 {}이(가) 전투 중에 인스턴스를 떠났습니다. 전투가 끝날 때까지 난이도가 {}명 미만으로 잠겨 있습니다.|r"},
    {LOCALE_frFR, "|cffc3dbff [AutoBalance]|r|cffFF8000 {} a quitté l'instance alors que le combat était en cours. La difficulté est verrouillée à pas moins de {} joueur(s) jusqu'à la fin du combat.|r"},
    {LOCALE_deDE, "|cffc3dbff [AutoBalance]|r|cffFF8000 {} hat die Instanz verlassen, während der Kampf im Gange war. Die Schwierigkeit ist gesperrt, bis der Kampf endet, auf nicht weniger als {} Spieler.|r"},
    {LOCALE_zhCN, "|cffc3dbff [AutoBalance]|r|cffFF8000 {}在战斗进行中离开了副本。直到战斗结束，难度锁定为不少于 {} 名玩家。|r"},
    {LOCALE_zhTW, "|cffc3dbff [AutoBalance]|r|cffFF8000 {}在戰鬥進行中離開了副本。直到戰鬥結束，難度鎖定為不少於 {} 名玩家。|r"},
    {LOCALE_esES, "|cffc3dbff [AutoBalance]|r|cffFF8000 {} salió de la instancia mientras el combate estaba en progreso. La dificultad está bloqueada a no menos de {} jugador(es) hasta que termine el combate.|r"}
};

const std::unordered_map<LocaleConstant, std::string> AB_LEAVING_INSTANCE = {
    {LOCALE_enUS, "|cffc3dbff [AutoBalance]|r|cffFF8000 {} left the instance. There are {} player(s) in this instance. Difficulty set to {} player(s).|r"},
    {LOCALE_koKR, "|cffc3dbff [AutoBalance]|r|cffFF8000 {}이(가) 인스턴스를 떠났습니다. 이 인스턴스에는 {}명의 플레이어가 있습니다. 난이도가 {}명으로 설정되었습니다.|r"},
    {LOCALE_frFR, "|cffc3dbff [AutoBalance]|r|cffFF8000 {} a quitté l'instance. Il y a {} joueur(s) dans cette instance. La difficulté est réglée sur {} joueur(s).|r"},
    {LOCALE_deDE, "|cffc3dbff [AutoBalance]|r|cffFF8000 {} hat die Instanz verlassen. Es gibt {} Spieler in dieser Instanz. Schwierigkeit auf {} Spieler eingestellt.|r"},
    {LOCALE_zhCN, "|cffc3dbff [AutoBalance]|r|cffFF8000 {}离开了副本。此副本中有 {} 名玩家。难度设置为 {} 名玩家。|r"},
    {LOCALE_zhTW, "|cffc3dbff [AutoBalance]|r|cffFF8000 {}離開了副本。此副本中有 {} 名玩家。難度設定為 {} 名玩家。|r"},
    {LOCALE_esES, "|cffc3dbff [AutoBalance]|r|cffFF8000 {} salió de la instancia. Hay {} jugador(es) en esta instancia. La dificultad se establece en {} jugador(es).|r"},
    {LOCALE_esMX, "|cffc3dbff [AutoBalance]|r|cffFF8000 {} salió de la instancia. Hay {} jugador(es) en esta instancia. La dificultad se establece en {}"}
};

const std::unordered_map<LocaleConstant, std::string> AB_SET_OFFSET_COMMAND_DESCRIPTION = {
    {LOCALE_enUS, "Set the player difficulty offset for this instance. Usage: .ab offset <number>.|r"},
    {LOCALE_koKR, "이 인스턴스의 플레이어 난이도 오프셋을 설정합니다. 사용법: .ab offset <숫자>.|r"},
    {LOCALE_frFR, "Définissez le décalage de difficulté du joueur pour cette instance. Utilisation : .ab offset <nombre>.|r"},
    {LOCALE_deDE, "Legen Sie den Spieler-Schwierigkeits-Offset für diese Instanz fest. Verwendung: .ab offset <Nummer>.|r"},
    {LOCALE_zhCN, "设置此副本的玩家难度。用法：.ab offset <数字>。|r"},
    {LOCALE_zhTW, "設定此副本的玩家難度。用法：.ab offset <數字>。|r"},
    {LOCALE_esES, "Establece el desplazamiento de dificultad del jugador para esta instancia. Uso: .ab offset <número>.|r"},
    {LOCALE_esMX, "Establece el desplazamiento de dificultad del jugador para esta instancia. Uso: .ab offset <número>.|r"},
    {LOCALE_ruRU, "Устанавливает смещение сложности игрока для этого экземп"}
};

const std::unordered_map<LocaleConstant, std::string> AB_SET_OFFSET_COMMAND_SUCCESS = {
    {LOCALE_enUS, "Changing Player Difficulty Offset to {}.|r"},
    {LOCALE_koKR, "플레이어 난이도 오프셋을 {}(으)로 변경합니다.|r"},
    {LOCALE_frFR, "Modification du décalage de difficulté du joueur à {}.|r"},
    {LOCALE_deDE, "Spieler-Schwierigkeits-Offset auf {} ändern.|r"},
    {LOCALE_zhCN, "将玩家难度更改为 {}。|r"},
    {LOCALE_zhTW, "將玩家難度更改為 {}。|r"},
    {LOCALE_esES, "Cambiando el desplazamiento de dificultad del jugador a {}.|r"},
    {LOCALE_esMX, "Cambiando el desplazamiento de dificultad del jugador a {}.|r"},
    {LOCALE_ruRU, "Изменение смещения сложности игрока на {}.|r"},
};

const std::unordered_map<LocaleConstant, std::string> AB_SET_OFFSET_COMMAND_ERROR = {
    {LOCALE_enUS, "Error changing Player Difficulty Offset! Please try again.|r"},
    {LOCALE_koKR, "플레이어 난이도 오프셋 변경 중 오류가 발생했습니다! 다시 시도하십시오.|r"},
    {LOCALE_frFR, "Erreur lors de la modification du décalage de difficulté du joueur ! Veuillez réessayer.|r"},
    {LOCALE_deDE, "Fehler beim Ändern des Spieler-Schwierigkeits-Offsets! Bitte versuchen Sie es erneut.|r"},
    {LOCALE_zhCN, "更改玩家难度时出错！请重试。|r"},
    {LOCALE_zhTW, "更改玩家難度時出錯！請重試。|r"},
    {LOCALE_esES, "¡Error al cambiar el desplazamiento de dificultad del jugador! Por favor, inténtelo de nuevo.|r"},
    {LOCALE_esMX, "¡Error al cambiar el desplazamiento de dificultad del jugador! Por favor, inténtelo de nuevo.|r"},
    {LOCALE_ruRU, "Ошибка при изменении смещения сложности игрока! Пожалуйста, попробуйте еще раз.|r"},
};

const std::unordered_map<LocaleConstant, std::string> AB_GET_OFFSET_COMMAND_SUCCESS = {
    {LOCALE_enUS, "Current Player Difficulty Offset = {}.|r"},
    {LOCALE_koKR, "현재 플레이어 난이도 오프셋 = {}.|r"},
    {LOCALE_frFR, "Décalage de difficulté actuel du joueur = {}.|r"},
    {LOCALE_deDE, "Aktueller Spieler-Schwierigkeits-Offset = {}.|r"},
    {LOCALE_zhCN, "当前玩家难度偏移 = {}。|r"},
    {LOCALE_zhTW, "當前玩家難度偏移 = {}。|r"},
    {LOCALE_esES, "Desplazamiento de dificultad actual del jugador = {}.|r"},
    {LOCALE_esMX, "Desplazamiento de dificultad actual del jugador = {}.|r"},
    {LOCALE_ruRU, "Текущее смещение сложности игрока = {}.|r"},
};

const std::unordered_map<LocaleConstant, std::string> AB_ADJUSTED_PLAYER_COUNT_COMBAT_LOCKED = {
    {LOCALE_enUS, "Adjusted Player Count: {} (Combat Locked)|r"},
    {LOCALE_koKR, "조정된 플레이어 수: {} (전투 잠금됨)|r"},
    {LOCALE_frFR, "Nombre de joueurs ajusté : {} (verrouillé en combat)|r"},
    {LOCALE_deDE, "Angepasste Spieleranzahl: {} (Kampf gesperrt)|r"},
    {LOCALE_zhCN, "调整后的玩家数量：{}（战斗锁定）|r"},
    {LOCALE_zhTW, "調整後的玩家數量：{}（戰鬥鎖定）|r"},
    {LOCALE_esES, "Cantidad de jugadores ajustada: {} (bloqueada en combate)|r"},
    {LOCALE_esMX, "Cantidad de jugadores ajustada: {} (bloqueada en combate)|r"},
    {LOCALE_ruRU, "Количество игроков, отрегулированное: {} (заблокировано в бою)|r"},
};

const std::unordered_map<LocaleConstant, std::string> AB_ADJUSTED_PLAYER_COUNT_MAP_MINIMUM = {
    {LOCALE_enUS, "Adjusted Player Count: {} (Map Minimum)|r"},
    {LOCALE_koKR, "조정된 플레이어 수: {} (지도 최소)|r"},
    {LOCALE_frFR, "Nombre de joueurs ajusté : {} (minimum de la carte)|r"},
    {LOCALE_deDE, "Angepasste Spieleranzahl: {} (Kartenminimum)|r"},
    {LOCALE_zhCN, "调整后的玩家数量：{}（地图最小）|r"},
    {LOCALE_zhTW, "調整後的玩家數量：{}（地圖最小）|r"},
    {LOCALE_esES, "Cantidad de jugadores ajustada: {} (mínimo del mapa)|r"},
    {LOCALE_esMX, "Cantidad de jugadores ajustada: {} (mínimo del mapa)|r"},
    {LOCALE_ruRU, "Количество игроков, отрегулированное: {} (минимальное для карты)|r"},
};

const std::unordered_map<LocaleConstant, std::string> AB_ADJUSTED_PLAYER_COUNT_MAP_MINIMUM_DIFFICULTY_OFFSET = {
    {LOCALE_enUS, "Adjusted Player Count: {} (Map Minimum + Difficulty Offset of {})|r"},
    {LOCALE_koKR, "조정된 플레이어 수: {} (지도 최소 + {}의 난이도 오프셋)|r"},
    {LOCALE_frFR, "Nombre de joueurs ajusté : {} (minimum de la carte + décalage de difficulté de {})|r"},
    {LOCALE_deDE, "Angepasste Spieleranzahl: {} (Kartenminimum + Schwierigkeits-Offset von {})|r"},
    {LOCALE_zhCN, "调整后的玩家数量：{}（地图最小 + {}的难度修正）|r"},
    {LOCALE_zhTW, "調整後的玩家數量：{}（地圖最小 + {}的難度修正）|r"},
    {LOCALE_esES, "Cantidad de jugadores ajustada: {} (mínimo del mapa + desplazamiento de dificultad de {})|r"},
    {LOCALE_esMX, "Cantidad de jugadores ajustada: {} (mínimo del mapa + desplazamiento de dificultad de {})|r"},
    {LOCALE_ruRU, "Количество игроков, отрегулированное: {} (минимальное для карты"}
};

const std::unordered_map<LocaleConstant, std::string> AB_ADJUSTED_PLAYER_COUNT_DIFFICULTY_OFFSET = {
    {LOCALE_enUS, "Adjusted Player Count: {} (Difficulty Offset of {})|r"},
    {LOCALE_koKR, "조정된 플레이어 수: {} ({}의 난이도 오프셋)|r"},
    {LOCALE_frFR, "Nombre de joueurs ajusté : {} (décalage de difficulté de {})|r"},
    {LOCALE_deDE, "Angepasste Spieleranzahl: {} (Schwierigkeits-Offset von {})|r"},
    {LOCALE_zhCN, "调整后的玩家数量：{}（{}的难度修正）|r"},
    {LOCALE_zhTW, "調整後的玩家數量：{}（{}的難度修正）|r"},
    {LOCALE_esES, "Cantidad de jugadores ajustada: {} (desplazamiento de dificultad de {})|r"},
    {LOCALE_esMX, "Cantidad de jugadores ajustada: {} (desplazamiento de dificultad de {})|r"},
    {LOCALE_ruRU, "Количество игроков, отрегулированное: {} (смещение сложности {})|r"},
};

const std::unordered_map<LocaleConstant, std::string> AB_ADJUSTED_PLAYER_COUNT = {
    {LOCALE_enUS, "Adjusted Player Count: {}|r"},
    {LOCALE_koKR, "조정된 플레이어 수: {}|r"},
    {LOCALE_frFR, "Nombre de joueurs ajusté : {}|r"},
    {LOCALE_deDE, "Angepasste Spieleranzahl: {}|r"},
    {LOCALE_zhCN, "调整后的玩家数量：{}|r"},
    {LOCALE_zhTW, "調整後的玩家數量：{}|r"},
    {LOCALE_esES, "Cantidad de jugadores ajustada: {}|r"},
    {LOCALE_esMX, "Cantidad de jugadores ajustada: {}|r"},
    {LOCALE_ruRU, "Количество игроков, отрегулированное: {}|r"},
};

const std::unordered_map<LocaleConstant, std::string> AB_LFG_RANGE = {
    {LOCALE_enUS, "LFG Range: Lvl {} - {} (Target: Lvl {})|r"},
    {LOCALE_koKR, "LFG 범위: 레벨 {} - {} (대상: 레벨 {})|r"},
    {LOCALE_frFR, "Plage LFG : Niveau {} - {} (Cible : Niveau {})|r"},
    {LOCALE_deDE, "LFG-Bereich: Stufe {} - {} (Ziel: Stufe {})|r"},
    {LOCALE_zhCN, "LFG范围：等级 {} - {}（目标：等级 {}）|r"},
    {LOCALE_zhTW, "LFG範圍：等級 {} - {}（目標：等級 {}）|r"},
    {LOCALE_esES, "Rango de LFG: Nivel {} - {} (Objetivo: Nivel {})|r"},
    {LOCALE_esMX, "Rango de LFG: Nivel {} - {} (Objetivo: Nivel {})|r"},
    {LOCALE_ruRU, "Диапазон поиска группы: Ур. {} - {} (Цель: Ур. {})|r"},
};

const std::unordered_map<LocaleConstant, std::string> AB_MAP_LEVEL = {
    {LOCALE_enUS, "Map Level: {}{}|r"},
    {LOCALE_koKR, "지도 레벨: {}{}|r"},
    {LOCALE_frFR, "Niveau de la carte : {}{}|r"},
    {LOCALE_deDE, "Kartenlevel: {}{}|r"},
    {LOCALE_zhCN, "地图等级：{}{}|r"},
    {LOCALE_zhTW, "地圖等級：{}{}|r"},
    {LOCALE_esES, "Nivel del mapa: {}{}|r"},
    {LOCALE_esMX, "Nivel del mapa: {}{}|r"},
    {LOCALE_ruRU, "Уровень карты: {}{}|r"},
};

const std::unordered_map<LocaleConstant, std::string> AB_LEVEL_SCALING_ENABLED = {
    {LOCALE_enUS, " (Level Scaling Enabled)|r"},
    {LOCALE_koKR, " (레벨 스케일링 활성화됨)|r"},
    {LOCALE_frFR, " (Mise à l'échelle des niveaux activée)|r"},
    {LOCALE_deDE, " (Stufenanpassung aktiviert)|r"},
    {LOCALE_zhCN, " （启用等级自动平衡）|r"},
    {LOCALE_zhTW, " （啟用等級縮放平衡）|r"},
    {LOCALE_esES, " (Escalado de nivel activado)|r"},
    {LOCALE_esMX, " (Escalado de nivel activado)|r"},
    {LOCALE_ruRU, " (Масштабирование уровней включено)|r"},
};

const std::unordered_map<LocaleConstant, std::string> AB_LEVEL_SCALING_DISABLED = {
    {LOCALE_enUS, " (Level Scaling Disabled)|r"},
    {LOCALE_koKR, " (레벨 스케일링 비활성화됨)|r"},
    {LOCALE_frFR, " (Mise à l'échelle des niveaux désactivée)|r"},
    {LOCALE_deDE, " (Stufenanpassung deaktiviert)|r"},
    {LOCALE_zhCN, " （禁用等级自动平衡）|r"},
    {LOCALE_zhTW, " （停用等級縮放平衡）|r"},
    {LOCALE_esES, " (Escalado de nivel desactivado)|r"},
    {LOCALE_esMX, " (Escalado de nivel desactivado)|r"},
    {LOCALE_ruRU, " (Масштабирование уровней отключено)|r"},
};

const std::unordered_map<LocaleConstant, std::string> AB_WORLD_HEALTH_MULTIPLIER = {
    {LOCALE_enUS, "World health multiplier: {:.3f}|r"},
    {LOCALE_koKR, "월드 체력 배율: {:.3f}|r"},
    {LOCALE_frFR, "Multiplicateur de santé mondiale : {:.3f}|r"},
    {LOCALE_deDE, "Weltgesundheitsmultiplikator: {:.3f}|r"},
    {LOCALE_zhCN, "全局生命值倍率：{:.3f}|r"},
    {LOCALE_zhTW, "全局生命值倍增器：{:.3f}|r"},
    {LOCALE_esES, "Multiplicador de salud mundial: {:.3f}|r"},
    {LOCALE_esMX, "Multiplicador de salud mundial: {:.3f}|r"},
    {LOCALE_ruRU, "Множитель здоровья мира: {:.3f}|r"},
};

const std::unordered_map<LocaleConstant, std::string> AB_WORLD_HOSTILE_DAMAGE_HEALING_MULTIPLIER_TO = {
    {LOCALE_enUS, "World hostile damage and healing multiplier: {:.3f} -> {:.3f}|r"},
    {LOCALE_koKR, "월드 적 대미지 및 치유 배율: {:.3f} -> {:.3f}|r"},
    {LOCALE_frFR, "Multiplicateur de dégâts et de soins hostiles mondiaux : {:.3f} -> {:.3f}|r"},
    {LOCALE_deDE, "Weltweiter feindlicher Schadens- und Heilungs-Multiplikator: {:.3f} -> {:.3f}|r"},
    {LOCALE_zhCN, "全局伤害和治疗倍率：{:.3f} -> {:.3f}|r"},
    {LOCALE_zhTW, "全局敵對傷害和治療倍增器：{:.3f} -> {:.3f}|r"},
    {LOCALE_esES, "Multiplicador de daño y curación hostil mundial: {:.3f} -> {:.3f}|r"},
    {LOCALE_esMX, "Multiplicador de daño y curación hostil mundial: {:.3f} -> {:.3f}|r"},
    {LOCALE_ruRU, "Множитель урона и лечения мира: {:.3f} -> {:.3f}|r"},
};

const std::unordered_map<LocaleConstant, std::string> AB_WORLD_HOSTILE_DAMAGE_HEALING_MULTIPLIER = {
    {LOCALE_enUS, "World hostile damage and healing multiplier: {:.3f}|r"},
    {LOCALE_koKR, "월드 적 대미지 및 치유 배율: {:.3f}|r"},
    {LOCALE_frFR, "Multiplicateur de dégâts et de soins hostiles mondiaux : {:.3f}|r"},
    {LOCALE_deDE, "Weltweiter feindlicher Schadens- und Heilungs-Multiplikator: {:.3f}|r"},
    {LOCALE_zhCN, "全局伤害和治疗倍率：{:.3f}|r"},
    {LOCALE_zhTW, "全局敵對傷害和治療倍增器：{:.3f}|r"},
    {LOCALE_esES, "Multiplicador de daño y curación hostil mundial: {:.3f}|r"},
    {LOCALE_esMX, "Multiplicador de daño y curación hostil mundial: {:.3f}|r"},
    {LOCALE_ruRU, "Множитель урона и лечения мира: {:.3f}|r"},
};

const std::unordered_map<LocaleConstant, std::string> AB_ORIGINAL_CREATURE_LEVEL_RANGE = {
    {LOCALE_enUS, "Original Creature Level Range: {} - {} (Avg: {:.2f})|r"},
    {LOCALE_koKR, "원래 크리쳐 레벨 범위: {} - {} (평균: {:.2f})|r"},
    {LOCALE_frFR, "Plage de niveaux de créatures d'origine : {} - {} (Moyenne : {:.2f})|r"},
    {LOCALE_deDE, "Originaler Kreaturenlevelbereich: {} - {} (Durchschnitt: {:.2f})|r"},
    {LOCALE_zhCN, "原始生物等级范围：{} - {}（平均：{:2.f}）|r"},
    {LOCALE_zhTW, "原始生物等級範圍：{} - {}（平均：{:2.f}）|r"},
    {LOCALE_esES, "Rango de niveles de criaturas originales: {} - {} (Promedio: {:.2f})|r"},
    {LOCALE_esMX, "Rango de niveles de criaturas originales: {} - {} (Promedio: {:.2f})|r"},
    {LOCALE_ruRU, "Исходный диапазон уровней существ: {} - {} (Среднее: {:.2f})|r"},
};

const std::unordered_map<LocaleConstant, std::string> AB_ACTIVE_TOTAL_CREATURES_IN_MAP = {
    {LOCALE_enUS, "Active | Total Creatures in map: {} | {}|r"},
    {LOCALE_koKR, "활성 | 지도 내 총 크리쳐: {} | {}|r"},
    {LOCALE_frFR, "Actif | Créatures totales dans la carte : {} | {}|r"},
    {LOCALE_deDE, "Aktiv | Gesamte Kreaturen in der Karte: {} | {}|r"},
    {LOCALE_zhCN, "Active | 地图中的总生物： {} | {}|r"},
    {LOCALE_zhTW, "Active | 地圖中的總生物： {} | {}|r"},
    {LOCALE_esES, "Activo | Criaturas totales en el mapa: {} | {}|r"},
    {LOCALE_esMX, "Activo | Criaturas totales en el mapa: {} | {}|r"},
    {LOCALE_ruRU, "Активные | Всего существ на карте: {} | {}|r"},
};

const std::unordered_map<LocaleConstant, std::string> AB_COMMAND_ONLY_IN_INSTANCE = {
    {LOCALE_enUS, "This command can only be used in a dungeon or raid.|r"},
    {LOCALE_koKR, "이 명령은 던전이나 공격대에서만 사용할 수 있습니다.|r"},
    {LOCALE_frFR, "Cette commande ne peut être utilisée que dans un donjon ou un raid.|r"},
    {LOCALE_deDE, "Dieser Befehl kann nur in einem Dungeon oder Schlachtzug verwendet werden.|r"},
    {LOCALE_zhCN, "此命令只能在地下城或团队副本中使用。|r"},
    {LOCALE_zhTW, "此命令只能在地城或團隊副本中使用。|r"},
    {LOCALE_esES, "Este comando solo se puede usar en una mazmorra o banda.|r"},
    {LOCALE_esMX, "Este comando solo se puede usar en una mazmorra o banda.|r"},
    {LOCALE_ruRU, "Эту команду можно использовать только в подземелье или рейде.|r"},
};

const std::unordered_map<LocaleConstant, std::string> AB_TARGET_NO_IN_INSTANCE = {
    {LOCALE_enUS, "That target is not in an instance.|r"},
    {LOCALE_koKR, "그 대상은 인스턴스에 있지 않습니다.|r"},
    {LOCALE_frFR, "Cette cible n'est pas dans une instance.|r"},
    {LOCALE_deDE, "Dieses Ziel befindet sich nicht in einer Instanz.|r"},
    {LOCALE_zhCN, "该目标不在副本中。|r"},
    {LOCALE_zhTW, "該目標不在副本中。|r"},
    {LOCALE_esES, "Ese objetivo no está en una instancia.|r"},
    {LOCALE_esMX, "Ese objetivo no está en una instancia.|r"},
    {LOCALE_ruRU, "Эта цель не находится в подземелье.|r"},
};

const std::unordered_map<LocaleConstant, std::string> AB_ACTIVE_FOR_MAP_STATS = {
    {LOCALE_enUS, "Active for Map Stats|r"},
    {LOCALE_koKR, "지도 통계용 활성|r"},
    {LOCALE_frFR, "Actif pour les statistiques de la carte|r"},
    {LOCALE_deDE, "Aktiv für Kartenstatistiken|r"},
    {LOCALE_zhCN, "地图平衡激活|r"},
    {LOCALE_zhTW, "地圖平衡激活|r"},
    {LOCALE_esES, "Activo para estadísticas del mapa|r"},
    {LOCALE_esMX, "Activo para estadísticas del mapa|r"},
    {LOCALE_ruRU, "Активно для статистики карты|r"},
};

const std::unordered_map<LocaleConstant, std::string> AB_IGNORED_FOR_MAP_STATS = {
    {LOCALE_enUS, "Ignored for Map Stats|r"},
    {LOCALE_koKR, "지도 통계용 무시됨|r"},
    {LOCALE_frFR, "Ignoré pour les statistiques de la carte|r"},
    {LOCALE_deDE, "Ignoriert für Kartenstatistiken|r"},
    {LOCALE_zhCN, "地图平衡已忽略|r"},
    {LOCALE_zhTW, "地圖平衡已忽略|r"},
    {LOCALE_esES, "Ignorado para estadísticas del mapa|r"},
    {LOCALE_esMX, "Ignorado para estadísticas del mapa|r"},
    {LOCALE_ruRU, "Игнорируется для статистики карты|r"},
};

const std::unordered_map<LocaleConstant, std::string> AB_CREATURE_DIFFICULTY_LEVEL = {
    {LOCALE_enUS, "Creature difficulty level: {} player(s)|r"},
    {LOCALE_koKR, "생물 난이도 레벨: {} 플레이어|r"},
    {LOCALE_frFR, "Niveau de difficulté de la créature : {} joueur(s)|r"},
    {LOCALE_deDE, "Kreaturschwierigkeitsstufe: {} Spieler|r"},
    {LOCALE_zhCN, "生物难度等级：{} 玩家|r"},
    {LOCALE_zhTW, "生物難度等級：{} 玩家|r"},
    {LOCALE_esES, "Nivel de dificultad de la criatura: {} jugador(es)|r"},
    {LOCALE_esMX, "Nivel de dificultad de la criatura: {} jugador(es)|r"},
    {LOCALE_ruRU, "Уровень сложности существа: {} игрок(ов)|r"},
};

const std::unordered_map<LocaleConstant, std::string> AB_CLONE_OF_SUMMON = {
    {LOCALE_enUS, "Clone of {} ({})|r"},
    {LOCALE_koKR, "{}의 복제 ({})|r"},
    {LOCALE_frFR, "Clone de {} ({})|r"},
    {LOCALE_deDE, "Klon von {} ({})|r"},
    {LOCALE_zhCN, "{}的克隆（{}）|r"},
    {LOCALE_zhTW, "{}的克隆（{}）|r"},
    {LOCALE_esES, "Clon de {} ({})|r"},
    {LOCALE_esMX, "Clon de {} ({})|r"},
    {LOCALE_ruRU, "Клон {} ({})|r"},
};

const std::unordered_map<LocaleConstant, std::string> AB_SUMMON_OF_SUMMON = {
    {LOCALE_enUS, "Summon of {} ({})|r"},
    {LOCALE_koKR, "{}의 소환 ({})|r"},
    {LOCALE_frFR, "Invocation de {} ({})|r"},
    {LOCALE_deDE, "Beschwörung von {} ({})|r"},
    {LOCALE_zhCN, "{}的召唤（{}）|r"},
    {LOCALE_zhTW, "{}的召喚（{}）|r"},
    {LOCALE_esES, "Invocación de {} ({})|r"},
    {LOCALE_esMX, "Invocación de {} ({})|r"},
    {LOCALE_ruRU, "Призыв {} ({})|r"},
};

const std::unordered_map<LocaleConstant, std::string> AB_SUMMON_WITHOUT_SUMMONER = {
    {LOCALE_enUS, "Summon without a summoner.|r"},
    {LOCALE_koKR, "소환사 없는 소환.|r"},
    {LOCALE_frFR, "Invocation sans invocateur.|r"},
    {LOCALE_deDE, "Beschwörung ohne Beschwörer.|r"},
    {LOCALE_zhCN, "没有召唤者的召唤物。|r"},
    {LOCALE_zhTW, "沒有召喚者的召喚物。|r"},
    {LOCALE_esES, "Invocación sin invocador.|r"},
    {LOCALE_esMX, "Invocación sin invocador.|r"},
    {LOCALE_ruRU, "Призыв без призывателя.|r"},
};

const std::unordered_map<LocaleConstant, std::string> AB_HEALTH_MULTIPLIER_TO = {
    {LOCALE_enUS, "Health multiplier: {:.3f} -> {:.3f}|r"},
    {LOCALE_koKR, "체력 배율: {:.3f} -> {:.3f}|r"},
    {LOCALE_frFR, "Multiplicateur de santé : {:.3f} -> {:.3f}|r"},
    {LOCALE_deDE, "Gesundheitsmultiplikator: {:.3f} -> {:.3f}|r"},
    {LOCALE_zhCN, "生命值倍率：{:.3f} -> {:.3f}|r"},
    {LOCALE_zhTW, "生命值倍增器：{:.3f} -> {:.3f}|r"},
    {LOCALE_esES, "Multiplicador de salud: {:.3f} -> {:.3f}|r"},
    {LOCALE_esMX, "Multiplicador de salud: {:.3f} -> {:.3f}|r"},
    {LOCALE_ruRU, "Множитель здоровья: {:.3f} -> {:.3f}|r"},
};

const std::unordered_map<LocaleConstant, std::string> AB_MANA_MULTIPLIER_TO = {
    {LOCALE_enUS, "Mana multiplier: {:.3f} -> {:.3f}|r"},
    {LOCALE_koKR, "마나 배율: {:.3f} -> {:.3f}|r"},
    {LOCALE_frFR, "Multiplicateur de mana : {:.3f} -> {:.3f}|r"},
    {LOCALE_deDE, "Manamultiplikator: {:.3f} -> {:.3f}|r"},
    {LOCALE_zhCN, "法力值倍率：{:.3f} -> {:.3f}|r"},
    {LOCALE_zhTW, "法力值倍增器：{:.3f} -> {:.3f}|r"},
    {LOCALE_esES, "Multiplicador de maná: {:.3f} -> {:.3f}|r"},
    {LOCALE_esMX, "Multiplicador de maná: {:.3f} -> {:.3f}|r"},
    {LOCALE_ruRU, "Множитель маны: {:.3f} -> {:.3f}|r"},
};

const std::unordered_map<LocaleConstant, std::string> AB_ARMOR_MULTIPLIER_TO = {
    {LOCALE_enUS, "Armor multiplier: {:.3f} -> {:.3f}|r"},
    {LOCALE_koKR, "방어구 배율: {:.3f} -> {:.3f}|r"},
    {LOCALE_frFR, "Multiplicateur d'armure : {:.3f} -> {:.3f}|r"},
    {LOCALE_deDE, "Rüstungsmultiplikator: {:.3f} -> {:.3f}|r"},
    {LOCALE_zhCN, "护甲倍率：{:.3f} -> {:.3f}|r"},
    {LOCALE_zhTW, "護甲倍增器：{:.3f} -> {:.3f}|r"},
    {LOCALE_esES, "Multiplicador de armadura: {:.3f} -> {:.3f}|r"},
    {LOCALE_esMX, "Multiplicador de armadura: {:.3f} -> {:.3f}|r"},
    {LOCALE_ruRU, "Множитель брони: {:.3f} -> {:.3f}|r"},
};

const std::unordered_map<LocaleConstant, std::string> AB_DAMAGE_MULTIPLIER_TO = {
    {LOCALE_enUS, "Damage multiplier: {:.3f} -> {:.3f}|r"},
    {LOCALE_koKR, "피해 배율: {:.3f} -> {:.3f}|r"},
    {LOCALE_frFR, "Multiplicateur de dégâts : {:.3f} -> {:.3f}|r"},
    {LOCALE_deDE, "Schadensmultiplikator: {:.3f} -> {:.3f}|r"},
    {LOCALE_zhCN, "伤害倍率：{:.3f} -> {:.3f}|r"},
    {LOCALE_zhTW, "傷害倍增器：{:.3f} -> {:.3f}|r"},
    {LOCALE_esES, "Multiplicador de daño: {:.3f} -> {:.3f}|r"},
    {LOCALE_esMX, "Multiplicador de daño: {:.3f} -> {:.3f}|r"},
    {LOCALE_ruRU, "Множитель урона: {:.3f} -> {:.3f}|r"},
};

const std::unordered_map<LocaleConstant, std::string> AB_HEALTH_MULTIPLIER = {
    {LOCALE_enUS, "Health multiplier: {:.3f}|r"},
    {LOCALE_koKR, "체력 배율: {:.3f}|r"},
    {LOCALE_frFR, "Multiplicateur de santé : {:.3f}|r"},
    {LOCALE_deDE, "Gesundheitsmultiplikator: {:.3f}|r"},
    {LOCALE_zhCN, "生命值倍率：{:.3f}|r"},
    {LOCALE_zhTW, "生命值倍增器：{:.3f}|r"},
    {LOCALE_esES, "Multiplicador de salud: {:.3f}|r"},
    {LOCALE_esMX, "Multiplicador de salud: {:.3f}|r"},
    {LOCALE_ruRU, "Множитель здоровья: {:.3f}|r"},
};

const std::unordered_map<LocaleConstant, std::string> AB_MANA_MULTIPLIER = {
    {LOCALE_enUS, "Mana multiplier: {:.3f}|r"},
    {LOCALE_koKR, "마나 배율: {:.3f}|r"},
    {LOCALE_frFR, "Multiplicateur de mana : {:.3f}|r"},
    {LOCALE_deDE, "Manamultiplikator: {:.3f}|r"},
    {LOCALE_zhCN, "法力值倍率：{:.3f}|r"},
    {LOCALE_zhTW, "法力值倍增器：{:.3f}|r"},
    {LOCALE_esES, "Multiplicador de maná: {:.3f}|r"},
    {LOCALE_esMX, "Multiplicador de maná: {:.3f}|r"},
    {LOCALE_ruRU, "Множитель маны: {:.3f}|r"},
};

const std::unordered_map<LocaleConstant, std::string> AB_ARMOR_MULTIPLIER = {
    {LOCALE_enUS, "Armor multiplier: {:.3f}|r"},
    {LOCALE_koKR, "방어구 배율: {:.3f}|r"},
    {LOCALE_frFR, "Multiplicateur d'armure : {:.3f}|r"},
    {LOCALE_deDE, "Rüstungsmultiplikator: {:.3f}|r"},
    {LOCALE_zhCN, "护甲倍率：{:.3f}|r"},
    {LOCALE_zhTW, "護甲倍增器：{:.3f}|r"},
    {LOCALE_esES, "Multiplicador de armadura: {:.3f}|r"},
    {LOCALE_esMX, "Multiplicador de armadura: {:.3f}|r"},
    {LOCALE_ruRU, "Множитель брони: {:.3f}|r"},
};

const std::unordered_map<LocaleConstant, std::string> AB_DAMAGE_MULTIPLIER = {
    {LOCALE_enUS, "Damage multiplier: {:.3f}|r"},
    {LOCALE_koKR, "피해 배율: {:.3f}|r"},
    {LOCALE_frFR, "Multiplicateur de dégâts : {:.3f}|r"},
    {LOCALE_deDE, "Schadensmultiplikator: {:.3f}|r"},
    {LOCALE_zhCN, "伤害倍率：{:.3f}|r"},
    {LOCALE_zhTW, "傷害倍增器：{:.3f}|r"},
    {LOCALE_esES, "Multiplicador de daño: {:.3f}|r"},
    {LOCALE_esMX, "Multiplicador de daño: {:.3f}|r"},
    {LOCALE_ruRU, "Множитель урона: {:.3f}|r"},
};

const std::unordered_map<LocaleConstant, std::string> AB_CC_DURATION_MULTIPLIER = {
    {LOCALE_enUS, "CC Duration multiplier: {:.3f}|r"},
    {LOCALE_koKR, "CC 지속시간 배율: {:.3f}|r"},
    {LOCALE_frFR, "Multiplicateur de durée de la CC : {:.3f}|r"},
    {LOCALE_deDE, "CC-Dauer-Multiplikator: {:.3f}|r"},
    {LOCALE_zhCN, "控制持续时间倍率：{:.3f}|r"},
    {LOCALE_zhTW, "控制持續時間倍增器：{:.3f}|r"},
    {LOCALE_esES, "Multiplicador de duración de CC: {:.3f}|r"},
    {LOCALE_esMX, "Multiplicador de duración de CC: {:.3f}|r"},
    {LOCALE_ruRU, "Множитель длительности контроля: {:.3f}|r"},
};

const std::unordered_map<LocaleConstant, std::string> AB_XP_MONEY_MULTIPLIER = {
    {LOCALE_enUS, "XP multiplier: {:.3f}  Money multiplier: {:.3f}|r"},
    {LOCALE_koKR, "경험치 배율: {:.3f}  돈 배율: {:.3f}|r"},
    {LOCALE_frFR, "Multiplicateur d'XP : {:.3f}  Multiplicateur d'argent : {:.3f}|r"},
    {LOCALE_deDE, "XP-Multiplikator: {:.3f}  Geldmultiplikator: {:.3f}|r"},
    {LOCALE_zhCN, "经验值倍率：{:.3f}  金钱倍率：{:.3f}|r"},
    {LOCALE_zhTW, "經驗值倍增器：{:.3f}  金錢倍增器：{:.3f}|r"},
    {LOCALE_esES, "Multiplicador de XP: {:.3f}  Multiplicador de dinero: {:.3f}|r"},
    {LOCALE_esMX, "Multiplicador de XP: {:.3f}  Multiplicador de dinero: {:.3f}|r"},
    {LOCALE_ruRU, "Множитель опыта: {:.3f}  Множитель денег: {:.3f}|r"},
};

const std::unordered_map<LocaleConstant, std::string> AB_LEAVING_INSTANCE_COMBAT_CHANGE = {
    {LOCALE_enUS, "|cffc3dbff [AutoBalance]|r|cffFF8000 Combat has ended. Difficulty is no longer locked.|r"},
    {LOCALE_koKR, "|cffc3dbff [AutoBalance]|r|cffFF8000 전투가 종료되었습니다. 난이도가 더 이상 잠겨 있지 않습니다.|r"},
    {LOCALE_frFR, "|cffc3dbff [AutoBalance]|r|cffFF8000 Le combat est terminé. La difficulté n'est plus verrouillée.|r"},
    {LOCALE_deDE, "|cffc3dbff [AutoBalance]|r|cffFF8000 Der Kampf ist vorbei. Die Schwierigkeit ist nicht mehr gesperrt.|r"},
    {LOCALE_zhCN, "|cffc3dbff [AutoBalance]|r|cffFF8000 战斗结束了。难度不再被锁定。|r"},
    {LOCALE_zhTW, "|cffc3dbff [AutoBalance]|r|cffFF8000 戰鬥已結束。難度不再被鎖定。|r"},
    {LOCALE_esES, "|cffc3dbff [AutoBalance]|r|cffFF8000 El combate ha terminado. La dificultad ya no está bloqueada.|r"},
    {LOCALE_esMX, "|cffc3dbff [AutoBalance]|r|cffFF8000 El combate ha terminado. La dificultad ya no está bloqueada.|r"},
    {LOCALE_ruRU, "|cffc3dbff [AutoBalance]|r|cffFF8000 Бой окончен. Сложность больше не заблокирована.|r"},
};

std::unordered_map<std::string, const std::unordered_map<LocaleConstant, std::string>*> abTextMaps = {
    {"welcome_to_player", &AB_WELCOME_TO_PLAYER},
    {"welcome_to_gm", &AB_WELCOME_TO_GM},
    {"announce_non_gm_entering_instance", &AB_ANNOUNCE_NON_GM_ENTERING_INSTANCE},
    {"leaving_instance_combat", &AB_LEAVING_INSTANCE_COMBAT},
    {"leaving_instance", &AB_LEAVING_INSTANCE},
    {"set_offset_command_description", &AB_SET_OFFSET_COMMAND_DESCRIPTION},
    {"set_offset_command_success", &AB_SET_OFFSET_COMMAND_SUCCESS},
    {"set_offset_command_error", &AB_SET_OFFSET_COMMAND_ERROR},
    {"get_offset_command_success", &AB_GET_OFFSET_COMMAND_SUCCESS},
    {"adjusted_player_count_combat_locked", &AB_ADJUSTED_PLAYER_COUNT_COMBAT_LOCKED},
    {"adjusted_player_count_map_minimum", &AB_ADJUSTED_PLAYER_COUNT_MAP_MINIMUM},
    {"adjusted_player_count_map_minimum_difficulty_offset", &AB_ADJUSTED_PLAYER_COUNT_MAP_MINIMUM_DIFFICULTY_OFFSET},
    {"adjusted_player_count_difficulty_offset", &AB_ADJUSTED_PLAYER_COUNT_DIFFICULTY_OFFSET},
    {"adjusted_player_count", &AB_ADJUSTED_PLAYER_COUNT},
    {"lfg_range", &AB_LFG_RANGE},
    {"map_level", &AB_MAP_LEVEL},
    {"level_scaling_enabled", &AB_LEVEL_SCALING_ENABLED},
    {"level_scaling_disabled", &AB_LEVEL_SCALING_DISABLED},
    {"world_health_multiplier", &AB_WORLD_HEALTH_MULTIPLIER},
    {"world_hostile_damage_healing_multiplier_to", &AB_WORLD_HOSTILE_DAMAGE_HEALING_MULTIPLIER_TO},
    {"world_hostile_damage_healing_multiplier", &AB_WORLD_HOSTILE_DAMAGE_HEALING_MULTIPLIER},
    {"original_creature_level_range", &AB_ORIGINAL_CREATURE_LEVEL_RANGE},
    {"active_total_creatures_in_map", &AB_ACTIVE_TOTAL_CREATURES_IN_MAP},
    {"ab_command_only_in_instance", &AB_COMMAND_ONLY_IN_INSTANCE},
    {"target_no_in_instance", &AB_TARGET_NO_IN_INSTANCE},
    {"active_for_map_stats", &AB_ACTIVE_FOR_MAP_STATS},
    {"ignored_for_map_stats", &AB_IGNORED_FOR_MAP_STATS},
    {"creature_difficulty_level", &AB_CREATURE_DIFFICULTY_LEVEL},
    {"clone_of_summon", &AB_CLONE_OF_SUMMON},
    {"summon_of_summon", &AB_SUMMON_OF_SUMMON},
    {"summon_without_summoner", &AB_SUMMON_WITHOUT_SUMMONER},
    {"health_multiplier_to", &AB_HEALTH_MULTIPLIER_TO},
    {"mana_multiplier_to", &AB_MANA_MULTIPLIER_TO},
    {"armor_multiplier_to", &AB_ARMOR_MULTIPLIER_TO},
    {"damage_multiplier_to", &AB_DAMAGE_MULTIPLIER_TO},
    {"health_multiplier", &AB_HEALTH_MULTIPLIER},
    {"mana_multiplier", &AB_MANA_MULTIPLIER},
    {"armor_multiplier", &AB_ARMOR_MULTIPLIER},
    {"damage_multiplier", &AB_DAMAGE_MULTIPLIER},
    {"cc_duration_multiplier", &AB_CC_DURATION_MULTIPLIER},
    {"xp_money_multiplier", &AB_XP_MONEY_MULTIPLIER},
    {"leaving_instance_combat_change", &AB_LEAVING_INSTANCE_COMBAT_CHANGE},
};

std::string ABGetLocaleText(LocaleConstant locale, const std::string& titleType) {
    auto textMapIt = abTextMaps.find(titleType);
    if (textMapIt != abTextMaps.end())
    {
        const std::unordered_map<LocaleConstant, std::string>* textMap = textMapIt->second;
        auto it = textMap->find(locale);
        if (it != textMap->end())
            return it->second;
    }

    return "";
}
