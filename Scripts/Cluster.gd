extends Reference

class_name Cluster

enum {ONE, TWO_R, TWO_DR, TWO_DL, THREE_R, THREE_DR, THREE_DL} # refers to the different orientations of clusters
var cell_number
var cluster_type

func _init(cell_number, cluster_type):
	self.cell_number = cell_number
	self.cluster_type = cluster_type
