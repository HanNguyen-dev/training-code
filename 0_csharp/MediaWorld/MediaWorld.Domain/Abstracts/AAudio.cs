namespace MediaWorld.Domain.Abstracts
{
  public abstract class AAudio : AMedia
  {
    public int BitRate { get; set; }

    public override bool Forward()
    {
      return true;
    }
    public override bool Rewind()
    {
      return true;
    }

    public new bool Play()
    {
      return false;
    }
    public new bool Pause()
    {
      return false;
    }
    public new bool Stop()
    {
      return false;
    }
    public override string ToString()
    {
      return $"{Title} {Duration}\n BitRate: {BitRate}";
    }
  }
}