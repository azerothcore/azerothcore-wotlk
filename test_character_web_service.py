#!/usr/bin/env python3
"""
Test script for AzerothCore Character Web Service

This script tests the character gear modification web service by sending
the JSON payload provided in the original request.

IMPORTANT: The character must be OFFLINE (logged out) for gear changes to work.
The character must also not be in a battleground.

Usage: python test_character_web_service.py [host] [port]
"""

import json
import sys
import requests

def test_character_web_service(host="localhost", port=8080):
    """Test the character web service with sample data."""
    
    # Sample data from the original request
    test_data = {
    "name": "Balance",
    "phase": 1,
    "character": {
        "name": "Thirk",
        "level": 29,
        "gameClass": "MAGE",
        "race": "HUMAN",
        "faction": "ALLIANCE"
    },
    "items": [
        {
            "name": "Spellpower Goggles Xtreme",
            "id": 10502,
            "slot": "HEAD"
        },
        {
            "name": "River Pride Choker",
            "id": 13087,
            "acquired": True,
            "slot": "NECK"
        },
        {
            "name": "Robes of Arugal",
            "id": 6324,
            "enchant": {
                "name": "Enchant Chest - Major Health",
                "id": 1892,
                "spellId": 20026
            },
            "slot": "CHEST"
        },
        {
            "name": "Highlander's Cloth Girdle",
            "id": 20099,
            "slot": "WAIST"
        },
        {
            "name": "Highlander's Cloth Boots",
            "id": 20096,
            "enchant": {
                "name": "Enchant Boots - Fortitude",
                "id": 2649,
                "spellId": 27950
            },
            "slot": "FEET"
        },
        {
            "name": "Vital Bracelets",
            "id": 14206,
            "enchant": {
                "name": "Enchant Bracer - Superior Stamina",
                "id": 1886,
                "spellId": 20011
            },
            "slot": "WRISTS"
        },
        {
            "name": "Hotshot Pilot's Gloves",
            "id": 9491,
            "enchant": {
                "name": "Enchant Gloves - Frost Power",
                "id": 2615,
                "spellId": 25074
            },
            "acquired": True,
            "slot": "HANDS"
        },
        {
            "name": "Deadman's Hand",
            "id": 34227,
            "slot": "FINGER_1"
        },
        {
            "name": "Rune of Perfection",
            "id": 21566,
            "slot": "TRINKET_1"
        },
        {
            "name": "Arena Grand Master",
            "id": 19024,
            "slot": "TRINKET_2"
        },
        {
            "name": "Parachute Cloak",
            "id": 10518,
            "enchant": {
                "name": "Enchant Cloak - Spell Penetration",
                "id": 2938,
                "spellId": 34003
            },
            "slot": "BACK"
        },
        {
            "name": "Zealot Blade",
            "id": 13033,
            "enchant": {
                "name": "Enchant Weapon - Spellpower",
                "id": 2504,
                "spellId": 22749
            },
            "slot": "MAIN_HAND"
        },
        {
            "name": "Furbolg Medicine Pouch",
            "id": 16768,
            "slot": "OFF_HAND"
        },
        {
            "name": "Gravestone Scepter",
            "id": 7001,
            "slot": "RANGED"
        }
    ],
    "consumables": [],
    "buffs": [],
    "talents": [],
    "glyphs": [],
    "points": [
        {
            "name": "Fire",
            "stats": {
                "spellDamage": 1,
                "fireDamage": 1,
                "critRating": 0.84,
                "hasteRating": 0.66,
                "hitRating": 1.5,
                "intellect": 0.56,
                "mp5": 0.35,
                "spirit": 0.68,
                "metaSockets": 30,
                "redSockets": 19,
                "yellowSockets": 19,
                "blueSockets": 19,
                "prismaticSockets": 19
            }
        }
    ],
    "stats": {
        "agility": 33,
        "arcaneDamage": 120,
        "armor": 410,
        "armorBonus": 110,
        "attackPower": 44,
        "crit": 5.42,
        "defense": 145,
        "dodge": 5.37,
        "expertise": 3,
        "fireDamage": 120,
        "frostDamage": 140,
        "healing": 120,
        "health": 1673,
        "holyDamage": 120,
        "intellect": 91,
        "mainHandSpeed": 2.8,
        "mana": 1677,
        "natureDamage": 120,
        "parry": 5,
        "rangedSpeed": 1.5,
        "shadowDamage": 120,
        "shadowResist": 5,
        "spellCrit": 3.87,
        "spellDamage": 120,
        "spellPen": 30,
        "spirit": 81,
        "stamina": 138,
        "strength": 27
    },
    "exportOptions": {
        "buffs": True,
        "talents": True
    }
    }
    
    url = f"http://{host}:{port}/character/gear"
    
    try:
        print(f"Testing Character Web Service at {url}")
        print("Sending character gear request...")
        
        response = requests.post(
            url, 
            json=test_data,
            headers={'Content-Type': 'application/json'}
        )
        
        print(f"Response Status: {response.status_code}")
        print(f"Response Headers: {dict(response.headers)}")
        
        try:
            response_json = response.json()
            print("Response Body:")
            print(json.dumps(response_json, indent=2))
            
            if response_json.get("success"):
                print("SUCCESS: Character gear updated successfully!")
            else:
                print("FAILED: Character gear update failed")
                if "error" in response_json:
                    print(f"Error: {response_json['error']}")
                    
        except json.JSONDecodeError:
            print("Response Body (raw):")
            print(response.text)
            
    except requests.exceptions.ConnectionError:
        print(f"CONNECTION ERROR: Could not connect to {host}:{port}")
        print("Make sure the worldserver is running with CharacterWebService.Enable = 1")
        
    except Exception as e:
        print(f"ERROR: {e}")

if __name__ == "__main__":
    host = sys.argv[1] if len(sys.argv) > 1 else "localhost"
    port = int(sys.argv[2]) if len(sys.argv) > 2 else 8080
    
    test_character_web_service(host, port)