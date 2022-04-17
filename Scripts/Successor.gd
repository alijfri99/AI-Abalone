extends Node

var actions = [One]

func calculate_successor(state, piece): # calculates all the successor states of a state, given a piece
	var result = []
	for cell_number in range(len(state.board)):
		if state.board[cell_number] == piece:
			for action in actions:
				for direction in action.get_directions():
					if action.is_legal(state, cell_number, piece, direction):
						print(direction, ", ", cell_number)
						var successor_state = State.new(state.board, state.black_score, state.white_score)
						action.execute(successor_state, cell_number, piece, direction)
						result.append(successor_state)
	return result
