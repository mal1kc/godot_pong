extends Node2D

@onready var player_1 = $player_1
@onready var player_2 = $player_2
@onready var ball = $ball

@onready var player1_init_pos:Vector2 = player_1.position
@onready var player2_init_pos:Vector2 = player_2.position

@onready var _ui_winner_label = $score_pane/_ui_winner_label
@export var score_to_win = 10

var game_finished:bool= false

# Called when the node enters the scene tree for the first time.
func _ready():
  _ui_winner_label.hide()
  pause_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):    
  pass
    
func pause_game():
  get_tree().set_pause(true)

func resume_game():
  if game_finished:
    reset_game()
  get_tree().set_pause(false)
  
func reset_game():
  _ui_winner_label.hide()
  game_finished = false
  player_1.score = 0
  player_2.score = 0
  ball.reset()
  player_1.position = player1_init_pos
  player_2.position = player2_init_pos
  get_node("score_pane/_ui_score_player_1").text = "0"
  get_node("score_pane/_ui_score_player_1").text = "0"

func add_score(player:Area2D):
  player.score += 1
  get_node("score_pane/_ui_score_" + player.name).text = str(player.score)
  if player.score >= score_to_win:
    _ui_winner_label.text = str(player.name) + " wins"
    print( _ui_winner_label.text)
    _ui_winner_label.show()
    game_finished = true
    pause_game()

func _on_horizantal_borders_area_entered(area):
  if area == ball:
    ball.move_direction.y *= -1

func _on__ui_pause_button_pressed():
  if get_tree().paused:
    resume_game()
    return
  pause_game()

func _on__ui_restart_button_pressed():
  reset_game()

func _on_vertical_borders_area_entered(area):
  if area.name == "ball":
    if player_1.position.x >= area.position.x:
      add_score(player_2)
    elif player_2.position.x <= area.position.x:
      add_score(player_1)
    ball.reset()
