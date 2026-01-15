# Slasher Manager - Changelog

## [Unreleased] - Page Turn & Level UX Updates

### Added
- **Notebook Underlay**
  - New background layer beneath the page-turn animation to simulate a second page.
- **Level Name Label**
  - Dedicated label above the map showing current level name (e.g., "LEVEL 1: LAKE CAMP").
- **Level-specific Boss Pools**
  - `level_defs` now supports a `bosses` list per level (ready for unique bosses per map).
- **Suburbs Victim Set**
  - New SUBURBS victim archetypes (NEIGHBOR, MAILMAN, BABYSITTER, HOUSEWIFE, JOGGER, SOCCER_DAD).
- **Juice Effects**
  - Screen shake on elimination
  - Ink/blood splatter on elimination
  - Screams label pulse on gain

### Changed
- **Page Turn Animation**
  - Shader applied to the viewport so the full page (map + UI) animates as one layer.
  - Single-phase turn (no "return" phase) for a more realistic page flip.
  - Page turn direction updated to curl right-to-left (notebook-style).
- **Victim Spawning**
  - Spawn pool now uses `victims_unlocked` for the current level.
  - `difficulty_mult` scales HP and reward for regular victims and bosses.
- **Elimination Feedback**
  - Removed large red X overlay in favor of splatter-only feedback.

### Fixed
- **Map Visibility on Level Transition**
  - Restored map alpha after level swap to avoid blank/transparent maps.
- **Viewport Sizing Stability**
  - Reverted manual SubViewport resizing to prevent layout instability.

### Files Modified
- `src/Main.gd` - level spawn logic, difficulty scaling, level label, transition fixes
- `scenes/Main.tscn` - viewport wiring, notebook underlay, level name label
- `assets/page_turn.gdshader` - updated page-turn direction and curl shaping
- `src/BloodSplatter.gd`, `scenes/BloodSplatter.tscn` - splatter feedback
- `scenes/VictimIcon.tscn` - click tween changes + elimination signal updates
- `Documentation/TechnicalDocs/Effects.md` - juice effects overview

## [v0.4.0] - 2026-01-14 - Level System Implementation

### Added - Phase 3: Level Progression System
- **Two-Level Game World**
  - Level 1: LAKE CAMP (starting area)
  - Level 2: SUBURBS (unlocks after completing Level 1)
  - Dynamic map texture swapping between levels
  
- **Level Advancement System**
  - Boss defeat tracking (Level 1: 3 bosses, Level 2: 5 bosses)
  - Level transition automatically triggers when boss requirement is met
  - Boss counter resets on level advancement
  
- **Page Turn Animation**
  - Realistic page curl shader with shadow effects
  - Smooth fade transitions for map and notebook
  - Shader-driven visual effects (shadow movement, edge highlights)
  - Total animation time: ~2.6 seconds
  - F2 debug key for manual testing

- **New Level Features**
  - Level 2 difficulty scaling (1.2x multiplier)
  - New victim types unlocked in Level 2:
    - GEEK (4 HP, 20 screams)
    - INFLUENCER (8 HP, 40 screams)
  - Level 1: TOURIST, JOCK, CHEERLEADER (3 types)
  - Level 2: TOURIST, JOCK, CHEERLEADER, GEEK, INFLUENCER (5 types)

### Improved - UI Updates
- **Level Display**
  - Map label shows: "Level X: LEVEL_NAME (Y/Z bosses)"
  - Dynamic boss counter updates in real-time
  - Floating text announcement on level advancement: "LEVEL 2: SUBURBS!"

- **Victim Spawning**
  - Level-appropriate victim pools
  - Only unlocked victim types spawn in current level
  - Maintains balance while increasing variety

### Technical Implementation
- **Level Definition System**
  - `level_defs` dictionary with level data structure
  - Configurable: map texture, bosses required, difficulty, unlocked victims
  - Easy to extend for additional levels

- **Boss Tracking**
  - Unique boss ID system prevents duplicate processing
  - `processed_boss_elims` array tracks defeated bosses
  - Clean separation of victim elimination and level advancement logic

- **Animation System**
  - Custom page turn shader (GLSL fragment shader)
  - Tween-based sequential animation with parallel phases
  - Shader removal with smooth color transition
  - Comprehensive debug logging

### Files Added/Modified
- **New Files:**
  - `assets/page_turn.gdshader` - Page curl shader
  - `assets/Environment/suburban_map.png` - Level 2 map
  
- **Modified:**
  - `src/Main.gd` - Level system, animation, boss tracking
  - `scenes/Main.tscn` - NotebookTexture, MapTexture nodes
  
- **Documentation:**
  - `Documentation/Roadmap.md` - Updated with revision note
  - `Documentation/CHANGELOG.md` - This entry

### Known Issues
- Page turn animation works but needs future polish (marked in Roadmap)
- Shader removal timing functional but could be smoother

---

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
