extends ParallaxLayer

onready var camera = get_tree().current_scene.get_node("Player/Camera2D")
export (int) var sprite_scale = 2
export (bool) var y_mirroring = false

var last_screen_size = Vector2()


func _process(_delta):
	var screen_size = get_viewport_rect().size * camera.zoom
	if screen_size != last_screen_size:
		var sprite = get_children()[0]
		sprite.scale = Vector2(sprite_scale, sprite_scale)
		var sprite_size = sprite.get_rect().size
		var rect = Rect2(0, 0, sprite_size.x * ceil(screen_size.x / sprite_size.x/sprite_scale),
		 sprite_size.y)
		sprite.region_rect = rect
		sprite.region_enabled = true
		motion_mirroring = Vector2(rect.size.x*sprite_scale, 0)
		if y_mirroring:
			rect.size.y = sprite_size.y * ceil(screen_size.y / sprite_size.y/sprite_scale)
			sprite.region_rect = rect
			motion_mirroring.y = rect.size.y*sprite_scale
	last_screen_size = screen_size
