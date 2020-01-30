class Cell {

  float x, y;
  float w, h;

  Cell(float _x, float _y) {
    x = _x;
    y = _y;
    w = cellW;
    h = cellH;
  }

  // CONFIGURE CELL SETTINGS
  void configure() {

    // GENERATE SHAPE ID
    int c1 = floor(random(1, 5));

    // GENERATE ORIENTATION ID
    int c2 = floor(random(0, 4));

    // GENERATE COLOR ID
    int c3 = floor(random(0, colors.length));

    // CREATE SHAPE
    render(4, c2, c3);
  }

  // DRAW CELL
  void render(int c1, int c2, int c3) {

    // START DRAWING
    pushMatrix();

    // ORIENT AT TOP LEFT CORNER
    translate(x,y);

    // DRAWING SETTINGS
    noStroke();
    fill(colors[c3]);

    // ARC START POINTS
    float[] startAngles = { 0, 90, 180, 270 };

    // // DRAW CELL BACKGROUND
    // fill(bgColor);
    // rect(0, 0, w, h);

    // SHAPE CONFIG 1: BLANK
    if (c1 == 0) { }

    // SHAPE CONFIG 2: ARC
    if (c1 == 1) {
      // NORTH FACING
      if (c2 == 0) {
        xpos = w/2;
        ypos = 0;
      }

      // EAST FACING
      if (c2 == 1) {
        xpos = w;
        ypos = h/2;
      }

      // SOUTH FACING
      if (c2 == 2) {
        xpos = w/2;
        ypos = h;
      }

      // WEST FACING
      if (c2 == 3) {
        xpos = 0;
        ypos = h/2;
      }

      // DRAW ARC
      arc(xpos, ypos, w, h, radians(startAngles[c2]), radians((startAngles[c2]+180)));
    }

    // SHAPE CONFIG 3 & 4: ARC+RECTANGLE & ELLIPSE
    if (c1 == 2 || c1 == 3) {

      // DRAW ELLIPSE NO MATTER WHAT
      ellipse(w/2, h/2, w, h);

      // DRAW ARC FOR TYPE 2
      if (c1 == 2) {
        // ARC SETTINGS
        xpos = w/2;
        ypos = h/2;

        // NORTH FACING
        if (c2 == 0) {
          rect(0, 0, w, h/2);
        }

        // EAST FACING
        if (c2 == 1) {
          rect(w/2, 0, w/2, h);
        }

        // SOUTH FACING
        if (c2 == 2) {
          rect(0, h/2, w, h/2);
        }

        // WEST FACING
        if (c2 == 3) {
          rect(0, 0, w/2, h);
        }

        // DRAW ARC
        arc(xpos, ypos, w, h, radians(startAngles[c2]), radians((startAngles[c2]+180)));
      }
    }

    // DRAW QUARTER ARC
    if (c1 == 4) {
      // NORTH FACING
      if (c2 == 0) {
        xpos = 0;
        ypos = 0;
      }

      // EAST FACING
      if (c2 == 1) {
        xpos = w;
        ypos = 0;
      }

      // SOUTH FACING
      if (c2 == 2) {
        xpos = w;
        ypos = h;
      }

      // WEST FACING
      if (c2 == 3) {
        xpos = 0;
        ypos = h;
      }

      // DRAW ARC
      arc(xpos, ypos, w*2, h*2, radians(startAngles[c2]), radians((startAngles[c2]+90)));
    }

    // END DRAWING
    popMatrix();
  }

}
