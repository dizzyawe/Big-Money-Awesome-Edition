extends Camera2D
var world_position = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x = get_viewport().size.x*0.5
	position.y = 480-get_viewport().size.y*0.5
	position += world_position
