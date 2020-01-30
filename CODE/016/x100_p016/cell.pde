class Cell {

  float x, y;
  float w, h, wQ, hQ;

  Cell(float _x, float _y) {
    x = _x;
    y = _y;
    w = cellW;
    h = cellH;
    wQ = w/2;
    hQ = h/2;
  }

  // CONFIGURE CELL
  void configure() {

    // GENERATE SHAPE ID FOR EACH QUARTER
    // OPTIONS: BLANK, RECTANGLE, TWO TRIANGLES, ONE TRIANGLE
    int c0 = floor(random(0, 4)); // top left quad
    int c1 = floor(random(0, 4)); // top right quad
    int c2 = floor(random(0, 4)); // bottom right quad
    int c3 = floor(random(0, 4)); // bottom left quad

    // GENERATE COLOR ID FOR EACH CELL BACKGROUND
    int c4 = floor(random(0, shapeColors.length));

    // DRAW SHAPE
    render(c0, c1, c2, c3, c4);


  }

  // DRAW CELL
  void render(int c0, int c1, int c2, int c3, int c4) {

    // BEGIN DRAWING
    pushMatrix();

    // ORIENT AT TOP LEFT
    translate(x,y);

    // GLOBAL CELL SETTINGS


    // BACKGROUND COLOR
    // noFill();
    // stroke(shapeColors[c4]);
    // rect(0, 0, w, h);


    // CREATE ARRAY OF SHAPE IDs
    int[] s = { c0, c1, c2, c3 };

    // ARRAY OF X AND Y POSITIONS
    float[] xpos = { 0, wQ, wQ, 0 };
    float [] ypos = { 0, 0, hQ, hQ };

    // CREATE ARRAY OF
    for (int i = 0; i < s.length; i++) {
      // RECTANGLE
      if (s[i] == 1) {
        pushMatrix();
        // GENERATE RANDOM FILL COLOR
        int f = floor(random(0, shapeColors.length));

        // GENERATE FILL PROBABILITY
        float r = random(0, 10);
        if (r > 9.0) {
          noFill();
        } else {
          fill(shapeColors[f]);
        }

        // DRAW RECTANGLE
        stroke(shapeColors[c4]);
        rect(xpos[i], ypos[i], wQ, hQ);
        popMatrix();
      }

      // TWO TRIANGLES
      if (s[i] == 2) {
        // GENERATE RANDOM FILL COLORS
        int f1 = floor(random(0, shapeColors.length));
        int f2 = floor(random(0, shapeColors.length));

        // GENERATE TRIANGLE OREINTATION
        int o = floor(random(0, 2));

        drawTri(o, xpos[i], ypos[i], f1, c4);
        drawTri(o+2, xpos[i], ypos[i], f2, c4);
      }

      // SINGLE TRIANGLE
      if (s[i] == 3) {
        // GENERATE RANDOM FILL COLORS
        int f = floor(random(0, shapeColors.length));

        // GENERATE TRIANGLE OREINTATION
        int o = floor(random(0, 4));

        // DRAW TRIANGLE
        drawTri(o, xpos[i], ypos[i], f, c4);
      }


    }

    // END DRAWING
    popMatrix();
  }

  void drawTri(int id, float x, float y, int f, int f2) {
    pushMatrix();

    // DRAWING SETTINGS
    translate(x, y);

    // DECIDE IF THERE IS A FILL
    float r = random(0, 10);
    if (r > 9) {
      noFill();
    } else {
      fill(shapeColors[f]);
    }

    // DRAW TRIANGLE
    stroke(shapeColors[f2]);
    if (id == 0) {
      triangle(0, 0, wQ, 0, 0, hQ);
    } else if (id == 1) {
      triangle(0, 0, wQ, 0, wQ, hQ);
    } else if (id == 2) {
      triangle(wQ, 0, wQ, hQ, 0, hQ);
    } else {
      triangle(0, 0, wQ, hQ, 0, hQ);
    }

    popMatrix();
  }
}
