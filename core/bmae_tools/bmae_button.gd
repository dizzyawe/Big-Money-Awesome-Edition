extends Button
@export var cmd:String = ""
@export var menu_handler:Node

func press():
	sfx_player.playsound("res://core/sfx/buttonclick.ogg","button_click")
	menu_handler.command(cmd)

func _on_pressed() -> void:
	press()
