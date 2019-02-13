Complex[] dft(Complex[] x)
{
  int N = x.length;
  Complex[] X = new Complex[N];

  for (int k = 0; k < N; k++)
  {
    
    Complex sum = new Complex(0, 0);

    for (int n = 0; n < N; n++)
    {
      float phi = (TWO_PI * k * n) / N;
      Complex c = new Complex(cos(phi), -sin(phi));
      sum = sum.add(x[n].mult(c));
    }

    sum = sum.div(N);
    
    float freq = k;
    float amp = sum.mag();
    float phase = sum.heading();
    X[k] = new Complex(sum.re, sum.im, freq, amp, phase);
  }
  return X;
}
