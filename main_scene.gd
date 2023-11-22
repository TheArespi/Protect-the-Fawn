extends Node2D

@export var gameworld: PackedScene
@export var gameover: PackedScene

func _ready():
	get_tree().change_scene_to_packed(gameworld)
	GlobalSignals.fawn_died.connect(fawn_dead)

func fawn_dead():
	print("Game over!")
	get_tree().change_scene_to_packed(gameover)
