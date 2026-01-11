# Technical Documentation: Shop Item Visuals (Ink & Paper)

## Overview
The shop item UI is generated procedurally to mimic a hand-drawn, scrapbook aesthetic. This avoids static textures and allows for dynamic resizing and random variations.

## Core Component: `ShopItemButton.gd`
This script extends `Button` and handles all custom drawing.

### Procedural Generation Features
1.  **Wobbly Borders:**
    - Uses `randf_range` to offset points along the border lines.
    - Draws multiple lines (outer + inner) to simulate sketched ink.
2.  **Tape Strips:**
    - Drawn as filled polygons with `draw_polyline` outlines.
    - Located at random corners with random angles.
    - "Super-sized" (80x32) to look like duct tape.
3.  **Transparency:**
    - `paper_color` is set to `Color.TRANSPARENT`.
    - `StyleBox` for disabled state is overridden to be transparent.

### Responsive Layout System
- **Dynamic Height:**
    - Calculates image container height based on the loaded texture's aspect ratio (`width / aspect_ratio`).
    - Ensures 100% of the image is visible without cropping.
- **Inset Margins:**
    - Uses `draw_inset` (12px) to draw content inside the control bounds.
    - Prevents "overhanging" tape from being clipped by the parent scroll container.
- **Text Sizing:**
    - Queries `target_text_container.get_combined_minimum_size().y` to shrink the button height to fit the text exactly.

## Integration in `Main.gd`
- `create_shop_item` instantiates `ShopItemButton`.
- Lays out the card vertically: `Image -> Margin -> Title -> Description -> Cost`.
- Passes references (`target_icon_container`, `target_text_container`) to the button so it can control their sizes.

## Fonts
- **Title:** Handwritten font (Size 28, centered).
- **Description:** Typewriter font (Size 18, centered).
