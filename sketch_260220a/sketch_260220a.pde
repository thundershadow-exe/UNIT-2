int x;
int d;

void setup() {
  size(530, 450);
  x = 0;
  d = 0;
  strokeWeight(3);
}

void draw() {
  background(255);
  ellipse(x, 200, d, d);
 x = x + 1;
 d = d + 1;
 if (x > 700) {
   x = 0;
   d = 0;
 }

}
