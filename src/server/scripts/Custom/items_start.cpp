class New_Character : public PlayerScript
{
public:
	New_Character() : PlayerScript("New_Character") {}

	void OnLogin(Player* player)
	{

		if (player->GetTotalPlayedTime() < 1)
		{
				switch (player->getClass())
				{

					/*
					// Skill Reference
					player->learnSpell(204);	// Defense
					player->learnSpell(264);	// Bows
					player->learnSpell(5011);	// Crossbow
					player->learnSpell(674);	// Dual Wield
					player->learnSpell(15590);	// Fists
					player->learnSpell(266);	// Guns
					player->learnSpell(196);	// Axes
					player->learnSpell(198);	// Maces
					player->learnSpell(201);	// Swords
					player->learnSpell(750);	// Plate Mail
					player->learnSpell(200);	// PoleArms
					player->learnSpell(9116);	// Shields
					player->learnSpell(197);	// 2H Axe
					player->learnSpell(199);	// 2H Mace
					player->learnSpell(202);	// 2H Sword
					player->learnSpell(227);	// Staves
					player->learnSpell(2567);	// Thrown
					*/

				case CLASS_PALADIN:
					player->learnSpell(196);	// Axes
					player->learnSpell(750);	// Plate Mail
					player->learnSpell(200);	// PoleArms
					player->learnSpell(197);	// 2H Axe
					player->learnSpell(199);	// 2H Mace
					break;


				case CLASS_SHAMAN:
					player->learnSpell(15590);	// Fists
					player->learnSpell(8737);	// Mail
					player->learnSpell(196);	// Axes
					player->learnSpell(197);	// 2H Axe
					player->learnSpell(199);	// 2H Mace
					break;

				case CLASS_WARRIOR:
					player->learnSpell(264);	// Bows
					player->learnSpell(5011);	// Crossbow
					player->learnSpell(674);	// Dual Wield
					player->learnSpell(15590);	// Fists
					player->learnSpell(266);	// Guns
					player->learnSpell(750);	// Plate Mail
					player->learnSpell(200);	// PoleArms
					player->learnSpell(199);	// 2H Mace
					player->learnSpell(227);	// Staves
                    player->learnSpell(2567);
					break;

				case CLASS_HUNTER:
					player->learnSpell(674);	// Dual Wield
					player->learnSpell(15590);	// Fists
					player->learnSpell(266);	// Guns
					player->learnSpell(8737);	// Mail
					player->learnSpell(200);	// PoleArms
					player->learnSpell(227);	// Staves
					player->learnSpell(202);	// 2H Sword
                    player->learnSpell(2567);
					break;

				case CLASS_ROGUE:
					player->learnSpell(264);	// Bows
					player->learnSpell(5011);	// Crossbow
					player->learnSpell(15590);	// Fists
					player->learnSpell(266);	// Guns
					player->learnSpell(196);	// Axes
					player->learnSpell(198);	// Maces
					player->learnSpell(201);	// Swords
                    player->learnSpell(2567);
					break;

				case CLASS_DRUID:
					player->learnSpell(1180);	// Daggers
					player->learnSpell(15590);	// Fists
					player->learnSpell(198);	// Maces
					player->learnSpell(200);	// PoleArms
					player->learnSpell(227);	// Staves
					player->learnSpell(199);	// 2H Mace
					break;

				case CLASS_MAGE:
					player->learnSpell(201);	// Swords
					player->learnSpell(1180);	// Daggers
					break;

				case CLASS_WARLOCK:
					player->learnSpell(201);	// Swords
					break;

				case CLASS_PRIEST:
					player->learnSpell(1180);	// Daggers
					break;

				case CLASS_DEATH_KNIGHT:
					player->learnSpell(198);	// Maces
					player->learnSpell(199);
					break;

				default:
					break;
				}

                switch (player->getRace())
                {
                    case RACE_GOBLINNEW :
                    case RACE_WORGEN:
                    case RACE_PANDARENA:
                    case RACE_PANDARENH:
                        player->learnSpell(9078);
                        break;
                }

			if (player->GetSession()->GetSecurity() > 1)
			{
				player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HEAD, true);
				player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_NECK, true);
				player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_SHOULDERS, true);
				player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_CHEST, true);
				player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_BODY, true);
				player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_WAIST, true);
				player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_LEGS, true);
				player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_WRISTS, true);
				player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HANDS, true);
				player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FINGER1, true);
				player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FINGER2, true);
				player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_TRINKET1, true);
				player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_TRINKET2, true);
				player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_BACK, true);
				player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND, true);
				player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND, true);
				player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_RANGED, true);
				player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_TABARD, true);
				player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FEET, true);
				player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 2586, true); // [Gamemaster's Robe]
				player->EquipNewItem(EQUIPMENT_SLOT_FEET, 11508, true); // [Gamemaster's Slippers]
				player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 12064, true); // [Gamemaster Hood]
				// player->learnSpell(26035); // Изучение любого спела при старте
				ChatHandler(player->GetSession()).PSendSysMessage("|cff00ccff[GM character is ready for use]|r");
			}

			else // if normal char

			{
				if (player->getClass() == CLASS_PALADIN || player->getClass() == CLASS_WARRIOR || player->getClass() == CLASS_DEATH_KNIGHT)
				{
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HEAD, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_NECK, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_SHOULDERS, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_CHEST, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_BODY, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_WAIST, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_LEGS, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_WRISTS, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HANDS, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FINGER1, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FINGER2, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_TRINKET1, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_TRINKET2, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_BACK, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_RANGED, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_TABARD, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FEET, true);
					player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 61014, true); // Грудбь ДД
					player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 61016, true); // Ноги ДД
					player->EquipNewItem(EQUIPMENT_SLOT_FEET, 61017, true); // Ботинки ДД
					player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 61015, true); // Руки ДД
					player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 61012, true); // Голова ДД
					player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 100400, true); // Плечи ДД
					player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 61083, true); // Колцьцо ДД
					player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 61083, true); // Колцьцо ДД
					player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 61089, true); // Триня ДД
					player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 61089, true); // Триня ДД
					player->EquipNewItem(EQUIPMENT_SLOT_NECK, 61086, true); // Шея  ДД
					player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 60098, true); // Шея  ДД
					player->EquipNewItem(EQUIPMENT_SLOT_BACK, 61095, true); // Плащ ДД
					player->EquipNewItem(EQUIPMENT_SLOT_TABARD, 61178, true); // Шея  ДД
					player->EquipNewItem(EQUIPMENT_SLOT_BODY, 61166, true); // Рубашка  ДД
					player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 61143, true); // Пуха
					player->EquipNewItem(INVENTORY_SLOT_BAG_1, 61092, true); // Сумка 1
					player->EquipNewItem(INVENTORY_SLOT_BAG_2, 61092, true); // Сумка 2
					player->EquipNewItem(INVENTORY_SLOT_BAG_3, 61092, true); // Сумка 3
					player->EquipNewItem(INVENTORY_SLOT_BAG_4, 61092, true); // Сумка 4
					player->AddItem(21215, 10); // Кекс
					player->ResurrectPlayer(player->GetSession()->GetSecurity() ? 1.0f : 1.0f);
					player->SpawnCorpseBones();
					player->SaveToDB(false, false);
				//	player->AddItem(60015, 1); // Кольцо НОВИЧКАМ 
				// Оповещение в чате
				std::ostringstream ss;
				ss << "|cffFF0000[Приятной игры]|cffFF8000Вы получили бонус:|cff02A4B1 ViP-Аккаунт [2] дня|r";
				ChatHandler(player->GetSession()).SendSysMessage(ss.str().c_str());
				ChatHandler(player->GetSession()).PSendSysMessage("|cffFF8000Вы изучили новыки владения оружием|r");
                ChatHandler(player->GetSession()).PSendSysMessage("|cffFF8000Среднее время прокачки до 130-уровня:|cff02A4B1 40 минут|r");
				}

				if (player->getClass() == CLASS_HUNTER)
				{
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HEAD, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_NECK, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_SHOULDERS, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_CHEST, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_BODY, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_WAIST, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_LEGS, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_WRISTS, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HANDS, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FINGER1, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FINGER2, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_TRINKET1, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_TRINKET2, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_BACK, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_RANGED, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_TABARD, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FEET, true);
					player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 61014, true); // Грудбь ДД
					player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 61016, true); // Ноги ДД
					player->EquipNewItem(EQUIPMENT_SLOT_FEET, 61017, true); // Ботинки ДД
					player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 61015, true); // Руки ДД
					player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 61012, true); // Голова ДД
					player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 100401, true); // Плечи ДД
					player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 61084, true); // Колцьцо ДД
					player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 61084, true); // Колцьцо ДД
					player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 61090, true); // Триня ДД
					player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 61090, true); // Триня ДД
					player->EquipNewItem(EQUIPMENT_SLOT_NECK, 61087, true); // Шея  ДД
					player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 60098, true); // Шея  ДД
					player->EquipNewItem(EQUIPMENT_SLOT_BACK, 61096, true); // Плащ ДД
					player->EquipNewItem(EQUIPMENT_SLOT_TABARD, 61179, true); // Шея  ДД
					player->EquipNewItem(EQUIPMENT_SLOT_BODY, 61167, true); // Шея  ДД
					player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 61147, true); // Пуха
					player->EquipNewItem(INVENTORY_SLOT_BAG_1, 61093, true); // Сумка 1
					player->EquipNewItem(INVENTORY_SLOT_BAG_2, 61093, true); // Сумка 2
					player->EquipNewItem(INVENTORY_SLOT_BAG_3, 61093, true); // Сумка 3
					player->EquipNewItem(INVENTORY_SLOT_BAG_4, 61093, true); // Сумка 4
					player->AddItem(21215, 10); // Кекс
				//	player->AddItem(60015, 1); // Кольцо НОВИЧКАМ 
					player->AddItem(61145, 1); // Арбалет 
					// Оповещение в чате
					std::ostringstream ss;
					ss << "|cffFF0000[Приятной игры]|cffFF8000Вы получили бонус:|cff02A4B1 ViP-Аккаунт [2] дня|r";
					ChatHandler(player->GetSession()).SendSysMessage(ss.str().c_str());
					ChatHandler(player->GetSession()).PSendSysMessage("|cffFF8000Вы изучили новыки владения оружием|r");
                    ChatHandler(player->GetSession()).PSendSysMessage("|cffFF8000Среднее время прокачки до 130-уровня:|cff02A4B1 40 минут|r");
				}

				if (player->getClass() == CLASS_ROGUE)
				{
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HEAD, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_NECK, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_SHOULDERS, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_CHEST, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_BODY, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_WAIST, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_LEGS, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_WRISTS, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HANDS, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FINGER1, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FINGER2, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_TRINKET1, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_TRINKET2, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_BACK, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_RANGED, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_TABARD, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FEET, true);
					player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 61014, true); // Грудбь ДД
					player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 61016, true); // Ноги ДД
					player->EquipNewItem(EQUIPMENT_SLOT_FEET, 61017, true); // Ботинки ДД
					player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 61015, true); // Руки ДД
					player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 61012, true); // Голова ДД
					player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 100401, true); // Плечи ДД
					player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 61084, true); // Колцьцо ДД
					player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 61084, true); // Колцьцо ДД
					player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 61090, true); // Триня ДД
					player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 61090, true); // Триня ДД
					player->EquipNewItem(EQUIPMENT_SLOT_NECK, 61087, true); // Шея  ДД
					player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 60098, true); // Шея  ДД
					player->EquipNewItem(EQUIPMENT_SLOT_BACK, 61096, true); // Плащ ДД
					player->EquipNewItem(EQUIPMENT_SLOT_TABARD, 61179, true); // Шея  ДД
					player->EquipNewItem(EQUIPMENT_SLOT_BODY, 61167, true); // Шея  ДД
					player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 61146, true); // Пуха
					player->EquipNewItem(EQUIPMENT_SLOT_OFFHAND, 61146, true); // Пуха
					player->EquipNewItem(INVENTORY_SLOT_BAG_1, 61093, true); // Сумка 1
					player->EquipNewItem(INVENTORY_SLOT_BAG_2, 61093, true); // Сумка 2
					player->EquipNewItem(INVENTORY_SLOT_BAG_3, 61093, true); // Сумка 3
					player->EquipNewItem(INVENTORY_SLOT_BAG_4, 61093, true); // Сумка 4
					player->AddItem(21215, 10); // Кекс
				//	player->AddItem(60015, 1); // Кольцо НОВИЧКАМ 
					// Оповещение в чате
					std::ostringstream ss;
					ss << "|cffFF0000[Приятной игры]|cffFF8000Вы получили бонус:|cff02A4B1 ViP-Аккаунт [2] дня|r";
					ChatHandler(player->GetSession()).SendSysMessage(ss.str().c_str());
					ChatHandler(player->GetSession()).PSendSysMessage("|cffFF8000Вы изучили новыки владения оружием|r");
                    ChatHandler(player->GetSession()).PSendSysMessage("|cffFF8000Среднее время прокачки до 130-уровня:|cff02A4B1 40 минут|r");
				}

				if (player->getClass() == CLASS_MAGE || player->getClass() == CLASS_PRIEST || player->getClass() == CLASS_WARLOCK)
				{
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HEAD, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_NECK, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_SHOULDERS, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_CHEST, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_BODY, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_WAIST, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_LEGS, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_WRISTS, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HANDS, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FINGER1, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FINGER2, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_TRINKET1, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_TRINKET2, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_BACK, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_RANGED, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_TABARD, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FEET, true);
					player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 61008, true); // Грудбь ДД
					player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 61010, true); // Ноги ДД
					player->EquipNewItem(EQUIPMENT_SLOT_FEET, 61011, true); // Ботинки ДД
					player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 61009, true); // Руки ДД
					player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 61006, true); // Голова ДД
					player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 100402, true); // Плечи ДД
					player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 61085, true); // Колцьцо ДД
					player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 61085, true); // Колцьцо ДД
					player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 61091, true); // Триня ДД
					player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 61091, true); // Триня ДД
					player->EquipNewItem(EQUIPMENT_SLOT_NECK, 61088, true); // Шея  ДД
					player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 60099, true); // Шея  ДД
					player->EquipNewItem(EQUIPMENT_SLOT_BACK, 61097, true); // Плащ ДД
					player->EquipNewItem(EQUIPMENT_SLOT_TABARD, 61180, true); // Шея  ДД
					player->EquipNewItem(EQUIPMENT_SLOT_BODY, 61168, true); // Шея  ДД
					player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 61144, true); // Пуха
					player->EquipNewItem(INVENTORY_SLOT_BAG_1, 61094, true); // Сумка 1
					player->EquipNewItem(INVENTORY_SLOT_BAG_2, 61094, true); // Сумка 2
					player->EquipNewItem(INVENTORY_SLOT_BAG_3, 61094, true); // Сумка 3
					player->EquipNewItem(INVENTORY_SLOT_BAG_4, 61094, true); // Сумка 4
					player->AddItem(21215, 10); // Кекс
				//	player->AddItem(60015, 1); // Кольцо НОВИЧКАМ 
					// Оповещение в чате
					std::ostringstream ss;
					ss << "|cffFF0000[Приятной игры]|cffFF8000Вы получили бонус:|cff02A4B1 ViP-Аккаунт [2] дня|r";
					ChatHandler(player->GetSession()).SendSysMessage(ss.str().c_str());
					ChatHandler(player->GetSession()).PSendSysMessage("|cffFF8000Вы изучили новыки владения оружием|r");
                    ChatHandler(player->GetSession()).PSendSysMessage("|cffFF8000Среднее время прокачки до 130-уровня:|cff02A4B1 40 минут|r");
				}

				if (player->getClass() == CLASS_DRUID || player->getClass() == CLASS_SHAMAN)
				{
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HEAD, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_NECK, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_SHOULDERS, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_CHEST, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_BODY, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_WAIST, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_LEGS, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_WRISTS, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HANDS, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FINGER1, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FINGER2, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_TRINKET1, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_TRINKET2, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_BACK, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_RANGED, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_TABARD, true);
					player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FEET, true);
					player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 61002, true); // Грудбь ДД
					player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 61004, true); // Ноги ДД
					player->EquipNewItem(EQUIPMENT_SLOT_FEET, 61005, true); // Ботинки ДД
					player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 61003, true); // Руки ДД
					player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 61000, true); // Голова ДД
					player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 100402, true); // Плечи ДД
					player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 61085, true); // Колцьцо ДД
					player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 61091, true); // Триня ДД
					player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 61091, true); // Триня ДД
					player->EquipNewItem(EQUIPMENT_SLOT_NECK, 61088, true); // Шея  ДД
					player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 60099, true); // Шея  ДД
					player->EquipNewItem(EQUIPMENT_SLOT_BACK, 61097, true); // Плащ ДД
					player->EquipNewItem(EQUIPMENT_SLOT_TABARD, 61180, true); // Шея  ДД
					player->EquipNewItem(EQUIPMENT_SLOT_BODY, 61168, true); // Шея  ДД
					player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 61144, true); // Пуха
					player->EquipNewItem(INVENTORY_SLOT_BAG_1, 61093, true); // Сумка 1
					player->EquipNewItem(INVENTORY_SLOT_BAG_2, 61093, true); // Сумка 2
					player->EquipNewItem(INVENTORY_SLOT_BAG_3, 61093, true); // Сумка 3
					player->EquipNewItem(INVENTORY_SLOT_BAG_4, 61093, true); // Сумка 4
					player->AddItem(21215, 10); // Кекс
					//	player->AddItem(60015, 1); // Кольцо НОВИЧКАМ 
					// Оповещение в чате
					std::ostringstream ss;
					ss << "|cffFF0000[Приятной игры]|cffFF8000Вы получили бонус:|cff02A4B1 ViP-Аккаунт [2] дня|r";
					ChatHandler(player->GetSession()).SendSysMessage(ss.str().c_str());
					ChatHandler(player->GetSession()).PSendSysMessage("|cffFF8000Вы изучили новыки владения оружием|r");
					ChatHandler(player->GetSession()).PSendSysMessage("|cffFF8000Среднее время прокачки до 130-уровня:|cff02A4B1 40 минут|r");
				}
			}
		}
	}
};

	void AddSC_New_Character()
	{
		new New_Character();
	}
