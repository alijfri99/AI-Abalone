extends Reference

class_name Cluster

enum {ONE, TWO_S, TWO_LD, TWO_RD, THREE_S, THREE_LD, THREE_RD} # specifies the types of clusters. S stands for straight, LD for left-diagonal, RD for right_diagonal
var i
var j
var cluster_type

func _init(i, j, cluster_type):
	self.i = i
	self.j = j
	self.cluster_type = cluster_type
