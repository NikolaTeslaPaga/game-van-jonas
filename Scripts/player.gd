extends CharacterBody2D

@export var speed = 400
@export var jump_velocity = -1200
@export var gravity = 4000
@export_range(0.0, 1.0) var friction = 0.4
@export_range(0.0 , 1.0) var acceleration = 0.1


func _physics_process(delta):
	#voegt elke frame zwaartekracht toe
	velocity.y += gravity * delta
	
	#ingewikkelde code (zie linear interpolation) die zorgt voor snelheid en wrijving
	var direction = Input.get_axis("move_left", "move_right")
	if direction != 0:
		velocity.x = lerp(velocity.x, direction * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)
	
	move_and_slide()
	#Zorgt ervoor dat je enkel op de grond kan springen
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
