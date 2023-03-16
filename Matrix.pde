
public class Matrix{
  // Matrix will start at coords 50,50 and end at 750,750
  // Max amount of cells is 12, so max grid 12x12
  // Max length of allignment is 10
  int cellSize = 60;
  int startX = 50, startY = 50;

  String sequence1, sequence2;
  int gap, mismatch, match;
  
  int[][] matrix;
  String[] alignmentResult;
  int scoring;
  
  ArrayList<Cell> cells;
  
  Matrix(String sequence1, String sequence2, int gap, int mismatch, int match){
    this.sequence1 = sequence1;
    this.sequence2 = sequence2;
    this.gap = gap;
    this.mismatch = mismatch;
    this.match = match;

    initMatrix();
    fillMatrix();
    this.scoring = getScoring();
    this.alignmentResult = backTracking();
    createCells();
  }
  
  private void createCells(){
    // Corner cells
    this.cells = new ArrayList<Cell>();
    Cell cell0 = new Cell(startX, startY, "");
    Cell cell1 = new Cell(startX+cellSize, startY, "");
    Cell cell2 = new Cell(startX, startY+cellSize, "");
    cell0.cellColor(color(101, 205, 255, 180));
    cell1.cellColor(color(101, 205, 255, 180));
    cell2.cellColor(color(101, 205, 255, 180));
    this.cells.add(cell0);
    this.cells.add(cell1);
    this.cells.add(cell2);
    
    
    int i = 0;
    int y = startY+(cellSize*2);
    while (i < this.sequence1.length()){
      char letter = this.sequence1.charAt(i);
      String str = String.valueOf(letter);
      Cell c = new Cell(startX, y, str);
      c.cellColor(color(101, 205, 255));
      this.cells.add(c);
      y += cellSize;
      i++;
    }
    
    i = 0;
    int x = startX+(cellSize*2);
    while (i < this.sequence2.length()){
      char letter = this.sequence2.charAt(i);
      String str = String.valueOf(letter);
      Cell c = new Cell(x, startY, str);
      c.cellColor(color(101, 205, 255));
      this.cells.add(c);
      x += cellSize;
      i++;
    }

    y = startY+cellSize;
    int j = 0;
    while (j < this.matrix.length){
      int k = 0;
      x = startX+cellSize;
      while (k < this.matrix[j].length){
        String str = Integer.toString(this.matrix[j][k]);
        Cell c = new Cell(x, y, str);
        this.cells.add(c);
        x += cellSize;        
        k++;
      }
      y += cellSize;
      j++;
    }
    int firstZeroIndex = 3 + this.sequence1.length() + this.sequence2.length();
    this.cells.get(firstZeroIndex).cellColor(color(103, 255, 172, 200));
    
  }
  
  public void displayMatrix(){
    for (Cell c : this.cells){
      c.display();
    }
  }
  
  private int S(int a, int b){
    if (a == b) return this.match;
    return this.mismatch;
  }
  
  private void initMatrix(){
    this.matrix = new int[this.sequence1.length()+1][this.sequence2.length()+1];
    for (int i = 0; i <= this.sequence1.length(); i++){
      for (int j = 0; j <= this.sequence2.length(); j++){
         this.matrix[i][j] = 0;
      }
    }
    
    for (int i = 0; i <= this.sequence1.length(); i++){
      this.matrix[i][0] = this.gap * i;
    }
    for (int j = 0; j <= this.sequence2.length(); j++){
        this.matrix[0][j] = this.gap * j;
    }
  }
  
  public void fillMatrix(){
    for (int i = 1; i < this.matrix.length; i++){
      for (int j = 1; j < this.matrix[i].length; j++){
         int diagonal = this.matrix[i-1][j-1];
         
         int scoring = diagonal + S(this.sequence2.charAt(j-1), this.sequence1.charAt(i-1));
         
         int gapj = this.matrix[i][j-1] + this.gap;
         int gapi = this.matrix[i-1][j] + this.gap;
         
         this.matrix[i][j] = max(scoring, gapj, gapi);
      }
    }
  }
  
  private int getScoring(){
    int n = this.matrix.length - 1;
    int m = this.matrix[n-1].length - 1;
    return this.matrix[n][m];
  }
  
  private String[] backTracking(){
    int n = this.matrix.length - 1;
    int m = this.matrix[n-1].length - 1;
    //String res1 = "", res2 = "";
    
    return backTrackingHelper("", "", n, m);
  }
  
  private String[] backTrackingHelper(String res1, String res2, int i, int j){
    if (i == 0 && j == 0){
      String[] res = {reverseString(res1), reverseString(res2)};
      return res;
    }
    
    int up = this.matrix[i-1][j] + this.gap;
    int left = this.matrix[i][j-1] + this.gap;
    int diagonal = this.matrix[i-1][j-1] + S(this.sequence2.charAt(j-1), this.sequence1.charAt(i-1));
    
    int maxNum = max(up, left, diagonal);
    
    if ((maxNum == diagonal && diagonal == left && left == up) || (maxNum == diagonal && diagonal == left)){
      res2 = res2 + this.sequence2.charAt(j-1);
      res1 = res1 + "-";
      return backTrackingHelper(res1, res2, i, j-1);
    }
    
    if (maxNum == diagonal && diagonal == up){
      res2 = res2 + "-";
      res1 = res1 + this.sequence1.charAt(i-1);
      return backTrackingHelper(res1, res2, i-1, j);
    }
    
    if (maxNum == diagonal){
      res2 = res2 + this.sequence2.charAt(j-1);
      res1 = res1 + this.sequence1.charAt(i-1);
      return backTrackingHelper(res1, res2, i-1, j-1);
    }
    
    else if (maxNum == left){
      res2 = res2 + this.sequence2.charAt(j-1);
      res1 = res1 + "-";
      return backTrackingHelper(res1, res2, i, j-1);
    }
    
    res2 = res2 + "-";
    res1 = res1 + this.sequence1.charAt(i-1);
    return backTrackingHelper(res1, res2, i-1, j);
  }
  
  private String reverseString(String str){
    int i = str.length() - 1;
    String res = "";
    while (i >= 0){
      res = res + str.charAt(i);
      i--;
    }
    return res;
  }
  
  public void printM(){
    System.out.println("Matrix");
    for (int i = 0; i < this.matrix.length; i++) {
    // Iterate over the columns of the matrix
    for (int j = 0; j < this.matrix[0].length; j++) {
        // Print the element at row i and column j
        System.out.print(this.matrix[i][j] + " ");
      }
    // Print a newline after each row
      System.out.println();
    }
    System.out.println("Scoring" + this.scoring);
    System.out.println("Result sequence 1 " + this.alignmentResult[0]);
    System.out.println("Result sequence 2 " + this.alignmentResult[1]);
  }
}
