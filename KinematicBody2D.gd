extends KinematicBody2D

var speed = 150
var jumpspeed = 350
var friction = 0.95
var velocity = Vector2()
var gravity = 500
var snapVector = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func get_input():
	if Input.is_key_pressed(KEY_D):
		$AnimatedSprite.play("run")
		$Position2D.position.x = 265
		$Position2D.rotation_degrees = -90
		$AnimatedSprite.flip_h = false
		
		velocity.x = speed
	if Input.is_key_pressed(KEY_A):
		$AnimatedSprite.play("run")
		$Position2D.position.x = -265
		$Position2D.rotation_degrees = 90
		$AnimatedSprite.flip_h = true
		velocity.x = -speed
	if is_on_floor() && Input.is_key_pressed(KEY_SPACE):
		velocity.y = -jumpspeed
		$AnimatedSprite.play("jump")
		snapVector = Vector2(0,0)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity.y += gravity * delta
	get_input()
	for i in range(0,get_slide_count()):
		var collider = get_slide_collision(i)
		var normal = collider.normal
		
		if collider.collider.name == "Platform2":
			snapVector = Vector2(0,32)
			velocity.y = get_floor_velocity().y
	
	velocity.x *= friction
	velocity = move_and_slide_with_snap(velocity, snapVector, Vector2(0,-1))
	
#	pass

