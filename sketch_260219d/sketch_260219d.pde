int y;

void setup() {
  size(530, 450);
  y = 0;
  strokeWeight(3);
}

void draw() {
  background(255);
  ellipse(265, y, 200, 200);

  // Move the circle downward
  y = y + 3;

  // Reset when it goes off-screen
  if (y > 700) {
    y = -100;
  }
}
