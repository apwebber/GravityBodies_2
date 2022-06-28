extends Spatial


# Declare member variables here. Examples:
export (PackedScene) var body_scene

export var n_bodies = 3
export var gravity = 9.81
export var spawn_range = 500

var bodies: Array
var rng = RandomNumberGenerator.new()
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	rng.randomize()
	
	for i in n_bodies:
		var b = body_scene.instance()
		var x = rng.randf_range(-spawn_range, spawn_range)
		var z = rng.randf_range(-spawn_range, spawn_range)
		
		b.translation = Vector3(x,1,z)
		b.gravity_scale = gravity
		bodies.append(b)
		add_child(b)
		b.add_force(Vector3(10000,0,0), Vector3(0,0,0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	for b1 in bodies:
		for b2 in bodies:
			if b1 == b2:
				continue
				
			b1.attract(b2)
