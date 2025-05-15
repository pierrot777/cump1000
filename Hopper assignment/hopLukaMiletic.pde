/*
 COMP 1000 - Luka Miletic 49055267
 Title - Kirb Hopper Syndrome
 */

float xKirb, yKirb, xDirection, yDirection;
float angleKirb, spinKirb;
color skinKirb, shoesKirb;

// Horizontal movement variables
float xVelocity = 0; // Horizontal velocity for Kirby
float moveSpeed = 5; // Speed of movement
float friction = 0.8; // Friction for smooth stopping

// Stars
int numStars = 100;
float[] starX = new float[numStars]; // creates new array of 100 float values needed to store all stars and below
float[] starY = new float[numStars];
float[] starBrightness = new float[numStars];
float[] starSize = new float[numStars];
float[] starSpeed = new float[numStars];

float kirbVelocity = 0;
float gravity = 0.2;
float jumpStrength = -10;

// Platform properties
float platformX, platformY, platformWidth = 800, platformHeight = 20;

void setup() {
  size(1000, 1000);
  xKirb = width / 2;
  yKirb = height / 2;
  yDirection = random(-4, 4);
  spinKirb = 2;
  angleKirb = 0;
  skinKirb = #E3ABB5;
  shoesKirb = #CD1B3F;

  for (int i = 0; i < numStars; i++) { // setups stars 100 times
    starX[i] = random(width);
    starY[i] = random(height);
    starBrightness[i] = random(100, 255); // random brightness for each star so it looks like some closer/farther same as below (passing speed/size)
    starSize[i] = random(1, 3);
    starSpeed[i] = random(0.1, 0.4);
  }

  platformX = width / 2 - platformWidth / 2;
  platformY = height - 100;
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

  fill(120, 6, 6);
  rect(platformX, platformY, platformWidth, platformHeight);

  // Update Kirby's horizontal position
  xKirb += xVelocity;
  xVelocity *= friction; // Apply friction
  xKirb = constrain(xKirb, 50, width - 50); // Keep within bounds

  // Gravity
  kirbVelocity += gravity;
  yKirb += kirbVelocity;

  // Check for landing on platform
  if (yKirb + 40 >= platformY && yKirb + 40 <= platformY + platformHeight &&
    xKirb > platformX - 40 && xKirb < platformX + platformWidth + 40 &&
    kirbVelocity > 0) {
    kirbVelocity = jumpStrength;  // Jump when landing
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

  drawKirby(xKirb, yKirb, angleKirb, false, skinKirb, shoesKirb);
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
  if (key == 'a' || key == 'A') {
    xVelocity = -moveSpeed; // Move left
  }
  if (key == 'd' || key == 'D') {
    xVelocity = moveSpeed; // Move right
  }
  if (key == 'a' && key == 'b') { // wip wanna make kirby explode
    xKirb = 1000;
  }
  if (key == 'A' && key == 'B') {
    xKirb= 1000;
  }
}

void keyReleased() {
  if (key == 'a' || key == 'A' || key == 'd' || key == 'D') {
    xVelocity = 0; // Stop moving when key is released
  }
}
