extends CharacterBody2D
var target: Node2D
@export var speed: int = 50
func _physics_process(delta: float) -> void:
	if target:
		chasing()
	else:
		pass
	animate_enemy()
	move_and_slide()
func chasing():
	var distance_to_player: Vector2
	distance_to_player = target.global_position - global_position
	var direction_normal: Vector2 = distance_to_player.normalized()
	velocity = direction_normal * speed
	
	
	
func animate_enemy():
	var normal_velocity: Vector2 = velocity.normalized()
	if normal_velocity.x > 0.7:
		$AnimatedSprite2D.play("right")
	elif normal_velocity.x < -0.7:
		$AnimatedSprite2D.play("left")
	elif normal_velocity.y > 0.7:
		$AnimatedSprite2D.play("down")
	elif normal_velocity.y < -0.7:
		$AnimatedSprite2D.play("up")
	else:
		$AnimatedSprite2D.stop()
	
	
	
	

func _on_chasing_radius_body_entered(body: Node2D) -> void:
	if body is Player:
		target = body # Replace with function body.
		speed = 50

func _on_chasing_radius_body_exited(body: Node2D) -> void:
	if body is Player:
		target != body # Replace with function body.
		speed = 0
