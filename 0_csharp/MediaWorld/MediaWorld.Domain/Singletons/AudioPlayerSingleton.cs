using MediaWorld.Domain.Abstracts;
using MediaWorld.Domain.Interfaces;
using System;

namespace MediaWorld.Domain.Singletons
{
  public class AudioPlayerSingleton : IPlayer
  {
    private static readonly AudioPlayerSingleton _instance = new AudioPlayerSingleton();

    private AudioPlayerSingleton() {}

    public static AudioPlayerSingleton Instance
    { get { return _instance; }
    }

    public void Execute(string command, AMedia media)
    {
      Console.WriteLine(media);
    }

    public bool Forward()
    {
      throw new NotImplementedException();
    }

    public bool Pause()
    {
      throw new NotImplementedException();
    }

    public bool Play()
    {
      throw new NotImplementedException();
    }

    public bool PowerDown()
    {
      throw new NotImplementedException();
    }

    public bool PowerUp()
    {
      throw new NotImplementedException();
    }

    public bool Rewind()
    {
      throw new NotImplementedException();
    }

    public bool Stop()
    {
      throw new NotImplementedException();
    }

    public bool VolumeDown()
    {
      throw new NotImplementedException();
    }

    public bool VolumeMute()
    {
      throw new NotImplementedException();
    }

    public bool VolumeUp()
    {
      throw new NotImplementedException();
    }
    // public void Play(Music m)
    // {
    //   System.Console.WriteLine(m);
    // }
  }
}