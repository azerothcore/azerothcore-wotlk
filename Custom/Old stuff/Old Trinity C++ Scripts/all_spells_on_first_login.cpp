/* ------------------------------------------------------------------ */
/* Script Made By Sinistah (Ac-Web) Or ToxicDev (EmuDevs & Lordcraft) */
/* ------------------------------------------------------------------ */
/*                 This is a lordcraft.net exclusive!                 */
/* ------------------------------------------------------------------ */
/*           You do not have permission to post this elsewhere.       */
/* ------------------------------------------------------------------ */

enum WeaponSkillSpells
{
	SPELL_BLOCK = 107,
	SPELL_BOWS = 264,
	SPELL_CROSSBOWS = 5011,
	SPELL_DAGGERS = 1180,
	SPELL_DUAL_WIELD = 674,
	SPELL_FIST_WEAPONS = 15590,
	SPELL_GUNS = 266,
	SPELL_MAIL = 8737,
	SPELL_PLATE = 750,
	SPELL_ONE_HANDED_AXES = 196,
	SPELL_ONE_HANDED_MACES = 198,
	SPELL_ONE_HANDED_SWORDS = 201,
	SPELL_TWO_HANDED_AXES = 197,
	SPELL_TWO_HANDED_MACES = 199,
	SPELL_TWO_HANDED_SWORDS = 202,
	SPELL_STAVES = 227,
	SPELL_THROW = 2764,
	SPELL_THROWN = 2567,
	SPELL_POLEARMS = 200,
	SPELL_RELIC = 52665,
	SPELL_RELIC_2 = 27764,
	SPELL_RELIC_3 = 27762,
	SPELL_RELIC_4 = 27763,
	SPELL_SHIELD = 9116,
	SPELL_SHOOT = 3018,
	SPELL_SHOOT_WANDS = 5019,
	SPELL_WANDS = 5009
};

class AllSpellsOnLogin : public PlayerScript
{
public:
	AllSpellsOnLogin() : PlayerScript("AllSpellsOnLogin") { }

	void OnLogin(Player * player, bool /*login*/)
	{
		// Checks to see if player is new or not.
		if (player->GetTotalPlayedTime() <= 2)
		{
			// Gets the player's class and calls the custom functions to teach them their spells, riding skils, weapon skills, and dual spec.
			switch (player->getClass())
			{
			case CLASS_DEATH_KNIGHT:
				DeathKnightSpells(player);
				break;

			case CLASS_DRUID:
				DruidSpells(player);
				break;

			case CLASS_HUNTER:
				HunterSpells(player);
				break;

			case CLASS_MAGE:
				MageSpells(player);
				break;

			case CLASS_PALADIN:
				PaladinSpells(player);
				break;

			case CLASS_PRIEST:
				PriestSpells(player);
				break;

			case CLASS_ROGUE:
				RogueSpells(player);
				break;

			case CLASS_SHAMAN:
				ShamanSpells(player);
				break;

			case CLASS_WARLOCK:
				WarlockSpells(player);
				break;

			case CLASS_WARRIOR:
				WarriorSpells(player);
				break;
			}
			RidingSpells(player);
			DualSpec(player);
			player->UpdateSkillsToMaxSkillsForLevel();
		}
	}

	void DualSpec(Player* player)
	{
		player->CastSpell(player, 63680, true, NULL, NULL, player->GetGUID());
		player->CastSpell(player, 63624, true, NULL, NULL, player->GetGUID());
	}

	void RidingSpells(Player* player)
	{
		player->LearnSpell(33388, false);
		player->LearnSpell(33391, false);
		player->LearnSpell(34090, false);
		player->LearnSpell(34091, false);
		player->LearnSpell(54197, false);
	}

