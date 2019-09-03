extends KinematicBody2D
#####################################################
const initial_speed = 400
#####################################################
var gravity = 955
var fir = 1
var doublejump = true
#####################################################
var speed = initial_speed
var direction = Vector2(1,0)
var velocity = Vector2(0,0)
#####################################################
var timer
var dashed = false
var collision
var stepped_on_invisible = false
#####################################################
signal ImDead
signal OnInvisible
#####################################################
var standard_sprite_region = Rect2(128,192,64,64)
var startpos = Vector2(-25, 992)
#####################################################
#####################################################
func resetAttributes():
	position = startpos
	speed = initial_speed
	gravity = 955
	fir = 1
	direction = Vector2(1,0)
	velocity = Vector2(0,0)
	dashed = false
	$Sprite.region_rect = standard_sprite_region
	$Sprite.flip_v = false
	$Trail.clear_points()
#####################################################
func momGetTheCamera():
	var camera = $"../Camera"
	
	#$"..".remove_child()
	#$"..".abortion()
	$"..".fetusDeletus()
	
	add_child(camera)
#####################################################
func get_input():
	#Invert Gravity
	if Input.is_action_just_pressed("ui_focus_next")&&!is_travelling():
		fir=fir*-1
		$Sprite.flip_v=!$Sprite.flip_v
	
	#Actions avaliable on floor
	if !is_travelling():
		
		#Jump
		if Input.is_action_pressed("ui_jump"):
			velocity.y = -515*fir
	
	#Dash
	if is_travelling():
		if Input.is_action_just_pressed("ui_run") && dashed == false:
			speed *= 15
			dashed = true
			timer.start()
	
	#Doublejump
	if is_travelling():
		if Input.is_action_just_pressed("ui_jump")&&doublejump:
			doublejump=false
	
	if !is_travelling():
		doublejump=true
#####################################################
func is_travelling():
	if !is_on_floor()&&!is_on_ceiling():
		return 1
#####################################################
func on_gameover():
	$Sprite.region_rect=Rect2(128,256,64,64)
	get_tree().paused = true
	$Trail.clear_points()
#####################################################
func on_timeout_complete():
	dashed = false
	speed = initial_speed
#####################################################

func _ready():
	momGetTheCamera()
	
	resetAttributes()
	
	timer = Timer.new()
	timer.wait_time = 0.042
	timer.connect("timeout",self,"on_timeout_complete")
	add_child(timer)
	
	connect("ImDead", self, "on_gameover")
	connect("ImDead", $"../DeathScreen", "gameover_panel")
	connect("OnInvisible", $"../Map", "onInvisible")
	
#####################################################

func _physics_process(delta):
	
	get_input()
	
	velocity.y += gravity*delta*fir
	
	velocity.x = speed*direction.x
	
	#######################################
	velocity=move_and_slide(velocity, Vector2(0,-1))
	
	if position.y>3000||position.y<0:
		emit_signal("ImDead")
	
	for i in get_slide_count():
		collision = get_slide_collision(i)
		if collision.collider.name == "Obstacles" || collision.collider.name == "Obstacles2":
			emit_signal("ImDead")
			break
		if collision.collider.name == "InvisiblePath" && !stepped_on_invisible:
			stepped_on_invisible = true
			emit_signal("OnInvisible")
			break
	#######################################