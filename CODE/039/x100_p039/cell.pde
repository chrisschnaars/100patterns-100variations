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

    // Shpae Combination
    // Options: two arcs, arc + accs, arc + lines
    int s1 = floor(random(0, 3));

    // Shape Rotation
    int r1 = floor(random(0, 4));

    // Colors
    int c1, c2;
    do {
      c1 = floor(random(0, shapeColors.length));
      c2 = floor(random(0, shapeColors.length));
    } while (c1 == c2);

    render(d1, s1, r1, c1, c2);
  }

  // DRAW CELL
  void render(float d1, int s1, int r1, int c1, int c2) {
    // BEGIN DRAWING
    pushMatrix();
    translate(x, y);
    strokeWeight(2);

    // BACKGROUND CELL BORDER FOR DEBUGGING
    boolean drawBG = false;
    if (drawBG) {
      noFill();
      stroke(255);
      rect(x, y, w, h);
    }

    // Draw Shape
    if (s1 == 0) {
      drawArcs(2, c1, r1, 1);
    } else if (s1 == 1) {
      drawArcLines(c2, 0);
      drawArcs(1, c1, 0, 0);
    } else {
      drawArcs(1, c1, r1, 1);
      drawLines(c2, r1);
    }

    // END DRAWING
    popMatrix();
  }

  void drawLines(int c, int r) {
    int numLines = 3;
    float lineSpacer = (h/2) / numLines;

    for (int i = 0; i < numLines; i++) {
      pushMatrix();
      translate(w/2, h/2);
      noFill();
      stroke(shapeColors[c]);

      float yP = lineSpacer/2 + (i * lineSpacer);

      float t = 90 * r;
      rotate(radians(t));

      line(-w/2, yP, w/2, yP);

      popMatrix();
    }
  }

  void drawArcLines(int c, int r) {
    int numArcs = 3;
    float spacer = (h/2) / numArcs;

    for (int i = 0; i < numArcs; i++) {
      pushMatrix();
      translate(w/2, h/2);
      noFill();
      stroke(shapeColors[c]);

      float arcWMin = w * 0.45;
      float arcWMax = w * 1;
      // float arcSizer = (arcWMax - arcWMin) / numArcs;
      // float arcSize = arcWMin + (i * arcSizer);
      float arcSize = map(i, 0, numArcs - 1, arcWMin, arcWMax);

      float t = 90 * r;
      rotate(radians(t));

      arc(0, 0, arcSize, arcSize, radians(180), radians(360));

      popMatrix();
    }

    // pushMatrix();
    // noStroke();
    // fill(bgColor);
    //
    // rect(0, h/2, w, -0.1 * h);
    // popMatrix();
  }

  void drawArcs(int n, int c, int r, int type) {
    int numArcs = n;
    float arcH = h/2;

    for (int i = 0; i < numArcs; i++) {
      pushMatrix();
      translate(w/2, h/2);

      float style = random(0, 10);
      if (style > 5) {
        noStroke();
        fill(shapeColors[c]);
      } else {
        noFill();
        stroke(shapeColors[c]);
      }

      float yP = (-h/2 * type) + (i * arcH);

      float t = 90 * r;
      rotate(radians(t));

      arc(0, yP, w, h, radians(0), radians(180), PIE);

      popMatrix();
    }
  }
}