	void DeathKnightSpells(Player* player)
	{
		player->LearnSpell(SPELL_DUAL_WIELD, true);
		player->LearnSpell(SPELL_ONE_HANDED_AXES, true);
		player->LearnSpell(SPELL_ONE_HANDED_MACES, true);
		player->LearnSpell(SPELL_ONE_HANDED_SWORDS, true);
		player->LearnSpell(SPELL_PLATE, true);
		player->LearnSpell(SPELL_POLEARMS, true);
		player->LearnSpell(SPELL_RELIC, true);
		player->LearnSpell(SPELL_TWO_HANDED_AXES, true);
		player->LearnSpell(SPELL_TWO_HANDED_MACES, true);
		player->LearnSpell(SPELL_TWO_HANDED_SWORDS, true);
		player->LearnSpellHighestRank(48778);
		player->LearnSpellHighestRank(48266);
		player->LearnSpellHighestRank(50977);
		player->LearnSpellHighestRank(49576);
		player->LearnSpellHighestRank(49142);
		player->LearnSpellHighestRank(46584);
		player->LearnSpellHighestRank(48263);
		player->LearnSpellHighestRank(48528);
		player->LearnSpellHighestRank(45524);
		player->LearnSpellHighestRank(3714);
		player->LearnSpellHighestRank(48792);
		player->LearnSpellHighestRank(45529);
		player->LearnSpellHighestRank(56222);
		player->LearnSpellHighestRank(48743);
		player->LearnSpellHighestRank(56815);
		player->LearnSpellHighestRank(48707);
		player->LearnSpellHighestRank(48265);
		player->LearnSpellHighestRank(41999);
		player->LearnSpellHighestRank(47568);
		player->LearnSpellHighestRank(57623);
		player->LearnSpellHighestRank(49941);
		player->LearnSpellHighestRank(49909);
		player->LearnSpellHighestRank(42650);
		player->LearnSpellHighestRank(49930);
		player->LearnSpellHighestRank(49938);
		player->LearnSpellHighestRank(49895);
		player->LearnSpellHighestRank(49924);
		player->LearnSpellHighestRank(49921);
		//Neu BNN
		player->LearnSpellHighestRank(47476);
		player->LearnSpellHighestRank(50842);
		player->LearnSpellHighestRank(47528);
		player->LearnSpellHighestRank(57330);
		player->LearnSpellHighestRank(51425);
		player->LearnSpellHighestRank(61999);
		player->LearnSpellHighestRank(53428);
		player->LearnSpellHighestRank(53342);
		player->LearnSpellHighestRank(54447);
		player->LearnSpellHighestRank(53331);
		player->LearnSpellHighestRank(53323);
		player->LearnSpellHighestRank(54446);
		player->LearnSpellHighestRank(53344);
		player->LearnSpellHighestRank(70164);
		player->LearnSpellHighestRank(62158);
	}

	void DruidSpells(Player* player)
	{
		player->LearnSpell(SPELL_DAGGERS, true);
		player->LearnSpell(SPELL_FIST_WEAPONS, true);
		player->LearnSpell(SPELL_ONE_HANDED_MACES, true);
		player->LearnSpell(SPELL_POLEARMS, true);
		player->LearnSpell(SPELL_RELIC_2, true);
		player->LearnSpell(SPELL_STAVES, true);
		player->LearnSpell(SPELL_TWO_HANDED_MACES, true);
		player->LearnSpellHighestRank(5487);
		player->LearnSpellHighestRank(6795);
		player->LearnSpellHighestRank(18960);
		player->LearnSpellHighestRank(5229);
		player->LearnSpellHighestRank(8946);
		player->LearnSpellHighestRank(1066);
		player->LearnSpellHighestRank(768);
		player->LearnSpellHighestRank(2782);
		player->LearnSpellHighestRank(2893);
		player->LearnSpellHighestRank(5209);
		player->LearnSpellHighestRank(783);
		player->LearnSpellHighestRank(5225);
		player->LearnSpellHighestRank(22842);
		player->LearnSpellHighestRank(9634);
		player->LearnSpellHighestRank(20719);
		player->LearnSpellHighestRank(29166);
		player->LearnSpellHighestRank(22812);
		player->LearnSpellHighestRank(8983);
		player->LearnSpellHighestRank(18658);
		player->LearnSpellHighestRank(33357);
		player->LearnSpellHighestRank(33786);
		player->LearnSpellHighestRank(26995);
		player->LearnSpellHighestRank(40120);
		player->LearnSpellHighestRank(62078);
		player->LearnSpellHighestRank(49802);
		player->LearnSpellHighestRank(53307);
		player->LearnSpellHighestRank(52610);
		player->LearnSpellHighestRank(48575);
		player->LearnSpellHighestRank(48476);
		player->LearnSpellHighestRank(48560);
		player->LearnSpellHighestRank(49803);
		player->LearnSpellHighestRank(48443);
		player->LearnSpellHighestRank(48562);
		player->LearnSpellHighestRank(53308);
		player->LearnSpellHighestRank(48577);
		player->LearnSpellHighestRank(53312);
		player->LearnSpellHighestRank(48574);
		player->LearnSpellHighestRank(48465);
		player->LearnSpellHighestRank(48570);
		player->LearnSpellHighestRank(48378);
		player->LearnSpellHighestRank(48480);
		player->LearnSpellHighestRank(48579);
		player->LearnSpellHighestRank(48477);
		player->LearnSpellHighestRank(50213);
		player->LearnSpellHighestRank(48461);
		player->LearnSpellHighestRank(48470);
		player->LearnSpellHighestRank(48467);
		player->LearnSpellHighestRank(48568);
		player->LearnSpellHighestRank(48451);
		player->LearnSpellHighestRank(48469);
		player->LearnSpellHighestRank(48463);
		player->LearnSpellHighestRank(48441);
		player->LearnSpellHighestRank(50763);
		player->LearnSpellHighestRank(49800);
		player->LearnSpellHighestRank(48572);
		player->LearnSpellHighestRank(48447);
		//Neu BNN
		player->LearnSpellHighestRank(770);
		player->LearnSpellHighestRank(50464);
		player->LearnSpellHighestRank(16857);
		player->LearnSpellHighestRank(5215);
		player->LearnSpellHighestRank(62600);
		}

