class_name Player1

extends CharacterBody2D

const SPEED = 800.0
const JUMP_VELOCITY = -400.0
const MAX_JUMP_VELOCITY = -600.0
const MAX_HEALTH = 20.0
const HEAL_AMOUNT = 2.0
const DAMAGE_AMOUNT = 1.0

var is_flipped = false
var health = MAX_HEALTH
var is_touching_player = false
var is_touching_healing = false
var backflip_rotation = 0.0
var attack_rotation = 0.0
var attack_animation_wait = 0.0
var attack_cooldown = 0

var button_left = false
var button_up = false
var button_right = false
var button_down = false
var button_hit = false

var direction

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and not button_up:
		velocity += get_gravity() * delta

	# Handle jump.
	if button_up and velocity.y > MAX_JUMP_VELOCITY:
		velocity.y += JUMP_VELOCITY
	if button_down and velocity.y > MAX_JUMP_VELOCITY:
		velocity.y -= JUMP_VELOCITY/2

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("player1left", "player1right")
	if (button_left):
		direction = -1.0
	elif (button_right):
		direction = 1.0
	else:
		direction = 0
	if direction:
		velocity.x = direction * SPEED
		if direction > 0 and is_flipped:
			scale.x = -1
			is_flipped = false
		if direction < 0 and !is_flipped:
			scale.x = -1
			is_flipped = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if button_hit and is_touching_player and Input.is_action_just_pressed("player1attack"):
		#button_hit = false
		get_node("/root/level/Player2").animation_taking_damage()
		animation_attack()
		get_node("/root/level/Player2").get_damage(DAMAGE_AMOUNT)

	if is_touching_healing:
		get_healed(HEAL_AMOUNT * delta)

	if attack_rotation > 0:
		if attack_animation_wait <= 0:
			attack_animation_wait = 0.01
			attack_rotation -= 0.1
			$Pidgeon.rotation = attack_rotation
		attack_animation_wait -= delta

	if backflip_rotation > 0:
		backflip_rotation -= int(100 * delta)
		$Pidgeon.rotation = backflip_rotation

	move_and_slide()

func animation_attack() -> void:
	attack_rotation = 1.0

func animation_taking_damage() -> void:
	pass

func animation_backflip() -> void:
	backflip_rotation = 10

func get_damage(damage: int) -> void:
	health -= damage
	$HealthBar.value = health
	if health < 1:
		get_node("/root/level/Player2").animation_backflip()
		get_node("/root/level").player_1_wins()
		die()

func get_healed(heal: float) -> void:
	if health < MAX_HEALTH:
		health += heal
	$HealthBar.value = health

func die() -> void:
	queue_free()

func _on_hitbox_area_entered(area: Area2D) -> void:
	is_touching_player = true

func _on_hitbox_area_exited(area: Area2D) -> void:
	is_touching_player = false

func _on_healbox_area_entered(area: Area2D) -> void:
	is_touching_healing = true

func _on_healbox_area_exited(area: Area2D) -> void:
	is_touching_healing = false

func _on_button_left_area_entered(area: Area2D) -> void:
	button_left = true

func _on_button_left_area_exited(area: Area2D) -> void:
	button_left = false

func _on_button_up_area_entered(area: Area2D) -> void:
	button_up = true

func _on_button_up_area_exited(area: Area2D) -> void:
	button_up = false

func _on_button_right_area_entered(area: Area2D) -> void:
	button_right = true

func _on_button_right_area_exited(area: Area2D) -> void:
	button_right = false

func _on_button_down_area_entered(area: Area2D) -> void:
	button_down = true

func _on_button_down_area_exited(area: Area2D) -> void:
	button_down = false

func _on_button_hit_area_entered(area: Area2D) -> void:
	button_hit = true

func _on_button_hit_area_exited(area: Area2D) -> void:
	button_hit = false
