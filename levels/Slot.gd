extends PanelContainer

var LEVEL
@export var Disabled = false

func _ready():
	LEVEL = self.get_parent().get_parent().get_parent()

func _can_drop_data(position, data):
	if data and data.name == "DELETE":
		return true
	if data and LEVEL.ENERGY >= data.COST:
		return true
	return false

func _drop_data(position, data):
	if data and data.name == "DELETE" and get_child(0) != null:
		LEVEL.energy_change(get_child(0).COST)
		get_child(0).on_Dead()
	if data and data.name != "DELETE" and get_child(0) == null:
		data.get_parent().remove_child(data)
		self.add_child(data)
		data.on_Plant()
		
		LEVEL.energy_change(-data.COST)
		
		if LEVEL.LEVEL_TYPE == 0:
			LEVEL.add_Unit_To_Storge(data.type)
		

