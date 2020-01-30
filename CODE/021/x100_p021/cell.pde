class Cell {

  float x, y;
  float w, h;
  int row, column;
  int l1, l2, l3;
  int[] lineIds;
  int ellipsePresence, ellipseStyle;
  int c1, c2;

  Cell(float _x, float _y, int _column, int _row) {
    x = _x;
    y = _y;
    w = cellW;
    h = cellH;
    row = _row;
    column = _column;
    l1 = 0;
    l2 = 0;
    l3 = 0;
    lineIds = new int[3];
    ellipsePresence = 0;
    ellipseStyle = 0;
    c1 = 0;
    c2 = 0;
  }

  // CONFIGURE CELL
  void configure() {
    // LINE SELECTION
    do {
      l1 = floor(random(0, 6));
      l2 = floor(random(0, 6));
      l3 = floor(random(0, 6));
    } while (l1 == l2 || l2 == l3 || l1 == l3);

    // CREATE LINE ID ARRAY
    lineIds[0] = l1;
    lineIds[1] = l2;
    lineIds[2] = l3;

    // SHAPE PRESENCE
    // OPTIONS: YES OR NO
    ellipsePresence = floor(random(0, 10));

    // ELLIPSE STYLE
    // OPTIONS: FILL OR STROKE
    ellipseStyle = floor(random(0, 2));

    // SHAPE COLOR DECIDERS
    // NEED TO BE DIFFERENT
    do {
      c1 = floor(random(0, shapeColors.length));
      c2 = floor(random(0, shapeColors.length));
    } while (c1 == c2);

  }

  // FUNCTION TO DRAW ELLIPSE
  void drawEllipse() {

    if (ellipsePresence > 6) {
      pushMatrix();
      translate(x, y);

      // GLOBAL ELLIPSE SCALES
      // float[] eScales = { 0.5, 1, 1.5 };
      float eScale = random(0.5, 2);

      // LINE POSITIONS
      float[] lX1 = { 0, w, w, 0, 0, w };
      float[] lY1 = { 0, 0, h, h, 0, 0 };
      float[] lX2 = { w, w, 0, 0, w, 0 };
      float[] lY2 = { 0, h, h, 0, h, h };

      // ELLIPSE VARIABLES
      float eX, eY, eD;
      boolean good;

      // PICK LINE FROM ARRAY TO DRAW ELLIPSE ON
      int l = floor(random(0, lineIds.length));
      int p = lineIds[l];
      eX = lX2[p];
      eY = lY2[p];

      // GENERATE RANDOM ELLIPSE SCALE
      int s = floor(random(0, 3));
      eD = w * eScale;

      // SET STYLE
      if (ellipseStyle == 0) {
        noStroke();
        fill(shapeColors[c2]);
      } else {
        noFill();
        int sk = round(random(8, 20));
        strokeWeight(sk);
        stroke(shapeColors[c2]);
      }

      // DRAW ELLIPSE
      ellipse(eX, eY, eD, eD);

      popMatrix();
    }
  }

  // DRAW EACH LINE
  void drawLines() {
    pushMatrix();

    translate(x, y);

    // LINE POSITIONS
    float[] lX1 = { 0, w, w, 0, 0, w };
    float[] lY1 = { 0, 0, h, h, 0, 0 };
    float[] lX2 = { w, w, 0, 0, w, 0 };
    float[] lY2 = { 0, h, h, 0, h, h };

    // LINE SETTINGS
    strokeWeight(4);
    stroke(shapeColors[c1]);
    noFill();

    // DRAW LINES
    for (int i=0; i < lineIds.length; i++) {
      int p = lineIds[i];
      line(lX1[p], lY1[p], lX2[p], lY2[p]);
    }

    popMatrix();
  }
}
