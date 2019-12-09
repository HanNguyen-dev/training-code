using System;
using MediaWorld.Domain.Interfaces;

namespace MediaWorld.Domain.Abstracts
{
  public abstract class AMedia : Object, IControl
  {
    public System.TimeSpan Duration { get; set; }
    public string Language { get; set; }
    public string Title { get; set; }
    public abstract bool Forward();
    public virtual bool Pause()
    {
      return true;
    }

    public virtual bool Play()
    {
      return true;
    }

    public abstract bool Rewind();

    public bool Stop()
    {
      return true;
    }

    public override string ToString()
    {
      return $"{this.Title}";
    }
  }

}