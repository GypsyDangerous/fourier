void swap(complex[] c, int i, int j)
{
  complex temp = c[i];
  c[i] = c[j];
  c[j] =  temp;
}

void Sort(complex[] c)
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
