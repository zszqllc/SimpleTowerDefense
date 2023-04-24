extends Node2D

var ob

var screen_halfx
var screen_halfy
	
var fullsceen

func _ready():
	screen_halfx = get_viewport().size.x/2
	screen_halfy = get_viewport().size.y/2

	
	var back = $back
	back.set_position(Vector2(0, 0))
	back.set_size(Vector2(get_viewport().size.x, get_viewport().size.y))
	
	var tabcont = TabContainer.new()
	
	var psize = 400
	var panel_main = Panel.new()
	panel_main.set_position(Vector2(20, 20))
	panel_main.set_size(Vector2(psize, psize))
	panel_main.name = "Main"
	
	var vflowcont_main = HFlowContainer.new()
	
	var back_button = Button.new()
	back_button.set_position(Vector2(20, 20))
	back_button.text = "Return to GAME"
	back_button.connect("pressed", self._cancel)
	back_button.connect("pressed", Callable(get_parent(),"Stop_Game_Togg"))
	
	var cancel_button = Button.new()
	cancel_button.set_position(Vector2(20, 20))
	cancel_button.text = "Return to MENU"
	cancel_button.connect("pressed", Callable(get_parent(), "back_to_main"))
	back_button.connect("pressed", Callable(get_parent(),"Stop_Game_Togg"))
	
	var restart_button = Button.new()
	restart_button.set_position(Vector2(20, 20))
	restart_button.text = "RESTART"
	restart_button.connect("pressed", Callable(get_parent(), ""))
	
	vflowcont_main.add_child(back_button)
	vflowcont_main.add_child(cancel_button)
	vflowcont_main.add_child(restart_button)
	
	var panel_settings = Panel.new()
	panel_settings.set_position(Vector2(20, 20))
	panel_settings.set_size(Vector2(psize, psize))
	panel_settings.name = "Settings"
	
	var vflowcont_settings = HFlowContainer.new()
	vflowcont_settings.set_position(Vector2(10, 10))
	
	ob = OptionButton.new()
	
	ob.add_item("-")
	ob.add_item("480x360")
	ob.add_item("1280x720")
	ob.add_item("1600x920")
	ob.add_item("1920x1080")
	ob.select(0)
	
	ob.connect("item_selected", self._handle_resolution_change)
	
	var fullscreen = CheckBox.new()
	fullscreen.connect("pressed", self._handle_fullscreen)
	fullscreen.text = "fullscreen"
	
	vflowcont_settings.add_child(ob)
	vflowcont_settings.add_child(fullscreen)
	
	
	
	var panel_help = Panel.new()
	panel_help.set_position(Vector2(20, 20))
	panel_help.set_size(Vector2(psize, psize))
	panel_help.name = "Help"
	
	tabcont.set_position(Vector2(screen_halfx-0.5*psize, screen_halfy-0.5*psize))
	tabcont.set_size(Vector2(psize, psize))
	tabcont.add_child(panel_main)
	tabcont.add_child(panel_settings)
	tabcont.add_child(panel_help)
	
	tabcont.get_tab_control(0).add_child(vflowcont_main)
	tabcont.get_tab_control(1).add_child(vflowcont_settings)
	
	add_child(tabcont)
	
func _cancel():
	self.queue_free()
	
func _handle_resolution_change(selected):
	var selection = ob.get_item_text(selected)
	if selection == "1920x1080":
		DisplayServer.window_set_size(Vector2i(1920, 1080))
		get_viewport().size = Vector2i(1920, 1080)
	elif selection == "1600x920":
		DisplayServer.window_set_size(Vector2i(1600, 920))
		get_viewport().size = Vector2i(1600, 920)
	elif selection == "1280x720":
		DisplayServer.window_set_size(Vector2i(1280, 720))
		get_viewport().size = Vector2i(1280, 720)
	elif selection == "480x360":
		DisplayServer.window_set_size(Vector2i(480, 360))
		get_viewport().size = Vector2i(480, 360)
		
	screen_halfx = get_viewport().size.x/2
	screen_halfy = get_viewport().size.y/2
pass

func _handle_fullscreen():
	fullsceen = !fullsceen
	if fullsceen == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	screen_halfx = get_viewport().size.x/2
	screen_halfy = get_viewport().size.y/2
pass
