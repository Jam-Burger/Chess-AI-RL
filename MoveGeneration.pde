StringList getPawnMoves(int i, int j, char[][] grid) {
  StringList moves = new StringList();
  
  // Move forward
  if (isValid(i-1, j) && grid[i-1][j] == ' ') {
    moves.append(createMoveString(i, j, i-1, j));  // Pawn forward move
    if (i == 6 && grid[i-2][j] == ' ') {
      moves.append(createMoveString(i, j, i-2, j));  // Initial two-step move
    }
  }

  // Capture diagonally
  if (isValid(i-1, j-1) && colorOf(grid[i-1][j-1]) == -1) {
    moves.append(createMoveString(i, j, i-1, j-1));  // Left capture
  }
  if (isValid(i-1, j+1) && colorOf(grid[i-1][j+1]) == -1) {
    moves.append(createMoveString(i, j, i-1, j+1));  // Right capture
  }
  
  return moves;
}

StringList getRookMoves(int i, int j, char[][] grid) {
  StringList moves = new StringList();
  int[] directions = {-1, 1};

  // Vertical moves
  for (int d : directions) {
    for (int ii = i + d; isValid(ii, j); ii += d) {
      if (grid[ii][j] == ' ') moves.append(createMoveString(i, j, ii, j));  // Empty tile
      else {
        if (colorOf(grid[ii][j]) == -1) moves.append(createMoveString(i, j, ii, j));  // Capture black piece
        break;
      }
    }
  }

  // Horizontal moves
  for (int d : directions) {
    for (int jj = j + d; isValid(i, jj); jj += d) {
      if (grid[i][jj] == ' ') moves.append(createMoveString(i, j, i, jj));  // Empty tile
      else {
        if (colorOf(grid[i][jj]) == -1) moves.append(createMoveString(i, j, i, jj));  // Capture black piece
        break;
      }
    }
  }

  return moves;
}

StringList getKnightMoves(int i, int j, char[][] grid) {
  StringList moves = new StringList();
  int[][] jumps = {{-2, -1}, {-2, 1}, {-1, -2}, {-1, 2}, {1, -2}, {1, 2}, {2, -1}, {2, 1}};
  
  for (int[] jump : jumps) {
    int ii = i + jump[0];
    int jj = j + jump[1];
    if (isValid(ii, jj) && colorOf(grid[ii][jj]) <= 0) {  // Empty or black square
      boolean isCapture = colorOf(grid[ii][jj]) == -1;
      moves.append(createMoveString(i, j, ii, jj));
    }
  }
  return moves;
}

StringList getBishopMoves(int i, int j, char[][] grid) {
  StringList moves = new StringList();
  int[] directions = {-1, 1};

  // Diagonal moves
  for (int di : directions) {
    for (int dj : directions) {
      for (int ii = i + di, jj = j + dj; isValid(ii, jj); ii += di, jj += dj) {
        if (grid[ii][jj] == ' ') moves.append(createMoveString(i, j, ii, jj));  // Empty tile
        else {
          if (colorOf(grid[ii][jj]) == -1) moves.append(createMoveString(i, j, ii, jj));  // Capture black piece
          break;
        }
      }
    }
  }
  return moves;
}

StringList getQueenMoves(int i, int j, char[][] grid) {
  StringList moves = new StringList();
  moves.append(getRookMoves(i, j, grid));  // Combine rook moves
  moves.append(getBishopMoves(i, j, grid));  // Combine bishop moves
  return moves;
}

StringList getKingMoves(int i, int j, char[][] grid) {
  StringList moves = new StringList();
  int[] directions = {-1, 0, 1};

  // Adjacent moves
  for (int di : directions) {
    for (int dj : directions) {
      if (di == 0 && dj == 0) continue;
      int ii = i + di;
      int jj = j + dj;
      if (isValid(ii, jj) && colorOf(grid[ii][jj]) <= 0) {  // Empty or black square
        boolean isCapture = colorOf(grid[ii][jj]) == -1;
        moves.append(createMoveString(i, j, ii, jj));
      }
    }
  }
  return moves;
}
