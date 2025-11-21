extends Area2D
signal pressed
signal unpressed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_float) -> void:
	pass


func _on_body_entered(_Node2D) -> void:
	print("I'm on")
	$AnimatedSprite2D.play("on")
	pressed.emit()

func _on_body_exited(_Node2D) -> void:
	print("I'm off")
	$AnimatedSprite2D.play("off")
	unpressed.emit()


func _on_unpressed() -> void:
	pass # Replace with function body.
