extends CharacterBody2D
class_name Player

@export var move_speed: float = 150.0
@export var push_strength: float = 100
func _ready() -> void:
	position = Scenemanager.player_spawn_position
	Scenemanager.player_hp = 4

func _physics_process(_float) -> void:
	
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

func _on_hitbox_body_entered(body: Node2D) -> void:
	Scenemanager.player_hp -= 1 # Replace with function body.
	print(Scenemanager.player_hp)
	
	if Scenemanager.player_hp <= 0:
		die()
func die():
	get_tree().call_deferred("reload_current_scene")



# Preload the projectile scene so it can be instantiated quickly
const ProjectileScene = preload("res://rock_attack.tscn")

var can_attack: bool = true
var attack_cooldown: float = 0.3 # Cooldown in seconds

func _input(event):
	# Check for a "shoot" action (defined in Project Settings -> Input Map)
	if event.is_action_pressed("shoot") and can_attack:
		perform_ranged_attack()
		can_attack = false
		# Use a timer to manage the attack rate
		await get_tree().create_timer(attack_cooldown).timeout
		can_attack = true

func perform_ranged_attack():
	var projectile_instance = ProjectileScene.instantiate()
	print("bang")
	# Calculate the direction from the player to the mouse position
	var mouse_pos = get_global_mouse_position()
	var shoot_direction = global_position.direction_to(mouse_pos).normalized()

	# Set the projectile's properties
	projectile_instance.direction = shoot_direction
	projectile_instance.global_position = global_position # Start at player's location

	# Add the projectile to the main scene tree, not as a child of the player
	# so it moves independently
	get_tree().root.add_child(projectile_instance)
