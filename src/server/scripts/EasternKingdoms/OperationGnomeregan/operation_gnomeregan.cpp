/*
 *This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 *This program is free software; you can redistribute it and/or modify it
 *under the terms of the GNU Affero General Public License as published by the
 *Free Software Foundation; either version 3 of the License, or (at your
 *option) any later version.
 *
 *This program is distributed in the hope that it will be useful, but WITHOUT
 *ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 *FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 *more details.
 *
 *You should have received a copy of the GNU General Public License along
 *with this program. If not, see<http://www.gnu.org/licenses/>.
 */


#include "Group.h"
#include "PassiveAI.h"
#include "SpellInfo.h"
#include "Player.h"
#include "Vehicle.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "ScriptedFollowerAI.h"
#include "SpellAuras.h"
#include "operation_gnomeregan.h"

constexpr bool Debug_Mode = true;
//constexpr bool Player_Multiplier = false;	// This is used to scale up the creatures, or to add more depending on players doing quest

class npc_og_suit: public CreatureScript
{
    public:
    npc_og_suit(): CreatureScript("npc_og_suit") {}

    struct npc_og_suitAI: public npc_escortAI
    {
        npc_og_suitAI(Creature *pCreature): npc_escortAI(pCreature) {}

        void WaypointReached(uint32 /*point */) override {}

        void SetupMovement(uint32 variation)
        {
            switch (variation)
            {
                case 0:
                    AddWaypoint(0, -5063.989746 f, 485.176605 f, 401.554596 f);
                    AddWaypoint(1, -5063.474121 f, 475.547302 f, 402.917847 f);
                    AddWaypoint(2, -5076.217285 f, 469.422577 f, 403.661407 f);
                    AddWaypoint(3, -5088.637207 f, 462.860535 f, 405.323853 f);
                    AddWaypoint(4, -5095.611816 f, 455.524353 f, 404.919037 f);
                    AddWaypoint(5, -5121.946777 f, 444.406799 f, 396.678772 f);
                    AddWaypoint(6, -5137.889648 f, 449.120300 f, 394.424469 f);
                    AddWaypoint(7, -5149.414063 f, 457.053406 f, 392.511566 f);
                    AddWaypoint(8, -5160.174316 f, 468.878296 f, 390.560455 f);
                    AddWaypoint(9, -5180.711914 f, 484.161713 f, 388.160278 f);
                    AddWaypoint(10, -5189.939941 f, 498.311462 f, 387.892426 f);
                    AddWaypoint(11, -5192.106934 f, 510.962097 f, 387.746155 f);
                    AddWaypoint(12, -5193.543945 f, 529.913147 f, 388.696655 f);
                    AddWaypoint(13, -5191.546387 f, 550.148438 f, 393.705780 f);
                    AddWaypoint(14, -5188.546875 f, 586.246826 f, 404.783936 f);
                    break;
                case 1:
                    AddWaypoint(0, -5069.393066 f, 483.890228 f, 401.484985 f);
                    AddWaypoint(1, -5068.837402 f, 477.813507 f, 402.159088 f);
                    AddWaypoint(2, -5079.646484 f, 472.017700 f, 402.333557 f);
                    AddWaypoint(3, -5092.053711 f, 465.606750 f, 404.372650 f);
                    AddWaypoint(4, -5100.974609 f, 458.543640 f, 403.343445 f);
                    AddWaypoint(5, -5123.000488 f, 449.164886 f, 396.634552 f);
                    AddWaypoint(6, -5135.452637 f, 452.087646 f, 394.234161 f);
                    AddWaypoint(7, -5145.298340 f, 459.457916 f, 392.519470 f);
                    AddWaypoint(8, -5155.757813 f, 471.958282 f, 390.643585 f);
                    AddWaypoint(9, -5177.949219 f, 486.992096 f, 388.152344 f);
                    AddWaypoint(10, -5185.644043 f, 497.995270 f, 387.916534 f);
                    AddWaypoint(11, -5188.020508 f, 510.212585 f, 387.776581 f);
                    AddWaypoint(12, -5189.084961 f, 530.316467 f, 388.683136 f);
                    AddWaypoint(13, -5187.695313 f, 553.590210 f, 394.830505 f);
                    AddWaypoint(14, -5183.902832 f, 589.274170 f, 405.504333 f);
                    break;
                case 2:
                    AddWaypoint(0, -5072.857910 f, 480.193024 f, 401.575989 f);
                    AddWaypoint(1, -5081.426758 f, 476.311279 f, 401.928589 f);
                    AddWaypoint(2, -5093.935059 f, 470.681549 f, 403.441467 f);
                    AddWaypoint(3, -5102.093262 f, 463.836243 f, 403.325378 f);
                    AddWaypoint(4, -5124.031250 f, 453.702057 f, 396.498871 f);
                    AddWaypoint(5, -5132.045898 f, 454.890564 f, 394.364868 f);
                    AddWaypoint(6, -5142.617188 f, 463.545746 f, 392.404541 f);
                    AddWaypoint(7, -5152.081055 f, 476.321075 f, 391.080353 f);
                    AddWaypoint(8, -5174.884766 f, 489.358124 f, 388.310547 f);
                    AddWaypoint(9, -5181.639648 f, 499.796936 f, 387.963043 f);
                    AddWaypoint(10, -5183.538574 f, 509.857727 f, 387.984863 f);
                    AddWaypoint(11, -5183.844238 f, 528.578613 f, 388.656555 f);
                    AddWaypoint(12, -5184.622559 f, 548.945251 f, 393.504517 f);
                    AddWaypoint(13, -5179.573730 f, 585.523010 f, 404.546021 f);
                    break;
                case 3:
                    AddWaypoint(0, -5086.023926 f, 713.154724 f, 260.556427 f);
                    AddWaypoint(1, -5076.176270 f, 720.441162 f, 260.530670 f);
                    AddWaypoint(2, -5061.914063 f, 721.010620 f, 260.532135 f);
                    AddWaypoint(3, -5057.044434 f, 728.671509 f, 260.554199 f);
                    AddWaypoint(4, -5054.104980 f, 728.641357 f, 261.240845 f);
                    AddWaypoint(5, -5046.533691 f, 731.763855 f, 256.475403 f);
                    AddWaypoint(6, -4975.580078 f, 725.948120 f, 256.266113 f);
                    AddWaypoint(7, -4948.541992 f, 724.022522 f, 260.442596 f);
                    AddWaypoint(8, -4947.177246 f, 723.911560 f, 261.646118 f);
                    AddWaypoint(9, -4943.868164 f, 723.567993 f, 261.646118 f);
                    AddWaypoint(10, -4945.804199 f, 720.004578 f, 261.646118 f);
                    AddWaypoint(11, -4946.651367 f, 721.550781 f, 261.645966 f);
                    break;
                case 4:
                    AddWaypoint(0, -5085.565918 f, 725.892761 f, 260.554840 f);
                    AddWaypoint(1, -5077.067383 f, 730.409729 f, 260.539093 f);
                    AddWaypoint(2, -5064.545410 f, 735.317627 f, 260.517822 f);
                    AddWaypoint(3, -5055.252441 f, 737.436584 f, 260.556335 f);
                    AddWaypoint(4, -5053.518555 f, 737.214722 f, 261.237610 f);
                    AddWaypoint(5, -5046.488281 f, 737.037964 f, 256.475586 f);
                    AddWaypoint(6, -5039.229492 f, 739.272888 f, 256.475586 f);
                    AddWaypoint(7, -4948.179199 f, 731.976929 f, 260.396484 f);
                    AddWaypoint(8, -4946.559570 f, 731.800903 f, 261.645752 f);
                    AddWaypoint(9, -4943.546875 f, 731.456848 f, 261.645752 f);
                    AddWaypoint(10, -4944.289063 f, 735.979248 f, 261.645752 f);
                    AddWaypoint(11, -4945.196289 f, 733.968018 f, 261.645752 f);
                    break;
                case 5:
                    AddWaypoint(0, -5085.312500 f, 477.487366 f, 401.958099 f);
                    AddWaypoint(1, -5093.171387 f, 469.209137 f, 403.715790 f);
                    AddWaypoint(2, -5100.262695 f, 462.922180 f, 403.585724 f);
                    AddWaypoint(3, -5106.192871 f, 458.708801 f, 402.284393 f);
                    AddWaypoint(4, -5113.296875 f, 454.575165 f, 400.071075 f);
                    AddWaypoint(5, -5129.138184 f, 448.644257 f, 395.268951 f);
                    AddWaypoint(6, -5144.433594 f, 458.945282 f, 392.658112 f);
                    AddWaypoint(7, -5157.008301 f, 472.717865 f, 390.544586 f);
                    AddWaypoint(8, -5167.264160 f, 479.733826 f, 389.530670 f);
                    AddWaypoint(9, -5182.246582 f, 490.885254 f, 388.022522 f);
                    AddWaypoint(10, -5188.400391 f, 508.496002 f, 387.779266 f);
                    AddWaypoint(11, -5189.048828 f, 533.551758 f, 389.216064 f);
                    AddWaypoint(12, -5185.604004 f, 572.490662 f, 400.257904 f);
                    AddWaypoint(13, -5189.048828 f, 533.551758 f, 389.216064 f);
                    AddWaypoint(14, -5188.400391 f, 508.496002 f, 387.779266 f);
                    AddWaypoint(15, -5182.246582 f, 490.885254 f, 388.022522 f);
                    AddWaypoint(16, -5167.264160 f, 479.733826 f, 389.530670 f);
                    AddWaypoint(17, -5157.008301 f, 472.717865 f, 390.544586 f);
                    AddWaypoint(18, -5144.433594 f, 458.945282 f, 392.658112 f);
                    AddWaypoint(19, -5129.138184 f, 448.644257 f, 395.268951 f);
                    AddWaypoint(20, -5113.296875 f, 454.575165 f, 400.071075 f);
                    AddWaypoint(21, -5106.192871 f, 458.708801 f, 402.284393 f);
                    AddWaypoint(22, -5100.262695 f, 462.922180 f, 403.585724 f);
                    AddWaypoint(23, -5093.171387 f, 469.209137 f, 403.715790 f);
                    break;
                default:
                    LOG_ERROR("server.loading", "Unexpected movement variation (%i) in npc_og_suitAI::SetupMovement call!", variation);
                    return;
            }
            if (npc_og_suitAI *pEscortAI = CAST_AI(npc_og_suitAI, me->AI()))
            {
                if (variation == 5)
                {
                    pEscortAI->Start(true, true, ObjectGuid::Empty, nullptr, false, true);
                }
                else
                {
                    pEscortAI->Start(true, true);
                    pEscortAI->SetDespawnAtEnd(false);
                }
                pEscortAI->SetDespawnAtFar(false);
            }
        }

        void UpdateAI(const uint32 diff) override
        {
            npc_escortAI::UpdateAI(diff);
        }
    };

    CreatureAI* GetAI(Creature *pCreature) const
    {
        return new npc_og_suitAI(pCreature);
    }
};

class npc_og_infantry: public CreatureScript
{
    public:
    npc_og_infantry(): CreatureScript("npc_og_infantry") {}

    struct npc_og_infantryAI: public npc_escortAI
    {
        npc_og_infantryAI(Creature *pCreature): npc_escortAI(pCreature) {}

        uint32 uiGCD;
        uint32 uiGrenade_timer;
        uint32 uiVariation;

        void Reset() override
        {
            uiGCD = 2500;
            uiGrenade_timer = urand(10000, 15000);
        }

        void WaypointReached(uint32 i) override
        {
            if (i == 9 && uiVariation <= 3)
                if (Creature *pSuit = me->FindNearestCreature(NPC_BATTLE_SUIT, 50, true))
                {
                    CAST_AI(npc_og_suit::npc_og_suitAI, pSuit->AI())->SetupMovement(uiVariation);
                    pSuit->SetFaction(FACTION_GNOMEREGAN);
                }
        }

