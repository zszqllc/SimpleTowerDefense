extends Node2D

var MAPname 
var MAP        
var UNIT        = preload("res://Units/Unit.tscn")

var LEVEL_NAME

var SET         = []
var WAVES       = []

var rng         = RandomNumberGenerator.new()

var WAVE_COUNT
var LEVEL_TYPE

var UNITS_COUNT
var ENERMIES_COUNT

var all_ES       = 0

var ENERMIES_SET = []

var ENERGY       = 225
var ENERGYSPEED  = 5

func _ready():
	read_level_json()
	read_unit_json()
	read_enemy_json()
	
	$Container/WAVES.text = "LEFT WAVES: " + str(WAVE_COUNT)
	
	MAP = load("res://levels/Maps/"+MAPname+".tscn").instantiate()
	self.add_child(MAP)
	
	for i in range(UNITS_COUNT):
		if i in UserStorge.Selected_Units:
			add_Unit_To_Storge(i)
	energy_change(0)

func read_level_json():
	var file     = FileAccess.open("res://Jsons/Levels.json",FileAccess.READ)
	var jsonStr  = file.get_as_text()
	var jsonData = JSON.parse_string(jsonStr)
	
	WAVE_COUNT   = len(jsonData[LEVEL_NAME]["count"])
	LEVEL_TYPE   = int(jsonData[LEVEL_NAME]["type"])
	MAPname      = jsonData[LEVEL_NAME]["map"]
	
	for i in range(WAVE_COUNT):
		WAVES.append(int(jsonData[LEVEL_NAME]["count"][i]))

func read_unit_json():
	var file     = FileAccess.open("res://Jsons/Unit.json",FileAccess.READ)
	var jsonStr  = file.get_as_text()
	var jsonData = JSON.parse_string(jsonStr)
	
	UNITS_COUNT  = jsonData["index"]


func read_enemy_json():
	var file      = FileAccess.open("res://Jsons/Enemy.json",FileAccess.READ)
	var jsonStr   = file.get_as_text()
	var jsonData  = JSON.parse_string(jsonStr)
	
	ENERMIES_COUNT = jsonData["index"]


func _on_Debug_pressed():
	add_Unit_To_Storge(randi() % int(UNITS_COUNT))

func _on_Stop_pressed():
	Stop_Game_Togg()

func _on_Back_pressed():
	Stop_Game_Togg()
	var stm = load("res://levels/SettingMenu.tscn") as PackedScene
	self.add_child(stm.instantiate())

func Del_ES():
	all_ES -= 1
	if all_ES == 0 and WAVE_COUNT == 0:
		pass

var STOP_FLAG = false		
func Stop_Game_Togg():
	if !STOP_FLAG:
		self.get_tree().paused = true
		STOP_FLAG              = true
		$Container/Buttons/Stop.text     = "GOON"
	else:
		self.get_tree().paused = false
		STOP_FLAG              = false
		$Container/Buttons/Stop.text     = "STOP"

func add_Unit_To_Storge(arg):
	for store in $UnitStorge.get_children():
		if (store.name != "EnergyPanel" and store.name != "DeletePanel" and !store.get_child(0)):
			var unit  = UNIT.instantiate()
			unit.type = arg
			SET.append(unit)
			store.add_child(unit)
			unit.z_index = 2
			break


func summon_enemy(way = randi()%6):
	var ENEMY = load("res://Enemies/Enemy.tscn").instantiate()
	ENEMY.type = randi() % int(ENERMIES_COUNT)
	MAP.get_child(0).get_child(way).add_child(ENEMY)
	ENERMIES_SET.append(ENEMY)
	
	ENEMY.LEVEL = self
	all_ES += 1
	
func _on_WaveTimer_timeout():
	#print(WAVE_COUNT)
	var PartFlag = [1,1,1,1,1,1]
	if WAVE_COUNT > 0:
		for i in range(WAVES[-WAVE_COUNT]):
			var way = randi()%6
			if PartFlag[way] == 1:
				var Part = load("res://Tools/FlowPart.tscn").instantiate()
				MAP.get_child(0).get_child(way).add_child(Part)
				PartFlag[way] = 0
			summon_enemy(way)
		WAVE_COUNT  -= 1
		$Container/WAVES.text =  "LEFT WAVES: " + str(WAVE_COUNT)
	
func energy_change(arg):
	ENERGY          += arg
	$ENERGY.text    =  str(ENERGY)
	$ENSPEED.text   =  str(ENERGYSPEED) + " /s"


func _on_EnergyTimer_timeout():
	energy_change(ENERGYSPEED)

func _input(event):
	if event.is_action_pressed("stop_togg"):
		Stop_Game_Togg()


func Win():
	back_to_main()

func back_to_main():
	self.queue_free()
	self.get_parent().get_node("LevelChange").game_over()

func _exit_tree():
	self.get_tree().paused = false
	STOP_FLAG              = false
