extends Reference

class_name Move

static func is_legal(state, cell_number, piece, cluster_length, cluster_direction, move_direction):
	var direction_difference = cluster_direction - move_direction
	if direction_difference == 3 || direction_difference == 0:
		return is_directional_move_legal(state, cell_number, piece, cluster_length, cluster_direction, move_direction)
	else:
		return is_side_step_move_legal(state, cell_number, piece, cluster_length, cluster_direction, move_direction)
		
static func execute(state, cell_number, piece, cluster_length, cluster_direction, move_direction, status):
	if len(status) == 1:
		execute_side_step_move(state, cell_number, piece, cluster_length, cluster_direction, move_direction)
	else:
		execute_directional_move(state, piece, move_direction, status)
	
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
			return [true, starting_point, cluster_length, false] # move is legal, shift as many as 'cluster length' pieces, score does not change
		elif stats[3]: # opponent has space
			return [true, starting_point, stats[0] + stats[1], false]
		else:
			if stats[0] > stats[1] and stats[1] != 0:
				return [true, starting_point, stats[0] + stats[1] - 1, true] # score changes
			else:
				return [false]
				
static func execute_side_step_move(state, cell_number, piece, cluster_length, cluster_direction, move_direction):
	var current_point = cell_number
	for i in range(cluster_length):
		state.board[current_point] = BoardManager.EMPTY
		state.board[BoardManager.neighbors[current_point][move_direction]] = piece
		current_point = BoardManager.neighbors[current_point][cluster_direction]
		
static func execute_directional_move(state, piece, move_direction, status):
	var current_point = status[1]
	var n1 = 0
	var n2 = 0
	
	state.board[current_point] = BoardManager.EMPTY
	n1 = piece
	n2 = state.board[BoardManager.neighbors[current_point][move_direction]]
	current_point = BoardManager.neighbors[current_point][move_direction]
	for i in range(status[2]):
		state.board[current_point] = n1
		n1 = n2
		if i != status[2] - 1:
			n2 = state.board[BoardManager.neighbors[current_point][move_direction]]
		current_point = BoardManager.neighbors[current_point][move_direction]
	if status[3]:
		state.increase_score(piece)
		
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
