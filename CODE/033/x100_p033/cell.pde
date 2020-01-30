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

    // SHAPE DISPLAY IDS
    float s1 = random(0, 1);
    float s2 = random(0, 1);
    float s3 = random(0, 1);

    // COLORS
    int c1, c2, c3;
    do {
      c1 = floor(random(0, shapeColors.length));
      c2 = floor(random(0, shapeColors.length));
      c3 = floor(random(0, shapeColors.length));
    } while (c1 == c2 || c1 == c3 || c2 == c3);

    // DRAW
    render(s1, s2, s3, c1, c2, c3);
  }

  // DRAW CELL
  void render(float s1, float s2, float s3, int c1, int c2, int c3) {

    // BEGIN DRAWING
    pushMatrix();

    // DISPLAY VARIABLES
    boolean drawBG = false; // draw containing cell (good for debugging)

    // ORIENT AT CENTER
    translate(x + w/2, y + h/2);

    // DISPLAY THRESHOLDS
    float t1 = 0.75;
    float t2 = 0.8;
    float t3 = 0.6;

    // BACKGROUND CELL BORDER FOR DEBUGGING
    if (drawBG) {
      noFill();
      stroke(255);
      rect(0, 0, w, h);
    }

    // DRAWING SETTINGS
    noFill();
    strokeWeight(sW);

    // DRAW BACKGROUND RECTANGLE
    if (s1 < t1) {
      drawBg(c1);
    }

    // DRAW BEZIER CURVE
    if (s2 < t2) {
      drawLine(c2);
    }

    // DRAW ELLIPSE
    if (s3 < t3) {
      drawEllipse(c3);
    }

    // drawLine(c3, t3);

    // END DRAWING
    popMatrix();
  }

  void drawBg(int c) {
    pushMatrix();

    stroke(shapeColors[c]);
    rect(-w/2, -h/2, w, h);

    popMatrix();
  }

  void drawLine(int c) {
    pushMatrix();

    // SET COLOR
    stroke(shapeColors[c]);

    // SET ROTATION
    int r = floor(random(0, 4));
    rotate(radians(r * 90));

    // DRAW LINE OR BEZIER
    float d = random(0, 1);
    if (d < 0.2) {
      line(-w/2, -h/2, w/2, h/2);
    } else {
      bezier(-w/2, -h/2, 0, -h/2, 0, h/2, w/2, h/2);
    }

    popMatrix();
  }

  void drawEllipse(int c) {
    pushMatrix();

    // SETTINGS
    stroke(shapeColors[c]);
    float aX = 0;
    float aY = -h/2;
    float aW = w;
    float aH = h;

    // SET ROTATION
    int r = floor(random(0, 4));
    rotate(radians(r * 90));

    // DRAW ARC
    arc(aX, aY, aW, aH, radians(0), radians(180));

    popMatrix();
  }
}
