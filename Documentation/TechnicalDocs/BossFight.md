# Technical Documentation: Boss Fight System

## Overview
The Boss Fight system implements challenging encounters with level-specific bosses that appear periodically and fight back against the player.

## Core Components

### 1. Boss Definition (Main.gd)
Located in `victim_defs` dictionary. Boss pools are defined per level in `level_defs["bosses"]`.

```gdscript
"THE RANGER": {
    "hp": 55.0,
    "reward": 520.0,
    "icon": "res://assets/Characters/the_ranger_boss.png",
    "flavor": "Knows every trail. Doesn't miss a single step.",
    "is_boss": true
}
```

**Stats:**
- **HP/Reward:** Vary per boss and are scaled by level difficulty multiplier
- **Special Flag:** `is_boss: true` identifies this as a boss enemy

### 2. Boss Tracking Variables

```gdscript
var kills_count: int = 0              # Tracks total kills
var kills_until_boss: int = 10        # Boss spawns every 10 kills
var boss_active: bool = false         # Prevents multiple bosses
```

### 3. Boss Spawn Logic (spawn_victim function)

**Spawn Trigger:**
```gdscript
if kills_count >= kills_until_boss and not boss_active:
    type_name = boss_pool[randi() % boss_pool.size()]
    boss_active = true
    spawn_floating_text("BOSS: %s!" % type_name, Vector2(map_area.size.x / 2, 100), Color(1, 0, 0))
```

**Visual Modifications:**
```gdscript
victim.custom_minimum_size = Vector2(600, 600)  # 1.5x larger than regular (400x400)
victim.pivot_offset = Vector2(300, 300)         # Centered pivot for larger size
victim.modulate = Color(1.0, 0.9, 0.9)         # Slight red tint
victim.set_meta("is_boss", true)                # Flag for special behavior
```

### 4. Boss "Fight Back" Mechanic (VictimIcon.tscn)

**Attack Timer System:**
```gdscript
var boss_attack_timer: float = 0.0
var boss_attack_interval: float = 3.0   # Attacks every 3 seconds
var boss_attack_damage: float = 50.0    # Removes 50 screams per attack
```

**Process Function:**
```gdscript
func _process(delta):
    if has_meta("is_boss") and not is_eliminated:
        boss_attack_timer += delta
        if boss_attack_timer >= boss_attack_interval:
            boss_attack_timer = 0.0
            boss_attacks.emit(boss_attack_damage)
            # Visual feedback: flash red
            var tween = create_tween()
            tween.tween_property(self, "modulate", Color(1.5, 0.5, 0.5), 0.1)
            tween.tween_property(self, "modulate", Color(1.0, 0.9, 0.9), 0.1)
```

### 5. Boss Attack Handler (Main.gd)

```gdscript
func _on_boss_attacks(damage):
    screams = max(0, screams - damage)  # Prevent negative screams
    spawn_floating_text("-%.0f" % damage, Vector2(map_area.size.x / 2, map_area.size.y / 2), Color(1, 0.3, 0.3))
    update_ui()
```

### 6. Boss Elimination Logic

**On Elimination:**
```gdscript
if eliminated_was_boss:
    boss_active = false
    kills_count = 0  # Reset counter for next boss cycle
    spawn_floating_text("BOSS DEFEATED!", Vector2(map_area.size.x / 2, 150), Color(1, 0.8, 0))
```

### 7. UI Integration

**Kill Counter Display:**
```gdscript
var kills_remaining = kills_until_boss - kills_count
var dps_text = "DPS: %.1f" % auto_damage

if not boss_active and kills_remaining > 0:
    dps_text += " | Boss in: %d kills" % kills_remaining
elif boss_active:
    dps_text += " | BOSS ACTIVE!"
```

## Visual Feedback System

### Boss Spawn
- **Warning Message:** "THE FINAL GIRL!" in red at top of map
- **Size:** 600x600 (1.5x regular victim size)
- **Color Tint:** Red-ish modulation (1.0, 0.9, 0.9)

### Boss Attacking
- **Color Flash:** Bright red (1.5, 0.5, 0.5) → pink (1.0, 0.9, 0.9)
- **Duration:** 0.2 seconds (0.1s flash + 0.1s return)
- **Floating Text:** "-50" in red at center of map

### Boss Defeated
- **Message:** "BOSS DEFEATED!" in yellow-orange at top of map
- **Reward:** "+500" in red
- **Counter Reset:** Kill tracker returns to 0

## Balance Considerations

### Risk vs. Reward
- **High HP:** Requires sustained clicking or high DPS upgrades
- **Resource Drain:** -50 screams every 3 seconds = -16.67 screams/sec
- **High Reward:** Reward varies by boss and level difficulty
- **Cycle Reset:** Kill counter resets, creating predictable intervals

### Difficulty Scaling
The boss becomes easier as player progresses:
- **Click Damage** upgrades reduce time-to-kill
- **Auto Damage** allows passive damage while clicking
- Faster kill = less resource drain from attacks

### Strategic Implications
- Players must balance spending screams on upgrades vs. saving for boss drain
- Boss creates natural "checkpoint" moments in gameplay
- Encourages active clicking (can't idle through boss fight)

## Tuning Parameters

Easily adjustable values for game balance:

| Parameter | Location | Default | Effect |
|-----------|----------|---------|--------|
| `kills_until_boss` | Main.gd:10 | 10 | How often boss spawns |
| Boss HP | Main.gd:46 | 50.0 | Boss durability |
| Boss Reward | Main.gd:47 | 500.0 | Screams gained on defeat |
| `boss_attack_interval` | VictimIcon.tscn:19 | 3.0 | Time between attacks |
| `boss_attack_damage` | VictimIcon.tscn:20 | 50.0 | Screams lost per attack |
| Boss Size | Main.gd:302 | 600x600 | Visual size (400 = normal) |

## Future Enhancements

Potential improvements to the boss system:

1. **Multiple Boss Types:** Different bosses with unique mechanics
2. **Boss Phases:** Boss behavior changes at HP thresholds
3. **Screen Shake:** Add camera shake on boss attacks
4. **Sound Effects:** Special audio for boss spawn/attack/defeat
5. **Boss Abilities:** Random attack patterns or special moves
6. **Scaling Difficulty:** Boss HP/damage increases with player progression
7. **Boss Loot:** Chance to drop special upgrades or bonuses
8. **Boss Announcements:** More dramatic introduction animations

## Related Files

- `src/Main.gd` - Boss spawn logic and tracking (lines 8-11, 40-51, 267-343)
- `scenes/VictimIcon.tscn` - Boss attack behavior (lines 17-20, 88-98)
- `assets/Characters/final_girl.png` - Boss character art
- `Documentation/ArtGuide.md` - Boss character visual specifications
