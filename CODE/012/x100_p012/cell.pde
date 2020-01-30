class Cell {

  float x, y;
  float w, h;

  Cell(float _x, float _y) {
    x = _x;
    y = _y;
    w = cellW;
    h = cellH;
  }

  // CONFIGURE CELL
  void configure() {

    // GENERATE TRIANGLE APEX IDS
    float a1 = random(0, 1);
    float a2 = random(0, 1);
    float a3 = random(0, 1);
    float a4 = random(0, 1);

    // GENERATE COLOR ID FOR EACH
    // OPTION 1: COLOR FOR EACH CELL
    int c5 = floor(random(0, shapeColors.length));
    int c6, c7, c8;
    c6 = c7 = c8 = c5;

    // OPTION 2: COLOR FOR EACH TRIANGLE
    // int c5 = floor(random(0, shapeColors.length));
    // int c6 = floor(random(0, shapeColors.length));
    // int c7 = floor(random(0, shapeColors.length));
    // int c8 = floor(random(0, shapeColors.length));

    // CREATE SHAPE
    render(a1, a2, a3, a4, c5, c6, c7, c8);
  }

  // DRAW CELL
  void render(float a1, float a2, float a3, float a4, int c5, int c6, int c7, int c8) {

    // BEGIN DRAWING
    pushMatrix();

    // ORIENT AT TOP LEFT
    translate(x,y);

    // GLOBAL CELL SETTINGS
    noStroke();


    // BASE SPACER
    // DISTANCE BETWEEN CORNER AND TRIANGLE POINT ALONG BASE
    float s = 0.15;
    float v = random(0.15, 0.45);

    // COMMON BASE POINTS
    // USED DIFFERENTLY BETWEEN NORTH/SOUTH AND EAST/WEST
    float ps1 = w * s;
    float ps2 = w - (w * s);
    float ps3 = w * v;

    // NORTH TRIANGLE
    float xNorth = map(a1, 0, 1, ps1, ps2);
    fill(shapeColors[c5]);
    triangle(ps1, 0, ps2, 0, xNorth, ps3);

    // SOUTH TRIANGLE
    float xSouth = map(a3, 0, 1, ps1, ps2);
    fill(shapeColors[c6]);
    triangle(ps1, h, ps2, h, xSouth, h-ps3);

    // EAST TRIANGLE
    float yEast = map(a2, 0, 1, ps1, ps2);
    fill(shapeColors[c7]);
    triangle(w, ps1, w, ps2, w-ps3, yEast);

    // WEST TRIANGLE
    float yWest = map(a4, 0, 1, ps1, ps2);
    fill(shapeColors[c8]);
    triangle(0, ps1, 0, ps2, ps3, yWest);

    // END DRAWING
    popMatrix();
  }

}
