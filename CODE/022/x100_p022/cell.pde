class Cell {

  float x, y; // x and y position of cell
  float w, h; // width and height of cell
  int cId, rId, id; // column and row ids
  float xx;

  Cell(float _x, float _y, int _cId, int _rId, int _id) {
    x = _x;
    y = _y;
    w = cellW;
    h = cellH;
    cId = _cId;
    rId = _rId;
    id = _id;
    xx = 0;
  }

  // CONFIGURE CELL
  void configure() {

    // BACKGROUND COLOR CHANCER
    float b = random(0, 1);

    // NORTH AND SOUTH BORDER X POSITIONS
    float xN, xS;
    do {
      xN = random(0, 1);
      xS = random(0, 1);

      if (rId > 0) {
        Cell c = (Cell) cells.get(id - 1);
        xN = c.getX();
      }

      xx = xS;

    } while (abs(xN - xS) < 0.3);


    // xx = xS;



    // ORIENTATION
    // EAST OR WEST FACING
    int o = floor(random(0, 2));

    // LAYER ORDER
    // ELLIPSE OVER TRAP OR TRAP OVER ELLIPSE
    int l = floor(random(0, 2));

    // COLORS
    // 3 COLORS NOT THE SAME
    int c1, c2, c3;
    do {
      c1 = floor(random(0, shapeColors.length));
      c2 = floor(random(0, shapeColors.length));
      c3 = floor(random(0, shapeColors.length));
    } while (c1 == c2 || c2 == c3 || c1 == c3);

    // DRAW SHAPE
    render(b, xN, xS, o, l, c1, c2, c3);
  }

  // DRAW CELL
  void render(float b, float xN, float xS, int o, int l, int c1, int c2, int c3) {

    // BEGIN DRAWING
    pushMatrix();
    noStroke();

    // ORIENT AT TOP LEFT
    translate(x, y);

    // THRESHOLDS
    float t1 = 1.0;


    // BACKGROUND CELL BORDER
    // FOR DEBUGGING PURPOSES
    // noFill();
    // stroke(255);
    // rect(0, 0, w, h);


    /*
     BACKGROUND LAYER
    */

    // if (b < t1) {
    //   fill(shapeColors[c1]);
    //   rect(0, 0, w, h);
    // }


    /*
     SHAPE LAYERS
    */

    if (l == 0) {
      if (b <= 0.8) {
        drawEllipse(l, c2);
      }
      drawTrap(xN, xS, o, c3);
    } else {
      drawTrap(xN, xS, o, c3);
      if (b <= 0.8) {
        drawEllipse(l, c2);
      }
    }


    // END DRAWING
    popMatrix();
  }


  // DRAW ELLIPSE
  void drawEllipse(int l, int c2) {

    // SET ELLISPE SIZE
    float eW = w * 0.5;

    // STYLE SETTINGS
    float s = random(0, 1);
    strokeWeight(6);
    stroke(shapeColors[c2]);
    if (s < 0.5) {
      noFill();
    } else {
      fill(shapeColors[c2]);
    }

    // SET X POS
    float eO = 0.1;
    float p = random(0, 1);
    float eX = map(p, 0, 1, (w/2 - eO), (w/2 + eO));

    // DRAW ELLIPSE
    ellipse(w/2, h/2, eW, eW);
  }


  // DRAW TRAPEZOID
  void drawTrap(float xN, float xS, int o, int c3) {

    // DEFINE KNOWN TRAP POSITIONS
    float tX[] = { 0, w };
    float tY[] = { 0, 0 };
    float bX[] = { 0, w };
    float bY[] = { w, h };

    // SET UNDEFINED TRAP POSITIONS
    float offset = 0.15;
    float minX = w * offset;
    float maxX = w * (1 - offset);

    float x1 = map(xN, 0, 1, minX, maxX);
    float x2 = map(xS, 0, 1, minX, maxX);

    // // SET OBJECT VARIABLE
    // xx = x2;


    // DRAW SHAPE
    noStroke();
    fill(shapeColors[c3]);
    beginShape();
    vertex(tX[o], tY[o]);
    vertex(x1, 0);
    vertex(x2, h);
    vertex(bX[o], bY[o]);
    endShape(CLOSE);

  }

  // GET THE TRAPEZOID X POSITION OF ANOTHER CELL
  float getX() {
    return xx;
  }

}
