complex[] dft(float[] x)
{
  int N = x.length;
  complex[] X = new complex[N];

  for (int k = 0; k < N; k++)
  {
    PVector c = new PVector();

    for (int n = 0; n < N; n++)
    {
      float phi = (TWO_PI * k * n) / N;
      c.x +=  x[n] * cos(phi);
      c.y -=  x[n] * sin(phi);
    }

    c.x /= N;
    c.y /= N;
    
    float freq = k;
    float amp = c.mag();
    float phase = c.heading();
    X[k] = new complex(c.x, c.y, freq, amp, phase);
  }
  return X;
}
