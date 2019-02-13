float d;
float amplitude;
float prevn;
float time;
float rad;
float pointnum;
int points;
float polyrad;

int epicycles;

PVector pos;
PVector prev;
PVector point;

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
  point = new PVector();
  path = new ArrayList<PVector>();
  drawing = new ArrayList<PVector>();
  points = 6;
  polyrad = 400;
  pointnum = TWO_PI/points;
  for (float i = 0; i < TWO_PI; i += pointnum)
  {
    for (float j = 0; j < 50; j++)
    {
      point.x = polyrad * sin(i);
      point.y = polyrad * cos(i);
      drawing.add(point.copy());
    }
  }
  
  epicycles = drawing.size()-1;
  x = new complex[epicycles];
  for (int i = 0; i < epicycles; i += 1)
  {
    PVector point = drawing.get(i);
    complex c = new complex(point.x, point.y);
    x[i] = c;
  }
  Fourier = dft(x);

  Sort(Fourier);
}

void draw()
{
  background(51);
  stroke(255);
  noFill();
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

PVector showfourier(float x, float y, float rotation, complex[] fourier)
{
  pos.x = x;
  pos.y = y;
  rad = TWO_PI/fourier.length;

  for (int i = 0; i < fourier.length; i++)
  {
    prev.x = pos.x;
    prev.y = pos.y;

    frequency = fourier[i].freq;
    amplitude = fourier[i].amp;
    ph = fourier[i].phase;
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
