extends Node
@export_custom(PROPERTY_HINT_EXPRESSION,"") var menu_layout:String = """{ 
	"order":["music","music","sfx","fullscreen","cursor","cusor_button","scores","controls","credits","done"],
	"origin": "music", 
	"music": {"up":"done","down":"sfx"},
	"sfx": {"up":"music","down":"music"},
	"fullscreen": {"up":"sfx","down":"cursor"},
	"cursor": {"up":"fullscreen","down":"scores","right":"cursor_button"}, "cursor_button":{"up":"fullscreen","down":"scores","left":"cursor"},
	"scores": {"up":"cursor","down":"controls"},
	"controls": {"up":"scores","down":"done","right":"credits"},"credits": {"up":"scores","down":"done","left":"controls"},
	"done": {"up":"controls","down":"music"}
}"""
@export var def_item:String = ""
@export var options:Array[Node] = [] # in order from the menu layout


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
