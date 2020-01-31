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
    int s1 = floor(random(0, 4));

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
    translate(x + w/2, y + h/2);

    // SETTINGS
    strokeWeight(4);

    // BACKGROUND CELL BORDER FOR DEBUGGING
    boolean drawBG = false;
    if (drawBG) {
      noFill();
      stroke(255);
      rect(x, y, w, h);
    }

    noFill();
    stroke(shapeColors[c1]);
    rotate(radians(r1 * 90));

    if (s1 == 0) {
      stroke(shapeColors[c2]);
      line(-w/2, 0, w/2, 0);
      stroke(shapeColors[c1]);
      arc(0, -w/2, w, h*2, radians(0), radians(180), PIE);
    } else if (s1 == 1) {
      arc(-w/4, -w/2, w/2, h*2, radians(0), radians(180), PIE);
      arc(w/4, -w/2, w/2, h*2, radians(0), radians(180), PIE);
    } else if (s1 == 2) {
      stroke(shapeColors[c2]);
      ellipse(0, 0, w/2, h/2);
      stroke(shapeColors[c1]);
      bezier(-w/2, -h/2, -w/2, h/2, 0, h/2, 0, -h/2);
      bezier(0, h/2, 0, -h/2, w/2, -h/2, w/2, h/2);
    } else if (s1 == 3) {
      fill(shapeColors[c1]);
      arc(-w/2, -h/2, w*2, h*2, radians(0), radians(90), PIE);
      // noFill();
      // stroke(shapeColors[c2]);
      // line(-w/2, -h/2, w/2, h/2);
    }

    // END DRAWING
    popMatrix();
  }
}
