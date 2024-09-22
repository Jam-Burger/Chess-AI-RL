int index(int i, int j) {
  return i * 8 + j;
}

boolean isValid(int i, int j){
  return i>=0 && j>=0 && i<8 && j<8;
}

int colorOf(char c) {
  if(Character.isUpperCase(c)) return 1;
  if(Character.isLowerCase(c)) return -1;
  return 0;
}

String createMoveString(int startI, int startJ, int endI, int endJ) {
  String move= str(startI) + startJ + endI + endJ;
  return move;
}

String standardizeMove(String move, char[][] grid) {
    int i1 = move.charAt(0) - '0';  // Starting row (i1)
    int j1 = move.charAt(1) - '0';  // Starting column (j1)
    int i2 = move.charAt(2) - '0';  // Target row (i2)
    int j2 = move.charAt(3) - '0';  // Target column (j2)

    // Convert to standard chess notation
    char fromFile = (char) ('a' + j1);  // Starting file
    int fromRank = 8 - i1;              // Starting rank
    char toFile = (char) ('a' + j2);    // Target file
    int toRank = 8 - i2;                // Target rank

    // Start constructing the move notation
    String moveNotation = "";

    // Handle pawn movement
    char movingPiece= grid[i1][i2];
    if (movingPiece == 'P') {
        moveNotation += toFile + "" + toRank; // Just the destination for pawns
    } else {
        moveNotation += movingPiece;           // Append piece type
        moveNotation += toFile + "" + toRank; // Destination
    }

    // Check for captures
    if (grid[i2][j2] != ' ' && colorOf(grid[i2][j2]) == -1) {
        if (movingPiece == 'P') {
            moveNotation = fromFile + "x" + moveNotation; // Pawn capture
        } else {
            moveNotation = moveNotation.charAt(0) + "x" + moveNotation.substring(1); // Non-pawn capture
        }
    }

    // Castling
    if (movingPiece == 'K' && Math.abs(j2 - j1) == 2) {
        moveNotation = (j2 == 6 ? "O-O" : "O-O-O"); // Kingside or queenside castling
    }

    // Promotions
    if (i2 == 0 && movingPiece == 'P') {
        moveNotation += "=" + "Q"; // Promotion to Queen (modify as needed for other pieces)
    }

    return moveNotation;
}
