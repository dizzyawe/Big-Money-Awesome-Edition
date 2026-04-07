extends CheckBox
var first_frame = true

@export var corresponding_value:String = ""
@export var node:Node
@export var sound:String
@export var cmd:String
#
func _ready() -> void:
	button_pressed = node.get(corresponding_value)
	first_frame = false
#
func change_value():
	node.set(corresponding_value,button_pressed)
#
func _on_pressed() -> void:
	if first_frame:
		return
	change_value()
	if sound:
		sfx_player.playsound(sound,"v")
	if cmd:
		node.command(cmd)
