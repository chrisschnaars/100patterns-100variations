class Cell {

  float x, y;
  float wt, ht;

  Cell(float _x, float _y) {
    x = _x;
    y = _y;
    wt = cellW;
    ht = cellH;
  }

  // CONFIGURE CELL PROPERTIES
  void configure() {

    // GENERATE BACKGROUND SHAPE
    int bgshapeId = floor(random(0,8));

    // GENERATE CURVE SETTINGS
    int posId = floor(random(0,2));  // DIRECTION THE CURVE GOES IN
    int curveId = floor(random(0,2));  // WHETHER CONTROLS ARE ON X OR Y AXIS

    // GENERATE COLOR
    int c1 = floor(random(0, colors.length));  // BG SHAPE COLOR
    int c2 = floor(random(0, colors.length));  // BEZIER COLOR

    // CREATE SHAPE
    render(bgshapeId, posId, curveId, c1, c2);

  }

  // DRAW CELL
  void render(int bId, int pId, int cId, int c1, int c2) {

    // BEGIN DRAWING
    pushMatrix();

    // ORIENT AT TOP LEFT
    translate(x,y);

    // GLOBAL CELL SETTINGS
    noFill();
    rectMode(CENTER);
    strokeWeight(4);
    strokeCap(ROUND);

    // SET CONTROL POINT
    float ap = wt/2;  // WT AND HT SAME FOR EACH CURVE SINCE ITS IN A SQUARE
    float a = random(0, 0);
    float c = 1;
    if (pId == 1) {
      c = -1;
    }

    // CURVE X AND Y COORDINATES
    float[] xStarts = { 0, 0 };
    float[] yStarts = { 0, ht };
    float[] xStops = { wt, wt };
    float[] yStops = { ht, 0 };

    // x and y coordinate variables
    float x1, y1, cx1, cy1, cx2, cy2, x2, y2;

    // SET X AND Y COORDINATES
    x1 = xStarts[pId];
    y1 = yStarts[pId];
    x2 = xStops[pId];
    y2 = yStops[pId];

    // SET CONTROL POINTS
    cx1 = 0;
    cy1 = ap+(c*a);
    cx2 = wt;
    cy2 = ap+(-c*a);

    if (cId == 0) {
      cx1 = ap+(c*a);
      cy1 = 0;
      cx2 = ap+(-c*a);
      cy2 = ht;

      if (pId == 1) {
        cx1 = ap+(c*a);
        cy1 = ht;
        cx2 = ap+(-c*a);
        cy2 = 0;
      }
    }

    // DRAW BACKGROUND SHAPE
    stroke(colors[c1]);
    float bgShapeScale = 1;

    float l = wt * bgShapeScale;
    float l2 = wt * bgShapeScale * (1/3);

    if (bId == 0) {
      ellipse(wt/2, ht/2, l, l);
    } else if (bId > 0 && bId < 3) {
      if (bId == 1) {
        rect(wt/2, ht/2, l, l/2);
      }
      if (bId == 2) {
        rect(wt/2, ht/2, l/2, l);
      }
    } else {
      if (bId >= 3 && bId < 7) {
        // NORTH POINTING TRIANGLE
        if (bId == 3) {
          beginShape();
          vertex(wt/2, l2);
          vertex(l, l);
          vertex(l2, l);
          endShape(CLOSE);
        }
        // EAST POINTING TRIANGLE
        if (bId == 4) {
          beginShape();
          vertex(l2, l2);
          vertex(l, ht/2);
          vertex(l2, l);
          endShape(CLOSE);
        }
        // SOUTH POINTING TRIANGLE
        if (bId == 5) {
          beginShape();
          vertex(l2, l2);
          vertex(l, l2);
          vertex(wt/2, l);
          endShape(CLOSE);
        }
        // WEST POINTING TRIANGLE
        if (bId == 6) {
          beginShape();
          vertex(l2, ht/2);
          vertex(l, l2);
          vertex(l, l);
          endShape(CLOSE);
        }
      }
    }

    // DRAW CURVE
    stroke(colors[c2]);
    bezier(x1, y1, cx1, cy1, cx2, cy2, x2, y2);
    //println(x1, y1, cx1, cy1, cx2, cy2, x2, y2);

    // END DRAWING
    popMatrix();
  }

}