	void HunterSpells(Player* player)
	{
		player->LearnSpell(SPELL_BOWS, true);
		player->LearnSpell(SPELL_CROSSBOWS, true);
		player->LearnSpell(SPELL_DUAL_WIELD, true);
		player->LearnSpell(SPELL_FIST_WEAPONS, true);
		player->LearnSpell(SPELL_GUNS, true);
		player->LearnSpell(SPELL_MAIL, true);
		player->LearnSpell(SPELL_ONE_HANDED_AXES, true);
		player->LearnSpell(SPELL_ONE_HANDED_SWORDS, true);
		player->LearnSpell(SPELL_POLEARMS, true);
		player->LearnSpell(SPELL_STAVES, true);
		player->LearnSpell(SPELL_TWO_HANDED_AXES, true);
		player->LearnSpell(SPELL_TWO_HANDED_SWORDS, true);
		player->LearnSpellHighestRank(75);
		player->LearnSpellHighestRank(1494);
		player->LearnSpellHighestRank(13163);
		player->LearnSpellHighestRank(5116);
		player->LearnSpellHighestRank(883);
		player->LearnSpellHighestRank(2641);
		player->LearnSpellHighestRank(6991);
		player->LearnSpellHighestRank(982);
		player->LearnSpellHighestRank(1515);
		player->LearnSpellHighestRank(19883);
		player->LearnSpellHighestRank(20736);
		player->LearnSpellHighestRank(2974);
		player->LearnSpellHighestRank(6197);
		player->LearnSpellHighestRank(1002);
		player->LearnSpellHighestRank(19884);
		player->LearnSpellHighestRank(5118);
		player->LearnSpellHighestRank(34074);
		player->LearnSpellHighestRank(781);
		player->LearnSpellHighestRank(3043);
		player->LearnSpellHighestRank(1462);
		player->LearnSpellHighestRank(19885);
		player->LearnSpellHighestRank(3045);
		player->LearnSpellHighestRank(19880);
		player->LearnSpellHighestRank(13809);
		player->LearnSpellHighestRank(13161);
		player->LearnSpellHighestRank(5384);
		player->LearnSpellHighestRank(1543);
		player->LearnSpellHighestRank(19878);
		player->LearnSpellHighestRank(3034);
		player->LearnSpellHighestRank(13159);
		player->LearnSpellHighestRank(19882);
		player->LearnSpellHighestRank(14327);
		player->LearnSpellHighestRank(19879);
		player->LearnSpellHighestRank(19263);
		player->LearnSpellHighestRank(14311);
		player->LearnSpellHighestRank(19801);
		player->LearnSpellHighestRank(34026);
		player->LearnSpellHighestRank(27044);
		player->LearnSpellHighestRank(34600);
		player->LearnSpellHighestRank(34477);
		player->LearnSpellHighestRank(53271);
		player->LearnSpellHighestRank(49071);
		player->LearnSpellHighestRank(53338);
		player->LearnSpellHighestRank(49067);
		player->LearnSpellHighestRank(48996);
		player->LearnSpellHighestRank(49052);
		player->LearnSpellHighestRank(49056);
		player->LearnSpellHighestRank(49045);
		player->LearnSpellHighestRank(49001);
		player->LearnSpellHighestRank(61847);
		player->LearnSpellHighestRank(60192);
		player->LearnSpellHighestRank(61006);
		player->LearnSpellHighestRank(48990);
		player->LearnSpellHighestRank(53339);
		player->LearnSpellHighestRank(49048);
		player->LearnSpellHighestRank(58434);
		//Neu BNN
		player->LearnSpellHighestRank(62757);
		player->LearnSpellHighestRank(3127);
	}

