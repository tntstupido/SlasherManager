extends Button

# Config
var ink_color = Color(0.1, 0.1, 0.3) # Deep Blue
var paper_color = Color.TRANSPARENT # Transparent for global background
var tape_color = Color(0.9, 0.9, 0.6, 0.6) # Semi-transparent yellow
var wobble_amount = 2.0
var content_start_y = 0.0 # New property to control where the "box" starts

# Responsive properties
var target_icon_container: MarginContainer
var target_text_container: Control # The container with title/desc/cost
var icon_aspect_ratio = 1.0 # Width / Height
var min_text_height = 220.0 # Height for the text box area
var draw_inset = 0.0 # Padding for logic to draw inside the control bounds
var bottom_padding = 24.0 # Padding for tape and aesthetics

func _ready():
	# Important: queue_redraw when resized to keep borders clean
	resized.connect(_on_resized)
	# Connect to sort_children to catch layout updates from children? 
	# Actually, usually safer to wait for sizing.
	add_theme_stylebox_override("normal", StyleBoxEmpty.new())
	add_theme_stylebox_override("hover", StyleBoxEmpty.new())
	add_theme_stylebox_override("pressed", StyleBoxEmpty.new())
	add_theme_stylebox_override("focus", StyleBoxEmpty.new())
	add_theme_stylebox_override("disabled", StyleBoxEmpty.new()) # Fix grey background on expensive items

func _on_resized():
	queue_redraw()
	# Recalculate metrics based on new width
	if target_icon_container and icon_aspect_ratio > 0:
		var new_width = size.x
		# Calculate new height for image based on width to maintain aspect ratio
		# aspect = w / h  =>  h = w / aspect
		var new_img_height = new_width / icon_aspect_ratio
		
		# Update minimum size of icon container
		if target_icon_container.custom_minimum_size.y != new_img_height:
			target_icon_container.custom_minimum_size.y = new_img_height
			content_start_y = new_img_height
			
			# Ensure button is tall enough for image + text
			var text_h = 0.0
			if target_text_container:
				text_h = target_text_container.get_combined_minimum_size().y
				
			var needed_height = new_img_height + text_h + bottom_padding
			
			if custom_minimum_size.y != needed_height:
				custom_minimum_size.y = needed_height

func _draw():
	var rect_size = get_rect().size
	
	# Determine the rect for the "box" (Info section)
	# Apply Draw Inset to all sides
	var safe_rect = Rect2(draw_inset, draw_inset, rect_size.x - draw_inset * 2, rect_size.y - draw_inset * 2)
	
	# The Info Box starts at content_start_y (which includes top inset now)
	# We want the text box to go from content_start_y down to safe_rect.end.y
	# And span the width of safe_rect
	var box_rect = Rect2(safe_rect.position.x, content_start_y, safe_rect.size.x, safe_rect.end.y - content_start_y)
	
	# 1. Background Paper
	draw_rect(box_rect, paper_color, true)
	
	# 2. Wobbly Border
	# We draw 4 lines with noise
	var points = []
	var segments = 12 # How many points per side
	
	# Top Edge
	for i in range(segments + 1):
		var t = float(i) / segments
		var x = lerp(box_rect.position.x, box_rect.end.x, t)
		var y = box_rect.position.y + randf_range(-wobble_amount, wobble_amount) + 2 # Offset slightly in
		points.append(Vector2(x, y))
		
	# Right Edge
	for i in range(segments + 1):
		var t = float(i) / segments
		var x = box_rect.end.x + randf_range(-wobble_amount, wobble_amount) - 2
		var y = lerp(box_rect.position.y, box_rect.end.y, t)
		points.append(Vector2(x, y))
		
	# Bottom Edge
	for i in range(segments + 1):
		var t = float(i) / segments
		var x = lerp(box_rect.end.x, box_rect.position.x, t) # Backwards
		var y = box_rect.end.y + randf_range(-wobble_amount, wobble_amount) - 2
		points.append(Vector2(x, y))
		
	# Left Edge
	for i in range(segments + 1):
		var t = float(i) / segments
		var x = box_rect.position.x + randf_range(-wobble_amount, wobble_amount) + 2
		var y = lerp(box_rect.end.y, box_rect.position.y, t) # Upwards
		points.append(Vector2(x, y))
		
	# Close the loop
	points.append(points[0])
	
	draw_polyline(PackedVector2Array(points), ink_color, 2.0, true)
	
	# 3. Double Border (Inner)
	var margin = 6.0
	var inner_points = []
	
	# Top Inner
	for i in range(segments + 1):
		var t = float(i) / segments
		var x = lerp(box_rect.position.x + margin, box_rect.end.x - margin, t)
		var y = box_rect.position.y + margin + randf_range(-1.0, 1.0)
		inner_points.append(Vector2(x, y))
		
	# Right Inner
	for i in range(segments + 1):
		var t = float(i) / segments
		var x = box_rect.end.x - margin + randf_range(-1.0, 1.0)
		var y = lerp(box_rect.position.y + margin, box_rect.end.y - margin, t)
		inner_points.append(Vector2(x, y))

	# Bottom Inner
	for i in range(segments + 1):
		var t = float(i) / segments
		var x = lerp(box_rect.end.x - margin, box_rect.position.x + margin, t)
		var y = box_rect.end.y - margin + randf_range(-1.0, 1.0)
		inner_points.append(Vector2(x, y))

	# Left Inner
	for i in range(segments + 1):
		var t = float(i) / segments
		var x = box_rect.position.x + margin + randf_range(-1.0, 1.0)
		var y = lerp(box_rect.end.y - margin, box_rect.position.y + margin, t)
		inner_points.append(Vector2(x, y))
	
	inner_points.append(inner_points[0])
	draw_polyline(PackedVector2Array(inner_points), ink_color, 1.0, true)
	
	# 4. Tape Strips (Procedural)
	# Use box_rect to position tape relative to the box
	# Draw tape slightly OUTSIDE the box_rect, which is safe because of draw_inset
	draw_tape(Vector2(box_rect.end.x - 10, box_rect.position.y), 20) # Top Right
	draw_tape(Vector2(box_rect.position.x + 10, box_rect.end.y - 5), -30) # Bottom Left
	
	# Optional: Add tape to the image (top of the whole button)?
	if content_start_y > draw_inset:
		# Center of the image area
		var img_center_x = safe_rect.position.x + safe_rect.size.x * 0.5
		draw_tape(Vector2(img_center_x, safe_rect.position.y + 5), randf_range(-5, 5))

func draw_tape(pos: Vector2, angle_deg: float):
	var w = 80.0 # Even BIGGER tape
	var h = 32.0
	var angle = deg_to_rad(angle_deg)
	
	var c = cos(angle)
	var s = sin(angle)
	
	# Rotate 4 corner points roughly centered on pos
	# Using float constants for division to avoid integer division warning
	var half_w = w * 0.5
	var half_h = h * 0.5
	
	var p1 = pos + Vector2(-half_w * c - -half_h * s, -half_w * s + -half_h * c)
	var p2 = pos + Vector2(half_w * c - -half_h * s, half_w * s + -half_h * c)
	var p3 = pos + Vector2(half_w * c - half_h * s, half_w * s + half_h * c)
	var p4 = pos + Vector2(-half_w * c - half_h * s, -half_w * s + half_h * c)
	
	draw_colored_polygon(PackedVector2Array([p1, p2, p3, p4]), tape_color)
	
	# Draw Outline
	var outline_points = PackedVector2Array([p1, p2, p3, p4, p1])
	draw_polyline(outline_points, ink_color, 1.5, true)
