extends Node
@onready var state_handler = $state_handler
#for buttons
var sfx_volume:float = 90
var mus_volume:float = 80
var fullscreen:bool = false
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
		"controls":
			state_handler.play("configuration")
		"credits":
			state_handler.play("credits")
#
func _ready() -> void:
	music_player.load_music_file("res://core/music/QualityTime_BigMoney.it")
	music_player.play_song(3)
	music_player.my_mptpb.seek(41,0)
	#
	sfx_volume = Global.config_get_setting("audio","sfx_volume")
	mus_volume = Global.config_get_setting("audio","mus_volume")
	fullscreen = Global.config_get_setting("video","fullscreen")
