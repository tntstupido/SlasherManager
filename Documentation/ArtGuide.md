# Slasher Manager - Art Guide

This document contains visual style guidelines, prompts, and technical specifications for art assets in "Slasher Manager".

## Core Visual Philosophy

The entire game is designed as a **"Ink & Paper / Hand-Drawn" aesthetic** - everything looks like it's from a deranged killer's spiral-bound notebook/journal. This style is perfect for:
- **Aesthetic of madness:** Looks like a diary of a madman or a bored bureaucrat doodling at work
- **Contrast:** Black and white drawings on yellowish paper with one additional color - bright RED (for blood, stamps, or crossing out)
- **Production efficiency:** No 3D models, textures, or complex animations needed - just static images (PNG)
- **Horror-sarcasm blend:** Raw and cynical look that fits the dark comedy theme

## Global Color Palette

- **Background:** Aged Paper (Yellowish-beige/parchment texture)
- **Primary Ink:** Deep Black (ballpoint pen) or Charcoal Grey (pencil) or Navy Blue
- **Accent Color (Critical):** **Vibrant RED** - used *only* for feedback (clicks), blood effects, and important notifications
- **UI Elements:** Semi-transparent yellowish tape for containers and borders

## Typography Specifications

- **Headers:** "Messy Handwriting" font (as if scrawled in a hurry)
- **Body Text:** "Typewriter" font (monospaced, looks like police reports or newspaper clippings)
- **Numbers:** Big, bold "Stamp" style or thick marker font
- **Implemented Fonts (v0.3.1):**
  - **Patrick_Hand** - Handwritten font for headers and titles
  - **Special_Elite** - Typewriter font for body text and numbers

### Font Usage Guide

**Static UI Elements (Main.tscn):**
- Game Title "SLASHER MANAGER": Patrick_Hand, Size 48
- Section Labels ("UPGRADES", "HUNT AREA"): Patrick_Hand, Size 24-28
- Resource Counters (Screams, DPS): Special_Elite, Size 24-42
- Target Info (Name/Flavor): Patrick_Hand (24) / Special_Elite (16)

**Dynamic Elements (Shop Items - Main.gd):**
- Item Titles: Patrick_Hand, Size 28
- Item Descriptions: Special_Elite, Size 18
- Item Costs: Special_Elite, Size 24

**Background Enhancements:**
- Upgrade info boxes use semi-transparent background (aged paper color)
- Corner radius: 3px for polished appearance
- Improves text readability while maintaining aesthetic

## Character Art Style

### General Specifications
- **Format:** Circular badge illustrations
- **Medium:** Ballpen drawing with thin lines in navy blue ink on creamy vintage paper
- **Technique:** Hand-drawn sketch aesthetic with crosshatching shading
- **Details:** Scattered ink splatters, dots, and small stars around circular border
- **Era:** Retro 1950s comic illustration style merged with 1980s horror movie aesthetic
- **Appearance:** Static portraits/doodles (not animated characters)
- **Character Types:** Victims should look like caricatures (stereotypical archetypes), while the Final Girl should be more realistic and determined

## Character Prompts

### Final Girl (Boss Character)

```
A circular ballpen drawing with thin lines in navy blue ink on creamy vintage paper of a determined Final Girl survivor character. The character is a young woman with messy, disheveled long hair falling around her face, intense wide eyes showing both fear and determination, dirt smudges on her face. She's wearing a torn tank top or casual clothing, gripping a makeshift weapon (baseball bat, broken bottle, or large kitchen knife) defensively across her chest. Her expression shows fierce determination and exhaustion - she's been through hell but won't give up. The artwork is rendered in navy blue ink linework on cream/beige aged paper background. Hand-drawn sketch aesthetic with heavy crosshatching shading to emphasize darkness and intensity. The circular composition includes more aggressive ink splatters, scratches, and distressed marks around the edges compared to other characters. Retro 1980s slasher movie poster illustration style, more dramatic and intense than the victim characters. Clean but bold linework, determined expression, survivalist energy. She should look tough, resourceful, and battle-worn but defiant.
```

