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

    // Shape Type
    // Options: arcs or ellipse
    float s1 = random(0, 1);

    // Shape Rotation
    int r1 = floor(random(0, 4));

    // Inner Arc Orientation
    float ort = random(0, 1);

    // Colors
    int c1, c2;
    do {
      c1 = floor(random(0, shapeColors.length));
      c2 = floor(random(0, shapeColors.length));
    } while (c1 == c2);

    render(d1, s1, r1, ort, c1, c2);
  }

  // DRAW CELL
  void render(float d1, float s1, int r1, float ort, int c1, int c2) {
    // BEGIN DRAWING
    pushMatrix();
    translate(x + w/2, y + h/2);

    // THRESHOLDS
    float st1 = 0.85;
    float ot1 = 0.25;
    float ot2 = 0.5;
    float ot3 = 0.75;

    // BACKGROUND CELL BORDER FOR DEBUGGING
    boolean drawBG = false;
    if (drawBG) {
      noFill();
      stroke(255);
      rect(x, y, w, h);
    }

    noStroke();
    rotate(radians(r1 * 90));

    if (s1 < st1) {
      // Draw masked background arc
      float maskArcSize = w * 1.5;
      fill(shapeColors[c1]);
      arc(-w/2, -h/2, w*2, h*2, radians(0), radians(90), PIE);
      fill(bgColor);
      arc(-w/2, -h/2, maskArcSize, maskArcSize, radians(0), radians(90), PIE);

      // Draw foreground shape
      // Determine positioning
      float xpos, ypos;
      float startR;
      float fgArcSize = w;

      if (ort < ot1) {
        xpos = -w/2;
        ypos = -h/2;
        startR = 0;
      } else if (ort >= ot1 && ort < ot2) {
        xpos = 0;
        ypos = 0;
        startR = 180;
      } else if (ort >= ot2 && ort < ot3) {
        xpos = 0;
        ypos = -h/2;
        startR = 90;
      } else {
        xpos = -w/2;
        ypos = 0;
        startR = 270;
      }

      fill(shapeColors[c2]);
      arc(xpos, ypos, fgArcSize, fgArcSize, radians(startR), radians(startR + 90), PIE);
    } else {
      fill(shapeColors[c1]);
      ellipse(0, 0, w, h);
      fill(bgColor);
      ellipse(0, 0, w/2, h/2);
    }

    // END DRAWING
    popMatrix();
  }
}
