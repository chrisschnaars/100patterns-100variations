class Cell {

  float x, y;
  float w, h;

  Cell(float _x, float _y) {
    x = _x;
    y = _y;
    w = cellW;
    h = cellH;
  }

  void configure() {

    // GENERATE SHAPE ID
    // OPTION: RECTANGLE, ELLIPSE, TRIANGLE
    int c1 = floor(random(0, 3));

    // GENERATE MULTIPLIER FOR SCALE OF INNER SHAPE
    int c2 = floor(random(0, 4));

    // GENERATE COLOR ID
    int c3 = floor(random(0, shapeColors.length));

    // CREATE SHAPE
    render(c1, c2, c3);
  }

  // DRAW SHAPE
  void render(int c1, int c2, int c3) {

    // START DRAWING
    pushMatrix();

    // GLOBAL DRAWING SETTINGS
    noStroke();

    // TRANSLATE TO CELL CENTER
    translate(x + w/2, y + h/2);

    // SET SCALE OF INNER SHAPE
    float insetScale = 0.28; // scale multiplier
    float s = insetScale * c2;

    // RECTANGLE
    if (c1 == 0) {
      rectMode(CENTER);
      // outer
      fill(shapeColors[c3]);
      rect(0, 0, w, h);
      // inner
      fill(bgColor);
      scale(s);
      rect(0, 0, w, h);
    }

    // ELLIPSE
    if (c1 == 1) {
      // outer
      fill(shapeColors[c3]);
      ellipse(0, 0, w, h);
      // inner
      fill(bgColor);
      scale(s);
      ellipse(0, 0, w, h);
    }

    // TRIANGLES
    if (c1 == 2) {

      // RANDOMLY DETERMINE ORIENTATINO OF TRIANGLE
      // NW CORNER, NE CORNER, SE CORNER, SW CORNER
      int tC = floor(random(0, 4));

      // OUTER TRIANGLE SIZERS
      float tW = w/2;
      float tH = h/2;

      // INNER TRIANGLE SIZERS
      float iW = tW * (1 - insetScale);
      float iH = tH * (1 - insetScale);

      // DRAW OUTER TRIANGLE
      pushMatrix();
      fill(shapeColors[c3]);
      rotate(radians(tC * 90));
      triangle(-tW, -tH, tW, -tH, -tW, tH);
      popMatrix();

      // DRAW INNER TRIANGLE
      if (c2 == 1) {
        fill(bgColor);
        if (tC == 0) {
          triangle(-iW, -iH, iW/2, -iH, -iW, iH/2);
        } else if (tC == 1) {
          triangle(-iW/2, -iH, iW, -iH, iW, iH/2);
        } else if (tC == 2) {
          triangle(iW, -iH/2, iW, iH, -iW/2, iH);
        } else {
          triangle(-iW, -iH/2, iW/2, iH, -iW, iH);
        }
      }
    }

    // END DRAWING
    popMatrix();
  }

}
