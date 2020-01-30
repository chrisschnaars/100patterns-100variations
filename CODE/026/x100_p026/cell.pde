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

    // DISPLAY THRESHOLD ID
    int displayId = floor(random(0, 10));

    // LINE SEGMENT SELECTORS
    // OPTIONS: TOP, WEST, SOUTH, EAST
    int l1, l2;
    do {
      l1 = floor(random(0, 4));
      l2 = floor(random(0, 4));
    } while (l1 == l2);

    // ARC ORIENTATION SELECTORS
    int o = floor(random(0, 4));

    // COLOR SELECTORS
    int c1, c2;
    do {
      c1 = floor(random(0, shapeColors.length));
      c2 = floor(random(0, shapeColors.length));
    } while (c1 == c2);

    // DRAW
    render(displayId, l1, l2, o, c1, c2);
  }

  // DRAW CELL
  void render(int displayId, int l1, int l2, int o, int c1, int c2) {

    // BEGIN DRAWING
    pushMatrix();

    // ORIENT AT TOP LEFT
    translate(x,y);

    // GLOBAL DRAWING SETTINGS
    strokeWeight(4);
    noFill();

    // SKETCH VARIABLES;
    boolean drawBG = false; // draw containing cell (good for debugging)
    int displayThreshold = 8; // art has 8/10 chance of showing

    // BACKGROUND CELL BORDER FOR DEBUGGING
    if (drawBG) {
      noFill();
      stroke(255);
      rect(0, 0, w, h);
    }

    if (displayId < displayThreshold) {

      /*
       BORDER LINES
      */

      // X AND Y POSITIONS
      float[] lX1 = { 0, w, w, 0 };
      float[] lY1 = { 0, 0, h, h };
      float[] lX2 = { w, w, 0, 0 };
      float[] lY2 = { 0, h, h, 0 };

      // SET COLOR
      stroke(shapeColors[c1]);

      // DRAW BOTH LINES
      int[] lines = { l1, l2 };
      for (int i=0; i < lines.length; i++) {
        int id = lines[i];
        line(lX1[id], lY1[id], lX2[id], lY2[id]);
      }

      /*
       QUARTER ARC
      */

      // ARC POSITIONS
      float[] aX = { 0, w, w, 0 };
      float[] aY = { 0, 0, h, h };
      float[] aStart = { 0, 90, 180, 270 };

      // SET COLOR
      stroke(shapeColors[c2]);

      // DRAW MUSIC
      arc(aX[o], aY[o], w*2, h*2, radians(aStart[o]), radians(aStart[o] + 90));
    } else {
      int r = floor(random(0, 2));
      int numLines = 7;
      float lineSpacer = w/ (numLines-1);
      float px1, px2, py1, py2;
      stroke(shapeColors[c1]);

      for (int i=0; i<numLines; i++) {
        if (r == 0) {
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

    // END DRAWING
    popMatrix();
  }


  // DRAW HALF ARC
  // void drawQuarterArc(float eX, float eY, float eW, float eH, int style, int col) {
  //   pushMatrix();
  //
  //   // TRANSLATE AT CORNER
  //   translate(eX - (eW/2), eY - (eH/2));
  //
  //   // ARC POSITIONS
  //   float[] xpos = { 0, eW, eW, 0 };
  //   float[] ypos = { 0, 0, eH, eH };
  //   float[] arcStart = { 0, 90, 180, 270 };
  //
  //   // GENERATE ARC ORIENTATION
  //   int o = floor(random(0, 4));
  //
  //   // SETUP COLOR
  //   if (style < 1) {
  //     noStroke();
  //     fill(shapeColors[col]);
  //   } else {
  //     noFill();
  //     strokeWeight(globalStrokeWeight);
  //     stroke(shapeColors[col]);
  //   }
  //
  //   arc(xpos[o], ypos[o], eW*2, eH*2, radians(arcStart[o]), radians(arcStart[o] + 90), PIE);
  //
  //   popMatrix();
  // }



}
