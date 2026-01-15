extends Control

var positions := []
var velocities := []
var radii := []
var lifetime := 1.1
var elapsed := 0.0
var gravity := Vector2(0, 380)
var drag := 0.85
var alpha := 1.0

func _ready():
	randomize()
	var center = size / 2.0
	var count = 30
	for i in range(count):
		positions.append(center + Vector2(randf_range(-40, 40), randf_range(-40, 40)))
		radii.append(randf_range(16.0, 32.0))
		
		var angle = randf_range(0.0, TAU)
		var speed = randf_range(220.0, 360.0)
		var vel = Vector2(cos(angle), sin(angle)) * speed
		vel.y -= randf_range(30.0, 120.0)
		velocities.append(vel)
	
	set_process(true)

func _process(delta):
	elapsed += delta
	for i in range(positions.size()):
		velocities[i] += gravity * delta
		velocities[i] *= pow(drag, delta * 60.0)
		positions[i] += velocities[i] * delta
	
	alpha = clamp(1.0 - (elapsed / lifetime), 0.0, 1.0)
	queue_redraw()
	
	if elapsed >= lifetime:
		queue_free()

func _draw():
	var color = Color(0.85, 0.05, 0.05, alpha)
	for i in range(positions.size()):
		draw_circle(positions[i], radii[i], color)
