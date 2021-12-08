extends Spatial


func _ready():
	var map = RouglikeMap.new(16)
	for room in map.rooms:
		var box := CSGBox.new()
		box.transform.origin = Vector3(3 * room[0], 0, 3 * room[1])
		add_child(box)
