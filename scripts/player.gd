extends Area2D

@onready var coll_shape:= $CollisionShape2D
var score = 0

var move_direction:= Vector2(0,295)

func _input(event):
  if event.is_action_pressed("ui_up_" + name):
    move_direction.y = -1 * abs(move_direction.y)
  elif event.is_action_pressed("ui_down_" + name):
    move_direction.y = abs(move_direction.y)

func _draw():
  draw_rect(Rect2(coll_shape.shape.size/2 * -1,coll_shape.shape.size),Color.WEB_GRAY)


# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
  position.y += move_direction.y * delta
  if position.y >= 240:
    position.y = 240
  if position.y <= -240:
    position.y = -240
