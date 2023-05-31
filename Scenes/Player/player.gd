extends CharacterBody2D

enum PlayerStates {
	MOVE,
	SWORD	
}

var CurrentState = PlayerStates.MOVE

var speed = 200.0
var gravity = 20.0
var jump = 400
var pressed = 2

func _ready():
	$Sword/CollisionShape2D.disabled = true

func _physics_process(delta):
	
	match CurrentState:
		PlayerStates.MOVE:
			Move(delta)
		PlayerStates.SWORD:
			Sword(delta)

	velocity.y += gravity
	move_and_slide()

func Move(delta):
	var movement = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	## Basic walking logic
	if (movement != 0):
		if (movement > 0.0):
			velocity.x += speed * delta
			velocity.x = clamp(speed, 100, speed)
			$Sprite2D.flip_h = false
			$Anim.play("Walk")
			$Sword.position = Vector2(25, 0)
		if (movement < 0.0):
			velocity.x -= speed * delta
			velocity.x = clamp(speed, -100, -speed)
			$Sprite2D.flip_h = true
			$Anim.play("Walk")
			$Sword.position = Vector2(-25, 0)
			
	## Basic Idle logic
	elif (movement == 0):
		velocity.x = 0.0
		$Anim.play("Idle")
	if Input.is_action_just_pressed("ui_jump"):
		pressed -= 1
		print(pressed)
	
	if Input.is_action_just_pressed("ui_jump") and is_on_floor():
		print(velocity.y)
		Jump()
	if Input.is_action_just_pressed("ui_jump") and !is_on_floor() && pressed >= 1:
		print(velocity.y)
		velocity.y = 0
		Jump()	
	if pressed <= 0:
		velocity.y = velocity.y
	if is_on_floor():
		pressed = 2
		
	if velocity.y < 0 and !is_on_floor() and pressed >= 1:
		$Anim.play("Jump")
	elif velocity.y > 10 and !is_on_floor():
		$Anim.play("Fall")
		
	if Input.is_action_just_pressed("ui_sword"):
		CurrentState = PlayerStates.SWORD

func Jump():
	velocity.y -= jump
		
func Sword(delta):
	var movement = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = movement
	$Anim.play("Sword")
	if (movement != 0):
		if (movement > 0.0):
			velocity.x += speed * delta
			velocity.x = clamp(speed, 100, speed)
		if (movement < 0.0):
			velocity.x -= speed * delta
			velocity.x = clamp(speed, -100, -speed)

func OnStateFinished():
	CurrentState = PlayerStates.MOVE
