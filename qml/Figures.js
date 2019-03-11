var Figures = {

    "CELL_FIGURE" :{
        maxOrientation: 1,
        points:[{ "x":0, "y":0 } ]
    },
    "SQUARE_FIGURE" :{
        maxOrientation: 1,
        points:[ { "x":0, "y":0 }, { "x":-1, "y":0 }, { "x":-1, "y":1 }, { "x":0, "y":1 }, ]
    },

    "LINE_FIGURE" :{
        maxOrientation: 2,
        points:[ { "x":-2, "y":0 }, { "x":-1, "y":0 }, { "x":0, "y":0 }, { "x":1, "y":0 }, ]
    },

    "TRIANGLE_FIGURE":{
        maxOrientation: 4,
        points:[ { "x":0, "y":0 }, { "x":-1, "y":0 }, { "x":1, "y":0 }, { "x":0, "y":1 }, ]
    },
    "S_FIGURE" :{
        maxOrientation: 2,
        points:[ { "x":0, "y":0 }, { "x":0, "y":1 }, { "x":-1, "y":0 }, { "x":1, "y":1 }, ]
    },
    "Z_FIGURE":{
        maxOrientation: 2,
        points:[{"x":0,"y":0},{"x":0,"y":1}, { "x":-1, "y":1 }, { "x":1, "y":0 }, ]
    },
    "RIGHT_ANGLE_FIGURE":{
        maxOrientation: 4,
        points:[ { "x":0, "y":0 }, { "x":0, "y":1 }, { "x":-1, "y":0 }, { "x":-2, "y":0 }, ]
    },
    "LEFT_ANGLE_FIGURE":{
        maxOrientation: 4,
        points:[ { "x":0, "y":0 }, { "x":0, "y":1 }, { "x":1, "y":0 }, { "x":2, "y":0 }, ]

    },
    "PLUS_FIGURE":{
        maxOrientation: 1,
        points:[ { "x":0, "y":0 }, { "x":0, "y":1 }, { "x":0, "y":2 }, { "x":-1, "y":1 }, { "x":1, "y":1 }, ]
    },

}
