extends Node
@onready var state_handler:AnimationPlayer = $state_handler
@onready var menus:Node = $"../menus"
@export var deafault_menu:String = "options"
#for buttons
var sfx_volume:float = 90
var mus_volume:float = 80
var fullscreen:bool = false
var custom_cursors:bool = false
#
var menu_position:String = ""
var menu_options:Dictionary = {}
var option_nodes:Array = []
var option_id 
var cur_option_node
#
func command(cmd):
	match cmd:
		"example":
			print("Nothing happened!")
		"sfx_volume":
			Global.set_channel_volume(1,sfx_volume,"sfx_volume")
		"mus_volume":
			Global.set_channel_volume(2,mus_volume,"mus_volume")
		"toggle_fullscreen":
			Global.toggle_fullscreen(fullscreen)
			Global.config_save_setting("video","fullscreen",fullscreen)
		"custom_cursors":
			Global.config_save_setting("video","custom_cursors",custom_cursors)
			$"../NinePatchRect/options/VBoxContainer/custom_cursors/select_cursor_button".visible = custom_cursors
			if menu_position == "cursor_button":
				menu_position ="cursor"
		"controls":
			state_handler.play("configuration")
		"credits":
			state_handler.play("credits")
#
func _ready() -> void:
	state_handler.play("options")
	music_player.load_music_file("res://core/music/QualityTime_BigMoney.it")
	music_player.play_song(3)
	music_player.my_mptpb.seek(41,0)
	#
	sfx_volume = Global.config_get_setting("audio","sfx_volume")
	mus_volume = Global.config_get_setting("audio","mus_volume")
	fullscreen = Global.config_get_setting("video","fullscreen")
	custom_cursors = Global.config_get_setting("video","custom_cursors")
	$"../NinePatchRect/options/VBoxContainer/custom_cursors/select_cursor_button".visible = custom_cursors
	load_menu(deafault_menu)
#
func load_menu(menu):
	var grabbed_menu:Node = menus.get_node(menu)
	menu_options = str_to_var(grabbed_menu.menu_layout)
	option_nodes = grabbed_menu.options
	menu_position = grabbed_menu.def_item
#
func _process(delta: float) -> void:
	menu_input()
#
func menu_input():
	if cur_option_node is HSlider:
			cur_option_node.value += Input.get_axis("action_left","action_right")
	var input_vec = Vector2(
		int(Input.is_action_just_pressed("action_right"))-int(Input.is_action_just_pressed("action_left")),
		int(Input.is_action_just_pressed("action_down"))-int(Input.is_action_just_pressed("action_up"))
		)
	var direction:String
	if input_vec != Vector2.ZERO:
		direction = get_input_dir(input_vec)
		select_option(direction)
		

func get_input_dir(input_vec:Vector2):
	var direction:String
	if abs(input_vec.x) < abs(input_vec.y):
		direction = "down" if input_vec.y > 0 else "up"
	else:
		direction = "right" if input_vec.x > 0 else "left"
	return direction

func select_option(direction):
	var valid = false
	var option_name = menu_options[menu_position].get(direction,null)
	if option_name:
		option_id = menu_options["order"].find(option_name)
		if option_id == -1:
			print("you fucked up")
		var potential_option = option_nodes[option_id]
		if potential_option.visible:
			valid = true
		if valid:
			cur_option_node = potential_option
			menu_position = option_name
			cur_option_node.grab_focus()
