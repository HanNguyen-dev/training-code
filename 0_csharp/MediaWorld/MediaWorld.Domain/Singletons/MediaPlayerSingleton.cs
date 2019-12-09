using MediaWorld.Domain.Abstracts;
using MediaWorld.Domain.Interfaces;
using System;

namespace MediaWorld.Domain.Singletons
{
  public class MediaPlayerSingleton : IPlayer
  {
    private static readonly MediaPlayerSingleton _instance = new MediaPlayerSingleton();
    public delegate bool ButtonDelegate();


    private MediaPlayerSingleton() {}

    public static MediaPlayerSingleton Instance
    {
      get { return _instance; }
    }


    public void Execute(ButtonDelegate button) // is part of static
    {
      // System.Console.WriteLine(button());
      button();
    }

    // public void Execute(string command, AMedia media)
    // {
    //   Console.WriteLine(media);
    // }

    public bool VolumeUp()
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
    public bool PowerUp()
    {
      return true;
    }

    public bool PowerDown()
    {
      return true;
    }

    public bool Play()
    {
      throw new NotImplementedException();
    }

    public bool Pause()
    {
      throw new NotImplementedException();
    }

    public bool Forward()
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
  }
}