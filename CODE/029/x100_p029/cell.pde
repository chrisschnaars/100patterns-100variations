class Cell {

  float x, y; // x and y position of cell
  float w, h; // width and height of cell
  int cId, rId; // column and row ids
  int sW;

  Cell(float _x, float _y, int _cId, int _rId) {
    x = _x;
    y = _y;
    w = cellW;
    h = cellH;
    cId = _cId;
    rId = _rId;
    sW = 4; // stroke weight
  }

  // CONFIGURE CELL
  void configure() {

    // BG DISPLAY ID
    int bgDisplay = floor(random(0, 10));

    // SHAPE DISPLAY ID
    int shapeDisplay = floor(random(0, 10));

    // SHAPE DECIDER
    // OPTIONS: TRIANGLE, HALF ARC FACE OUT, HALF ARC FACE IN
    int shapeDecider = floor(random(0, 3));

    // SHAPE ORIENTATION
    // OPTIONS: NORTH, WEST, SOUTH, EAST
    int shapeOrientation = floor(random(0, 4));

    // LINE DISPLAY ID
    int linesDisplay = floor(random(0, 10));

    // LINE ORIENTATION
    // OPTIONS: VERTICAL, HORIZONTAL, DIAGONAL LTR, DIAGONAL RTL
    int linesOrientation = floor(random(0, 4));

    // COLORS
    int c1, c2, c3;
    do {
      c1 = floor(random(0, shapeColors.length));
      c2 = floor(random(0, shapeColors.length));
      c3 = floor(random(0, shapeColors.length));
    } while (c1 == c2 || c2 == c3 || c1 == c3);

    // DRAW
    render(bgDisplay, shapeDisplay, shapeDecider, shapeOrientation, linesDisplay, linesOrientation, c1, c2, c3);
  }

  // DRAW CELL
  void render(int bgDisplay, int shapeDisplay, int shapeDecider, int shapeOrientation, int linesDisplay,
    int linesOrientation, int c1, int c2, int c3) {

    // BEGIN DRAWING
    pushMatrix();

    // ORIENT AT TOP LEFT
    translate(x,y);

    // DISPLAY VARIABLES
    boolean drawBG = false; // draw containing cell (good for debugging)
    int bgThreshold = 3;
    int shapeThreshold = 8;
    int linesThreshold = 5;

    // BACKGROUND CELL BORDER FOR DEBUGGING
    if (drawBG) {
      noFill();
      stroke(255);
      rect(0, 0, w, h);
    }


    /**** BG FILL ****/

    if (bgDisplay < bgThreshold) {
      noStroke();
      fill(shapeColors[c1]);
      rect(0, 0, w, h);
    }


    /**** SHAPE ****/

    if (shapeDisplay < shapeThreshold) {

      boolean noLines = true;
      if (linesDisplay < linesThreshold) {
        noLines = false;
      }

      // TRIANGLE
      if (shapeDecider == 0) {
        drawTriangle(shapeOrientation, c2, noLines);
      }

      // HALF ARC
      if (shapeDecider > 0) {
        drawHalfArc(shapeDecider, shapeOrientation, c2, noLines);
      }
    }


    /**** LINES ****/

    // LINES SETUP
    int numLines = 8;

    if (linesDisplay < linesThreshold) {

      // HORIZONTAL AND VERTICAL LINES
      if (linesOrientation <= 1) {
        drawLines(numLines, linesOrientation, c3);
      }

      // HORIZONTAL AND VERTICAL LINES
      if (linesOrientation > 1) {
        drawDiagonalLines(numLines, linesOrientation, c3);
      }
    }

    // END DRAWING
    popMatrix();
  }

  // DRAW QUARTER ARC
  void drawTriangle(int o, int c, boolean stroke) {
    pushMatrix();

    // ORIENT AT CELL CENTER
    translate(w/2, h/2);

    // SET TRIANGLE VERTEX SIZE
    float t = w/2;

    // SETUP COLOR
    if (!stroke) {
      noStroke();
      fill(shapeColors[c]);
    } else {
      noFill();
      strokeWeight(4);
      stroke(shapeColors[sW]);
    }

    // DRAW SINGLE TRIANGLE
    rotate(radians(o * 90));
    triangle(-t, -t, t, t, -t, t);

    popMatrix();
  }

  // DRAW HALF ARC
  void drawHalfArc(int type, int o, int c, boolean stroke) {
    pushMatrix();

    // ARC POSITIONS FOR FACE OUT ARC
    float[] xpos = { w/2, w, w/2, 0 };
    float[] ypos = { 0, h/2, h, h/2 };
    float[] arcStart = { 0, 90, 180, 270 };

    // SETUP COLOR
    if (!stroke) {
      noStroke();
      fill(shapeColors[c]);
    } else {
      noFill();
      strokeWeight(sW);
      stroke(shapeColors[c]);
    }

    // FACE OUT ARC
    if (type == 1) {
      arc(xpos[o], ypos[o], w, h, radians(arcStart[o]), radians(arcStart[o] + 180), PIE);
    }

    // FACE IN ARC
    if (type == 2) {
      arc(w/2, h/2, w, h, radians(arcStart[o]), radians(arcStart[o] + 180), PIE);
    }

    popMatrix();
  }

  // DRAW HORIZONTAL AND VERTICAL LINES
  void drawLines(int num, int o, int c) {

    // SET LINES STROKE
    noFill();
    strokeWeight(sW);
    stroke(shapeColors[c]);

    // LINE POINT VARIABLES
    float lineSpacer = w / (num-1);
    float px1, px2, py1, py2;

    // SETUP LINE points
    for (int i=0; i<num; i++) {
      if (o == 0) {
        px1 = i * lineSpacer;
        py1 = 0;
        px2 = px1;
        py2 = h;
      } else {
        px1 = 0;
        py1 = i * lineSpacer;
        px2 = w;
        py2 = py1;
      }

      // DRAW LINE
      line(px1, py1, px2, py2);
    }
  }

  // DRAW DIAGONAL LINES
  void drawDiagonalLines(int num, int o, int c) {

    // SET LINES STROKE
    noFill();
    strokeWeight(sW);
    stroke(shapeColors[c]);

    // LINE SPACING CALCULATIONS
    float linesPerSide = floor(num / 2);
    float lineSpacer = w / linesPerSide;
    float hL = lineSpacer/2;

    // LINE POINT VARIABLES
    float px1 = 0;
    float px2 = 0;
    float py1 = 0;
    float py2 = 0;

    // DRAW LINE
    for (int i = 0; i < num; i++) {
      // DIAGONAL LTR
      if (o == 2) {
        // MATCH POINTS BASED ON SIDE
        if (i <= linesPerSide-1) {
          px1 = 0;
          py1 = h - hL - (i * lineSpacer);
          px2 = hL + (i * lineSpacer);
          py2 = h;
        } else {
          px1 = hL + ((i - linesPerSide) * lineSpacer);
          py1 = 0;
          px2 = w;
          py2 = h - hL - ((i - linesPerSide) * lineSpacer) ;
        }
      } else {
        // MATCH POINTS BASED ON SIDE
        if (i <= linesPerSide-1) {
          px1 = 0;
          py1 = hL + (i * lineSpacer);
          px2 = hL + (i * lineSpacer);
          py2 = 0;
        } else {
          px1 = hL + ((i - linesPerSide) * lineSpacer);
          py1 = h;
          px2 = w;
          py2 = hL + ((i - linesPerSide) * lineSpacer);
        }
      }

      // DRAW LINE
      line(px1, py1, px2, py2);
    }


  }



}
