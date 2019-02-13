complex[] dft(complex[] x)
{
  int N = x.length;
  complex[] X = new complex[N];

  for (int k = 0; k < N; k++)
  {
    complex sum = new complex(0, 0);

    for (int n = 0; n < N; n++)
    {
      float phi = (TWO_PI * k * n) / N;
      complex c = new complex(cos(phi), -sin(phi));
      sum = sum.add(x[n].mult(c));
    }

    sum.re /= N;
    sum.im /= N;
    
    float freq = k;
    float amp = sum.mag();
    float phase = sum.heading();
    X[k] = new complex(sum.re, sum.im, freq, amp, phase);
  }
  return X;
}
