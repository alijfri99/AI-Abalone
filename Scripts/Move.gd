extends Reference

class_name Move

static func is_legal(state, cell_number, piece, cluster_length, cluster_direction, move_direction):
	var direction_difference = cluster_direction - move_direction
	if direction_difference == 3 || direction_difference == 0:
		#return is_side_directional_move_legal(state, cell_number, piece, cluster_length, cluster_direction, move_direction)
		pass
	else:
		return is_side_step_move_legal(state, cell_number, piece, cluster_length, cluster_direction, move_direction)
	
static func is_side_step_move_legal(state, cell_number, piece, cluster_length, cluster_direction, move_direction):
	var neighbor = BoardManager.neighbors[cell_number][move_direction]
	if neighbor == -1:
		return false
	else:
		if BoardManager.check_cluster(state.board, neighbor, BoardManager.EMPTY, cluster_length, cluster_direction):
			return true
		else:
			return false
	
static func is_directional_move_legal(state, cell_number, piece, cluster_length, cluster_direction, move_direction):
	pass
	
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
