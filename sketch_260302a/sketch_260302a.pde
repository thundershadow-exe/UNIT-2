// White intro → dark world → realistic clock → fast fall → plant squish → white text

float t = 0;
float growth = 0;
float clockY = -400;
float fallSpeed = 0;
boolean falling = false;
boolean impact = false;
float squish = 1.0;
float textAlpha = 0;
float fadeToDark = 0;

PFont font;

void setup() {
  size(900, 900);
  font = createFont("Georgia", 34);
}

void draw() {

  // --- WHITE INTRO ---
  if (t < 60) {
    background(255);
    t++;
    return;
  }

  // --- FADE TO DARK ---
  fadeToDark = min(1, (t - 300) / 40.0);
  drawBackground(fadeToDark);

  if (!impact) {
    // --- PLANT GROWTH ---
    if (t < 180) {
      drawSeed();
    } else if (t < 300) {
      growth = map(t, 180, 300, 0, 1);
      drawPlant(growth, 1.0);
    }

    // --- CLOCK ENTERS ---
    else if (t < 360) {
      drawPlant(growth, 1.0);
      drawClock(clockY, true);
      clockY = lerp(clockY, 200, 0.18);
    }

    // --- CLOCK FALLS  ---
    else {
      drawPlant(growth, 1.0);
      drawClock(clockY, false);
      falling = true;
    }

    if (falling) {
      fallSpeed += 4.5; 
      clockY += fallSpeed;

      if (clockY >= 420) {
        impact = true;
      }
    }

    t++;
  }

  // --- IMPACT SEQUENCE ---
  else {
    // screen shake
    translate(random(-18, 18), random(-18, 18));

    // plant squish
    squish = max(0.05, squish - 0.12);
    drawPlant(0.55, squish);

    // clock landed
    drawClock(420, false);

    // shockwave
    drawShockwave();

    // dust burst
    drawDust();

    // one-frame flash
    if (frameCount % 2 == 0) {
      fill(255, 40);
      rect(0, 0, width, height);
    }

    // fade to full dark
    fill(0, 8);
    rect(0, 0, width, height);

    // final text
    drawFinalText();
  }
}

// --- CLEAN DARK BACKGROUND ---
void drawBackground(float fade) {
  for (int y = 0; y < height; y++) {
    float p = map(y, 0, height, 0, 1);
    int c = lerpColor(color(255), color(0, 0, 0), fade);
    int d = lerpColor(c, color(10, 0, 15), p);
    stroke(d);
    line(0, y, width, y);
  }
}

// --- SEED ---
void drawSeed() {
  fill(200, 150, 160);
  noStroke();
  ellipse(width/2, height/2 + 200, 55, 40);
}

// --- PLANT (with squash) ---
void drawPlant(float g, float squash) {
  pushMatrix();
  translate(width/2, height/2 + 250);
  scale(1, squash);

  stroke(130, 210, 160);
  strokeWeight(8);
  noFill();

  beginShape();
  for (int i = 0; i < 30; i++) {
    float t = i / 29.0;
    float y = -350 * g * t;
    float x = sin(t * PI) * 30 * g;
    vertex(x, y);
  }
  endShape();

  if (g > 0.15) {
    fill(150, 220, 170);
    noStroke();
    ellipse(-40, -160 * g, 80, 40);
  }
  if (g > 0.35) {
    ellipse(40, -240 * g, 80, 40);
  }
  if (g > 0.55) {
    ellipse(-30, -300 * g, 70, 35);
  }

  popMatrix();
}

// --- CLOCK ---
void drawClock(float y, boolean shaking) {
  pushMatrix();
  translate(width/2 + (shaking ? random(-4, 4) : 0), y);

  // rim
  fill(200);
  stroke(0);
  strokeWeight(6);
  ellipse(0, 0, 240, 240);

  // face
  fill(255);
  stroke(0);
  strokeWeight(3);
  ellipse(0, 0, 200, 200);

  // hour marks
  for (int i = 0; i < 12; i++) {
    float ang = radians(i * 30);
    float x1 = 80 * cos(ang);
    float y1 = 80 * sin(ang);
    float x2 = 95 * cos(ang);
    float y2 = 95 * sin(ang);
    line(x1, y1, x2, y2);
  }

  // hands
  float minuteAngle = radians(frameCount * 10);
  float hourAngle = radians(frameCount * 0.7);

  stroke(0);
  strokeWeight(5);
  line(0, 0, 90 * cos(minuteAngle), 90 * sin(minuteAngle));

  strokeWeight(7);
  line(0, 0, 60 * cos(hourAngle), 60 * sin(hourAngle));

  popMatrix();
}

// --- SHOCKWAVE ---
void drawShockwave() {
  noFill();
  stroke(255, 40);
  strokeWeight(3);
  float r = (frameCount - t) * 7;
  ellipse(width/2, 420, r, r);
}

// --- DUST ---
void drawDust() {
  for (int i = 0; i < 80; i++) {
    float x = width/2 + random(-220, 220);
    float y = 420 + random(-50, 50);
    fill(255, 40);
    noStroke();
    ellipse(x, y, random(3, 8), random(3, 8));
  }
}

// --- FINAL TEXT ---
void drawFinalText() {
  textAlpha = min(textAlpha + 2, 255);
  fill(255, textAlpha);
  textAlign(CENTER);
  textFont(font);

  text("My greatest fear isn’t failing.", width/2, height/2 + 300);
  text("It’s never trying.", width/2, height/2 + 340);
}
