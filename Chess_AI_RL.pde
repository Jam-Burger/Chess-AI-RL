final int S= 100;
Board board;
final char[] sequence= {'p', 'n', 'b', 'r', 'q', 'k', 'P', 'N', 'B', 'R', 'Q', 'K'};
color selectColor, choiceColor, dangerColor, promotionColor;
HashMap<Character, PImage> piecesImages;

void settings() {
  size(S*8 + 100, S*8 + 100);
}

void setup(){
  rectMode(CENTER);
  imageMode(CENTER);
  noLoop();
  noStroke();

  selectColor= color(#0092FF, 120);
  choiceColor= color(#FFE600, 120);
  dangerColor= color(#FC1831, 150);
  promotionColor= color(#F10AFF, 120);
  
  piecesImages= new HashMap<>();
  for (int i=0; i<=1; i++) {
    for (int j=0; j<6; j++) {
      piecesImages.put(sequence[i*6+j], loadImage("pieces/"+i+j+".png"));
      piecesImages.get(sequence[i*6+j]).resize(S, S);
    }
  }
  
  board= new Board();
}
void draw(){
  background(255);
  board.show();
}

void mousePressed() {
  int i= floor((S*4 + mouseY - height/2.0)/S);
  int j= floor((S*4 + mouseX - height/2.0)/S);
  int index= index(i, j);
  if(isValid(i, j)){
    if(board.selected==-1){
      if(colorOf(board.pieceAt(index)) == 1) {
        board.selected= index;
        board.updateAllMoves();
        println(board.possibleMoves);
      }
    } else {
      board.applyMoveIfValid(i, j);
    }
  } else {
    board.selected= -1;
  }
 
  redraw();
}
