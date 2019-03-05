function apply(type){

    switch(type){
    case Constant.NEW_LEVEL_SOUND:
        playOtherSound.play()
        break;
    case Constant.MOVING_SOUND:
        playMovingSound.play()
        break;
    case Constant.REMOVE_ROW_SOUND:
        playClearRowSound.play()
        break;
    case Constant.GAME_OVER_SOUND:
        playGameOverSound.play()
        break;
    }
}
