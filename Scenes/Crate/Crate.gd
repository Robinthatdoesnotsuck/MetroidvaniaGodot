extends StaticBody2D

var hitpoints = 2

func _on_hitbox_area_entered(area):
	
	if area.name == "Sword" && hitpoints > 0:
		$Anim.play("Hurt")
		hitpoints -= 1
		await $Anim.animation_finished
		$Anim.play("Active")
	if hitpoints <= 0:
		$Anim.play("Destroy")
		await $Anim.animation_finished
		queue_free()
	
	print("Sword")
