extends KinematicBody2D
#####################################################
const initial_speed = 200
const snapvectordefault = Vector2(0,32)
const snapvectordisabled = Vector2(0,0)
#####################################################
var gravity = 500
var fir = 1
var doublejump = true
var snapvector
#####################################################
var speed = initial_speed
var direction = Vector2(0,0)
var velocity = Vector2(0,0)
var friction = 0.95
#####################################################
func get_input():
	#Invert Gravity
	if Input.is_action_just_pressed("ui_focus_next")&&!is_traveling():
		snapvector=snapvectordisabled
		fir=fir*-1
		$Sprite.flip_v=!$Sprite.flip_v
	
	#Walk Left
	if Input.is_action_pressed("ui_left"):
		direction.x = -1
		get_node("Sprite/AnimationPlayer").play("Walk_Left")
	
	#Walk Right
	if Input.is_action_pressed("ui_right"):
		direction.x = 1
		get_node("Sprite/AnimationPlayer").play("Walk_Right")
	
	#Stop
	if !Input.is_action_pressed("ui_left")&&!Input.is_action_pressed("ui_right"):
		get_node("Sprite/AnimationPlayer").play("Idle")
	
	#Actions avaliable on floor
	if !is_traveling():
		#Activate Sprint
		if Input.is_action_just_pressed("ui_run"):
			speed*=3/1
			get_node("Sprite/AnimationPlayer").set_speed_scale(6)
		#Jump
		if Input.is_action_just_pressed("ui_jump"):
			snapvector=snapvectordisabled
			velocity.y = -500*fir

	#Reset Sprint
	if Input.is_action_just_released("ui_run"):
		speed=initial_speed
		get_node("Sprite/AnimationPlayer").set_speed_scale(2)
		
	#Doublejump
	if is_traveling():
		if Input.is_action_just_pressed("ui_jump")&&doublejump:
			move_and_collide(Vector2(-256,0)*direction)
			doublejump=false
	
	if !is_traveling():
		doublejump=true
#####################################################	
func is_traveling():
	if !is_on_floor()&&!is_on_ceiling():
		return 1
#####################################################
func _ready():
	pass # Replace with function body.
	get_node("Sprite/AnimationPlayer").set_speed_scale(2)
#####################################################
func _physics_process(delta):
	snapvector=snapvectordefault
	direction = Vector2(0,0)
	get_input()
	
	velocity.y += gravity*delta*fir
	
	#delta MUST NOT be factored into velocity here, since the _physics_process function is synced (but it has to be applied to gravity)
	velocity.x = speed*direction.x
	
	velocity=move_and_slide_with_snap(velocity, snapvector, Vector2(0,-1))