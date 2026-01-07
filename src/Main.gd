extends Control

# Resources
var screams: float = 0.0
var click_damage: float = 1.0
var auto_damage: float = 0.0

# Victim Types (HP, Reward, Portrait, Flavor)
var victim_defs = {
	"TOURIST": {
		"hp": 2.0,
		"reward": 10.0,
		"icon": "res://assets/Characters/tourist.png",
		"flavor": "Just looking for the nearest gift shop."
	},
	"JOCK": {
		"hp": 15.0,
		"reward": 75.0,
		"icon": "res://assets/Characters/jock.png",
		"flavor": "Thinks the killer is just a very aggressive coach."
	},
	"CHEERLEADER": {
		"hp": 5.0,
		"reward": 25.0,
		"icon": "res://assets/Characters/cheerleader.png",
		"flavor": "Too busy live-streaming to notice the chainsaw."
	},
	"GEEK": {
		"hp": 4.0,
		"reward": 20.0,
		"icon": "res://assets/Characters/GEEK.png",
		"flavor": "Trying to calculate the killer's DPS in real-time."
	},
	"INFLUENCER": {
		"hp": 8.0,
		"reward": 40.0,
		"icon": "res://assets/Characters/influencer.png",
		"flavor": "Actually wants to be killed for the views."
	}
}

# Shop Data
var upgrade_defs = {
	"weapon": {
		"title": "Rusty Knife",
		"desc": "A jagged piece of history. Increases Click Damage.",
		"base_cost": 10.0,
		"cost_mult": 1.5,
		"level": 1,
		"icon": "res://assets/Upgrades/knife.png"
	},
	"utility": {
		"title": "Piano Wire",
		"desc": "Elegant and silent. Adds Auto Damage per second.",
		"base_cost": 50.0,
		"cost_mult": 1.4,
		"level": 0,
		"icon": "res://assets/Upgrades/wire.png"
	},
	"gloves": {
		"title": "Leather Gloves",
		"desc": "Better grip, more screams. Multiplies resource gain.",
		"base_cost": 200.0,
		"cost_mult": 1.6,
		"level": 0,
		"icon": "res://assets/Upgrades/gloves.png"
	}
}

# UI reference
@onready var scream_label = $NotebookUI/NotebookBase/ContentMargin/VBox/TopMargin/ResourceDisplay/ScreamLabel
@onready var sps_label = $NotebookUI/NotebookBase/ContentMargin/VBox/TopMargin/ResourceDisplay/SPS
@onready var map_area = $NotebookUI/NotebookBase/ContentMargin/VBox/PageSplit/LeftPage/MapArea
@onready var upgrade_list = $NotebookUI/NotebookBase/ContentMargin/VBox/PageSplit/RightPage/UpgradeScroll/UpgradeList
@onready var shop_label = $NotebookUI/NotebookBase/ContentMargin/VBox/PageSplit/RightPage/ShopLabel

# Target Info UI
@onready var target_info_bar = $NotebookUI/NotebookBase/ContentMargin/VBox/PageSplit/LeftPage/MapArea/TargetInfoBar
@onready var target_name_label = $NotebookUI/NotebookBase/ContentMargin/VBox/PageSplit/LeftPage/MapArea/TargetInfoBar/VBox/NameLabel
@onready var target_flavor_label = $NotebookUI/NotebookBase/ContentMargin/VBox/PageSplit/LeftPage/MapArea/TargetInfoBar/VBox/FlavorLabel
@onready var target_hp_bar = $NotebookUI/NotebookBase/ContentMargin/VBox/PageSplit/LeftPage/MapArea/TargetInfoBar/VBox/HPBar

# Scene references
var victim_scene = preload("res://scenes/VictimIcon.tscn")
var floating_text_scene = preload("res://scenes/FloatingText.tscn")
var red_x_scene = preload("res://scenes/RedX.tscn")

# Font references
var font_handwritten = load("res://assets/fonts/Patrick_Hand/PatrickHand-Regular.ttf")
var font_typewriter = load("res://assets/fonts/Special_Elite/SpecialElite-Regular.ttf")
var ShopItemButton = load("res://src/ShopItemButton.gd")

var shop_nodes = {}

func _ready():
	# Initial UI state for target bar
	target_info_bar.hide()
	shop_label.text = "UPGRADES"
	shop_label.add_theme_font_override("font", font_handwritten)
	shop_label.add_theme_font_size_override("font_size", 32)
	
	setup_shop()
	
	# Wait for a frame to ensure UI is laid out before spawning
	await get_tree().process_frame
	
	# Initial spawn
	for i in range(3):
		spawn_victim()
	
	update_ui()

