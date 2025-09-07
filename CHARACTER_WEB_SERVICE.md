# AzerothCore Character Web Service

This module adds HTTP web service functionality to AzerothCore worldserver that allows external applications to modify character equipment, enchantments, level, class, and race via JSON API calls.

## Features

- **HTTP REST API** for character gear and configuration management
- **JSON payload support** for equipment, enchantment, and character configuration changes
- **Character configuration updates** including level, class, and race
- **Offline character updates** for players who are not currently online
- **Configurable port and enable/disable options**
- **Safe item replacement** with automatic cleanup
- **Enchantment application** support

## Configuration

Add the following settings to your `worldserver.conf`:

```ini
# Enable HTTP web service for character gear management
CharacterWebService.Enable = 1

# Port for the character web service (default: 8080)
CharacterWebService.Port = 8080
```

## API Endpoint

**POST** `/character/gear`

Accepts JSON payload to update character equipment, enchantments, level, class, and race.

### Request Format

```json
{
    "name": "ConfigurationName",
    "phase": 1,
    "character": {
        "name": "CharacterName",
        "level": 19,
        "gameClass": "DRUID",
        "race": "NIGHTELF", 
        "faction": "ALLIANCE"
    },
    "items": [
        {
            "name": "Item Display Name",
            "id": 19972,
            "slot": "HEAD",
            "enchant": {
                "name": "Enchantment Name",
                "id": 1503,
                "itemId": 11642,
                "spellId": 27950
            }
        }
    ]
}
```

### Character Configuration

The `character` object supports:
- `name`: Character name (string)
- `level`: Character level 1-80 (number)
- `gameClass`: Character class (string)
- `race`: Character race (string)
- `faction`: Alliance/Horde (informational, not used for updates)

**Supported Classes:**
- `WARRIOR`, `PALADIN`, `HUNTER`, `ROGUE`, `PRIEST`
- `DEATH_KNIGHT`, `SHAMAN`, `MAGE`, `WARLOCK`, `DRUID`

**Supported Races:**
- `HUMAN`, `DWARF`, `NIGHTELF`, `GNOME`, `DRAENEI` (Alliance)
- `ORC`, `UNDEAD`, `TAUREN`, `TROLL`, `BLOODELF` (Horde)

### Equipment Slots

Supported slot names:
- `HEAD`
- `NECK` 
- `SHOULDERS`
- `CHEST`
- `WAIST`
- `LEGS`
- `FEET`
- `WRISTS`
- `HANDS`
- `FINGER_1`, `FINGER_2`
- `TRINKET_1`, `TRINKET_2`
- `BACK`
- `MAIN_HAND`
- `OFF_HAND`
- `RANGED`

### Response Format

Success response:
```json
{
    "success": true,
    "character": "CharacterName",
    "itemsApplied": 16,
    "message": "Character configuration and gear updated successfully"
}
```

Error response:
```json
{
    "success": false,
    "error": "Character 'CharacterName' must be offline for gear changes"
}
```

## Usage Examples

### Using curl

```bash
curl -X POST http://localhost:8080/character/gear \
  -H "Content-Type: application/json" \
  -d @character_gear.json
```

### Using Python

```python
import requests
import json

url = "http://localhost:8080/character/gear"
data = {
    "character": {"name": "TestChar"},
    "items": [{"id": 19972, "slot": "HEAD"}]
}

response = requests.post(url, json=data)
print(response.json())
```

## Testing

A test script is provided: `test_character_web_service.py`

```bash
python test_character_web_service.py localhost 8080
```

## Requirements

- Character must be **offline** for gear changes
- Character must **not be in a battleground**
- Valid item IDs from the database
- Valid enchantment IDs from SpellItemEnchantment DBC

## Implementation Details

### Files Added

- `src/server/game/Server/CharacterWebService.h`
- `src/server/game/Server/CharacterWebService.cpp`
- Integration in `src/server/apps/worldserver/Main.cpp`
- Configuration in `worldserver.conf.dist`

### Dependencies

- Boost.Asio for networking
- Boost.Beast for HTTP handling
- Standard C++ regex for JSON parsing

### Security Considerations

- **No authentication** - restrict network access appropriately
- **CORS enabled** - allows cross-origin requests
- **Character validation** - only online characters can be modified
- **Item validation** - validates item and enchantment IDs

## Troubleshooting

### Service won't start
- Check that the port is not in use
- Verify `CharacterWebService.Enable = 1` in config
- Check worldserver logs for error messages

### Character not found
- Ensure the character exists in the database
- Character must be **logged out/offline**  
- Check exact character name spelling
- Character names are case-sensitive

### Character online error
- Character must log out completely before gear changes
- Wait a few seconds after logout to ensure character is fully offline

### Items not applying
- Verify item IDs exist in item_template database
- Check that enchantment IDs are valid
- Review worldserver logs for specific errors

## Future Enhancements

- Authentication system
- Batch character updates
- Talent and glyph support
- Consumable and buff application
- Character stat validation
- Rollback/undo functionality