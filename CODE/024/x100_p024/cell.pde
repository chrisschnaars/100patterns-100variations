class Cell {

  float x, y; // x and y position of cell
  float w, h; // width and height of cell
  int cId, rId; // column and row ids

  Cell(float _x, float _y, int _cId, int _rId) {
    x = _x;
    y = _y;
    w = cellW;
    h = cellH;
    cId = _cId;
    rId = _rId;
  }

  // CONFIGURE CELL
  void configure() {

    // QUARTER ARC
    // OPTIONS: N, W, S, E
    int qArcPresence = floor(random(0, 10)); // Decides if there will be an arc in the cell
    int qArcOrientation = floor(random(0, 4)); // Orientation of arc

    // HALF ARC
    // OPTIONS: N, W, S, E
    int hArcPresence = floor(random(0, 10)); // Decides if there will be an arc in the cell
    int hArcOrientation = floor(random(0, 4)); // Orientation of arc

    // COLOR SELECTORS
    int c1, c2, c3;
    do {
      c1 = floor(random(0, shapeColors.length));
      c2 = floor(random(0, shapeColors.length));
      c3 = floor(random(0, shapeColors.length));
    } while (c1 == c2 || c2 == c3 || c1 == c3);

    // OPTIONS: FILL OR STROKE
    int s1 = floor(random(0, 2));
    int s2 = floor(random(0, 2));

    // DRAW SHAPE
    render(qArcPresence, qArcOrientation, hArcPresence, hArcOrientation, c1, c2, c3, s1, s2);

  }

  // DRAW CELL
  void render(int qArcPresence, int qArcOrientation, int hArcPresence, int hArcOrientation, int c1, int c2, int c3, int s1, int s2) {

    // BEGIN DRAWING
    pushMatrix();

    // ORIENT AT TOP LEFT
    translate(x,y);

    // GLOBAL DRAWING SETTINGS
    strokeWeight(2);

    // SKETCH VARIABLES;
    boolean drawBG = false; // draw containing cell (good for debugging)
    int qArcThreshold = 7;  // 70% chance of getting quarter arc
    int hArcThreshold = 7; // 60% chance of getting half arc

    // BACKGROUND CELL BORDER
    // FOR DEBUGGING PURPOSES
    if (drawBG) {
      noFill();
      stroke(255);
      rect(0, 0, w, h);
    }

    /*
     QUARTER ARC
    */

    noStroke();
    fill(shapeColors[c3]);
    rect(0, 0, w, h);

    // DRAW QUARTER ARC
    if (qArcPresence < qArcThreshold) {
      drawQuarterArc(qArcOrientation, c1, s1);
    }

    // DRAW HALF ARC
    if (hArcPresence < hArcThreshold) {
      drawHalfArc(hArcOrientation, c2, s2);
    }

    // DRAW ELLIPSE IF BOTH ARE NOT PAST THRESHOLD
    if (qArcPresence >= qArcThreshold && hArcPresence >= hArcThreshold) {
      // noFill();
      // strokeWeight(4);
      // stroke(shapeColors[c1]);
      fill(shapeColors[c1]);
      float ww = w * 0.666667;
      ellipse(w/2, h/2, ww, ww);
      // float[] modifiers = { 0.5, 0.5, 0.25 };
      // for (int i=0; i<3; i++) {
      //   float ww = w * modifiers[i];
      //   ellipse(w/2, h/2, ww, ww);
      // }
      // ellipse(w/2, h/2, w*0.9, h*0.9);
    }

    // END DRAWING
    popMatrix();
  }

  // DRAW QUARTER ARC
  void drawQuarterArc(int o, int c, int s) {
    pushMatrix();

    // ARC PARAMETER ARRAYS
    float[] xpos = { 0, w, w, 0 };
    float[] ypos = { 0, 0, h, h };
    float[] arcStart = { 0, 90, 180, 270 };

    // DRAW ARC
    noStroke();
    fill(shapeColors[c]);
    arc(xpos[o], ypos[o], w*2, h*2, radians(arcStart[o]), radians(arcStart[o] + 90), PIE);

    popMatrix();
  }

  // DRAW HALF ARC
  void drawHalfArc(int o, int c, int s) {
    pushMatrix();

    // ARC PARAMETER ARRAYS
    float[] xpos = { w/2, w, w/2, 0 };
    float[] ypos = { 0, h/2, h, h/2 };
    float[] arcStart = { 0, 90, 180, 270 };


    noStroke();
    fill(shapeColors[c]);
    arc(xpos[o], ypos[o], w, h, radians(arcStart[o]), radians(arcStart[o] + 180), PIE);

    popMatrix();
  }


}
