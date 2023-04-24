extends Node2D

signal Start_Game
var Level = load("res://levels/Level.tscn") as PackedScene
var select = load("res://levels/select.tscn.tscn") as PackedScene

func _ready():
	Level = Level.instantiate()

func _on_Level11_pressed():
	Level.LEVEL_NAME = "1-1"
	get_parent().add_child(Level)
	start_game()
	
func start_game():
	emit_signal("Start_Game")
	self.hide()

func game_over():
	Level = load("res://levels/Level.tscn").instantiate()
	self.show()

func _on_Level12_pressed():
	Level.LEVEL_NAME = "1-2"
	get_parent().add_child(Level)
	start_game()


func _on_Level13_pressed():
	Level.LEVEL_NAME = "1-3"
	get_parent().add_child(Level)
	start_game()


func _on_Levelremote_pressed():
	pass # Replace with function body.

func _on_select_pressed():
	get_parent().add_child(select)
	self.hide()
