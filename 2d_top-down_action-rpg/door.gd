extends StaticBody2D

func _on_button_pressed() -> void:
	visible = false # Replace with function body.
	$CollisionShape2D.set_deferred("disabled" ,true)

func _on_button_unpressed() -> void:
	visible = true # Replace with function body.
	$CollisionShape2D.set_deferred("disabled" ,false)
