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

    // SHAPE DISPLAY IDS
    int l1 = floor(random(0, 2)); // LAYERING ORDER
    int o1 = floor(random(0, 4)); // ORIENTATIONS

    // COLORS
    int c1 = floor(random(0, shapeColors.length));

    // DRAW
    render(l1, o1, c1);
  }

  // DRAW CELL
  void render(int l1, int o1, int c1) {

    // BEGIN DRAWING
    pushMatrix();

    // DISPLAY VARIABLES
    boolean drawBG = false; // draw containing cell (good for debugging)

    // ORIENT AT CENTER
    translate(x + w/2, y + h/2);

    // BACKGROUND CELL BORDER FOR DEBUGGING
    if (drawBG) {
      noFill();
      stroke(255);
      rect(0, 0, w, h);
    }

    // SET COLORS
    noStroke();

    int f1, f2;
    if (l1 == 0) {
      f1 = shapeColors[c1];
      f2 = bgColor;
    } else {
      f1 = bgColor;
      f2 = shapeColors[c1];
    }

    // DRAW ARC
    fill(f1);
    rect(-w/2, -h/2, w, h);


    float t = random(0, 1);
    if (t < 0.2) {
      strokeWeight(3);
      stroke(f2);
      fill(f1);
    } else {
      noStroke();
      fill(f2);
    }

    rotate(radians(o1 * 90));
    arc(-w/2, -h/2, w*2, h*2, radians(0), radians(90));

    // END DRAWING
    popMatrix();
  }
}
