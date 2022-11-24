extends Node2D

onready var slots_dict = {
	"ENGINE": [
		$Engine1, $Engine2, $Engine3, $ThrustLeft2, $ThrustRight2,
		],
	"GUN": [
		$Gun1, $Gun2, $Gun3, $ThrustLeft1, $ThrustRight1,
		],
	"UTILITY": [
		$ThrustLeft1, $ThrustLeft2, $ThrustRight1, $ThrustRight2, 
		$Utility1, $Utility2, $Utility3, $Gun1, $Gun2, $Gun3,
		],
}

var ui_window_path = "res://UI/Station/ShipHeavyWin.tscn"


func _ready():
	print(slots_dict["ENGINE"])


func enter_station(station):
	station.equipped_ship = ui_window_path
