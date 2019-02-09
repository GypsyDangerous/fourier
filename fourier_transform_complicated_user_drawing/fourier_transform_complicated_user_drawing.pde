float d;
float r;
float prevn;
float time;
float rad;

int epicycles;

PVector pos;
PVector prev;

ArrayList<PVector> path;

float frequency;
float ph;

float[] y;
float[] x;
complex[] FourierY;
complex[] FourierX;
void setup()
{
  size(800, 480);
  //fullScreen();
  background(0);
  epicycles = 100;
  y = new float[epicycles];
  x = new float[epicycles];
  for (int i = 0; i < epicycles; i++)
  {
    float angle = map(i, 0, epicycles, 0, TWO_PI);
    y[i] = 100*cos(angle);
    x[i] = 100*sin(angle);
  }
  
  FourierY = dft(y);
  FourierX = dft(x);

FourierX = sort(FourierX);

  rad = TWO_PI/FourierY.length;
  pos = new PVector();
  prev = new PVector();
  path = new ArrayList<PVector>();
  background(51);
}

void draw()
{
  //frameRate(15);
  background(51);
  //translate(width/4, height/2);
  stroke(255);

  PVector vx = showfourier(width/2 - 50, 100, 0, FourierX);
  PVector vy = showfourier(100, height/2 + 50, HALF_PI, FourierY);
  PVector v = new PVector(vx.x, vy.y);

  noFill();

  path.add(v);


  line(vx.x, vx.y, v.x, v.y);
  line(vy.x, vy.y, v.x, v.y);

  beginShape();
  for (int i = path.size()-1; i > 0; i--)
  {
    PVector p = path.get(i);
    vertex(p.x, p.y);
  }
  endShape();
  time += rad;
  if(time > TWO_PI)
  {
    time = 0;
    path.clear();
  }
}

PVector showfourier(float x, float y, float rotation, complex[] Fourier)
{
  pos.x = x;
  pos.y = y;
  for (int i = 0; i < Fourier.length; i++)
  {
    prev.x = pos.x;
    prev.y = pos.y;

    frequency = Fourier[i].freq;
    r = Fourier[i].amp;
    ph = Fourier[i].phase;
    d = r*2;


    pos.x += r * cos(frequency * time + ph + rotation);
    pos.y += r * sin(frequency * time + ph + rotation); 
    noFill();
    stroke(255, 100);
    ellipse(prev.x, prev.y, d, d);
    stroke(255);
    line(prev.x, prev.y, pos.x, pos.y);
  }
  return new PVector(pos.x, pos.y);
}
