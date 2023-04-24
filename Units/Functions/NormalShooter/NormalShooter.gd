extends Node

var UNIT
var DM
var arg = [0]

func _ready():

	UNIT = self.get_parent().get_parent() 
	DM   = UNIT.DM
	
func on_Dead():
	pass

func on_Plant():
	pass

func attack():
	var center = UNIT.get_center_position()
	var to     = Vector2(center.x + 2000 , center.y)
	
	var path   = Path2D.new()
	
	var bullet = load("res://Units//Bullets/"+arg[0]+"/"+arg[0]+".tscn").instantiate()
	bullet.DM = self.DM
	
	var cu = Curve2D.new()
	cu.add_point(center)
	cu.add_point(to)
	path.curve = cu
	
	path.add_child(bullet)
	UNIT.LEVEL.add_child(path)
