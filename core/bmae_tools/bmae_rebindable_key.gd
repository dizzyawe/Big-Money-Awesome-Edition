extends HBoxContainer
var key_name = "select"
@onready var label = $key_name

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = key_name


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
