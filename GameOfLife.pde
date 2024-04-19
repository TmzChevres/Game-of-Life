int cols = 10;
int rows = 10;

boolean[][] board;

void setup(){
  board = new boolean[rows][cols];
  size(300,300);
  
  rectMode(CORNERS);
  randomBoard();
}

void draw(){
  background(#FFFFFF);
  drawBoard();
}

void drawBoard(){
  noStroke();
  for(int r=0; r<rows; r++){
    for(int c=0; c<cols; c++){
      fill(board[r][c]?#FFFFFF:#000000);
      rect(c*width/cols,r*height/cols,(c+1)*width/cols,(r+1)*height/cols);
    }
  }
}

int sumNeighbors(int row, int col){
  int sum = 0;
  for(int r=-1; r<=1; r++){
    for(int c=-1; c<=1; c++){
      if((r!=0||c!=0) && row+r>=0 && row+r<board.length && col+c>=0 && col+c<board[row].length && board[row+r][col+c]){
        sum++;
      }
    }
  }
  return sum;
}

void randomBoard(){
  for(int i=0; i<board.length; i++){
    for(int j=0; j<board.length; j++){
      board[i][j] = random(1)<0.5;
    }
  }
}

void nextBoard(){
  boolean[][] temp = new boolean[rows][cols];
  for(int r=0; r<rows; r++){
    for(int c=0; c<cols; c++){
      int sum = sumNeighbors(r,c);
      if(board[r][c]){
        if(sum<2) temp[r][c] = false;
        else if(sum<=3) temp[r][c] = true;
        else temp[r][c] = false;
      }
      else if(sum==3) temp[r][c] = true;
    }
  }
  board = temp;
}

int getRow(float y){
  return int(rows*y/height);
}
int getCol(float x){
  return int(cols*x/width);
}

void mouseClicked(){
  board[getRow(mouseY)][getCol(mouseX)] = !board[getRow(mouseY)][getCol(mouseX)];
}

void keyPressed(){
  nextBoard();
}
