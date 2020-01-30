class Cell {

  float x, y; // x and y position of cell
  float w, h; // width and height of cell
  int id, cId, rId; // column and row ids
  int lP;

  Cell(float _x, float _y, int _id, int _cId, int _rId) {
    x = _x;
    y = _y;
    w = cellW;
    h = cellH;
    id = _id;
    cId = _cId;
    rId = _rId;
    lP = 0; // BIG ARC LINE POSITION ID
  }

  // CONFIGURE CELL
  void configure() {

    // CHOOSE ORIENTATION OF SMALLER ARCS
    int o1 = floor(random(0, 4));

    // CHOOSE ORIENTATION OF LARGER ARCS
    // CORNERS: NW, NE, SE, SW

    // CREATE ARRAY OF ARC ORIENTATIONS
    int o2 = floor(random(0, 4));
    //
    // int[] pos = { };
    //
    // // SET BOOLEANS TO TEST IF CELL HAS VALID NEIGHBORS
    // boolean leftNeighbor = false;
    // boolean topNeighbor = false;
    //
    // // ADD TO ARRAY BASED ON NEIGHBOR VALUES
    // if (rId > 0 || cId > 0) {
    //
    //   // TOP NEIGHTOR
    //   if (rId > 0) {
    //     // GET TOP NEIGHBOR CELL'S LINE POS
    //     Cell c = (Cell) cells.get(id - 1);
    //     int p = c.getP();
    //
    //     // APPEND ARRAY BASED ON NEIGHBOR VALUE
    //     if (p == 2 || p == 3) {
    //       pos = append(pos, 0);
    //       pos = append(pos, 1);
    //       leftNeighbor = true;
    //     }
    //   }
    //
    //   // LEFT NEIGHBOR
    //   if (cId > 0) {
    //     // GET LEFT NEIGHBOR CELL'S LINE POS
    //     Cell c = (Cell) cells.get(id - 10);
    //     int p = c.getP();
    //
    //     // APPEND ARRAY BASED ON NEIGHBOR VALUE
    //     if (p == 1 || p == 2) {
    //       pos = append(pos, 3);
    //       if (!leftNeighbor) {
    //         pos = append(pos, 0);
    //       }
    //       topNeighbor = true;
    //     }
    //   }
    // }
    //
    // // CREATE FULL ARRAY
    // if ((rId == 0 && cId == 0) || (!leftNeighbor && !topNeighbor)) {
    //   for (int i = 0; i < 4; i++) {
    //     pos = append(pos, i);
    //   }
    // }
    //
    // // SELECT BIG ARC POSITION
    // int selector = floor(random(0, pos.length));
    // int o2 = pos[selector];
    // lP = o2; // SET OBJECT VARIABLE

    // CHOOSE TWO DIFFERENT COLORS
    int c1, c2;
    do {
      c1 = floor(random(0, shapeColors.length));
      c2 = floor(random(0, shapeColors.length));
    } while (c1 == c2);

    // DRAW SHAPE
    render(o1, o2, c1, c2);

  }

  // DRAW CELL
  void render(int o1, int o2, int c1, int c2) {

    // BEGIN DRAWING
    pushMatrix();

    // ORIENT AT CENTER
    translate(x + w/2, y + h/2);

    // SKETCH SETTINGS;
    boolean drawBG = false;
    strokeWeight(6);

    // BACKGROUND CELL BORDER
    // FOR DEBUGGING PURPOSES
    if (drawBG) {
      noFill();
      stroke(255);
      rect(-w/2, -h/2, w, h);
    }

    /*
      ARCS
    */

    drawDoubleArcs(o1, c1, 0);
    drawDoubleArcs(o1, c1, 2);
    drawBigArc(o2, c2);
    drawDoubleArcs(o1, c1, 1);

    // END DRAWING
    popMatrix();
  }

  // DRAW DOUBLE ARCS
  void drawDoubleArcs(int o, int c, int index) {

    // ARC DISPLAY VARIABLES
    float arcD[] = { 0.5, 0.75, 1 };
    float arcX[] = { 0, w/2, 0, -w/2 };
    float arcY[] = { -h/2, 0, h/2, 0 };
    float arcStart[] = { 0, 90, 180, 270 };

    // CONVERT START AND STOP ANGLES TO RADIANS
    float d1 = radians(arcStart[o]);
    float d2 = radians(arcStart[o] + 180);

    // SET STYLE
    noFill();
    stroke(shapeColors[c]);

    float aD = arcD[index] * w;
    arc(arcX[o], arcY[o], aD, aD, d1, d2);
    //
    // for (int i = 0; i < arcD.length; i++) {
    //
    //   float aD = arcD[i] * w;
    //
    //   arc(arcX[o], arcY[o], aD, aD, d1, d2);
    // }
  }

  void drawBigArc(int o, int c) {
    pushMatrix();
    // ARC DISPLAY VARIABLES
    float d[] = { 1 };
    float arcX[] = { -w/2, w/2, w/2, -w/2 };
    float arcY[] = { -h/2, -h/2, h/2, h/2 };
    float arcStart[] = { 0, 90, 180, 270 };

    // CONVERT START AND STOP ANGLES TO RADIANS
    float d1 = radians(arcStart[o]);
    float d2 = radians(arcStart[o] + 90);

    // SET STYLE
    noFill();
    stroke(shapeColors[c]);

    // DRAW ARC
    for (int i = 0; i < d.length; i++) {
      arc(arcX[o], arcY[o], w*d[i], h*d[i], d1, d2);
      rotate(radians(180));
      arc(arcX[o], arcY[o], w*d[i], h*d[i], d1, d2);
    }

    popMatrix();
  }

  // GET THE TRAPEZOID X POSITION OF ANOTHER CELL
  int getP() {
    return lP;
  }
}
