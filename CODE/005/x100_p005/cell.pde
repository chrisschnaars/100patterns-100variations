class Cell {

  float x, y;
  float wt, ht;

  Cell(float _x, float _y) {
    x = _x;
    y = _y;
    wt = cellW;
    ht = cellH;
  }

  void configure() {

    // GENERATE TWO RANDOM CORNERS OF EACH CELL
    // TO DRAW ARCS ACROSS
    int p1;
    int p2;

    // SIDES IDS 0 – 4 ARE REAL
    // SIDE ID -1 MEANS NO ARC IS DRAWN
    // CHANGE BOTTOM LIMIT TO 0 IF EACH CELL SHOULD GET 2 ARCS
    do {
      p1 = floor(random(-1, 4));
      p2 = floor(random(-1, 4));
    } while (p1 == p2);

    // GENERATE RANDOM COLOR ID
    int c1 = floor(random(0, colors.length));

    // DRAW CELL
    render(p1, p2, c1);
  }

  void render(int p1, int p2, int c1) {

    // DRAWING SETTINGS
    pushMatrix();

    // ORIENT AT CENTER
    translate(x, y);

    // GLOBAL CELL SETTINGS
    noFill();
    strokeWeight(8);

    // SET STROKE SHAPE COLOR
    stroke(colors[c1]);

    // X AND Y POSITIONS FOR EACH SIDE
    // CLOCKWISE FROM NE CORNER
    float[] xs = { wt, wt, 0, 0 };
    float[] ys = { 0, ht, ht, 0 };

    // START AND STOP POSITIONS FOR EACH SIDE
    // CLOCKWISE FROM NE CORNER
    int[] degStart = { 90, 180, 270, 0 };
    int[] degStop = { 180, 270, 360, 90 };

    // DRAW ARC 1
    if (p1 >= 0) {
      arc(xs[p1], ys[p1], wt, ht, radians(degStart[p1]), radians(degStop[p1]), OPEN);
    }

    // DRAW ARC 2
    if (p2 >= 0) {
      arc(xs[p2], ys[p2], wt, ht, radians(degStart[p2]), radians(degStop[p2]), OPEN);
    }

    // END DRAWING
    popMatrix();
  }

}
