extends Node

var current_board = []
var neighbors = []
enum {EMPTY, BLACK, WHITE} # used to represent the board
enum {L, UL, UR, R, DR, DL} # used to represent the directions of neighbors

func _ready():
	init_board()
	# test_board()
	var state = State.new(current_board, 0, 0)
	state.board[32] = BLACK
	state.board[28] = WHITE
	Successor.calculate_successor(state, WHITE)
		
func init_board():
	var file = File.new()
	file.open("res://adjacency_lists.json", File.READ)
	var raw_data = file.get_as_text()
	var adjacency_lists = parse_json(raw_data)
	file.close() # reading the file that specifies the adjacency lists and converting it to a dictionary
	
	for i in range(61):
		var cell_value = EMPTY
		if (i >= 0 and i <= 10) or (i >= 13 and i <= 15):
			cell_value = WHITE
		elif (i >= 45 and i <= 47) or (i >= 50 and i <= 60):
			cell_value = BLACK
		else:
			cell_value = EMPTY # determining the value of the current board cell
		
		current_board.append(cell_value)
		neighbors.append(adjacency_lists[str(i)])

func get_nth_neighbor(cell_number, n, direction): # returns the nth neighbor of a cell in a given direction
		var neighbor = cell_number
		for i in range(n, 0, -1):
			neighbor = neighbors[neighbor][direction]
			if neighbor == -1:
				return -1
		return neighbor
		
func check_cluster(board, cell_number, piece, cluster_length, cluster_direction):
	if board[cell_number] != piece:
		return false
	
	var neighbor = cell_number
	for i in range(cluster_length, 1, -1):
		neighbor = neighbors[neighbor][cluster_direction]
		if neighbor == -1:
			return false
		elif board[neighbor] != piece:
			return false
	return true
	
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
