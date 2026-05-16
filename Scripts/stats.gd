extends Node
class_name GameStats

@export var money: int = 100
@export var spawn_cost: int = 0
@export var click_cost: int = 0
@export var toggle_cost: int = 500
@export var spawn_rate: float = 1.0
@export var spawn_rate_upgrade_cost: int = 50
@export var win_reward: int = 100
@export var win_reward_upgrade_cost: int = 50
@export var bucket: int = 1
@export var bucket_upgrade_cost: int = 10000
@export var auto_spawn_level: int = 0
@export var auto_spawn_cursor: bool = false
@export var auto_spawn_upgrade_cost: int = 10000
