function apply(type){

    switch(type){
    case Constant.NEW_LEVEL_SOUND:
        playOtherSound.play()
        break;
    case Constant.MOVING_SOUND:
        soundMoving.play()
        break;
    case Constant.REMOVE_ROW_SOUND:
        soundClearRow.play()
        break;
    case Constant.GAME_OVER_SOUND:
        soundGameOver.play()
        break;
    }
}
