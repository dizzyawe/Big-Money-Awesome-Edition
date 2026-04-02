extends Node2D

# Store play times of audio instances
var sfx_play_times := {}
func playsound(stream: String, sfx_name: String):
	if not find_child(name):
		var instance = AudioStreamPlayer.new()
		instance.stream = load(stream)
		instance.bus = "sfx"
		instance.name = sfx_name
		instance.finished.connect(remove_node.bind(instance))
		add_child(instance)
		instance.play()
		
		# Store the start time
		sfx_play_times[name] = Time.get_ticks_msec() / 1000.0 # in seconds
func is_sfx_playing(sfx_name: String) -> bool:
	return get_node_or_null(sfx_name) != null

func remove_node(instance: AudioStreamPlayer):
	sfx_play_times.erase(instance.name)
	instance.queue_free()

func stop_sound(id):
	var instance = get_node_or_null(id)
	if instance != null:
		remove_node(instance)

func set_sfx_pitch(id,pitch):
	var instance:AudioStreamPlayer = get_node_or_null(id)
	instance.pitch_scale = pitch

func get_current_beat(sfx_name: String, bpm: float) -> int:
	if not sfx_play_times.has(sfx_name):
		return -1

	var elapsed_time:float = (Time.get_ticks_msec() / 1000.0) - sfx_play_times[name]
	var beat_duration:float = 60.0 / bpm
	return int(elapsed_time / beat_duration)
