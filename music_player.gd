extends AudioStreamPlayer

var my_mptpb : AudioStreamPlaybackMPT

func load_music_file(file):
	stream = load(file)

func play_song(song:int):
	play() # playback
	if stream is AudioStreamMPT:
		if has_stream_playback(): # make sure before trying things due to crashes if null
			my_mptpb = get_stream_playback()
			my_mptpb.select_subsong(song) # should switch to start of next sequence/subsong, #2 in MPT
			stream.loop_mode = true
			# Hrrmm, not auto completing props/metho in editor after the last two ???
			print("subsong: ", my_mptpb.get_selected_subsong()) 
			
		else:
			print("No PLAYBACK AAAH!!!")
