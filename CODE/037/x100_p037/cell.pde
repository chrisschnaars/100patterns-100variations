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
    int o1 = floor(random(0, 4)); // LINES ORIENTATION
    int o2 = floor(random(0, 4)); // SHAPE ORIENTATION
    int s1 = floor(random(0, 2)); // SHAPE TYPE

    // COLORS
    int c1, c2;
    do {
      c1 = floor(random(0, shapeColors.length));
      c2 = floor(random(0, shapeColors.length));
    } while (c1 == c2);

    // DRAW
    render(d1, d2, o1, o2, s1, c1, c2);
  }

  // DRAW CELL
  void render(float d1, float d2, int o1, int o2, int s1, int c1, int c2) {
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
    noStroke();
    float t1 = 0.85; // SHAPE THRESHOLD
    float t2 = 0.85; // LINE THRESHOLD

    // DRAW SHAPE
    if (d1 < t1) {
      if (s1 == 0) {
        drawArc(o2, c2);
      } else {
        drawAngle(o2, c2);
      }
    }

    //  DRAW HALF LINES
    if (d2 < t2) {
      drawHalfLines(o1, c1);
    }

    // END DRAWING
    popMatrix();
  }

  void drawArc(int o, int c) {
    pushMatrix();

    // DECIDE DIRECTION
    float d = random(0, 1);

    // ARC SETTINGS
    float subW = w * 5/7;
    rotate(radians(o * 90));

    // DRAW ARC
    if (d < 0.5) {
      fill(shapeColors[c]);
      arc(0, h/2, w, h, radians(180), radians(360));
      fill(bgColor);
      arc(0, h/2, subW, subW, radians(180), radians(360));
    } else {
      fill(shapeColors[c]);
      arc(0, 0, w, h, radians(0), radians(180));
      fill(bgColor);
      arc(0, 0, subW, subW, radians(0), radians(180));
    }
    popMatrix();
  }

  void drawAngle(int o, int c) {
    pushMatrix();

    // DECIDE DIRECTION
    float d = random(0, 1);

    // ANGLE SETTINGS
    rotate(radians(o * 90));
    float seg = w/6.65;
    float subW = w * 5/7;

    // DRAW ANGLE
    fill(shapeColors[c]);
    arc(-w/2, h/2, w, h, radians(270), radians(360));
    fill(bgColor);
    arc(-w/2, h/2, subW, subW, radians(270), radians(360));

    popMatrix();
  }

  void drawHalfLines(int o, int c) {
    pushMatrix();

    // SET NUMBER OF VISIBLE HALF LINES
    int numLines = 7;
    float lineW = w / numLines;

    // CHOOSE WHETHER TO STAGGER
    float stagger = random(0, 1);

    // DRAW LINES
    rotate(radians(o * 90));

    for (int i=0; i<numLines; i++) {
      fill(shapeColors[c]);
      // SET STAGGER FILL
      if ((stagger < 0.75 && i % 2 == 1) || (stagger >= 0.75 && i % 2 == 0)) {
        float x = (-w/2) + (i * lineW);
        float y = -h/2;
        rect(x, y, lineW, h/2);
      }
    }
    popMatrix();
  }
}