        void SetupMovement(uint32 variation)
        {
            switch (variation)
            {
                case 0:
                    AddWaypoint(0, -5158.309082 f, 470.632172 f, 390.470764 f);
                    AddWaypoint(1, -5145.815918 f, 455.817719 f, 392.905914 f);
                    AddWaypoint(2, -5133.497070 f, 447.780579 f, 394.853760 f);
                    AddWaypoint(3, -5123.107910 f, 447.636963 f, 396.523224 f);
                    AddWaypoint(4, -5113.999512 f, 450.278076 f, 399.421631 f);
                    AddWaypoint(5, -5099.395020 f, 459.180542 f, 403.653595 f);
                    AddWaypoint(6, -5092.314941 f, 464.330475 f, 404.561371 f);
                    AddWaypoint(7, -5077.594238 f, 472.013489 f, 402.421844 f);
                    AddWaypoint(8, -5061.697754 f, 479.314331 f, 402.391602 f);
                    AddWaypoint(9, -5064.035645 f, 486.302704 f, 401.484802 f);
                    break;
                case 1:
                    AddWaypoint(0, -5156.698242 f, 473.458801 f, 390.562836 f);
                    AddWaypoint(1, -5143.689453 f, 459.033173 f, 392.722260 f);
                    AddWaypoint(2, -5131.758301 f, 450.333496 f, 394.751221 f);
                    AddWaypoint(3, -5124.032715 f, 451.750183 f, 396.452881 f);
                    AddWaypoint(4, -5115.258789 f, 453.386505 f, 399.366028 f);
                    AddWaypoint(5, -5100.275879 f, 462.415070 f, 403.588318 f);
                    AddWaypoint(6, -5092.391602 f, 467.532990 f, 404.065125 f);
                    AddWaypoint(7, -5077.200684 f, 474.754211 f, 402.065674 f);
                    AddWaypoint(8, -5068.790039 f, 478.631042 f, 402.016907 f);
                    AddWaypoint(9, -5069.553223 f, 485.221466 f, 401.486023 f);
                    break;
                case 2:
                    AddWaypoint(0, -5154.232910 f, 475.711517 f, 390.823730 f);
                    AddWaypoint(1, -5140.836914 f, 461.044586 f, 392.818695 f);
                    AddWaypoint(2, -5130.810059 f, 454.405426 f, 394.685913 f);
                    AddWaypoint(3, -5124.641113 f, 455.657715 f, 396.326508 f);
                    AddWaypoint(4, -5115.422852 f, 456.902405 f, 399.631653 f);
                    AddWaypoint(5, -5101.960938 f, 464.402954 f, 403.353455 f);
                    AddWaypoint(6, -5093.451172 f, 469.957916 f, 403.570282 f);
                    AddWaypoint(7, -5078.112305 f, 477.189697 f, 401.767792 f);
                    AddWaypoint(8, -5071.622559 f, 476.510834 f, 402.198334 f);
                    AddWaypoint(9, -5073.813477 f, 481.830627 f, 401.484741 f);
                    break;
                case 15:
                    AddWaypoint(0, -5103.443359 f, 724.770813 f, 257.777954 f);
                    AddWaypoint(1, -5094.822754 f, 723.598328 f, 260.490723 f);
                    AddWaypoint(2, -5086.649902 f, 723.079773 f, 260.556946 f);
                    AddWaypoint(3, -5055.190430 f, 736.540833 f, 260.557220 f);
                    AddWaypoint(4, -5054.147949 f, 736.447632 f, 261.243988 f);
                    AddWaypoint(5, -5047.112305 f, 737.144043 f, 256.501160 f);
                    AddWaypoint(6, -5036.274414 f, 739.345154 f, 256.475739 f);
                    AddWaypoint(7, -4976.154297 f, 734.201904 f, 256.277985 f);
                    AddWaypoint(8, -4947.897461 f, 732.244080 f, 260.438263 f);
                    AddWaypoint(9, -4946.339844 f, 732.115906 f, 261.646210 f);
                    AddWaypoint(10, -4939.273438 f, 734.958496 f, 261.646210 f);
                    AddWaypoint(11, -4938.026855 f, 741.879028 f, 261.644684 f);
                    AddWaypoint(12, -4938.707520 f, 740.875122 f, 261.644684 f);
                    break;
                case 16:
                    AddWaypoint(0, -5109.180664 f, 725.262878 f, 255.981613 f);
                    AddWaypoint(1, -5095.178711 f, 724.099243 f, 260.368286 f);
                    AddWaypoint(2, -5086.729004 f, 723.518494 f, 260.557068 f);
                    AddWaypoint(3, -5055.729004 f, 735.350525 f, 260.556061 f);
                    AddWaypoint(4, -5054.227051 f, 735.254822 f, 261.244995 f);
                    AddWaypoint(5, -5046.759766 f, 735.879211 f, 256.475433 f);
                    AddWaypoint(6, -5035.186523 f, 739.123962 f, 256.475433 f);
                    AddWaypoint(7, -4974.740234 f, 734.052185 f, 256.263763 f);
                    AddWaypoint(8, -4963.679688 f, 732.872192 f, 257.911133 f);
                    AddWaypoint(9, -4959.834961 f, 734.894470 f, 259.341797 f);
                    AddWaypoint(10, -4963.027832 f, 735.367432 f, 258.783722 f);
                    break;
                case 17:
                    AddWaypoint(0, -5104.795898 f, 717.425720 f, 257.537598 f);
                    AddWaypoint(1, -5095.783203 f, 716.306946 f, 260.370605 f);
                    AddWaypoint(2, -5085.620117 f, 716.721130 f, 260.557373 f);
                    AddWaypoint(3, -5056.110352 f, 727.733398 f, 260.561371 f);
                    AddWaypoint(4, -5054.630371 f, 727.904541 f, 261.246185 f);
                    AddWaypoint(5, -5047.102051 f, 731.708801 f, 256.475403 f);
                    AddWaypoint(6, -5036.331055 f, 730.962219 f, 256.475403 f);
                    AddWaypoint(7, -4974.770996 f, 726.103333 f, 256.258118 f);
                    AddWaypoint(8, -4948.733398 f, 723.634705 f, 260.412781 f);
                    AddWaypoint(9, -4947.263184 f, 723.494263 f, 261.646088 f);
                    AddWaypoint(10, -4940.096191 f, 717.815491 f, 261.646088 f);
                    AddWaypoint(11, -4939.854980 f, 712.329895 f, 261.644684 f);
                    AddWaypoint(12, -4940.705566 f, 713.400269 f, 261.644684 f);
                    break;
                case 18:
                    AddWaypoint(0, -5109.956543 f, 717.818481 f, 255.921844 f);
                    AddWaypoint(1, -5095.956055 f, 716.377014 f, 260.314667 f);
                    AddWaypoint(2, -5085.541992 f, 716.675903 f, 260.557373 f);
                    AddWaypoint(3, -5056.114258 f, 727.704346 f, 260.561310 f);
                    AddWaypoint(4, -5054.369629 f, 727.836121 f, 261.243469 f);
                    AddWaypoint(5, -5047.054199 f, 731.594299 f, 256.475586 f);
                    AddWaypoint(6, -5036.313477 f, 731.290100 f, 256.475586 f);
                    AddWaypoint(7, -4975.180664 f, 725.747314 f, 256.261780 f);
                    AddWaypoint(8, -4964.648926 f, 725.515686 f, 257.849091 f);
                    AddWaypoint(9, -4960.842285 f, 722.796204 f, 259.332458 f);
                    AddWaypoint(10, -4964.441895 f, 722.924133 f, 258.709137 f);
                    break;
                default:
                    LOG_ERROR("server.loading", "Unexpected movement variation (%i) in npc_og_infantryAI::SetupMovement call!", variation);
                    return;
            }
            uiVariation = variation;
            if (npc_og_infantryAI *pEscortAI = CAST_AI(npc_og_infantryAI, me->AI()))
            {
                pEscortAI->Start(true, true);
                pEscortAI->SetDespawnAtFar(false);
                if (variation > 14)
                    pEscortAI->SetDespawnAtEnd(false);
            }
        }

        void AttackStart(Unit *pWho) override
        {
            if (!pWho)
                return;

            if (me->Attack(pWho, true))
            {
                me->AddThreat(pWho, 10.0 f);
                me->SetInCombatWith(pWho);
                pWho->SetInCombatWith(me);
                DoStartMovement(pWho, 20.0 f);
                SetCombatMovement(true);
            }
        }

        void UpdateAI(const uint32 diff) override
        {
            npc_escortAI::UpdateAI(diff);

            if (!UpdateVictim())
                return;

            if (me->IsWithinMeleeRange(me->GetVictim()))
            {
                if (uiGCD <= diff)
                {
                    if (!urand(0, 3))
                        DoCast(me->GetVictim(), SPELL_ATTACK);

                    uiGCD = 5000;
                }
                else
                    uiGCD -= diff;
            }
            else
            {
                if (uiGCD <= diff)
                {
                    DoCast(me->GetVictim(), SPELL_SHOOT);
                    uiGCD = 3000;
                }
                else
                    uiGCD -= diff;
            }

            if (uiGrenade_timer <= diff)
            {
                if (Unit *pTarget = SelectTarget(SelectTargetMethod::Random, 0))
                    DoCast(pTarget, SPELL_GRENADE);
                uiGrenade_timer = urand(10000, 15000);
            }
            else
                uiGrenade_timer -= diff;
        }
    };

    CreatureAI* GetAI(Creature *pCreature) const
    {
        return new npc_og_infantryAI(pCreature);
    }
};

class npc_og_tank: public CreatureScript
{
    public:
    npc_og_tank(): CreatureScript("npc_og_tank") {}

    struct npc_og_tankAI: public npc_escortAI
    {
        npc_og_tankAI(Creature *pCreature): npc_escortAI(pCreature) {}

        uint32 uiGCD;

        void Reset() override
        {
            uiGCD = urand(5000, 7000);
        }

        void WaypointReached(uint32 /*pointId */) override {}

        void SetupMovement(uint32 variation)
        {
            switch (variation)
            {
                case 0:
                    AddWaypoint(0, -5402.410156 f, 543.925049 f, 387.239044 f);
                    AddWaypoint(1, -5395.444824 f, 543.309692 f, 386.707794 f);
                    AddWaypoint(2, -5386.854492 f, 546.801086 f, 386.116394 f);
                    AddWaypoint(3, -5360.019043 f, 558.631836 f, 387.000153 f);
                    AddWaypoint(4, -5335.933594 f, 581.771667 f, 386.494202 f);
                    AddWaypoint(5, -5312.586426 f, 572.810486 f, 388.351349 f);
                    AddWaypoint(6, -5303.000000 f, 567.692078 f, 386.120575 f);
                    break;
                case 1:
                    AddWaypoint(0, -5404.278809 f, 530.734863 f, 387.149506 f);
                    AddWaypoint(1, -5395.379883 f, 532.568787 f, 387.045959 f);
                    AddWaypoint(2, -5383.813477 f, 538.125305 f, 386.221008 f);
                    AddWaypoint(3, -5358.499023 f, 552.581299 f, 387.086823 f);
                    AddWaypoint(4, -5344.463867 f, 553.109802 f, 384.685608 f);
                    AddWaypoint(5, -5318.844727 f, 552.937134 f, 385.461639 f);
                    break;
                case 2:
                    AddWaypoint(0, -5394.302734 f, 518.734436 f, 386.275909 f);
                    AddWaypoint(1, -5388.748535 f, 524.705505 f, 386.650208 f);
                    AddWaypoint(2, -5378.070313 f, 529.968689 f, 386.955872 f);
                    AddWaypoint(3, -5353.919434 f, 533.967957 f, 385.093628 f);
                    AddWaypoint(4, -5326.888184 f, 539.787048 f, 384.828491 f);
                    break;
                case 3:
                    AddWaypoint(0, -5280.954102 f, 559.265808 f, 385.679932 f);
                    AddWaypoint(1, -5267.337402 f, 540.788391 f, 387.169342 f);
                    AddWaypoint(2, -5255.488281 f, 521.325256 f, 386.325378 f);
                    AddWaypoint(3, -5241.595215 f, 513.660339 f, 387.892212 f);
                    AddWaypoint(4, -5229.519531 f, 508.052399 f, 387.756287 f);
                    AddWaypoint(5, -5208.560059 f, 495.748932 f, 387.916199 f);
                    AddWaypoint(6, -5196.718750 f, 480.324402 f, 387.072052 f);
                    AddWaypoint(7, -5164.643555 f, 447.614532 f, 394.698822 f);
                    AddWaypoint(8, -5137.479492 f, 428.433716 f, 395.987518 f);
                    AddWaypoint(9, -5138.148926 f, 404.461121 f, 396.885284 f);
                    AddWaypoint(10, -5139.549805 f, 386.402893 f, 396.906952 f);
                    AddWaypoint(11, -5140.363281 f, 375.913422 f, 397.931152 f);
                    AddWaypoint(12, -5142.502441 f, 346.961121 f, 398.053497 f);
                    AddWaypoint(13, -5141.139160 f, 359.352966 f, 397.011078 f);
                    AddWaypoint(14, -5140.697754 f, 378.842957 f, 397.872406 f);
                    AddWaypoint(15, -5138.448242 f, 395.032410 f, 396.352783 f);
                    AddWaypoint(16, -5133.321289 f, 431.758118 f, 396.322357 f);
                    AddWaypoint(17, -5161.619141 f, 452.354553 f, 394.115448 f);
                    AddWaypoint(18, -5185.990723 f, 478.249481 f, 387.941895 f);
                    AddWaypoint(19, -5201.514160 f, 491.001923 f, 387.610474 f);
                    AddWaypoint(20, -5227.306641 f, 500.188507 f, 387.142792 f);
                    AddWaypoint(21, -5237.200195 f, 513.050537 f, 387.736145 f);
                    AddWaypoint(22, -5251.963379 f, 525.391174 f, 386.584442 f);
                    AddWaypoint(23, -5266.466797 f, 537.124451 f, 387.494537 f);
                    AddWaypoint(24, -5283.755859 f, 560.300293 f, 385.199860 f);
                    break;
                case 4:
                    AddWaypoint(0, -5263.007813 f, 572.262085 f, 388.673157 f);
                    AddWaypoint(1, -5236.423340 f, 542.552368 f, 389.753387 f);
                    AddWaypoint(2, -5214.283691 f, 541.975586 f, 389.412659 f);
                    AddWaypoint(3, -5197.762207 f, 531.495056 f, 388.887299 f);
                    AddWaypoint(4, -5179.492188 f, 519.916443 f, 388.667297 f);
                    AddWaypoint(5, -5175.582520 f, 502.293945 f, 388.701996 f);
                    AddWaypoint(6, -5167.252441 f, 493.800568 f, 390.061920 f);
                    AddWaypoint(7, -5157.853027 f, 480.655945 f, 390.738495 f);
                    AddWaypoint(8, -5145.563965 f, 479.578796 f, 393.390839 f);
                    AddWaypoint(9, -5131.671875 f, 465.390198 f, 394.823059 f);
                    AddWaypoint(10, -5113.997559 f, 476.204285 f, 397.972015 f);
                    AddWaypoint(11, -5118.809570 f, 470.737091 f, 397.644592 f);
                    AddWaypoint(12, -5136.430664 f, 457.685455 f, 393.588379 f);
                    AddWaypoint(13, -5149.951172 f, 475.280426 f, 391.100586 f);
                    AddWaypoint(14, -5170.628418 f, 490.365723 f, 388.964539 f);
                    AddWaypoint(15, -5177.971191 f, 510.636871 f, 388.935669 f);
                    AddWaypoint(16, -5179.023438 f, 522.535889 f, 388.936523 f);
                    AddWaypoint(17, -5200.432129 f, 530.929260 f, 388.382721 f);
                    AddWaypoint(18, -5214.941895 f, 535.946106 f, 388.297760 f);
                    AddWaypoint(19, -5234.781250 f, 535.892456 f, 388.333527 f);
                    AddWaypoint(20, -5250.526367 f, 551.972473 f, 388.484741 f);
                    AddWaypoint(21, -5262.729492 f, 572.853027 f, 388.782532 f);
                    break;
                default:
                    LOG_ERROR("server.loading", "Unexpected movement variation (%i) in npc_og_tankAI::SetupMovement call!", variation);
                    return;
            }
            if (npc_og_tankAI *pEscortAI = CAST_AI(npc_og_tankAI, me->AI()))
            {
                if (variation > 2)
                    pEscortAI->Start(true, true, ObjectGuid::Empty, nullptr, false, true);
                else
                {
                    pEscortAI->Start(true, true);
                    pEscortAI->SetDespawnAtEnd(false);
                }
                pEscortAI->SetDespawnAtFar(false);
                me->setActive(true);
            }
        }

