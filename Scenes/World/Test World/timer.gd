extends Node

@export var time_label: Label

var currSec: float
var currMin: int

func _ready():
	currSec = 0
	currMin = 0

func _process(delta):
	currSec += delta

	if currSec >= 60:
		currSec = 0
		currMin += 1

	var format_string = "%02d:%02d"
	time_label.text = format_string % [currMin, currSec]
