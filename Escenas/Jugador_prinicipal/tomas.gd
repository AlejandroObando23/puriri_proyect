extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var final_direc_ataque=1
var atacando= false
@onready var animated_sprite =$AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _ready():
	# Conectar la señal para saber cuando termina la animación
	animated_sprite.animation_finished.connect(_on_animation_finished)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("salto") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		print(velocity.y)
	
	if Input.is_action_just_pressed("ataque") and not atacando:
		atacando=true
		print("activado")
		if final_direc_ataque==1:
			animated_sprite.play("ataque_der")
		elif final_direc_ataque==-1:
			animated_sprite.play("ataque_izq")
		
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("izq", "dere")
	if !atacando:
		if direction:
			if 1==direction:
				
				animated_sprite.play("cor_dere")
				velocity.x=SPEED
				final_direc_ataque=1
			else:
				animated_sprite.play("core_izq")
				velocity.x=-SPEED
				final_direc_ataque=-1
				
			

				
			
			
		elif direction==0:
			velocity.x = 0
			animated_sprite.play("normal")
	else:
		await animated_sprite.animation_finished
		atacando=false

		

	move_and_slide()

	


func _on_ataque_cel_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("ataque"):
		print("hola mundo")
		
func _on_animation_finished():
	# Cuando termina la animación de ataque
	
	atacando = false
