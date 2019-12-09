using MediaWorld.Domain.Abstracts;
using MediaWorld.Domain.Interfaces;
using System;

namespace MediaWorld.Domain.Singletons
{
  public class VideoPlayerSingleton : IPlayer
  {
    private static readonly VideoPlayerSingleton _instance = new VideoPlayerSingleton();

    private VideoPlayerSingleton() {}

    public static VideoPlayerSingleton Instance
    { get { return _instance; }
    }

    public void Execute(string command, AMedia media)
    {
      Console.WriteLine(media);
    }

    public bool Forward()
    {
      return true;
    }

    public bool Pause()
    {
      return true;
    }

    public bool Play()
    {
      return true;
    }

    public bool PowerDown()
    {
      return true;
    }

    public bool PowerUp()
    {
      return true;
    }

    public bool Rewind()
    {
      return true;
    }

    public bool Stop()
    {
      return true;
    }

    public bool VolumeDown()
    {
      return true;
    }

    public bool VolumeMute()
    {
      return true;
    }

    public bool VolumeUp()
    {
      return true;
    }
    // public void Play(Music m)
    // {
    //   System.Console.WriteLine(m);
    // }
  }
}