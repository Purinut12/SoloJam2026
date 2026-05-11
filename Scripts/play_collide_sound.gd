extends AudioStreamPlayer2D

func _ready():
	SignalBus.play_collide_sound.connect(play_collide_sound)

func play_collide_sound():
	play()
