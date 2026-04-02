extends Node2D
@onready var dealer = $moneybags
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	music_player.load_music_file("res://core/music/QualityTime_BigMoney.it")
	music_player.play_song(4)
	
	dealer.play_anim("welcome")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
