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
#
func _process(_delta: float) -> void:
	position = bounce(0.12,goal.position,position,_delta) 
	if round(position) == goal.position: 
		if !at_goal:
			at_goal = true
			emit_signal("reached_goal")
	else:
		at_goal = false
	rotation = (velocity.x)/50
	if anim_state == anim_states.idle:
		if !anim.is_playing():
			anim.play(str("idle_",randi_range(0,3)))

func bounce(damping,goal_pos,input_vector,deltatime):
	velocity += (goal_pos - input_vector) * (1 - damping) * deltatime
	velocity = velocity * (1 - damping)
	return input_vector + velocity 

func play_anim(input):
	if Global.config_get_setting("audio","sfx_volume") > 49:
		anim_state = anim_states.speaking
		anim.play(input)
		await anim.animation_finished
	anim_state = anim_states.idle
