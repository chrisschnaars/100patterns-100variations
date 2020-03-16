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

  // Configure Cell
  void configure() {
    // Display Setting
    float d1 = random(0, 1);

    // Shape Rotation
    int r1 = floor(random(0, 4));

    // Shape type IDs
    float st1 = random(0, 1); // arc or curve

    // Colors
    int c1, c2, c3;
    do {
      c1 = floor(random(0, shapeColors.length));
      c2 = floor(random(0, shapeColors.length));
      c3 = floor(random(0, shapeColors.length));
    } while (c1 == c2 || c1 == c3 || c2 == c3);

    render(d1, r1, st1, c1, c2, c3);
  }

  // DRAW CELL
  void render(float d1, int r1, float st1, int c1, int c2, int c3) {
    // BEGIN DRAWING
    pushMatrix();
    translate(x + w/2, y + h/2);

    // BACKGROUND CELL BORDER FOR DEBUGGING
    boolean drawBG = false;
    if (drawBG) {
      noFill();
      stroke(255);
      rect(-w/2, -h/2, w, h);
    }

    // Shape type threshold
    float t1 = 0.39;

    // Global Shape Settings
    strokeWeight(2);
    rotate(radians(90 * r1));

    // Draw arc in each cell
    drawArc(c1);

    if (st1 > t1) {
      drawArcMask();
      drawStarFlower(6, w/2, c2);
    }

    // END DRAWING
    popMatrix();
  }

  void drawArc(int c) {
    noStroke();
    fill(shapeColors[c]);

    arc(-w/2, -h/2, w*2, h*2, radians(0), radians(90));
  }

  void drawArcMask() {
    // Set mask arc size
    float maskArcSize = w * 1.85;

    // Draw shape
    fill(bgColor);
    arc(-w/2, -h/2, maskArcSize, maskArcSize, radians(0), radians(90), PIE);

  }

  // Draw a star flower shape
  // Assumes tranlsate to shape center
  void drawStarFlower(int sides, float w, int c) {
    pushMatrix();
    translate(-w/4, -h/4);

    noFill();
    stroke(shapeColors[c]);

    float segment = w/4;
    float rotateIncrement = 180 / sides;

    for (int i = 0; i < sides; i++) {
      rotate(radians(rotateIncrement));
      line(-segment, 0, segment, 0);
    }

    popMatrix();
  }

}
