class_name Player1

extends CharacterBody2D

const SPEED = 1200.0
const JUMP_VELOCITY = -600.0
const MAX_JUMP_VELOCITY = -800.0
const MAX_HEALTH = 20.0
const HEAL_AMOUNT = 1.0

var is_flipped = false
var health = MAX_HEALTH
var is_touching_player = false
var is_touching_healing = false
var backflip_rotation = 0.0
var attack_rotation = 0.0
var attack_animation_wait = 0.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and not Input.is_action_pressed("player1up"):
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_pressed("player1up") and velocity.y > MAX_JUMP_VELOCITY:
		velocity.y += JUMP_VELOCITY
	if Input.is_action_pressed("player1down") and velocity.y > MAX_JUMP_VELOCITY:
		velocity.y -= JUMP_VELOCITY/2

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("player1left", "player1right")
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

	if Input.is_action_just_pressed("player1attack") and is_touching_player:
		animation_taking_damage()
		get_node("/root/level/Player2").animation_attack()
		get_damage(1)

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
