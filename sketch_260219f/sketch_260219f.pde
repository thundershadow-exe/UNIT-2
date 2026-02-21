int w;

void setup() {
  size(530, 450);
  w = 0;
  strokeWeight(3);
}

void draw() {
  background(255);

  ellipse(265, 225, w, w);

  w = w + 1;

  if (w > 650) {
    w = 0;
  }
}