        void UpdateAI(const uint32 diff) override
        {
            npc_escortAI::UpdateAI(diff);

            if (!UpdateVictim())
                return;

            if (uiGCD <= diff)
            {
                DoCast(me->GetVictim(), !urand(0, 3) ? SPELL_MACHINE_GUN : SPELL_FLAME_SPRAY);
                uiGCD = urand(5000, 7000);
            }
            else
                uiGCD -= diff;

            if (!me->HasUnitState(UNIT_STATE_CASTING))
                DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature *pCreature) const
    {
        return new npc_og_tankAI(pCreature);
    }
};

class npc_og_i_tank: public CreatureScript
{
    public:
    npc_og_i_tank(): CreatureScript("npc_og_i_tank") {}

    struct npc_og_i_tankAI: public npc_escortAI
    {
        npc_og_i_tankAI(Creature *pCreature): npc_escortAI(pCreature) {}

        void Reset() override {}

        void WaypointReached(uint32 /*waypointId */) override {}

        void SetupMovement(uint32 variation)
        {
            switch (variation)
            {
                case 0:
                    AddWaypoint(0, -5339.479980 f, 545.804688 f, 384.888336 f);
                    AddWaypoint(1, -5348.981934 f, 555.181458 f, 385.137665 f);
                    AddWaypoint(2, -5348.816406 f, 567.433472 f, 384.981537 f);
                    AddWaypoint(3, -5348.981934 f, 555.181458 f, 385.137665 f);
                    break;
                case 1:
                    AddWaypoint(0, -5318.129395 f, 578.573425 f, 387.439697 f);
                    AddWaypoint(1, -5305.049316 f, 584.957153 f, 389.928864 f);
                    AddWaypoint(2, -5291.333496 f, 589.698730 f, 387.835785 f);
                    AddWaypoint(3, -5283.275391 f, 583.998413 f, 386.930725 f);
                    AddWaypoint(4, -5279.059082 f, 571.535461 f, 386.423187 f);
                    AddWaypoint(5, -5283.275391 f, 583.998413 f, 386.930725 f);
                    AddWaypoint(6, -5291.333496 f, 589.698730 f, 387.835785 f);
                    AddWaypoint(7, -5305.049316 f, 584.957153 f, 389.928864 f);
                    break;
                case 3:
                    AddWaypoint(0, -5085.889648 f, 475.435455 f, 402.240814 f);
                    AddWaypoint(1, -5092.540527 f, 468.895569 f, 403.767853 f);
                    AddWaypoint(2, -5100.161133 f, 463.751984 f, 403.568817 f);
                    AddWaypoint(3, -5110.015625 f, 455.567688 f, 401.042847 f);
                    AddWaypoint(4, -5116.595215 f, 453.564240 f, 398.949249 f);
                    AddWaypoint(5, -5127.697754 f, 447.250763 f, 395.562195 f);
                    AddWaypoint(6, -5116.622559 f, 453.300476 f, 398.915619 f);
                    AddWaypoint(7, -5111.297363 f, 456.783386 f, 400.862091 f);
                    AddWaypoint(8, -5100.011719 f, 463.002197 f, 403.610992 f);
                    AddWaypoint(9, -5093.187500 f, 469.667328 f, 403.619598 f);
                    AddWaypoint(10, -5088.007324 f, 474.113739 f, 402.551941 f);
                    break;
                default:
                    LOG_ERROR("server.loading", "Unexpected movement variation (%i) in npc_og_i_tankAI::SetupMovement call!", variation);
                    return;
            }
            if (npc_og_i_tankAI *pEscortAI = CAST_AI(npc_og_i_tankAI, me->AI()))
            {
                pEscortAI->Start(true, true, ObjectGuid::Empty, nullptr, false, true);
                pEscortAI->SetDespawnAtFar(false);
                me->setActive(true);
            }
        }

        void UpdateAI(const uint32 diff) override
        {
            npc_escortAI::UpdateAI(diff);

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature *pCreature) const
    {
        return new npc_og_i_tankAI(pCreature);
    }
};

class npc_og_assistants: public CreatureScript
{
    public:
    npc_og_assistants(): CreatureScript("npc_og_assistants") {}

    struct npc_og_assistantsAI: public npc_escortAI
    {
        npc_og_assistantsAI(Creature *pCreature): npc_escortAI(pCreature)
        {
            me->SetFaction(35);
        }

        void Reset() override {}

        void WaypointReached(uint32 i) override
        {
            switch (i)
            {
                case 0:
                case 2:
                case 20:
                case 35:
                case 52:
                case 57:
                case 65:
                case 66:
                case 67:
                case 70:
                    SetHoldState(true);
                    break;
                case 49:
                    SetHoldState(true);
                    me->Dismount();
                    if (Creature *pMekkatorque = me->FindNearestCreature(NPC_MEKKATORQUE, 100.0 f, true))
                        me->CastSpell(pMekkatorque, SPELL_TRIGGER, true);
                    break;
                case 50:
                    me->CastSpell(me, SPELL_PARACHUTE_AURA, true);
                    break;
                case 51:
                    me->RemoveAurasDueToSpell(SPELL_PARACHUTE_AURA);
                    me->Mount(me->GetEntry() == NPC_FASTBLAST ? DATA_MOUNT_FAST : DATA_MOUNT_COG);
                    break;
                case 11:
                case 17:
                    SetHoldState(true);
                    if (Creature *pMekkatorque = me->FindNearestCreature(NPC_MEKKATORQUE, 100.0 f, true))
                        me->CastSpell(pMekkatorque, SPELL_TRIGGER, true);
                    break;
            }
        }

        void SetHoldState(bool b_OnHold)
        {
            SetEscortPaused(b_OnHold);
        }

        void UpdateAI(const uint32 diff) override
        {
            npc_escortAI::UpdateAI(diff);

            if (!UpdateVictim())
                return;
        }
    };

    CreatureAI* GetAI(Creature *pCreature) const
    {
        return new npc_og_assistantsAI(pCreature);
    }
};

class npc_og_mekkatorque: public CreatureScript
{
    public:
    npc_og_mekkatorque(): CreatureScript("npc_og_mekkatorque")
    {
        bProcessing = false;
    }

    struct npc_og_mekkatorqueAI: public npc_escortAI
    {
        npc_og_mekkatorqueAI(Creature *pCreature): npc_escortAI(pCreature) {}

        uint32 uiStep;
        uint32 uiStep_timer;
        uint32 uiRLDestroyed;
        uint32 uiCannonsDestroyed;
        uint32 uiTroggs;
        uint32 uiSoldiers;
        bool bCanSummonBomber;
        bool bCannonIntro;
        bool bBuffs;
        bool bControlWP_1;
        bool bControlWP_2;
        Creature *RL[4];
        Creature *Tank[3];
        Creature *Cannon[6];
        Creature *BattleSuit[3];
        Creature * ExplosionBunny;
        std::list<GameObject*> BannerList_temp;
        std::list<GameObject*> BannerList;
        std::list<ObjectGuid> SummonsGUID;
        Player * pEscortPlayer;

        bool decor_p1, decor_p2, decor_p3, decor_p4, decor_p5, decor_p6 = false;

        void Reset() override
        {
            uiStep = 0;
            uiTroggs = 0;
            uiSoldiers = 0;
            uiStep_timer = 0;
            uiRLDestroyed = 0;
            uiCannonsDestroyed = 0;
            bCanSummonBomber = true;
            bCannonIntro = false;
            bBuffs = false;
            bControlWP_1 = false;
            bControlWP_2 = false;
            decor_p1 = decor_p2 = decor_p3 = decor_p4 = decor_p5 = decor_p6 = false;
        }

        void WaypointReached(uint32 i) override
        {
            switch (i)
            {
                case 0:
                    DoPlayMusic(0);
                    SetHoldState(true);
                    break;
                case 2:
                    SetHoldState(true);
                    DoTalk(me, MEK_5_1, SOUND_MEK_5, false);
                    JumpToNextStep(3500);
                    break;
                case 3:
                    SquadSetRun(true);
                    DoUpdateWorldState(WORLDSTATE_RL_DESTROYED, uiRLDestroyed);
                    DoUpdateWorldState(WORLDSTATE_RL_DESTROYED_CTRL, 1);
                    break;
                case 5:
                    DoTalk(me, MEK_6_1, SOUND_MEK_6, false);
                    if (RL[0]->IsAlive())
                        AttackStart(RL[0]);
                    break;
                case 7:
                    if (RL[1]->IsAlive())
                        AttackStart(RL[1]);
                    break;
                case 8:
                    if (RL[2]->IsAlive())
                        AttackStart(RL[2]);
                    break;
                case 10:
                    if (RL[3]->IsAlive())
                        AttackStart(RL[3]);
                    break;
                case 12:
                    SetHoldState(true);
                    DoUpdateWorldState(WORLDSTATE_RL_DESTROYED_CTRL, 0);
                    DoUpdateWorldState(WORLDSTATE_AIRFIELD_ATTACKED, 0);
                    DoUpdateWorldState(WORLDSTATE_AIRFIELD_CAPTURED, 1);
                    DoTalk(me, MEK_10_1, SOUND_MEK_10, false);
                    for (int8 n = 0; n < 5; ++n)
                        me->SummonCreature(NPC_INFANTRY, InfantrySpawn[n], TEMPSUMMON_MANUAL_DESPAWN);
                    UpdateBannerState(70.0 f);
                    JumpToNextStep(5500);
                    break;
                case 18:
                    SetHoldState(true);
                    JumpToNextStep(0);
                    break;
                case 19:
                    SetHoldState(true);
                    me->Dismount();
                    JumpToNextStep(2000);
                    break;
                case 21:
                    SetHoldState(true);
                    me->Mount(DATA_MOUNT_MEK);
                    for (int8 n = 18; n < 26; ++n)
                        me->SummonCreature(NPC_I_INFANTRY, iInfantrySpawn[n], TEMPSUMMON_MANUAL_DESPAWN);
                    if (Debug_Mode) JumpToNextStep(1000);
                    else JumpToNextStep(7000);
                    break;
                case 27:
                    DoUpdateWorldState(WORLDSTATE_BATTLE_NEAR_ENTRANCE, 1);
                    for (int8 n = 5; n < 11; ++n)
                        me->SummonCreature(NPC_INFANTRY, InfantrySpawn[n], TEMPSUMMON_MANUAL_DESPAWN);
                    UpdateBannerState(70.0 f);
                    break;
                case 34:
                    if (Creature *pSuit = me->SummonCreature(NPC_BATTLE_SUIT, BattleSuitSpawn[5], TEMPSUMMON_MANUAL_DESPAWN))
                        CAST_AI(npc_og_suit::npc_og_suitAI, pSuit->AI())->SetupMovement(5);
                    UpdateBannerState(10.0 f);
                    break;
                case 36:
                    SetHoldState(true);
                    DoTalk(me, MEK_13_1, SOUND_MEK_13, false);
                    JumpToNextStep(6500);
                    break;
                case 37:
                    UpdateBannerState(10.0 f);
                    break;
                case 47:
                    UpdateBannerState(80.0 f);
                    break;
                case 50:
                    SetHoldState(true);
                    me->Dismount();
                    JumpToNextStep(1000);
                    break;
                case 51:
                    me->CastSpell(me, SPELL_PARACHUTE_AURA, true);
                    break;
                case 52:
                    me->RemoveAurasDueToSpell(SPELL_PARACHUTE_AURA);
                    me->Mount(DATA_MOUNT_MEK);
                    break;
                case 53:
                    SetHoldState(true);
                    UpdateBannerState(30.0 f);
                    JumpToNextStep(5000);
                    break;
                case 58:
                    SetHoldState(true);
                    DoTalk(me, MEK_16_1, SOUND_MEK_16, false);
                    DoUpdateWorldState(WORLDSTATE_BATLLE_IN_TUNNELS, 1);
                    JumpToNextStep(3000);
                    break;
                case 67:
                    SetHoldState(true);
                    JumpToNextStep(3000);
                    break;
                case 68:
                    SetHoldState(true);
                    JumpToNextStep(3500);
                    break;
                case 71:
                   	// wtf?
                   	//me->SetReactState(REACT_AGGRESSIVE);
                   	//if (Creature* pCogspin = me->FindNearestCreature(NPC_COGSPIN, 100.0f))
                   	//pCogspin->SetReactState(REACT_AGGRESSIVE);
                   	//if (Creature* pFastblast = me->FindNearestCreature(NPC_FASTBLAST, 100.0f))
                   	//pFastblast->SetReactState(REACT_AGGRESSIVE);
                    SetHoldState(true);
                    break;
                case 75:
                    SetHoldState(true);
                    me->SummonCreature(NPC_BRAG_BOT, BragBotSpawn[1], TEMPSUMMON_MANUAL_DESPAWN);
                    JumpToNextStep(2000);
                    break;
            }
        }

