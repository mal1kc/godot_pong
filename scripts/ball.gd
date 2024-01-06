extends Area2D

@onready var coll_shape:CollisionShape2D = $CollisionShape2D
@onready var _initial_position = position

@export var init_move_direction := Vector2(200,0)
@export var overtime_speed_multipler = 0.4

var move_direction := Vector2(200,0)
var speed_limit := Vector2(1200,1200)


func _draw():
  draw_circle(Vector2(0,0),coll_shape.shape.radius,Color.WEB_GRAY)


# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
  move_direction.x += delta * overtime_speed_multipler
  if move_direction.x >= speed_limit.x:
    move_direction.x = speed_limit.x

  move_direction.y += delta * overtime_speed_multipler
  if move_direction.y >= speed_limit.y:
    move_direction.y = speed_limit.y
  position += delta * move_direction


func reset():
  if randi_range(1,2) == 1:
    init_move_direction.x *= -1
  position = _initial_position
  move_direction = init_move_direction

func _on_area_entered(area):
  if area.name == "player_1" or area.name == "player_2":
    move_direction.x *= -1
    move_direction.y = -1 * randf() * 200