	void MageSpells(Player* player)
	{
		player->LearnSpellHighestRank(130);
		player->LearnSpellHighestRank(475);
		player->LearnSpellHighestRank(1953);
		player->LearnSpellHighestRank(12051);
		player->LearnSpellHighestRank(7301);
		player->LearnSpellHighestRank(2139);
		player->LearnSpellHighestRank(45438);
		player->LearnSpellHighestRank(12826);
		player->LearnSpellHighestRank(66);
		player->LearnSpellHighestRank(30449);
		player->LearnSpellHighestRank(53140);
		player->LearnSpellHighestRank(42917);
		player->LearnSpellHighestRank(43015);
		player->LearnSpellHighestRank(43017);
		player->LearnSpellHighestRank(42985);
		player->LearnSpellHighestRank(43010);
		player->LearnSpellHighestRank(42833);
		player->LearnSpellHighestRank(42914);
		player->LearnSpellHighestRank(42859);
		player->LearnSpellHighestRank(42846);
		player->LearnSpellHighestRank(43012);
		player->LearnSpellHighestRank(42842);
		player->LearnSpellHighestRank(43008);
		player->LearnSpellHighestRank(43024);
		player->LearnSpellHighestRank(43020);
		player->LearnSpellHighestRank(43046);
		player->LearnSpellHighestRank(42897);
		player->LearnSpellHighestRank(43002);
		player->LearnSpellHighestRank(42921);
		player->LearnSpellHighestRank(42940);
		player->LearnSpellHighestRank(42956);
		player->LearnSpellHighestRank(61316);
		player->LearnSpellHighestRank(61024);
		player->LearnSpellHighestRank(42973);
		player->LearnSpellHighestRank(47610);
		player->LearnSpellHighestRank(58659);
		// Neu BNN
		player->LearnSpellHighestRank(42995);
		player->LearnSpellHighestRank(55342);
		player->LearnSpellHighestRank(27090);
		player->LearnSpellHighestRank(33717);
		player->LearnSpellHighestRank(42931);
		player->LearnSpellHighestRank(42873);
		player->LearnSpellHighestRank(42926);
	}

