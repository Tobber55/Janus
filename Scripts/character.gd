extends CharacterBody2D

var speed = 600
var acceleration = 1000

const friction = 1000

var input = Vector2.ZERO

func _ready():
	
	pass

func _movement(delta):
	input.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	input.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	
	input = input.normalized()
	
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (input * acceleration * delta)
		velocity = velocity.limit_length(speed)
	
	move_and_slide()

func _physics_process(delta):
	
	if Input.is_action_just_pressed("menu"):
		if $UI.visible:
			$UI.hide()
			Global.paused = false
		else:
			$UI.show()
			Global.paused = true
	
	if Global.paused == false:
		_movement(delta)
	
