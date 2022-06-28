extends RigidBody


# Declare member variables here. Examples:
var rng = RandomNumberGenerator.new()

export var max_mass = 10.0
export var min_mass = 0.1
export var max_mu = 0.1
export var min_mu = 0.001
export var attraction_multiplyer = 10

var my_mass
var my_mu
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	#Randomly assign a mass, this sets the mass and changes the size
	rng.randomize()
	my_mass = rng.randf_range(min_mass, max_mass)
	mass = my_mass
	
	my_mu = rng.randf_range(min_mu, max_mu)
	
	var volume = my_mass / my_mu
	var diameter = pow(3 * (volume / (4 * 3.14)),0.333)
	
	scale_object_local(Vector3(diameter, diameter, diameter))
	
	#Colour of the material is darkened by an amount according to the mu
	#mu is mapped between 0 and 1
	var normalized = (my_mu - min_mu) / (max_mu - min_mu)
	var material = $MeshInstance.get_surface_material(0)
	var col = material.albedo_color
	col = col.darkened(normalized)
	
	#Make a new material and set the albedo to the darkened colour
	var sm = SpatialMaterial.new()
	sm.albedo_color = col
	$MeshInstance.set_surface_material(0, sm)
	

func attract(m):
	var a_pos = global_transform.origin
	var m_pos = m.global_transform.origin
	var force = m_pos.direction_to(a_pos)
	
	#Scale force according to mass
	force = force * my_mass * attraction_multiplyer
	m.add_force(force, Vector3(0,0,0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