        void UpdateAI(const uint32 diff) override
        {
            DoRefreshWorldStates();

            npc_escortAI::UpdateAI(diff);

            if (bBuffs)
            {
                if (!me->HasAura(SPELL_BRILLIANT_TACTICS))
                    me->AddAura(SPELL_BRILLIANT_TACTICS, me);
                if (!me->HasAura(SPELL_HEALTH_REGEN))
                    me->AddAura(SPELL_HEALTH_REGEN, me);
            }

            if (uiStep_timer <= diff)
            {
                if (Debug_Mode)
                    LOG_ERROR("server.loading", "NEW STEP: %u", uiStep);
                switch (uiStep)
                {
                    case 1:
                        me->Say(MEK_1_2, LANG_UNIVERSAL);
                        if (Debug_Mode) JumpToNextStep(1000);
                        else JumpToNextStep(9000);
                        break;
                    case 2:
                        me->Say(MEK_1_3, LANG_UNIVERSAL);
                        if (Debug_Mode) JumpToNextStep(1000);
                        else JumpToNextStep(5000);
                        break;
                    case 3:
                        DoTalk(me, MEK_2_1, SOUND_MEK_2, false);
                       	//JumpToNextStep(13000);
                        if (Debug_Mode) JumpToNextStep(1000);
                        else JumpToNextStep(13000);
                        break;
                    case 4:
                        DoTalk(me, MEK_3_1, SOUND_MEK_3, false);
                        if (Debug_Mode) JumpToNextStep(1000);
                        else JumpToNextStep(4000);
                        break;
                    case 5:
                        me->Yell(MEK_3_2, LANG_UNIVERSAL);
                        DoUpdateWorldState(WORLDSTATE_COUNTDOWN_CTRL, 1);
                        DoUpdateWorldState(WORLDSTATE_COUNTDOWN, 5);
                        if (Debug_Mode) JumpToNextStep(1000);
                        else JumpToNextStep(60000);
                        break;
                    case 6:
                        DoUpdateWorldState(WORLDSTATE_COUNTDOWN, 4);
                        if (Debug_Mode) JumpToNextStep(1000);
                        else JumpToNextStep(60000);
                        break;
                    case 7:
                        DoUpdateWorldState(WORLDSTATE_COUNTDOWN, 3);
                        if (Debug_Mode) JumpToNextStep(1000);
                        else JumpToNextStep(60000);
                        break;
                    case 8:
                        DoUpdateWorldState(WORLDSTATE_COUNTDOWN, 2);
                        if (Debug_Mode) JumpToNextStep(1000);
                        else JumpToNextStep(60000);
                        break;
                    case 9:
                        DoUpdateWorldState(WORLDSTATE_COUNTDOWN, 1);
                        if (Debug_Mode) JumpToNextStep(1000);
                        else JumpToNextStep(60000);
                        break;
                    case 10:
                        DoUpdateWorldState(WORLDSTATE_COUNTDOWN_CTRL, 0);
                        DoUpdateWorldState(WORLDSTATE_IN_PROCCESS, 1);
                        if (npc_og_mekkatorqueAI *pEscortAI = CAST_AI(npc_og_mekkatorqueAI, me->AI()))
                        {
                            pEscortAI->Start(true, true, pEscortPlayer->GetGUID());
                            pEscortAI->SetDespawnAtFar(false);
                            pEscortAI->SetDespawnAtEnd(false);
                            me->setActive(true);
                        }
                        if (Creature *pCogspin = me->FindNearestCreature(NPC_COGSPIN, 20))
                        {
                            CAST_AI(npc_og_assistants::npc_og_assistantsAI, pCogspin->AI())->Start(true, true, pEscortPlayer->GetGUID());
                            CAST_AI(npc_og_assistants::npc_og_assistantsAI, pCogspin->AI())->SetDespawnAtFar(false);
                            CAST_AI(npc_og_assistants::npc_og_assistantsAI, pCogspin->AI())->SetDespawnAtEnd(false);
                            pCogspin->setActive(true);
                        }
                        if (Creature *pFastblast = me->FindNearestCreature(NPC_FASTBLAST, 20))
                        {
                            CAST_AI(npc_og_assistants::npc_og_assistantsAI, pFastblast->AI())->Start(true, true, pEscortPlayer->GetGUID());
                            CAST_AI(npc_og_assistants::npc_og_assistantsAI, pFastblast->AI())->SetDespawnAtFar(false);
                            CAST_AI(npc_og_assistants::npc_og_assistantsAI, pFastblast->AI())->SetDespawnAtEnd(false);
                            pFastblast->setActive(true);
                        }
                        DoTalk(me, MEK_4_1, SOUND_MEK_4, 0);
                        if (Debug_Mode) JumpToNextStep(1000);
                        else JumpToNextStep(7700);
                        break;
                    case 11:
                        me->Yell(MEK_4_2, LANG_UNIVERSAL);
                        DoPlayMusic(1);
                        me->CastSpell(me, SPELL_HEALTH_REGEN, true);
                        me->CastSpell(me, SPELL_BRILLIANT_TACTICS, true);
                        bBuffs = true;
                        JumpToNextStep(2000);
                        break;
                    case 12:
                        SetHoldState(false);
                        break;
                    case 14:
                        me->Say(MEK_5_2, LANG_UNIVERSAL);
                        DoUpdateWorldState(WORLDSTATE_AIRFIELD_ATTACKED, 1);
                        for (int8 n = 0; n < 3; ++n)
                            CAST_AI(npc_og_tank::npc_og_tankAI, Tank[n]->AI())->SetupMovement(n);
                        JumpToNextStep(3300);
                        break;
                    case 15:
                        me->Say(MEK_5_3, LANG_UNIVERSAL);
                        if (Debug_Mode) JumpToNextStep(1000);
                        else JumpToNextStep(7000);
                        break;
                    case 16:
                        SetHoldState(false);
                        break;
                    case 18:
                        me->Say(MEK_10_2, LANG_UNIVERSAL);
                        DoUpdateWorldState(WORLDSTATE_BATTLE_NEAR_WORKSHOPS, 1);
                        DoUpdateWorldState(WORLDSTATE_CANNONS_DESTROYED_CTRL, 1);
                        DoUpdateWorldState(WORLDSTATE_CANNONS_DESTROYED, 0);
                        for (int8 n = 0; n < 6; ++n)
                        {
                            Cannon[n] = me->SummonCreature(NPC_CANNON, CannonSpawn[n], TEMPSUMMON_MANUAL_DESPAWN);
                            Cannon[n]->CastSpell(Cannon[n], SPELL_TRIGGER, true);
                        }
                        me->SummonGameObject(GO_RAD_CONTROL, -5072.80 f, 441.48 f, 410.97 f, 2.6 f, 0.0 f, 0.0 f, 0.0 f, 0.0 f, 0);
                        for (int8 n = 0; n < 3; ++n)
                            BattleSuit[n] = me->SummonCreature(NPC_BATTLE_SUIT, BattleSuitSpawn[n], TEMPSUMMON_MANUAL_DESPAWN);
                        if (Creature *iTank = me->SummonCreature(NPC_I_TANK, iTankSpawn[3], TEMPSUMMON_MANUAL_DESPAWN))
                            CAST_AI(npc_og_i_tank::npc_og_i_tankAI, iTank->AI())->SetupMovement(3);
                        for (int8 n = 8; n < 18; ++n)
                            me->SummonCreature(NPC_I_INFANTRY, iInfantrySpawn[n], TEMPSUMMON_MANUAL_DESPAWN);
                        if (Debug_Mode) JumpToNextStep(1000);
                        else JumpToNextStep(7250);
                        break;
                    case 19:
                        me->Say(MEK_10_3, LANG_UNIVERSAL);
                        if (Creature *pTank1 = me->SummonCreature(NPC_TANK, TankSpawn[3], TEMPSUMMON_MANUAL_DESPAWN))
                            if (Creature *pTank2 = me->SummonCreature(NPC_TANK, TankSpawn[4], TEMPSUMMON_MANUAL_DESPAWN))
                            {
                                CAST_AI(npc_og_tank::npc_og_tankAI, pTank1->AI())->SetupMovement(3);
                                CAST_AI(npc_og_tank::npc_og_tankAI, pTank2->AI())->SetupMovement(4);
                            }
                        DoSummonBomber();
                        JumpToNextStep(3000);
                        break;
                    case 20:
                        SetHoldState(false);
                        break;
                    case 22:
                        if (me->FindNearestCreature(NPC_CANNON, 100.0 f, true))
                        {
                            uiStep_timer = 2000;
                            return;
                        }

                        DoTalk(me, MEK_12_1, SOUND_MEK_12, false);
                        if (Creature *pDriver1 = me->SummonCreature(NPC_INFANTRY, BattleSuitDriverSpawn[0], TEMPSUMMON_MANUAL_DESPAWN))
                            if (Creature *pDriver2 = me->SummonCreature(NPC_INFANTRY, BattleSuitDriverSpawn[1], TEMPSUMMON_MANUAL_DESPAWN))
                                if (Creature *pDriver3 = me->SummonCreature(NPC_INFANTRY, BattleSuitDriverSpawn[2], TEMPSUMMON_MANUAL_DESPAWN))
                                {
                                    CAST_AI(npc_og_infantry::npc_og_infantryAI, pDriver1->AI())->SetupMovement(0);
                                    CAST_AI(npc_og_infantry::npc_og_infantryAI, pDriver2->AI())->SetupMovement(1);
                                    CAST_AI(npc_og_infantry::npc_og_infantryAI, pDriver3->AI())->SetupMovement(2);
                                }
                        if (Debug_Mode) JumpToNextStep(1000);
                        else JumpToNextStep(8500);
                        break;
                    case 23:
                        if (!decor_p3)
                            HandleDecorByPhase(me, 3);
                        me->Say(MEK_12_2, LANG_UNIVERSAL);
                        if (Debug_Mode) JumpToNextStep(1000);
                        else JumpToNextStep(8500);
                        break;
                    case 24:
                        SetHoldState(false);
                        break;
                    case 26:
                        SetEscortPaused(false);
                        JumpToNextStep(0);
                        break;
                    case 28:
                        SetHoldState(false);
                        break;
                    case 30:
                        me->Say(MEK_13_2, LANG_UNIVERSAL);
                        if (Debug_Mode) JumpToNextStep(1000);
                        else JumpToNextStep(8000);
                        break;
                    case 31:
                        me->Say(MEK_13_3, LANG_UNIVERSAL);
                        for (int32 n = 0; n < 3; ++n)
                            BattleSuit[n]->DisappearAndDie();
                        me->SummonCreature(NPC_BRAG_BOT, BragBotSpawn[0], TEMPSUMMON_MANUAL_DESPAWN);
                        if (Debug_Mode) JumpToNextStep(1000);
                        else JumpToNextStep(5000);
                        break;
                    case 32:
                        if (Creature *pBragBot = me->FindNearestCreature(NPC_BRAG_BOT, 20, true))
                            DoTalk(pBragBot, THERM_1_1, SOUND_THERM_1, true);
                        if (Debug_Mode) JumpToNextStep(1000);
                        else JumpToNextStep(7000);
                        break;
                    case 33:
                        if (Creature *pBragBot = me->FindNearestCreature(NPC_BRAG_BOT, 20, true))
                            pBragBot->Yell(THERM_1_2, LANG_UNIVERSAL);
                        if (Debug_Mode) JumpToNextStep(1000);
                        else JumpToNextStep(5000);
                        break;
                    case 34:
                        if (Creature *pBragBot = me->FindNearestCreature(NPC_BRAG_BOT, 20, true))
                            pBragBot->Yell(THERM_1_3, LANG_UNIVERSAL);
                        JumpToNextStep(3000);
                        break;
                    case 35:
                        if (Creature *pBragBot = me->FindNearestCreature(NPC_BRAG_BOT, 20, true))
                            pBragBot->Yell(THERM_1_4, LANG_UNIVERSAL);
                        JumpToNextStep(4500);
                        break;
                    case 36:
                        PartyCast(SPELL_EXPLOSION);
                        if (Creature *pBragBot = me->FindNearestCreature(NPC_BRAG_BOT, 20, true))
                            pBragBot->DisappearAndDie();
                        JumpToNextStep(1000);
                        break;
                    case 37:
                        if (uiTroggs <= 20)
                        {
                            if (me->SummonCreature(NPC_I_TROGG, TroggSpawn, TEMPSUMMON_MANUAL_DESPAWN))
                                ++uiTroggs;

                            switch (uiTroggs)
                            {
                                case 2:
                                    DoTalk(me, MEK_14_1, SOUND_MEK_14, false);
                                    break;
                                case 5:
                                    me->Yell(MEK_14_2, LANG_UNIVERSAL);
                                    break;
                            }
                            uiStep_timer = uiTroggs % 4 == 0 ? (Debug_Mode ? 1000 : 30000) : 1500;
                        }
                        else
                        {
                            if (me->SummonCreature(NPC_GASHERIKK, TroggSpawn, TEMPSUMMON_MANUAL_DESPAWN))
                            {
                                DoTalk(me, MEK_15_1, SOUND_MEK_15, true);
                                ++uiStep;
                            }
                        }
                        break;
                    case 39:
                        SetHoldState(false);
                        break;
                    case 41:
                        PartyCast(SPELL_PARACHUTE);
                        SetHoldState(false);
                        break;
                    case 43:
                        SetHoldState(false);
                        break;
                    case 45:
                        if (Creature *pSuit = me->SummonCreature(NPC_BATTLE_SUIT, BattleSuitSpawn[3], TEMPSUMMON_MANUAL_DESPAWN))
                            CAST_AI(npc_og_suit::npc_og_suitAI, pSuit->AI())->SetupMovement(3);
                        if (Creature *pSuit = me->SummonCreature(NPC_BATTLE_SUIT, BattleSuitSpawn[4], TEMPSUMMON_MANUAL_DESPAWN))
                            CAST_AI(npc_og_suit::npc_og_suitAI, pSuit->AI())->SetupMovement(4);
                        for (int8 n = 15; n < 19; ++n)
                            if (Creature *pInfantry = me->SummonCreature(NPC_INFANTRY, InfantrySpawn[n], TEMPSUMMON_MANUAL_DESPAWN))
                                CAST_AI(npc_og_infantry::npc_og_infantryAI, pInfantry->AI())->SetupMovement(n);
                        JumpToNextStep(1500);
                        break;
                    case 46:
                        SetHoldState(false);
                        break;
                    case 48:
                        DoTalk(me, MEK_17_1, SOUND_MEK_17, false);
                        for (int8 n = 11; n < 15; ++n)
                            me->SummonCreature(NPC_INFANTRY, InfantrySpawn[n], TEMPSUMMON_MANUAL_DESPAWN);
                        for (int8 n = 0; n < 5; ++n)
                            if (Creature *pSoldier = me->SummonCreature(urand(0, 1) ? NPC_I_INFANTRY : NPC_I_CAVALRY, iSoldierSpawn[n], TEMPSUMMON_MANUAL_DESPAWN))
                                pSoldier->GetMotionMaster()->MovePoint(0, -4955.23 f, 728.98 f, 259.31 f);
                        JumpToNextStep(5000);
                        break;
                    case 49:
                        me->SetReactState(REACT_PASSIVE);
                        if (Creature *pCogspin = me->FindNearestCreature(NPC_COGSPIN, 100.0 f))
                            pCogspin->SetReactState(REACT_PASSIVE);
                        if (Creature *pFastblast = me->FindNearestCreature(NPC_FASTBLAST, 100.0 f))
                            pFastblast->SetReactState(REACT_PASSIVE);
                        SetHoldState(false);
                        break;
                    case 51:
                        SetHoldState(false);
                        JumpToNextStep(5000);
                        break;
                    case 53:
                        if (uiSoldiers <= 30)
                        {
                            if (Creature *pSoldier = me->SummonCreature(urand(0, 1) ? NPC_I_INFANTRY : NPC_I_CAVALRY, iSoldierSpawn[urand(0, 5)], TEMPSUMMON_MANUAL_DESPAWN))
                            {
                                pSoldier->GetMotionMaster()->MovePoint(0, -4955.23 f, 728.98 f, 259.31 f);
                                ++uiSoldiers;
                            }
                            uiStep_timer = 4000;
                        }
                        else
                        {
                            me->SummonCreature(NPC_BOLTCOG, -5035.236816 f, 708.675232 f, 260.499268 f, 0, TEMPSUMMON_MANUAL_DESPAWN);
                            if (Debug_Mode) JumpToNextStep(1000);
                            else JumpToNextStep(10000);
                        }
                        break;
                    case 54:
                        if (Creature *pBoltcog = me->FindNearestCreature(NPC_BOLTCOG, 1000, true))
                            DoTalk(pBoltcog, BOLTCOG_1, SOUND_BOLTCOG_1, true);
                        ++uiStep;
                        break;
                    case 56:
                        SetHoldState(false);
                        break;
                    case 58:
                        if (Creature *pBragBot = me->FindNearestCreature(NPC_BRAG_BOT, 20, true))
                            DoTalk(pBragBot, THERM_2_1, SOUND_THERM_2, true);
                        if (Debug_Mode) JumpToNextStep(1000);
                        else JumpToNextStep(6000);
                        break;
                    case 59:
                        if (Creature *pBragBot = me->FindNearestCreature(NPC_BRAG_BOT, 20, true))
                            pBragBot->Yell(THERM_2_2, LANG_UNIVERSAL);
                        JumpToNextStep(3000);
                        break;
                    case 60:
                        if (Creature *pBragBot = me->FindNearestCreature(NPC_BRAG_BOT, 20, true))
                            pBragBot->Yell(THERM_2_3, LANG_UNIVERSAL);
                        if (Debug_Mode) JumpToNextStep(1000);
                        else JumpToNextStep(5000);
                        break;
                    case 61:
                        DoTalk(me, MEK_18_1, SOUND_MEK_18, false);
                        JumpToNextStep(5000);
                        break;
                    case 62:
                        if (Creature *pBragBot = me->FindNearestCreature(NPC_BRAG_BOT, 20, true))
                            DoTalk(pBragBot, THERM_3_1, SOUND_THERM_3, true);
                        if (Debug_Mode) JumpToNextStep(1000);
                        else JumpToNextStep(5000);
                        break;
                    case 63:
                        if (Creature *pBragBot = me->FindNearestCreature(NPC_BRAG_BOT, 20, true))
                            pBragBot->Yell(THERM_3_2, LANG_UNIVERSAL);
                        if (Debug_Mode) JumpToNextStep(1000);
                        else JumpToNextStep(7000);
                        break;
                    case 64:
                        if (Creature *pBragBot = me->FindNearestCreature(NPC_BRAG_BOT, 20, true))
                            pBragBot->Yell(THERM_3_3, LANG_UNIVERSAL);
                        if (Debug_Mode) JumpToNextStep(1000);
                        else JumpToNextStep(2000);
                        break;
                    case 65:
                        if (Creature *pBragBot = me->FindNearestCreature(NPC_BRAG_BOT, 20, true))
                            pBragBot->Yell(THERM_3_4, LANG_UNIVERSAL);
                        if (Debug_Mode) JumpToNextStep(1000);
                        else JumpToNextStep(8000);
                        break;
                    case 66:
                        if (GameObject *pGO = me->FindNearestGameObject(GO_IRRADIATOR, 20))
                        {
                            pGO->SetGoState(GO_STATE_ACTIVE);
                            if (Creature *pIrraiator = me->SummonCreature(NPC_IRRADIATOR, pGO->GetPositionX(), pGO->GetPositionY(), pGO->GetPositionZ(), 0, TEMPSUMMON_MANUAL_DESPAWN))
                                DoTalk(pIrraiator, IRRADIATOR_1_1, SOUND_IRRADIATOR_1, true);
                        }
                        if (Debug_Mode) JumpToNextStep(1000);
                        else JumpToNextStep(8000);
                        break;
                    case 67:
                        DoTalk(me, MEK_19_1, SOUND_MEK_19, false);
                        if (Debug_Mode) JumpToNextStep(1000);
                        else JumpToNextStep(5000);
                        break;
                    case 68:
                        me->Say(MEK_19_2, LANG_UNIVERSAL);
                        me->Dismount();
                        me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID, 25140);
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_WORK_SHEATHED);
                        if (Debug_Mode) JumpToNextStep(1000);
                        else JumpToNextStep(10000);
                        break;
                    case 69:
                        if (Creature *pBragBot = me->FindNearestCreature(NPC_BRAG_BOT, 20, true))
                            DoTalk(pBragBot, THERM_4_1, SOUND_THERM_4, true);
                        if (Debug_Mode) JumpToNextStep(1000);
                        else JumpToNextStep(10000);
                        break;
                    case 70:
                        if (Creature *pIrraiator = me->FindNearestCreature(NPC_IRRADIATOR, 20, true))
                            DoTalk(pIrraiator, IRRADIATOR_2_1, SOUND_IRRADIATOR_2, true);
                        if (Creature *pBragBot = me->FindNearestCreature(NPC_BRAG_BOT, 20, true))
                            pBragBot->DisappearAndDie();
                        if (Debug_Mode) JumpToNextStep(1000);
                        else JumpToNextStep(8000);
                        break;
                    case 71:
                        if (Creature *pIrraiator = me->FindNearestCreature(NPC_IRRADIATOR, 20, true))
                            pIrraiator->DisappearAndDie();
                        me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID, 53056);
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
                        DoTalk(me, MEK_20_1, SOUND_MEK_20, false);
                        if (Debug_Mode) JumpToNextStep(1000);
                        else JumpToNextStep(5000);
                        break;
                    case 72:
                        if (Player *pPlayer = GetPlayerForEscort())
                        {
                            if (Group *pGroup = pPlayer->GetGroup())
                            {
                                for (GroupReference *itr = pGroup->GetFirstMember(); itr != NULL; itr = itr->next())
                                {
                                    if (Player *pMember = itr->GetSource())
                                    {
                                        Creature *pCameraVeh = me->SummonCreature(NPC_CAMERA_VEHICLE, -5164.767578 f, 556.341125 f, 423.753784 f, 25.29 f, TEMPSUMMON_MANUAL_DESPAWN);
                                        pMember->CastSpell(pMember, SPELL_SEE_INVISIBILITY, true);
                                        pMember->CastSpell(pCameraVeh, SPELL_BINDSIGHT, true);
                                    }
                                }
                            }
                            else
                            {
                                pPlayer->GetMap()->LoadGrid(ExplosionBunnySpawn.GetPositionX(), ExplosionBunnySpawn.GetPositionY());
                                Creature *pCameraVeh = me->SummonCreature(NPC_CAMERA_VEHICLE, -5164.767578 f, 556.341125 f, 423.753784 f, 25.29 f, TEMPSUMMON_MANUAL_DESPAWN);
                                pPlayer->CastSpell(pPlayer, SPELL_SEE_INVISIBILITY, true);
                                pPlayer->CastSpell(pCameraVeh, SPELL_BINDSIGHT, true);
                            }
                        }
                        JumpToNextStep(1300);
                        break;
                    case 73:
                        ExplosionBunny = me->SummonCreature(NPC_EXPLOSION_BUNNY, ExplosionBunnySpawn, TEMPSUMMON_MANUAL_DESPAWN);
                        ExplosionBunny->setActive(true);
                        ExplosionBunny->CastSpell(ExplosionBunny, SPELL_SPAWN_INVISIBILITY, true);
                        JumpToNextStep(1500);
                        break;
                    case 74:
                        ExplosionBunny->CastSpell(ExplosionBunny, SPELL_RAD_EXPLOSION, true);
                        JumpToNextStep(7000);
                        break;
                    case 75:
                        ExplosionBunny->DespawnOrUnsummon();
                        bBuffs = false;
                        me->RemoveAurasDueToSpell(SPELL_HEALTH_REGEN);
                        me->RemoveAurasDueToSpell(SPELL_BRILLIANT_TACTICS);
                        me->NearTeleportTo(-4827.0 f, -1256.0 f, 506.077 f, 4.535 f);
                        me->SetDisplayId(11686);
                        me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID, 0);
                        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                        DoPlayMusic(2);
                        DoCleanup();
                        if (Debug_Mode) JumpToNextStep(1000);
                        else JumpToNextStep(10000);
                        break;
                    case 76:
                        DoTalk(me, MEK_21_1, SOUND_MEK_21, false);
                        if (Debug_Mode) JumpToNextStep(1000);
                        else JumpToNextStep(10000);
                        break;
                    case 77:
                        me->Say(MEK_21_2, LANG_UNIVERSAL);
                        if (Debug_Mode) JumpToNextStep(1000);
                        else JumpToNextStep(10000);
                        break;
                    case 78:
                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                        me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID, 53056);
                        me->DisappearAndDie();
                        break;
                }
            }
            else
                uiStep_timer -= diff;

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }

        void HandleDecorByPhase(Creature */*me*/, int8 /*p*/)
        {
           	// Placeholder until we have valid sniffs and proper GoB/NPC IDs
            /*
            switch (p)
            {
            case 1:	// INTRO
                if (decor_p1 == true) break;
               	// 8 Gnomeregan banners
                for (int8 n = 0; n < 8; ++n)
                    me->SummonGameObject(GO_BANNER, decor_gnomeregan_banners[n].m_positionX, decor_gnomeregan_banners[n].m_positionY, decor_gnomeregan_banners[n].m_positionZ, decor_gnomeregan_banners[n].m_orientation, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0);

                decor_p1 = true;
                break;

            case 2:	// AIRFIELD
                if (decor_p2 == true) break;
               	// 5 Gnomeregan banners
                for (int8 n = 8; n < (n + 5); ++n)
                    me->SummonGameObject(GO_BANNER, decor_gnomeregan_banners[n].m_positionX, decor_gnomeregan_banners[n].m_positionY, decor_gnomeregan_banners[n].m_positionZ, decor_gnomeregan_banners[n].m_orientation, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0);

                decor_p2 = true;
                break;

            case 3:	// SMALL HOUSE (RADIATION VALVE)
                if (decor_p3 == true) break;
               	// 5 Gnomeregan banners
                for (int8 n = 13; n < (n + 5); ++n)
                    me->SummonGameObject(GO_BANNER, decor_gnomeregan_banners[n].m_positionX, decor_gnomeregan_banners[n].m_positionY, decor_gnomeregan_banners[n].m_positionZ, decor_gnomeregan_banners[n].m_orientation, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0);

                decor_p3 = true;
                break;

            case 4:	// OUTSIDE CAVE OF GNOMEREGAN
                if (decor_p4 == true) break;
               	// 5 Gnomeregan banners
                for (int8 n = 18; n < (n + 5); ++n)
                    me->SummonGameObject(GO_BANNER, decor_gnomeregan_banners[n].m_positionX, decor_gnomeregan_banners[n].m_positionY, decor_gnomeregan_banners[n].m_positionZ, decor_gnomeregan_banners[n].m_orientation, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0);

                decor_p4 = true;
                break;

            case 5:	// INSIDE GNOMEREGAN
                if (decor_p5 == true) break;
               	// 9 Gnomeregan banners
                for (int8 n = 23; n < (n + 9); ++n)
                    me->SummonGameObject(GO_BANNER, decor_gnomeregan_banners[n].m_positionX, decor_gnomeregan_banners[n].m_positionY, decor_gnomeregan_banners[n].m_positionZ, decor_gnomeregan_banners[n].m_orientation, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0);

                decor_p5 = true;
                break;

            case 6:	// BOMB PLATFORM INSIDE GNOMEREGAN
                if (decor_p6 == true) break;

                decor_p6 = true;
                break;
            }
            */
        };

        void JustDied(Unit */*who*/) override
        {
            DoCleanup();
        }

        void JustSummoned(Creature *summon) override
        {
            SummonsGUID.push_back(summon->GetGUID());
        }

        void JumpToNextStep(uint32 uiTimer)
        {
            uiStep_timer = uiTimer;
            ++uiStep;
        }

        void SetHoldState(bool b_OnHold)
        {
            SetEscortPaused(b_OnHold);
            if (!b_OnHold)
            {
                if (Creature *pCogspin = me->FindNearestCreature(NPC_COGSPIN, 100.0 f))
                    CAST_AI(npc_og_assistants::npc_og_assistantsAI, pCogspin->AI())->SetHoldState(b_OnHold);
                if (Creature *pFastblast = me->FindNearestCreature(NPC_FASTBLAST, 100.0 f))
                    CAST_AI(npc_og_assistants::npc_og_assistantsAI, pFastblast->AI())->SetHoldState(b_OnHold);
                ++uiStep;
            }
        }

        void EnterCombat(Unit *pWho) override
        {
            if (pWho && pWho->ToCreature())
                SquadAssist(pWho->ToCreature());
        }

        void PartyCast(uint32 spell)
        {
            if (Player *pPlayer = GetPlayerForEscort())
            {
                if (Group *pGroup = pPlayer->GetGroup())
                {
                    for (GroupReference *itr = pGroup->GetFirstMember(); itr != NULL; itr = itr->next())
                    {
                        if (Player *pMember = itr->GetSource())
                            pMember->CastSpell(pMember, spell, true);
                    }
                }
                else
                {
                    pPlayer->CastSpell(pPlayer, spell, true);
                }
            }
        }

        void SpecialKill(uint32 variation)
        {
            switch (variation)
            {
                case 0:
                    ++uiRLDestroyed;
                    DoUpdateWorldState(WORLDSTATE_RL_DESTROYED, uiRLDestroyed);
                    if (uiStep > 14)
                    {
                        switch (uiRLDestroyed)
                        {
                            case 1:
                                DoTalk(me, MEK_7_1, SOUND_MEK_7, false);
                                break;
                            case 2:
                                DoTalk(me, MEK_8_1, SOUND_MEK_8, false);
                                break;
                            case 3:
                                DoTalk(me, MEK_9_1, SOUND_MEK_9, false);
                                break;
                            case 4:
                                break;
                            default:
                                LOG_ERROR("server.loading", "More than 4 Rocket Launchers destroyed!");
                        }
                    }
                    break;
                case 1:
                    ++uiCannonsDestroyed;
                    DoUpdateWorldState(WORLDSTATE_CANNONS_DESTROYED, uiCannonsDestroyed);
                    if (uiCannonsDestroyed == 6)
                    {
                        bCanSummonBomber = false;
                        DoUpdateWorldState(WORLDSTATE_AIRFIELD_CAPTURED, 0);
                        DoUpdateWorldState(WORLDSTATE_CANNONS_DESTROYED_CTRL, 0);
                        DoUpdateWorldState(WORLDSTATE_AIRFIELD_AND_COMMAND_CENTER_CAPTURED, 1);
                    }
                    if (uiCannonsDestroyed > 6)
                        LOG_ERROR("server.loading", "More than 6 Tankbuster Cannons destroyed!");
                    break;
                case 2:
                    DoUpdateWorldState(WORLDSTATE_BATTLE_NEAR_ENTRANCE, 0);
                    DoUpdateWorldState(WORLDSTATE_AIRFIELD_AND_COMMAND_CENTER_CAPTURED, 0);
                    DoUpdateWorldState(WORLDSTATE_SURFACE_CAPTURED, 1);
                    JumpToNextStep(2000);
                    break;
                case 3:
                    DoUpdateWorldState(WORLDSTATE_BATLLE_IN_TUNNELS, 0);
                    DoUpdateWorldState(WORLDSTATE_TUNNELS_CAPTURED, 1);
                    JumpToNextStep(100);
                    break;
                default:
                    LOG_ERROR("server.loading", "Unexpected variation (%i) in npc_og_mekkatorqueAI::SpecialKill call!", variation);
            }
        }

        void DoTalk(Creature *pTalker, const char *text, uint32 sound, bool yell)
        {
            if (yell)
                pTalker->Yell(text, LANG_UNIVERSAL);
            else
                pTalker->Say(text, LANG_UNIVERSAL);

            if (sound)
                DoPlaySoundToSet(pTalker, sound);
        }

        void SquadAssist(Creature *pTarget)
        {
            if (!pTarget->IsAlive())
                return;

            if (Creature *pCogspin = me->FindNearestCreature(NPC_COGSPIN, 100))
                pCogspin->AI()->AttackStart(pTarget);

            if (Creature *pFastblast = me->FindNearestCreature(NPC_FASTBLAST, 100))
                pFastblast->AI()->AttackStart(pTarget);
        }

        void SquadSetRun(bool b_Run)
        {
            if (Creature *pCogspin = me->FindNearestCreature(NPC_COGSPIN, 100))
                CAST_AI(npc_og_assistants::npc_og_assistantsAI, pCogspin->AI())->SetRun(b_Run);
            if (Creature *pFastblast = me->FindNearestCreature(NPC_FASTBLAST, 100))
                CAST_AI(npc_og_assistants::npc_og_assistantsAI, pFastblast->AI())->SetRun(b_Run);

            SetRun(b_Run);
        }

        void DoPlayMusic(uint8 musicId)
        {
            switch (musicId)
            {
                case 0:
                    PartyCast(SPELL_MUSIC_START);
                    break;
                case 1:
                    PartyCast(SPELL_MUSIC);
                    break;
                case 2:
                    PartyCast(SPELL_MUSIC_END);
                    break;
                default:
                    LOG_ERROR("server.loading", "Unexpected musicId (%i) in npc_og_mekkatorqueAI::DoPlayMusic call!", musicId);
            }
        }

        void DoSummonBomber()
        {
            if (bCanSummonBomber)
            {
                Creature *pBomber = me->SummonCreature(NPC_BOMBER, BomberSpawn, TEMPSUMMON_CORPSE_DESPAWN);
                pBomber->setActive(true);
                pBomber->SetSpeed(MOVE_FLIGHT, 5.0, true);
                pBomber->GetMotionMaster()->MovePoint(1, -5034.42 f, 369.79 f, 438.06 f);
            }
        }

        void SpellHit(Unit */*pHitter*/, SpellInfo
            const */*pSpell*/) override {}

        void DoUpdateWorldState(uint32 worldstate, uint32 value)
        {
            Map::PlayerList
            const &PlList = me->GetMap()->GetPlayers();

            if (PlList.IsEmpty())
                return;

            for (Map::PlayerList::const_iterator i = PlList.begin(); i != PlList.end(); ++i)
            {
                if (Player *pPlayer = i->GetSource())
                {
                    if (pPlayer->GetQuestStatus(QUEST_OPERATION_GNOMEREGAN) == QUEST_STATUS_INCOMPLETE)
                        pPlayer->SendUpdateWorldState(worldstate, value);
                }
            }
        }

        void DoRefreshWorldStates()
        {
            return;
            Map::PlayerList
            const &PlList = me->GetMap()->GetPlayers();

            if (PlList.IsEmpty())
                return;

            for (Map::PlayerList::const_iterator i = PlList.begin(); i != PlList.end(); ++i)
            {
                if (Player *pPlayer = i->GetSource())
                {
                    if (pPlayer->GetQuestStatus(QUEST_OPERATION_GNOMEREGAN) == QUEST_STATUS_NONE || pPlayer->GetQuestStatus(QUEST_OPERATION_GNOMEREGAN) == QUEST_STATUS_REWARDED || pPlayer->GetQuestStatus(QUEST_OPERATION_GNOMEREGAN) == QUEST_STATUS_FAILED)
                        for (int8 n = 0; n < 15; ++n)
                            pPlayer->SendUpdateWorldState(Worldstates[n], 0);
                }
            }
        }

        void UpdateBannerState(float radius)
        {
            me->GetGameObjectListWithEntryInGrid(BannerList_temp, GO_BANNER, radius);
            if (!BannerList_temp.empty())
            {
                for (std::list<GameObject*>::const_iterator itr = BannerList_temp.begin(); itr != BannerList_temp.end(); ++itr)
                {
                    if ((*itr)->GetRespawnTime() == 0)
                    {
                        (*itr)->SetRespawnTime(1 *DAY);
                        BannerList.push_back(*itr);
                    }
                }
                BannerList_temp.clear();
            }
            else
                LOG_ERROR("server.loading", "TSCR error: BannerList is empty!");
        }

        void DoCleanup()
        {
            if (!SummonsGUID.empty())
            {
                for (std::list<ObjectGuid>::const_iterator itr = SummonsGUID.begin(); itr != SummonsGUID.end(); ++itr)
                    if (Creature *summon = ObjectAccessor::GetCreature(*me, *itr))
                        summon->DisappearAndDie();
                SummonsGUID.clear();
            }
            if (!BannerList.empty())
            {
                for (std::list<GameObject*>::const_iterator itr = BannerList.begin(); itr != BannerList.end(); ++itr)
                    (*itr)->SetRespawnTime(0);
                BannerList.clear();
            }
            if (Creature *pCogspin = me->FindNearestCreature(NPC_COGSPIN, 100.0 f))
                pCogspin->DisappearAndDie();
            if (Creature *pFastblast = me->FindNearestCreature(NPC_FASTBLAST, 100.0 f))
                pFastblast->DisappearAndDie();
            DoRefreshWorldStates();
        }
    };

    typedef npc_og_mekkatorque::npc_og_mekkatorqueAI MekkAI;

    bool OnQuestAccept(Player *pPlayer, Creature *pCreature, Quest
        const */*pQuest*/) override
    {
        if (!bProcessing)
        {
            CAST_AI(MekkAI, pCreature->AI())->pEscortPlayer = pPlayer;
            pCreature->Say(MEK_1_1, LANG_UNIVERSAL);
            CAST_AI(MekkAI, pCreature->AI())->DoPlaySoundToSet(pCreature, SOUND_MEK_1);
            for (int8 n = 0; n < 4; ++n)
                CAST_AI(MekkAI, pCreature->AI())->RL[n] = pCreature->SummonCreature(NPC_RL, RLSpawn[n], TEMPSUMMON_MANUAL_DESPAWN);
            for (int8 n = 0; n < 3; ++n)
                CAST_AI(MekkAI, pCreature->AI())->Tank[n] = pCreature->SummonCreature(NPC_TANK, TankSpawn[n], TEMPSUMMON_MANUAL_DESPAWN);
            for (int8 n = 0; n < 8; ++n)
                pCreature->SummonCreature(NPC_I_INFANTRY, iInfantrySpawn[n], TEMPSUMMON_MANUAL_DESPAWN);
            pCreature->SummonCreature(NPC_I_TANK, iTankSpawn[0], TEMPSUMMON_MANUAL_DESPAWN);
            for (int8 n = 1; n < 3; ++n)
                if (Creature *p_iTank = pCreature->SummonCreature(NPC_I_TANK, iTankSpawn[n], TEMPSUMMON_MANUAL_DESPAWN))
                    CAST_AI(npc_og_i_tank::npc_og_i_tankAI, p_iTank->AI())->SetupMovement(n - 1);
            CAST_AI(MekkAI, pCreature->AI())->JumpToNextStep(4000);
            bProcessing = true;
        }
        return true;
    }

    bool OnGossipHello(Player *pPlayer, Creature *pCreature) override
    {
        if (!bProcessing)
        {
            CAST_AI(MekkAI, pCreature->AI())->pEscortPlayer = pPlayer;
            pCreature->Say(MEK_1_1, LANG_UNIVERSAL);
            CAST_AI(MekkAI, pCreature->AI())->DoPlaySoundToSet(pCreature, SOUND_MEK_1);
            for (int8 n = 0; n < 4; ++n)
                CAST_AI(MekkAI, pCreature->AI())->RL[n] = pCreature->SummonCreature(NPC_RL, RLSpawn[n], TEMPSUMMON_MANUAL_DESPAWN);
            for (int8 n = 0; n < 3; ++n)
                CAST_AI(MekkAI, pCreature->AI())->Tank[n] = pCreature->SummonCreature(NPC_TANK, TankSpawn[n], TEMPSUMMON_MANUAL_DESPAWN);
            for (int8 n = 0; n < 8; ++n)
                pCreature->SummonCreature(NPC_I_INFANTRY, iInfantrySpawn[n], TEMPSUMMON_MANUAL_DESPAWN);
            pCreature->SummonCreature(NPC_I_TANK, iTankSpawn[0], TEMPSUMMON_MANUAL_DESPAWN);
            for (int8 n = 1; n < 3; ++n)
                if (Creature *p_iTank = pCreature->SummonCreature(NPC_I_TANK, iTankSpawn[n], TEMPSUMMON_MANUAL_DESPAWN))
                    CAST_AI(npc_og_i_tank::npc_og_i_tankAI, p_iTank->AI())->SetupMovement(n - 1);
            CAST_AI(MekkAI, pCreature->AI())->JumpToNextStep(4000);
            bProcessing = true;
        }
        InitializeDecorations(pCreature);
        return true;
    }

    void InitializeDecorations(Creature */*me*/)
    {
        /*
       	// Player "spawn" platform - from where they land off the helicopter
       	// -- plr spawn platform
        me->SummonGameObject(GO_PLR_LANDING_PLATFORM, -5434.71f, 523.177f, 386.959f, 0.575957f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0);

       	// Random gnomish tabkes
        for (int8 n = 0; n < 6; ++n)
            me->SummonGameObject(GO_CRAP_TABLE, decor_gnomish_tables[n].m_positionX, decor_gnomish_tables[n].m_positionY, decor_gnomish_tables[n].m_positionZ, decor_gnomish_tables[n].m_orientation, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0);

       	// Spawn all teleport disks
        for (int8 n = 0; n < 6; ++n)
            me->SummonGameObject(GO_TELE_DISK, decor_beginning_teleport_platforms[n].m_positionX, decor_beginning_teleport_platforms[n].m_positionY, decor_beginning_teleport_platforms[n].m_positionZ, decor_beginning_teleport_platforms[n].m_orientation, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0);

       	// Spawn all hazard lights
        for (int8 n = 0; n < 20; ++n)
            me->SummonGameObject(GO_HAZ_LIGHT, decor_beginning_hazard_lights[n].m_positionX, decor_beginning_hazard_lights[n].m_positionY, decor_beginning_hazard_lights[n].m_positionZ, decor_beginning_hazard_lights[n].m_orientation, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0);
        */
    }

    private:
        bool bProcessing;

    CreatureAI* GetAI(Creature *pCreature) const override
    {
        return new npc_og_mekkatorqueAI(pCreature);
    }
};

