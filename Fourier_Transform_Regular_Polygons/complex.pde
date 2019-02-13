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
   float rea = re * other.re - im * other.im;
   float ima = re * other.im + im * other.re;
   return new complex(rea, ima);
  }
  
  complex add(complex other) 
  {
    return new complex(re + other.re, im + other.im);
  }
  
  float mag()
  {
   return sqrt(re * re + im * im); 
  }
  
  float magSquared()
  {
    return re * re + im * im; 
  }
  
  float heading()
  {
   return atan2(im, re); 
  }
  
  complex pow(int n) 
  {
    complex result = this;
    for (int i = 1; i < n; i++) 
    {
      result = result.mult(this);
    }
    return result;
  }
}
