using System;
using MediaWorld.Domain.Abstracts;

namespace MediaWorld.Domain.Models
{

  public class Movie : AVideo
  {
    // public Movie()
    // {
    //   Title = "untitled";
    //   Duration = new System.TimeSpan();
    //   FrameRate = 24;
    // }

    public Movie(string title, TimeSpan duration, int frameRate)
    {
      // new Movie();
      Initialize(title, duration, frameRate);
    }
    private void Initialize(string title="Untitled", TimeSpan duration=new TimeSpan(), int frameRate=24) { // to ensure the all field has somethin rather than null or 0
      Title = title;
      Duration = duration;
      FrameRate = frameRate;
    }
  }
}