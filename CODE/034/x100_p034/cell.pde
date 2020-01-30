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

    // LINE ID
    float l1 = random(0, 1);
    float l2 = random(0, 1);
    float l3 = random(0, 1);

    // COLOR IDS
    int c1 = floor(random(0, shapeColors.length));
    int c2 = floor(random(0, shapeColors.length));
    int c3 = floor(random(0, shapeColors.length));

    // DRAW
    render(l1, l2, l3, c1, c2, c3);
  }

  // DRAW CELL
  void render(float l1, float l2, float l3, int c1, int c2, int c3) {

    // BEGIN DRAWING
    pushMatrix();

    // ORIENT AT CENTER
    translate(x + w/2, y + h/2);

    // DISPLAY VARIABLES
    boolean drawBG = false; // draw containing cell (good for debugging)

    // BACKGROUND CELL BORDER FOR DEBUGGING
    if (drawBG) {
      noFill();
      stroke(255);
      rect(-w/2, -h/2, w, h);
    }

    // GLOBAL SETTINGS
    noFill();
    strokeWeight(8);
    rotate(radians(globalR * 90));

    // SEGMENT SETTINGS
    float xS = w/2;
    float yS = h/2;

    // DISPLAY THRESHOLD
    float t1 = 0.8;
    float t2 = 0.3;

    // LINE 1
    if (l1 < t1) {
      stroke(shapeColors[c1]);
      line(-xS, yS, 0, -yS);
    }

    // LINE 2
    if (l2 < t1) {
      stroke(shapeColors[c2]);
      line(0, yS, xS, -yS);

    }

    // LINE 3
    if (l3 < t2) {
      stroke(shapeColors[c3]);

      int p = floor(random(0, 3));
      float xP[] = { -xS, 0, xS };
      line(xP[p], -yS, xP[p], yS);
    }

    // END DRAWING
    popMatrix();
  }
}
