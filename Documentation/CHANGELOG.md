# Slasher Manager - Changelog

## [v0.3.1] - 2026-01-11 - Typography & UI Polish Update

### Added - Font System Implementation
- **Typography System**
  - Integrated Patrick_Hand (handwritten) font for headers and titles
  - Integrated Special_Elite (typewriter) font for body text and numbers
  - Font assets available in `assets/fonts/` directory

- **Static UI Fonts (Main.tscn)**
  - Game Title: "SLASHER MANAGER" - Patrick_Hand, Size 48
  - Shop Label: "UPGRADES" - Patrick_Hand, Size 28
  - Map Label: "HUNT AREA (2/3)" - Patrick_Hand, Size 24
  - Screams Counter: Special_Elite, Size 42
  - DPS/Stats: Special_Elite, Size 24
  - Target Info: Name (Patrick_Hand, Size 24), Flavor (Special_Elite, Size 16)

- **Dynamic UI Fonts (Main.gd)**
  - Shop Item Titles: Patrick_Hand, Size 28
  - Shop Item Descriptions: Special_Elite, Size 18
  - Shop Item Costs: Special_Elite, Size 24

### Improved - Upgrade Cards Visuals
- **Background Enhancement**
  - Added semi-transparent background to upgrade info boxes using PanelContainer
  - Color: Semi-transparent aged paper (0.95, 0.93, 0.85, 0.95)
  - Corner radius: 3px for polished appearance
  - Improves text readability while maintaining "Ink & Paper" aesthetic

- **Text Contrast Improvements**
  - Darkened text colors for better readability:
    - Titles: Color(0, 0, 0.2) - dark navy blue
    - Descriptions: Color(0, 0, 0.1) - very dark blue, almost black
    - Costs: Color(0, 0, 0.15) - dark blue

### Fixed - Text Issues
- Corrected "Piano Wire" description typo
  - Changed from: "Elegant and silent"
  - Changed to: "Silent and efficient"

### Technical Notes
- Fonts set in Main.tscn for static elements (proper Godot approach)
- Fonts loaded dynamically in Main.gd for programmatically created elements
- PanelContainer used for backgrounds (prevents layout disruption)
- Maintains vintage newspaper/police report aesthetic per ArtGuide specifications

---

## [v0.3.0] - 2026-01-11 - Boss Fight Update

### Added - Phase 3: Boss Fight System
- **The Final Girl Boss Character**
  - New boss enemy that appears every 10 kills
  - 50 HP (much higher than regular victims: 2-15 HP)
  - 500 scream reward (10x regular victim rewards)
  - 1.5x larger visual size (600x600 vs 400x400)
  - Unique character art with battle-worn, determined appearance

- **Boss "Fight Back" Mechanic**
  - Boss attacks player every 3 seconds
  - Removes 50 screams per attack
  - Visual feedback: boss flashes red when attacking
  - Floating damage text shows "-50" in red

- **Boss Spawn System**
  - Kill counter tracks progress toward boss
  - Warning message "THE FINAL GIRL!" appears on boss spawn
  - Only one boss can be active at a time
  - Kill counter resets after boss is defeated

- **UI Enhancements**
  - Kill counter display: "Boss in: X kills"
  - "BOSS ACTIVE!" warning during boss fight
  - "BOSS DEFEATED!" celebration message
  - All messages integrated into DPS label area

### Visual Features
- Boss has red-ish color tint (Color 1.0, 0.9, 0.9)
- Boss flashes bright red during attacks
- Dramatic warning and victory messages
- Boss is visibly larger than regular victims

### Balance
- **Risk:** High HP + resource drain creates challenge
- **Reward:** 500 screams compensates for difficulty
- **Strategy:** Encourages active clicking vs. idle play
- **Progression:** Boss becomes easier as player upgrades click/auto damage

### Documentation
- Added `Documentation/TechnicalDocs/BossFight.md` - Complete technical documentation
- Updated `Documentation/Roadmap.md` - Marked Phase 3 boss fight as complete
- Updated `Documentation/ArtGuide.md` - Added Final Girl character specs and table

---

## [v0.2.0] - Previous Update - Economy & Shop

### Added - Phase 2: Economy and Shop
- Upgrade categorization (Weapon, Atmosphere, Utility)
- Visual shop with procedural "paper scrap" aesthetic
- Auto-damage system (Piano Wire upgrade)
- Exponential upgrade cost scaling

### Added - Phase 1: Core Mechanics
- UI Layout: "Notebook on desk" aesthetic
- Dynamic victim spawning with click interaction
- HP system with visual feedback
- Resource system (Screams currency)
- Multiple victim types with different HP values
- Floating damage text
- Red X elimination effects

---

## File Structure
```
SlahserManager/
├── assets/
│   └── Characters/
│       ├── final_girl.png (NEW)
│       ├── cheerleader.png
│       ├── jock.png
│       ├── GEEK.png
│       ├── influencer.png
│       └── tourist.png
├── scenes/
│   ├── VictimIcon.tscn (UPDATED - boss attack logic)
│   └── ...
├── src/
│   ├── Main.gd (UPDATED - boss spawn/tracking)
│   └── ...
└── Documentation/
    ├── Roadmap.md (UPDATED)
    ├── ArtGuide.md (UPDATED)
    ├── CHANGELOG.md (NEW)
    └── TechnicalDocs/
        └── BossFight.md (NEW)
```
