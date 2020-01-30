class Cell {

  float x, y;
  float w, h;

  Cell(float _x, float _y) {
    x = _x;
    y = _y;
    w = cellW;
    h = cellH;
  }

  // CONFIGURE CELL
  void configure(int s) {

    // LINE ORIENTATION
    // OPTIONS: VERTICAL OR HORIZONTAL
    int lineOrientation = floor(random(0, 2));

    // SHAPE ORIENTATION
    // OPTIONS: VERTICAL OR HORIZONTAL
    int shapeOrientation = s;

    // SHAPE DIRECTION
    // OPTIONS: up/down vs down/up OR left/right vs right/left
    int shapeDirection = floor(random(0, 2));

    // SHAPE COLOR DECIDERS
    // NEED TO BE DIFFERENT
    int c1 = floor(random(0, shapeColors.length));
    int c2;
    do {
      c2 = floor(random(0, shapeColors.length));
    } while (c1 == c2);

    // DRAW SHAPE
    render(lineOrientation, shapeOrientation, shapeOrientation, c1, c2);

  }

  // DRAW CELL
  void render(int lineOrientation, int shapeOrientation, int shapeDirection, int c1, int c2) {

    // BEGIN DRAWING
    pushMatrix();

    // ORIENT AT TOP LEFT
    translate(x,y);

    // GLOBAL DRAWING SETTINGS
    boolean drawBG = false;
    strokeWeight(2);

    // SKETCH VARIABLES
    int numLines = 8;  // how many lines per cell
    float lineSpacer = w / (numLines - 1); // even space between lines
    int shapeOffset = 2; // how many lines does the shape offset
    float offsetDistance = shapeOffset * lineSpacer;

    // BACKGROUND CELL BORDER
    // FOR DEBUGGING PURPOSES
    if (drawBG) {
      fill(255);
      rect(0, 0, w, h);
    }

    /*
     LINES
    */

    // VERTICAL
    if (lineOrientation == 0) {

      // SET LINE COLOR
      noFill();
      stroke(shapeColors[c1]);

      // DRAW LINES
      for (int i = 0; i < numLines; i++) {
        float xpos = i * lineSpacer;
        line(xpos, 0, xpos, h);
      }
    }

    // HORIZONTAL
    if (lineOrientation == 1) {

      // SET LINE COLOR
      noFill();
      stroke(shapeColors[c1]);

      // DRAW LINES
      for (int i = 0; i < numLines; i++) {
        float ypos = i * lineSpacer;
        line(0, ypos, w, ypos);
      }
    }

    /*
     SHAPE
    */

    // GENERATE SHAPE START AND DIRECTIONAL COEFFICIENT
    int shapeStart, d;
    if (shapeDirection == 0) {
      shapeStart = floor(random(0, numLines - (shapeOffset* 2)));
      d =  1;
    } else {
      shapeStart = floor(random(shapeOffset, numLines - shapeOffset));
      d = -1;
    }

    // SHAPE COORDINATES
    float s1A = shapeStart * lineSpacer;
    float s1B = s1A + (offsetDistance * d);
    float s2A = s1A + offsetDistance;
    float s2B = s2A + (offsetDistance * d);

    // SET SHAPE COLOR
    noStroke();
    fill(shapeColors[c2]);

    // DRAW VERTICAL SHAPE
    if (shapeOrientation == 0) {
      float y1 = 0;
      float y2 = h;

      beginShape();
      vertex(s1A, y1);
      vertex(s1B, y2);
      vertex(s2B, y2);
      vertex(s2A, y1);
      endShape(CLOSE);
    }

    // DRAW HORIZONTAL SHAPE
    if (shapeOrientation == 1) {
      float x1 = 0;
      float x2 = h;

      beginShape();
      vertex(x1, s1A);
      vertex(x2, s1B);
      vertex(x2, s2B);
      vertex(x1, s2A);
      endShape(CLOSE);
    }





    // END DRAWING
    popMatrix();
  }
}