	void PaladinSpells(Player* player)
	{
		if (player->GetTeam() == ALLIANCE)
		{
			// Ally Charger
			player->LearnSpellHighestRank(23214);
		}
		else
		{
			//Horde Charger
			player->LearnSpellHighestRank(34767);
		}
		player->LearnSpell(SPELL_BLOCK, true);
		player->LearnSpell(SPELL_ONE_HANDED_AXES, true);
		player->LearnSpell(SPELL_ONE_HANDED_MACES, true);
		player->LearnSpell(SPELL_ONE_HANDED_SWORDS, true);
		player->LearnSpell(SPELL_PLATE, true);
		player->LearnSpell(SPELL_POLEARMS, true);
		player->LearnSpell(SPELL_RELIC_3, true);
		player->LearnSpell(SPELL_SHIELD, true);
		player->LearnSpell(SPELL_TWO_HANDED_AXES, true);
		player->LearnSpell(SPELL_TWO_HANDED_MACES, true);
		player->LearnSpell(SPELL_TWO_HANDED_SWORDS, true);
		player->LearnSpellHighestRank(21084);
		player->LearnSpellHighestRank(20271);
		player->LearnSpellHighestRank(498);
		player->LearnSpellHighestRank(1152);
		player->LearnSpellHighestRank(53408);
		player->LearnSpellHighestRank(31789);
		player->LearnSpellHighestRank(62124);
		player->LearnSpellHighestRank(25780);
		player->LearnSpellHighestRank(1044);
		player->LearnSpellHighestRank(5502);
		player->LearnSpellHighestRank(19746);
		player->LearnSpellHighestRank(20164);
		player->LearnSpellHighestRank(10326);
		player->LearnSpellHighestRank(1038);
		player->LearnSpellHighestRank(53407);
		player->LearnSpellHighestRank(19752);
		player->LearnSpellHighestRank(20165);
		player->LearnSpellHighestRank(642);
		player->LearnSpellHighestRank(10278);
		player->LearnSpellHighestRank(20166);
		player->LearnSpellHighestRank(4987);
		player->LearnSpellHighestRank(6940);
		player->LearnSpellHighestRank(10308);
		player->LearnSpellHighestRank(25898);
		player->LearnSpellHighestRank(32223);
		player->LearnSpellHighestRank(33776);
		player->LearnSpellHighestRank(31884);
		player->LearnSpellHighestRank(54428);
		player->LearnSpellHighestRank(54043);
		player->LearnSpellHighestRank(48943);
		player->LearnSpellHighestRank(48936);
		player->LearnSpellHighestRank(48945);
		player->LearnSpellHighestRank(48938);
		player->LearnSpellHighestRank(48947);
		player->LearnSpellHighestRank(48817);
		player->LearnSpellHighestRank(48788);
		player->LearnSpellHighestRank(48932);
		player->LearnSpellHighestRank(48942);
		player->LearnSpellHighestRank(48801);
		player->LearnSpellHighestRank(48785);
		player->LearnSpellHighestRank(48934);
		player->LearnSpellHighestRank(48950);
		player->LearnSpellHighestRank(48819);
		player->LearnSpellHighestRank(48806);
		player->LearnSpellHighestRank(48782);
		player->LearnSpellHighestRank(53601);
		player->LearnSpellHighestRank(61411);
		//Neu BNN
		player->LearnSpellHighestRank(3127);
		player->LearnSpellHighestRank(20217);
	}

	void PriestSpells(Player* player)
	{
		player->LearnSpell(SPELL_DAGGERS, true);
		player->LearnSpell(SPELL_ONE_HANDED_MACES, true);
		player->LearnSpell(SPELL_SHOOT_WANDS, true);
		player->LearnSpell(SPELL_STAVES, true);
		player->LearnSpell(SPELL_WANDS, true);
		player->LearnSpellHighestRank(586);
		player->LearnSpellHighestRank(2053);
		player->LearnSpellHighestRank(528);
		player->LearnSpellHighestRank(6346);
		player->LearnSpellHighestRank(453);
		player->LearnSpellHighestRank(8129);
		player->LearnSpellHighestRank(605);
		player->LearnSpellHighestRank(552);
		player->LearnSpellHighestRank(6064);
		player->LearnSpellHighestRank(1706);
		player->LearnSpellHighestRank(988);
		player->LearnSpellHighestRank(10909);
		player->LearnSpellHighestRank(10890);
		player->LearnSpellHighestRank(60931);
		player->LearnSpellHighestRank(10955);
		player->LearnSpellHighestRank(34433);
		player->LearnSpellHighestRank(32375);
		player->LearnSpellHighestRank(48072);
		player->LearnSpellHighestRank(48169);
		player->LearnSpellHighestRank(48168);
		player->LearnSpellHighestRank(48170);
		player->LearnSpellHighestRank(48120);
		player->LearnSpellHighestRank(48063);
		player->LearnSpellHighestRank(48135);
		player->LearnSpellHighestRank(48171);
		player->LearnSpellHighestRank(48300);
		player->LearnSpellHighestRank(48071);
		player->LearnSpellHighestRank(48127);
		player->LearnSpellHighestRank(48113);
		player->LearnSpellHighestRank(48123);
		player->LearnSpellHighestRank(48173);
		player->LearnSpellHighestRank(47951);
		player->LearnSpellHighestRank(48073);
		player->LearnSpellHighestRank(48078);
		player->LearnSpellHighestRank(53023);
		player->LearnSpellHighestRank(48161);
		player->LearnSpellHighestRank(48066);
		player->LearnSpellHighestRank(48162);
		player->LearnSpellHighestRank(48074);
		player->LearnSpellHighestRank(48068);
		player->LearnSpellHighestRank(48158);
		player->LearnSpellHighestRank(48125);
		//Neu BNN
		player->LearnSpellHighestRank(64901);
		player->LearnSpellHighestRank(64843);
	}