**Usage Notes:**
- Combine this prompt with an image reference for best results
- The Final Girl should contrast with victim characters - more determined, resourceful, and ready to fight back
- Emphasize the battle-worn, defiant survivor archetype from 1980s slasher films

---

## UI Elements & Assets

### Shop Item Cards
Shop items should look like **newspaper clippings** or **note cards** held by scotch tape, featuring:
- **Wobbly Borders:** Hand-drawn lines with slight variations (procedurally generated)
- **Tape Strips:** Semi-transparent yellowish tape at corners with random angles
- **Icon:** Hand-drawn sketch of the item (weapons, tools, masks)
- **Flavor Text:** Prominent sarcastic descriptions

### Map & Environment Assets
The "Hunting Grounds" (left page) features:
- **Background:** Crudely drawn map sketch (top-down view) - should look like a child drew it or a schematic
- **Elements:** Lake, cabins, trees drawn in simple ink lines
- **Victim States:**
  - State 1 (Alive): Simple ink sketch of a face inside a circle
  - State 2 (Eliminated): Fat Red "X" or Red Ink Splat overlay

### Interactive Elements
- **Click Feedback:** Red "X" marks or ink splats
- **Floating Numbers:** Red text showing score/damage (e.g., "+10")
- **Particles:** Ink splatter effects for feedback
- **Animations:** Subtle "paper wobble" shader effect to make static images feel alive

### Technical Asset Requirements (for Godot)

**Backgrounds:**
- bg_wood_desk.png (Dark texture behind the book)
- bg_notebook_open.png (Main container)
- bg_map_camp.png (Location sketch)

**UI Elements:**
- ui_tape_strip.png (Semi-transparent yellow rectangle)
- ui_paper_scrap.png (9-patch rect for upgrade buttons)
- ui_red_x.png (Cross-out overlay)
- ui_ink_splat.png (Particle effect)

**Icons (Doodles):**
- icon_victim_[type].png (cheerleader, jock, nerd, influencer, tourist, geek)
- icon_weapon_[type].png (chainsaw, knife, etc.)
- icon_currency_scream.png

---

## Visual Effects ("The Juice")

To make the game feel premium, these effects are implemented:
1. **Screen Shake:** On victim elimination
2. **Number Pulse:** Resource counter scales up/down when increasing
3. **Paper Tilt:** Upgrade cards rotate slightly (-2 degrees) on hover
4. **Scribble Animation:** Pen circling effect when buying upgrades
5. **Parallax Mouse:** Notebook shifts 1-2 pixels opposite to mouse movement for depth
6. **Wobble Shader:** Subtle "living drawing" effect on static images

---

## Audio Design Notes

While not strictly visual, audio complements the ink & paper aesthetic:
- **Pen scratching paper** (click sounds)
- **Paper tearing/ripping** (page transitions)
- **Short screams/yells** (victim elimination)
- **Ambient sounds** (forest ambience, wind)

---

## Future Character Prompts
(To be added as new characters are developed)

### Existing Characters
- Cheerleader ✓
- Jock ✓
- Geek ✓
- Influencer ✓
- Tourist ✓
- Final Girl (Boss) ✓

### Character Specifications Summary

| Character | HP | Reward | Role | Special Notes |
|-----------|----|----|------|---------------|
| Tourist | 2 | 10 | Easy victim | Lowest HP, quick kill |
| Geek | 4 | 20 | Easy victim | Low HP |
| Cheerleader | 5 | 25 | Medium victim | Standard target |
| Influencer | 8 | 40 | Medium victim | Moderate HP |
| Jock | 15 | 75 | Tank victim | Highest regular HP |
| **Final Girl** | **50** | **500** | **Boss** | **Fights back, larger size** |
