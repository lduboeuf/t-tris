.pragma library
var MAX_CELL = 12;
var SCORE = 20;
var REDUCED_TIME = 60;
var TIMER_INTERVAL = 500



//var MAX_FIGURE = 9
//var MAX_POINT_IN_FIGURE = 4

/*
  Key handle
*/
var KEY_LEFT = 1
var KEY_RIGHT = 2
var KEY_UP = 3
var KEY_DOWN = 4
var KEY_PAUSE = 5
var KEY_STEP_DOWN =6

/*
  Type of cell
*/
var RUNNING_CELL = 1 //moving cells
var CLOCKING_CELL = 2 //fixed cells

/*
  STATES
*/


var STATE_START = "STATE_START"
var STATE_PLAY = "STATE_PLAY"
var STATE_PAUSED = "STATE_PAUSED"
var STATE_RESUMED =" STATE_RESUMED"
var STATE_NEW_LEVEL = "STATE_NEW_LEVEL"
var STATE_GAMEOVER = "STATE_GAMEOVER"
var STATE_ROW_REMOVED = "STATE_ROW_REMOVED"
var STATE_PENDING_BOMB = "STATE_PENDING_BOMB"
var STATE_FIRING_BOMB = "STATE_FIRING_BOMB"

/*
  Some value default to init the game
*/
var MAX_COLUMN_DEFAULT = 12
var MAX_ROW_DEFAULT    = 19
var ORIGIN_X_DEFAULT   = 4
var ORIGIN_Y_DEFAULT   = 0
var TYPE_FIGURE_DEFAULT= 1
var ORIENTATION_DEFAULT= 0

var color = ["red", "blue", "green", "yellow"]

///*
//  State of SOUND
//*/
//var NEW_LEVEL_SOUND = 0
//var MOVING_SOUND = 1
//var REMOVE_ROW_SOUND = 2
//var GAME_OVER_SOUND = 3