	void RogueSpells(Player* player)
	{
		player->LearnSpell(SPELL_BOWS, true);
		player->LearnSpell(SPELL_CROSSBOWS, true);
		player->LearnSpell(SPELL_DUAL_WIELD, true);
		player->LearnSpell(SPELL_FIST_WEAPONS, true);
		player->LearnSpell(SPELL_GUNS, true);
		player->LearnSpell(SPELL_ONE_HANDED_AXES, true);
		player->LearnSpell(SPELL_ONE_HANDED_MACES, true);
		player->LearnSpell(SPELL_ONE_HANDED_SWORDS, true);
		player->LearnSpell(SPELL_SHOOT, true);
		player->LearnSpell(SPELL_THROW, true);
		player->LearnSpell(SPELL_THROWN, true);
		player->LearnSpellHighestRank(921);
		player->LearnSpellHighestRank(1776);
		player->LearnSpellHighestRank(1766);
		player->LearnSpellHighestRank(1804);
		player->LearnSpellHighestRank(51722);
		player->LearnSpellHighestRank(1725);
		player->LearnSpellHighestRank(2836);
		player->LearnSpellHighestRank(1833);
		player->LearnSpellHighestRank(1842);
		player->LearnSpellHighestRank(2094);
		player->LearnSpellHighestRank(1860);
		player->LearnSpellHighestRank(6774);
		player->LearnSpellHighestRank(26669);
		player->LearnSpellHighestRank(8643);
		player->LearnSpellHighestRank(11305);
		player->LearnSpellHighestRank(26889);
		player->LearnSpellHighestRank(31224);
		player->LearnSpellHighestRank(5938);
		player->LearnSpellHighestRank(51724);
		player->LearnSpellHighestRank(57934);
		player->LearnSpellHighestRank(48674);
		player->LearnSpellHighestRank(48659);
		player->LearnSpellHighestRank(48668);
		player->LearnSpellHighestRank(48672);
		player->LearnSpellHighestRank(48691);
		player->LearnSpellHighestRank(48657);
		player->LearnSpellHighestRank(57993);
		player->LearnSpellHighestRank(51723);
		player->LearnSpellHighestRank(48676);
		player->LearnSpellHighestRank(48638);
		//Neu BNN
		player->LearnSpellHighestRank(1784);
		player->LearnSpellHighestRank(3127);
		player->LearnSpellHighestRank(8647);
	}

