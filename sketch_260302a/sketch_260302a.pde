

float t = 0;
float growth = 0;
float clockY = -300;
float fallSpeed = 0;
boolean falling = false;
boolean impact = false;

PFont font;

void setup() {
  size(900, 900);
  font = createFont("Georgia", 34);
}

void draw() {

  // --- WHITE INTRO ---
  if (t < 40) {
    background(255);
    t++;
    return;
  }

  // --- DARK BACKGROUND ---
  background(20); 

  if (!impact) {

    // --- PLANT---
    if (t < 160) {
      drawSeed();
    } else if (t < 260) {
      growth = map(t, 160, 260, 0, 1);
      drawPlant(growth);
    }

    // --- CLOCK ENTERS ---
    else if (t < 320) {
      drawPlant(growth);
      drawClock(clockY);
      clockY = lerp(clockY, 200, 0.08);
    }

    // --- CLOCK FALL ---
    else {
      drawPlant(growth);
      drawClock(clockY);
      falling = true;
    }

    if (falling) {
      fallSpeed += 2.5;  
      clockY += fallSpeed;

      if (clockY > 400) {
        impact = true;
      }
    }

    t++;
  }

  // --- IMPACT ---
  else {
    background(10);

    // plant just disappears
    // drawPlant(??)

    // clock
    drawClock(400);

    // missing: shockwave, dust, flash

    // text
    fill(255);
    textAlign(CENTER);
    text("My greatest fear isn’t failing.", width/2, height/2 + 250);
  }
}

// --- SEED ---
void drawSeed() {
  fill(180, 140, 150);
  noStroke();
  ellipse(width/2, height/2 + 200, 40, 28);
}

// --- PLANT  ---
void drawPlant(float g) {
  pushMatrix();
  translate(width/2, height/2 + 250);

  stroke(130, 210, 160);
  strokeWeight(6);
  noFill();

  beginShape();
  for (int i = 0; i < 20; i++) {
    float t = i / 19.0;
    float y = -300 * g * t;
    float x = sin(t * PI) * 20 * g;
    vertex(x, y);
  }
  endShape();

  popMatrix();
}

// --- CLOCK  ---
void drawClock(float y) {
  pushMatrix();
  translate(width/2, y);

  fill(200);
  stroke(0);
  strokeWeight(4);
  ellipse(0, 0, 200, 200);

  fill(255);
  ellipse(0, 0, 160, 160);

  // hour marks 
  for (int i = 0; i < 12; i++) {
    float ang = radians(i * 30);
    float x1 = 60 * cos(ang);
    float y1 = 60 * sin(ang);
    float x2 = 75 * cos(ang);
    float y2 = 75 * sin(ang);
    line(x1, y1, x2, y2);
  }

  // static hands 
  line(0, 0, 50, 0);
  line(0, 0, 0, -70);

  popMatrix();
}
