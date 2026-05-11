extends AudioStreamPlayer2D

func _ready():
	SignalBus.play_receive_coin.connect(play_receive_coin)

func play_receive_coin():
	play()
