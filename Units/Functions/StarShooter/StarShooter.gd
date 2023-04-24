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
	var center  = UNIT.get_center_position()
	
	var to1     = Vector2(center.x + 2000 , center.y      )
	var to2     = Vector2(center.x - 2000 , center.y      )
	var to3     = Vector2(center.x        , center.y-2000 )
	var to4     = Vector2(center.x + 2000 , center.y+2000 )
	var to5     = Vector2(center.x - 2000 , center.y+2000 )
	
	var bullet1 = load("res://Units//Bullets/"+arg[0]+"/"+arg[0]+".tscn").instantiate()
	var bullet2 = load("res://Units//Bullets/"+arg[0]+"/"+arg[0]+".tscn").instantiate()
	var bullet3 = load("res://Units//Bullets/"+arg[0]+"/"+arg[0]+".tscn").instantiate()
	var bullet4 = load("res://Units//Bullets/"+arg[0]+"/"+arg[0]+".tscn").instantiate()
	var bullet5 = load("res://Units//Bullets/"+arg[0]+"/"+arg[0]+".tscn").instantiate()
	
	bullet1.DM  = self.DM
	bullet2.DM  = self.DM
	bullet3.DM  = self.DM
	bullet4.DM  = self.DM
	bullet5.DM  = self.DM
	
	var cu1     = Curve2D.new()
	var cu2     = Curve2D.new()
	var cu3     = Curve2D.new()
	var cu4     = Curve2D.new()
	var cu5     = Curve2D.new()
	
	var path1   = Path2D.new()
	var path2   = Path2D.new()
	var path3   = Path2D.new()
	var path4   = Path2D.new()
	var path5   = Path2D.new()
	
	cu1.add_point(center)
	cu1.add_point(to1)
	path1.curve = cu1
	
	cu2.add_point(center)
	cu2.add_point(to2)
	path2.curve = cu2
	
	cu3.add_point(center)
	cu3.add_point(to3)
	path3.curve = cu3
	
	cu4.add_point(center)
	cu4.add_point(to4)
	path4.curve = cu4
	
	cu5.add_point(center)
	cu5.add_point(to5)
	path5.curve = cu5
	
	path1.add_child(bullet1)
	path2.add_child(bullet2)
	path3.add_child(bullet3)
	path4.add_child(bullet4)
	path5.add_child(bullet5)
	
	UNIT.LEVEL.add_child(path1)
	UNIT.LEVEL.add_child(path2)
	UNIT.LEVEL.add_child(path3)
	UNIT.LEVEL.add_child(path4)
	UNIT.LEVEL.add_child(path5)
