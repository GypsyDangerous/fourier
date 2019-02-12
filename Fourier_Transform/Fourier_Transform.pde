int USER = 0;
int FOURIER = 1;

float d;
float amplitude;
float prevn;
float time;
float rad;
int skip;

int epicycles;
int state = -1;

PVector pos;
PVector prev;

ArrayList<PVector> path;

float frequency;
float ph;

complex[] x;
ArrayList<PVector> drawing;
complex[] Fourier;

void setup()
{
  fullScreen();
  background(0);
  pos = new PVector();
  prev = new PVector();
  path = new ArrayList<PVector>();
  drawing = new ArrayList<PVector>();
  background(51);
}

void draw()
{
  background(51);
  stroke(255);
  noFill();
  if (state == USER && (mouseX != pmouseX) && (mouseY != pmouseY))
  {
    PVector point = new PVector(mouseX-(width/2), mouseY-(height/2));
    drawing.add(point);
    beginShape();
    for (PVector p : drawing)
      vertex(p.x + width/2, p.y + height/2);
    endShape();
  } else if (state == FOURIER)
  {
    PVector vector = showfourier(width/2, height/2, 0, Fourier);
    path.add(vector);

    beginShape();
    for (int i = path.size()-1; i > 0; i--)
    {
      PVector p = path.get(i);
      vertex(p.x, p.y);
    }
    endShape();
    time += rad;
    if (time > TWO_PI)
    {
      time = 0;
      path.clear();
    }
  }
}



PVector showfourier(float x, float y, float rotation, complex[] Fourier)
{
  pos.x = x;
  pos.y = y;
  rad = TWO_PI/Fourier.length;

  for (int i = 0; i < Fourier.length; i++)
  {
    prev.x = pos.x;
    prev.y = pos.y;

    frequency = Fourier[i].freq;
    amplitude = Fourier[i].amp;
    ph = Fourier[i].phase;
    d = amplitude*2;


    pos.x += amplitude * cos(frequency * time + ph + rotation);
    pos.y += amplitude * sin(frequency * time + ph + rotation); 
    noFill();
    stroke(255, 100);
    ellipse(prev.x, prev.y, d, d);
    stroke(255);
    line(prev.x, prev.y, pos.x, pos.y);
  }
  return new PVector(pos.x, pos.y);
}
