extends Node2D


var generated_map: RouglikeMap

const cell_prefab := preload("res://Cell.tscn")

onready var start = Vector2(450, 250)
const size := 64

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_map_view()

func generate_map_view() -> void:
	for cell_id in range(len(generated_map.rooms)):
		var cell_inst := cell_prefab.instance()
		var cell = generated_map.rooms[cell_id]
		cell_inst.position = start + Vector2(cell[0], cell[1]) * size + Vector2.ONE * size
		if cell_id == generated_map.get_start_room():
			cell_inst.modulate = Color.green
		if cell_id == generated_map.get_boss_room():
			cell_inst.modulate = Color.red
		add_child(cell_inst)
