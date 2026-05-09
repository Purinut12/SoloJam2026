extends Node

var stats = GameStats.new() # In a real game, you'd load this from a file

# These define how much the stats improve per upgrade
const COOLDOWN_REDUCTION = 0.1
const MONEY_INCREMENT = 5
var speed_upgrade_cost = 100
var reward_upgrade_cost = 200

func upgrade_spawn_speed():
	if stats.money >= speed_upgrade_cost:
		stats.money -= speed_upgrade_cost
		stats.spawn_cooldown = max(0.2, stats.spawn_cooldown - COOLDOWN_REDUCTION)
		speed_upgrade_cost *= 2
		update_ui()

func upgrade_win_reward():
	if stats.money >= reward_upgrade_cost:
		stats.money -= reward_upgrade_cost
		stats.money_per_win += MONEY_INCREMENT
		reward_upgrade_cost *= 2
		update_ui()

func add_win_money():
	stats.money += stats.money_per_win
	update_ui()

func update_ui():
	get_node("../HUD/MoneyLabel").text = "Money: " + str(stats.money)
