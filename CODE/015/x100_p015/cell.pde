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

    // GENERATE SHAPE ID
    // OPTIONS: RECT, ELLIPSE, TRIANGE
    int c1 = floor(random(0, 3));

    // GENERATE SIZE/QUANTITY ID
    // OPTIONS: FULL, HALF, QUARTER
    int c2 = floor(random(0, 3));

    // GENERATE POSITION (FOR HALF AND QUARTER ONLY)
    // OPTIONS TOP/TOP-LEFT, RIGHT/TOP-RIGHT, BOTTOM/BOTTOM-LEFT, LEFT/BOTTOM-LEFT
    int c3 = floor(random(0, 4));

    // GENERATE POSITION 2 (FOR QUARTER ONLY)
    int c4;
    do {
      c4 = floor(random(0, 4));
    } while (c3 == c4);

    // GENERATE COLOR
    // 2 COLORS IN THE CASE OF QUARTER SHAPES
    int c5, c6;
    do {
      c5 = floor(random(0, shapeColors.length));
      c6 = floor(random(0, shapeColors.length));
    } while (c5 == c6);

    // CREATE SHAPE
    render(c1, c2, c3, c4, c5, c6);

  }

  // DRAW CELL
  void render(int c1, int c2, int c3, int c4, int c5, int c6) {

    // BEGIN DRAWING
    pushMatrix();

    // BACKGROUND TRIANGLE FOR DEBUGGING
    // fill(25);
    // rect(0, 0, w, h);

    // SET FILL AND STROKE STYLE
    // FULL SCALE SHAPES HAVE 25% CHANCE OF FILL
    // HALF SCALE SHAPES HAVE 50% CHANCE OF FILL
    int s = floor(random(0, 4));
    if (c2 == 0 && s > 2 || c2 == 1 && s < 3 || c2 == 2) {
      fill(shapeColors[c5]);
      noStroke();
    } else {
      noFill();

    }
    stroke(shapeColors[c5]);
    strokeWeight(2);


    // RECTANGLES
    if (c1 == 0) {
      drawRectangle(c2, c3, c4, c5, c6);
    }

    // ELLIPSES
    if (c1 == 1) {
      drawEllipses(c2, c3, c4, c5, c6);
    }

    // TRIANGLES
    if (c1 == 2) {
      drawTriangles(c2, c3, c4, c5, c6);
    }

    // END DRAWING
    popMatrix();
  }

  // DRAW THE RECTANGLER SHAPE
  void drawRectangle(int c2, int c3, int c4, int c5, int c6) {

    // ORIENT AT CELL CORNER
    translate(x, y);

    // DRAW FULL OR HALF SHAPES
    if (c2 == 0 || c2 == 1) {

      // FULL
      if (c2 == 0) {
        rect(0, 0, w, h);
      }

      if (c2 == 1) {
        // RECT POSITION AND SIZE ARRAYS
        float rX[] = { 0, w/2, 0, 0 };
        float rY[] = { 0, 0, h/2, 0 };
        float rW[] = { w, w/2, w, w/2 };
        float rH[] = { h/2, h, h/2, h };

        rect(rX[c3], rY[c3], rW[c3], rH[c3]);
      }
    }

    // QUARTER RECTS
    if (c2 == 2) {

      // RECT POS AND SIZE ARRAYS
      float rX[] = { 0, w/2, w/2, 0 };
      float rY[] = { 0, 0, h/2, h/2 };

      // RECT 1
      rect(rX[c3], rY[c3], w/2, h/2);

      // RECT 2
      stroke(shapeColors[c6]);
      fill(shapeColors[c6]);
      rect(rX[c4], rY[c4], w/2, h/2);
    }
  }

  // DRAW THE ELLIPSE SHAPE
  void drawEllipses(int c2, int c3, int c4, int c5, int c6) {

    // ORIENT AT CELL CENTER
    translate(x + w/2, y + h/2);

    // DRAW FULL OR HALF SHAPES
    if (c2 == 0 || c2 == 1) {

      // FULL
      if (c2 == 0) {
        ellipse(0, 0, w, h);
      }

      if (c2 == 1) {
        // ARC POSITION AND SIZE ARRAYS
        float hStart[] = { 0, 90, 180, 270 };
        float hStop[] = { 180, 270, 360, 450 };
        float aX[] = { 0, w/2, 0, -w/2 };
        float aY[] = { -h/2, 0, h/2, 0 };

        arc(aX[c3], aY[c3], w, h, radians(hStart[c3]), radians(hStop[c3]), CHORD);
      }
    }

    // QUARTER ARCS
    if (c2 == 2) {

      // ARC POSITION AND SIZE ARRAYS
      float hStart[] = { 0, 90, 180, 270 };
      float hStop[] = { 90, 180, 270, 360 };
      float aX[] = { -w/2, w/2, w/2, -w/2 };
      float aY[] = { -h/2, -h/2, h/2, h/2 };

      // ARC 1
      arc(aX[c3], aY[c3], w, h, radians(hStart[c3]), radians(hStop[c3]), PIE);

      // ARC 2
      stroke(shapeColors[c6]);
      fill(shapeColors[c6]);
      arc(aX[c4], aY[c4], w, h, radians(hStart[c4]), radians(hStop[c4]), PIE);
    }
  }

  // DRAW THE ELLIPSE SHAPE
  void drawTriangles(int c2, int c3, int c4, int c5, int c6) {

    // ORIENT AT CELL CENTER
    translate(x + w/2, y + h/2);

    // DRAW FULL OR HALF SHAPES
    if (c2 == 0 || c2 == 1) {

      // RANDOMLY ROTATE TRIANGLE
      int r = floor(random(0, 4));
      rotate(radians(90 * r));

      // FULL
      if (c2 == 0) {
        triangle(-w/2, -h/2, w/2, -h/2, -w/2, h/2);
      }

      // HALF TRIANGLE
      if (c2 == 1) {
        triangle(-w/2, -h/2, w/2, -h/2, -w/2, 0);
      }
    }

    // QUARTER TRIANGLES
    if (c2 == 2) {

      // ROTATION VALUES
      float r[] = { 0, 1, 2, 3 };

      // TRIANGLE 1
      pushMatrix();
      rotate(radians(r[c3] * 90));
      triangle(-w/2, -h/2, 0, -h/2, -w/2, 0);
      popMatrix();

      // TRIANGLE 2
      pushMatrix();
      stroke(shapeColors[c6]);
      fill(shapeColors[c6]);
      rotate(radians(r[c4] * 90));
      triangle(-w/2, -h/2, 0, -h/2, -w/2, 0);
      popMatrix();
    }
  }
}
