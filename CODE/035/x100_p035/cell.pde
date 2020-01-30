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
  }

  // CONFIGURE CELL
  void configure() {

    // SHAPE DISPLAY
    float shapeDisplay = random(0, 1);

    // SHAPE TYPE
    float t1 = random(0, 1);

    // ROTATIONS IDS
    int r = floor(random(0, 4));

    // COLOR IDS
    int c1, c2;
    do {
      c1 = floor(random(0, shapeColors.length));
      c2 = floor(random(0, shapeColors.length));
    } while (c1 == c2);

    // DRAW
    render(shapeDisplay, t1, r, c1, c2);
  }

  // DRAW CELL
  void render(float shapeDisplay, float t1, int r, int c1, int c2) {

    // BEGIN DRAWING
    pushMatrix();

    // SETTINGS
    translate(x, y);
    strokeWeight(3);

    // DISPLAY VARIABLES
    float displayThreshold = 0.78;
    float shapeTypeThreshold1 = 0.7;
    float shapeTypeThreshold2 = 0.9;

    // BACKGROUND CELL BORDER FOR DEBUGGING
    boolean drawBG = false; // draw containing cell (good for debugging)
    if (drawBG) {
      noFill();
      stroke(255);
      rect(0, 0, w, h);
    }

    // DRAW SHAPE
    if (shapeDisplay < displayThreshold) {
      if (t1 < shapeTypeThreshold1) {
        drawTriangles(c2, r);
      } else {
        drawArcs(c2, r);

        if (t1 > shapeTypeThreshold2) {
          drawEllipse(c1);
        }
      }
    }

    // DRAW DOTS
    drawDots(c1);

    popMatrix();
  }

  void drawDots(int c) {
    int numDots = 4;
    int dotSize = 7;
    float dotSpacer = w / (numDots);

    for (int i = 0; i < numDots; i++) {
      for (int j = 0; j < numDots; j++) {
        float d = random(0, 1);

        if (d < 0.45) {
          noStroke();
          fill(shapeColors[c]);
          float dotX = dotSpacer/2 + (i * dotSpacer);
          float dotY = dotSpacer/2 + (j * dotSpacer);
          ellipse(dotX, dotY, dotSize, dotSize);
        }
      }
    }
  }

  void drawEllipse(int c) {

    float eS = w * 0.55;

    noFill();
    strokeWeight(4);
    stroke(shapeColors[c]);

    ellipse(w/2, h/2, eS, eS);
  }

  void drawArcs(int c, int r) {

    int numArcs = 2;
    float aH = h / numArcs;

    for (int i = 0; i < numArcs; i++) {
      pushMatrix();
      translate(w/2, h/2);
      noStroke();
      fill(shapeColors[c]);

      float yP = (-h/2) + (i * aH);

      // DRAW SHAPE
      int rT = r * 90;
      rotate(radians(rT));
      arc(0, yP, w, h, radians(0), radians(180));

      popMatrix();
    }
  }

  void drawTriangles(int c, int r) {

    // TRIANGLE SETTINGS
    int numTriangles = 3;
    float tW = w/numTriangles;
    float tH = h/2;

    for (int i = 0; i < numTriangles; i++) {
      pushMatrix();
      translate(w/2, h/2);
      noStroke();
      fill(shapeColors[c]);

      float x1 = (-w/2) + (i * tW);
      float x2 = x1 + tW;

      int rT = r * 90;
      rotate(radians(rT));
      triangle(x1, -tH, x2, -tH, x2, tH);

      popMatrix();
    }
  }
}
