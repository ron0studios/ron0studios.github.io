extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var motion : Vector2
var check = false
var drag = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _input(event):
	if Input.is_action_pressed("scrolldown"):
		zoom *= 1.1 #Vector2(0.1,0.1)
	elif Input.is_action_pressed("scrollup"):
		zoom *= 0.9 #Vector2(0.1,0.1)
		
func _physics_process(delta):
	if check and Input.is_action_pressed("lmb"):
		drag = true
	if Input.is_action_just_released("lmb") and drag:
		drag = false
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ColorRect_gui_input(event):
	if drag and event is InputEventMouseMotion:
		self.offset -= event.relative * zoom
	if event is InputEventMouseButton and event.pressed:
		check = true
	pass # Replace with function body.
