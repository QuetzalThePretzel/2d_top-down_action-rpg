extends Area2D
signal pressed
signal unpressed


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	print("I'm on")
	$AnimatedSprite2D.play("on")
	pressed.emit()


func _on_pressed() -> void:
	$WaterObstacleLvl1.queue_free()
