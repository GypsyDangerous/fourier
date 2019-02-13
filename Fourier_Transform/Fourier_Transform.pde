/*---------------------------------------------------------------------------------------------------------------------------------------//
This Code is based on the coding challenge 130.x by Dan Shiffman
Watch the videos at 
Part 1: https://youtu.be/MY4luNgGfms  
Part 2: https://youtu.be/n9nfTxp_APM  
Part 3: https://thecodingtrain.com/CodingChallenges/130.3-fourier-transform-drawing.html
This code is fundamentally very similat as the code in that challenge, but due to the limits of Processing
There are many differences in the syntax of the code. There is Currently no way to draw a path from an image, like the coding train logo.
I think it is possible to add this feature, but I don't know how.
//---------------------------------------------------------------------------------------------------------------------------------------*/



//The states for switching between user drawing and fourier drawing
int USER = 0;
int FOURIER = 1;
int state = -1;
int epicycles;

float diameter;
float amplitude;
float time;
float interval;
float frequency;
float phase;

PVector pos;
PVector prev;

ArrayList<PVector> path;
ArrayList<PVector> drawing;

Complex[] x;
Complex[] Fourier;

void setup()
{
  fullScreen();
  
  //initialize the PVectors
  pos = new PVector();
  prev = new PVector();

  //initialize the ArrayLists
  path = new ArrayList<PVector>();
  drawing = new ArrayList<PVector>();
}

void draw()
{
  background(51);
  stroke(255);
  noFill();
  if (state == USER)
  {
    PVector point = new PVector(mouseX-(width/2), mouseY-(height/2));
    drawing.add(point);

    beginShape();
    for (PVector p : drawing)
    {
      vertex(p.x + width/2, p.y + height/2);
    }
    endShape();
    
  } 
  else if (state == FOURIER)
  {
    PVector vertex = showfourier(width/2, height/2, 0, Fourier);
    
    path.add(vertex.copy());

    beginShape();
    for (int i = path.size()-1; i > 0; i--)
    {
      PVector p = path.get(i);
      vertex(p.x, p.y);
    }
    endShape();

    time += interval;

    if (time > TWO_PI)
    {
      time = 0;
      path.clear();
    }
  }
}

//shows the epicycles and the generates each point in the path drawn by them
PVector showfourier(float x, float y, float rotation, Complex[] fourier)
{
  pos.x = x;
  pos.y = y;
  interval = TWO_PI/fourier.length;

  for (int i = 0; i < fourier.length; i++)
  {
    prev.x = pos.x;
    prev.y = pos.y;

    Complex epicycle = fourier[i];

    frequency = epicycle.freq;
    amplitude = epicycle.amp;
    phase = epicycle.phase;
    diameter = amplitude*2;


    pos.x += amplitude * cos(frequency * time + phase + rotation);
    pos.y += amplitude * sin(frequency * time + phase + rotation); 
    noFill();
    stroke(255, 100);
    ellipse(prev.x, prev.y, diameter, diameter);
    stroke(255);
    line(prev.x, prev.y, pos.x, pos.y);
  }
  return new PVector(pos.x, pos.y);
}

//User controls to start and finish drawing
void mousePressed()
{
  state = USER; 
  drawing.clear();
  path.clear();
  time = 0;
}

void mouseReleased()
{
  state = FOURIER; 
  
  //the number of epicycles is the number of points in the drawing
  epicycles = drawing.size()-1;
  x = new Complex[epicycles];
  
  //Populate the x array with all the points in the drawing
  for (int i = 0; i < epicycles; i += 1)
  {
    PVector point = drawing.get(i);
    Complex c = new Complex(point.x, point.y);
    x[i] = c;
  }
  
  //perform discrete fourier transform on the x array and sort it by amplitude
  Fourier = dft(x);
  SortComplex(Fourier);
}

//selection sort algorithm for sorting epicycles by amplitude
void SortComplex(Complex[] c)
{
  int n = c.length;

  for (int i = 0; i < n-1; i++)
  {
    int mindex = i;

    for (int j = i+1; j < n; j++)
    {
      if (c[j].amp > c[mindex].amp)
        mindex = j;
    }
    swap(c, mindex, i);
  }
}

//simple algorithm to swap items in an array
void swap(Complex[] c, int i, int j)
{
  Complex temp = c[i];
  c[i] = c[j];
  c[j] =  temp;
}
