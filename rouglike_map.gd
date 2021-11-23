extends Reference
class_name RouglikeMap


var rooms: Array
var boss_room: int = -1


func _init(n: int):
	var rng := RandomNumberGenerator.new()
	rng.randomize()
	rooms = [[0, 0]]
	for i in range(n - 1):
		var adj_nodes := _all_adjecent_rooms()
		rooms.append(adj_nodes[rng.randi() % adj_nodes.size()])
	set_boss_room()

func get_start_room() -> int:
	return 0

func get_boss_room() -> int:
	return boss_room

func set_boss_room() -> void:
	if len(rooms) > 1:
		var max_dist = 0
		var start_pos = Vector2.ZERO
		for i in range(1, len(rooms)):
			var room = rooms[i]
			var curr_pos := Vector2(room[0], room[1])
			var new_dist = start_pos.distance_to(curr_pos)
			if new_dist > max_dist and _neighbours(room) == 1:
				max_dist = new_dist
				boss_room = i

func _all_adjecent_rooms() -> Array:
	var adj_rooms = []
	for room in rooms:
		var new_adj_rooms := _adjecent_rooms(room)
		for new_adj_room in new_adj_rooms:
			var not_in_rooms: bool = not new_adj_room in rooms
			var not_in_adj_rooms: bool = not new_adj_room in adj_rooms
			var doesnt_support: bool = not _supports_pattern(new_adj_room)
			if not_in_rooms and not_in_adj_rooms and doesnt_support:
				adj_rooms.append(new_adj_room)
	return adj_rooms

func _adjecent_rooms(room: Array) -> Array:
	return [
		_left(room),
		_right(room),
		_up(room),
		_down(room)
	]

func _supports_pattern(room: Array) -> bool:
	return _supports_pattern1(room) or \
		   _supports_pattern2(room) or \
		   _supports_pattern3(room) or \
		   _supports_pattern4(room)

func _supports_pattern1(room: Array) -> bool:
	return _left(room) in rooms and \
		   _left(_up(room)) in rooms and \
		   _up(room) in rooms

func _supports_pattern2(room: Array) -> bool:
	return _right(room) in rooms and \
		   _right(_up(room)) in rooms and \
		   _up(room) in rooms

func _supports_pattern3(room: Array) -> bool:
	return _left(room) in rooms and \
		   _left(_down(room)) in rooms and \
		   _down(room) in rooms

func _supports_pattern4(room: Array) -> bool:
	return _right(room) in rooms and \
		   _right(_down(room)) in rooms and \
		   _down(room) in rooms

func _neighbours(room: Array) -> int:
	var result := 0
	
	result += 1 if _left(room) in rooms else 0
	result += 1 if _right(room) in rooms else 0
	result += 1 if _up(room) in rooms else 0
	result += 1 if _down(room) in rooms else 0
	
	return result

func _left(room: Array) -> Array:
	return [room[0] - 1, room[1]]

func _right(room: Array) -> Array:
	return [room[0] + 1, room[1]]

func _up(room: Array) -> Array:
	return [room[0], room[1] + 1]

func _down(room: Array) -> Array:
	return [room[0], room[1] - 1]
