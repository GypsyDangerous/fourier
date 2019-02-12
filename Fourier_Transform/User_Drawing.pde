void mousePressed()
{
  state = USER; 
  drawing.clear();
  time = 0;
  path.clear();
}

void mouseReleased()
{
  state = FOURIER; 
  epicycles = drawing.size()-1;
  if (epicycles < 0)
  {
    drawing.add(new PVector(0,0));
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
