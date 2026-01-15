extends CPUParticles2D

func _ready():
	if texture == null:
		var img_size = 16
		var img = Image.create(img_size, img_size, false, Image.FORMAT_RGBA8)
		img.fill(Color(0, 0, 0, 0))
		var center = Vector2(img_size / 2.0, img_size / 2.0)
		var radius = 6.0
		for y in range(img_size):
			for x in range(img_size):
				if Vector2(x, y).distance_to(center) <= radius:
					img.set_pixel(x, y, Color(1, 1, 1, 1))
		texture = ImageTexture.create_from_image(img)
		modulate = Color(0.85, 0.05, 0.05, 1)

	emitting = true
	finished.connect(queue_free)