class npc_og_boltcog: public CreatureScript
{
    public:
    npc_og_boltcog(): CreatureScript("npc_og_boltcog") {}

    struct npc_og_boltcogAI: public npc_escortAI
    {
        npc_og_boltcogAI(Creature *pCreature): npc_escortAI(pCreature) {}

        uint32 uiThrow_timer;

        void Reset() override
        {
            uiThrow_timer = urand(10000, 25000);
        }

        void WaypointReached(uint32 /*waypointId */) override {}

        void JustDied(Unit */*who*/) override
        {
            if (Creature *pMekkatorque = me->FindNearestCreature(NPC_MEKKATORQUE, 100.0 f, true))
                CAST_AI(npc_og_mekkatorque::npc_og_mekkatorqueAI, pMekkatorque->AI())->SpecialKill(3);
        }

        void IsSummonedBy(Unit */*who*/) override
        {
            AddWaypoint(0, -5035.236816 f, 708.675232 f, 260.499268 f);
            AddWaypoint(1, -5033.954590 f, 717.153992 f, 260.528778 f);
            AddWaypoint(2, -5048.367188 f, 718.769409 f, 260.534576 f);
            AddWaypoint(3, -5048.580078 f, 723.327087 f, 260.738220 f);
            AddWaypoint(4, -5048.201660 f, 725.357117 f, 261.238556 f);
            AddWaypoint(5, -5044.113281 f, 735.628906 f, 256.475586 f);
            AddWaypoint(6, -4974.464355 f, 730.595642 f, 256.258636 f);
            AddWaypoint(7, -4950.033203 f, 728.526733 f, 260.143768 f);
            AddWaypoint(8, -4952.264160 f, 728.697937 f, 259.785492 f);

            if (npc_og_boltcogAI *pEscortAI = CAST_AI(npc_og_boltcogAI, me->AI()))
            {
                pEscortAI->Start(true, true);
                pEscortAI->SetDespawnAtFar(false);
                pEscortAI->SetDespawnAtEnd(false);
            }
        }

