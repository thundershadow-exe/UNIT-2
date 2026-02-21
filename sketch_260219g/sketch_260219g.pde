int x;

void setup() {
  size(530, 450);
  x = width + 100;   // start just off the right side
  strokeWeight(3);
}

void draw() {
  background(255);

  ellipse(x, 225, 200, 200);

  x = x - 1;

  // When the circle fully leaves the left side, reset to the right
  if (x < -100) {
    x = width + 100;
  }
}
