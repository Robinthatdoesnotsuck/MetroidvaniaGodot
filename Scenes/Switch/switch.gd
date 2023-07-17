extends Area2D

signal opening_door

func _on_area_entered(area):
	if area.name == "Sword":
		$Anim.play("Activating")
		await $Anim.animation_finished
		$Anim.play("Activated")
		emit_signal("opening_door")
