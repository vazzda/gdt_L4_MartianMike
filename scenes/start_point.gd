extends StaticBody2D

@onready var spawnPos = $SpawnPosition

func getSpawnPosition():
	return spawnPos.global_position
