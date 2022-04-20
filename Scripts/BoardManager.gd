extends Node

var current_board = []
var neighbors = []
enum {EMPTY, BLACK, WHITE} # used to represent the board
enum {L, UL, UR, R, DR, DL} # used to represent the directions of neighbors
var successors = []
var i = 0

func _ready():
	init_board()
	# test_board()
	current_board[26] = BLACK
	current_board[27] = BLACK
	current_board[28] = WHITE
	current_board[29] = WHITE
	current_board[30] = WHITE
	current_board[36] = WHITE
	current_board[43] = BLACK
	var state = State.new(current_board, 0, 0)
	successors = Successor.calculate_successor(state, WHITE)	
	print(len(successors))

func init_board():
	var file = File.new()
	file.open("res://adjacency_lists.json", File.READ)
	var raw_data = file.get_as_text()
	var adjacency_lists = parse_json(raw_data)
	file.close() # reading the file that specifies the adjacency lists and converting it to a dictionary
	
	for i in range(61):
		var cell_value = EMPTY
		if (i >= 0 and i <= 10) or (i >= 13 and i <= 15):
			cell_value = BLACK
		elif (i >= 45 and i <= 47) or (i >= 50 and i <= 60):
			cell_value = WHITE
		else:
			cell_value = EMPTY # determining the value of the current board cell
		
		current_board.append(cell_value)
		neighbors.append(adjacency_lists[str(i)])
		
func check_cluster(board, cell_number, piece, cluster_length, cluster_direction):
	if board[cell_number] != piece:
		return false
	
	var neighbor = cell_number
	for i in range(1, cluster_length):
		neighbor = neighbors[neighbor][cluster_direction]
		if neighbor == -1:
			return false
		elif board[neighbor] != piece:
			return false
	return true
	
func get_stats(board, cell_number, piece, cluster_length, cluster_direction):
	var num_side_pieces = 0
	var num_opponent_pieces = 0
	var piece_has_space = false
	var opponent_has_space = false
	var is_sandwich = false
	
	var current_point = cell_number
	for i in range(0, cluster_length + cluster_length):
		if board[current_point] == piece:
			if num_opponent_pieces > 0:
				is_sandwich = true
				break
			else:	
				num_side_pieces += 1
				if neighbors[current_point][cluster_direction] != -1:
					if board[neighbors[current_point][cluster_direction]] == EMPTY and i == cluster_length - 1:
						piece_has_space = true
						break
					
		elif board[current_point] == EMPTY:
			continue
			
		else: # opponent
			if num_side_pieces == cluster_length:
				num_opponent_pieces += 1
			if neighbors[current_point][cluster_direction] != -1:
				if board[neighbors[current_point][cluster_direction]] == EMPTY and piece_has_space == false and num_side_pieces == cluster_length and i != cluster_length + cluster_length - 1:
					opponent_has_space = true
					break
		
		current_point = neighbors[current_point][cluster_direction]
		if current_point == -1:
			break
	return {"number of side pieces" : num_side_pieces, "number of opponent pieces" : num_opponent_pieces, \
			"piece has space" : piece_has_space, "opponent has space" : opponent_has_space, 
			"is sandwich" : is_sandwich}
	
func test_board():
	for i in range(61):
		if neighbors[i][L] != -1: # check the correctness of left neighbors
			if neighbors[neighbors[i][L]][R] != i:
				print("Incorrect Left Neighbor: ", i, ", ", neighbors[neighbors[i][L]][R])
				
		if neighbors[i][UL] != -1: # check the correctness of up left neighbors
			if neighbors[neighbors[i][UL]][DR] != i:
				print("Incorrect Up Left Neighbor: ", i, ", ", neighbors[neighbors[i][UL]][DR])
		
		if neighbors[i][UR] != -1: # check the correctness of up right neighbors
			if neighbors[neighbors[i][UR]][DL] != i:
				print("Incorrect Up Right Neighbor: ", i, ", ", neighbors[neighbors[i][UR]][DL])
				
		if neighbors[i][R] != -1: # check the correctness of right neighbors
			if neighbors[neighbors[i][R]][L] != i:
				print("Incorrect Right Neighbor: ", i, ", ", neighbors[neighbors[i][R]][L])
				
		if neighbors[i][DR] != -1: # check the correctness of down right neighbors
			if neighbors[neighbors[i][DR]][UL] != i:
				print("Incorrect Down Right Neighbor: ", i, ", ", neighbors[neighbors[i][DR]][UL])
				
		if neighbors[i][DL] != -1:
			if neighbors[neighbors[i][DL]][UR] != i:
				print("Incorrect Down Left Neighbor: ", i, ", ", neighbors[neighbors[i][DL]][UR])
