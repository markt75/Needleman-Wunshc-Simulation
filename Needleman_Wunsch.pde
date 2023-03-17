
String sequence1 = "GATTCTTTTT";
String sequence2 = "GTCGAFTJTT";

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
