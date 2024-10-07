/*
* Copyright BATTLE-WOW.ORG 2019
* Enchantment English (just OnGossipHello) & Russian (Full)
* Developers r0m1ntik
* 07.02.2019 Tested & work
*/

#include "Player.h"
#include "WorldSession.h"

using namespace std;

#define GetText(a, b, c)    a->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU ? b : c

struct VisualData
{
    uint32 Menu;
    uint32 Submenu;
    uint32 Icon;
    uint32 Id;
    string Icon_name;
    string Name;
    string Name_EN;
};

VisualData vData[] =
{
    /*        Head - Голова        */
    { 0, 0, GOSSIP_ICON_BATTLE, 3819, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+30 к силе заклинаний и +10 ед.маны каждые 5 секунд",       "+30 spell power and +10 mana every 5 seconds" },
    { 0, 0, GOSSIP_ICON_BATTLE, 3820, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+30 к силе заклинаний и +20 к рейтингу критического удара", "+30 spell Power and +20 critical Strike rating" },
    { 0, 0, GOSSIP_ICON_BATTLE, 3796, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+29 к силе заклинаний и +20 к рейтингу устойчивости",       "+29 spell Power and +20 resilience rating" },
    { 0, 0, GOSSIP_ICON_BATTLE, 3842, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+30 к выносливости и +25 к рейтингу устойчивости",          "+30 stamina and +25 resilience rating" },
    { 0, 0, GOSSIP_ICON_BATTLE, 3818, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+37 к выносливости и +20 к рейтингу защиты",                "+37 stamina and +20 defense rating" },
    { 0, 0, GOSSIP_ICON_BATTLE, 3817, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+50 к силе атаки и +20 к рейтингу критического удара",      "+50 attack power and +20 critical strike rating" },
    { 0, 0, GOSSIP_ICON_BATTLE, 3795, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+50 к силе атаки и +20 к рейтингу устойчивости",            "+50 attack power and +20 resilience rating" },
    { 0, 0, GOSSIP_ICON_BATTLE, 3815, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+25 к сопротивлению тайной магии и +30 к выносливости",     "+25 resistance to arcane magic and +30 stamina."},
    { 0, 0, GOSSIP_ICON_BATTLE, 3816, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+25 к сопротивлению огню и +30 к выносливости",             "+25 fire resistance and +30 stamina" },
    { 0, 0, GOSSIP_ICON_BATTLE, 3814, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+25 к сопротивлению темной магии и +30 к выносливости",     "+25 shadow resistance and +30 stamina" },
    { 0, 0, GOSSIP_ICON_BATTLE, 3812, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+25 к сопротивлению магии льда и +30 к выносливости",       "+25 frost resistance and +30 stamina" },
    { 0, 0, GOSSIP_ICON_BATTLE, 3813, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+25 к сопротивлению силам природы и +30 к выносливости",    "+25 resistance to the forces of nature and +30 stamina" },
    { 0, 10, GOSSIP_ICON_BATTLE,   0, "|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:15:15:-20:0|t", "Назад", "Back" },

    /*        Shoulders - Плечи        */
    { 2, 0, GOSSIP_ICON_BATTLE, 3808, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+40 к силе атаки и +15 к рейтингу критического удара",          "+40 attack power and +15 critical strike rating"},
    { 2, 0, GOSSIP_ICON_BATTLE, 3809, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+24 к силе заклинаний и +8 ед.маны каждые 5 секунд",            "+24 spell power and +8 mana every 5 seconds." },
    { 2, 0, GOSSIP_ICON_BATTLE, 3852, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+30 к выносливости и +15 к рейтингу устойчивости",              "+30 stamina and +15 resilience rating" },
    { 2, 0, GOSSIP_ICON_BATTLE, 3811, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+20 к рейтингу уклонения и +15 к рейтингу защиты",              "+20 dodge rating and +15 protection rating" },
    { 2, 0, GOSSIP_ICON_BATTLE, 3810, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+24 к силе заклинаний и +15 к рейтингу критического удара",     "+24 spell power and +15 critical strike rating" },
    { 2, 0, GOSSIP_ICON_BATTLE, 3794, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+23 к силе заклинаний и +15 к рейтингу устойчивости",           "+23 spell power and +15 resilience rating" },
    { 2, 0, GOSSIP_ICON_BATTLE, 3793, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+40 к силе атаки и + 15 крейтингу устойчивости",                "+40 attack power and + 15 resilience rating" },
    /*        Shouleders Proffesion - Плечи из професии        */
    { 2, 1, GOSSIP_ICON_BATTLE, 3835, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cffD80000+120 к силе атаки и + 15 к рейтингу критического эффекта|r", "|cffD80000+120 attack power and + 15 critical attack rating|r"},
    { 2, 1, GOSSIP_ICON_BATTLE, 3836, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cffD80000+70 к силе заклинаний и +8 к мане каждые 5 секунд|r",        "|cffD80000+70 spell power and +8 mana every 5 seconds|r" },
    { 2, 1, GOSSIP_ICON_BATTLE, 3838, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cffD80000+70 к силе заклинаний и +15 к рейтингу критического эффекта|r", "|cffD80000+70 spell power and +15 critical strike rating|r" },
    { 2, 1, GOSSIP_ICON_BATTLE, 3837, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cffD80000+60 к рейтингу уклонения и + 15 к защите|r",                     "|cffD80000+60 dodge rating and + 15 protection|r" },
    { 2, 10, GOSSIP_ICON_BATTLE,   0, "|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:15:15:-20:0|t", "Назад", "Back" },

    /*        Chest - Грудак        */
    { 4, 0, GOSSIP_ICON_BATTLE, 3832, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+10 ко всем характеристикам", "+10 to all specifications" },
    { 4, 0, GOSSIP_ICON_BATTLE, 3297, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+275 к здоровью", "+275 to health" },
    { 4, 0, GOSSIP_ICON_BATTLE, 2387, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+10 ед.маны каждые 5 секунд", "+10 mana every 5 seconds" },
    { 4, 0, GOSSIP_ICON_BATTLE, 3245, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+20 к рейтингу устойчивости", "+20 Resilience Rating" },
    { 4, 0, GOSSIP_ICON_BATTLE, 1953, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+22 к рейтингу защиты", "+22 protection rating" },
    { 4, 10, GOSSIP_ICON_BATTLE,   0, "|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:15:15:-20:0|t", "Назад", "Back" },

    /*        Waist - Пояс        */
    { 5, 0, GOSSIP_ICON_BATTLE, 3729, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "Добавить гнездо для сокета", "Add slot for socket" },
    { 5, 2, GOSSIP_ICON_BATTLE, 3601, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cffD80000Наременные осколочные гранаты|r", "|cffD80000Temporary Frag Grenades|r" },
    { 5, 2, GOSSIP_ICON_BATTLE, 3599, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cffD80000Генератор ЭМИ|r", "|cffD80000EMP Generator|r" },
    { 5, 10, GOSSIP_ICON_BATTLE,   0, "|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:15:15:-20:0|t", "Назад", "Back" },

    /*        Legs - Ноги        */
    { 6, 0, GOSSIP_ICON_BATTLE, 3853, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+40 к устойчивости и + 28 к выносливости", "+40 resilence and + 28 stamina" },
    { 6, 0, GOSSIP_ICON_BATTLE, 3822, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+55 к выносливости и +22 к ловкости", "+55 stamina and +22 agility" },
    { 6, 0, GOSSIP_ICON_BATTLE, 3823, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+75 к силе атаки и +22 к рейтингу критического удара", "+75 attack power and +22 crit rating" },
    { 6, 0, GOSSIP_ICON_BATTLE, 3719, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+50 к силе заклинаний и +20 к духу", "+50 spell power and +20 spirit" },
    { 6, 0, GOSSIP_ICON_BATTLE, 3721, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+50 к силе заклинаний и +30 к выносливости", "+50 spell power and +30 stamina" },
    { 6, 10, GOSSIP_ICON_BATTLE,   0, "|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:15:15:-20:0|t", "Назад", "Back" },

    /*        Feet - Cтупни        */
    { 7, 0, GOSSIP_ICON_BATTLE, 1597, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+32 к силе атаки", "+32 attack power" },
    { 7, 0, GOSSIP_ICON_BATTLE, 3232, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+15 к выносливости и небольшое увеличение скорости", "+15 stamina and a slight increase in speed" },
    { 7, 0, GOSSIP_ICON_BATTLE,  983, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+16 к ловкости", "+16 agility" },
    { 7, 0, GOSSIP_ICON_BATTLE, 1147, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+18 к духу", "+18 spirit" },
    { 7, 0, GOSSIP_ICON_BATTLE, 3244, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+7 ед. здоровья и маны каждые 5 сек", "+7 health and mana every 5 seconds" },
    { 7, 0, GOSSIP_ICON_BATTLE, 3826, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+12 к рейтингу меткости, и + 12 к рейтингу критического удара", "+12 hit rating, and + 12 crit rating" },
    { 7, 0, GOSSIP_ICON_BATTLE, 1075, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+22 к выносливости", "+22 stamina" },
    { 7, 23, GOSSIP_ICON_BATTLE, 3606, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cffD80000Нитро сапоги|r", "|cffD80000Nitro boots|r" },
    { 7, 0, GOSSIP_ICON_BATTLE, 0000, "|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:15:15:-20:0|t", "Назад", "Back" },

    /*        Wrists - Запястья        */
    { 8, 0, GOSSIP_ICON_BATTLE, 3850, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+40 к выносливости", "+40 Stamina" },
    { 8, 0, GOSSIP_ICON_BATTLE, 2332, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+30 к силе заклинаний", "+30 Spell Power" },
    { 8, 0, GOSSIP_ICON_BATTLE, 3845, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+50 к силе атаки", "+50 Attack Power" },
    { 8, 0, GOSSIP_ICON_BATTLE, 1147, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+18 к духу", "+18 Spirit" },
    { 8, 0, GOSSIP_ICON_BATTLE, 3231, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+15 к рейтингу мастерства", "+15 skill rating" },
    { 8, 0, GOSSIP_ICON_BATTLE, 1119, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+16 к интеллекту", "+16 to intellect" },
    { 8, 6, GOSSIP_ICON_BATTLE, 3763, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cffD80000+70 к сопротивлению тайной магии|r", "|cffD80000+70 Arcane Resistance|r" },
    { 8, 6, GOSSIP_ICON_BATTLE, 3759, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cffD80000+70 к сопротивлению огню|r", "|cffD80000+70 Fire Resistance|r" },
    { 8, 6, GOSSIP_ICON_BATTLE, 3760, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cffD80000+70 к сопротивлению магии льда|r", "|cffD80000+70 Frost Resistance|r" },
    { 8, 6, GOSSIP_ICON_BATTLE, 3762, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cffD80000+70 к сопротивлению силам природы|r", "|cffD80000+70 Resistance to the forces of nature|r" },
    { 8, 6, GOSSIP_ICON_BATTLE, 3761, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cffD80000+70 к сопротивлению темной магии|r", "|cffD80000+70 Shadow Resistance|r" },
    { 8, 6, GOSSIP_ICON_BATTLE, 3756, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cffD80000+130 к силе атаки|r", "|cffD80000+130 attack power|r" },
    { 8, 6, GOSSIP_ICON_BATTLE, 3757, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cffD80000+102 к выносливости|r", "|cffD80000+102 stamina|r" },
    { 8, 6, GOSSIP_ICON_BATTLE, 3758, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cffD80000+76 к силе заклинаний|r", "|cffD80000+76 spell power|r" },
    { 8, 3, GOSSIP_ICON_BATTLE, 3717, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cffD80000Добавить гнездо для сокета|r", "|cffD80000 Add slot for socket|r" },
    { 8, 10, GOSSIP_ICON_BATTLE,   0, "|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:15:15:-20:0|t", "Назад", "Back" },

    /*        Hands - Кисти Рук        */
    { 9, 0, GOSSIP_ICON_BATTLE, 3249, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+16 к рейтингу критического удара", "+16 crit rating" },
    { 9, 0, GOSSIP_ICON_BATTLE, 3253, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+2% угрозы и + 10 к рейтингу парирования", "+ 2% threat and + 10 parry rating" },
    { 9, 0, GOSSIP_ICON_BATTLE, 1603, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+44 к силе атаки", "+44 attack power" },
    { 9, 0, GOSSIP_ICON_BATTLE, 3222, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+20 к ловкости", "+20 agility" },
    { 9, 0, GOSSIP_ICON_BATTLE, 3234, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+20 к рейтингу меткости", "+20 hit rating" },
    { 9, 0, GOSSIP_ICON_BATTLE, 3246, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+28 к силе заклинаний", "+28 spell power" },
    { 9, 22, GOSSIP_ICON_BATTLE, 3604, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cffD80000Гиперскоростные ускорители|r", "|cffD80000Hyper Speed Boosters|r" },
    { 9, 22, GOSSIP_ICON_BATTLE, 3603, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cffD80000Нарукавная зажигательная ракетница|r", "|cffD80000Incendiary Rocket Launcher|r" },
    { 9, 3, GOSSIP_ICON_BATTLE, 3723, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cffD80000Добавить гнездо для сокета|r", "|cffD80000Add slot for socket|r" },
    { 9, 10, GOSSIP_ICON_BATTLE,   0, "|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:15:15:-20:0|t", "Назад", "Back" },

    /*        Fingers - Кольца        */
    { 10, 4, GOSSIP_ICON_BATTLE, 3839, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cffD80000+40 к силе атаки|r", "|cffD80000 +40 attack power|r" },
    { 10, 4, GOSSIP_ICON_BATTLE, 3840, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cffD80000+23 к силе заклинаний|r", "|cffD80000 +23 Spell Power|r" },
    { 10, 4, GOSSIP_ICON_BATTLE, 3791, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cffD80000+30 к выносливости|r", "|cffD80000 +30 stamina|r" },
    { 10, 10, GOSSIP_ICON_BATTLE,   0, "|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:15:15:-20:0|t", "Назад", "Back" },

    /*        Fingers 2 - Кольца 2        */
    { 11, 4, GOSSIP_ICON_BATTLE, 3839, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cffD80000+40 к силе атаки|r", "|cffD80000 +40 attack power|r" },
    { 11, 4, GOSSIP_ICON_BATTLE, 3840, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cffD80000+23 к силе заклинаний|r", "|cffD80000 +23 Spell Power|r" },
    { 11, 4, GOSSIP_ICON_BATTLE, 3791, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cffD80000+30 к выносливости|r", "|cffD80000 +30 stamina|r" },
    { 11, 10, GOSSIP_ICON_BATTLE,   0, "|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:15:15:-20:0|t", "Назад", "Back" },

    /*        Back - Спина        */
    { 14, 0, GOSSIP_ICON_BATTLE, 3296, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+10 к духу и снижение угрозы на 2%", "+10 spirit and reduced threat by 2%" },
    { 14, 0, GOSSIP_ICON_BATTLE, 1957, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+16 к рейтингу защиты", "+16 Protection Rating" },
    { 14, 0, GOSSIP_ICON_BATTLE, 3243, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+35 к проникающей способности заклинаний", "+35 spell penetration" },
    { 14, 0, GOSSIP_ICON_BATTLE, 3294, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+225 к броне", "+225 to armor" },
    { 14, 0, GOSSIP_ICON_BATTLE, 1099, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+22 к ловкости", "+22 agility" },
    { 14, 0, GOSSIP_ICON_BATTLE, 3831, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+23 к рейтингу скорости", "+23 hast rating" },
    { 14, 0, GOSSIP_ICON_BATTLE, 3256, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "Улучшение незаметности и +10 к ловкости", "Improved stealth and +10 agility" },
    { 14, 5, GOSSIP_ICON_BATTLE, 3859, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cffD80000Пружинистая паутинка|r", "|cffD80000 Springy gossamer|r" },
    { 14, 5, GOSSIP_ICON_BATTLE, 3728, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cffD80000Вышивка темного сияния|r", "|cffD80000 Dark Shadow Embroidery|r" },
    { 14, 5, GOSSIP_ICON_BATTLE, 3722, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cffD80000Светлотканая вышивка|r", "|cffD80000 Light Woven Embroidery|r" },
    { 14, 5, GOSSIP_ICON_BATTLE, 3730, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cffD80000Вышивка в виде рукояти меча|r" , "|cffD80000 Sword hilt embroidery|r" },
    { 14, 10, GOSSIP_ICON_BATTLE,   0, "|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:15:15:-20:0|t", "Назад", "Back" },

    /*         Mainhand - Правая Рука        */
    { 15, 8, GOSSIP_ICON_BATTLE, 3854, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cff005ce6+81 к силе заклинаний|r", "|cff005ce6 +81 spell power|r" },
    { 15, 8, GOSSIP_ICON_BATTLE, 3827, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cff005ce6+110 к силе атаки|r", "|cff005ce6 +110 attack power|r" },
    { 15, 0, GOSSIP_ICON_BATTLE, 3844, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+45 к духу", "+45 spirit" },
    { 15, 0, GOSSIP_ICON_BATTLE, 3834, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+63 к силе заклинаний", "+63 spell power" },
    { 15, 0, GOSSIP_ICON_BATTLE, 3833, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+65 к силе атаки", "+65 attack power" },
    { 15, 0, GOSSIP_ICON_BATTLE, 3789, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "Боевое исступление", "Fighting frenzy" },
    { 15, 0, GOSSIP_ICON_BATTLE, 2673, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "Мангуст", "Mongoose" },
    { 15, 0, GOSSIP_ICON_BATTLE, 3225, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "Палач", "Executioner" },
    { 15, 0, GOSSIP_ICON_BATTLE, 1894, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "Леденящая стужа", "Icy cold" },
    { 15, 0, GOSSIP_ICON_BATTLE, 3731, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "Титановая цепь", "Titanium chain" },
    { 15, 0, GOSSIP_ICON_BATTLE, 3247, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "Оберег", "Guardian" },
    { 15, 0, GOSSIP_ICON_BATTLE, 3239, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "Оружие Ледолома", "Icebreaker Weapon" },
    { 15, 0, GOSSIP_ICON_BATTLE, 2675, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "Военачальник", "Warlord" },
    { 15, 0, GOSSIP_ICON_BATTLE, 3869, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "Отведение удара", "Kickback" },
    { 15, 0, GOSSIP_ICON_BATTLE, 3870, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "Вытягивание Крови", "Blood Pulling" },
    { 15, 0, GOSSIP_ICON_BATTLE, 3790, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "Черная магия", "Black magic" },
    { 15, 10, GOSSIP_ICON_BATTLE,   0, "|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:15:15:-20:0|t", "Назад", "Back" },

    /*        Offhand - Левая Рука        */
    { 16, 8, GOSSIP_ICON_BATTLE, 3854, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cff005ce6+81 к силе заклинаний|r", "|cff005ce6 +81 spell power|r" },
    { 16, 8, GOSSIP_ICON_BATTLE, 3827, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cff005ce6+110 к силе атаки|r", "|cff005ce6 +110 attack power|r" },
    { 16, 9, GOSSIP_ICON_BATTLE, 1952, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cffD80000+20 к рейтингу защиты|r", "|cffD80000 +20 protection rating|r" },
    { 16, 9, GOSSIP_ICON_BATTLE, 1128, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cffD80000+25 к интелекту|r", "|cffD80000 +25 intellect|r" },
    { 16, 9, GOSSIP_ICON_BATTLE, 3229, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cffD80000+12 к рейтингу устойчивости|r", "|cffD80000 +12 Resilience Rating|r" },
    { 16, 9, GOSSIP_ICON_BATTLE, 3849, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cffD80000Титановая обшивка|r", "|cffD80000 Titanium plating|r" },
    { 16, 9, GOSSIP_ICON_BATTLE, 1071, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cffD80000+18 к выносливости|r", "|cffD80000 +18 stamina|r" },
    { 16, 9, GOSSIP_ICON_BATTLE, 2653, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "|cffD80000+36 к показателю блокирования|r", "|cffD80000+36 to blocking rate|r" },
    { 16, 11, GOSSIP_ICON_BATTLE, 3844, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+45 к духу", "+45 spirit" },
    { 16, 11, GOSSIP_ICON_BATTLE, 3834, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+63 к силе заклинаний", "+63 spell power" },
    { 16, 11, GOSSIP_ICON_BATTLE, 3833, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+65 к силе атаки", "+65 attack power" },
    { 16, 11, GOSSIP_ICON_BATTLE, 3789, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "Боевое исступление", "Fighting frenzy" },
    { 16, 11, GOSSIP_ICON_BATTLE, 2673, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "Мангуст", "Mongoose" },
    { 16, 11, GOSSIP_ICON_BATTLE, 3225, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "Палач", "Executioner" },
    { 16, 11, GOSSIP_ICON_BATTLE, 1894, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "Леденящая стужа", "Icy cold" },
    { 16, 11, GOSSIP_ICON_BATTLE, 3731, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "Титановая цепь", "Titanium chain" },
    { 16, 11, GOSSIP_ICON_BATTLE, 3247, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "Оберег", "Guardian" },
    { 16, 11, GOSSIP_ICON_BATTLE, 3239, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "Оружие Ледолома", "Icebreaker Weapon" },
    { 16, 11, GOSSIP_ICON_BATTLE, 2675, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "Военачальник", "Warlord" },
    { 16, 11, GOSSIP_ICON_BATTLE, 3869, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "Отведение удара", "Kickback" },
    { 16, 11, GOSSIP_ICON_BATTLE, 3870, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "Вытягивание Крови", "Blood Pulling" },
    { 16, 11, GOSSIP_ICON_BATTLE, 3790, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "Черная магия", "Black magic" },
    { 16, 10, GOSSIP_ICON_BATTLE,   0, "|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:15:15:-20:0|t", "Назад", "Back" },

    /*        Ranged - Дальний бой        */
    { 17, 7, GOSSIP_ICON_BATTLE, 3608, "|TInterface\\icons\\inv_misc_note_01:15:15:-20:0|t", "+40 к показателю критического удара", "+40 Critical Strike" },
    { 17, 10, GOSSIP_ICON_BATTLE,   0, "|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:15:15:-20:0|t", "Назад" , "Back" },
};

class Enchat_npc_new : public  CreatureScript
{
public:
    Enchat_npc_new() : CreatureScript("Enchat_npc_new") { }

    void AdvancedEnchant(Player* player, Item* item, EnchantmentSlot slot, uint32 socketGem)
    {
    	if (!item)
    	{
    		ChatHandler(player->GetSession()).PSendSysMessage(GetText(player,"Вы должны одеть предмет для зачарование!", "You must wear an item for enchantment!"));
    		return;
    	}

    	if (!socketGem)
    	{
    		ChatHandler(player->GetSession()).PSendSysMessage(GetText(player,"Что-то пошло не так в коде.","Something went wrong in the code."));
    		return;
    	}

    	player->ApplyEnchantment(item, slot, false);
    	item->SetEnchantment(slot, socketGem, 0, 0);
    	player->ApplyEnchantment(item, slot, true);
    	ChatHandler(player->GetSession()).PSendSysMessage(GetText(player,"%s - успешно был улучшен!","%s - has been successfully improved!"), item->GetTemplate()->Name1.c_str());
    }

    void Enchant(Player* player, Item* item, uint32 enchantid)
    {
    	if (!item)
    	{
    		ChatHandler(player->GetSession()).PSendSysMessage(GetText(player,"Вы должны одеть предмет для зачарование!", "You must wear an item for enchantment!"));
    		return;
    	}

    	if (!enchantid)
    	{
    		ChatHandler(player->GetSession()).PSendSysMessage(GetText(player,"Что-то пошло не так в коде.","Something went wrong in the code."));
    		return;
    	}

    	player->ApplyEnchantment(item, PERM_ENCHANTMENT_SLOT, false);
    	item->SetEnchantment(PERM_ENCHANTMENT_SLOT, enchantid, 0, 0);
    	player->ApplyEnchantment(item, PERM_ENCHANTMENT_SLOT, true);
        ChatHandler(player->GetSession()).PSendSysMessage(GetText(player,"%s - успешно был улучшен!","%s - has been successfully improved!"), item->GetTemplate()->Name1.c_str());
    }

    /* name list */
    const char* GetSlotName(Player* player, uint8 slot, WorldSession* /*session*/) const
    {
        switch (slot)
        {                                                       /*  Русский перевод            English Translate */
            case EQUIPMENT_SLOT_HEAD:       return  GetText(player, "Зачаровать Голову",        "Enchant Head");
            case EQUIPMENT_SLOT_SHOULDERS:  return  GetText(player, "Зачаровать Плечи",         "Enchant Shoulders");
            case EQUIPMENT_SLOT_CHEST:      return  GetText(player, "Зачаровать Грудь",         "Enchant Chest");
            case EQUIPMENT_SLOT_LEGS:       return  GetText(player, "Зачаровать Ноги",          "Enchant Legs");
            case EQUIPMENT_SLOT_HANDS:      return  GetText(player, "Зачаровать Кисти рук",     "Enchant Hands");
            case EQUIPMENT_SLOT_WAIST:      return  GetText(player, "Зачаровать Пояс",          "Enchant Waist");
            case EQUIPMENT_SLOT_FEET:       return  GetText(player, "Зачаровать Ступни",        "Enchant Feet");
            case EQUIPMENT_SLOT_WRISTS:     return  GetText(player, "Зачаровать Запястья",      "Enchant Wrists");
            case EQUIPMENT_SLOT_BACK:       return  GetText(player, "Зачаровать Плащ",          "Enchant Back");
            case EQUIPMENT_SLOT_MAINHAND:   return  GetText(player, "Зачаровать Оружие",        "Enchant Mainhand");
            case EQUIPMENT_SLOT_OFFHAND:    return  GetText(player, "Зачаровать Левую руку",    "Enchant Offhand");
            case EQUIPMENT_SLOT_RANGED:     return  GetText(player, "Зачаровать Дальний бой",   "Enchant Ranged");
            case EQUIPMENT_SLOT_FINGER1:    return  GetText(player, "Зачаровать Первое Кольцо", "Enchant First Fingers");
            case EQUIPMENT_SLOT_FINGER2:    return  GetText(player, "Зачаровать Второе кольцо", "Enchant Second Fingers");
            default: return NULL;
        }
    }

    /* icons list */
    std::string GetItemIcon(uint32 entry, uint32 width, uint32 height, int x, int y) const
    {
        std::ostringstream ss;
        ss << "|TInterface";
        const ItemTemplate* temp = sObjectMgr->GetItemTemplate(entry);
        const ItemDisplayInfoEntry* dispInfo = NULL;
        if (temp)
        {
            dispInfo = sItemDisplayInfoStore.LookupEntry(temp->DisplayInfoID);
            if (dispInfo)
                ss << "/ICONS/" << dispInfo->inventoryIcon;
        }
        if (!dispInfo)
            ss << "/InventoryItems/WoWUnknownItem01";
        ss << ":" << width << ":" << height << ":" << x << ":" << y << "|t";
        return ss.str();
    }

    void GetMenu(Player* player, Creature* creature, uint32 menuId)
    {
        for (uint8 i = 0; i < (sizeof(vData) / sizeof(*vData)); i++)
        {
            if (vData[i].Menu == menuId)
            {
                if (player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU)
                    AddGossipItemFor(player, vData[i].Icon, vData[i].Icon_name + vData[i].Name, GOSSIP_SENDER_MAIN, i);
                else
                    AddGossipItemFor(player, vData[i].Icon, vData[i].Icon_name + vData[i].Name_EN, GOSSIP_SENDER_MAIN, i);
            }
        }
        player->PlayerTalkClass->SendGossipMenu(1, creature->GetGUID());
    }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        WorldSession* session = player->GetSession();
        for (uint8 slot = EQUIPMENT_SLOT_START; slot < EQUIPMENT_SLOT_END; ++slot)
        {
            if (const char* slotName = GetSlotName(player, slot, session))
            {
                Item* newItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, slot);
                uint32 entry  = newItem ? newItem->GetEntry() : 0;
                std::string icon = GetItemIcon(entry, 20, 20, -20, 0);

                if(newItem) /* show the menu if the item is dressed on the player */
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, icon + std::string(slotName), GOSSIP_SENDER_MAIN + 1, slot);
            }
        }
        player->PlayerTalkClass->SendGossipMenu(1, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();
        Item * item;

        /* Menu list enchant */
        if (sender == GOSSIP_SENDER_MAIN + 1)
        {
            GetMenu(player, creature, action);
            return false;
        }

        if (sender == GOSSIP_SENDER_MAIN + 2)
        {
            OnGossipHello(player,creature);
            return true;
        }

        else if (sender == GOSSIP_SENDER_MAIN)
        {
            uint32 menuData = vData[action].Submenu;

            item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, vData[action].Menu);
            if(!item) {
                ChatHandler(player->GetSession()).PSendSysMessage(GetText(player,"Не найден предмет в указаном слоте, оденьте предмет пожалуйста !",
                                                                                 "No item found in the specified slot, put on an item please!"));
                return true;
            }

            if (menuData == 0) /* normal enchant (don't need profession) */
            {
                if (vData[action].Id == 3729) /* Prismatic socket in waist - сокет в поясе */
                    AdvancedEnchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, vData[action].Menu), PRISMATIC_ENCHANTMENT_SLOT, vData[action].Id);
                else
                    Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, vData[action].Menu), vData[action].Id);
            }

            if (menuData == 1) /* INSCRIPTION - Начертание */
            {
                if(player->HasSkill(SKILL_INSCRIPTION) && player->GetSkillValue(SKILL_INSCRIPTION) == 450)
                    Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, vData[action].Menu), vData[action].Id);
                else
                    ChatHandler(player->GetSession()).PSendSysMessage(GetText(player,"Для этого вам нужно: Начертание - 450/450", "For this you need: Inscription - 450/450"));
            }

            if (menuData == 2) /* ENGINEERING - Инженерное Дело */
            {
                item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_WAIST);
                /* Condition for enchant spell on item where level > 150 */
                if (item->GetTemplate()->ItemLevel > 150)
                {
                    if (player->HasSkill(SKILL_ENGINEERING) && player->GetSkillValue(SKILL_ENGINEERING) == 450)
                        Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, vData[action].Menu), vData[action].Id);
                    else
                        ChatHandler(player->GetSession()).PSendSysMessage(GetText(player,"Для этого вам нужно: Инженерное Дело - 450/450","For this you need: Engineering - 450/450"));
                }
                else
                    ChatHandler(player->GetSession()).PSendSysMessage(GetText(player,"Уровень предмета должнен быть выше чем 150.","Item level must be higher than 150."));
            }

            if (menuData == 22) /* ENGINEERING - Инженерное Дело */
            {
                item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HANDS);
                /* Condition for enchant spell on item where level > 150 */
                if (item->GetTemplate()->ItemLevel > 150)
                {
                    if (player->HasSkill(SKILL_ENGINEERING) && player->GetSkillValue(SKILL_ENGINEERING) == 450)
                        Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, vData[action].Menu), vData[action].Id);
                    else
                        ChatHandler(player->GetSession()).PSendSysMessage(GetText(player,"Для этого вам нужно: Инженерное Дело - 450/450","For this you need: Engineering - 450/450"));
                }
                else
                    ChatHandler(player->GetSession()).PSendSysMessage(GetText(player,"Уровень предмета должнен быть выше чем 150.","Item level must be higher than 150."));
            }

            if (menuData == 23) /* ENGINEERING - Инженерное Дело */
            {
                item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FEET);
                /* Condition for enchant spell on item where level > 150 */
                if (item->GetTemplate()->ItemLevel > 150)
                {
                    if (player->HasSkill(SKILL_ENGINEERING) && player->GetSkillValue(SKILL_ENGINEERING) == 450)
                        Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, vData[action].Menu), vData[action].Id);
                    else
                        ChatHandler(player->GetSession()).PSendSysMessage(GetText(player,"Для этого вам нужно: Инженерное Дело - 450/450","For this you need: Engineering - 450/450"));
                }
                else
                    ChatHandler(player->GetSession()).PSendSysMessage(GetText(player,"Уровень предмета должнен быть выше чем 150.","Item level must be higher than 150."));
            }

            if (menuData == 3) /* Bkacksmithing - Кузнечное дело */
            {
                if (player->HasSkill(SKILL_BLACKSMITHING) && player->GetSkillValue(SKILL_BLACKSMITHING) == 450)
                    AdvancedEnchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, vData[action].Menu), PRISMATIC_ENCHANTMENT_SLOT, vData[action].Id);
                else
                    ChatHandler(player->GetSession()).PSendSysMessage(GetText(player,"Для этого вам нужно: Кузнечное Дело - 450/450","For this you need: Blacksmithing - 450/450"));
            }

            if (menuData == 4) /* Echanting - Наложение чар */
            {
                if (player->HasSkill(SKILL_ENCHANTING) && player->GetSkillValue(SKILL_ENCHANTING) == 450)
                    Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, vData[action].Menu), vData[action].Id);
                else
                    ChatHandler(player->GetSession()).PSendSysMessage(GetText(player,"Для этого вам нужно: Наложение чар - 450/450","For this you need: Enchanting - 450/450"));
            }

            if (menuData == 5) /* Tailoring - Портняжное дело */
            {
                if (player->HasSkill(SKILL_TAILORING) && player->GetSkillValue(SKILL_TAILORING) == 450)
                    Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, vData[action].Menu), vData[action].Id);
                else
                    ChatHandler(player->GetSession()).PSendSysMessage(GetText(player,"Для этого вам нужно: Портняжное дело - 450/450", "For this you need: Tailoring - 450/450"));
            }

            if (menuData == 6) /* Leatherworking - Кожевнечиство */
            {
                if (player->HasSkill(SKILL_LEATHERWORKING) && player->GetSkillValue(SKILL_LEATHERWORKING) == 450)
                    Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, vData[action].Menu), vData[action].Id);
                else
                    ChatHandler(player->GetSession()).PSendSysMessage(GetText(player,"Для этого вам нужно: Кожевничество - 450/450", "For this you need: Leatherworking - 450/450"));
            }

            if (menuData == 7)
            {
                item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_RANGED);

                if (item->GetTemplate()->Class == 2 && (item->GetTemplate()->SubClass == 18 || item->GetTemplate()->SubClass == 3 || item->GetTemplate()->SubClass == 2))
                    Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, vData[action].Menu), vData[action].Id);
                else
                    ChatHandler(player->GetSession()).PSendSysMessage(GetText(player,"Невозможно улучшить данный предмет !", "Unable to improve this item!"));
            }

            if (menuData == 8)
            {
                item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND);

                if(item->GetTemplate()->InventoryType == 17)
                    Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, vData[action].Menu), vData[action].Id);
                else
                    ChatHandler(player->GetSession()).PSendSysMessage(GetText(player,"Данная чарка для двуручного оружия !", "This enchantment for two-handed weapons!"));
            }

            if (menuData == 9)
            {
                item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND);

                if(item->GetTemplate()->InventoryType == 14)
                    Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, vData[action].Menu), vData[action].Id);
                else
                    ChatHandler(player->GetSession()).PSendSysMessage(GetText(player,"Данное зачарование для щитов !", "This enchantment for shields!"));
            }

            if (menuData == 11)
            {
                item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND);

                if(item->GetTemplate()->InventoryType != 14 && item->GetTemplate()->InventoryType != 23)
                    Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, vData[action].Menu), vData[action].Id);
                else
                    ChatHandler(player->GetSession()).PSendSysMessage(GetText(player,"Данное зачарование не может быть наложена на щиты / книги!", "This enchantment cannot be cast on shields!"));
            }

            if (menuData == 10) /* return on gossip menu */
                OnGossipHello(player,creature);
            else
                OnGossipHello(player,creature);
        }
        return true;
    }
};

void AddSC_Enchat_npc_new()
{
    new Enchat_npc_new();
}