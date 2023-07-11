extends CharacterBody2D

var moving_left = true
var speed = 15
var gravity = 30
var health = 3

func _physics_process(delta):
	Move()
	floor_detect()
func _ready():
	$Anim.play("Idle")

func Move():
	if moving_left:
		velocity.x = speed
	else:
		velocity.x = -speed
	if health <= 0:
		velocity.x = 0
		$Anim.play("Dead")
		await $Anim.animation_finished
		queue_free()
	move_and_slide()

func floor_detect():
	if !$RayCastY.is_colliding() && is_on_floor():
		moving_left = !moving_left
		scale.x = -scale.x
	elif !$RayCastX.is_colliding() && is_on_wall():
		moving_left = !moving_left
		scale.x = -scale.x
		
func flash():
	$Sprite2D.material.set_shader_parameter("flash_modifier", 1)
	await (get_tree().create_timer(0.3)).timeout
	$Sprite2D.material.set_shader_parameter("flash_modifier", 0)


func _on_area_2d_area_entered(area):
	if area.name == "Sword":
		flash()
		health -= 1
		print(health)
