extends Node

export (PackedScene) var MOB_TURRET

var time_score
var spawns = []
var spawns_turret = []

func _ready():
	get_tree().paused = true

func init_spawns():
	spawns = get_tree().get_nodes_in_group("Spawn")
	spawns_turret = get_tree().get_nodes_in_group("Spawn")

func start_spikes():
	# Resume execution the next frame
	yield(get_tree(), "idle_frame")
	# Start spikes nodes
	var spikes = get_tree().get_nodes_in_group("Spikes")
	for spike in spikes:
		spike.start()

func clean_mobs():
	var mobs = get_tree().get_nodes_in_group("Mob")
	for mob in mobs:
		mob.queue_free()

func clean_bullets():
	var bullets = get_tree().get_nodes_in_group("Bullet")
	for bullet in bullets:
		bullet.queue_free()

func game_over():
	get_tree().paused = true
	$HUD.show_game_over()
	$Timers/TimeScoreTimer.stop()
	$Timers/MobTurretTimer.stop()

func set_spawn_available(spawn):
	spawns_turret.insert(spawns_turret.size(), spawn)

func new_game():
	get_tree().paused = false
	# Reset score
	time_score = 0
	$HUD.update_score(time_score)
	# Start player node 
	$Player.start($StartPosition.position)
	# Launch timers 
	$Timers/TimeScoreTimer.start()
	$Timers/MobTurretTimer.start()
	# Restart spikes
	start_spikes()
	#cleanning mobs & bullets
	clean_mobs()
	clean_bullets()
	#reset spawn available for mob turret
	init_spawns()


func _on_TimeScoreTimer_timeout():
	time_score += $Timers/TimeScoreTimer.wait_time
	$HUD.update_score(time_score)


func _on_MobTurretTimer_timeout():
	# if there is spawn available
	if spawns_turret.size() > 0:
		#choose one randomly
		var i = rand_range(0, spawns_turret.size()-1)
		var spawn = spawns_turret[i]
		# Remove spawn from available list
		spawns_turret.remove(i)
		# Creating the mob
		var mob = MOB_TURRET.instance()
		get_parent().add_child(mob)
		mob.start(spawn)
