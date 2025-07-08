# Architecture and Structure of AzerothCore Project

This document provides an overview of the architecture and structure of the AzerothCore project, an open-source World of Warcraft (WoW) server emulator for version 3.3.5a (Wrath of the Lich King).

## Overview

AzerothCore is a modular project designed to emulate the functionality of a WoW server. It is structured with several main components that interact to recreate the gaming experience.

## Directory Structure

The project is organized according to the following hierarchy:

```
azerothcore-wotlk/
├── apps/            # Main applications (worldserver, authserver)
├── bin/             # Compiled binary files
├── conf/            # Configuration files
├── data/            # Game data
├── deps/            # External dependencies
├── doc/             # Documentation
├── modules/         # Custom modules
├── src/             # Source code
│   ├── cmake/       # CMake scripts for compilation
│   ├── common/      # Code common to several components
│   ├── genrev/      # Revision generation
│   ├── server/      # Main server code
│   │   ├── apps/    # Server applications
│   │   ├── database/# Database management
│   │   ├── game/    # Game logic
│   │   ├── scripts/ # Game scripts
│   │   └── shared/  # Code shared between server components
│   ├── test/        # Unit tests
│   └── tools/       # Development tools
└── var/             # Variable data
```

## System Architecture

AzerothCore follows a modular architecture with several interconnected subsystems:

### 1. Core Systems

The core of the project consists of several fundamental systems:

#### World System

Manages the global state of the game server, including:
- Configuration
- In-game time and weather
- Main update loop

The World System is responsible for the update cycle that processes all game actions and events at each server tick.

#### Entity System

Forming the backbone of all objects in the game world, it follows a hierarchical design where all entities inherit from a base `Object` class.

Object hierarchy:
```
Object
├── WorldObject (objects with position in the world)
│   ├── Unit (living entities)
│   │   ├── Player (player characters)
│   │   └── Creature (creatures/NPCs)
│   │       ├── Pet (pets)
│   │       └── TempSummon (temporary summons)
│   ├── GameObject (interactive objects)
│   └── Corpse (corpses)
```

Each entity type has specific functionalities:
- **Object**: GUID, update masks, values
- **WorldObject**: Coordinates, map reference, visibility
- **Unit**: Health, statistics, combat abilities, movement
- **Player**: Inventory, skills, quests, chat, groups
- **Creature**: AI, loot tables, spawn data, vendor information
- **GameObject**: Traps, doors, chests, transport objects

#### Map System

Maps represent different game areas and are divided into grids for efficient processing:

- **Maps** (Continents, Instances, Battlegrounds)
  - Divided into **Grids** (8x8 grids)
    - Containing **Cells** (8x8 cells per grid)
      - Containing **Objects** (game objects and creatures)

Map types:
- **Regular Maps**: Normal maps (continents)
- **Instance Maps**: Dungeons and raids
- **Battleground Maps**: Battlegrounds

### 2. Spell System

Manages all spells, abilities, and magical effects in the game:

- **SpellMgr**: Manages spell information
  - **SpellInfo**: Definition of a spell
    - Creates instances of **Spell**: Active spell
    - Creates **Aura**: Persistent effect
      - Contains **AuraEffect**: Specific aura effects

Spell execution flow:
1. A player/creature casts a spell
2. The spell validates the target and conditions
3. The spell calculates the cost and consumes resources
4. The spell applies effects on targets
5. The spell applies auras if necessary
6. The spell triggers secondary effects and spells

### 3. AI Systems

AzerothCore offers several AI systems for different purposes:

```
CreatureAI
├── UnitAI
│   ├── ScriptedAI
│   │   └── BossAI
│   │       └── InstanceBossAI
│   ├── PetAI
│   └── GuardAI
└── SmartAI
```

#### SmartAI System

A data-driven AI system that allows defining creature and object behavior through database entries without writing C++ code.

The system uses an event-action-target approach:
- **Events**: Triggers (SMART_EVENT_*)
- **Actions**: Actions to execute (SMART_ACTION_*)
- **Targets**: Targets of actions (SMART_TARGET_*)

### 4. Scripting System

Allows extending and customizing game behavior through C++ code:

| Script Type | Function | Examples |
|-------------|----------|----------|
| WorldScript | Server-wide events | Startup, shutdown, configuration |
| PlayerScript | Player events | Level up, skills, chat |
| CreatureScript | Creature behavior | Custom AI, dialogue |
| GameObjectScript | Object behavior | Custom interactions |
| InstanceScript | Instance behavior | Boss encounters, events |
| SpellScriptLoader | Spell behavior | Modified spells, auras |
| CommandScript | Chat commands | GM commands |

### 5. Network System

The network layer handles communication between the client and server using a packet-based protocol:

1. Client sends a packet to WorldSocket
2. WorldSocket queues the packet for WorldSession
3. WorldSession processes the packet via HandlePacket
4. HandlePacket updates the game state
5. Game objects generate a response
6. WorldSession sends the response to WorldSocket
7. WorldSocket transmits the response to the client

### 6. Database System

AzerothCore uses a multi-database approach to store different types of game data:

| Database | Function | Main Tables |
|----------|---------|-------------|
| Auth | Authentication | account, account_access, realmlist |
| Characters | Player data | characters, item_instance, guild |
| World | Game content | creature_template, gameobject_template, quest_template |
| Hotfixes | Dynamic updates | Various hotfix tables |

## Functional Modules

AzerothCore is divided into several functional modules in the `src/server/game` directory:

- **AI**: Artificial intelligence for creatures and objects
- **Accounts**: User account management
- **Achievements**: Achievement system
- **AuctionHouse**: Auction house
- **Battlefield**: Battlefield system
- **Battlegrounds**: Instanced battlegrounds
- **Chat**: Communication system
- **Combat**: Combat mechanics
- **Entities**: Entity definitions (players, creatures, objects)
- **Globals**: Global variables and managers
- **Grids**: Grid system for maps
- **Groups**: Player group system
- **Guilds**: Guild system
- **Handlers**: Network packet handlers
- **Instances**: Dungeon instance management
- **Loot**: Loot system
- **Mails**: Mail system
- **Maps**: World map management
- **Movement**: Movement system
- **Quests**: Quest system
- **Scripting**: Scripting system
- **Spells**: Spell and ability system
- **World**: Game world management

## Module System

AzerothCore offers a module system that allows adding or modifying functionality without touching the core code. These modules are located in the `modules/` directory and are loaded dynamically when the server starts.

## Configuration

Server configuration is managed through files in the `conf/` directory, with main categories:

- **Server Settings**: Core server functionality
- **Database**: Database connection information
- **Game Settings**: Gameplay mechanics
- **Player Settings**: Character options
- **Creature Settings**: NPC behavior
- **Chat Settings**: Communication
- **Performance**: Optimization
- **Custom**: Server-specific features

## System Interactions

AzerothCore systems are designed to work together through well-defined interfaces:

- **World** executes the main update loop on **Maps**
- **Maps** contain **Units** (Players/Creatures) and **GameObjects**
- **Units** use the **Spell System** and **Combat System**
- **Units** are controlled by the **AI System**
- **Spell System** applies effects via the **Aura System**
- **World** manages the **Database Cache** and **Network System**
- **Script System** integrates with all other systems

## Conclusion

AzerothCore provides a robust and extensible foundation for World of Warcraft server emulation. Its modular design allows for customization at various levels, from configuration settings to scripted extensions. The various systems - World, Entity, Map, Spell, AI, and Network - work together to create a complete game server implementation.
