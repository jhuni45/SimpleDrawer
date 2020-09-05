extends MeshInstance

var numbers_of_lines = 500
var numbers_of_spheres= 100
export(SpatialMaterial) var material=null

func _ready():
	var LineDrawer = preload("res://lines.gd").new()
	var SphereDrawer= preload("res://Spheres.gd").new()
	add_child(LineDrawer)
	add_child(SphereDrawer)
	for lines in numbers_of_lines:
		var rand_x_origin = randi()%960+1
		var rand_x_end = randi()%960+1
		var rand_y_origin = randi()%540+1
		var rand_y_end = randi()%540+1
		var rand_z_origin = randi()%540+1
		var rand_z_end = randi()%540+1
		if lines%2==0:
			rand_x_origin= rand_x_origin*-1
		elif lines%1==0:
			rand_y_origin= rand_y_origin*-1
		LineDrawer.DrawLine(Vector3(rand_x_origin, rand_y_origin, rand_z_origin), Vector3(rand_x_end, rand_y_end, rand_z_end), Color(1, 1, 0,0.5), 0.5)
	
	#for cubes in numbers_of/2:
	#	var center= randi()%540+1
	#	var axis= randi()%540+1
	#	if center%2==0:
	#		center=center*-1
		#LineDrawer.DrawCube(Vector3(axis, center, axis ), 3, Color(1, 0, 0))
	
	SphereDrawer.ready(numbers_of_spheres)

