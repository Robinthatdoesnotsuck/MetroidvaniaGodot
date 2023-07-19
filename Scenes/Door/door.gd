extends StaticBody2D

func _on_switch_opening_door():
	$Anim.play("Opening")
	$Audio.play()
	await $Anim.animation_finished
	$Anim.play("Opened")


func _on_switch_2_opening_door():
	$Anim.play("Opening")
	$Audio.play()
	await $Anim.animation_finished
	$Anim.play("Opened")
