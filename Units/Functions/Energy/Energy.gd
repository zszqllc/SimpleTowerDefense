extends Node

var arg = [0]
var UNIT

func _ready():
	UNIT = self.get_parent().get_parent() 
	
func on_Dead():
	UNIT.LEVEL.ENERGYSPEED -= arg[0]
	UNIT.LEVEL.energy_change(0)

func on_Plant():
	UNIT.LEVEL.ENERGYSPEED += arg[0]
	UNIT.LEVEL.energy_change(0)

func attack():
	pass
