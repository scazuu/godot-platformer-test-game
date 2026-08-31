extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -300.0

@onready var player_animatedSprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if (Input.is_action_just_pressed("move_up") or Input.is_action_just_pressed("jump")) and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handle movement.
	# gets direction - it will either be a 1 or -1, defaults at start is 0.
	var direction := Input.get_axis("move_left", "move_right")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Handles sprites.
	# flips sprite on direction
	if direction > 0:
		player_animatedSprite.flip_h = false
	elif direction < 0:
		player_animatedSprite.flip_h = true

	# changes animations based on actions
	if is_on_floor():
		if direction == 0:
			player_animatedSprite.play("default")
		else:
			player_animatedSprite.play("run")
	else:
		player_animatedSprite.play("jump")

	move_and_slide()
