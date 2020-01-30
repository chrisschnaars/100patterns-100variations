class Cell {

  float x, y;
  float wt, ht;

  Cell(float _x, float _y) {
    x = _x;
    y = _y;
    wt = cellW;
    ht = cellH;
  }

  // CONFIGURE CELL SETTINGS
  void configure() {

    // GENERATE SHAPE ID FOR EACH QUADRANT
    // BLANK, ARC, ELLIPSE
    int nw = floor(random(0, 3)); // NW quad
    int ne = floor(random(0, 3)); // NE quad
    int se = floor(random(0, 3)); // SW quad
    int sw = floor(random(0, 3)); // SE quad

    // DETERMINE STYLE ID
    // FILL OR ELLIPSE
    int c1 = floor(random(0, 2));

    // DETERMINE COLOR
    int c2 = floor(random(0, colors.length));

    // CREATE CELL
    render(ne, nw, sw, se, c1, c2);
  }

  // DRAW CELL
  void render(int nw, int ne, int se, int sw, int c1, int c2) {

    // START DRAWING
    pushMatrix();

    // ORIENT AT CENTER
    translate(x+wt/2, y+ht/2);

    // GLOBAL CELL SETTINGS
    strokeWeight(4);

    // SET FILL OR STROKE SETTING
    if (c1 == 0) {
      stroke(colors[c2]);
      fill(colors[c2]);
    } else {
      stroke(colors[c2]);
      noFill();
    }

    // ARC SETTINGS
    float wC = 0.75;
    float lA = wt * wC;

    // ELLIPSE SETTINGS
    float eD = wt * 0.125;
    float eX = wt/4;
    float eY = wt/4;

    // NW POSITION
    if (nw == 1) {
      arc(0, 0, wt, ht, radians(180), radians(270), PIE);
    } else if (nw == 2) {
      ellipse(-eX, -eY, eD, eD);
    }

    // NE POSITION
    if (ne == 1) {
      arc(0, 0, wt, ht, radians(270), radians(360), PIE);
    } else if (ne == 2) {
      ellipse(eX, -eY, eD, eD);
    }

    // SE POSITION
    if (se == 1) {
      arc(0, 0, wt, ht, radians(0), radians(90), PIE);
    } else if (se == 2) {
      ellipse(eX, eY, eD, eD);
    }

    // SW POSITION
    if (sw == 1) {
      arc(0, 0, wt, ht, radians(90), radians(180), PIE);
    } else if (sw == 2) {
      ellipse(-eX, eY, eD, eD);
    }

    // END DRAWING
    popMatrix();

  }

}
