class Board{
  PImage boardImage;
  char[][] grid;
  int selected= -1;
  ArrayList<String> possibleMoves;
  ArrayList<String> choices;
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
    grid[7][1]= ' ';
    grid[7][2]= ' ';
    grid[7][3]= ' ';
    grid[7][5]= ' ';
    grid[7][6]= ' ';
    
    possibleMoves= new ArrayList<>();
    choices= new ArrayList<>();
  }
  
  void makeMove(String move) {
      // Extract starting and ending positions from the move string
      int i1 = move.charAt(0) - '0';
      int j1 = move.charAt(1) - '0';
      int i2 = move.charAt(2) - '0';
      int j2 = move.charAt(3) - '0';
      
      // Perform the move
      char piece = grid[i1][j1];
      grid[i2][j2] = piece; // Move piece to the new position
      grid[i1][j1] = ' ';   // Clear the old position
      
      // Promotion
      if (piece == 'P' && i2 == 0) { // Pawn reaching the 1st rank
          grid[i2][j2] = 'Q'; // Promote to the specified piece
      }
      
      // Handle castling
      if (piece == 'K') {
          // Kingside castling
          if (j2 == 6) {
              grid[i1][5] = 'R'; // Move the rook
              grid[i1][7] = ' '; // Clear the rook's old position
          }
          // Queenside castling
          else if (j2 == 2) {
              grid[i1][3] = 'R'; // Move the rook
              grid[i1][0] = ' '; // Clear the rook's old position
          }
      }
  }
  
  void applyMoveIfValid(int i2, int j2){
    if(selected==-1) return;
    int i1= selected/8, j1= selected%8;
    String move= createMoveString(i1, j1, i2, j2, grid);
    
    for(String c : choices){
      if(c.equals(move)) {
        makeMove(move);
        break;
      }
    }
    selected= -1;
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
  
  ArrayList<String> getLegalMoves(int index) {
    int i = index / 8;
    int j = index % 8;
    char piece = grid[i][j];
    ArrayList<String> moves = new ArrayList<>();
    
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
    choices.clear();
    
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        char piece = grid[i][j];
        if (colorOf(piece)==1) {
          ArrayList<String> pieceMoves = getLegalMoves(index(i, j));
          if(selected==index(i, j)) choices= pieceMoves;
          possibleMoves.addAll(pieceMoves);
        }
      }
    }
  }
  
  void showPossibleMoves() {
     for(String c : choices){
       int i= c.charAt(2) - '0';
       int j= c.charAt(3) - '0';
       if(grid[i][j]==' ') drawTile(choiceColor, index(i, j));
       else drawTile(dangerColor, index(i, j));
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
