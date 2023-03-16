
public class Cell{
  int cellSize = 60;
  String cellText;
  int x, y;
  color c;
  
  Cell(int x, int y, String cellText){
    this.x = x;
    this.y = y;
    this.cellText = cellText;
  }
  public void display(){
    stroke(255);
    fill(this.c);
    rectMode(CENTER);
    square(this.x, this.y, cellSize);
    
    fill(255);
    textSize(30);
    textAlign(CENTER);
    text(this.cellText, x, y+10);
  }
  
  public void cellColor(color c){
    this.c = c;
  }
   
}
