Here is a comprehensive, developer-ready design document for the **User Interface (UI) Layout** of "Slasher Manager" (Concept 3).

This plan is tailored for the **"Ink & Paper / Hand-Drawn" aesthetic** and focuses on ease of implementation in engines like Godot.

# ---

**UI Design Document: "Slasher Manager"**

## **1\. Global Aesthetic & Philosophy**

* **Visual Metaphor:** The entire game takes place inside a **deranged killer’s spiral-bound notebook/journal**.  
* **Color Palette:**  
  * **Background:** Aged Paper (Yellowish-beige/parchment texture).  
  * **Ink:** Deep Black (ballpoint pen) or Charcoal Grey (pencil).  
  * **Accent (Crucial):** **Vibrant RED** (looks like marker, paint, or blood). Used *only* for feedback (clicks) and important notifications.  
  * **Tape/Glue:** Semi-transparent yellowish tape for UI containers.  
* **Typography:**  
  * **Headers:** "Messy Handwriting" font (as if scrawled in a hurry).  
  * **Body Text:** "Typewriter" font (monospaced, looks like police reports or newspaper clippings).  
  * **Numbers:** Big, bold "Stamp" style or thick marker font.

## ---

**2\. Screen Layout (The "Open Notebook" View)**

The screen is divided into two main panels, simulating an open book lying on a dark wooden desk.

### **A. The Header (Top Margin)**

*Located at the very top of the notebook pages.*

1. **Game Title:**  
   * Top Left. Text: "SLASHER MANAGER".  
   * Style: Black ink, underlined twice.  
2. **Primary Resource Counter:**  
   * Center. Text: **\[Icon: Screaming Mouth\] 1,204,500 Screams**.  
   * Animation: When this number increases, it should "pulse" or slightly scale up/down.  
3. **Passive Rate:**  
   * Below Resource. Text: *"+450 Screams/sec"*.  
   * Style: Smaller, typewriter font, perhaps in parenthesis.  
4. **Settings/Menu:**  
   * Top Right. Icon: A simple "Gear" drawn in ink, or a coffee stain that acts as a button.

### ---

**B. Left Page: The "Hunting Grounds" (Active Gameplay)**

*This is where the player clicks. It represents the planning stage of the murders.*

1. **Background Container:**  
   * A crudely drawn map sketch (top-down view).  
   * *visuals:* A lake, a few cabins, some trees. It should look like a child drew it, or a schematic.  
2. **The Targets (Clickable Entities):**  
   * **Appearance:** They are not animated characters. They are **Static Portraits/Doodles** drawn on the map.  
   * **Types:** "The Jock," "The Cheerleader," "The Nerd," "The Cop."  
   * **State 1 (Alive):** A simple ink sketch of a face inside a circle.  
   * **Action (Click):** The player clicks the face.  
   * **State 2 (Eliminated):** Instantly overlaid with a **Fat Red "X"** or a **Red Ink Splat**.  
   * **Feedback:**  
     * **Visual:** A floating text pops up: *"+10"* (in Red). The portrait shakes (screen shake on the node).  
     * **Audio:** A sound of a pen scratching paper aggressively \+ a short, underwhelming "yell."  
3. **Respawn Mechanic:**  
   * After all targets on the map are "crossed out," a hand animation (or just a fade) wipes the page clean, and new targets appear.

### ---

**C. Right Page: The "Toolkit" (Upgrades & Shop)**

*This page looks like a scrapbook. It is filled with "clippings" taped to the paper.*

**Layout Structure:** A ScrollContainer (vertical scroll) containing a list of HBox or Panel items.

#### **Item Card Design (The Upgrade Button)**

Each upgrade is a rectangular panel that looks like a **Newspaper Clipping** or a **Note Card** held by scotch tape.

1. **Icon (Left):**  
   * Hand-drawn sketch of the item (e.g., a rusty knife, a chainsaw, a hockey mask).  
2. **Title (Top):**  
   * Example: *"Rusty Spoon"* or *"Chainsaw Model 3000"*.  
3. **Flavor Text (Middle \- THE SARCASM):**  
   * *Must be prominent.*  
   * Example: *"It's dull, it's dirty, and it gives them tetanus. Highly inefficient, but very scary."*  
4. **Effect (Bottom Left):**  
   * *"+5 Screams per click"* or *"+10 Screams/sec"*.  
5. **Cost & Buy Button (Right):**  
   * A distinct button drawn in the corner of the card.  
   * Text: *"BUY (500 Screams)"*.  
   * **State:** If the player can't afford it, the text is greyed out/scribbled over.

### ---

**D. Navigation Tabs (Bookmarks)**

*Sticking out from the right side or bottom of the notebook.*

1. **Tab 1 (Red):** **"Hunt"** (The main view described above).  
2. **Tab 2 (Blue):** **"Minions"** (Automation).  
   * Flavor: Hiring other slashers, lawyers, or clean-up crews.  
3. **Tab 3 (Black):** **"Dark Rituals"** (Prestige System).  
   * Reset progress for permanent multipliers. Visuals: Latin text, pentagram doodles.

## ---

**3\. Technical Asset List (For Godot)**

To build this, you will need to create (or generate) the following 2D assets:

**Backgrounds:**

* bg\_wood\_desk.png (Dark texture behind the book).  
* bg\_notebook\_open.png (The main container, tileable or large texture).  
* bg\_map\_camp.png (The sketch of the location).

**UI Elements:**

* ui\_tape\_strip.png (Semi-transparent yellow rectangle).  
* ui\_paper\_scrap.png (9-patch rect for upgrade buttons).  
* ui\_red\_x.png (The cross-out overlay).  
* ui\_ink\_splat.png (Particle effect).

**Icons (Doodles):**

* icon\_victim\_cheerleader.png, icon\_victim\_nerd.png, etc.  
* icon\_weapon\_chainsaw.png, icon\_weapon\_knife.png.  
* icon\_currency\_scream.png.

**Fonts:**

* font\_handwritten.ttf  
* font\_typewriter.ttf

## ---

**4\. "The Juice" (Polishing the UI)**

To make the game feel premium, add these subtle details:

1. **Parallax Mouse Movement:** When the player moves the mouse, the notebook should shift slightly (1-2 pixels) in the opposite direction. It gives depth.  
2. **Paper Physics:** When hovering over an upgrade card, it should rotate slightly (e.g., \-2 degrees), as if the paper is loose.  
3. **Scribble Particles:** When buying an upgrade, don't just deduct money. Play an animation of a pen **circling** the item, indicating it has been acquired.

Does this detailed plan give you a clear roadmap to start building in Godot?