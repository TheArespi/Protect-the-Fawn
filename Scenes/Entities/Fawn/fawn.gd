extends Node2D

func _ready():
    position = Util.snap_to_grid(position)