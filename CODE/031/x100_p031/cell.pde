class Cell {

  float x, y; // x and y position of cell
  float w, h; // width and height of cell
  float cId, rId; // column and row ids

  Cell(float _x, float _y, float _cId, float _rId) {
    x = _x;
    y = _y;
    w = cellW;
    h = cellH;
    cId = _cId;
    rId = _rId;
  }

  // CONFIGURE CELL
  void configure() {

    // SHAPE DISPLAY ID
    float shapeDisplay = random(0, 1);

    // SHAPE DECIDER
    // OPTIONS: TRIANGLE, HALF ARC, RECTANGLE
    int shapeDecider01 = floor(random(0, 3));
    int shapeDecider02 = floor(random(0, 3));

    // SIDE DECIDER
    // OPTIONS: NORTH, WEST, SOUTH, EAST
    int side01, side02;
    do {
      side01 = floor(random(0, 4));
      side02 = floor(random(0, 4));
    } while (side01 == side02);

    // COLORS
    int c1, c2;
    do {
      c1 = floor(random(0, shapeColors.length));
      c2 = floor(random(0, shapeColors.length));
    } while (c1 == c2);

    // DRAW
    render(shapeDisplay, shapeDecider01, shapeDecider01, side01, side02, c1, c2);
  }

  // DRAW CELL
  void render(float shapeDisplay, int shapeDecider01, int shapeDecider02, int side01, int side02,
    int c1, int c2) {

    // BEGIN DRAWING
    pushMatrix();

    // ORIENT AT TOP LEFT
    translate(x,y);

    // DISPLAY VARIABLES
    boolean drawBG = false; // draw containing cell (good for debugging)
    float shapeThreshold = 1.00;

    // BACKGROUND CELL BORDER FOR DEBUGGING
    if (drawBG) {
      noFill();
      stroke(255);
      rect(0, 0, w, h);
    }

    /**** SHAPES ****/

    // CREATE ARRAY OF SHAPE DECIDERS
    int[] shapes = { shapeDecider01, shapeDecider01 };
    int[] sides = { side01, side02 };

    // CREATE COLORS
    // int cMin = floor((cId + rId) / 4);
    // int cMax = cMin + 3;
    //
    // int col1, col2;
    // do {
    //   col1 = floor(random(cMin, cMax));
    //   col2 = floor(random(cMin, cMax));
    // } while (col1 == col2);
    int[] colors = { c1, c2 };

    // DRAW EACH SHAPES
    if (shapeDisplay < shapeThreshold) {

      for (int i=0; i<2; i++) {
        // COLOR CHOICE
        float styleId = (cId + rId) / 18;
        float styleDecider = random(0, 1);
        // println(cId, rId);

        if (styleDecider < styleId) {
          // noStroke();
          fill(shapeColors[colors[i]]);
        } else {
          noFill();
          // strokeWeight(2);
          // stroke(shapeColors[colors[i]]);
        }
        strokeWeight(2);
        stroke(shapeColors[colors[i]]);

        // if (i == 0) {
        //   noStroke();
        //   fill(shapeColors[colors[i]]);
        // } else {
        //   noFill();
        //   strokeWeight(2);
        //   stroke(shapeColors[colors[i]]);
        // }
        // strokeWeight(2);
        // stroke(shapeColors[colors[i]]);

        // TRIANGLE
        if (shapes[i] == 0) {
          drawTriangle(sides[i], colors[i]);
        }

        // HALF ARC
        if (shapes[i] == 1) {
          drawHalfArc(sides[i], colors[i]);
        }

        // RECTANGLE
        if (shapes[i] == 2) {
          drawRectangle(sides[i], colors[i]);
        }
      }
    }

    // END DRAWING
    popMatrix();
  }

  // DRAW QUARTER ARC
  void drawTriangle(int s, int c) {
    pushMatrix();

    // SET TRIANGLE DIMENSIONS
    float tW = w;
    float tH = h/2;

    // GENERATE TRIANGLE TYPE (INWARD OR OUTWARD FACING)
    int type = floor(random(0, 2));

    // SET X AND Y POSITIONS
    float[] xp1 = { 0, w, w, 0 };
    float[] yp1 = { 0, 0, h, h };
    float[] xp2 = { 0, w, w, 0 };
    float[] yp2 = { tH, tH, h-tH, h-tH };
    float[] xp3 = { w, 0, 0, w };
    float[] yp3 = { 0, 0, h, h };

    if (type == 1) {
      yp3[0] = tH;
      yp3[1] = tH;
      yp3[2] = h-tH;
      yp3[3] = h-tH;
    }

    // SET TRIANGLE VERTEX SIZE
    float t = w/2;

    // // SETUP COLOR
    // int style = floor(random(0, 2));
    // style = 0;
    //
    // if (style == 0) {
    //   noStroke();
    //   fill(shapeColors[c]);
    // } else {
    //   noFill();
    //   strokeWeight(4);
    //   stroke(shapeColors[c]);
    // }

    // DRAW SINGLE TRIANGLE
    triangle(xp1[s], yp1[s], xp2[s], yp2[s], xp3[s], yp3[s]);

    popMatrix();
  }

  // DRAW HALF ARC
  void drawHalfArc(int s, int c) {
    pushMatrix();

    // DETERMINE ARC ORIENTATION (FACE IN OR OUT)
    int type = floor(random(0, 2));

    // ARC POSITIONS FOR FACE OUT ARC
    float[] xpos = { w/2, w, w/2, 0 };
    float[] ypos = { 0, h/2, h, h/2 };
    float[] arcStart = { 0, 90, 180, 270 };

    // SETUP COLOR
    // int style = floor(random(0, 2));
    // style = 0;
    //
    // if (style == 0) {
    //   noStroke();
    //   fill(shapeColors[c]);
    // } else {
    //   noFill();
    //   strokeWeight(4);
    //   stroke(shapeColors[c]);
    // }

    // FACE OUT ARC
    if (type == 0) {
      arc(xpos[s], ypos[s], w, h, radians(arcStart[s]), radians(arcStart[s] + 180), PIE);
    }

    // FACE IN ARC
    if (type == 1) {
      arc(w/2, h/2, w, h, radians(arcStart[s] + 180), radians(arcStart[s] + 360), PIE);
    }

    popMatrix();
  }

  // DRAW RECTANGLE
  void drawRectangle(int s, int c) {
    pushMatrix();

    // RECTANGLE DIMENSIONS
    float rW = w;
    float rH = h/2;

    float[] xpos = { 0, w, w, 0 };
    float[] ypos = { 0, 0, h, h };
    float[] w = { rW, -rH, -rW, rH };
    float[] h = { rH, rW, -rH, -rW };

    // SETUP COLOR
    // int style = floor(random(0, 2));
    // style = 0;
    //
    // if (style == 0) {
    //   noStroke();
    //   fill(shapeColors[c]);
    // } else {
    //   noFill();
    //   strokeWeight(4);
    //   stroke(shapeColors[c]);
    // }

    // DRAW RECTANGLE
    rect(xpos[s], ypos[s], w[s], h[s]);

    popMatrix();
  }
}
