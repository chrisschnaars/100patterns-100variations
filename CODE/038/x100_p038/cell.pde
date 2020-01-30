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

    // DISPLAY SETTINGS
    float d1 = random(0, 1);
    float d2 = random(0, 1);

    // SHAPE SETTINGS
    int o1 = floor(random(0, 5)); // Square Configuration
    int o2 = floor(random(0, 2)); // SHAPE ORIENTATION

    // COLORS
    int c1, c2;
    do {
      c1 = floor(random(0, shapeColors.length));
      c2 = floor(random(0, shapeColors.length));
    } while (c1 == c2);

    // DRAW
    render(d1, d2, o1, o2, c1, c2);
  }

  // DRAW CELL
  void render(float d1, float d2, int o1, int o2, int c1, int c2) {
    // BEGIN DRAWING
    pushMatrix();

    // BACKGROUND CELL BORDER FOR DEBUGGING
    boolean drawBG = false;
    if (drawBG) {
      noFill();
      stroke(255);
      rect(x, y, w, h);
    }

    // DRAWING SETTINGS
    translate(x + w/2, y + h/2);
    strokeWeight(4);
    float t1 = 0.85; // SHAPE THRESHOLD
    float t2 = 0.35; // LINE THRESHOLD

    // DRAW SQUARE CONFIGURATION
    if (d1 < t1) {
      drawSquares(o1, c1);
      drawDots(c1);
    }

    if (d2 < t2) {
      drawEllipses(o2, c2);
    }

    // END DRAWING
    popMatrix();
  }

  void drawSquares(int config, int col) {
    pushMatrix();

    // Set Rotation Value
    int r = floor(random(0, 4));
    rotate(radians(r * 90));

    // Draw Settings
    noFill();
    stroke(shapeColors[col]);
    int eD = 4;

    // Full Rect
    if (config == 0) {
      rect(-w/2, -h/2, w, h);
    }

    if (config == 1) {
      beginShape();
      vertex(-w/2, -h/2);
      vertex(w/2, -h/2);
      vertex(w/2, 0);
      vertex(0, 0);
      vertex(0, h/2);
      vertex(-w/2, h/2);
      endShape(CLOSE);
    }

    if (config == 2) {
      rect(-w/2, -h/2, w/2, h/2);
      rect(0, 0, w/2, h/2);
    }

    if (config == 3) {
      rect(-w/2, -h/2, w, h/2);
    }

    if (config == 4) {
      rect(-w/2,-h/2, w/2, h/2);
    }

    popMatrix();
  }

  void drawDots(int col) {
    pushMatrix();

    int eD = 4;

    for (int i = 0; i < 4; i++) {
      float d = random(0, 1);

      if (d < 0.5) {
        rotate(radians(i * 90));
        noStroke();
        fill(shapeColors[col]);
        ellipse(-w/4, -h/4, 4, 4);
      }
    }

    popMatrix();
  }

  void drawEllipses(int type, int col) {
    pushMatrix();

    noFill();
    stroke(shapeColors[col]);

    if (type == 0) {
      ellipse(0, 0, w, h);
    } else {
      for (int i = 0; i < 4; i++) {
        float d = random(0, 1);

        if (d < 0.35) {
          rotate(radians(i * 90));
          arc(-w/2, -h/2, w, h, radians(0), radians(90));
          // ellipse(-w/4, -h/4, w/2, h/2);
        }
      }
    }

    popMatrix();
  }
}
