extends Area2D



func _ready():
	pass

func _process(delta):
	pass


func _on_body_entered(body):
	if body.name == "Player":
		Globals.player_coins += 1
		print(Globals.player_coins)
		$Anim.play("Picked")
		await $Anim.animation_finished
		queue_free()
