extends Reference

class_name Move

static func is_legal(state, cell_number, piece, cluster_length, cluster_direction, move_direction):
	var direction_difference = cluster_direction - move_direction
	if direction_difference == 3 || direction_difference == 0:
		return is_directional_move_legal(state, cell_number, piece, cluster_length, cluster_direction, move_direction)
	else:
		return is_side_step_move_legal(state, cell_number, piece, cluster_length, cluster_direction, move_direction)
	
static func is_side_step_move_legal(state, cell_number, piece, cluster_length, cluster_direction, move_direction):
	var neighbor = BoardManager.neighbors[cell_number][move_direction]
	if neighbor == -1:
		return [false]
	else:
		if BoardManager.check_cluster(state.board, neighbor, BoardManager.EMPTY, cluster_length, cluster_direction):
			return [true]
		else:
			return [false]
	
static func is_directional_move_legal(state, cell_number, piece, cluster_length, cluster_direction, move_direction):
	var starting_point = cell_number
	if cluster_direction - move_direction == 3:
		for i in range(1, cluster_length):
			starting_point = BoardManager.neighbors[starting_point][cluster_direction]
		
	var stats = BoardManager.get_stats(state.board, starting_point, piece, cluster_length, move_direction)

	if stats[4] == true: # sandwich
		return [false]
	else:
		if stats[2]: # piece has space
			return [true, cluster_length, false] # move is legal, shift as many as 'cluster length' pieces, score does not change
		elif stats[3]: # opponent has space
			return [true, stats[0] + stats[1], false]
		else:
			if stats[0] > stats[1] and stats[1] != 0:
				return [true, stats[0] + stats[1] - 1, true] # score changes
			else:
				return [false]
		
static func get_possible_cluster_directions(cluster_length):
	if cluster_length == 1:
		return [BoardManager.R]
	else:
		return [BoardManager.R, BoardManager.DR, BoardManager.DL]
		
static func get_possible_move_directions(cluster_length, cluster_direction):
	if cluster_length == 1:
		return [BoardManager.L, BoardManager.UL, BoardManager.UR, BoardManager.R, \
				BoardManager.DR, BoardManager.DL]
	else:
		if cluster_direction == BoardManager.DR:
			return [BoardManager.L, BoardManager.UL, BoardManager.R, BoardManager.DR]
		elif cluster_direction == BoardManager.DL:
			return [BoardManager.L, BoardManager.UR, BoardManager.R, BoardManager.DL]
		else:
			return [BoardManager.L, BoardManager.UL, BoardManager.UR, BoardManager.R, \
				BoardManager.DR, BoardManager.DL]
