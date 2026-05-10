extends Node
 
@export var stats: Node
@export var moneyLabel: Label
@export var winRewardLabel: Label
@export var winRewardUpgradeButton: Button
@export var maxSpawnLabel: Label
@export var maxSpawnUpgradeButton: Button
@export var shakeButton: Button
@export var bucketUpgradeButton: Button
@export var bucketLabel: Label
@export var autoSpawnNumberUpgradeButton: Button
@export var autoSpawnNumberLabel: Label

# These define how much the stats improve per upgrade
const COOLDOWN_INCREMENT = 0.1
const MONEY_INCREMENT = 50

signal ran_out_of_money()
signal bucket_upgraded()
signal spawn_rate_upgraded(rate: float, level: int)

func _ready():
	update_ui()
	add_money(0)

func upgrade_spawn_speed():
	if stats.money >= stats.spawn_rate_upgrade_cost:
		add_money(-stats.spawn_rate_upgrade_cost)
		stats.spawn_rate = stats.spawn_rate + COOLDOWN_INCREMENT
		stats.spawn_rate_upgrade_cost *= 1.2
		update_max_spawn_label()
		update_max_spawn_upgrade_label()
		update_shake_label()
		spawn_rate_upgraded.emit(stats.spawn_rate, stats.auto_spawn_level)

func upgrade_win_reward():
	if stats.money >= stats.win_reward_upgrade_cost:
		add_money(-stats.win_reward_upgrade_cost)
		stats.win_reward += MONEY_INCREMENT
		stats.win_reward_upgrade_cost *= 1.2
		update_win_reward_label()
		update_win_reward_upgrade_label()
		update_shake_label()

func upgrade_bucket():
	if stats.money >= stats.bucket_upgrade_cost:
		add_money(-stats.bucket_upgrade_cost)
		stats.bucket += 1
		stats.bucket_upgrade_cost *= 10
		update_bucket_label()
		update_bucket_upgrade_label()
		bucket_upgraded.emit()

func upgrade_auto_spawn_number():
	if stats.money >= stats.auto_spawn_upgrade_cost:
		add_money(-stats.auto_spawn_upgrade_cost)
		stats.auto_spawn_level += 1
		stats.auto_spawn_upgrade_cost *= 10
		update_auto_spawn_number_label()
		update_auto_spawn_number_upgrade_label()
		spawn_rate_upgraded.emit(stats.spawn_rate, stats.auto_spawn_level)

func add_win_money():
	add_money(stats.win_reward)
	
func add_money(amount):
	stats.money += amount
	if stats.money < 0:
		stats.money = 0
		emit_signal("ran_out_of_money")
	update_money_label()
	winRewardUpgradeButton.disabled = stats.money < stats.win_reward_upgrade_cost
	maxSpawnUpgradeButton.disabled = stats.money < stats.spawn_rate_upgrade_cost
	bucketUpgradeButton.disabled = stats.money < stats.bucket_upgrade_cost
	autoSpawnNumberUpgradeButton.disabled = stats.money < stats.auto_spawn_upgrade_cost
	shakeButton.disabled = stats.money < get_shake_cost()

func get_shake_cost() -> int:
	return stats.win_reward_upgrade_cost + stats.spawn_rate_upgrade_cost

func update_ui():
	update_money_label()
	update_win_reward_label()
	update_win_reward_upgrade_label()
	update_max_spawn_label()
	update_max_spawn_upgrade_label()
	update_bucket_label()
	update_bucket_upgrade_label()
	update_auto_spawn_number_label()
	update_auto_spawn_number_upgrade_label()
	update_shake_label()
	
func update_money_label():
	moneyLabel.text = "Money: " + format_number_with_commas(stats.money)
	
func update_win_reward_label():
	winRewardLabel.text = "Money per Win: " + format_number_with_commas(stats.win_reward)

func update_win_reward_upgrade_label():
	winRewardUpgradeButton.text = "Upgrade (" + format_number_with_commas(stats.win_reward_upgrade_cost) + ")"

func update_max_spawn_label():
	maxSpawnLabel.text = "Max Spawn: " + format_number_with_commas(stats.spawn_rate) + "/sec"

func update_max_spawn_upgrade_label():
	maxSpawnUpgradeButton.text = "Upgrade (" + format_number_with_commas(stats.spawn_rate_upgrade_cost) + ")"

func update_bucket_label():
	bucketLabel.text = "Buckets: " + format_number_with_commas(stats.bucket)

func update_bucket_upgrade_label():
	bucketUpgradeButton.text = "Upgrade (" + format_number_with_commas(stats.bucket_upgrade_cost) + ")"

func update_auto_spawn_number_label():
	autoSpawnNumberLabel.text = "Auto Spawner: " + format_number_with_commas(stats.auto_spawn_level)

func update_auto_spawn_number_upgrade_label():
	autoSpawnNumberUpgradeButton.text = "Upgrade (" + format_number_with_commas(stats.auto_spawn_upgrade_cost) + ")"

func update_shake_label():
	shakeButton.text = "Shake (" + str(get_shake_cost()) + ")"

func _on_spawn_on_click_ball_spawned() -> void:
	add_money(-stats.spawn_cost)

func _on_auto_spawner_ball_spawned() -> void:
	add_money(-stats.spawn_cost)

func _on_spawn_on_click_clicked() -> void:
	add_money(-stats.click_cost)

func _on_spawn_on_click_auto_spawn_toggled() -> void:
	add_money(-stats.toggle_cost)


func _on_win_reward_upgrade_pressed() -> void:
	upgrade_win_reward()

func _on_max_spawn_upgrade_pressed() -> void:
	upgrade_spawn_speed()

func _on_bucket_upgrade_pressed() -> void:
	upgrade_bucket()

func _on_auto_spawn_button_pressed() -> void:
	upgrade_auto_spawn_number()

func _on_shake_button_shake_screen_signal() -> void:
	add_money(-get_shake_cost())


func format_number_with_commas(number: Variant) -> String:
	var val_float = float(number)
	var is_negative = val_float < 0
	var full_str = str(abs(val_float))
	
	var parts = full_str.split(".")
	var int_part = parts[0]
	var dec_part = parts[1] if parts.size() > 1 else ""
	
	var formatted_int = ""
	var count = 0
	for i in range(int_part.length() - 1, -1, -1):
		formatted_int = int_part[i] + formatted_int
		count += 1
		if count % 3 == 0 and i != 0:
			formatted_int = "," + formatted_int
			
	var result = formatted_int
	if dec_part != "":
		result += "." + dec_part
		
	if is_negative:
		result = "-" + result
		
	return result