func setup_shop():
	# Clear existing placeholder buttons if any
	for child in upgrade_list.get_children():
		child.queue_free()
	
	for id in upgrade_defs.keys():
		var data = upgrade_defs[id]
		var item = create_shop_item(id, data)
		upgrade_list.add_child(item)
		shop_nodes[id] = item
		
	update_ui()

func create_shop_item(id: String, data: Dictionary) -> Button:
	var btn = ShopItemButton.new()
	# Size and content_start_y will be set after loading texture
	btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	btn.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	btn.clip_contents = false
	
	# Main Vertical Layout
	# 1. Main visual layout wrapper to prevent clipping of "Overhanging" elements like tape
	var visual_margin = 12.0
	btn.draw_inset = visual_margin
	
	var outer_margin = MarginContainer.new()
	outer_margin.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	outer_margin.mouse_filter = Control.MOUSE_FILTER_IGNORE
	outer_margin.add_theme_constant_override("margin_left", visual_margin)
	outer_margin.add_theme_constant_override("margin_top", visual_margin)
	outer_margin.add_theme_constant_override("margin_right", visual_margin)
	outer_margin.add_theme_constant_override("margin_bottom", visual_margin)
	btn.add_child(outer_margin)

	var main_vbox = VBoxContainer.new()
	# main_vbox.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT) # Managed by MarginContainer now
	main_vbox.mouse_filter = Control.MOUSE_FILTER_IGNORE
	main_vbox.add_theme_constant_override("separation", 0) # No separation, handled by layout
	outer_margin.add_child(main_vbox)
	
	# 2. Image Section (Top, outside the box)
	# Load texture first to calculate dynamic height
	var icon_texture = null
	if FileAccess.file_exists(data.icon):
		icon_texture = load(data.icon)
	
	var item_width = 240.0
	var inner_width = item_width - (visual_margin * 2) # Width available for image
	var img_height = 150.0
	var aspect_ratio = 1.0
	
	if icon_texture:
		var t_size = icon_texture.get_size()
		if t_size.x > 0 and t_size.y > 0:
			aspect_ratio = float(t_size.x) / float(t_size.y)
			# Calculate height to match aspect ratio at inner width
			img_height = inner_width / aspect_ratio
	
	# Pass dependencies to button script
	btn.icon_aspect_ratio = aspect_ratio
	
	# Update Button properties with dynamic height
	# Note: content_start_y is relative to the Button's TOP (0,0)
	# So it must include the top margin.
	btn.content_start_y = img_height + visual_margin
	
	# Minimum height must include margins + image + minimum text area
	btn.custom_minimum_size = Vector2(item_width, img_height + 220.0 + (visual_margin * 2))
	
	var icon_container = MarginContainer.new()
	icon_container.custom_minimum_size = Vector2(0, img_height) # Set exact height
	main_vbox.add_child(icon_container)
	
	# Give button reference to container so it can resize it
	btn.target_icon_container = icon_container
	
	var icon = TextureRect.new()
	icon.name = "Icon"
	icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	if icon_texture:
		icon.texture = icon_texture
	# Full width, no rotation, "Pinned" look
	icon_container.add_child(icon)

	# 2. Info Box Section (Bottom, inside the box)
	var info_margin = MarginContainer.new()
	info_margin.size_flags_vertical = Control.SIZE_EXPAND_FILL
	# Align margins with the drawn border
	info_margin.add_theme_constant_override("margin_left", 12)
	info_margin.add_theme_constant_override("margin_top", 12)
	info_margin.add_theme_constant_override("margin_right", 12)
	info_margin.add_theme_constant_override("margin_bottom", 12)
	# Link for dynamic sizing
	btn.target_text_container = info_margin
	main_vbox.add_child(info_margin)
	
	var content_vbox = VBoxContainer.new()
	content_vbox.add_theme_constant_override("separation", 10) # Slightly increased separation between elements
	info_margin.add_child(content_vbox)
	
	# Title
	var title = Label.new()
	title.text = data.title
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_color_override("font_color", Color(0.1, 0.1, 0.3))
	title.add_theme_font_size_override("font_size", 28)
	title.add_theme_font_override("font", font_handwritten)
	content_vbox.add_child(title)
	
	# 3. Description
	var desc = Label.new()
	desc.text = data.desc
	desc.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	desc.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	desc.add_theme_color_override("font_color", Color(0.2, 0.2, 0.4))
	desc.add_theme_font_size_override("font_size", 18) # Increased size
	desc.add_theme_font_override("font", font_typewriter)
	# Removed size_flags_vertical = EXPAND_FILL to prevent pushing cost down
	content_vbox.add_child(desc)
	
	# 4. Cost (Bottom)
	var cost_lbl = Label.new()
	cost_lbl.name = "CostLabel"
	cost_lbl.text = "Cost: " + str(int(data.base_cost))
	cost_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	cost_lbl.add_theme_color_override("font_color", Color(0.1, 0.1, 0.3))
	cost_lbl.add_theme_font_size_override("font_size", 24)
	cost_lbl.add_theme_font_override("font", font_typewriter)
	content_vbox.add_child(cost_lbl)
	
	# Remove old tape logic (now handled by ShopItemButton)
	btn.rotation_degrees = randf_range(-1.0, 1.0)
	btn.pressed.connect(_on_upgrade_bought.bind(id))
	
	return btn

