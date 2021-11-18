extends Reference
class_name RouglikeMap


var rooms: Array
var boss_room: int = -1


func _init(n: int):
	var rng := RandomNumberGenerator.new()
	rng.randomize()
	var adjecent_rooms := [] + adjecent_rooms_for([0, 0])
	rooms = [[0, 0]]
	while len(rooms) < n:
		var random_new_room_id := rng.randi() % len(adjecent_rooms)
		var new_room = adjecent_rooms[random_new_room_id]
		if neighbours_count(new_room, rooms) <= 2:
			adjecent_rooms.remove(random_new_room_id)
			rooms.append(new_room)
			
			var new_adjecent_rooms := adjecent_rooms_for(new_room)
			for new_adj_room in new_adjecent_rooms:
				if not (new_adj_room in rooms) and not (new_adj_room in adjecent_rooms):
					adjecent_rooms.append(new_adj_room)
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
			if new_dist > max_dist and plus_shape_neighbours_count(room, rooms) == 1:
				max_dist = new_dist
				boss_room = i

func adjecent_rooms_for(room: Array) -> Array:
	return [
		[room[0] - 1, room[1]],
		[room[0] + 1, room[1]],
		[room[0], room[1] - 1],
		[room[0], room[1] + 1]
	]

func plus_shape_neighbours_count(room: Array, _rooms: Array) -> int:
	var rooms_number := 0
	
	rooms_number += 1 if [room[0], room[1] - 1] in _rooms else 0 # u
	rooms_number += 1 if [room[0] - 1, room[1]] in _rooms else 0 # l
	rooms_number += 1 if [room[0] + 1, room[1]] in _rooms else 0 # r
	rooms_number += 1 if [room[0], room[1] + 1] in _rooms else 0 # d
	
	return rooms_number

func neighbours_count(room: Array, _rooms: Array) -> int:
	var rooms_number := 0
	
	rooms_number += 1 if [room[0] - 1, room[1] - 1] in _rooms else 0 # lu
	rooms_number += 1 if [room[0], room[1] - 1] in _rooms else 0 # u
	rooms_number += 1 if [room[0] + 1, room[1] - 1] in _rooms else 0 # ru
	rooms_number += 1 if [room[0] - 1, room[1]] in _rooms else 0 # l
	rooms_number += 1 if [room[0] + 1, room[1]] in _rooms else 0 # r
	rooms_number += 1 if [room[0] - 1, room[1] + 1] in _rooms else 0 # ld
	rooms_number += 1 if [room[0], room[1] + 1] in _rooms else 0 # d
	rooms_number += 1 if [room[0] + 1, room[1] + 1] in _rooms else 0 # rd
	
	return rooms_number
