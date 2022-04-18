extends Reference

class_name ClusterFinder

#static func find_one_clusters(board, piece): # finds all 'ONE' clusters of type 'piece' on a board
#	var result = []
#	for cell_number in range(len(board)):
#		if check_one_cluster(board, cell_number, piece):
#			var new_one_cluster = Cluster.new(cell_number, Cluster.ONE)
#			result.append(new_one_cluster)
#	return result
#
#func find_two_clusters(board, direction, piece): # finds all two-element clusters of type 'piece' in a given direction on a board
#	var result = []
#	for cell_number in range(len(board)):
#		if check_two_cluster(board, cell_number, direction, piece):
#			var new_cluster = Cluster.new(cell_number, direction - 2) # mapping between the directions in BoardManager and Cluster classes
#			result.append(new_cluster)
#	return result
#
#func find_three_clusters(board, direction, piece): # finds all three-element clusters of type 'piece' in a given direction on a board
#	var result = []
#	for cell_number in range(len(board)):
#		if check_three_cluster(board, cell_number, direction, piece):
#			var new_cluster = Cluster.new(cell_number, direction + 1)
#			result.append(new_cluster)
#	return result

#static func check_one_cluster(board, cell_number, piece): # checks if there is a one-element cluster of type 'piece' at a given cell number on a board
#	if board[cell_number] == piece:
#		return true
#	else:
#		return false

#static func check_two_cluster(board, cell_number, direction, piece): # checks if there is a two-element cluster of type 'piece' in a specific direction at a given cell number on a board
#	var neighbor_number = BoardManager.neighbors[cell_number][direction]
#	if neighbor_number != -1: # if this cell has a neighbor in the given direction
#		if board[cell_number] == piece and board[neighbor_number] == piece:
#			return true
#		else:
#			return false
#	else:
#		return false
#
#static func check_three_cluster(board, cell_number, direction, piece): # checks if there is a three-element cluster of type 'piece' in a specific direction at a given cell number on a board
#	var neighbor_number = BoardManager.neighbors[cell_number][direction]
#	if neighbor_number != -1:
#		if check_two_cluster(board, cell_number, direction, piece) and check_two_cluster(board, neighbor_number, direction, piece):
#			return true
#		else:
#			return false
#	else:
#		return false

static func check_cluster(board, cell_number, piece, cluster_length, direction):
	if board[cell_number] != piece:
		return false
	
	var neighbor = cell_number
	for i in range(cluster_length, 1, -1):
		neighbor = BoardManager.neighbors[neighbor][direction]
		if neighbor == -1:
			return false
		elif board[neighbor] != piece:
			return false
	return true
