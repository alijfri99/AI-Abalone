extends Reference

class_name One

static func get_directions():
	return [BoardManager.L, BoardManager.UL, BoardManager.UR, \
			BoardManager.R, BoardManager.DR, BoardManager.DL]

static func is_legal(state, cell_number, piece, direction):
	if state.board[cell_number] != piece:
		return false
		
	var neighbor = BoardManager.neighbors[cell_number][direction]
	if neighbor == -1:
		return false
	else:
		if state.board[neighbor] == BoardManager.EMPTY:
			return true
		else:
			return false

static func execute(state, cell_number, piece, direction):
	var neighbor = BoardManager.neighbors[cell_number][direction]
	state.board[cell_number] = BoardManager.EMPTY
	state.board[neighbor] = piece
