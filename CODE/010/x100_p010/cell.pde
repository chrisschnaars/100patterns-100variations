class Cell {

  float x, y;
  float w, h;

  Cell(float _x, float _y) {
    x = _x;
    y = _y;
    w = cellW;
    h = cellH;
  }

  // CONFIGURE CELL PROPERTIES
  void configure() {

    // GENERATE SHAPE ID
    // CHANGE LOWER LIMIT TO 0 FOR A BLANK OPTION
    int c1 = floor(random(1, 6));

    // GENERATE RANDOM SHAPE COLOR ID
    int c2 = floor(random(0, colors.length));

    // CREATE SHAPE
    render(c1, c2);
  }

  // DRAW CELL
  void render(int c1, int c2) {

    // BEGIN DRAWING
    pushMatrix();

    // ORIENT AT TOP LEFT
    translate(x,y);

    // GLOBAL CELL SETTINGS
    noFill();
    strokeWeight(8);
    strokeCap(ROUND);
    ellipseMode(CENTER);

    // // DRAW CELL BACKGROUND
    // fill(bgColor);
    // rect(0, 0, w, h);

    // FIND THE OFFSET NEEDED FOR DIAGANOL TO BE SAME SIZE AS HORIZ/VERT
    float dOff = calcC(w);

    // SET COLOR
    stroke(colors[c2]);

    // VERTICAL
    if (c1 == 1) {
      line(w/2, 0, w/2, h);
    }

    // HORIZONTAL
    if (c1 == 2) {
      line(0, h/2, w, h/2);
    }

    // 45º ANGLE (left to right)
    if (c1 == 3) {
      line(dOff, dOff, w-dOff, h-dOff);
    }

    // 45º ANGLE (right to left)
    if (c1 == 4) {
      line(dOff, h-dOff, w-dOff, dOff);
    }

    if (c1 == 5) {
      ellipse(w/2, h/2, w/2, h/2);
    }

    // END DRAWING
    popMatrix();
  }

  float calcC(float s) {
    // CALCULATE LENGTH OF A AND B SIDES TO GET HYPOT = W
    float cLSq = sq(s);  // C2
    float a = sqrt(cLSq/2); // a2 + b2 = c2

    // FIND OFFSET NEEDED TO DRAW LINE
    float offset = (s - a) / 2;

    // RETURN OFFSET
    return offset;
  }
}