	void ShamanSpells(Player* player)
	{
		if (player->GetTeam() == ALLIANCE)
		{
			// heroism
			player->LearnSpellHighestRank(32182);
		}
		else
		{
			// Bloodlust
			player->LearnSpellHighestRank(2825);
		}
		player->AddItem(46978, 1);
		player->LearnSpell(SPELL_BLOCK, true);
		player->LearnSpell(SPELL_FIST_WEAPONS, true);
		player->LearnSpell(SPELL_MAIL, true);
		player->LearnSpell(SPELL_ONE_HANDED_AXES, true);
		player->LearnSpell(SPELL_ONE_HANDED_MACES, true);
		player->LearnSpell(SPELL_RELIC_4, true);
		player->LearnSpell(SPELL_SHIELD, true);
		player->LearnSpell(SPELL_STAVES, true);
		player->LearnSpell(SPELL_TWO_HANDED_AXES, true);
		player->LearnSpell(SPELL_TWO_HANDED_MACES, true);
		player->LearnSpellHighestRank(30671);
		player->LearnSpellHighestRank(2484);
		player->LearnSpellHighestRank(526);
		player->LearnSpellHighestRank(57994);
		player->LearnSpellHighestRank(8143);
		player->LearnSpellHighestRank(2645);
		player->LearnSpellHighestRank(2870);
		player->LearnSpellHighestRank(8166);
		player->LearnSpellHighestRank(131);
		player->LearnSpellHighestRank(10399);
		player->LearnSpellHighestRank(6196);
		player->LearnSpellHighestRank(546);
		player->LearnSpellHighestRank(556);
		player->LearnSpellHighestRank(8177);
		player->LearnSpellHighestRank(20608);
		player->LearnSpellHighestRank(36936);
		player->LearnSpellHighestRank(8012);
		player->LearnSpellHighestRank(8512);
		player->LearnSpellHighestRank(6495);
		player->LearnSpellHighestRank(8170);
		player->LearnSpellHighestRank(3738);
		player->LearnSpellHighestRank(2062);
		player->LearnSpellHighestRank(2894);
		player->LearnSpellHighestRank(57960);
		player->LearnSpellHighestRank(49276);
		player->LearnSpellHighestRank(49236);
		player->LearnSpellHighestRank(58734);
		player->LearnSpellHighestRank(58582);
		player->LearnSpellHighestRank(58753);
		player->LearnSpellHighestRank(49231);
		player->LearnSpellHighestRank(49238);
		player->LearnSpellHighestRank(49277);
		player->LearnSpellHighestRank(55459);
		player->LearnSpellHighestRank(49271);
		player->LearnSpellHighestRank(51994);
		player->LearnSpellHighestRank(61657);
		player->LearnSpellHighestRank(58739);
		player->LearnSpellHighestRank(49233);
		player->LearnSpellHighestRank(58656);
		player->LearnSpellHighestRank(58790);
		player->LearnSpellHighestRank(58745);
		player->LearnSpellHighestRank(58796);
		player->LearnSpellHighestRank(58757);
		player->LearnSpellHighestRank(49273);
		player->LearnSpellHighestRank(51514);
		player->LearnSpellHighestRank(60043);
		player->LearnSpellHighestRank(49281);
		player->LearnSpellHighestRank(58774);
		player->LearnSpellHighestRank(58749);
		player->LearnSpellHighestRank(58704);
		player->LearnSpellHighestRank(58643);
		player->LearnSpellHighestRank(58804);
		//Neu BNN
		player->LearnSpellHighestRank(66842);
		player->LearnSpellHighestRank(66843);
		player->LearnSpellHighestRank(66844);
	}

	void WarlockSpells(Player* player)
	{
		player->LearnSpell(SPELL_DAGGERS, true);
		player->LearnSpell(SPELL_ONE_HANDED_SWORDS, true);
		player->LearnSpell(SPELL_SHOOT_WANDS, true);
		player->LearnSpell(SPELL_STAVES, true);
		player->LearnSpell(SPELL_WANDS, true);
		player->LearnSpellHighestRank(688);
		player->LearnSpellHighestRank(696);
		player->LearnSpellHighestRank(697);
		player->LearnSpellHighestRank(5697);
		player->LearnSpellHighestRank(698);
		player->LearnSpellHighestRank(712);
		player->LearnSpellHighestRank(126);
		player->LearnSpellHighestRank(5138);
		player->LearnSpellHighestRank(5500);
		player->LearnSpellHighestRank(132);
		player->LearnSpellHighestRank(691);
		player->LearnSpellHighestRank(18647);
		player->LearnSpellHighestRank(11719);
		player->LearnSpellHighestRank(1122);
		player->LearnSpellHighestRank(17928);
		player->LearnSpellHighestRank(6215);
		player->LearnSpellHighestRank(18540);
		player->LearnSpellHighestRank(23161);
		player->LearnSpellHighestRank(29858);
		player->LearnSpellHighestRank(50511);
		player->LearnSpellHighestRank(61191);
		player->LearnSpellHighestRank(47884);
		player->LearnSpellHighestRank(47856);
		player->LearnSpellHighestRank(47813);
		player->LearnSpellHighestRank(47855);
		player->LearnSpellHighestRank(47888);
		player->LearnSpellHighestRank(47865);
		player->LearnSpellHighestRank(47860);
		player->LearnSpellHighestRank(47857);
		player->LearnSpellHighestRank(47823);
		player->LearnSpellHighestRank(47891);
		player->LearnSpellHighestRank(47878);
		player->LearnSpellHighestRank(47864);
		player->LearnSpellHighestRank(57595);
		player->LearnSpellHighestRank(47893);
		player->LearnSpellHighestRank(47820);
		player->LearnSpellHighestRank(47815);
		player->LearnSpellHighestRank(47809);
		player->LearnSpellHighestRank(60220);
		player->LearnSpellHighestRank(47867);
		player->LearnSpellHighestRank(47889);
		player->LearnSpellHighestRank(48018);
		player->LearnSpellHighestRank(47811);
		player->LearnSpellHighestRank(47838);
		player->LearnSpellHighestRank(57946);
		player->LearnSpellHighestRank(58887);
		player->LearnSpellHighestRank(47836);
		player->LearnSpellHighestRank(61290);
		player->LearnSpellHighestRank(47825);
		//Neu BNN
		player->LearnSpellHighestRank(48020);
		player->LearnSpellHighestRank(5784);
	}

