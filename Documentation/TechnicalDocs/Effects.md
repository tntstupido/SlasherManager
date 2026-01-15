# Technical Documentation: Juice Effects

## Overview
This document covers the small feedback effects added for moment-to-moment impact:
- Screen shake on elimination
- Ink/blood splatter on elimination
- Screams label pulse on gain

## Screen Shake
**Location:** `src/Main.gd`
- Triggered in `_on_victim_eliminated`.
- Uses a short tween to offset `NotebookUI` position with random jitter.

## Ink/Blood Splatter
**Location:** `src/BloodSplatter.gd`, `scenes/BloodSplatter.tscn`
- Spawned per victim on elimination.
- Draws multiple red circles via `_draw()` and applies burst physics + gravity.

## Screams Pulse
**Location:** `src/Main.gd`
- Applied when `screams` increases.
- Scales `ScreamLabel` up/down with a short tween.
