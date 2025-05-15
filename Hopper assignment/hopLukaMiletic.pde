/*
 COMP 1000 - Luka Miletic 49055267
 Title - Kirb Hopper Syndrome
 
 
 */

float xKirb, yKirb, xDirection, yDirection; 
float angleKirb, spinKirb;
color skinKirb, shoesKirb;

// Stars
int numStars = 100;
float[] starX = new float[numStars]; // creates new arrayopf 100 float values needed to store all stars and velow
float[] starY = new float[numStars];
float[] starBrightness = new float[numStars];
float[] starSize = new float[numStars];
float[] starSpeed = new float[numStars];

void setup() {
  size(1000, 1000);
  xKirb = width / 2;
  yKirb = height / 2;
  xDirection = random(-4, 4);
  yDirection = random(-4, 4);
  spinKirb = 2;
  angleKirb = 0;
  skinKirb = #E3ABB5;
  shoesKirb = #CD1B3F;

  for (int i = 0; i < numStars; i++) { // setups stars 100 times
    starX[i] = random(width);
    starY[i] = random(height);
    starBrightness[i] = random(100, 255); // random brightness for each star so it looks like some closer/farter same as below (passing speed/size)
    starSize[i] = random(1, 3);
    starSpeed[i] = random(0.1, 0.4);
  }
}

void draw() {
  background(0, 0, 40); // space background

  // moon wip
  stroke(255);
  fill(220, 220, 220);
  ellipse(150, 150, 200, 200);

  // stars
  for (int i = 0; i < numStars; i++) {
    starX[i] -= starSpeed[i];
    if (starX[i] < 0) {
      starX[i] = width;
      starY[i] = random(height);
    }
    fill(255, starBrightness[i]);
    noStroke();
    ellipse(starX[i], starY[i], starSize[i], starSize[i]);
  }

  // game to make kirb blue by hovering mouse over it while moving if not goes red
  boolean mouseOver = dist(mouseX, mouseY, xKirb, yKirb) < 40;
  if (keyPressed) {
    if (mouseOver) {
      skinKirb = #9EDEF9; // blue
    } else {
      skinKirb = #d22044; // red
      shoesKirb = #852e63;
    }
  }

  angleKirb += spinKirb;
}

void drawKirby(float x, float y, float angle, boolean armsUpState, color skinKirb, color shoesKirb) {

  pushMatrix();
  translate(x, y);
  rotate(radians(angle));
  translate(-x, -y);

  fill(skinKirb); // body
  ellipse(x, y, 80, 80);

  fill(skinKirb); // left arm
  pushMatrix();
  translate(x - 40, y + 10);
  if (armsUpState) {
    rotate(radians(-60));  // arm raised
  } else {
    rotate(radians(30));   // arm resting
  }
  ellipse(0, 0, 10, 25);
  popMatrix();

  fill(skinKirb); // right arm
  pushMatrix();
  translate(x + 40, y + 10);
  if (armsUpState) {
    rotate(radians(60));  // arm raised
  } else {
    rotate(radians(-30));   // arm resting
  }
  ellipse(0, 0, 10, 25);
  popMatrix();

  fill(shoesKirb); // left leg
  pushMatrix();
  translate(x - 25, y + 40);
  ellipse(0, 0, 20, 10);
  popMatrix();

  fill(shoesKirb); // right leg
  pushMatrix();
  translate(x + 25, y + 40);
  ellipse(0, 0, 20, 10);
  popMatrix();

  popMatrix();
}


void keyPressed() {
  // adds movement to the velocity of kirb other then mouse clikc
  if (keyPressed) {
    if (key == 'w' || key == 'W') {
      yDirection -= 0.1;
    }
    if (key == 's' || key == 'S') {
      yDirection += 0.1;
    }
    if (key == 'a' || key == 'A') {
      xDirection -= 0.1;
    }
    if (key == 'd' || key == 'D') {
      xDirection += 0.1;
    }
  }
}