        void UpdateAI(const uint32 diff) override
        {
            npc_escortAI::UpdateAI(diff);

            if (!UpdateVictim())
                return;

            if (uiThrow_timer <= diff)
            {
                DoCast(me->GetVictim(), SPELL_WRENCH_THROW);
                uiThrow_timer = urand(10000, 25000);
            }
            else
                uiThrow_timer -= diff;
        }
    };

    CreatureAI* GetAI(Creature *pCreature) const
    {
        return new npc_og_boltcogAI(pCreature);
    }
};

class npc_og_rl: public CreatureScript
{
    public:
    npc_og_rl(): CreatureScript("npc_og_rl") {}

    struct npc_og_rlAI: public ScriptedAI
    {
        npc_og_rlAI(Creature *pCreature): ScriptedAI(pCreature) {}

        void JustDied(Unit */*who*/) override
        {
            if (Creature *pMekkatorque = me->FindNearestCreature(NPC_MEKKATORQUE, 1000, true))
                CAST_AI(npc_og_mekkatorque::npc_og_mekkatorqueAI, pMekkatorque->AI())->SpecialKill(0);
        }
    };

    CreatureAI* GetAI(Creature *pCreature) const
    {
        return new npc_og_rlAI(pCreature);
    }
};

class npc_og_cannon: public CreatureScript
{
    public:
    npc_og_cannon(): CreatureScript("npc_og_cannon") {}

