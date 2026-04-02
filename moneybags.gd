extends Sprite2D
@onready var anim = $animations
@export var goal:Node2D
@export var smoothing_speed:int = 10
enum anim_states {
	idle,
	speaking
	
	
}
var anim_state:anim_states = anim_states.idle
var velocity:Vector2 = Vector2.ZERO
var at_goal = false
signal reached_goal


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	velocity = _delta * hld(goal.position-position,velocity,100,3)
	
	position += _delta * velocity
	if round(position) == goal.position:
		if !at_goal:
			at_goal = true
			emit_signal("reached_goal")
	else:
		at_goal = false
	
	rotation = (velocity.x/4)/360
	if anim_state == anim_states.idle:
		if !anim.is_playing():
			anim.play(str("idle_",randi_range(0,3)))
func hld(ds:Vector2,vel:Vector2,stf:float,damp:float):
	return (stf*ds)-(damp*vel)

func play_anim(input):
	anim_state = anim_states.speaking
	anim.play(input)
	await anim.animation_finished
	anim_state = anim_states.idle
