var Figures = {

    "CELL_FIGURE" :{
        maxOrientation: 1,
        points:[[{"x":0,"y":0}]],
        color: "grey"
    },

    "SQUARE_FIGURE" :{
        maxOrientation: 1,
        points:[[{"x":0,"y":0},{"x":-1,"y":0},{"x":-1,"y":1},{"x":0,"y":1}]],
        color: "yellow"
    },

    "LINE_FIGURE" :{
        maxOrientation: 2,
        points:[[{"x":-2,"y":0},{"x":-1,"y":0},{"x":0,"y":0},{"x":1,"y":0}],
            [{"x":0,"y":-2},{"x":0,"y":-1},{"x":0,"y":0},{"x":0,"y":1}]],
        color: "cyan"
    },

    "TRIANGLE_FIGURE":{
        maxOrientation: 4,
        points:[[{"x":0,"y":0},{"x":-1,"y":0},{"x":1,"y":0},{"x":0,"y":1}],
            [{"x":0,"y":0},{"x":0,"y":-1},{"x":0,"y":1},{"x":-1,"y":0}],
            [{"x":0,"y":0},{"x":1,"y":0},{"x":-1,"y":0},{"x":0,"y":-1}],
            [{"x":0,"y":0},{"x":0,"y":1},{"x":0,"y":-1},{"x":1,"y":0}]],
        color: "purple"
    },
    "S_FIGURE" :{
        maxOrientation: 2,
        points:[[{"x":0,"y":0},{"x":0,"y":1},{"x":-1,"y":0},{"x":1,"y":1}],
            [{"x":0,"y":0},{"x":-1,"y":0},{"x":0,"y":-1},{"x":-1,"y":1}]],
        color: "green"
    },
    "Z_FIGURE":{
        maxOrientation: 2,
        points:[[{"x":0,"y":0},{"x":0,"y":1},{"x":-1,"y":1},{"x":1,"y":0}],
            [{"x":0,"y":0},{"x":-1,"y":0},{"x":-1,"y":-1},{"x":0,"y":1}]],
        color: "red"
    },
    "RIGHT_ANGLE_FIGURE":{
        maxOrientation: 4,
        points:[[{"x":0,"y":0},{"x":0,"y":1},{"x":-1,"y":0},{"x":-2,"y":0}],
            [{"x":0,"y":0},{"x":-1,"y":0},{"x":0,"y":-1},{"x":0,"y":-2}],
            [{"x":0,"y":0},{"x":0,"y":-1},{"x":1,"y":0},{"x":2,"y":0}],
            [{"x":0,"y":0},{"x":1,"y":0},{"x":0,"y":1},{"x":0,"y":2}]],
        color: "blue"
    },
    "LEFT_ANGLE_FIGURE":{
        maxOrientation: 4,
        points:[[{"x":0,"y":0},{"x":0,"y":1},{"x":1,"y":0},{"x":2,"y":0}],
            [{"x":0,"y":0},{"x":-1,"y":0},{"x":0,"y":1},{"x":0,"y":2}],
            [{"x":0,"y":0},{"x":0,"y":-1},{"x":-1,"y":0},{"x":-2,"y":0}],
            [{"x":0,"y":0},{"x":1,"y":0},{"x":0,"y":-1},{"x":0,"y":-2}]],
        color: "orange"

    },
    "PLUS_FIGURE":{
        maxOrientation: 1,
        points:[[{"x":0,"y":0},{"x":0,"y":1},{"x":0,"y":2},{"x":-1,"y":1},{"x":1,"y":1}]],
        color: "white"
    },

}