    struct npc_og_cannonAI: public ScriptedAI
    {
        npc_og_cannonAI(Creature *pCreature): ScriptedAI(pCreature) {}

        uint32 uiHits;
        uint32 uiRocket_timer;

        void Reset() override
        {
            if (uiHits < 5 && !me->HasAura(SPELL_CANNON_SHIELD))
                me->CastSpell(me, SPELL_CANNON_SHIELD, true);

            uiRocket_timer = urand(1000, 5000);
        }

        void SpellHit(Unit */*pHitter*/, const SpellInfo *pSpell) override
        {
            if (pSpell->Id == SPELL_ROCKET)
            {
                ++uiHits;
                if (uiHits == 1)	// @todo : should be 5
                {
                    if (Creature *pMekkatorque = me->FindNearestCreature(NPC_MEKKATORQUE, 1000, true))
                        if (!CAST_AI(npc_og_mekkatorque::npc_og_mekkatorqueAI, pMekkatorque->AI())->bCannonIntro)
                        {
                            CAST_AI(npc_og_mekkatorque::npc_og_mekkatorqueAI, pMekkatorque->AI())->DoTalk(pMekkatorque, MEK_11_1, SOUND_MEK_11, false);
                            CAST_AI(npc_og_mekkatorque::npc_og_mekkatorqueAI, pMekkatorque->AI())->bCannonIntro = true;
                        }
                    me->RemoveAurasDueToSpell(SPELL_CANNON_SHIELD);
                }
            }
            else if (pSpell->Id == SPELL_TRIGGER)
            {
                uiHits = 0;
                me->CastSpell(me, SPELL_CANNON_SHIELD, true);
            }
        }

        void UpdateAI(const uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            if (uiRocket_timer <= diff)
            {
                DoCast(me->GetVictim(), SPELL_CANNON_SHOT);
                uiRocket_timer = urand(1000, 5000);
            }
            else
                uiRocket_timer -= diff;
        }

        void JustDied(Unit */*who*/) override
        {
            if (Creature *pMekkatorque = me->FindNearestCreature(NPC_MEKKATORQUE, 1000, true))
                CAST_AI(npc_og_mekkatorque::npc_og_mekkatorqueAI, pMekkatorque->AI())->SpecialKill(1);
        }
    };

    CreatureAI* GetAI(Creature *pCreature) const
    {
        return new npc_og_cannonAI(pCreature);
    }
};

class npc_og_bomber: public CreatureScript
{
    public:
    npc_og_bomber(): CreatureScript("npc_og_bomber") {}

    struct npc_og_bomberlAI: public ScriptedAI
    {
        npc_og_bomberlAI(Creature *pCreature): ScriptedAI(pCreature) {}

        bool bAction;

        void Reset() override
        {
            bAction = true;
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type == POINT_MOTION_TYPE && id == 1)
                if (Creature *pMekkatorque = me->FindNearestCreature(NPC_MEKKATORQUE, 300, true))
                    CAST_AI(npc_og_mekkatorque::npc_og_mekkatorqueAI, pMekkatorque->AI())->DoSummonBomber();

            me->DisappearAndDie();
        }

        void MoveInLineOfSight(Unit *who) override
        {
            if (who->GetTypeId() != TYPEID_UNIT)
                return;

            if (who->GetEntry() != NPC_CANNON || !bAction || !who->HasAura(SPELL_CANNON_SHIELD))
                return;

            SpellInfo
            const *sEntry = sSpellMgr->GetSpellInfo(SPELL_ROCKET);
            me->CastSpell(who, sEntry, true);
            CAST_AI(npc_og_cannon::npc_og_cannonAI, who->ToCreature()->AI())->SpellHit(me, sEntry);
            bAction = false;
        }
    };

    CreatureAI* GetAI(Creature *pCreature) const
    {
        return new npc_og_bomberlAI(pCreature);
    }
};

class npc_og_trogg: public CreatureScript
{
    public:
    npc_og_trogg(): CreatureScript("npc_og_trogg") {}

    struct npc_og_troggAI: public npc_escortAI
    {
        npc_og_troggAI(Creature *pCreature): npc_escortAI(pCreature) {}

        void Reset() override {}

        void WaypointReached(uint32 /*waypointId */) override {}

        void IsSummonedBy(Unit */*who*/) override
        {
            AddWaypoint(0, -5181.290039 f, 629.843567 f, 398.547211 f);
            AddWaypoint(1, -5182.823730 f, 612.078735 f, 408.880646 f);
            AddWaypoint(2, -5183.547852 f, 600.796997 f, 409.014313 f);
            AddWaypoint(3, -5185.562500 f, 581.175110 f, 403.160065 f);

            if (npc_og_troggAI *pEscortAI = CAST_AI(npc_og_troggAI, me->AI()))
            {
                pEscortAI->Start(true, true);
                pEscortAI->SetDespawnAtEnd(false);
            }
        }

        void JustDied(Unit */*who*/) override
        {
            if (me->GetEntry() == NPC_GASHERIKK)
                if (Creature *pMekkatorque = me->FindNearestCreature(NPC_MEKKATORQUE, 100, true))
                    CAST_AI(npc_og_mekkatorque::npc_og_mekkatorqueAI, pMekkatorque->AI())->SpecialKill(2);
        }
    };

    CreatureAI* GetAI(Creature *pCreature) const
    {
        return new npc_og_troggAI(pCreature);
    }
};

class npc_og_i_infantry: public CreatureScript
{
    public:
    npc_og_i_infantry(): CreatureScript("npc_og_i_infantry") {}

    struct npc_og_i_infantryAI: public ScriptedAI
    {
        npc_og_i_infantryAI(Creature *pCreature): ScriptedAI(pCreature) {}

        uint32 uiGrenade_timer;
        uint32 uiGCD;

        void Reset() override
        {
            uiGrenade_timer = urand(10000, 15000);
            uiGCD = 3000;
        }

        void AttackStart(Unit *pWho) override
        {
            if (!pWho)
                return;

            if (me->Attack(pWho, true))
            {
                me->AddThreat(pWho, 10.0 f);
                me->SetInCombatWith(pWho);
                pWho->SetInCombatWith(me);
                if (!urand(0, 5))
                    DoStartMovement(pWho, 20.0 f);
                else
                    DoStartMovement(pWho, 5.0 f);
                SetCombatMovement(true);
            }
        }

        void UpdateAI(const uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            if (!me->IsWithinMeleeRange(me->GetVictim()))
            {
                if (uiGCD <= diff)
                {
                    DoCast(me->GetVictim(), SPELL_SHOOT);
                    uiGCD = 3000;
                }
                else
                    uiGCD -= diff;
            }

            if (uiGrenade_timer <= diff)
            {
                if (Unit *pTarget = SelectTarget(SelectTargetMethod::Random, 0))
                    DoCast(pTarget, SPELL_RAD_GRENADE);
                uiGrenade_timer = urand(10000, 15000);
            }
            else
                uiGrenade_timer -= diff;
        }
    };

    CreatureAI* GetAI(Creature *pCreature) const
    {
        return new npc_og_i_infantryAI(pCreature);
    }
};

class npc_og_camera_vehicle: public CreatureScript
{
    public:
    npc_og_camera_vehicle(): CreatureScript("npc_og_camera_vehicle") {}

    struct npc_og_camera_vehicleAI: public ScriptedAI
    {
        npc_og_camera_vehicleAI(Creature *pCreature): ScriptedAI(pCreature) {}

        void SpellHit(Unit */*who*/, const SpellInfo *pSpell) override
        {
            if (pSpell->Id == SPELL_BINDSIGHT)
            {
                me->SetSpeed(MOVE_FLIGHT, 0.5 f, true);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                me->GetMotionMaster()->MovePoint(0, -5169.104492 f, 575.167786 f, 416.563660 f);
            }
        }

        void MovementInform(uint32 type, uint32 /*id*/) override
        {
            if (type != POINT_MOTION_TYPE)
                return;

            if (me->HasAura(SPELL_BINDSIGHT))
            {
                if (Unit *caster = me->GetAura(SPELL_BINDSIGHT)->GetCaster())
                {
                    Player *player = caster->ToPlayer();
                    player->CastSpell(player, SPELL_RECALL_FINAL, true);
                    player->RemoveAurasDueToSpell(SPELL_SEE_INVISIBILITY);
                    player->RemoveAurasDueToSpell(SPELL_BINDSIGHT);
                    me->RemoveAurasDueToSpell(SPELL_BINDSIGHT);
                }
            }
            me->DespawnOrUnsummon();
        }
    };

    CreatureAI* GetAI(Creature *pCreature) const
    {
        return new npc_og_camera_vehicleAI(pCreature);
    }
};

// npc_gnome_citizen
enum
{
    QUEST_A_FEW_GOOD_GNOMES = 25229,
        SPELL_MOTIVATE = 74035,
        NPC_GNOME_CITIZEN = 39623,
        NPC_GNOME_CITIZEN_MOTIVATED = 39466,
        NPC_CAPTAIN_TREAD_SPARKNOZZLE = 39675,
        QUEST_CREDIT_CITIZEN = 39623,
        QUEST_CREDIT_MOTIVATED_CITIZEN = 39466,
        TALK_BROADCAST_ENTRY_MIN = 100004,
        TALK_BROADCAST_ENTRY_MAX = 100012,
        TALK_CHARMED = 0,
};

class npc_gnome_citizen: public CreatureScript
{
    public:
    npc_gnome_citizen(): CreatureScript("npc_gnome_citizen") {}

    struct npc_gnome_citizenAI: public FollowerAI
    {
        npc_gnome_citizenAI(Creature *creature): FollowerAI(creature) {}

        void Reset() {}

        void SpellHit(Unit *pWho, const SpellInfo *pSpell)
        {
            if (!pWho || !pWho->IsInWorld() || pWho->GetTypeId() != TYPEID_PLAYER || !pSpell)
                return;

            if (Player *plr = pWho->ToPlayer())
                if (pSpell->Id == SPELL_MOTIVATE && plr->GetQuestStatus(QUEST_A_FEW_GOOD_GNOMES) == QUEST_STATUS_INCOMPLETE)
                {
                    if (Creature *motivated_gnome = me->SummonCreature(NPC_GNOME_CITIZEN_MOTIVATED, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation(), TEMPSUMMON_TIMED_DESPAWN, 40 *MINUTE *IN_MILLISECONDS))
                    {
                        plr->KilledMonsterCredit(QUEST_CREDIT_CITIZEN, ObjectGuid::Empty);
                        CreatureAI *motivated_gnomeAI = motivated_gnome->AI();
                        if (!motivated_gnomeAI)
                            return;

                        motivated_gnomeAI->Talk(TALK_CHARMED);
                    }

                    me->DespawnOrUnsummon();
                }
        }
    };

    CreatureAI* GetAI(Creature *creature) const
    {
        return new npc_gnome_citizenAI(creature);
    }
};

class npc_gnome_citizen_motivated: public CreatureScript
{
    public:
    npc_gnome_citizen_motivated(): CreatureScript("npc_gnome_citizen_motivated") {}

    struct npc_gnome_citizen_motivatedAI: public FollowerAI
    {
        npc_gnome_citizen_motivatedAI(Creature *creature): FollowerAI(creature)
        {
            me->SetDisplayId(2590);
        }

        void Reset() {}

