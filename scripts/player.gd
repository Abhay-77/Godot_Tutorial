extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const BOUNCE_VELOCITY = -200

var dying = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("move_left", "move_right")
	if direction and not dying:
		velocity.x = direction * SPEED
		animated_sprite_2d.flip_h = (direction < 0)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if is_on_floor() and not dying:
		if direction:
			animated_sprite_2d.play("run")
		else:
			animated_sprite_2d.play("idle")
	else:
		if velocity.y < 0:
			animated_sprite_2d.play("jump")

	move_and_slide()

func bounce():
	velocity.y = BOUNCE_VELOCITY

func die():
	dying = true
	animated_sprite_2d.play("die")
