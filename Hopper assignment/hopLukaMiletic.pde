/*
 COMP 1000 - Luka Miletic 49055267
 Title - Kirb floating simulator 2D
 
 How to use;
 WASD - use wasd to move the kirb thingy around, W makes kirbs velocity go up, A makes kirbs velocity go left, S makes kirb go right, and D makes kirb go down
 Any key press - challenge yourself by keeping the mouse on kirb while it bounces around the screen to get the really cool blue kirby... if key is pressed and mouse isnt on kirb he turns angry/red
 Mouse clicked - Pushes kirb away from the mouse (not nice) and makes him raise his hands also used as a reset if kirb getting a bit too fast
 
 Enjoy
 
 */

float xKirb, yKirb, xDirection, yDirection, speedKirb, angleKirb, spinKirb;
color skinKirb, shoesKirb;

int flashStart, flashDuration = 60;

boolean WASD = false;
boolean isFlashing = false;
boolean armsUp = false;


// Stars
int numStars = 100;
float[] starX = new float[numStars]; // creates new arrayopf 100 float values needed to store all stars and velow
float[] starY = new float[numStars];
float[] starBrightness = new float[numStars];
float[] starSize = new float[numStars];
float[] starSpeed = new float[numStars];

// spaceships
int numShips = 3;

void setup() {
  size(1000, 1000);
  xKirb = width / 2;
  yKirb = height / 2;
  xDirection = random(-4, 4);
  yDirection = random(-4, 4);
  speedKirb = 3;
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

  // if hits wall emits flashing animation
  if (isFlashing && millis() - flashStart < flashDuration) {
    fill(255, 255, 255, 100);
    rect(0, 0, width, height);
  } else {
    isFlashing = false;
  }

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

  // kirby movement
  xKirb += xDirection * speedKirb;
  yKirb += yDirection * speedKirb;

  // bounce off walls
  boolean hitWall = false;
  if (xKirb > width - 50 || xKirb < 50) {
    xDirection = -xDirection;
    hitWall = true;
  }
  if (yKirb > height - 50 || yKirb < 50) {
    yDirection = -yDirection;
    hitWall = true;
  }

  if (hitWall && !isFlashing) {
    isFlashing = true;
    flashStart = millis();
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

  drawKirby(xKirb, yKirb, angleKirb, armsUp, skinKirb, shoesKirb); // the 'void drawkirby' used ot be here before moved it to make it clearer would move stars too but wip



  println("x:", xKirb, "y:", yKirb);
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


void keyReleased() {
  skinKirb = #E3ABB5;
  armsUp = false;
}

void mousePressed() {
  // push kirby away from mouse position
  float dx = xKirb - mouseX;
  float dy = yKirb - mouseY;
  float length = dist(xKirb, yKirb, mouseX, mouseY);

  if (length > 0) {
    xDirection = dx / length;
    yDirection = dy / length;
  }

  spinKirb *= -1;  // flip kirby's spin
  armsUp = true;   // raise arms
}

void mouseReleased() {
  armsUp = false;
}

/* Personal Checklist
 - Does it run? YEs
 - Does it use setup and draw?? Yes
 - Does it use 2d shapes (YES), variables(YES), arithmetic(YES), if statements (YES), loops(YES), event handlers (YES)... All yes
 - Meet minimum requuirements? Yes
 - Movement? Yes i have mouse pressed functions and WASD movement.. it also float randomly by itself bouncing off the walls
 - User input? Yes i have so mouse pressed and WASD interacts with the animation and any key pressed (though it should be WASD) switches colour of kirb making it a mouse game having to keep the mouse in kirb while moving it around the screen progressively geting faster
 - Design and style? Yes, i used camel casing and using event handlers to clearly seperate parts of my code to be easy to use later.. i also spammed control T to insure the best formatting
 */
