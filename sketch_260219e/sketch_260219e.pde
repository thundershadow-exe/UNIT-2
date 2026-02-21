int x;
int y;

void setup() {
  size(530, 450);
  x = 0;      // start at left
  y = 0;      // start at top
  strokeWeight(3);
}

void draw() {
  background(255);

  ellipse(x, y, 200, 200);

  x = x + 1;
  y = y + 1;

  if (y > height + 100) {
    x = -100;
    y = -100;
  }
}
