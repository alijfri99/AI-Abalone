extends Node

func calculate_successor(state, piece): # calculates all the successor states of a state, given a piece
	var result = []
	for cell_number in range(len(state.board)):
		if state.board[cell_number] == piece:
			for cluster_length in range(1, 4):
				for cluster_direction in Move.get_possible_cluster_directions(cluster_length):
					if BoardManager.check_cluster(state.board, cell_number, piece, cluster_length, cluster_direction):
						for move_direction in Move.get_possible_move_directions(cluster_length, cluster_direction):
							if Move.is_legal(state, cell_number, piece, cluster_length, cluster_direction, move_direction):
								print(cell_number, ", ", cluster_length, ", ", cluster_direction, ", ", move_direction)
#						print(direction, ", ", cell_number)
#						var successor_state = State.new(state.board, state.black_score, state.white_score)
#						action.execute(successor_state, cell_number, piece, direction)
#						result.append(successor_state)
