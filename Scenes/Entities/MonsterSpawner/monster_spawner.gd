extends Node2D

@export var markerlist_node: Node
@export var monster_object: PackedScene
@export var monster_limit: int = 15
@export var monster_frequency: int = 5 #in seconds

var monster_list_node: Node
var current_monster_count: int = 0
var markers

func _ready():
	$SpawningTimer.wait_time = monster_frequency

	monster_list_node = Node.new()
	monster_list_node.name = "MonsterList"

	add_child(monster_list_node, true)

	markers = markerlist_node.get_children()

func _on_spawning_timer_timeout():
	if current_monster_count <= monster_limit:
		print("monster would be spawning now")
		var new_monster = monster_object.instantiate()
		
		var selected_marker_index = randi() % markers.size()
		var random_location:Vector2 = markers[selected_marker_index].position

		print("Monster will spawn in ", markers[selected_marker_index].name)

		new_monster.position = random_location

		call_deferred("add_monster", new_monster);
		current_monster_count += 1
	else:
		print("Monster limit reached")

func monster_died():
	current_monster_count -= 1

func add_monster(monster_instance):
	$MonsterList.add_child(monster_instance)