extends Node
 
@export var stats: Node
@export var moneyLabel: Label
@export var winRewardLabel: Label
@export var winRewardUpgradeButton: Button
@export var maxSpawnLabel: Label
@export var maxSpawnUpgradeButton: Button

# These define how much the stats improve per upgrade
const COOLDOWN_INCREMENT = 0.5
const MONEY_INCREMENT = 50

func _ready():
	update_ui()

func upgrade_spawn_speed():
	if stats.money >= stats.spawn_rate_upgrade_cost:
		stats.money -= stats.spawn_rate_upgrade_cost
		stats.spawn_rate = stats.spawn_rate + COOLDOWN_INCREMENT
		stats.spawn_rate_upgrade_cost *= 1.2
		update_money_label()
		update_max_spawn_label()
		update_max_spawn_upgrade_label()

func upgrade_win_reward():
	if stats.money >= stats.win_reward_upgrade_cost:
		stats.money -= stats.win_reward_upgrade_cost
		stats.win_reward += MONEY_INCREMENT
		stats.win_reward_upgrade_cost *= 1.2
		update_money_label()
		update_win_reward_label()
		update_win_reward_upgrade_label()

func add_win_money():
	stats.money += stats.win_reward
	update_money_label()
	
func add_money(amount):
	stats.money += amount
	if stats.money < 0:
		stats.money = 0
	update_money_label()

func update_ui():
	update_money_label()
	update_win_reward_label()
	update_win_reward_upgrade_label()
	update_max_spawn_label()
	update_max_spawn_upgrade_label()
	
func update_money_label():
	moneyLabel.text = "Money: " + str(stats.money)
	
func update_win_reward_label():
	winRewardLabel.text = "Money per Win: " + str(stats.win_reward)

func update_win_reward_upgrade_label():
	winRewardUpgradeButton.text = "Upgrade (cost: " + str(stats.win_reward_upgrade_cost) + ")"

func update_max_spawn_label():
	maxSpawnLabel.text = "Max Spawn: " + str(stats.spawn_rate) + "/sec"

func update_max_spawn_upgrade_label():
	maxSpawnUpgradeButton.text = "Upgrade (cost: " + str(stats.spawn_rate_upgrade_cost) + ")"


func _on_spawn_on_click_ball_spawned() -> void:
	add_money(-stats.spawn_cost)

func _on_spawn_on_click_clicked() -> void:
	add_money(-stats.click_cost)

func _on_spawn_on_click_auto_spawn_toggled() -> void:
	add_money(-stats.toggle_cost)


func _on_win_reward_upgrade_pressed() -> void:
	upgrade_win_reward()

func _on_max_spawn_upgrade_pressed() -> void:
	upgrade_spawn_speed()
