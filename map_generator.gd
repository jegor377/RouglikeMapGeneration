extends Node2D


const shower_prefab := preload("res://ShowingGeneratedMap.tscn")


var last_map = null

func _on_Timer_timeout():
	var map_inst := shower_prefab.instance()
	if last_map != null:
		last_map.queue_free()
	map_inst.generated_map = RouglikeMap.new(8)
	add_child(map_inst)
	last_map = map_inst
