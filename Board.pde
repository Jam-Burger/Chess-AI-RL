class Board{
  PImage boardImage;
  char[][] grid;
  int selected= -1;
  StringList possibleMoves;
  
  Board(){
    boardImage= loadImage("board.png");
    grid= new char[][]{
      {'r', 'n', 'b', 'q', 'k', 'b', 'n', 'r'},
      {'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p'},
      {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
      {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
      {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
      {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
      {'P', 'P', 'P', 'P', 'P', 'P', 'P', 'P'},
      {'R', 'N', 'B', 'Q', 'K', 'B', 'N', 'R'}
    };
    
    possibleMoves= new StringList();
  }
  void showPieces() {
    for (int i=0; i<8; i++) {
      for (int j=0; j<8; j++) {
        if (grid[i][j] == ' ') continue;
        image(piecesImages.get(grid[i][j]), j*S + S/2 - S*4, i*S + S/2 - S*4);
      }
    }
  }
  char pieceAt(int i) {
    return grid[i/8][i%8];
  }
  
  void drawTile(color clr, int i) {
    fill(clr);
    rect(i%8 * S - S*4 + S/2, i/8 * S - S*4 + S/2, S, S);
  }
  
  StringList getLegalMoves(int index) {
    int i = index / 8;
    int j = index % 8;
    char piece = grid[i][j];
    StringList moves = new StringList();
    
    switch (piece) {
      case 'P': moves = getPawnMoves(i, j, grid); break;
      case 'R': moves = getRookMoves(i, j, grid); break;
      case 'N': moves = getKnightMoves(i, j, grid); break;
      case 'B': moves = getBishopMoves(i, j, grid); break;
      case 'Q': moves = getQueenMoves(i, j, grid); break;
      case 'K': moves = getKingMoves(i, j, grid); break;
    }
    return moves;
  }
  
  void updateAllMoves() {
    possibleMoves.clear();
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        char piece = grid[i][j];
        if (Character.isUpperCase(piece)) {
          StringList pieceMoves = getLegalMoves(index(i, j));
          possibleMoves.append(pieceMoves);
        }
      }
    }
  }
  void showPossibleMoves() {
     StringList choices= board.getLegalMoves(selected);
     for(String c : choices){
       int i= c.charAt(2) - '0';
       int j= c.charAt(3) - '0';
       drawTile(choiceColor, index(i, j));
     }
  }
  void show(){
    pushMatrix();
    translate(height/2, height/2);
    image(boardImage, 0, 0, S*8, S*8);
    
    if (selected!=-1) {
      drawTile(selectColor, selected);
      showPossibleMoves();
    }
    
    showPieces();
    popMatrix();
  }
}
