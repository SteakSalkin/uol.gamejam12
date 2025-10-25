extends CharacterBody2D

const SPEED = 600.0
const JUMP_VELOCITY = -80.0
const MAX_JUMP_VELOCITY = -800

var is_flipped = false
var health = 20
var is_touching_player = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and not Input.is_action_pressed("player1up"):
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_pressed("player1up") and velocity.y > MAX_JUMP_VELOCITY:
		velocity.y += JUMP_VELOCITY

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

	if Input.is_action_just_pressed("player2attack") and is_touching_player:
		get_damage(1)

	move_and_slide()

func get_damage(damage: int) -> void:
	health -= damage
	$HealthBar.value = health
	if health < 1:
		die()

func die() -> void:
	hide()

func _on_hitbox_area_entered(area: Area2D) -> void:
	is_touching_player = true

func _on_hitbox_area_exited(area: Area2D) -> void:
	is_touching_player = false
