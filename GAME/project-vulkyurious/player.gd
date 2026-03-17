extends CharacterBody3D


@export var speed = 20.0
@export var jump_velocity = 4.5

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var last_position = ""

func idle(pos):
	if(pos == "f"):
		$AnimatedSprite3D.play("front_idle")
		return
	if(pos == "l"):
		$AnimatedSprite3D.play("left_idle")
		return
	if(pos == "d"):
		$AnimatedSprite3D.play("bottom_idle")
		return
	if(pos == 'r'):
		$AnimatedSprite3D.play("right_idle")
		return
	
	
	
func _physics_process(delta):
	var direction = Vector3.ZERO
	var is_moving = false
	
	if Input.is_action_pressed("ui_up"):
		direction -= transform.basis.z
		last_position = "f"
		$AnimatedSprite3D.play("run_front")
		is_moving = true
		
	if Input.is_action_pressed("ui_down"):
		direction += transform.basis.z
		last_position = "l"
		$AnimatedSprite3D.play("run_back")
		is_moving = true
		
	if Input.is_action_pressed("ui_left"):
		$AnimatedSprite3D.play("run_left")
		direction -= transform.basis.x
		last_position = "d"
		is_moving = true
		
	if Input.is_action_pressed("ui_right"):
		direction += transform.basis.x
		last_position = "r"
		$AnimatedSprite3D.play("run_right")
		is_moving = true

	direction = direction.normalized()
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	
	if not is_moving: 
		idle(last_position)

	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity
	

	move_and_slide()
	