	void WarriorSpells(Player* player)
	{
		player->LearnSpell(SPELL_BLOCK, true);
		player->LearnSpell(SPELL_BOWS, true);
		player->LearnSpell(SPELL_CROSSBOWS, true);
		player->LearnSpell(SPELL_DUAL_WIELD, true);
		player->LearnSpell(SPELL_FIST_WEAPONS, true);
		player->LearnSpell(SPELL_GUNS, true);
		player->LearnSpell(SPELL_ONE_HANDED_AXES, true);
		player->LearnSpell(SPELL_ONE_HANDED_MACES, true);
		player->LearnSpell(SPELL_ONE_HANDED_SWORDS, true);
		player->LearnSpell(SPELL_PLATE, true);
		player->LearnSpell(SPELL_POLEARMS, true);
		player->LearnSpell(SPELL_SHIELD, true);
		player->LearnSpell(SPELL_SHOOT, true);
		player->LearnSpell(SPELL_STAVES, true);
		player->LearnSpell(SPELL_THROW, true);
		player->LearnSpell(SPELL_THROWN, true);
		player->LearnSpell(SPELL_TWO_HANDED_AXES, true);
		player->LearnSpell(SPELL_TWO_HANDED_MACES, true);
		player->LearnSpell(SPELL_TWO_HANDED_SWORDS, true);
		player->LearnSpellHighestRank(2457);
		player->LearnSpellHighestRank(1715);
		player->LearnSpellHighestRank(2687);
		player->LearnSpellHighestRank(71);
		player->LearnSpellHighestRank(355);
		player->LearnSpellHighestRank(7384);
		player->LearnSpellHighestRank(72);
		player->LearnSpellHighestRank(694);
		player->LearnSpellHighestRank(2565);
		player->LearnSpellHighestRank(676);
		player->LearnSpellHighestRank(20230);
		player->LearnSpellHighestRank(12678);
		player->LearnSpellHighestRank(5246);
		player->LearnSpellHighestRank(1161);
		player->LearnSpellHighestRank(871);
		player->LearnSpellHighestRank(2458);
		player->LearnSpellHighestRank(20252);
		player->LearnSpellHighestRank(18449);
		player->LearnSpellHighestRank(1680);
		player->LearnSpellHighestRank(6552);
		player->LearnSpellHighestRank(11578);
		player->LearnSpellHighestRank(1719);
		player->LearnSpellHighestRank(34428);
		player->LearnSpellHighestRank(23920);
		player->LearnSpellHighestRank(3411);
		player->LearnSpellHighestRank(55694);
		player->LearnSpellHighestRank(47450);
		player->LearnSpellHighestRank(47465);
		player->LearnSpellHighestRank(47520);
		player->LearnSpellHighestRank(47467);
		player->LearnSpellHighestRank(47436);
		player->LearnSpellHighestRank(47502);
		player->LearnSpellHighestRank(47437);
		player->LearnSpellHighestRank(47475);
		player->LearnSpellHighestRank(47440);
		player->LearnSpellHighestRank(47471);
		player->LearnSpellHighestRank(57755);
		player->LearnSpellHighestRank(57823);
		player->LearnSpellHighestRank(47488);
		//Neu BNN
		player->LearnSpellHighestRank(18499);
		player->LearnSpellHighestRank(3127);
		player->LearnSpellHighestRank(64382);
	}
};

void AddSC_AllSpellsOnLogin()
{
	new AllSpellsOnLogin;
}