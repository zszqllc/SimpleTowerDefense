extends Node

var arg = [0]
var UNIT
var DM

func _ready():
	UNIT = self.get_parent().get_parent() 
	DM   = UNIT.DM
	
	$BombTimer.wait_time = UNIT.ATT
	
func on_Dead():
	boom()

func on_Plant():
	$BombTimer.start()

func attack():
	pass

func _on_BombTimer_timeout():
	UNIT.on_Dead()

func boom():
	for area in UNIT.get_node("AttackArea").get_overlapping_areas():
		if "Enemy" in area.get_parent().name:
			for i in range(arg[0]):
				UNIT.LEVEL._on_EnergyTimer_timeout()
			area.get_parent().be_Stopped(arg[0])

