extends Node2D

const SETTINGS_FILE_PATH = "user://config/"
var config = ConfigFile.new()

var events:Dictionary = {}
var is_first_playthrough:bool = false

func _ready() -> void:
	if !FileAccess.file_exists(SETTINGS_FILE_PATH):
		make_preset_config()
	else:
		load_config()

func make_preset_config():
	config.set_value("version","id","0.1")
	#VIDEO
	config.set_value("video","fullscreen",false)
	config.set_value("video","custom_cursors",false)
	#AUDIO
	config.set_value("audio","sfx_volume",100.0)
	config.set_value("audio","mus_volume",100.0)
	
	
	config.save(SETTINGS_FILE_PATH)

func load_config():
	config.load(SETTINGS_FILE_PATH)
	if config.get_value("video","fullscreen",false):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	set_channel_volume(1,config.get_value("audio","sfx_volume"),"sfx_volume")
	set_channel_volume(2,config.get_value("audio","mus_volume"),"mus_volume")


func config_save_setting(type,key,value):
	config.set_value(type,key,value)
	config.save(SETTINGS_FILE_PATH)

func config_get_setting(type,key):
	return config.get_value(type,key,null)

func print_settings():
	print(config.encode_to_text())

func toggle_fullscreen(full:bool):
	if full:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		config.set_value("video","fullscreen",true)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		config.set_value("video","fullscreen",false)

func set_channel_volume(channel:int,vol:float,save = null):
	AudioServer.set_bus_volume_db(channel,-100+vol+1)
	AudioServer.set_bus_mute(channel,vol < 50)
	if save:
		config.set_value("audio",save,vol)
		config.save(SETTINGS_FILE_PATH)
	else:
		print(str(channel," ",vol))
