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
    float lineDisplay = random(0, 1);
    int bgDisplay = floor(random(0, 10));

    // LINE ORIENTATION SELECTORS
    // OPTIONS: VERTICAL, HORIZONTAL, DIAGONAL LTR, DIAGONAL RTL
    int lineO = floor(random(0, 2));

    // COLOR SELECTORS
    int c1, c2;
    do {
      c1 = floor(random(0, shapeColors.length));
      c2 = floor(random(0, shapeColors.length));
    } while (c1 == c2);

    // DRAW
    render(lineDisplay, bgDisplay, lineO, c1, c2);
  }

  // DRAW CELL
  void render(float lineDisplay, int bgDisplay, int lineO, int c1, int c2) {

    // BEGIN DRAWING
    pushMatrix();

    // ORIENT AT TOP LEFT
    translate(x,y);

    // GLOBAL DRAWING SETTINGS
    strokeWeight(4);
    noFill();

    // SKETCH VARIABLES;
    boolean drawBG = false; // draw containing cell (good for debugging)
    int bgThreshold = 8; // bg has to be less than to display
    float t1 = 0.9; // line has to be less than to display

    // BACKGROUND CELL BORDER FOR DEBUGGING
    if (drawBG) {
      noFill();
      stroke(255);
      rect(0, 0, w, h);
    }

    /**** BG RECTANGLE ****/

    // DRAW RECTANGLE
    // if (bgDisplay > bgThreshold) {
    //   noStroke();
    //   fill(shapeColors[c2]);
    //   rect(0, 0, w, h);
    // }

    // GLOBAL LINE SETTINGS
    int numLines = 8;
    float linesPerSide = numLines / 2;
    float lineSpacer = w / (linesPerSide);


    // DRAW LINES
    if (lineDisplay < t1) {

      // SET LINES STROKE
      noFill();
      stroke(shapeColors[c1]);

      // DIAGONAL LINES
      if (lineO == 0 || lineO == 1) {

        // LINE POINT VARIABLES
        float px1 = 0;
        float px2 = 0;
        float py1 = 0;
        float py2 = 0;

        // DRAW LINE
        for (int i = 0; i < numLines; i++) {

          // VARIABLE TO COUNT SECOND SIDE OF LINES
          float ix = i - (linesPerSide);

          // DIAGONAL LTR
          if (lineO == 0) {
            // MATCH POINTS BASED ON SIDE
            if (i < linesPerSide) {
              px1 = 0;
              py1 = h - (lineSpacer/2) - (i * lineSpacer);
              px2 = (lineSpacer / 2) + (i * lineSpacer);
              py2 = h;
            } else {

              px1 = (lineSpacer / 2) + (ix * lineSpacer);
              py1 = 0;
              px2 = w;
              py2 = (h - lineSpacer/2) - (ix * lineSpacer);
            }
          } else {
            // MATCH POINTS BASED ON SIDE
            if (i < linesPerSide) {
              px1 = 0;
              py1 = (lineSpacer/2) + (i * lineSpacer);
              px2 = (lineSpacer/2) + (i * lineSpacer);
              py2 = 0;
            } else {
              px1 = (lineSpacer / 2) + (ix * lineSpacer);
              py1 = h;
              px2 = w;
              py2 = (lineSpacer / 2) + (ix * lineSpacer);
            }
          }

          // DRAW LINE
          line(px1, py1, px2, py2);
        }
      }
    } else {
      // DRAW BACKGROUND RECTANGLE
      stroke(shapeColors[c2]);
      rect(0, 0, w, h);
    }

    // END DRAWING
    popMatrix();
  }
}
