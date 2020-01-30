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
  void configure() {

    // DOT PRESENCE
    // OPTIONS: YES OR NO
    int dotPresence = floor(random(0, 10)); // yes has 10:1 odds

    // DOT LOCATION
    // OPTIONS: NW, NE, SE, SW QUADRANT
    int dotLocation = floor(random(0, 4));;

    // SHAPE PRESENCE
    // OPTIONS: YES OR NO
    int shapePresence = floor(random(0, 10)); // yes has 10:1 odds

    // SHAPE DECIDERS
    // OPTIONS: TRIANGLE, BAR, HALF-ARC, QUARTER-ARC, LINE
    int shapeDecider = floor(random(0, 3));

    // SHAPE COLOR DECIDERS
    // NEED TO BE DIFFERENT
    int c1 = floor(random(0, shapeColors.length));
    int c2;
    do {
      c2 = floor(random(0, shapeColors.length));
    } while (c1 == c2);

    // DRAW SHAPE
    render(dotPresence, dotLocation, shapePresence, shapeDecider, c1, c2);

  }

  // DRAW CELL
  void render(int dotPresence, int dotLocation, int shapePresence, int shapeDecider, int c1, int c2) {

    // BEGIN DRAWING
    pushMatrix();

    // ORIENT AT TOP LEFT
    translate(x,y);

    // GLOBAL DRAWING SETTINGS
    strokeWeight(2);

    // SKETCH VARIABLES;
    boolean drawBG = false;
    int shapeThreshold = 7;  // DECIDING FACTOR OF WHETHER THERE IS A SHAPE
    int dotThreshold = 9; // DECIDING WHETHER TO DRAW DOT
    float dotSize = w * 0.15; // SIZE OF DOT

    // BACKGROUND CELL BORDER
    // FOR DEBUGGING PURPOSES
    if (drawBG) {
      noFill();
      stroke(255);
      rect(0, 0, w, h);
    }

    /*
     SHAPE
    */

    if (shapePresence < shapeThreshold) {

      // TRIANGLE
      if (shapeDecider == 0) {
        drawTriangle(c1);
      }

      // BAR
      if (shapeDecider == 1) {
        drawBar(c1);
      }

      // // HALF-ARC
      // if (shapeDecider == 2) {
      //   // DETERMIEN QUANTITY OF ARCS
      //   int aQ = floor(random(0, 2));
      //
      //   if (aQ == 0) {
      //     drawHalfArc(c1);
      //   } else {
      //     drawHalfArc(c1);
      //     drawHalfArc(c1);
      //   }
      // }
      //
      // // QUARTER-ARC
      // if (shapeDecider == 3) {
      //   drawQuarterArc(c1);
      // }

      // LINE
      if (shapeDecider == 2) {
        drawLine(c1);
      }
    }

    /*
     DOTS
    */

    // ONLY DRAW IF CELL HAS A DOT
    if (dotPresence < dotThreshold) {

      // OFFSET FOR QUADRANTS
      float dotOffsetX = w/4;
      float dotOffsetY = h/4;

      // X AND Y POSITIONS
      // NW, NE, SE, SW
      float[] dotX = { dotOffsetX, w - dotOffsetX, w - dotOffsetX, dotOffsetX };
      float[] dotY = { dotOffsetY, dotOffsetY, h - dotOffsetY, h - dotOffsetY };

      // DRAW DOT
      ellipseMode(CENTER);
      noStroke();
      fill(shapeColors[c2]);
      ellipse(dotX[dotLocation], dotY[dotLocation], dotSize, dotSize);
    }

    // END DRAWING
    popMatrix();
  }

  // DRAW A TRIANGLE
  void drawTriangle(int col) {
    pushMatrix();

    // ORIENT AT CENTER FOR ROTATION
    translate(w/2, h/2);

    // GENERATE RANDOM ORIENTATION
    float tO = floor(random(0, 4));

    // SET ROTATION
    float r = radians(tO * 90);
    rotate(r);

    // DRAW TRIANGLE
    noStroke();
    fill(shapeColors[col]);
    triangle(-w/2, -h/2, w/2, h/2, -w/2, h/2);

    popMatrix();
  }

  // DRAW A BAR
  void drawBar(int col) {
    pushMatrix();

    // GENERATE RANDOM ORIENTATION
    int bO = floor(random(0, 4));

    // GENERATE RANDOM STYLE ORIENTATION
    int bStyle = floor(random(0, 2));
    bStyle = 1;

    // BAR POSITIONS AND SIZES
    float[] xpos = { 0, w/2, 0, 0 };
    float[] ypos = { 0, 0, h/2, 0};
    float[] bW = { w, w/2, w, w/2 };
    float[] bH = { h/2, h, h/2, h };

    // DRAW BAR
    noStroke();
    fill(shapeColors[col]);

    if (bStyle == 0) {
      rect(xpos[bO], ypos[bO], bW[bO], bH[bO]);
    } else {
      // STRIPE SETTINGS
      int numLines = 10;
      int stripeSize = 2;
      float lineSpacer;

      // HORIZONTAL BARS
      if (bW[bO] > bH[bO]) {
        lineSpacer = bW[bO] / (numLines - 1);

        for (int i=0; i<numLines; i++) {
          float xP = xpos[bO] + (i * lineSpacer);
          float yP = ypos[bO];
          float w = stripeSize;
          float h = bH[bO];

          rect(xP, yP, w, h);
        }
      }

      // VERTICAL BARS
      if (bW[bO] < bH[bO]) {
        lineSpacer = bH[bO] / (numLines - 1);

        for (int i=0; i<numLines; i++) {
          float xP = xpos[bO];
          float yP = ypos[bO] + (i * lineSpacer);
          float w = bW[bO];
          float h = stripeSize;

          rect(xP, yP, w, h);
        }
      }
    }
    popMatrix();
  }

  // DRAW A HALF ARC STROKE
  void drawHalfArc(int col) {
    pushMatrix();
    strokeWeight(4);

    // ARC POSITIONS - SET 1
    float[] aX = { w/2, w, w/2, 0 };
    float[] aY = { 0, h/2, h, h/2 };
    float[] aStart = { 0, 90, 180, 270 };

    // ARC POSITIONS - SET 2
    float[] bStart = { 180, 270, 0, 90 };

    // GENERATE RANDOM ORIENTATION & DIRECTION
    int aO = floor(random(0, 4));
    int aD = floor(random(0, 1));

    // SET ARC COORDINATES
    float xpos = aX[aO];
    float ypos = aY[aO];
    float start = aStart[aO];
    float stop = start + 180;

    // MODIFY IF DIRECTION IS INVERSE
    if (aD == 1) {
      xpos = 0;
      ypos = 0;
      start = bStart[aO];
      stop = start + 180;
    }

    // DRAW ARC
    noFill();
    stroke(shapeColors[col]);
    arc(xpos, ypos, w, h, radians(start), radians(stop));

    popMatrix();
  }

  // DRAW A HALF ARC STROKE
  void drawQuarterArc(int col) {
    pushMatrix();

    // ARC POSITIONS - SET 1
    float[] aX = { 0, w, w, 0 };
    float[] aY = { 0, 0, h, h };
    float[] aStart = { 0, 90, 180, 270 };

    // GENERATE RANDOM ORIENTATION & DIRECTION
    int aO = floor(random(0, 4));

    // SET ARC COORDINATES
    float xpos = aX[aO];
    float ypos = aY[aO];
    float start = aStart[aO];
    float stop = start + 45;

    // DRAW ARC
    noStroke();
    fill(shapeColors[col]);
    arc(xpos, ypos, w*2, h*2, radians(start), radians(stop));

    popMatrix();
  }

  void drawLine(int col) {
    pushMatrix();

    // LINE COORDINATES
    float[] lx1 = { 0, w };
    float[] lx2 = { w, 0 };

    // RANDOM LINE ORIENTATION
    int lO = floor(random(0, 2));

    // DRAW LINE
    strokeWeight(4);
    stroke(shapeColors[col]);
    noFill();

    if (lO == 0) {
      line(0, 0, w, h);
    } else {
      line(w, 0, 0, h);
    }

    popMatrix();

  }
}
