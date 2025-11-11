extends CharacterBody2D
class_name Player

@export var move_speed: float = 150.0
@export var push_strength: float = 50

func _ready() -> void:
	position = Scenemanager.player_spawn_position
func _physics_process(delta: float) -> void:
	
	var move_vector: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = move_vector * move_speed
	if velocity.x > 0:
		$AnimatedSprite2D.play("move_right")
	elif velocity.x < 0:
		$AnimatedSprite2D.play("move_left")
	elif velocity.y > 0:
		$AnimatedSprite2D.play("move_down")
	elif velocity.y < 0:
		$AnimatedSprite2D.play("move_up")
	else:
		$AnimatedSprite2D.stop()
		
	var collision: KinematicCollision2D = get_last_slide_collision()
	if collision:
		var collider_node = collision.get_collider()
		if collider_node.is_in_group("Movable"):
			var collision_normal: Vector2 = collision.get_normal()
			
			collider_node.apply_central_force(-collision_normal * push_strength)
	move_and_slide()
#Add code to player. 
#The characterbody doesnt have collision signals
#(although you could add a rigidbody as a child) 
#so collision detection needs to be added 
# - find collision node with get_last_slide_collision() 
#and get_collider(), if there is a collision with a pushable object, 
#get direction of collision (normal vector), 
#apply central force away from player (negative), 
#deactivate or lock rotation, apply linear damping
