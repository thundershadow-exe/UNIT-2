float x, y;
float ease = 0.05;

void setup() {
  size(1000, 600);
  x = width/2;
  y = height/2;
}

void draw() {
  background(250);

  // follow mouse
  x += (mouseX - x) * ease;
  y += (mouseY - y) * ease;

  // grow as mouse moves down
  float s = map(mouseY, 0, height, 0.6, 2.0);

  pushMatrix();
  translate(x, y);
  scale(s);
  drawSoot();       
  popMatrix();
}

void drawSoot() {
  // body`
  noStroke();
  fill(0);
  ellipse(0, 0, 80, 80);

  // fuzz
  stroke(0);
  strokeWeight(3);
  int fuzzCount = 40;
  for (int i = 0; i < fuzzCount; i++) {
    float a = TWO_PI * i / fuzzCount;
    line(cos(a)*35, sin(a)*35, cos(a)*45, sin(a)*45);
  }

  // eyes
  noStroke();
  fill(255);
  ellipse(-15, -5, 22, 22);
  ellipse(15, -5, 22, 22);

  // pupils
  fill(0);
  float px = constrain((mouseX - x) * 0.03, -4, 4);
  float py = constrain((mouseY - y) * 0.03, -4, 4);
  ellipse(-15 + px, -5 + py, 10, 10);
  ellipse(15 + px, -5 + py, 10, 10);
}
