extends Node2D

@export var markerlist_node: Node
@export var monster_object: PackedScene
@export var monster_limit: int = 15
@export var monster_frequency: int = 5 #in seconds

var monster_list_node: Node
var current_monster_count: int = 0

func _ready():
	$SpawningTimer.wait_time = monster_frequency

	monster_list_node = Node.new()
	monster_list_node.name = "MonsterList"

	add_child(monster_list_node, true)

func _on_spawning_timer_timeout():
	print("monster would be spawning now")
	var new_monster = monster_object.instantiate()

	var markers = markerlist_node.get_children()
	var random_location = markers[randi() % markers.size()].position

	new_monster.position = random_location
	$MonsterList.add_child(new_monster)
