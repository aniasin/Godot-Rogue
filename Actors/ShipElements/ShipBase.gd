extends Area2D


export (int) var hit_points = 100
export var inventory_texture_path = ""

func enter_station(_station):
	print("entering station...")
	

func get_texture():
	return $Sprite.texture

