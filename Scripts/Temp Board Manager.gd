extends Node

enum {EMPTY, BLACK, WHITE}
var current_state = []

func _ready():
	current_state.append(fill_row(5, 0, 4, WHITE))
	current_state.append(fill_row(6, 0, 5, WHITE))
	current_state.append(fill_row(7, 2, 4, WHITE))
	current_state.append(fill_row(8, 0, 7, EMPTY))
	current_state.append(fill_row(9, 0, 8, EMPTY))
	current_state.append(fill_row(8, 0, 7, EMPTY))
	current_state.append(fill_row(7, 2, 4, BLACK))
	current_state.append(fill_row(6, 0, 5, BLACK))
	current_state.append(fill_row(5, 0, 4, BLACK))
	var l = find_three_clusters(current_state, BLACK)
	print(l)

func fill_row(row_size, start, finish, element): # fills a row with 'element' from the 'start' column to the 'end' column
	var result = []
	for i in range(row_size):
		if i >= start and i <= finish:
			result.append(element)
		else:
			result.append(EMPTY)
	return result
	
func find_one_clusters(state, element): # finds all the 1-element clusters of 'element' in a state
		var result = []
		for row in range(len(state)):
			for column in range(len(state[row])):
				if state[row][column] == element:
					var new_cluster = Cluster.new(row, column, Cluster.ONE)
					result.append(new_cluster)
		return result
		
func find_two_clusters(state, element): # finds all the 2-element clusters of 'element' in a state
	var result = []
	for row in range(len(state)):
		for column in range(len(state[row])):
			if check_two_s_cluster(state, row, column, element):
				var new_two_s_cluster = Cluster.new(row, column, Cluster.TWO_S)
				result.append(new_two_s_cluster)
				
			if check_two_ld_cluster(state, row, column, element):
				var new_two_ld_cluster = Cluster.new(row, column, Cluster.TWO_LD)
				result.append(new_two_ld_cluster)
				
			if check_two_rd_cluster(state, row, column, element):
				var new_two_rd_cluster = Cluster.new(row, column, Cluster.TWO_RD)
				result.append(new_two_rd_cluster)
	return result
	
func find_three_clusters(state, element): # finds all the 2-element clusters of 'element' in a state
	var result = []
	for row in range(len(state)):
		for column in range(len(state[row])):
			if check_three_s_cluster(state, row, column, element):
				var new_three_s_cluster = Cluster.new(row, column, Cluster.THREE_S)
				result.append(new_three_s_cluster)
				
			if check_three_ld_cluster(state, row, column, element):
				var new_three_ld_cluster = Cluster.new(row, column, Cluster.THREE_LD)
				result.append(new_three_ld_cluster)
				
			if check_three_rd_cluster(state, row, column, element):
				var new_three_rd_cluster = Cluster.new(row, column, Cluster.THREE_RD)
				result.append(new_three_rd_cluster)
	return result
			
func check_two_s_cluster(state, row, column, element): # checks the existence of a 'TWO_S' cluster of type 'element' in a state, starting from a specific row and column
	if (column + 1) < len(state[row]): # checking to see if the next column in the row exists
		if state[row][column] == element and state[row][column + 1] == element:
			return true
		else:
			return false
	else: # there is no next element in the row
		return false
			
func check_two_ld_cluster(state, row, column, element): # checks the existence of a 'TWO_LD' cluster of type 'element' in a state, starting from a specific row and column
	if (row + 1) < len(state): # checking to see if the next row exists
		if len(state[row]) < len(state[row + 1]): # checking in the upper half of the board is different from checking in the lower half
			if state[row][column] == element and state[row + 1][column] == element:
				return true
			else:
				return false
		else:
			if (column - 1) >= 0: # checking to see if the previous column exists in the next row
				if state[row][column] == element and state[row + 1][column - 1] == element:
					return true
				else:
					return false
			else:
				return false
	else: # there is no next row
		return false
		
func check_two_rd_cluster(state, row, column, element): # checks the existence of a 'TWO_RD' cluster of type 'element' in a state, starting from a specific row and column
	if (row + 1) < len(state): # checks to see if the next row exists
		if len(state[row]) < len(state[row + 1]):
			if state[row][column] == element and state[row + 1][column + 1] == element:
				return true
			else:
				return false
		else:
			if column < len(state[row + 1]): # checking to see if the current column exists in the next row
				if state[row][column] == element and state[row + 1][column] == element:
					return true
				else:
					return false
			else:
				return false
	else: # there is no next row
		return false
		
func check_three_s_cluster(state, row, column, element): # checks the existence of a 'THREE_S' cluster of type 'element' in a state, starting from a specific row and column
	if (column + 1) < len(state[row]):
		if check_two_s_cluster(state, row, column, element) and check_two_s_cluster(state, row, column + 1, element):
			return true
		else:
			return false
	else:
		return false
		
func check_three_ld_cluster(state, row, column, element): # checks the existence of a 'THREE_LD' cluster of type 'element' in a state, starting from a specific row and column
	if (row + 1) < len(state):
		if len(state[row]) < len(state[row + 1]):
			if check_two_ld_cluster(state, row, column, element) and check_two_ld_cluster(state, row + 1, column,element):
				return true
			else:
				return false
		else:
			if (column - 1) >= 0:
				if check_two_ld_cluster(state, row, column, element) and check_two_ld_cluster(state, row + 1, column - 1, element):
					return true
				else:
					return false
			else:
				return false
	else:
		return false
		
func check_three_rd_cluster(state, row, column, element): # checks the existence of a 'THREE_RD' cluster of type 'element' in a state, starting from a specific row and column
	if (row + 1) < len(state):
		if len(state[row]) < len(state[row + 1]):
			if check_two_rd_cluster(state, row, column, element) and check_two_rd_cluster(state, row + 1, column + 1, element):
				return true
			else:
				return false
		else:
			if column < len(state[row + 1]):
				if check_two_rd_cluster(state, row, column, element) and check_two_rd_cluster(state, row + 1, column, element):
					return true
				else:
					return false
			else:
				return false
	else:
		return false
