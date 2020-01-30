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
    // OPTIONS: 1 CELL OR 4 SUB-CELLS
    int cellScale = floor(random(0, 2));

    // DRAW
    render(cellScale);
  }

  // DRAW CELL
  void render(int cellScale) {

    // BEGIN DRAWING
    pushMatrix();

    // ORIENT AT TOP LEFT
    translate(x,y);
    rectMode(CORNER);

    // GLOBAL DRAWING SETTINGS
    strokeWeight(2);

    // THRESHOLDS
    float t1 = 0.5; // SHAPE STYLE THRESHOLD
    float t2 = 0.95; // SHAPE DISPLAY THRESHOLD
    float t3 = 0.4; // LINE DISPLAY THRESHOLD

    // SKETCH VARIABLES;
    boolean drawBG = false; // draw containing cell (good for debugging)

    // SUB CELL GRID VARIABLES
    float subXCount = 1;
    float subYCount = 1;
    float subW = w;
    float subH = h;

    if (cellScale > 0) {
      subXCount = 2;
      subYCount = 2;
      subW = w/2;
      subH = h/2;
    }

    // BACKGROUND CELL BORDER FOR DEBUGGING
    if (drawBG) {
      noFill();
      stroke(255);
      rect(0, 0, w, h);
    }

    // SUB CELL DRAW
    for (int i=0; i<subXCount; i++) {
      for (int j=0; j<subYCount; j++) {

        // X AND Y POSITIONS OF SUB CELL CENTER POINT
        float subX = (subW/2) + (i * subW);
        float subY = (subH/2) + (j * subH);

        // COLOR SELECTORS
        int c1, c2;
        do {
          c1 = floor(random(0, shapeColors.length));
          c2 = floor(random(0, shapeColors.length));
        } while (c1 == c2);

        // SHAPE COLOR STYLE
        // OPTIONS: FILL OR STROKE
        float s1 = random(0, 1);
        if (s1 < t1) {
          noStroke();
          fill(shapeColors[c1]);
        } else {
          stroke(shapeColors[c1]);
          noFill();
        }


        /*** DRAW BACKGROUND SHAPE ***/

        // DETERMINE DISPLAY DECIDER
        float shapeDisplay = random(0, 1);

        // SELECT AND DRAW SHAPE
        if (shapeDisplay < t2) {
          // OPTIONS: TRIANGLE, ELLIPSE, RECTANGE, QUARTER ARC
          int shapeDecider = floor(random(0, 4));

          // DRAW TRIANGLE
          if (shapeDecider == 0) {
            drawTriangle(subX, subY, subW, subH);
          }

          // DRAW ELLIPSE
          if (shapeDecider == 1) {
            drawEllipse(subX, subY, subW, subH);
          }

          // DRAW RECTANGLE
          if (shapeDecider == 2) {
            drawRectangle(subX, subY, subW, subH);
          }

          // DRAW QUARTER ARC
          if (shapeDecider == 3) {
            drawQuarterArc(subX, subY, subW, subH);
          }
        }


        /*** DRAW LINE ***/

        // DETERMINE DISPLAY DECIDER
        float lineDisplay = random(0, 1);

        // SELECT AND DRAW LINE
        if (lineDisplay < t3) {
          // TYPE: FULL OR PARTIAL (ONLY FOR FULL SCALE SHAPES)
          // ORIENTATION: EACH CORNER (4), EACH PLANE (4)
          int lineType = 0;
          if (cellScale == 0) {
            lineType = floor(random(0, 2));
          }

          // FULL LINE
          if (lineType == 0) {
            drawFullLine(subX, subY, subW, subH, c2);
          }

          // HALF LINE
          if (lineType == 1) {
            drawHalfLine(subX, subY, subW, subH, c2);
          }
        }
      }
    }

    // END DRAWING
    popMatrix();
  }

  // DRAW QUARTER ARC
  void drawTriangle(float triX, float triY, float triW, float triH) {
    pushMatrix();

    // ORIENT AT SUBCELL CENTER
    translate(triX, triY);

    // GENERATE RANDOM TRIANGLE ORIENTATION
    int tO = floor(random(0, 4));

    // SET TRIANGLE VERTEX SIZE
    float t = triW / 2;

    // DRAW SINGLE TRIANGLE
    rotate(radians(tO * 90));
    triangle(-t, -t, t, t, -t, t);

    popMatrix();
  }

  // DRAW ELLIPSE
  void drawEllipse(float eX, float eY, float eW, float eH) {
    pushMatrix();

    // DRAW SINGLE TRIANGLE
    ellipse(eX, eY, eW, eH);

    popMatrix();
  }

  // DRAW REGTANGLE
  void drawRectangle(float eX, float eY, float eW, float eH) {
    pushMatrix();

    // DRAW SINGLE TRIANGLE
    rectMode(CENTER);
    rect(eX, eY, eW, eH);

    popMatrix();
  }

  // DRAW HALF ARC
  void drawQuarterArc(float eX, float eY, float eW, float eH) {
    pushMatrix();

    // TRANSLATE AT CORNER
    translate(eX - (eW/2), eY - (eH/2));

    // ARC POSITIONS
    float[] xpos = { 0, eW, eW, 0 };
    float[] ypos = { 0, 0, eH, eH };
    float[] arcStart = { 0, 90, 180, 270 };

    // GENERATE ARC ORIENTATION
    int o = floor(random(0, 4));

    // DRAW ARC
    arc(xpos[o], ypos[o], eW*2, eH*2, radians(arcStart[o]), radians(arcStart[o] + 90), PIE);

    popMatrix();
  }

  // DRAW A FULL LINE
  void drawFullLine(float eX, float eY, float eW, float eH, int col) {
    pushMatrix();
    translate(eX, eY);

    // GENERATE RANDOM ORIENTATION
    int lineSpan = floor(random(0, 1));
    int lO = floor(random(0, 4)); // RANDOM ORIENTATION

    // COLOR SETUP
    stroke(shapeColors[col]);

    // LINE SEGMENT MEASUREMENT
    float l = eW / 2;

    // DRAW LINES
    if (lineSpan < 1) {
      rotate(radians(lO * 90));
      line(0, -l, 0, l);
    } else {
      rotate(radians(lO * 90));
      line(-l, -l, l, l);
    }

    popMatrix();
  }

  void drawHalfLine(float eX, float eY, float eW, float eH, int col) {
    pushMatrix();
    translate(eX, eY);

    // GENERATE RANDOM ORIENTATION
    int lineSpan = floor(random(0, 2));
    int lO = floor(random(0, 4));

    // COLOR SETUP
    strokeWeight(4);
    stroke(shapeColors[col]);

    // LINE SEGMENT MEASUREMENT
    float l = eW / 2;

    // DRAW LINES
    if (lineSpan < 1) {
      rotate(radians(lO * 90));
      line(0, 0, 0, -l);
    } else {
      rotate(radians(lO * 90));
      line(0, 0, -l, -l);
    }

    popMatrix();
  }


}
