extends CharacterBody3D

var direction : Vector2
var accel : Vector2
var movement : Vector3
var speed = 500.0
var yaccel = 0.0
var interacting = false
@export var sens = 0.13

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	direction = Vector2(int(Input.is_action_pressed("moveEast"))-int(Input.is_action_pressed("moveWest")),int(Input.is_action_pressed("moveSouth"))-int(Input.is_action_pressed("moveNorth")))
	direction = direction.normalized()
	direction = direction.rotated(-rotation.y)
	movement = Vector3(direction.x, 0, direction.y)
	if is_on_floor():
		yaccel = 1
	else:
		yaccel += 1
	#move_and_collide(movement * delta * speed)
	set_velocity(Vector3.DOWN * yaccel + movement * delta * speed)
	move_and_slide()
	if $Camera3D/RayCast3D.is_colliding() and not interacting:
		interacting = true
		if $Camera3D/RayCast3D.get_collider().get("hintName") != "":
			$"../UI/CursorHint".visible = true
			$"../UI/CursorHint/Hint".text = $Camera3D/RayCast3D.get_collider().get("hintName")
		else:
			$"../UI/CursorHint".visible = false
		var tween = get_tree().create_tween().set_trans(Tween.TRANS_ELASTIC)
		tween.tween_property($"../UI/CursorContainer/Cursor", "rotation", 360.0, 0.4)
		tween.parallel().tween_property($"../UI/CursorContainer/Cursor", "modulate", Color(1, 1, 1, 1), 0.4)
		tween.parallel().tween_property($"../UI/CursorHint", "modulate", Color(1, 1, 1, 1), 0.4)
		tween.play()
	elif not $Camera3D/RayCast3D.is_colliding() and interacting:
		interacting = false
		var tween = get_tree().create_tween().set_trans(Tween.TRANS_ELASTIC)
		tween.tween_property($"../UI/CursorContainer/Cursor", "rotation", 0.0, 0.4)
		tween.parallel().tween_property($"../UI/CursorContainer/Cursor", "modulate", Color(1, 1, 1, 0), 0.4)
		tween.parallel().tween_property($"../UI/CursorHint", "modulate", Color(1, 1, 1, 0), 0.4)
		tween.play()


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * sens
		$Camera3D.rotation_degrees.x -= event.relative.y * sens
		$Camera3D.rotation_degrees.x = clamp($Camera3D.rotation_degrees.x, -90, 90)
	if event is InputEventMouseButton and event.is_pressed():
		if $Camera3D/RayCast3D.is_colliding():
			$Camera3D/RayCast3D.get_collider().call("interact")
