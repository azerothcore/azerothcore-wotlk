# Copyright (C) 
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

set(scripts_STAT_SRCS
  ${scripts_STAT_SRCS}
  ${AC_SCRIPTS_DIR}/Kalimdor/zone_stonetalon_mountains.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/zone_silithus.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/zone_moonglade.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/RazorfenDowns/razorfen_downs.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/RazorfenDowns/instance_razorfen_downs.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/RazorfenDowns/razorfen_downs.h
  ${AC_SCRIPTS_DIR}/Kalimdor/ZulFarrak/instance_zulfarrak.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/ZulFarrak/zulfarrak.h
  ${AC_SCRIPTS_DIR}/Kalimdor/CavernsOfTime/EscapeFromDurnholdeKeep/boss_epoch_hunter.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/CavernsOfTime/EscapeFromDurnholdeKeep/old_hillsbrad.h
  ${AC_SCRIPTS_DIR}/Kalimdor/CavernsOfTime/EscapeFromDurnholdeKeep/boss_lieutenant_drake.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/CavernsOfTime/EscapeFromDurnholdeKeep/old_hillsbrad.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/CavernsOfTime/EscapeFromDurnholdeKeep/instance_old_hillsbrad.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/CavernsOfTime/EscapeFromDurnholdeKeep/boss_captain_skarloc.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/CavernsOfTime/BattleForMountHyjal/boss_archimonde.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/CavernsOfTime/BattleForMountHyjal/hyjalAI.h
  ${AC_SCRIPTS_DIR}/Kalimdor/CavernsOfTime/BattleForMountHyjal/hyjal_trash.h
  ${AC_SCRIPTS_DIR}/Kalimdor/CavernsOfTime/BattleForMountHyjal/boss_kazrogal.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/CavernsOfTime/BattleForMountHyjal/hyjal_trash.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/CavernsOfTime/BattleForMountHyjal/hyjal.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/CavernsOfTime/BattleForMountHyjal/hyjalAI.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/CavernsOfTime/BattleForMountHyjal/instance_hyjal.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/CavernsOfTime/BattleForMountHyjal/boss_rage_winterchill.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/CavernsOfTime/BattleForMountHyjal/hyjal.h
  ${AC_SCRIPTS_DIR}/Kalimdor/CavernsOfTime/BattleForMountHyjal/boss_azgalor.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/CavernsOfTime/BattleForMountHyjal/boss_anetheron.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/CavernsOfTime/CullingOfStratholme/boss_infinite.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/CavernsOfTime/CullingOfStratholme/boss_salramm.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/CavernsOfTime/CullingOfStratholme/boss_meathook.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/CavernsOfTime/CullingOfStratholme/boss_mal_ganis.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/CavernsOfTime/CullingOfStratholme/boss_epoch.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/CavernsOfTime/CullingOfStratholme/culling_of_stratholme.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/CavernsOfTime/CullingOfStratholme/instance_culling_of_stratholme.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/CavernsOfTime/CullingOfStratholme/culling_of_stratholme.h
  ${AC_SCRIPTS_DIR}/Kalimdor/CavernsOfTime/TheBlackMorass/the_black_morass.h
  ${AC_SCRIPTS_DIR}/Kalimdor/CavernsOfTime/TheBlackMorass/instance_the_black_morass.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/CavernsOfTime/TheBlackMorass/boss_chrono_lord_deja.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/CavernsOfTime/TheBlackMorass/the_black_morass.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/CavernsOfTime/TheBlackMorass/boss_aeonus.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/CavernsOfTime/TheBlackMorass/boss_temporus.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/BlackfathomDeeps/instance_blackfathom_deeps.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/BlackfathomDeeps/blackfathom_deeps.h
  ${AC_SCRIPTS_DIR}/Kalimdor/zone_azuremyst_isle.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/zone_orgrimmar.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/zone_desolace.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/zone_feralas.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/Maraudon/instance_maraudon.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/Maraudon/maraudon.h
  ${AC_SCRIPTS_DIR}/Kalimdor/TempleOfAhnQiraj/boss_fankriss.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/TempleOfAhnQiraj/boss_huhuran.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/TempleOfAhnQiraj/instance_temple_of_ahnqiraj.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/TempleOfAhnQiraj/mob_anubisath_sentinel.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/TempleOfAhnQiraj/boss_viscidus.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/TempleOfAhnQiraj/boss_twinemperors.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/TempleOfAhnQiraj/boss_sartura.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/TempleOfAhnQiraj/boss_cthun.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/TempleOfAhnQiraj/temple_of_ahnqiraj.h
  ${AC_SCRIPTS_DIR}/Kalimdor/TempleOfAhnQiraj/boss_skeram.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/TempleOfAhnQiraj/boss_ouro.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/TempleOfAhnQiraj/boss_bug_trio.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/zone_darkshore.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/RuinsOfAhnQiraj/boss_buru.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/RuinsOfAhnQiraj/instance_ruins_of_ahnqiraj.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/RuinsOfAhnQiraj/boss_rajaxx.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/RuinsOfAhnQiraj/boss_ossirian.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/RuinsOfAhnQiraj/boss_ayamiss.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/RuinsOfAhnQiraj/boss_moam.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/RuinsOfAhnQiraj/ruins_of_ahnqiraj.h
  ${AC_SCRIPTS_DIR}/Kalimdor/RuinsOfAhnQiraj/boss_kurinnaxx.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/zone_mulgore.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/zone_bloodmyst_isle.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/zone_thunder_bluff.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/zone_azshara.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/RazorfenKraul/instance_razorfen_kraul.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/zone_the_barrens.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/zone_ungoro_crater.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/WailingCaverns/wailing_caverns.h
  ${AC_SCRIPTS_DIR}/Kalimdor/WailingCaverns/instance_wailing_caverns.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/zone_durotar.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/zone_felwood.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/boss_azuregos.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/zone_tanaris.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/zone_dustwallow_marsh.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/zone_winterspring.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/zone_thousand_needles.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/zone_ashenvale.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/zone_teldrassil.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/OnyxiasLair/boss_onyxia.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/OnyxiasLair/onyxias_lair.h
  ${AC_SCRIPTS_DIR}/Kalimdor/OnyxiasLair/instance_onyxias_lair.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/RagefireChasm/instance_ragefire_chasm.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/DireMaul/instance_dire_maul.cpp
  ${AC_SCRIPTS_DIR}/Kalimdor/DireMaul/dire_maul.h
)

AC_ADD_SCRIPT_LOADER("Kalimdor" "ScriptLoader.h")

message("  -> Prepared: Kalimdor")
