class complex
{
  
  float re, im, freq, amp, phase;
  
  complex(float a, float b)
  {
    re = a;
    im = b;
  }
  
  complex(float a, float b, float freq, float amp, float phase)
  {
    re = a;
    im = b;
    this.freq = freq;
    this.amp = amp;
    this.phase = phase;
  }
  
  complex mult(complex other)
  {
   float re = this.re * other.re - this.im * other.im;
   float im = this.re * other.im + this.im * other.re;
   return new complex(re, im);
  }
  
  void add(complex other)
  {
    this.re += other.re;
    this.im += other.im;
  }
}