func _process(delta):
	# Auto Damage Logic (Rusty Wire)
	if auto_damage > 0:
		for child in map_area.get_children():
			if child.has_method("take_damage") and !child.is_eliminated:
				child.take_damage(auto_damage * delta)
	
	update_ui_labels()

func spawn_victim():
	var victim = victim_scene.instantiate()
	map_area.add_child(victim)
	
	# Random type
	var keys = victim_defs.keys()
	var type_name = keys[randi() % keys.size()]
	var data = victim_defs[type_name]
	
	victim.setup(type_name, data["icon"], data["flavor"])
	victim.setup_stats(data["hp"], data["reward"])
	
	var victim_size = Vector2(400, 400)
	var area_size = map_area.size
	
	var valid_pos = false
	var attempts = 0
	var final_pos = Vector2.ZERO
	
	while !valid_pos and attempts < 20:
		attempts += 1
		final_pos = Vector2(
			randf_range(20, area_size.x - victim_size.x - 20),
			randf_range(110, area_size.y - victim_size.y - 20)
		)
		
		valid_pos = true
		for other in map_area.get_children():
			if other == victim or not other is Button: continue
			if final_pos.distance_to(other.position) < 350:
				valid_pos = false
				break
	
	victim.position = final_pos
	
	# Signals
	victim.pressed.connect(_on_victim_clicked.bind(victim))
	victim.victim_eliminated.connect(_on_victim_eliminated)
	victim.victim_targeted.connect(_on_victim_targeted)

func _on_victim_clicked(victim):
	if victim.is_eliminated: return
	victim.take_damage(click_damage)
	spawn_floating_text(str(int(click_damage)), victim.global_position)
	
	var slash = red_x_scene.instantiate()
	map_area.add_child(slash)
	slash.global_position = victim.global_position + (victim.size / 2)

func _on_victim_targeted(data):
	target_info_bar.show()
	target_name_label.text = data["name"]
	target_flavor_label.text = data["flavor"]
	target_hp_bar.max_value = data["max_hp"]
	target_hp_bar.value = data["hp"]

func _on_victim_eliminated(points):
	screams += points
	spawn_floating_text("+%d" % int(points), get_global_mouse_position(), Color(1, 0, 0))
	update_ui()
	
	await get_tree().create_timer(1.5).timeout
	spawn_victim()

func spawn_floating_text(txt: String, pos: Vector2, color = Color(1, 1, 1)):
	var float_txt = floating_text_scene.instantiate()
	float_txt.text = txt
	float_txt.modulate = color
	map_area.add_child(float_txt)
	float_txt.global_position = pos - Vector2(20, 20)

func _on_upgrade_bought(id):
	var data = upgrade_defs[id]
	var cost = data.base_cost * pow(data.cost_mult, data.level)
	
	if screams >= cost:
		screams -= cost
		data.level += 1
		
		# Apply effects
		match id:
			"weapon":
				click_damage += 1.0
			"utility":
				auto_damage += 0.5
			"gloves":
				# Placeholder for resource mult
				pass
		
		# Update UI
		update_ui()

func update_ui():
	update_ui_labels()
	
	# Update buy buttons status
	for id in upgrade_defs.keys():
		if not shop_nodes.has(id):
			continue
		var data = upgrade_defs[id]
		var cost = data.base_cost * pow(data.cost_mult, data.level)
		var btn = shop_nodes[id]
		
		# Update Cost Label
		var cost_label = btn.find_child("CostLabel")
		if cost_label:
			cost_label.text = "Cost: " + str(int(cost))
			
		btn.disabled = screams < cost
		btn.modulate.a = 1.0 if screams >= cost else 0.7

func update_ui_labels():
	scream_label.text = "Screams: %d" % int(screams)
	scream_label.add_theme_font_override("font", font_typewriter)
	scream_label.add_theme_font_size_override("font_size", 42)
	
	sps_label.text = "DPS: %.1f" % auto_damage
	sps_label.add_theme_font_override("font", font_typewriter)
	sps_label.add_theme_font_size_override("font_size", 24)
