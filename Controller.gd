tool
extends Spatial
const ROT_SPEED = 0.15
var rot_x = 0
var rot_y = 0
var rot_z = 0
onready var initial_cam_rot = $Camera.rotation
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var p = Array()

var zoom_factor = 1.1

func _ready():
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)



func _process(delta):
	var speed = 50
	var direction = Vector3()
	if Input.is_action_pressed("key_forward"):
		direction -= $Camera.get_transform().basis.z
	if Input.is_action_pressed("key_backward"):
		direction += $Camera.get_transform().basis.z

	if Input.is_action_pressed("key_left"):
		direction -= $Camera.get_transform().basis.x
	if Input.is_action_pressed("key_right"):
		direction += $Camera.get_transform().basis.x

	$Camera.global_translate(direction * speed * delta)
	
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		p.clear()
		#p.append(get_node("point").transform.origin) # Replace with function body.
		#p.append(get_node("point2").transform.origin)
		#p.append(get_node("point3").transform.origin)
		#p.append(get_node("point4").transform.origin)
		
		#var ig = get_node("draw")
		#ig.clear()
		#ig.begin(Mesh.PRIMITIVE_LINE_LOOP)
		
		#for x in p:
		#	ig.add_vertex(x)
		#ig.end()


func _unhandled_input(ev):
	if (ev is InputEventMouseButton and ev.button_mask == BUTTON_MASK_LEFT):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if (ev is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED):
		rot_y += (ev.relative.x * ROT_SPEED)
		rot_z += (ev.relative.y * ROT_SPEED)

		var t = Transform()
		t = t.rotated(Vector3(1,0,0),(-rot_z * PI / 180.0) + initial_cam_rot.z)
		t = t.rotated(Vector3(0,1,0),(-rot_y * PI / 180.0) + initial_cam_rot.y)

		$Camera.transform.basis = t.basis

	if (ev.is_action_pressed("ui_cancel")):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
