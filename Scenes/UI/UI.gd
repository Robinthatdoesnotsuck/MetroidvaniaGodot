extends CanvasLayer

const HEART_ROW_SIZE = 8
const HEART_OFFSET = 16

func _ready():
	$coinLogo/Anim.play("coin")
	for i in Globals.player_life:
		var new_heart = Sprite2D.new()
		new_heart.texture = $Heart.texture
		new_heart.hframes = $Heart.hframes
		$Heart.add_child(new_heart)


func _process(delta):
	for heart in $Heart.get_children():
		var index = heart.get_index()
		
		var x = (index % HEART_ROW_SIZE) * HEART_OFFSET
		var y = (index / HEART_ROW_SIZE) * HEART_OFFSET
		heart.position = Vector2(x, y)
		
		var last_heart = floor(Globals.player_life)
		
		if index > last_heart:
			heart.frame = 0
		if index == last_heart:
			heart.frame = (Globals.player_life - last_heart) * 4
		if index < last_heart:
			heart.frame = 4
