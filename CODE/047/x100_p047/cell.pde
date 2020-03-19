class Cell {

  float x, y; // x and y position of cell
  float w, h; // width and height of cell
  int cId, rId; // column and row ids
  int localMagicLine;

  Cell(float _x, float _y, int _cId, int _rId, int _localMagicLine) {
    x = _x;
    y = _y;
    w = cellW;
    h = cellH;
    cId = _cId;
    rId = _rId;
    localMagicLine = _localMagicLine;
  }

  // Configure Cell
  void configure() {
    // Shape Rotation
    int r1 = floor(random(0, 4));

    // Colors
    int c1, c2, c3;
    do {
      c1 = floor(random(0, shapeColors.length));
      c2 = floor(random(0, shapeColors.length));
      c3 = floor(random(0, shapeColors.length));
    } while (c1 == c2 || c1 == c3 || c2 == c3);

    render(r1, c1, c2, c3);
  }

  // DRAW CELL
  void render(int r1, int c1, int c2, int c3) {
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

    // Drawing Settings
    noFill();
    strokeWeight(3);
    rotate(radians(r1 * 90));

    // Draw Arc if Local and Global Magic Lines are Same
    if (localMagicLine == globalMagicLine) {
      noFill();
      stroke(shapeColors[c3]);
      arc(0, 0, w, h, radians(270), radians(450), CHORD);
    }

    // Draw Lines
    int centerLine = floor(numLines/2);
    float lineSpacer = h / (numLines - 1);

    for (int i = 0; i < numLines; i++) {
      // Calculate y position of line
      float yPos = -h/2 + (i * lineSpacer);

      if (i == localMagicLine) {
        stroke(shapeColors[c2]);
        line(-w/2, yPos, w/2, yPos);
        if (i < centerLine) {
          line(w/2, yPos, w/2, -h/2);
        } else if (i >= centerLine + 1) {
          line(w/2, yPos, w/2, h/2);
        }
      } else {
        stroke(shapeColors[c1]);
        line(-w/2, yPos, 0, yPos);
      }

    };


    // END DRAWING
    popMatrix();
  }
}
