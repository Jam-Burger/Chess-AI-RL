ArrayList<String> getPawnMoves(int i, int j, char[][] grid) { 
    ArrayList<String> moves = new ArrayList<>();

    // Move forward
    if (isValid(i - 1, j) && grid[i - 1][j] == ' ') {
        moves.add(createMoveString(i, j, i - 1, j, grid));  // Pawn forward move
        if (i == 6 && grid[i - 2][j] == ' ') {
            moves.add(createMoveString(i, j, i - 2, j, grid));  // Initial two-step move
        }
    }

    // Capture diagonally
    if (isValid(i - 1, j - 1) && colorOf(grid[i - 1][j - 1]) == -1) {
        moves.add(createMoveString(i, j, i - 1, j - 1, grid));  // Left capture
    }
    if (isValid(i - 1, j + 1) && colorOf(grid[i - 1][j + 1]) == -1) {
        moves.add(createMoveString(i, j, i - 1, j + 1, grid));  // Right capture
    }

    return moves;
}

ArrayList<String> getRookMoves(int i, int j, char[][] grid) {
    ArrayList<String> moves = new ArrayList<>();
    int[] directions = {-1, 1};

    // Vertical moves
    for (int d : directions) {
        for (int ii = i + d; isValid(ii, j); ii += d) {
            if (grid[ii][j] == ' ') moves.add(createMoveString(i, j, ii, j, grid));  // Empty tile
            else {
                if (colorOf(grid[ii][j]) == -1) moves.add(createMoveString(i, j, ii, j, grid));  // Capture black piece
                break;
            }
        }
    }

    // Horizontal moves
    for (int d : directions) {
        for (int jj = j + d; isValid(i, jj); jj += d) {
            if (grid[i][jj] == ' ') moves.add(createMoveString(i, j, i, jj, grid));  // Empty tile
            else {
                if (colorOf(grid[i][jj]) == -1) moves.add(createMoveString(i, j, i, jj, grid));  // Capture black piece
                break;
            }
        }
    }

    return moves;
}

ArrayList<String> getKnightMoves(int i, int j, char[][] grid) {
    ArrayList<String> moves = new ArrayList<>();
    int[][] jumps = {{-2, -1}, {-2, 1}, {-1, -2}, {-1, 2}, {1, -2}, {1, 2}, {2, -1}, {2, 1}};

    for (int[] jump : jumps) {
        int ii = i + jump[0];
        int jj = j + jump[1];
        if (isValid(ii, jj) && colorOf(grid[ii][jj]) <= 0) {  // Empty or black square
            moves.add(createMoveString(i, j, ii, jj, grid));
        }
    }
    return moves;
}

ArrayList<String> getBishopMoves(int i, int j, char[][] grid) {
    ArrayList<String> moves = new ArrayList<>();
    int[] directions = {-1, 1};

    // Diagonal moves
    for (int di : directions) {
        for (int dj : directions) {
            for (int ii = i + di, jj = j + dj; isValid(ii, jj); ii += di, jj += dj) {
                if (grid[ii][jj] == ' ') moves.add(createMoveString(i, j, ii, jj, grid));  // Empty tile
                else {
                    if (colorOf(grid[ii][jj]) == -1) moves.add(createMoveString(i, j, ii, jj, grid));  // Capture black piece
                    break;
                }
            }
        }
    }
    return moves;
}

ArrayList<String> getQueenMoves(int i, int j, char[][] grid) {
    ArrayList<String> moves = new ArrayList<>();
    moves.addAll(getRookMoves(i, j, grid));  // Combine rook moves
    moves.addAll(getBishopMoves(i, j, grid));  // Combine bishop moves
    return moves;
}

ArrayList<String> getKingMoves(int i, int j, char[][] grid) {
    ArrayList<String> moves = new ArrayList<>();
    int[] directions = {-1, 0, 1};

    // Standard king moves
    for (int di : directions) {
        for (int dj : directions) {
            if (di == 0 && dj == 0) continue; // Skip the current position
            int ii = i + di;
            int jj = j + dj;
            if (isValid(ii, jj) && (colorOf(grid[ii][jj]) != 1)) {
                moves.add(createMoveString(i, j, ii, jj, grid));
            }
        }
    }

    // Castling logic
    if (j == 4 && i == 7) {
        // Kingside castling
        if (grid[i][5] == ' ' && grid[i][6] == ' ' && grid[i][7] == 'R') { 
            moves.add(createMoveString(i, j, i, 6, grid));
        }
        // Queenside castling
        if (grid[i][1] == ' ' && grid[i][2] == ' ' && grid[i][3] == ' ' && grid[i][0] == 'R') {
            moves.add(createMoveString(i, j, i, 2, grid));
        }
    }

    return moves;
}
