extends Area2D


var direction: Vector2 = Vector2.RIGHT # This will be set by the spawner

func _ready():
	# Rotate the sprite to face the direction of travel
	$AnimatedSprite2D.play()
	print("projectile spawned at", global_position)
	look_at(global_position + direction)
	# Connect the "body_entered" or "area_entered" signal for collision logic
	connect("body_entered", Callable(self, "_on_body_entered"))
	# Add a timer to destroy the projectile after a few seconds if it doesn't hit anything
	var timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = 5.0
	timer.connect("timeout", Callable(self, "queue_free"))
	add_child(timer)
	timer.start()
	$AnimatedSprite2D.stop()

func _process(delta: float) -> void:
	# Move the projectile every frame
	position += direction * delta
