int y1;
int y2;

void setup() {
  size(530, 450);
  y1 = -100;
  y2 = 550;
  strokeWeight(3);
}

void draw() {
  background(255);
  ellipse(130, y1, 200, 200);
  ellipse(400, y2, 200, 200);
  y1 = y1 + 1;
  y2 = y2 - 1;

  if (y1 > 550) {
    y1 = -100;
    y2 = 550;
  }
}
