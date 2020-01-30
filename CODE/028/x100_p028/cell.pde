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

    // 01 DIVIDE CELL IN HALF
    // CHOOSE ORIENTATION
    int b1 = floor(random(0, 2)); // CELL BG SHAPE
    int b2 = floor(random(0, 4)); // CELL ROTATION

    // 02 CHOOSE LAYERING ORDER OF SHAPE AND LINE
    int v1 = floor(random(0, 2));

    // 02 ADD TOP SHAPE
    // OPTIONS: SQUARE, RECT, TRIANGLER
    float s1 = random(0, 1); // DISPLAY ID
    int s2 = floor(random(0, 4)); // SHAPE ID
    int s3 = floor(random(0, 4)); // ROTATION ID

    // CHOOSE LINE ORIENTATION
    float l1 = random(0, 1);  // LINE DISPLAY ID
    int l2 = floor(random(0, 4)); // ROTATION ID

    // COLOR SELECTORS
    int c1, c2, c3;
    do {
      c1 = floor(random(0, shapeColors.length));
      c2 = floor(random(0, shapeColors.length));
      c3 = floor(random(0, shapeColors.length));
    } while (c1 == c2 || c2 == c3 || c1 == c3);

    // DRAW
    render(b1, b2, v1, s1, s2, s3, l1, l2, c1, c2, c3);
  }

  // DRAW CELL
  void render(int b1, int b2, int v1, float s1, int s2, int s3, float l1, int l2, int c1, int c2, int c3) {

    // BEGIN DRAWING
    pushMatrix();

    // ORIENT AT CENTER
    translate(x+w/2, y+h/2);

    // GLOBAL DRAWING SETTINGS
    strokeWeight(3);

    // SKETCH VARIABLES;
    boolean drawBG = false; // draw containing cell (good for debugging)

    // THRESHOLDS
    float t1 = 0.8; // DISPLAY THRESHOLD
    float t2 = 0.75; // STYLE THRESHOLD


    // DRAW BG SHAPE
    bgShape(b1, b2, c1);

    // DRAW TOP LAYERS
    if (v1 == 0) {
      drawShape(s1, s2, s3, c2);
      drawLine(l1, l2, c3);
    } else {
      drawLine(l1, l2, c3);
      drawShape(s1, s2, s3, c2);
    }

    // END DRAWING
    popMatrix();
  }

  // DRAW BG
  void bgShape(int b1, int b2, int c1) {

    pushMatrix();

    // SET  COLOR
    float ss = random(0, 1);
    stroke(shapeColors[c1]);
    if (ss > 0.55) {
      fill(shapeColors[c1]);
    } else {
      noFill();
    }


    // DRAW BACKGROUND SHAPES
    rotate(radians(90 * b2));
    if (b1 == 0) {
      rect(-w/2, -h/2, w, h/2);
    } else {
      triangle(-w/2, -h/2, w/2, -h/2, w/2, h/2);
    }

    popMatrix();
  }

  void drawShape(float s1, int s2, int s3, int c2) {
    pushMatrix();

    // SET  COLOR
    float ss = random(0, 1);
    stroke(shapeColors[c2]);
    if (ss > 0.25) {
      fill(shapeColors[c2]);
    } else {
      noFill();
    }

    if (s1 < 0.75) {
      rotate(radians(s3 * 90));
      if (s2 == 0) {
        rect(-w/2, -h/2, w/2, h/2);
      } else if (s2 == 1) {
        rect(-w/2, -h/2, w, h/2);
      } else if (s2 == 2) {
        triangle(0, 0, -w/2, -h/2, w/2, -h/2);
      } else {
        triangle(-w/2, -h/2, 0, -h/2, -w/2, 0);
      }
    }



    popMatrix();
  }


  // DRAW LINE OVERLAY
  void drawLine(float l1, int l2, int c3) {
    pushMatrix();
    stroke(shapeColors[c3]);

    // SET Y POS BASED ON ROTATION VALUE
    float ly1, ly2;
    if (l2 < 2) {
      ly1 = 0;
      ly2 = 0;
    } else {
      ly1 = -h/2;
      ly2 = h/2;
    }

    // DRAW AND ROTATE LINE
    if (l1 < 0.75) {
      rotate(radians(l2 * 90));
      line(-w/2, ly1, w/2, ly2);
    }

    popMatrix();
  }

}