        void MoveInLineOfSight(Unit *pWho)
        {
            FollowerAI::MoveInLineOfSight(pWho);
            if (pWho->GetTypeId() != TYPEID_PLAYER)
                return;
            Player *plr = pWho->ToPlayer();

            if (plr->GetQuestStatus(QUEST_A_FEW_GOOD_GNOMES) != QUEST_STATUS_INCOMPLETE)
                return;

           	// if the motivated guy is not mounted, mount up
            if (plr->IsMounted() && (!me->IsMounted() || !me->HasAura(23225)))
                me->CastSpell(me, 23225);
            else if (me->HasAura(23225) && !plr->IsMounted())
                me->RemoveAura(23225);

            if (!HasFollowState(STATE_FOLLOW_INPROGRESS))
                StartFollow(plr);
        }

        void UpdateFollowerAI(const uint32 /*uiDiff*/)
        {
            if (me->FindNearestCreature(NPC_CAPTAIN_TREAD_SPARKNOZZLE, 2. f))
            {
                GetLeaderForFollower()->KilledMonsterCredit(QUEST_CREDIT_MOTIVATED_CITIZEN, ObjectGuid::Empty);
                SetFollowComplete(true);
                me->DisappearAndDie();
            }
        }
    };

    CreatureAI* GetAI(Creature *creature) const
    {
        return new npc_gnome_citizen_motivatedAI(creature);
    }
};

class npc_steamcrank: public CreatureScript
{
    public:
    npc_steamcrank(): CreatureScript("npc_steamcrank") {}

    struct npc_steamcrankAI: public ScriptedAI
    {
        npc_steamcrankAI(Creature *creature): ScriptedAI(creature)
        {
            _stepTimer = 0;
            _step = 0;
        }

        void Reset() override {}

        void JumpToNextStep(uint32 uiTimer)
        {
            _stepTimer = uiTimer;
            ++_step;
            if (_step > 26)
            {
                _step = 0;
                _stepTimer = 2000;
            }
        }

        void ReceiveEmote(Player *pPlayer, uint32 uiTextEmote) override
        {
            switch (uiTextEmote)
            {
                case TEXT_EMOTE_SALUTE:
                    if (_step >= 5 && _step < 8)
                        me->CastSpell(pPlayer, SPELL_SALUTE_CREDIT, true);
                    break;
                case TEXT_EMOTE_ROAR:
                    if (_step >= 11 && _step < 14)
                        me->CastSpell(pPlayer, SPELL_ROAR_CREDIT, true);
                    break;
                case TEXT_EMOTE_CHEER:
                    if (_step >= 17 && _step < 20)
                        me->CastSpell(pPlayer, SPELL_CHEER_CREDIT, true);
                    break;
                case TEXT_EMOTE_DANCE:
                    if (_step >= 23 && _step < 26)
                        me->CastSpell(pPlayer, SPELL_DANCE_CREDIT, true);
                    break;
            }
        }

        void ForceEmote(uint32 uiEmote)
        {
            std::list<Creature*> Trainees;
            GetCreatureListWithEntryInGrid(Trainees, me, NPC_TRAINEE, 15.0 f);
            if (!Trainees.empty())
            {
                for (std::list<Creature*>::iterator itr = Trainees.begin(); itr != Trainees.end(); ++itr)
                    (*itr)->SetUInt32Value(UNIT_NPC_EMOTESTATE, uiEmote);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (_stepTimer <= diff)
            {
                switch (_step)
                {
                    case 0:
                        me->Say(STEAM_0, LANG_UNIVERSAL);
                        JumpToNextStep(5000);
                        break;
                    case 1:
                        me->Say(STEAM_1, LANG_UNIVERSAL);
                        JumpToNextStep(5000);
                        break;
                    case 2:
                        me->Say(STEAM_2, LANG_UNIVERSAL);
                        JumpToNextStep(5000);
                        break;
                    case 3:
                        me->Say(STEAM_3, LANG_UNIVERSAL);
                        JumpToNextStep(5000);
                        break;
                    case 4:
                        me->Say(STEAM_4, LANG_UNIVERSAL);
                        JumpToNextStep(1000);
                        break;
                    case 5:
                        ForceEmote(EMOTE_ONESHOT_SALUTE);
                        JumpToNextStep(1500);
                        break;
                    case 6:
                        ForceEmote(EMOTE_ONESHOT_NONE);
                        JumpToNextStep(3000);
                        break;
                    case 7:
                        me->Say(STEAM_5, LANG_UNIVERSAL);
                        JumpToNextStep(5000);
                        break;
                    case 8:
                        me->Say(STEAM_6, LANG_UNIVERSAL);
                        JumpToNextStep(5000);
                        break;
                    case 9:
                        me->Say(STEAM_7, LANG_UNIVERSAL);
                        JumpToNextStep(5000);
                        break;
                    case 10:
                        me->Say(STEAM_8, LANG_UNIVERSAL);
                        JumpToNextStep(1000);
                        break;
                    case 11:
                        ForceEmote(EMOTE_ONESHOT_ROAR);
                        JumpToNextStep(2000);
                        break;
                    case 12:
                        ForceEmote(EMOTE_ONESHOT_NONE);
                        JumpToNextStep(3000);
                        break;
                    case 13:
                        me->Say(STEAM_9, LANG_UNIVERSAL);
                        JumpToNextStep(5000);
                        break;
                    case 14:
                        me->Say(STEAM_10, LANG_UNIVERSAL);
                        JumpToNextStep(5000);
                        break;
                    case 15:
                        me->Say(STEAM_11, LANG_UNIVERSAL);
                        JumpToNextStep(5000);
                        break;
                    case 16:
                        me->Say(STEAM_12, LANG_UNIVERSAL);
                        JumpToNextStep(1000);
                        break;
                    case 17:
                        ForceEmote(EMOTE_ONESHOT_CHEER);
                        JumpToNextStep(1500);
                        break;
                    case 18:
                        ForceEmote(EMOTE_ONESHOT_NONE);
                        JumpToNextStep(3000);
                        break;
                    case 19:
                        me->Say(STEAM_13, LANG_UNIVERSAL);
                        JumpToNextStep(5000);
                        break;
                    case 20:
                        me->Say(STEAM_14, LANG_UNIVERSAL);
                        JumpToNextStep(5000);
                        break;
                    case 21:
                        me->Say(STEAM_15, LANG_UNIVERSAL);
                        JumpToNextStep(5000);
                        break;
                    case 22:
                        me->Say(STEAM_16, LANG_UNIVERSAL);
                        JumpToNextStep(1000);
                        break;
                    case 23:
                        ForceEmote(EMOTE_ONESHOT_DANCE);
                        JumpToNextStep(2500);
                        break;
                    case 24:
                        ForceEmote(EMOTE_ONESHOT_NONE);
                        JumpToNextStep(3000);
                        break;
                    case 25:
                        me->Say(STEAM_17, LANG_UNIVERSAL);
                        JumpToNextStep(5000);
                        break;
                    case 26:
                        me->Say(STEAM_18, LANG_UNIVERSAL);
                        JumpToNextStep(5000);
                        break;
                }
            }
            else
                _stepTimer -= diff;
        }

        private:
            uint32 _step = 0;
        uint32 _stepTimer = 0;
    };

    CreatureAI* GetAI(Creature *creature) const
    {
        return new npc_steamcrankAI(creature);
    }
};

class npc_mekkatorque: public CreatureScript
{
    public:
    npc_mekkatorque(): CreatureScript("npc_mekkatorque") {}

    struct npc_mekkatorqueAI: public ScriptedAI
    {
        npc_mekkatorqueAI(Creature *creature): ScriptedAI(creature)
        {
            if (Creature *ozzie = me->FindNearestCreature(NPC_OZZIE, 35.0 f, true))
                _listener = ozzie;
            else if (Creature *milli = me->FindNearestCreature(NPC_MILLI, 35.0 f, true))
                _listener = milli;
            else if (Creature *tog = me->FindNearestCreature(NPC_TOG, 35.0 f, true))
                _listener = tog;
            else
            {
                me->DespawnOrUnsummon();
                return;
            }
            _variation = urand(1, 3);
            me->CastSpell(me, SPELL_CREATE_TELEPORTER, true);
        }

        void Reset() override {}

        void JumpToNextStep(uint32 uiTimer)
        {
            _stepTimer = uiTimer;
            ++_step;
        }

        void CastCredit()
        {
            Unit *owner = me->GetOwner();
            switch (_listener->GetEntry())
            {
                case NPC_OZZIE:
                    me->CastSpell(owner, SPELL_CREDIT_OZZIE, true);
                    break;
                case NPC_MILLI:
                    me->CastSpell(owner, SPELL_CREDIT_MILLI, true);
                    break;
                case NPC_TOG:
                    me->CastSpell(owner, SPELL_CREDIT_TOG, true);
                    break;
            }
            me->DespawnOrUnsummon();
        }

        void UpdateAI(const uint32 diff) override
        {
            if (_stepTimer <= diff)
            {
                switch (_variation)
                {
                    case 1:
                        switch (_step)
                        {
                            case 0:
                                me->AI()->Talk(MEK1_0_0);
                                CastCredit();
                                JumpToNextStep(5000);
                                break;
                            case 1:
                                me->AI()->Talk(MEK1_0_1);
                                JumpToNextStep(5000);
                                break;
                            case 2:
                                _listener->AI()->Talk(MEK1_REPLY);
                                JumpToNextStep(3000);
                                break;
                            case 3:
                                if (Creature *Pad = me->FindNearestCreature(NPC_SUMMONING_PAD, 1.0 f, true))
                                    Pad->DespawnOrUnsummon();
                                break;
                        }
                        break;
                    case 2:
                        switch (_step)
                        {
                            case 0:
                                me->AI()->Talk(MEK1_0_2);
                                CastCredit();
                                JumpToNextStep(5000);
                                break;
                            case 1:
                                me->AI()->Talk(MEK1_0_3);
                                JumpToNextStep(5000);
                                break;
                            case 2:
                                me->AI()->Talk(MEK1_0_4);
                                JumpToNextStep(5000);
                                break;
                            case 3:
                                _listener->AI()->Talk(MEK1_REPLY);
                                JumpToNextStep(3000);
                                break;
                            case 4:
                                if (Creature *Pad = me->FindNearestCreature(NPC_SUMMONING_PAD, 1.0 f, true))
                                    Pad->DespawnOrUnsummon();
                                break;
                        }
                        break;
                    case 3:
                        switch (_step)
                        {
                            case 0:
                                me->AI()->Talk(MEK1_0_5);
                                CastCredit();
                                JumpToNextStep(7000);
                                break;
                            case 1:
                                me->AI()->Talk(MEK1_0_6);
                                JumpToNextStep(3000);
                                break;
                            case 2:
                                me->AI()->Talk(MEK1_0_7);
                                JumpToNextStep(3000);
                                break;
                            case 3:
                                _listener->AI()->Talk(MEK1_REPLY);
                                JumpToNextStep(3000);
                                break;
                            case 4:
                                if (Creature *Pad = me->FindNearestCreature(NPC_SUMMONING_PAD, 1.0 f, true))
                                    Pad->DespawnOrUnsummon();
                                break;
                        }
                        break;
                }
            }
            else
                _stepTimer -= diff;
        }

        private:
            uint32 _step;
        uint32 _stepTimer;
        uint32 _variation;
        Creature * _listener;
    };

    CreatureAI* GetAI(Creature *creature) const
    {
        return new npc_mekkatorqueAI(creature);
    }
};

class npc_shoot_bunny: public CreatureScript
{
    public:
    npc_shoot_bunny(): CreatureScript("npc_shoot_bunny") {}

    struct npc_shoot_bunnyAI: public ScriptedAI
    {
        npc_shoot_bunnyAI(Creature *creature): ScriptedAI(creature) {}

        void Reset()
        {
            if (me->FindNearestCreature(39711, 3.0 f, true))
                if (TempSummon *summon = me->ToTempSummon())
                    if (Unit *vehSummoner = summon->GetSummonerUnit())
                        if (Vehicle *vehicle = vehSummoner->GetVehicleKit())
                            if (Unit *driver = vehicle->GetPassenger(0))
                                driver->CastSpell(driver, SPELL_SHOOT_CREDIT, true);
        }
    };

    CreatureAI* GetAI(Creature *creature) const
    {
        return new npc_shoot_bunnyAI(creature);
    }
};

class spell_q25289_evasive_manueuvers: public SpellScript
{
    PrepareSpellScript(spell_q25289_evasive_manueuvers);

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (Creature *target = GetHitCreature())
        ;	// target->CastSpell(GetCaster(), SPELL_BUNNY_CREDIT_EVASIVE_MANUEVERS, false);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q25289_evasive_manueuvers::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class spell_q25289_left_leg: public SpellScript
{
    PrepareSpellScript(spell_q25289_left_leg);

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (Creature *target = GetHitCreature())
        ;	// target->CastSpell(GetCaster(), SPELL_BUNNY_CREDIT_LEFT_LEG, false);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q25289_left_leg::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class spell_q25289_right_leg: public SpellScript
{
    PrepareSpellScript(spell_q25289_right_leg);

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (Creature *target = GetHitCreature())
        ;	// target->CastSpell(GetCaster(), SPELL_BUNNY_CREDIT_RIGHT_LEG, false);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q25289_right_leg::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

void AddSC_operation_gnomeregan()
{
    new npc_og_camera_vehicle;
    new npc_og_mekkatorque;
    new npc_og_assistants;
    new npc_og_i_infantry;
    new npc_og_infantry;
    new npc_og_boltcog;
    new npc_og_cannon;
    new npc_og_i_tank;
    new npc_og_bomber;
    new npc_og_trogg;
    new npc_og_tank;
    new npc_og_suit;
    new npc_og_rl;
    new npc_gnome_citizen;
    new npc_gnome_citizen_motivated;
    new npc_steamcrank;
    new npc_mekkatorque;
    new npc_shoot_bunny;

   	// those are the spellscripts, we need to add the proper credit id in them and then uncomment
   	//new spell_q25289_evasive_manueuvers;
   	//new spell_q25289_left_leg;
   	//new spell_q25289_right_leg;
}
