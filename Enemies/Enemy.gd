extends PathFollow2D

var SPEED
var V
var HP

var NAME
var DM
var ATT

var LEVEL

var type

var TAR

var Flash = preload("res://Tools/Snapshot.tscn").instantiate()

func _ready():
	typechange()
	
	V = SPEED
	var LEN = self.get_parent().curve.get_baked_length()
	$AttackTimer.wait_time = ATT
	progress = LEN

	add_child(Flash)
	

func be_hit(DM1):
	Flash.light_on()
	HP -= DM1
	if HP <= 0:
		on_Dead()

func on_Dead():
	LEVEL.Del_ES()
	queue_free()

func _process(delta):
	progress -= V * delta * 20
	if progress <= 50:
		on_Dead()

func _on_Area_area_entered(area):
	if "Bullet" in area.get_parent().name and area.name != "Boom":
		var Bullet = area.get_parent()
		be_hit(Bullet.DM)
		Bullet.on_hit()

	if "Unit" in area.get_parent().name and "Unit" in area.name:
		V = 0
		$AttackTimer.start()
		TAR = area.get_parent()

func _on_AttackTimer_timeout():
	if !is_instance_valid(TAR):
		$AttackTimer.stop()
		V = SPEED
		TAR = null
	else:
		TAR.be_hit(DM)

func typechange():
	var file = FileAccess.open("res://Jsons/Enemy.json",FileAccess.READ)
	var jsonData = JSON.parse_string(file.get_as_text())
	
	SPEED= jsonData["Enemies"][type]["SPEED"]
	NAME = jsonData["Enemies"][type]["name"]
	HP   = jsonData["Enemies"][type]["HP"]
	DM   = jsonData["Enemies"][type]["DM"]
	ATT  = jsonData["Enemies"][type]["ATT"]
	
	SPEED *= randf_range(0.75,1.0)
	$Sprite.texture = load(jsonData["Enemies"][type]["texture"])
	
func be_Stopped(arg):
	V = 0
	$FunctionTimers/StopTimer.wait_time = arg
	$FunctionTimers/StopTimer.start()

func _on_StopTimer_timeout():
	$FunctionTimers/StopTimer.stop()
	if TAR == null:
		V = SPEED
