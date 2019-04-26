# t-tris
Tetris game, desktop and mobile written in Qt QML ( >= 5.9 )

initial work: https://github.com/keshavbhatt/qt-crazy-tetris

* on Mobile: Use swipe right/left/down to move pieces, tap to rotate or use bottom control buttons
* on Desktop: Use arrow keys

## scoring

Inspired by Nintendo™ tetris game on GameBoy

source: https://tetris.wiki/Scoring

| level  |  1 line |  2 lines | 3 lines  | 4 lines  |
|---|---|---|---|---|
| 0 |  40 |  100 | 300  | 1200  |
| 1 |  80 |  200 | 600  |  2400 |
| ... | ...  | ...  | ...  | ... |
| n | 40 * (n + 1)  | 100 * (n + 1)  | 300 * (n + 1)  | 1200 * (n + 1) |


## build and deploy

Import project in QtCreator and that's it!
