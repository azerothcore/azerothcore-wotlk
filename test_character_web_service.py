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
        "name": "H",
        "phase": 1,
        "character": {
            "name": "Thirk",
            "level": 19,
            "gameClass": "DRUID",
            "race": "NIGHTELF",
            "faction": "ALLIANCE"
        },
        "items": [
            {
                "name": "Lucky Fishing Hat",
                "id": 19972,
                "enchant": {
                    "name": "Lesser Arcanum of Constitution",
                    "id": 1503,
                    "itemId": 11642
                },
                "slot": "HEAD"
            },
            {
                "name": "Thick Bronze Necklace",
                "id": 21933,
                "slot": "NECK"
            },
            {
                "name": "Talbar Mantle",
                "id": 10657,
                "enchant": {
                    "name": "Resilience of the Scourge",
                    "id": 2715,
                    "itemId": 23547
                },
                "slot": "SHOULDERS"
            },
            {
                "name": "Robe of the Moccasin",
                "id": 6465,
                "enchant": {
                    "name": "Enchant Chest - Exceptional Health",
                    "id": 2659,
                    "spellId": 27957
                },
                "slot": "CHEST"
            },
            {
                "name": "Keller's Girdle",
                "id": 2911,
                "slot": "WAIST"
            },
            {
                "name": "Darkweave Breeches",
                "id": 12987,
                "enchant": {
                    "name": "Golden Spellthread",
                    "id": 2746,
                    "itemId": 24276
                },
                "slot": "LEGS"
            },
            {
                "name": "Footpads of the Fang",
                "id": 10411,
                "enchant": {
                    "name": "Enchant Boots - Fortitude",
                    "id": 2649,
                    "spellId": 27950
                },
                "slot": "FEET"
            },
            {
                "name": "Mindthrust Bracers",
                "id": 1974,
                "enchant": {
                    "name": "Enchant Bracer - Superior Healing",
                    "id": 2650,
                    "spellId": 27911
                },
                "slot": "WRISTS"
            },
            {
                "name": "Serpent Gloves",
                "id": 5970,
                "enchant": {
                    "name": "Enchant Gloves - Major Healing",
                    "id": 2322,
                    "spellId": 33999
                },
                "slot": "HANDS"
            },
            {
                "name": "Seal of Sylvanas",
                "id": 6414,
                "enchant": {
                    "name": "Enchant Ring - Healing Power",
                    "id": 2930,
                    "spellId": 27926
                },
                "slot": "FINGER_1"
            },
            {
                "name": "Blood Ring",
                "id": 4998,
                "enchant": {
                    "name": "Enchant Ring - Healing Power",
                    "id": 2930,
                    "spellId": 27926
                },
                "slot": "FINGER_2"
            },
            {
                "name": "Arena Grand Master",
                "id": 19024,
                "slot": "TRINKET_1"
            },
            {
                "name": "Hook of the Master Angler",
                "id": 19979,
                "slot": "TRINKET_2"
            },
            {
                "name": "Caretaker's Cape",
                "id": 20428,
                "slot": "BACK"
            },
            {
                "name": "Devout Aurastone Hammer",
                "id": 42948,
                "enchant": {
                    "name": "Enchant Weapon - Major Healing",
                    "id": 3846,
                    "spellId": 34010
                },
                "slot": "MAIN_HAND"
            },
            {
                "name": "Furbolg Medicine Pouch",
                "id": 16768,
                "slot": "OFF_HAND"
            }
        ],
        "consumables": [],
        "buffs": [],
        "talents": [],
        "glyphs": [],
        "points": [
            {
                "name": "Balance",
                "stats": {
                    "spellDamage": 1,
                    "arcaneDamage": 1,
                    "critRating": 0.7,
                    "hasteRating": 0.7,
                    "hitRating": 1.2,
                    "intellect": 0.41,
                    "spirit": 0.34,
                    "metaSockets": 164,
                    "redSockets": 19,
                    "yellowSockets": 19,
                    "blueSockets": 19,
                    "prismaticSockets": 19
                }
            }
        ],
        "stats": {
            "agility": 35,
            "arcaneDamage": 183,
            "armor": 339,
            "attackPower": 44,
            "crit": 10.24,
            "defense": 95,
            "dodge": 10.41,
            "fireDamage": 183,
            "frostDamage": 183,
            "healing": 183,
            "health": 1773,
            "holyDamage": 183,
            "intellect": 82,
            "mainHandSpeed": 2.7,
            "mana": 1279,
            "mp5": 6,
            "natureDamage": 183,
            "parry": 5,
            "shadowDamage": 183,
            "spellCrit": 6.46,
            "spellDamage": 183,
            "spirit": 59,
            "stamina": 147,
            "strength": 32
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