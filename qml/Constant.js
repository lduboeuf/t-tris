.pragma library

var CELL_FIGURE = 0
var SQUARE_FIGURE = 1
var LINE_FIGURE = 2
var TRIANGLE_FIGURE = 3
var S_FIGURE = 4
var Z_FIGURE = 5
var RIGHT_ANGLE_FIGURE = 6
var LEFT_ANGLE_FIGURE = 7
var PLUS_FIGURE = 8

var arrMaxCell = new Array(MAX_FIGURE);
arrMaxCell[CELL_FIGURE] = 1
arrMaxCell[SQUARE_FIGURE] = 4
arrMaxCell[LINE_FIGURE] = 4
arrMaxCell[TRIANGLE_FIGURE] = 4
arrMaxCell[S_FIGURE] = 4
arrMaxCell[Z_FIGURE] = 4
arrMaxCell[RIGHT_ANGLE_FIGURE] = 4
arrMaxCell[LEFT_ANGLE_FIGURE] = 4
arrMaxCell[PLUS_FIGURE] = 5

var arrMaxOrientation = new Array(MAX_FIGURE);
arrMaxOrientation[CELL_FIGURE] = 1
arrMaxOrientation[SQUARE_FIGURE] = 1
arrMaxOrientation[LINE_FIGURE] = 2
arrMaxOrientation[TRIANGLE_FIGURE] = 4
arrMaxOrientation[S_FIGURE] = 2
arrMaxOrientation[Z_FIGURE] = 2
arrMaxOrientation[RIGHT_ANGLE_FIGURE] = 4
arrMaxOrientation[LEFT_ANGLE_FIGURE] = 4
arrMaxOrientation[PLUS_FIGURE] = 1

var MAX_FIGURE = 9
var MAX_POINT_IN_FIGURE = 4

/*
  Key handle
*/
var KEY_LEFT = 1
var KEY_RIGHT = 2
var KEY_UP = 3
var KEY_DOWN = 4
var KEY_PAUSE = 5

/*
  State of cell
*/
var RUNNING_CELL = 1
var CLOCKING_CELL = 2

/*
  Value of Tetris.gameState
*/
var PLAYING_STATE = 1
var PAUSING_STATE = 2
var GAMEOVER_STATE = 3

/*
  Some value default to init the game
*/
var BLOCK_SIZE_DEFAULT = 40
var MAX_COLUMN_DEFAULT = 12
var MAX_ROW_DEFAULT    = 19
var ORIGIN_X_DEFAULT   = 4
var ORIGIN_Y_DEFAULT   = 0
var TYPE_FIGURE_DEFAULT= 1
var ORIENTATION_DEFAULT= 0

var color = ["red", "blue", "green"]

/*
  State of SOUND
*/
var NEW_LEVEL_SOUND = 0
var MOVING_SOUND = 1
var REMOVE_ROW_SOUND = 2
var GAME_OVER_SOUND = 3



