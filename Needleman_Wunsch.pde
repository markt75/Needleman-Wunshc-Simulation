
Cell test = new Cell(400,400,"1");
String sequence1 = "GATT";
String sequence2 = "GTCGA";

Matrix m;
void setup(){
 size(800,800); 
 m = new Matrix(sequence1, sequence2, -2, -1, 1);
 //m.printM();
}

void draw(){
  background(0);
  m.displayMatrix();
}
