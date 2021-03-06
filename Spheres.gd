extends MeshInstance


##TO CONFIGURE VALUES OF TRIANGLES UN THIS MESH

var rings = 50
var radial_segments = 50
var height = 0.2
var radius = 0.5
export(SpatialMaterial) var material=null
var verts = PoolVector3Array()
var uvs = PoolVector2Array()
var normals = PoolVector3Array()
var indices = PoolIntArray()


func ready(value:int):
	
	for points in value:
		# PoolVectorXXArrays for mesh construction.
		var arr = []
		arr.resize(Mesh.ARRAY_MAX)
		
		var thisrow = 1
		var prevrow = 1
		var point =1 
		
		var surfTool = SurfaceTool.new() ##This is test
		
		var mesh = Mesh.new()
		#var material = SpatialMaterial.new()
		 
		#material.set_parameter(material.SPECULAR_SCHLICK_GGX, Color(1,0,0,1))
		
		for i in range(rings + 1):
			var v = float(i) / rings
			var w = sin(PI * v)
			var y = cos(PI * v)
	
			# Loop over segments in ring.
			for j in range(radial_segments):
				var u = float(j) / radial_segments
				var x = sin(u * PI * 2.0)
				var z = cos(u * PI * 2.0)
				var vert = Vector3(x * radius * w , y , z * radius * w)
				verts.append(vert)
				normals.append(vert.normalized())
				uvs.append(Vector2(u, v))
				point += 1
	
				# Create triangles in ring using indices.
				if i > 0 and j > 0:
					indices.append(prevrow + j - 1)
					indices.append(prevrow + j)
					indices.append(thisrow + j - 1)
	
					indices.append(prevrow + j)
					indices.append(thisrow + j)
					indices.append(thisrow + j - 1)
	
			if i > 0:
				indices.append(prevrow + radial_segments - 1)
				indices.append(prevrow)
				indices.append(thisrow + radial_segments - 1)
	
				indices.append(prevrow)
				indices.append(prevrow + radial_segments)
				indices.append(thisrow + radial_segments - 1)
	
			prevrow = thisrow
			thisrow = point
		
		
		
		arr[Mesh.ARRAY_VERTEX] = verts
		arr[Mesh.ARRAY_TEX_UV] = uvs
		arr[Mesh.ARRAY_NORMAL] = normals
		arr[Mesh.ARRAY_INDEX] = indices
		
		
		mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arr)
	
		self.set_mesh(mesh)
