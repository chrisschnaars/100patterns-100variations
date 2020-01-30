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

    // GENERATE PROBABILITY
    // 1 IN 10 THAT CELL WILL BE BLANK
    float c0 = random(0, 10);

    // GENERATE ELLIPSE SIZE ID
    // OPTIONS: SMALL, MEDIUM, LARGE
    int c1 = floor(random(0, 3));

    // GENERATE ELLIPSE COLOR
    int c2 = floor(random(0, shapeColors.length-1));

    // GENERATE ELLIPSE COLOR MODE
    // OPTIONS: FILL OR STROKE
    int c5 = floor(random(0, 2));

    // GENERATE LINE SEGMENT CONFIGURATION
    // OPTIONS: VERTICAL, HORIZONTAL, 90 DEG ANGLE EACH ROTATION
    int c3 = floor(random(0, 6));

    // GENERATE LINE COLOR
    int c4 = floor(random(0, shapeColors.length-1));

    // CREATE SHAPE
    if (c0 >= 1) {
      render(c1, c2, c3, c4, c5);
    }

  }

  // DRAW CELL
  void render(int c1, int c2, int c3, int c4, int c5) {

    // BEGIN DRAWING
    pushMatrix();

    // ORIENT AT CENTER
    translate(x+w/2,y+h/2);

    // GLOBAL CELL SETTINGS
    strokeWeight(6);

    /*
    1. DRAW LINE
    */

    // LINE SETTINGS
    noFill();
    stroke(shapeColors[c4]);

    // LINE VARIABLES
    float xE = -w/2;
    float xW = w/2;
    float yN = -h/2;
    float yS = h/2;

    // HORIZONTAL LINE
    if (c3 == 0) {
      line(xE, 0, xW, 0);
    }

    if (c3 == 1) {
      line(0, yN, 0, yS);
    }

    if (c3 == 2) {
      line(xE, 0, 0, 0);
      line(0, yN, 0, 0);
    }

    if (c3 == 3) {
      line(0, 0, xW, 0);
      line(0, yN, 0, 0);
    }

    if (c3 == 4) {
      line(0, 0, xW, 0);
      line(0, 0, 0, yS);
    }

    if (c3 == 5) {
      line(xE, 0, 0, 0);
      line(0, 0, 0, yS);
    }

    /*
    2. DRAW ELLIPSE
    */

    // ELLIPSE SIZE
    float eScale[] = { 0.15, 0.25, 0.35 };

    // DRAW ELLIPSE
    if (c5 == 0) {
      stroke(shapeColors[c2]);
      fill(shapeColors[c2]);
    } else {
      stroke(shapeColors[c2]);
      fill(bgColor);
    }

    ellipse(0, 0, w * eScale[c1], w * eScale[c1]);

    // END DRAWING
    popMatrix();
  }

}
