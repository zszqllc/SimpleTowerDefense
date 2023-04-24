extends Node2D

var type
var LEVEL

var id

var HP
var DM
var COST
var ATT
var CD
var NAME
var AREA

var DF
var BLOCK

var TAR = 0
var IS_A = false

var Flash = preload("res://Tools/Snapshot.tscn").instantiate()

signal att
signal dead
signal plant

func _ready():
	type_change(type)
	
	$AttackTimer.wait_time = ATT
	
	for function in $Functions.get_children():
		connect("att"  , Callable (function , "attack"))
		connect("plant", Callable (function , "on_Plant"))
		connect("dead" , Callable (function , "on_Dead"))
	
	$NAME.text = str(NAME)
	$COST.text = str(COST)
	
	$ColorRect.show()
	$CDTimer.wait_time = CD
	$CDTimer.start()
	
	add_child(Flash)
	Flash.position = Vector2(32,32)
	
func be_hit(DM1):
	Flash.light_on()
	if DM1 - DF >= 0:
		HP -= DM1 - DF
	else:
		HP -= 1
	if HP <= 0:
		on_Dead()

func on_Plant():
	LEVEL = self.get_parent().get_parent().get_parent().get_parent()
	$NAME.hide()
	$COST.hide()
	
	$AttackTimer.start()
	emit_signal("plant")

func on_Dead():
	emit_signal("dead")
	queue_free()

func type_change(type):
	var JsonFile = FileAccess.open("res://Jsons/Unit.json",FileAccess.READ)
	var jsonData = JSON.parse_string(JsonFile.get_as_text())
	
	id     = jsonData["Units"][type]["id"]
	NAME   = jsonData["Units"][type]["name"]
	HP     = jsonData["Units"][type]["HP"]
	DM     = jsonData["Units"][type]["DM"]
	COST   = jsonData["Units"][type]["cost"]
	ATT    = jsonData["Units"][type]["ATT"]
	AREA   = jsonData["Units"][type]["area"]
	CD     = jsonData["Units"][type]["CD"]
	DF     = jsonData["Units"][type]["DF"]
	BLOCK  = jsonData["Units"][type]["BLOCK"]
	
	
	$Sprite.texture = load(jsonData["Units"][type]["texture"])
	
	for funcNAME in jsonData["Units"][type]["functions"]:
		var funcPATH = "res://Units/Functions/"+funcNAME+"/"+funcNAME+".tscn"
		var function = load(funcPATH).instantiate()
		
		for i in range(len(jsonData["Units"][type]["args"][funcNAME])):
			function.arg[i] = jsonData["Units"][type]["args"][funcNAME][i]
		$Functions.add_child(function)
	if AREA != "":
		$AttackArea.add_child(load("res://Units/Areas/"+AREA+"/"+AREA+".tscn").instantiate())
	
func attack():
	emit_signal("att")

func _on_AttackTimer_timeout():
	if TAR > 0:
		attack()

func get_center_position() -> Vector2:
	var glb = self.to_global(position)
	return Vector2(glb.x + 32 , glb.y +32)

func _on_AttackArea_area_entered(area):
	if "Enemy" in area.get_parent().name:
		TAR += 1 

func _on_AttackArea_area_exited(area):
	if "Enemy" in area.get_parent().name:
		TAR -= 1 


func _on_CDTimer_timeout():
	$ColorRect.hide()
	IS_A = true
