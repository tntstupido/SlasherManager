# Slasher Manager

A dark comedy idle/clicker game where you play as a 1980s horror movie serial killer hunting annoying teenagers.

![Game Preview](assets/Environment/VisualConcept.png)

## 🎮 Game Concept

**Slasher Manager** is a unique idle/clicker game that combines horror aesthetics with dark humor and sarcasm. You play as an incompetent serial killer from 1980s horror films, trying to hunt down annoying modern teenagers who are too busy on their phones to notice you're trying to kill them.

### Core Gameplay Loop

1. **Hunt**: Click on victims on the map to damage them
2. **Collect**: Gather "Screams" as your primary currency
3. **Upgrade**: Buy sarcastic upgrades to improve your killing efficiency
4. **Survive**: Face "The Final Girl" - a boss who fights back every 10 kills

## 🎨 Visual Style

The game features a distinctive **"Ink & Paper"** aesthetic:
- Everything looks like sketches in a deranged killer's notebook
- Hand-drawn character portraits with navy blue ink on aged paper
- Vintage newspaper/police report feel for UI elements
- Bright RED used sparingly for blood and dramatic effects

## ✨ Current Features (v0.4.0)

### Level Progression System
- ✅ **Two-level game world** with unique environments:
  - **Level 1: LAKE CAMP** - Starting area, 3 bosses required
  - **Level 2: SUBURBS** - Unlocks after Level 1, 5 bosses required
  - Dynamic map texture swapping between levels
- ✅ **Level advancement** based on boss defeats
- ✅ **Page turn animation** with realistic shader effects
- ✅ **Level-appropriate victim spawning** (unlocks new victim types)
- ✅ **Difficulty scaling** (Level 2 has 1.2x difficulty multiplier)
- ✅ **Real-time boss counter** display on map

### Core Mechanics
- ✅ Dynamic victim spawning with click interactions
- ✅ Multiple victim types with different HP and rewards
- ✅ Visual HP feedback system
- ✅ Resource system (Screams currency)
- ✅ Floating damage text and elimination effects

### Economy & Shop
- ✅ Upgrade system with three categories:
  - **Weapons** (Rusty Knife) - Increase click damage
  - **Utility** (Piano Wire) - Add auto-damage per second
  - **Atmosphere** (Leather Gloves) - Boost resource gains
- ✅ Exponential upgrade cost scaling
- ✅ Procedural "paper scrap" shop aesthetic

### Boss System
- ✅ **"The Final Girl"** boss character
  - Appears every 10 kills
  - 50 HP with 500 scream reward
  - Fights back - removes 50 screams every 3 seconds
  - Larger visual size (1.5x regular victims)
- ✅ Warning and victory messages
- ✅ Strategic challenge balancing

### Typography & UI
- ✅ Implemented custom fonts:
  - **Patrick_Hand** - Handwritten headers and titles
  - **Special_Elite** - Typewriter body text and numbers
- ✅ Semi-transparent backgrounds for improved readability
- ✅ Professional "Ink & Paper" aesthetic throughout

## 🚀 Getting Started

### Requirements
- **Godot Engine 4.x** (download from https://godotengine.org)
- No external dependencies required

### Installation

1. Clone this repository:
```bash
git clone https://github.com/tntstupido/SlasherManager.git
cd SlahserManager
```

2. Open in Godot:
   - Launch Godot Engine
   - Click "Import" → Select the project folder
   - Click "Edit" to open the project

3. Run the game:
   - Press F5 in Godot Editor
   - Or click the "Play" button in the top-right corner

## 📖 Documentation

Comprehensive documentation is available in the `Documentation/` folder:

- **[CHANGELOG.md](Documentation/CHANGELOG.md)** - Version history and update notes
- **[Roadmap.md](Documentation/Roadmap.md)** - Development roadmap and progress tracking
- **[ArtGuide.md](Documentation/ArtGuide.md)** - Visual style guidelines and asset specifications
- **[TechnicalDocs/](Documentation/TechnicalDocs/)** - In-depth technical documentation:
  - [Boss Fight System](Documentation/TechnicalDocs/BossFight.md)

## 🗺️ Roadmap

### Phase 4: Polishing & "Juice" (In Progress)
- [ ] Audio design (sound effects, ambient music)
- [x] Typography system implementation ✅
- [ ] Visual effects (screen shake, particles, animations)
- [ ] Page-turning animations

### Phase 3: Progression & Content
- [x] Boss fight system ✅
- [ ] New levels (Suburbia, etc.)
- [ ] Unlockable content

### Phase 5: Prestige System (Planned)
- [ ] "The Sequel" soft reset mechanic
- [ ] Permanent bonuses
- [ ] "Directors Cut" special upgrades

## 🎯 Victim Types

| Character | HP | Reward | Description |
|-----------|----|----|-------------|
| Tourist | 2 | 10 | Just looking for the nearest gift shop |
| Geek | 4 | 20 | Trying to calculate the killer's DPS in real-time |
| Cheerleader | 5 | 25 | Too busy live-streaming to notice the chainsaw |
| Influencer | 8 | 40 | Actually wants to be killed for the views |
| Jock | 15 | 75 | Thinks the killer is just a very aggressive coach |
| **Final Girl** | **50** | **500** | **She's been through hell... and she's not going down easy.** |

## 🛠️ Technical Stack

- **Engine**: Godot 4.x
- **Language**: GDScript
- **Architecture**: Component-based with clear separation of concerns
- **UI System**: Godot's native Control nodes with custom theming

## 📝 Credits

- **Concept & Design**: Original horror-comedy idle game concept
- **Development**: Active development
- **Assets**: Custom hand-drawn character art

## 🤝 Contributing

This is a personal project, but feedback and suggestions are welcome!

## 📄 License

This project is for educational and entertainment purposes.

---

**Version**: v0.4.0  
**Last Updated**: January 14, 2026  
**Status**: Active Development
